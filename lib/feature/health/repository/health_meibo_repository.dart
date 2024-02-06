import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/health/model/health_meibo_model.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

// ignore: one_member_abstracts
abstract class HealthRepositoryProtocol {
  Future<ApiState> fetch(
    FilterModel filter,
    int days,
    DateTime targetDate,
  );
  Future<ApiState> save(FilterModel filter);
}

final healthMeiboRepositoryProvider = Provider(
  HealthMeiboRepository.new,
);

class HealthMeiboRepository implements HealthRepositoryProtocol {
  HealthMeiboRepository(this.ref);

  final Ref ref;
  late final ApiProvider _api = ref.read(apiProvider);
  final box0 = Boxes.getHealthMeiboBox();
  final box1 = Boxes.getHealthMeiboBox1();
  final box2 = Boxes.getHealthMeiboBox2();  

  @override
  Future<ApiState> fetch(
    FilterModel filter,
    int days,
    DateTime targetDate,
  ) async {
    
    await box0.clear();
    await box1.clear();
    await box2.clear();
    final strDate = DateUtil.getStringDate(targetDate);

    if (filter.classId == null || filter.classId == 0) {
      return const ApiState.loaded();
    }

    var url = 'api/shozoku/${filter.classId}/KenkouKansatsubo';
    url =  '$url?date=$strDate&kouryuGakkyu=${filter.kouryuGakkyu}';
    final response = await _api.get(url);

    response.when(
        success: (success) {},
        error: (error) {
          return ApiState.error(error);
        },);

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) change response to list
        final meiboList = healthMeiboListFromJson(
          value as List<dynamic>,
        );
        
        // 2) change list to map
        final meiboMap = meiboList.asMap();

        switch (days) {
          case 0:
            // set save button enable
            if (meiboMap.isNotEmpty) {
              ref.read(buttonEnableProvider.notifier).state = true;
            } else {
              ref.read(buttonEnableProvider.notifier).state = false;
            }
            // 3) save to hive with key
            await box0.putAll(meiboMap);
          case 1:
            await box1.putAll(meiboMap);
          case 2:
            await box2.putAll(meiboMap);
        }

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
  Future<ApiState> save(FilterModel filter) async {
    
    final strDate = DateUtil.getStringDate(filter.targetDate ?? DateTime.now());

    final meibos = box0.values.toList();
    final json = jsonEncode(meibos.map((v) => v.toNewJson()).toList()); 

    final url = 'api/shozoku/${filter.classId}/KenkouKansatsubo?date=$strDate';
    final response = await _api.post2(url, json);

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
