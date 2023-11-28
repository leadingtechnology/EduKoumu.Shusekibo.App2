import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'timed_state.freezed.dart';

@freezed
class TimedsState with _$TimedsState {
  const factory TimedsState.loading() = _Loading;
  const factory TimedsState.loaded(List<TimedModel> timeds) = _Loaded;
  const factory TimedsState.error(AppException error) = _Error;
}
