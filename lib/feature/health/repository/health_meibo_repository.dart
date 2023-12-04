import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

import '../../../shared/http/api_provider.dart';
import '../../../shared/http/api_response.dart';
import '../../../shared/http/app_exception.dart';
import '../model/health_meibo_model.dart';

abstract class HealthMeiboRepositoryProtocol {
  Future<ApiState> fetchHealthMeibo();
}

final healthMeiboRepositoryProvider =
    Provider((ref) => HealthMeiboRepository(ref));

class HealthMeiboRepository implements HealthMeiboRepositoryProtocol {
  HealthMeiboRepository(this.ref);

  final Ref ref;
  late final ApiProvider _api = ref.read(apiProvider);

  @override
  Future<ApiState> fetchHealthMeibo() async {
    final FilterModel filter = ref.read(filterProvider);
    
    final String strDate = DateFormat('yyyy-MM-dd').format(filter.targetDate?? DateTime.now()).toString();

    if (filter.classId == null) {
      return const ApiState.loading();
    }

    final response = await _api.get('api/shozoku/${filter.classId}/KenkouKansatsubo?date=${strDate}&kouryuGakkyu=${filter.kouryuGakkyu}');

    response.when(
        success: (success) {},
        error: (error) {
          return ApiState.error(error);
        });

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) change response to list
        final meiboList = healthMeiboListFromJson(value as List<dynamic>);
        
        // 2) change list to map
        final Map<int, HealthMeiboModel> _meiboMap = meiboList.asMap();

        // 3) save to hive with key
        await Boxes.getHealthMeiboBox().clear();
        await Boxes.getHealthMeiboBox().putAll(_meiboMap);

        return ApiState.loaded();
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
  Future<ApiState> save() async {
    final FilterModel filter = ref.read(filterProvider);
    
    final String strDate = DateFormat('yyyy-MM-dd').format(filter.targetDate??DateTime.now()).toString();

    List<HealthMeiboModel> meibos = Boxes.getHealthMeiboBox().values.toList();
    String json =  jsonEncode(meibos.map((v) => v.toNewJson()).toList()); //jsonEncode(meibos.map((i) => i.toJson()).toList()).toString();

    final response = await _api.post2('api/shozoku/${filter.classId}/KenkouKansatsubo?date=${strDate}', json);

    return response.when(success: (success) async {

      return const ApiState.loaded();
    }, error: (error) {
      return ApiState.error(AppException.errorWithMessage(error.toString()));
    },);
  }  
}
