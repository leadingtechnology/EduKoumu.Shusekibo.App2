import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/kizuki/model/kizuki_template_model.dart';
import 'package:kyoumutechou/feature/kizuki/state/kizuki_template_state.dart';

import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

abstract class KizukiTemplateRepositoryProtocol {
  Future<KizukiTemplateState> fetch({int? id});
  Future<void> save(String json);
  Future<void> patch(int id, String json);
  Future<void> delete(int id);
}

final kizukiTemplateRepositoryProvider = Provider(KizukiTemplateRepository.new);

class KizukiTemplateRepository implements KizukiTemplateRepositoryProtocol {
  KizukiTemplateRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<KizukiTemplateState> fetch({int? id}) async {

    var url = 'api/KizukiTemplates';
    if (id != null) {
      url = '$url/$id';
    }
    final response = await _api.get(url);

    response.when(
      success: (success) {},
      error: (error) {
        return KizukiTemplateState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final list = kizukiTemplateListFromJson(value as List<dynamic>);

        return KizukiTemplateState.loaded(list);
      } catch (e) {
        return KizukiTemplateState.error(
          AppException.errorWithMessage(e.toString()),
        );
      }
    } else if (response is APIError) {
      return KizukiTemplateState.error(response.exception);
    } else {
      return const KizukiTemplateState.loading();
    }
  }

  @override
  Future<KizukiTemplateState> save(String json) async {
    final response = await _api.post2('api/KizukiTemplates', json);

    if (response is APISuccess) {
      final value = response.value;
      try {
        final list = KizukiTemplateModel.fromJson(value as Map<String, dynamic>);

        return KizukiTemplateState.loaded([list]);
      } catch (e) {
        return KizukiTemplateState.error(
          AppException.errorWithMessage(e.toString()),
        );
      }
    } else if (response is APIError) {
      return KizukiTemplateState.error(response.exception);
    } else {
      return const KizukiTemplateState.loading();
    }
  }

  @override
  Future<KizukiTemplateState> patch(int id, String json) async {
    
    final url = 'api/KizukiTemplates/$id';
    final response = await _api.patch(url, json);

    if (response is APISuccess) {
      final value = response.value;
      try {
        final list = kizukiTemplateListFromJson(value as List<dynamic>);

        return KizukiTemplateState.loaded(list);
      } catch (e) {
        return KizukiTemplateState.error(
          AppException.errorWithMessage(e.toString()),
        );
      }
    } else if (response is APIError) {
      return KizukiTemplateState.error(response.exception);
    } else {
      return const KizukiTemplateState.loading();
    }
  }

  @override
  Future<KizukiTemplateState> delete(int id) async {
    
    final url = 'api/KizukiTemplates/$id';
    final response = await _api.delete(url, '');

    if (response is APISuccess) {
      final value = response.value;
      try {
        final list =
            KizukiTemplateModel.fromJson(value as Map<String, dynamic>);

        return KizukiTemplateState.loaded([list]);
      } catch (e) {
        return KizukiTemplateState.error(
          AppException.errorWithMessage(e.toString()),
        );
      }
    } else if (response is APIError) {
      return KizukiTemplateState.error(response.exception);
    } else {
      return const KizukiTemplateState.loading();
    }
  }

  
}
