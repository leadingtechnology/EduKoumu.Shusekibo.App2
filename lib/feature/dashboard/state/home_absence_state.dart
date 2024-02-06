import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_absence_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'home_absence_state.freezed.dart';

@freezed
class HomeAbsenceState with _$HomeAbsenceState {
  const factory HomeAbsenceState.loading() = _Loading;
  const factory HomeAbsenceState.loaded(List<HomeAbsenceModel> list) = _Loaded;
  const factory HomeAbsenceState.error(AppException error) = _Error;
}
