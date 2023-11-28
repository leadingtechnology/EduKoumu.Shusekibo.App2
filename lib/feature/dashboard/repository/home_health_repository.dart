import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_health_model.dart';
import 'package:kyoumutechou/feature/dashboard/state/home_health_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

// ignore: one_member_abstracts
abstract class HomeHealthRepositoryProtocol {
  Future<HomeHealthState> fetch(int dantaiId, DateTime today);
}

final homeHealthRepositoryProvider = Provider(HomeHealthRepository.new);

class HomeHealthRepository implements HomeHealthRepositoryProtocol {
  HomeHealthRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<HomeHealthState> fetch(int dantaiId, DateTime targetDate) async {
    final today = DateUtil.getStringDate(targetDate);

    var url = 'api/kenkou/classbetsu?date=$today';
    url = '$url&dantaiId=$dantaiId';

    final response = await _api.get(url);

    response.when(
      success: (success) {},
      error: (error) {
        return HomeHealthState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final list = homeHealthListFromJson(value as List<dynamic>);

        return HomeHealthState.loaded(list);
      } catch (e) {
        return HomeHealthState.error(
            AppException.errorWithMessage(e.toString(),),);
      }
    } else if (response is APIError) {
      return HomeHealthState.error(response.exception);
    } else {
      return const HomeHealthState.loading();
    }
  }
}
