import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/tokobi_model.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

// ignore: one_member_abstracts
abstract class TokobisRepositoryProtocol {
  Future<ApiState> fetch(
    int shozokuId,
    DateTime targetDate,
    // ignore: avoid_positional_boolean_parameters
    bool isKoryu,
  );
}

final tokobisRepositoryProvider = Provider(TokobisRepository.new);

class TokobisRepository implements TokobisRepositoryProtocol {
  TokobisRepository(this.ref);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> fetch(
    int shozokuId, 
    DateTime targetDate, 
    bool isKoryu,
  ) async {

    final box = Boxes.getTokobis();
    final year = DateUtil.getYear(targetDate);
    final month = DateUtil.getMonth(targetDate);

    // 所属Id,　対象日付の登校日データが存在する場合、正常終了とする
    if (box.isNotEmpty) {
      final keys = box.keys.toList().where(
        (e) => e.toString().startsWith('$shozokuId-${DateUtil.getStringDate(targetDate)}'),
      );
      
      // keysの値が存在した場合、正常終了とする
      if (keys.isNotEmpty) {
        return const ApiState.loaded();
      }
    }

    final url = 'api/shozoku/$shozokuId/ShukketsuShussekibo?year=$year&month=$month&kouryuGakkyu=$isKoryu';
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
        final tokobis = tokobiListFromJson(value as List<dynamic>);

        // 2) change to map and save the box
        final tokobiMap = Map.fromIterables(
          tokobis.map((e) => '$shozokuId-${DateUtil.getStringDate(e.tokobi??DateTime.now())}}').toList(),
          tokobis.map((e) => e).toList(),
        );
        await box.putAll(tokobiMap);

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
