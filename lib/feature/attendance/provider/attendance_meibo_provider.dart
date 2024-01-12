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

final attendanceMeiboListProvider = 
    StateNotifierProvider<AttendanceMeiboListProvider, ApiState>((ref) {

  final filter = ref.watch(filterProvider);

  return AttendanceMeiboListProvider(ref, filter);
});

// 選択された生徒情報
final attendanceMeiboProvider = StateProvider<AttendanceMeiboModel>(
  (ref) => const AttendanceMeiboModel(),
);
final attendanceShiftProvider = StateProvider<bool>((ref) => false);

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
      if (m.jokyoList![0].shukketsuBunrui!.isEmpty) {
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
          )
        : AttendanceStatusModel(
            shukketsuBunrui: stamp.shukketsuBunrui,
            shukketsuKbn: stamp.shukketsuKbn,
            ryaku: stamp.shukketsuJokyoNmRyaku,
            jiyu1: reason1.shukketsuJiyuNmSeishiki ?? '',
            jiyu2: reason2.shukketsuJiyuNmSeishiki ?? '',
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
