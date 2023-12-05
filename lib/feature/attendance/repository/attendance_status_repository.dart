import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_status_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_status_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

abstract class AttendanceStatusRepositoryProtocol { 
  Future<ApiState> fetchAttendanceStatus(); 
}

final attendanceStatusRepositoryProvider = Provider(
  AttendanceStatusRepository.new,
);

class AttendanceStatusRepository implements AttendanceStatusRepositoryProtocol {
  AttendanceStatusRepository(this.ref);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> fetchAttendanceStatus() async {
    final response = await _api.get('status_AttendanceStatus_model');

    response.when(
        success: (success) {},
        error: (error) {return ApiState.error(error);}
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final attendanceStatus = attendanceStatusListFromJson(value as List<dynamic>);


        ref.read(attendanceStatusProvider.notifier).state = attendanceStatus.first;

        return const ApiState.loaded();
      } catch (e) {
        return ApiState.error(
            AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return ApiState.error(response.exception);
    } else {
      return const ApiState.loading();
    }
  }
}
