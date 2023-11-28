import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/common/model/tokobi_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'tokobi_state.freezed.dart';

@freezed
class TokobisState with _$TokobisState {
  const factory TokobisState.loading() = _Loading;
  const factory TokobisState.loaded(List<TokobiModel> tokobis) = _Loaded;
  const factory TokobisState.error(AppException error) = _Error;
}
