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
  Future<ApiState> patch(int id, String json);
}

final seatChartRepositoryProvider = Provider(SeatChartRepository.new);

class SeatChartRepository implements SeatChartRepositoryProtocol {
  SeatChartRepository(this.ref);

  late final ApiProvider _api = ref.read(apiProvider);
  final box = Boxes.getSeatChart();
  final Ref ref;

  @override
  Future<ApiState> fetch(int seatSettingId) async {

    // 設定をクリア
    await box.clear();

    final url = 'api/SeatChartStudents?SeatChartId=$seatSettingId';
    final response = await _api.get(url);

    response.when(
        success: (success) {},
        error: (error) {
          return ApiState.error(error);
        },);

    if (response is APISuccess) {
      final value = response.value;
      try {
        if (value == null) {
          return const ApiState.loaded();
        } 

        final seatChart =
            seatChartListFromJson(value['SeatChartStudents'] as List<dynamic>);

        // 2) save to hive with key
        final seatChartMap = Map.fromIterables(
            seatChart.map((e) => e.seatIndex), 
            seatChart.map((e) => e),
        );
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

  @override
  Future<ApiState> patch(int id, String json) async {
    
    final url = 'api/SeatChartStudents/$id';
    final response = await _api.patch(url, json);

    response.when(
        success: (success) {},
        error: (error) {
          return ApiState.error(error);
        },);

    if (response is APISuccess) {
      final value = response.value;
      try {
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
