import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kyoumutechou/feature/attendance/model/attendance_timed_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_timed_reason_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

// final attendanceTimedReasonListProvider = StateNotifierProvider<AttendanceTimedReasonListProvider, ApiState>((ref) {
//   final stamp = ref.watch(attendanceTimedStampProvider);

//   return AttendanceTimedReasonListProvider(ref, stamp.shukketsuJokyoCd ?? '');
// });

//final attendanceTimedReason1Provider = StateProvider<AttendanceTimedReasonModel>((ref) => AttendanceTimedReasonModel());
//final attendanceTimedReason2Provider = StateProvider<AttendanceTimedReasonModel>((ref) => AttendanceTimedReasonModel());

// class AttendanceTimedReasonListProvider extends StateNotifier<ApiState> {
//   AttendanceTimedReasonListProvider(this.ref,this._shukketsuJokyoCd) : super(const ApiState.loading()) {
//     _init();
//   }

//   final Ref ref;
//   final String _shukketsuJokyoCd;
//   late final AttendanceTimedReasonRepository _repository = ref.read(attendanceTimedReasonRepositoryProvider);

//   Future<void> _init() async { _fetchAttendanceTimedReasonList(); }

//   Future<void> _fetchAttendanceTimedReasonList() async {
//     final response = await _repository.fetch();

//     List keys = Boxes.getAttendanceTimedReason1().keys.toList().where(
//       (element) => element.toString().startsWith('${_shukketsuJokyoCd}'),
//     ).toList(); 
//     keys.sort((a, b) => a.toString().compareTo(b.toString()),);

//     if (keys.length > 0)
//       ref.read(attendanceTimedReason1Provider.notifier).state = Boxes.getAttendanceTimedReason1().get(keys[0])!;
//     else
//       ref.read(attendanceTimedReason1Provider.notifier).state = AttendanceTimedReasonModel();

//     keys = Boxes.getAttendanceTimedReason2().keys.toList().where(
//       (element) => element.toString().startsWith('${_shukketsuJokyoCd}'),
//     ).toList(); 
//     keys.sort((a, b) => a.toString().compareTo(b.toString()),);

//     if (keys.length > 0)
//       ref.read(attendanceTimedReason2Provider.notifier).state = Boxes.getAttendanceTimedReason2().get(keys[0])!;
//     else
//       ref.read(attendanceTimedReason2Provider.notifier).state = AttendanceTimedReasonModel();

//     if (mounted) {
//       state = response;
//     }
//   }
// }
