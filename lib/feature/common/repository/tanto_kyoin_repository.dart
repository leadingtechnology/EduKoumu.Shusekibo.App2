import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/tanto_kyoin_model.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

// ignore: one_member_abstracts
abstract class TantoKyoinsRepositoryProtocol {
  Future<ApiState> fetch(int shozokuId, DateTime targetDate);
}

final tantoKyoinsRepositoryProvider = Provider(TantoKyoinsRepository.new);

class TantoKyoinsRepository implements TantoKyoinsRepositoryProtocol {
  TantoKyoinsRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<ApiState> fetch(int shozokuId, DateTime targetDate) async {
    // パラメーターのチェック。空白の場合、終了する。
    if (shozokuId == 0) {
      return const ApiState.loaded();
    }

    final strDate = DateUtil.getStringDate(targetDate);

    final box = Boxes.getTantoKyoins();
    await box.clear();

    final url = 'api/shozoku/$shozokuId/TantoKyoinList?date=$strDate';
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
        final tantoKyoins = tantoKyoinListFromJson(value as List<dynamic>);

        // ignore: cascade_invocations
        //tantoKyoins.sort((a, b) => '${a.loginId}'.compareTo('${b.loginId}'));

        // 2) save to local
        final tantoKyoinMap = tantoKyoins.asMap();
        await box.putAll(tantoKyoinMap);

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
