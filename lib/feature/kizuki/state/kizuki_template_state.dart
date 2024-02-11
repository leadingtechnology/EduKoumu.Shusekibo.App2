import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/kizuki/model/kizuki_template_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'kizuki_template_state.freezed.dart';

@freezed
class KizukiTemplateState with _$KizukiTemplateState {
  const factory KizukiTemplateState.loading() = _Loading;
  const factory KizukiTemplateState.loaded(List<KizukiTemplateModel> list) = _Loaded;
  const factory KizukiTemplateState.error(AppException error) = _Error;
}
