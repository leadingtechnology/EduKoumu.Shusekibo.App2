import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_attendance_model.dart';
import 'package:kyoumutechou/feature/dashboard/state/home_attendance_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

// ignore: one_member_abstracts
abstract class HomeAttendanceRepositoryProtocol {
  Future<HomeAttendanceState> fetch(int dantaiId, DateTime targetDate);
}

final homeAttendanceRepositoryProvider = Provider(HomeAttendanceRepository.new);

class HomeAttendanceRepository implements HomeAttendanceRepositoryProtocol {
  HomeAttendanceRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<HomeAttendanceState> fetch(int dantaiId, DateTime targetDate) async {
    final today = DateUtil.getStringDate(targetDate);

    var url = 'api/syukketsu/classbetsu?date=$today';
    url = '$url&dantaiId=$dantaiId';

    final response = await _api.get(url);

    response.when(
      success: (success) {},
      error: (error) {
        return HomeAttendanceState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final list = homeAttendanceListFromJson(value as List<dynamic>);

        return HomeAttendanceState.loaded(list);
      } catch (e) {
        return HomeAttendanceState.error(
            AppException.errorWithMessage(e.toString(),),);
      }
    } else if (response is APIError) {
      return HomeAttendanceState.error(response.exception);
    } else {
      return const HomeAttendanceState.loading();
    }
  }
}
