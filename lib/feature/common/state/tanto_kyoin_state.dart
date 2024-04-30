import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/common/model/tanto_kyoin_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'tanto_kyoin_state.freezed.dart';

@freezed
class TantoKyoinState with _$TantoKyoinState {
  const factory TantoKyoinState.loading() = _Loading;
  const factory TantoKyoinState.loaded(List<TantoKyoinModel> tantoKyoins) =
      _Loaded;
  const factory TantoKyoinState.error(AppException error) = _Error;
}
