import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'dantai_state.freezed.dart';

@freezed
class DantaisState with _$DantaisState {
  const factory DantaisState.loading() = _Loading;
  const factory DantaisState.loaded(List<DantaiModel> dantais) = _Loaded;
  const factory DantaisState.error(AppException error) = _Error;
}
