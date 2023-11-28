import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.loading() = _Loading;
  const factory DashboardState.loaded(List<DantaiModel> dantais) = _Loaded;
  const factory DashboardState.error(AppException error) = _Error;
}
