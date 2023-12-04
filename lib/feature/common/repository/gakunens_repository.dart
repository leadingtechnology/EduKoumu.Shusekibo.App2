import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/state/gakunen_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class GakunensRepositoryProtocol {
  Future<GakunensState> fetch(String organizationKbn);
}

final gakunensRepositoryProvider = Provider(GakunensRepository.new);

class GakunensRepository implements GakunensRepositoryProtocol {
  GakunensRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<GakunensState> fetch(String organizationKbn) async {
    
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

        //1.3 set no grade button.
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
