import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/kamoku_model.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class KamokusRepositoryProtocol {
  Future<ApiState> fetch(int dantaiId, String gakunenCode);
}

final kamokusRepositoryProvider = Provider(KamokusRepository.new);

class KamokusRepository implements KamokusRepositoryProtocol {
  KamokusRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<ApiState> fetch(int dantaiId, String gakunenCode) async {
    // パラメーターのチェック。空白の場合、終了する。
    if (dantaiId == 0) {
      return const ApiState.loaded();
    }

    final box = Boxes.getKamokus();

    // organizationKbnの学年が存在する場合、正常終了とする
    if (box.isNotEmpty) {
      final keys = box.keys.toList().where(
            (element) =>
                element.toString().startsWith('$dantaiId-$gakunenCode-'),
          );

      // keysの値が存在した場合、正常終了とする
      if (keys.isNotEmpty) {
        return const ApiState.loaded();
      }
    }

    final url = 'api/dantai/$dantaiId/kamoku?gakunen=$gakunenCode';
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
        final kamokus = kamokuListFromJson(value as List<dynamic>);

        // ignore: cascade_invocations
        //kamokus.sort((a, b) => '${a.loginId}'.compareTo('${b.loginId}'));

        // 2) save to local
        final kamokuMap = Map.fromIterables(
          kamokus.map((e) => '$dantaiId-$gakunenCode-${e.dantaiBunrui}-${e.dantaiKbn}-${e.kyokaBunrui}-${e.kamokuCode}').toList(),
          kamokus.map((e) => e).toList(),
        );
        await box.putAll(kamokuMap);

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
