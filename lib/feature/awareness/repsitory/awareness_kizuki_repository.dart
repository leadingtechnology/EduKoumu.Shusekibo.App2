import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_kizuki_model.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class AwarenessKizukiRepositoryProtocol {
  Future<ApiState> fetch();
}

final awarenessKizukiRepositoryProvider =
    Provider(AwarenessKizukiRepository.new);

class AwarenessKizukiRepository implements AwarenessKizukiRepositoryProtocol {
  AwarenessKizukiRepository(this.ref);

  final Ref ref;
  late final ApiProvider _api = ref.read(apiProvider);

  @override
  Future<ApiState> fetch() async {
    final dantai = ref.read(dantaiProvider);
    final filter = ref.read(filterProvider);

    final strDate = DateFormat('yyyy-MM-dd')
        .format(filter.beginDate ?? DateTime.now())
        ;
    final endDate = DateFormat('yyyy-MM-dd')
        .format(filter.endDate ?? DateTime.now())
        ;

    final json = '''
{        
    DantaiId: ${dantai.id},
    Gakunen: ${filter.gakunenCode},
    ShozokuId: ${filter.classId},
    Start: "$strDate",
    End: "$endDate",
    TakeNo: 100,
    PageNo: 1
}
   ''';


    final response = await _api.post2('api/kizuki/search', json);

    response.when(
        success: (success) {},
        error: (error) {
          return ApiState.error(error);
        },);

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) change response to list
        final kizukiValue = value['Value'];
        final kizukiList = awarenessKizukiListFromJson(
          kizukiValue as List<dynamic>,
        );

        // 2) save to hive with key
        final _kizukiMap = Map.fromIterables(
          kizukiList.map((e) => '${e.id}').toList(),
          kizukiList.map((e) => e).toList(),
        ); 

        // 3) save to hive with key
        await Boxes.getAwarenessKizukiModelBox().clear();
        await Boxes.getAwarenessKizukiModelBox().putAll(_kizukiMap);

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
    final response = await _api.patch('api/kizuki/$id', json);

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

  Future<ApiState> delete(AwarenessKizukiModel kizuki, String dt) async {

    final response = await _api.delete('api/kizuki/${kizuki.id}?timestamp=${kizuki.timeStamp}', '');

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

}
