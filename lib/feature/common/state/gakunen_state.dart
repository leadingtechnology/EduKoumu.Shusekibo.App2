import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'gakunen_state.freezed.dart';

@freezed
class GakunensState with _$GakunensState {
  const factory GakunensState.loading() = _Loading;
  const factory GakunensState.loaded(List<GakunenModel> gakunens) =
      _Loaded;
  const factory GakunensState.error(AppException error) = _Error;
}
