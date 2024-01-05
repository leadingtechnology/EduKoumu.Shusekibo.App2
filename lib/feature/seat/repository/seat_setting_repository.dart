import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/seat/model/seat_setting_model.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';


// ignore: one_member_abstracts
abstract class SeatSettingRepositoryProtocol {
  Future<ApiState> fetch(String classCode);
}

final seatSettingRepositoryProvider = Provider(SeatSettingRepository.new);

class SeatSettingRepository implements SeatSettingRepositoryProtocol {
  SeatSettingRepository(this.ref);

  final Ref ref;
  late final ApiProvider _api = ref.read(apiProvider);
  final box = Boxes.getSeatSetting();

  @override
  Future<ApiState> fetch(String classId) async {
    
    // データの取得
    final response = await _api.get('api/SeatCharts?ShozokuId=$classId');

    response.when(
        success: (success) {},
        error: (error) {
          return ApiState.error(error);
        },);

    if (response is APISuccess) {
      final value = response.value;
      try {
        final seatSetting = seatSettingListFromJson(value as List<dynamic>);

        // 2) save to hive with key
        final seatSettingMap = Map.fromIterables(
            seatSetting.map((e) => e.id), 
            seatSetting.map((e) => e),
        );
        await box.clear();
        await box.putAll(seatSettingMap);


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

  Future<ApiState> delete(int id) async {
    final response = await _api.delete('api/SeatCharts/$id', '');

    if (response is APISuccess) {
      try {
        await box.delete(id);

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

  Future<ApiState> patch(int id, String json) async {
    final response = await _api.patch('api/SeatCharts/$id', json);

    if (response is APISuccess) {
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

    @override
  Future<ApiState> save(String json) async {

    const url = 'api/SeatCharts';
    final response = await _api.post(url, json);

    return response.when(
      success: (success) async {
        return const ApiState.loaded();
      },
      error: (error) {
        return ApiState.error(AppException.errorWithMessage(error.toString()));
      },
    );
  }

}
