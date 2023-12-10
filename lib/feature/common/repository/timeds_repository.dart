import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class TimedsRepositoryProtocol {
  Future<ApiState> fetch(int shozokuId, String strDate);
}

final timedsRepositoryProvider = Provider(TimedsRepository.new);

class TimedsRepository implements TimedsRepositoryProtocol {
  TimedsRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<ApiState> fetch(int shozokuId, String strDate) async {
    
    final box = Boxes.getTimeds();

    // 所属Id,　対象日付の時限データが存在する場合、正常終了とする
    if (box.isNotEmpty) {
      final keys = box.keys.toList().where(
        (element) => element.toString().startsWith('$shozokuId-$strDate-'),
      );
      
      // keysの値が存在した場合、正常終了とする
      if (keys.isNotEmpty) {
        return const ApiState.loaded();
      }
    }

    
    final url = 'api/shozoku/$shozokuId/JigenList?date=$strDate';
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
        final timeds = timedListFromJson(value as List<dynamic>);

        // ignore: cascade_invocations
        timeds.sort((a, b) => a.jigenIdx??0.compareTo(b.jigenIdx??0));

        // 2) change to map and save the box
        final timedMap = Map.fromIterables(
          timeds.map((e) => '$shozokuId-$strDate-${e.jigenIdx}').toList(),
          timeds.map((e) => e).toList(),
        );
        await box.putAll(timedMap);

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
