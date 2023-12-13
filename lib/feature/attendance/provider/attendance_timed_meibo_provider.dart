import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_stamp_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_status_model.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_timed_meibo_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final attendanceTimedMeiboListProvider = 
    StateNotifierProvider<AttendanceTimedMeiboListProvider, ApiState>((ref) {
  
  final filter = ref.watch(filterProvider);

  return AttendanceTimedMeiboListProvider(ref, filter);
});

// 選択された生徒情報
final attendanceTimedMeiboProvider = StateProvider<AttendanceTimedMeiboModel>(
  (ref) => const AttendanceTimedMeiboModel(),
);
final attendanceTimedShiftProvider = StateProvider<bool>((ref) => false);

// 出欠（時）
class AttendanceTimedMeiboListProvider extends StateNotifier<ApiState> {
  AttendanceTimedMeiboListProvider(this.ref, this.filter)
  : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  final FilterModel filter;
  late final _repository = ref.read(timedMeiboRepositoryProvider);

  Future<void> _init() async { 
    await _fetch(); 
  }

  Future<void> _fetch() async {
    final response = await _repository.fetch(filter);
    if (mounted) {
      state = response;
    }
  }

  Future<void> save() async {
    state = await _repository.save(filter);
  }

  // set stamp by Id
  Future<void> updateById(
    AttendanceTimedMeiboModel meibo,
    AttendanceTimedStampModel stamp,
    FilterModel filter,
    AttendanceTimedReasonModel reason1,
    AttendanceTimedReasonModel reason2,
  ) async {
    
    if (stamp.shukketsuJokyoCd == '001') return;

    // set all.
    if (stamp.shukketsuBunrui == '50' || stamp.shukketsuBunrui == '60') {
      final meibos = Boxes.getAttendanceTimedMeiboModelBox().values.toList();

      for (final m in meibos) {
        await updateBox(m, stamp, filter, reason1, reason2);
      }
      return;
    }

    //clear all and set one
    if (meibo.jokyoList![0].shukketsuBunrui == '50' ||
        meibo.jokyoList![0].shukketsuBunrui == '60'
    ) {

      final meibos = Boxes.getAttendanceTimedMeiboModelBox().values.toList();
      const s = AttendanceTimedStampModel(
        shukketsuJokyoCd: '999', 
        shukketsuBunrui: '', 
        shukketsuKbn: '',
      );

      for (final m in meibos) {
        if (m.studentKihonId == meibo.studentKihonId) {
          await updateBox(meibo, stamp, filter, reason1, reason2);
        } else {
          await updateBox(
            m, 
            s, 
            filter, 
            const AttendanceTimedReasonModel(), 
            const AttendanceTimedReasonModel(),
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
    final meibos = Boxes.getAttendanceTimedMeiboModelBox().values.toList();

    if (meibos.isEmpty) return;

    final stamp = Boxes.getRegistAttendanceTimedStampBox().get('100');

    for (final m in meibos) {
      if (m.jokyoList![0].shukketsuBunrui!.isEmpty) {
        await updateBox(
            m, 
            stamp!, 
            filter, 
            const AttendanceTimedReasonModel(), 
            const AttendanceTimedReasonModel(),
        );
      }
    }
  }

  Future<void> updateBox(
    AttendanceTimedMeiboModel meibo,
    AttendanceTimedStampModel stamp,
    FilterModel filter,
    AttendanceTimedReasonModel reason1,
    AttendanceTimedReasonModel reason2,
  ) async {
    final status = stamp.shukketsuJokyoCd == '999'
        ? AttendanceTimedStatusModel(
            jigenIdx: filter.jigenIdx,
            shukketsuBunrui: '',
            shukketsuKbn: '',
            ryaku: '',
            jiyu1: '',
            jiyu2: '',
          )
        : AttendanceTimedStatusModel(
            jigenIdx: filter.jigenIdx,
            shukketsuBunrui: stamp.shukketsuBunrui,
            shukketsuKbn: stamp.shukketsuKbn,
            ryaku: stamp.shukketsuJokyoNmRyaku,
            jiyu1: reason1.shukketsuJiyuNmSeishiki ?? '',
            jiyu2: reason2.shukketsuJiyuNmSeishiki ?? '',
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
      jokyoList: [status],
    );

    final box = Boxes.getAttendanceTimedMeiboModelBox();
    final index = box.keys.firstWhere(
        (k) => box.getAt(k as int)?.studentKihonId == newMeibo.studentKihonId,
      );

    await box.put(index, newMeibo);
  }

}
