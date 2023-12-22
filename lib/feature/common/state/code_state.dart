import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_code_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'code_state.freezed.dart';

@freezed
class CodesState with _$CodesState {
  const factory CodesState.loading() = _Loading;
  const factory CodesState.loaded(List<AwarenessCodeModel> dodes) = _Loaded;
  const factory CodesState.error(AppException error) = _Error;
}
