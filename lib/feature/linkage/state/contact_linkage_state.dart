import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/linkage/model/contact_linkage_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'contact_linkage_state.freezed.dart';

@freezed
class ContactLinkageState with _$ContactLinkageState {
  const factory ContactLinkageState.loading() = _Loading;
  const factory ContactLinkageState.loaded(List<ContactLinkageModel> list) =
      _Loaded;
  const factory ContactLinkageState.error(AppException error) = _Error;
}
