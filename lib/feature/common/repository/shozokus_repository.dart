import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class ShozokusRepositoryProtocol {
  Future<ApiState> fetch(int dantaiId);
}

final shozokusRepositoryProvider = Provider(ShozokusRepository.new);

class ShozokusRepository implements ShozokusRepositoryProtocol {
  ShozokusRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<ApiState> fetch(int dantaiId) async {

    final box = Boxes.getShozokus();

    // dantaiIdの所属が存在する場合、正常終了とする
    if (box.isNotEmpty) {
      final keys = box.keys.toList().where(
            (element) => element.toString().startsWith('$dantaiId-'),
          );
      
      // keysの値が存在した場合、正常終了とする
      if (keys.isNotEmpty) {
        return const ApiState.loaded();
      }
    }
    
    final url = 'api/dantai/$dantaiId/shozoku';
    final response = await _api.get(url);

    response.when(
      success: (success) {},
      error: (error) {
        return ApiState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) get the list
        final shozokus = shozokuListFromJson(value as List<dynamic>);
        // ignore: cascade_invocations
        shozokus.sort((a, b) => a.id??0.compareTo(b.id??0));

        // 2) change to map and save the box
        final shozokuMap = Map.fromIterables(
          shozokus.map((e) => '$dantaiId-${e.gakunenCode}-${e.id}').toList(),
          shozokus.map((e) => e).toList(),
        );
        await box.putAll(shozokuMap);

        return const ApiState.loaded();
      } catch (e) {
        return ApiState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return ApiState.error(response.exception);
    } else {
      return const ApiState.loading();
    }
  }
}
