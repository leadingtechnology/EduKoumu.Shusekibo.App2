import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_health_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'home_health_state.freezed.dart';

@freezed
class HomeHealthState with _$HomeHealthState {
  const factory HomeHealthState.loading() = _Loading;
  const factory HomeHealthState.loaded(
      Map<String, List<HomeHealthModel>> maps,) = _Loaded;
  const factory HomeHealthState.error(AppException error) = _Error;
}
