import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

abstract class AttendanceMeiboRepositoryProtocol {
  Future<ApiState> fetchAttendanceMeiboList();
}

final attendanceMeiboRepositoryProvider =
    Provider(AttendanceMeiboRepository.new);

class AttendanceMeiboRepository implements AttendanceMeiboRepositoryProtocol {
  AttendanceMeiboRepository(this.ref);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> fetchAttendanceMeiboList() async {
    final filter = ref.read(filterProvider);

    final strDate = DateFormat('yyyy-MM-dd').format(filter.targetDate?? DateTime.now()).toString();

    if (filter.classId == null) {
      return const ApiState.loading();
    }

    final String url =  'api/shozoku/${filter.classId}/ShukketsuShussekibo?date=${strDate}&kouryuGakkyu=${filter.kouryuGakkyu}';
    final response = await _api.get(url);
    
    response.when(
        success: (success) {},
        error: (error) {
          return ApiState.error(error);
        });

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) change response to list
        final _attendanceMeiboList = attendanceMeiboListFromJson(value as List<dynamic>);

        // 2) change list to map
        final Map<int, AttendanceMeiboModel>  _attendanceMeiboMap = _attendanceMeiboList.asMap();

        // 3) save to hive with key
        await Boxes.getAttendanceMeiboModelBox().clear();
        await Boxes.getAttendanceMeiboModelBox().putAll(_attendanceMeiboMap);

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
    
    final String strDate = DateFormat('yyyy-MM-dd').format(filter.targetDate ?? DateTime.now()).toString();

    List<AttendanceMeiboModel> meibos = Boxes.getAttendanceMeiboModelBox().values.toList();
    String json = jsonEncode(meibos.map((v) => v.toNewJson()).toList()); //jsonEncode(meibos.map((i) => i.toJson()).toList()).toString();

    final response = await _api.post2('api/shozoku/${filter.classId}/ShukketsuShussekibo?date=${strDate}', json);

    return response.when(success: (success) async {

      return const ApiState.loaded();
    }, error: (error) {
      return ApiState.error(error);
    });
  }  

}
