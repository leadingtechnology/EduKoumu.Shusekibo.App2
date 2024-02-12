import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/linkage/model/contact_linkage_model.dart';
import 'package:kyoumutechou/feature/linkage/state/contact_linkage_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

abstract class ContactLinkageRepositoryProtocol {
  Future<ContactLinkageState> fetch(int dantaiId, DateTime targetDate);
  Future<ContactLinkageState> patch(int dantaiId, DateTime targetDate, int id);
}

final contactLinkageRepositoryProvider = Provider(ContactLinkageRepository.new);

class ContactLinkageRepository implements ContactLinkageRepositoryProtocol {
  ContactLinkageRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<ContactLinkageState> fetch(int dantaiId, DateTime targetDate) async {

    final strDate = DateUtil.getStringDate(targetDate);
    final url = 'api/dantais/$dantaiId/ContactLinkages?date=$strDate&deleteFlg=';
    
    final response = await _api.get(url);

    response.when(
      success: (success) {},
      error: (error) {
        return ContactLinkageState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final list = contactLinkageListFromJson(value as List<dynamic>);

        return ContactLinkageState.loaded(list);
      } catch (e) {
        return ContactLinkageState.error(
          AppException.errorWithMessage(e.toString()),
        );
      }
    } else if (response is APIError) {
      return ContactLinkageState.error(response.exception);
    } else {
      return const ContactLinkageState.loading();
    }
  }

  @override
  Future<ContactLinkageState> patch(
      int dantaiId, 
      DateTime targetDate, 
      int id,
  ) async {

    final url = 'api/contactLinkages/$id?processStatus=1';
    
    final response = await _api.patch(url, '');

    if (response is APISuccess) {
      final value = response.value;
      try {
        final list =
            ContactLinkageModel.fromJson(value as Map<String, dynamic>);

        return fetch(dantaiId, targetDate);
      } catch (e) {
        return ContactLinkageState.error(
          AppException.errorWithMessage(e.toString()),
        );
      }
    } else if (response is APIError) {
      return ContactLinkageState.error(response.exception);
    } else {
      return const ContactLinkageState.loading();
    }
  }
}
