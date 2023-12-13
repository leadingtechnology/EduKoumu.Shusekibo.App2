import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

abstract class AttendanceRepositoryProtocol {
  Future<ApiState> fetch(FilterModel filter);
  Future<ApiState> save(FilterModel filter);
}

final attendanceMeiboRepositoryProvider = Provider(
  AttendanceMeiboRepository.new,
);

class AttendanceMeiboRepository implements AttendanceRepositoryProtocol {
  AttendanceMeiboRepository(this.ref);

  final Ref ref;
  late final ApiProvider _api = ref.read(apiProvider);

  @override
  Future<ApiState> fetch(FilterModel filter) async {

    final strDate = DateUtil.getStringDate(filter.targetDate ?? DateTime.now());

    if (filter.classId == null || filter.classId == 0) {
      return const ApiState.loaded();
    }

    var url =  'api/shozoku/${filter.classId}/ShukketsuShussekibo';
    url = '$url?date=$strDate&kouryuGakkyu=${filter.kouryuGakkyu}';
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
        final attendanceMeiboList = attendanceMeiboListFromJson(
          value as List<dynamic>,
        );

        // 2) change list to map
        final attendanceMeiboMap = attendanceMeiboList.asMap();

        // 3) save to hive with key
        await Boxes.getAttendanceMeibo().clear();
        await Boxes.getAttendanceMeibo().putAll(attendanceMeiboMap);

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

    final meibos = Boxes.getAttendanceMeibo().values.toList();
    final json = jsonEncode(
      meibos.map((v) => v.toNewJson()).toList(),
    ); //jsonEncode(meibos.map((i) => i.toJson()).toList()).toString();

    final url = 'api/shozoku/${filter.classId}/ShukketsuShussekibo?date=$strDate';
    final response = await _api.post2(url, json);

    return response.when(success: (success) async {

      return const ApiState.loaded();
    }, error: (error) {
      return ApiState.error(error);
    });
  }  

}
