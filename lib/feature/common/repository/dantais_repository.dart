import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class DantaisRepositoryProtocol {
  Future<ApiState> fetch();
}

final dantaisRepositoryProvider = Provider(DantaisRepository.new);

class DantaisRepository implements DantaisRepositoryProtocol {
  DantaisRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<ApiState> fetch() async {
    final response = await _api.get('api/dantai');

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
        final dantais = dantaiListFromJson(value as List<dynamic>);
        dantais.sort((a, b) =>
            '${a.organizationBunrui}${a.organizationKbn}${a.code}'.compareTo(
                '${b.organizationBunrui}${b.organizationKbn}${b.code}',),);

        // 2) change to map and save the box
        final dantaiMap = Map.fromIterables(
          dantais.map((e) => e.id).toList(),
          dantais.map((e) => e).toList(),
        );
        
        await Boxes.getDantais().clear();
        await Boxes.getDantais().putAll(dantaiMap);

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
