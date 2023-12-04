import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/state/timed_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

// ignore: one_member_abstracts
abstract class TimedsRepositoryProtocol {
  Future<TimedsState> fetch(int shozokuId, DateTime targetDate);
}

final timedsRepositoryProvider = Provider(TimedsRepository.new);

class TimedsRepository implements TimedsRepositoryProtocol {
  TimedsRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<TimedsState> fetch(int shozokuId, DateTime targetDate) async {
    
    final strDate = DateUtil.getStringDate(targetDate);
    final url =
        'api/shozoku/$shozokuId/JigenList?date=$strDate';

    final response = await _api.get(url);

    response.when(
      success: (success) {},
      error: (error) {
        return TimedsState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final timeds = timedListFromJson(value as List<dynamic>);

        return TimedsState.loaded(timeds);
      } catch (e) {
        return TimedsState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return TimedsState.error(response.exception);
    } else {
      return const TimedsState.loading();
    }
  }
}
