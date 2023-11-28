import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'api_state.freezed.dart';

@freezed
class ApiState with _$ApiState {
  const factory ApiState.loading() = _Loading;
  const factory ApiState.loaded() = _Loaded;
  const factory ApiState.error(AppException error) = _Error;
}
