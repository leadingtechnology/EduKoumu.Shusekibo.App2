import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_code_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_code_provider.dart';
import 'package:kyoumutechou/feature/common/state/code_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class AwarenessCodeRepositoryProtocol { 
  Future<CodesState> fetch(); 
}

final awarenessCodeRepositoryProvider = Provider(AwarenessCodeRepository.new,);

class AwarenessCodeRepository implements AwarenessCodeRepositoryProtocol {
  AwarenessCodeRepository(this.ref);

  final Ref ref;
  late final ApiProvider _api = ref.read(apiProvider);

  @override
  Future<CodesState> fetch() async {
    final response = await _api.get('api/kizuki/bunrui/');

    response.when(
      success: (success) {},
      error: (error) { return CodesState.error(error); },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final awarenessCode = awarenessCodeListFromJson(value as List<dynamic>);

        if (awarenessCode.isEmpty) {
          return const CodesState.loaded([]);
        }
        
        ref.read(awarenessCodeProvider.notifier).state = awarenessCode.first;

        return CodesState.loaded(awarenessCode);
      } catch (e) {
        return CodesState.error(
            AppException.errorWithMessage(e.toString(),),);
      }
    } else if (response is APIError) {
      return CodesState.error(response.exception);
    } else {
      return const CodesState.loading();
    }
  }
}
