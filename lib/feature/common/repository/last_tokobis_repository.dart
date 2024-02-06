import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

// ignore: one_member_abstracts
abstract class LastTokobisRepositoryProtocol {
  Future<ApiState> fetch(
    int shozokuId,
    DateTime targetDate,
    // ignore: avoid_positional_boolean_parameters
    {int? count = 2,}
  );
}

final lastTokobisRepositoryProvider = Provider(LastTokobisRepository.new);

class LastTokobisRepository implements LastTokobisRepositoryProtocol {
  LastTokobisRepository(this.ref);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> fetch(
    int dantaiId, 
    DateTime targetDate, 
    {int? count = 2,}
  ) async {

    final url = 'api/TaishoDates?dantaiId=$dantaiId&toDate=$targetDate&count=$count';
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
        final firstDay = DateUtil.calculateFiscalYear(targetDate)
            .item1
            .subtract(const Duration(days: 1));

        // 1) get the list
        List<DateTime> tokobis =  (value as List)
            .map((v) => DateTime.parse(v as String))
            .where((e) => e.isAfter(firstDay))
            .toList();

        // ) ソート降順
        tokobis.add(targetDate);
        tokobis.sort((a, b) => b.compareTo(a));

        // 2) save to provider
        ref.read(lastTokobisProvider.notifier).state = tokobis;
    
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
