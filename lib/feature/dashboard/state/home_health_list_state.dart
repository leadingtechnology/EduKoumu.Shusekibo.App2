import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_health_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'home_health_list_state.freezed.dart';

@freezed
class HomeHealthListState with _$HomeHealthListState {
  const factory HomeHealthListState.loading() = _Loading;
  const factory HomeHealthListState.loaded(List<List<HomeHealthModel>> list) = _Loaded;
  const factory HomeHealthListState.error(AppException error) = _Error;
}
