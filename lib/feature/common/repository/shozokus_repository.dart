import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/state/shozoku_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class ShozokusRepositoryProtocol {
  Future<ShozokusState> fetch(int dantaiId);
}

final shozokusRepositoryProvider = Provider(ShozokusRepository.new);

class ShozokusRepository implements ShozokusRepositoryProtocol {
  ShozokusRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<ShozokusState> fetch(int dantaiId) async {

    final response = await _api.get('api/dantai/$dantaiId/shozoku');

    response.when(
      success: (success) {},
      error: (error) {
        return ShozokusState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final shozokus = shozokuListFromJson(value as List<dynamic>);

        return ShozokusState.loaded(shozokus);
      } catch (e) {
        return ShozokusState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return ShozokusState.error(response.exception);
    } else {
      return const ShozokusState.loading();
    }
  }
}
