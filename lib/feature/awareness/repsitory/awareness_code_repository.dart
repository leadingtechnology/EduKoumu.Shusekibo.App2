import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_code_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_code_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class AwarenessCodeRepositoryProtocol { 
  Future<ApiState> fetch(int dantaiId); 
}

final awarenessCodeRepositoryProvider = Provider(AwarenessCodeRepository.new,);

class AwarenessCodeRepository implements AwarenessCodeRepositoryProtocol {
  AwarenessCodeRepository(this.ref);

  final Ref ref;
  late final ApiProvider _api = ref.read(apiProvider);

  @override
  Future<ApiState> fetch(int dantaiId) async {
    final box = Boxes.getBunruiBox();

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

    final response = await _api.get('api/kizuki/bunrui/');

    response.when(
      success: (success) {},
      error: (error) { return ApiState.error(error); },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) get the list
        final awarenessCode = awarenessCodeListFromJson(value as List<dynamic>);

        // 2) change to map and save the box
        final awarenessCodeMap = Map.fromIterables(
          awarenessCode.map((e) => '$dantaiId-${e.code}').toList(),
          awarenessCode.map((e) => e).toList(),
        );
        await box.putAll(awarenessCodeMap);

        return const ApiState.loaded();
      } catch (e) {
        return ApiState.error(
            AppException.errorWithMessage(e.toString(),),);
      }
    } else if (response is APIError) {
      return ApiState.error(response.exception);
    } else {
      return const ApiState.loading();
    }
  }
}
