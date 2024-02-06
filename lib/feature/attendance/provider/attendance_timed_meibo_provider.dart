import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_stamp_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_status_model.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_timed_meibo_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

final attendanceTimedMeiboListProvider = 
    StateNotifierProvider<AttendanceTimedMeiboListProvider, ApiState>((ref) {
  
  final filter = ref.watch(filterProvider);

  return AttendanceTimedMeiboListProvider(ref, filter);
});

// 選択された生徒情報
final attendanceTimedMeiboProvider = StateProvider<AttendanceTimedMeiboModel>(
  (ref) => const AttendanceTimedMeiboModel(),
);

// 出欠（時）
class AttendanceTimedMeiboListProvider extends StateNotifier<ApiState> {
  AttendanceTimedMeiboListProvider(this.ref, this.filter)
  : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  final FilterModel filter;
  late final _rep = ref.read(timedMeiboRepositoryProvider);

  Future<void> _init() async { 
    await _fetch(); 
  }

  Future<void> _fetch() async {

    // 初期化完成しない場合、終了する
    if (filter.classId == null ||
        filter.classId == 0 ||
        filter.jigenIdx == null ||
        filter.targetDate == null) {
      state = const ApiState.loaded();
      return;
    }

    final response = await _rep.fetch(
      filter, 
      filter.targetDate ?? DateTime.now(),
    );

    // 正常終了
    if (mounted) {
      state = response;
    }

  }

  Future<void> save() async {
    state = await _rep.save(filter);
  }

  // set stamp by Id
  Future<void> updateById(
    AttendanceTimedMeiboModel meibo,
    AttendanceStampModel stamp,
    FilterModel filter,
    AttendanceReasonModel reason1,
    AttendanceReasonModel reason2,
  ) async {
    
    if (stamp.shukketsuJokyoCd == '001') return;

    // set all.
    if (stamp.shukketsuBunrui == '50' || stamp.shukketsuBunrui == '60') {
      var meibos = Boxes.getAttendanceTimedMeibo().values.toList();

      // 学年毎
      if (meibos.isNotEmpty) {
        meibos = meibos.where((e) => e.gakunen == meibo.gakunen).toList();
      } 


      for (final m in meibos) {
        await updateBox(m, stamp, filter, reason1, reason2);
      }
      return;
    }

    //clear all and set one
    if (meibo.jokyoList![0].shukketsuBunrui == '50' ||
        meibo.jokyoList![0].shukketsuBunrui == '60'
    ) {

      var meibos = Boxes.getAttendanceTimedMeibo().values.toList();
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
          await updateBox(meibo, stamp, filter, reason1, reason2);
        } else {
          await updateBox(
            m, 
            s, 
            filter, 
            const AttendanceReasonModel(), 
            const AttendanceReasonModel(),
          );
        }
      }
      return;
    }
    // set one
    await updateBox(meibo, stamp, filter,reason1, reason2);
  }


  // 未設定の場合、すべての生徒を健康にする
  Future<void> updateByBlank() async {
    final filter = ref.read(filterProvider);
    final meibos = Boxes.getAttendanceTimedMeibo().values.toList();

    if (meibos.isEmpty) return;

    final stamp = Boxes.getRegistAttendanceStamp().get('100');

    for (final m in meibos) {
      
      // 編集可否フラグの取得
      var jokyo = m.jokyoList![0];
      try {
        jokyo = m.jokyoList!
            .where(
              (e) => e.jigenIdx == filter.jigenIdx,
            )
            .toList()
            .first;
      } catch (ex) {
        //
      }

      // 保護されない場合、編集可能
      final isEditable = jokyo.isEditable == true ? true : false;
      if (isEditable && jokyo.shukketsuBunrui!.isEmpty) {
        await updateBox(
            m, 
            stamp!, 
            filter, 
            const AttendanceReasonModel(), 
            const AttendanceReasonModel(),
        );
      }
    }
  }

  Future<void> updateBox(
    AttendanceTimedMeiboModel meibo,
    AttendanceStampModel stamp,
    FilterModel filter,
    AttendanceReasonModel reason1,
    AttendanceReasonModel reason2,
  ) async {
    final status = stamp.shukketsuJokyoCd == '999'
        ? AttendanceTimedStatusModel(
            jigenIdx: filter.jigenIdx,
            shukketsuBunrui: '',
            shukketsuKbn: '',
            ryaku: '',
            jiyu1: '',
            jiyu2: '',
            isEditable: true,
          )
        : AttendanceTimedStatusModel(
            jigenIdx: filter.jigenIdx,
            shukketsuBunrui: stamp.shukketsuBunrui,
            shukketsuKbn: stamp.shukketsuKbn,
            ryaku: stamp.shukketsuJokyoNmRyaku,
            jiyu1: reason1.shukketsuJiyuNmSeishiki ?? '',
            jiyu2: reason2.shukketsuJiyuNmSeishiki ?? '',
            isEditable: true,
          );

    final newMeibo = AttendanceTimedMeiboModel(
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

    final box = Boxes.getAttendanceTimedMeibo();
    final index = box.keys.firstWhere(
        (k) => box.getAt(k as int)?.studentKihonId == newMeibo.studentKihonId,
      );

    await box.put(index, newMeibo);
  }

}
