import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_code_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_code_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class AwarenessCodeRepositoryProtocol { 
  Future<ApiState> fetchAwarenessCode(); 
}

final awarenessCodeRepositoryProvider = Provider(AwarenessCodeRepository.new,);

class AwarenessCodeRepository implements AwarenessCodeRepositoryProtocol {
  AwarenessCodeRepository(this.ref);

  final Ref ref;
  late final ApiProvider _api = ref.read(apiProvider);

  @override
  Future<ApiState> fetchAwarenessCode() async {
    final response = await _api.get('api/kizuki/Bunrui');

    response.when(
        success: (success) {},
        error: (error) {return ApiState.error(error);},
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final awarenessCode = awarenessCodeListFromJson(value as List<dynamic>);


        ref.read(awarenessCodeProvider.notifier).state = awarenessCode.first;

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
