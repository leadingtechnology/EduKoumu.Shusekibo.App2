import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/seat/model/seat_chart_model.dart';

import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class SeatChartRepositoryProtocol {
  Future<ApiState> fetch(int seatSettingId);
}

final seatChartRepositoryProvider = Provider(SeatChartRepository.new);

class SeatChartRepository implements SeatChartRepositoryProtocol {
  SeatChartRepository(this.ref);

  late final ApiProvider _api = ref.read(apiProvider);
  final box = Boxes.getSeatChart();
  final Ref ref;

  @override
  Future<ApiState> fetch(int seatSettingId) async {
    final response = await _api.get('api/SeatChartStudents?SeatChartId=$seatSettingId');

    response.when(
        success: (success) {},
        error: (error) {
          return ApiState.error(error);
        },);

    if (response is APISuccess) {
      final value = response.value;
      try {
        final seatChart = seatChartListFromJson(value as List<dynamic>);

        // 2) save to hive with key
        final seatChartMap = Map.fromIterables(
            seatChart.map((e) => '$seatSettingId-${e.seatNumber}'), 
            seatChart.map((e) => e),
        );
        await box.clear();
        await box.putAll(seatChartMap);

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
