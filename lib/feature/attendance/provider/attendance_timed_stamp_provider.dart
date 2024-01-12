import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kyoumutechou/feature/attendance/model/attendance_timed_stamp_model.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_timed_stamp_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

// final attendanceTimedStampListProvider = StateNotifierProvider<AttendanceTimedStampListProvider, ApiState>((ref) {
//   //final shozoku = ref.watch(attendanceTimedShozokuListProvider);

//   return AttendanceTimedStampListProvider(ref);
// });

//final attendanceTimedStampProvider = StateProvider<AttendanceTimedStampModel>((ref) => AttendanceTimedStampModel());
//final attendanceTimedUnregistShowProvider = StateProvider<bool>((ref) => false);

// class AttendanceTimedStampListProvider extends StateNotifier<ApiState> {
//   AttendanceTimedStampListProvider(this.ref)
//       : super(const ApiState.loading()) {
//     _init();
//   }

//   final Ref ref;

//   late final AttendanceTimedStampRepository _repository = ref.read(attendanceTimedStampRepositoryProvider);

//   Future<void> _init() async { _fetchAttendanceTimedStampList(); }

//   Future<void> _fetchAttendanceTimedStampList() async {
//     final response = await _repository.fetchAttendanceTimedStamp();
//     if (mounted) {
//       state = response;
//     }
//   }
// }
