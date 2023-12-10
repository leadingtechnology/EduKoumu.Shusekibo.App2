import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kyoumutechou/feature/attendance/model/attendance_stamp_model.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_stamp_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final attendanceStampListProvider = 
  StateNotifierProvider<AttendanceStampListProvider, ApiState>((ref) {

  return AttendanceStampListProvider(ref);
});

final attendanceStampProvider = StateProvider<AttendanceStampModel>(
  (ref) => const AttendanceStampModel(),
);


class AttendanceStampListProvider extends StateNotifier<ApiState> {
  AttendanceStampListProvider(this.ref)
      : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;

  late final _repository = ref.read(attendanceStampRepositoryProvider);

  Future<void> _init() async { await _fetch(); }

  Future<void> _fetch() async {
    if (Boxes.getRegistAttendanceStamp().values.isNotEmpty) {
      state = const ApiState.loaded();
      return;
    }

    final response = await _repository.fetch();
    if (mounted) {
      state = response;
    }
  }
}
