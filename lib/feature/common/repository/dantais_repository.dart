import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/state/dantai_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class DantaisRepositoryProtocol {
  Future<DantaisState> fetch();
}

final dantaisRepositoryProvider = Provider(DantaisRepository.new);

class DantaisRepository implements DantaisRepositoryProtocol {
  DantaisRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<DantaisState> fetch() async {
    final response = await _api.get('api/dantai');

    response.when(
      success: (success) {},
      error: (error) {
        return DantaisState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final dantais = dantaiListFromJson(value as List<dynamic>);
        
        return DantaisState.loaded(dantais);
      } catch (e) {
        return DantaisState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return DantaisState.error(response.exception);
    } else {
      return const DantaisState.loading();
    }
  }
}
