import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_stamp_provider.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_reason_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final attendanceReasonListProvider = 
  StateNotifierProvider<AttendanceReasonListProvider, ApiState>((ref) {
  
  final stamp = ref.watch(attendanceStampProvider);

  return AttendanceReasonListProvider(
    ref, 
    stamp.shukketsuJokyoCd??'',
    stamp.shukketsuKbn??'',
    );
});

final attendanceReason1Provider = StateProvider<AttendanceReasonModel>(
  (ref) => const AttendanceReasonModel(),);
final attendanceReason2Provider = StateProvider<AttendanceReasonModel>(
  (ref) => const AttendanceReasonModel(),);

class AttendanceReasonListProvider extends StateNotifier<ApiState> {
  AttendanceReasonListProvider(
    this.ref, this._jokyoCd,this._shukketsuKbn,
  ) : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  final String _jokyoCd;
  final String _shukketsuKbn;
  late final _repository = ref.read(attendanceReasonRepositoryProvider);

  Future<void> _init() async { await _fetch(); }

  Future<void> _fetch() async {
    // _jokyoCdが空の場合、正常終了とする
    if (_jokyoCd.isEmpty) {
      state = const ApiState.loaded();
      return;
    }

    final response = await _repository.fetch(_jokyoCd, _shukketsuKbn);

    var keys = Boxes.getAttendanceReason1().keys.toList().where(
      (element) => element.toString().startsWith(_jokyoCd),
    ).toList(); 
    keys.sort((a, b) => a.toString().compareTo(b.toString()),);

    if(keys.isNotEmpty) {
      ref.read(attendanceReason1Provider.notifier).state = 
      Boxes.getAttendanceReason1().get(keys[0])!;
    } 

    keys = Boxes.getAttendanceReason2().keys.toList().where(
      (element) => element.toString().startsWith(_jokyoCd),
    ).toList(); 
    //keys.sort((a, b) => a.toString().compareTo(b.toString()),);

    if (keys.isNotEmpty) {
      ref.read(attendanceReason2Provider.notifier).state = 
      Boxes.getAttendanceReason2().get(keys[0])!;
    } 

    if (mounted) {
      state = response;
    }
  }
}
