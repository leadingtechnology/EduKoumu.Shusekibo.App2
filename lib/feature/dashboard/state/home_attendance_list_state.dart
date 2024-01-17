import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_attendance_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'home_attendance_list_state.freezed.dart';

@freezed
class HomeAttendanceListState with _$HomeAttendanceListState {
  const factory HomeAttendanceListState.loading() = _Loading;
  const factory HomeAttendanceListState.loaded(List<List<HomeAttendanceModel>> list) = _Loaded;
  const factory HomeAttendanceListState.error(AppException error) = _Error;
}
