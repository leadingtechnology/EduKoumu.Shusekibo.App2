import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/tokobi_model.dart';
import 'package:kyoumutechou/feature/common/state/tokobi_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

abstract class TokobisRepositoryProtocol {
  Future<TokobisState> fetch();
}

final tokobisRepositoryProvider = Provider(TokobisRepository.new);

class TokobisRepository implements TokobisRepositoryProtocol {
  TokobisRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<TokobisState> fetch() async {
    final response = await _api.get('tokobis');

    response.when(
      success: (success) {},
      error: (error) {
        return TokobisState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final tokobis = tokobiListFromJson(value as List<dynamic>);

        return TokobisState.loaded(tokobis);
      } catch (e) {
        return TokobisState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return TokobisState.error(response.exception);
    } else {
      return const TokobisState.loading();
    }
  }
}
