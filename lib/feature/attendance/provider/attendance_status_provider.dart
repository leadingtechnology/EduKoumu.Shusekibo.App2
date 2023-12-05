import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kyoumutechou/feature/attendance/model/attendance_status_model.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_status_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final attendanceStatusListProvider = StateNotifierProvider<AttendanceStatusListProvider, ApiState>((ref) {

  return AttendanceStatusListProvider(ref);
});

final attendanceStatusProvider = StateProvider<AttendanceStatusModel>((ref) => AttendanceStatusModel());

class AttendanceStatusListProvider extends StateNotifier<ApiState> {
  AttendanceStatusListProvider(this.ref)
      : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;

  late final _repository = ref.read(attendanceStatusRepositoryProvider);

  Future<void> _init() async { _fetchAttendanceStatusList(); }

  Future<void> _fetchAttendanceStatusList() async {
    final response = await _repository.fetchAttendanceStatus();
    if (mounted) {
      state = response;
    }
  }
}
