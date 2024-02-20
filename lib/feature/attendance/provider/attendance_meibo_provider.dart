import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_stamp_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_status_model.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_meibo_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

final attendanceMeiboListProvider = 
    StateNotifierProvider<AttendanceMeiboListProvider, ApiState>((ref) {

  final filter = ref.watch(filterProvider);

  return AttendanceMeiboListProvider(ref, filter);
});

// 選択された生徒情報
final attendanceMeiboProvider = StateProvider<AttendanceMeiboModel>(
  (ref) => const AttendanceMeiboModel(),
);

// 出欠（日）
class AttendanceMeiboListProvider extends StateNotifier<ApiState> {
  AttendanceMeiboListProvider(this.ref, this.filter) 
  : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  final FilterModel filter;
  late final _repository = ref.read(attendanceMeiboRepositoryProvider);

  Future<void> _init() async { 
    await fetch(); 
  }

  Future<void> fetch() async {

    // 初期化完成しない場合、終了する
    if (filter.classId == null ||
        filter.classId == 0 ||
        filter.targetDate == null) {
      state = const ApiState.loaded();
      return;
    }

    // 最大３日間の登校日を取得する。
    final tokobis = getFilteredTokobiDates(
      filter.targetDate ?? DateTime.now(),
      ref.read(filterProvider).classId ?? 0, 
    );

    // 非同期処理で最大３日間の生徒情報を取得する。
    final responses = await Future.wait(
      List.generate(tokobis.length, (index) {
        try {
          return _repository.fetch(filter, index, tokobis[index]);
        } catch (e) {
          return Future.value(
            APIError<String>(
              AppException.errorWithMessage(e.toString()),
            ),
          );
        }
      }),
    );

    // エラー、ローディングの場合、エラーを表示する。
    var isError = false;
    var isLoading = false;
    var errorMessage = '';
    for (final response in responses) {
      if (response is ApiState) {
        response.when(
          error: (e) {
            isError = true;
            errorMessage = '$errorMessage {e};';
          },
          loading: () {
            isLoading = true;
          },
          loaded: () {},
        );
      }
    }

    if (isError || isLoading) {
      state = const ApiState.error(
        AppException.errorWithMessage('Error occurred'),
      );
      return;
    }

    // 正常終了
    if (mounted) {
      state = const ApiState.loaded();
    }

  }

  Future<void> save() async {
    state = await _repository.save(filter);
  }

  // set stamp by Id
  Future<void> updateById(
    AttendanceMeiboModel meibo, 
    AttendanceStampModel stamp,
    AttendanceReasonModel reason1, 
    AttendanceReasonModel reason2,
  ) async {

    if (stamp.shukketsuJokyoCd == '001') return;

    // set all.
    if (stamp.shukketsuBunrui == '50' || stamp.shukketsuBunrui == '60') {
      var meibos = Boxes.getAttendanceMeibo().values.toList();

      // 学年毎
      if (meibos.isNotEmpty){
        meibos = meibos.where((e) => e.gakunen == meibo.gakunen).toList();
      } 

      for (final m in meibos) {
        await updateBox(m, stamp, reason1, reason2);
      }
      return;
    }

    //clear all and set one
    if (meibo.jokyoList![0].shukketsuBunrui == '50' || 
        meibo.jokyoList![0].shukketsuBunrui == '60'
    ) {
      var meibos = Boxes.getAttendanceMeibo().values.toList();
      const s = AttendanceStampModel(
        shukketsuJokyoCd: '999', 
        shukketsuBunrui: '', 
        shukketsuKbn: '',
      );

      // 学年毎
      if (meibos.isNotEmpty) {
        meibos = meibos.where((e) => e.gakunen == meibo.gakunen).toList();
      } 

      for (final m in meibos) {
        if (m.studentKihonId == meibo.studentKihonId) {
          await updateBox(meibo, stamp, reason1, reason2);
        } else {
          await updateBox(
            m, 
            s, 
            const AttendanceReasonModel(), 
            const AttendanceReasonModel(),
          );
        }
      }
      return;
    }
    // set one
    await updateBox(meibo, stamp, reason1, reason2);
  }


  // 未設定の場合、すべての生徒を健康にする
  Future<void> updateByBlank() async {
    final meibos = Boxes.getAttendanceMeibo().values.toList();
    
    if (meibos.isEmpty) return;

    final stamp = Boxes.getRegistAttendanceStamp().get('100');

    for (final m in meibos) {
      final jokyo = m.jokyoList?[0]; 

      if ((jokyo == null || 
          jokyo.shukketsuBunrui!.isEmpty) &&
          jokyo?.isEditable == true
      ) {
        await updateBox(
          m, 
          stamp!, 
          const AttendanceReasonModel(), 
          const AttendanceReasonModel(),
        );
      }
    }
  }

  Future<void> updateBox(
    AttendanceMeiboModel meibo,
    AttendanceStampModel stamp,
    AttendanceReasonModel reason1,
    AttendanceReasonModel reason2,
  ) async {
    final status = stamp.shukketsuJokyoCd == '999'
        ? const AttendanceStatusModel(
            shukketsuBunrui: '',
            shukketsuKbn: '',
            ryaku: '',
            jiyu1: '',
            jiyu2: '',
            isEditable: true,
          )
        : AttendanceStatusModel(
            shukketsuBunrui: stamp.shukketsuBunrui,
            shukketsuKbn: stamp.shukketsuKbn,
            ryaku: stamp.shukketsuJokyoNmRyaku,
            jiyu1: reason1.shukketsuJiyuNmSeishiki ?? '',
            jiyu2: reason2.shukketsuJiyuNmSeishiki ?? '',
            isEditable: true,
          );
    final newMeibo = AttendanceMeiboModel(
      studentKihonId: meibo.studentKihonId,
      studentSeq: meibo.studentSeq,
      gakunen: meibo.gakunen,
      className: meibo.className,
      studentNumber: meibo.studentNumber,
      photoImageFlg: meibo.photoImageFlg,
      name: meibo.name,
      genderCode: meibo.genderCode,
      photoUrl: meibo.photoUrl,
      tenshutsuYoteiFlg: meibo.tenshutsuYoteiFlg,
      tenshutsuSumiFlg: meibo.tenshutsuSumiFlg,
      jokyoList: [status],
    );

    final box = Boxes.getAttendanceMeibo();
    final index = box.keys.firstWhere(
          (k) => box.getAt(k as int)?.studentKihonId == newMeibo.studentKihonId,
        );

    await Boxes.getAttendanceMeibo().put(index, newMeibo);
  }

  // Future<void> getPhoto() async {
  //   state = await _repository.save(filter);
  // }

}
