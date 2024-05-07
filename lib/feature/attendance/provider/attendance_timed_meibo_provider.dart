import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_stamp_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_status_model.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_timed_meibo_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/model/kamoku_model.dart';
import 'package:kyoumutechou/feature/common/model/tanto_kyoin_model.dart';
import 'package:kyoumutechou/feature/common/model/teacher_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/kamokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/teachers_provider.dart';
import 'package:kyoumutechou/feature/common/repository/kamokus_repository.dart';
import 'package:kyoumutechou/feature/common/repository/tanto_kyoin_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

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
  late final _kmRep = ref.read(kamokusRepositoryProvider);
  late final _tkRep = ref.read(tantoKyoinsRepositoryProvider);



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

    final responses = await Future.wait([
      _kmRep.fetch(filter.dantaiId ?? 0, filter.gakunenCode ?? ''),
      _tkRep.fetch(filter.classId!, filter.targetDate ?? DateTime.now()),
      _rep.fetch(filter, filter.targetDate ?? DateTime.now()),
    ]);

    // エラー、ローディングの場合、エラーを表示する。
    var isError = false;
    var isLoading = false;
    var errorMessage = '';
    for (final response in responses) {
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

    if (isError || isLoading) {
      state = const ApiState.error(
        AppException.errorWithMessage('Error occurred'),
      );
      return;
    }

    await setDefaultValue();

    // 正常終了
    if (mounted) {
      state = const ApiState.loaded();
    }
  }

  // 初期値を設定する
  Future<void> setDefaultValue() async {
    // 検索条件の取得
    final filter = ref.read(filterProvider);
    final dantaiId = filter.dantaiId ?? 0;
    final gakunenCode = filter.gakunenCode ?? '';
    final shozokuId = filter.classId ?? 0;
    final strDate = DateUtil.getStringDate(filter.targetDate ?? DateTime.now());
    final jigenIdx = filter.jigenIdx ?? 0;
    
    // 先生情報の取得
    final tbox = Boxes.getTeachers();
    final teacherList = tbox.values.toList();

    // 教科情報の取得
    final kbox = Boxes.getKamokus();
    final kamokuList = <KamokuModel>[];
    try {
      final keys = kbox.keys
          .toList()
          .where((e) => e.toString().startsWith('$dantaiId-$gakunenCode-'))
          .toList();

      final list = keys.map(kbox.get).toList();
      
      for (final k in list) {
        if (k != null) {
          kamokuList.add(k);
        }
      }
    } catch (e) {
      //
    }


    // 初期化する
    var kamoku = const KamokuModel();
    final teachers = <TeacherModel>[];

    // １） DBに保存された教科情報を設定する
    // １－１）時限別生徒情報の取得
    final meibo = Boxes.getAttendanceTimedMeibo();
    final meiboList = meibo.values.toList();

    // １－２）時限情報の取得
    var jokyo = const AttendanceTimedStatusModel();
    for (final meibo in meiboList) {
      try {
        jokyo = meibo.jokyoList!
            .where((e) => e.jigenIdx == jigenIdx)
            .toList()
            .first;

        break;
      } catch (e) {
        //
      }
    }
    if (jokyo.jigenIdx == jigenIdx) {
      // １－３） 許可情報の設定
      try{
        kamoku = kamokuList
            .where(
              (e) =>
                  e.dantaiBunrui == jokyo.kyokaDantaiBunrui &&
                  e.dantaiKbn == jokyo.kyokaDantaiKbn &&
                  e.kyokaBunrui == jokyo.kyokaBunrui &&
                  e.kamokuCode == jokyo.kamokuCd,
            )
            .first;
      }catch(e){
        //
      }

      ref.read(kamokuProvider.notifier).state = kamoku;

      // 1-4) 担任教員情報の設定
      for (final t in teacherList) {
        if (t.loginId == jokyo.kyoinId1
            || t.loginId == jokyo.kyoinId2
            || t.loginId == jokyo.kyoinId3) {
          teachers.add(t);
        }
      }

      ref.read(teacherListProvider.notifier).state = teachers;

      return ;
    }
    
    // ２）デフォルト設定
    // ２－１）担任教員・教科情報の取得
    final tkbox = Boxes.getTantoKyoins();
    TantoKyoinModel? tantoKyoin;
    try {
      final list = tkbox.values.toList();
      tantoKyoin = list.where((e) => e.jigenIdx == jigenIdx).first;  
    } catch (e) {
      //
    }

    if (tantoKyoin != null) {
      // 2-2) 教科情報の設定
      try {
        kamoku = kamokuList
            .where(
              (e) =>
                  e.dantaiBunrui == tantoKyoin?.kyokaDantaiBunrui &&
                  e.dantaiKbn == tantoKyoin?.kyokaDantaiKbn &&
                  e.kyokaBunrui == tantoKyoin?.kyokaBunrui &&
                  e.kamokuCode == tantoKyoin?.kamokuCd,
            )
            .first;
      } catch (e) {
        //
      }
      ref.read(kamokuProvider.notifier).state = kamoku;
      
      // 2-3) 担任教員情報の設定
      for (final t in teacherList) {
        if (t.loginId == tantoKyoin.kyoinID ) {
          teachers.add(t);
        }
      }
      ref.read(teacherListProvider.notifier).state = teachers;
    }


    // 3）設定なしの設定
    ref.read(kamokuProvider.notifier).state = kamoku;
    ref.read(teacherListProvider.notifier).state = teachers;

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
    late AttendanceTimedStatusModel jokyo;
    try {
      jokyo = meibo.jokyoList!
          .where((e) => e.jigenIdx == filter.jigenIdx)
          .toList()
          .first;
    } catch (ex) {
      jokyo = AttendanceTimedStatusModel(
        jigenIdx: filter.jigenIdx,
        shukketsuBunrui: '',
        shukketsuKbn: '',
        ryaku: '',
        jiyu1: '',
        jiyu2: '',
        isEditable: meibo.jokyoList![0].isEditable,
      );
    }
    if (jokyo.shukketsuBunrui == '50' ||
        jokyo.shukketsuBunrui == '60'
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
      var isEditable = false;
      
      // 編集可否フラグの取得
      late AttendanceTimedStatusModel jokyo;
      try {
        jokyo = m.jokyoList!
            .where(
              (e) => e.jigenIdx == filter.jigenIdx,
            )
            .toList()
            .first;
      } catch (ex) {
        jokyo = AttendanceTimedStatusModel(
          jigenIdx: filter.jigenIdx,
          shukketsuBunrui: '',
          shukketsuKbn: '',
          ryaku: '',
          jiyu1: '',
          jiyu2: '',
          isEditable: m.jokyoList![0].isEditable,
        );
      }

      // 保護されない場合、編集可能
      isEditable = jokyo.isEditable == true ? true : false;
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
