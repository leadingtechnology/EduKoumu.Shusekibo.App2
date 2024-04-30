import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/common/model/kamoku_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'kamoku_state.freezed.dart';

@freezed
class KamokuState with _$KamokuState {
  const factory KamokuState.loading() = _Loading;
  const factory KamokuState.loaded(List<KamokuModel> kamokus) = _Loaded;
  const factory KamokuState.error(AppException error) = _Error;
}
