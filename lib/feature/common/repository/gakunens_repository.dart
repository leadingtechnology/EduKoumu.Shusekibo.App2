import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/common/state/gakunen_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class GakunensRepositoryProtocol {
  Future<ApiState> fetch(String organizationKbn);
}

final gakunensRepositoryProvider = Provider(GakunensRepository.new);

class GakunensRepository implements GakunensRepositoryProtocol {
  GakunensRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<ApiState> fetch(String organizationKbn) async {
    // パラメーターのチェック。空白の場合、終了する。
    if (organizationKbn.isEmpty) {
      return const ApiState.loaded();
    }  
    
    final box = Boxes.getGakunens();
    
    // organizationKbnの学年が存在する場合、正常終了とする
    if (box.isNotEmpty) {
      final keys = box.keys.toList().where(
            (element) => element.toString().startsWith('$organizationKbn-'),
          );
      
      // keysの値が存在した場合、正常終了とする
      if (keys.isNotEmpty) {
        return const ApiState.loaded();
      }
    }

    final url = 'api/gakunen?kbn=$organizationKbn';
    final response = await _api.get(url);

    response.when(
      success: (success) {},
      error: (error) {
        return GakunensState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) get the list
        final gakunens = gakunenListFromJson(value as List<dynamic>);
        
        // ignore: cascade_invocations
        gakunens.sort((a, b) => a.id??0.compareTo(b.id??0));

        // 2) set no grade button.
        final l = gakunens.last;
        final nashi = GakunenModel(
            id: 999,
            organizationId: l.organizationId ?? 0,
            gakunenCode: '0',
            gakunenName: '学年なし',
            gakunenRyakusho: '学年なし',
            kateiKbn: l.kateiKbn ?? '0',
            code: '999',
            name: '学年なし',);
        gakunens.add(nashi);

        // 3) save to local
        final gakunenMap = Map.fromIterables(
          gakunens.map((e) => '$organizationKbn-${e.id}').toList(),
          gakunens.map((e) => e).toList(),
        );
        await box.putAll(gakunenMap);

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
