import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/state/gakunen_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

abstract class GakunensRepositoryProtocol {
  Future<GakunensState> fetch();
}

final gakunensRepositoryProvider = Provider(GakunensRepository.new);

class GakunensRepository implements GakunensRepositoryProtocol {
  GakunensRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<GakunensState> fetch() async {
    final response = await _api.get('gakunens');

    response.when(
      success: (success) {},
      error: (error) {
        return GakunensState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final gakunens = gakunenListFromJson(value as List<dynamic>);

        return GakunensState.loaded(gakunens);
      } catch (e) {
        return GakunensState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return GakunensState.error(response.exception);
    } else {
      return const GakunensState.loading();
    }
  }
}
