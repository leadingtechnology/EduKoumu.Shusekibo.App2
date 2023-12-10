import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/tannin_model.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';


// ignore: one_member_abstracts
abstract class TanninRepositoryProtocol {
  Future<ApiState> fetch(int dantaiId, String strDate);
}

final tanninRepositoryProvider = Provider(TanninRepository.new);

class TanninRepository implements TanninRepositoryProtocol {
  TanninRepository(this.ref,);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> fetch(int dantaiId, String strDate) async {

    final box = Boxes.getTannin();

    // 10)団体Id,　対象日付の担任データが存在する場合、正常終了とする
    if (box.isNotEmpty) {
      final keys = box.keys.toList().where(
        (element) => element.toString().startsWith('$dantaiId-$strDate'),
      );
      
      // keysの値が存在した場合、正常終了とする
      if (keys.isNotEmpty) {
        return const ApiState.loaded();
      }
    }

    // 20) データを取得する
    final url = 'api/GakunenClassLists?date=$strDate&dantaiId=$dantaiId';
    final response = await _api.get(url);
    //print('fetchTannin (${response})');

    response.when(
        success: (success) {},
        error: (error) {
          return ApiState.error(error);
        },);

    if (response is APISuccess) {
      final value = response.value;
      try {
        final tannins = tanninListFromJson(value as List<dynamic>);

        // 2) change to map and save the box
        var tanninMap = <String, TanninModel>{};
        if (tannins.isEmpty) {
          final key = '$dantaiId-$strDate';
          tanninMap[key] = const TanninModel();
        } else {
          tanninMap = Map.fromIterables(
            tannins.map((e) => '$dantaiId-$strDate').toList(),
            tannins.map((e) => e).toList(),
          );
        }
        await box.putAll(tanninMap);

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
