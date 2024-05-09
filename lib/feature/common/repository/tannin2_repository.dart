import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';


// ignore: one_member_abstracts
abstract class Tannin2RepositoryProtocol {
  Future<ApiState> fetch();
}

final tannin2RepositoryProvider = Provider(Tannin2Repository.new);

class Tannin2Repository implements Tannin2RepositoryProtocol {
  Tannin2Repository(this.ref,);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> fetch() async {

    final boxGakunen = Boxes.getTanninGakunen();
    final boxShozoku = Boxes.getTanninShozoku();

    await boxGakunen.clear();
    await boxShozoku.clear();

    
    // 20) データを取得する
    final response = await _api.get('api/GakunenClassLists/KY-f01');

    response.when(
        success: (success) {},
        error: (error) {
          return ApiState.error(error);
        },);

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 学年の取得
        final gakunenlist = gakunenListFromJson(value['GakunenList'] as List<dynamic>);

        final gakunenMap = gakunenlist.asMap();
        await boxGakunen.putAll(gakunenMap);

        // 所属の取得
        final shozokulist = shozokuListFromJson(value['ClassList'] as List<dynamic>);

        final shozokuMap = shozokulist.asMap();
        await boxShozoku.putAll(shozokuMap);

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
