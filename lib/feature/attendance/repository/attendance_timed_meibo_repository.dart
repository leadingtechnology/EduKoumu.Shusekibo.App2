import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_meibo_model.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

abstract class TimedRepositoryProtocol {
  Future<ApiState> fetch(FilterModel filter, DateTime targetDate);
  Future<ApiState> save(FilterModel filter);
}

final timedMeiboRepositoryProvider = Provider(
  TimedMeiboRepository.new,
);

class TimedMeiboRepository implements TimedRepositoryProtocol {
  TimedMeiboRepository(this.ref);

  final Ref ref;
  late final ApiProvider _api = ref.read(apiProvider);
  final box0 = Boxes.getAttendanceTimedMeibo();

  @override
  Future<ApiState> fetch(
    FilterModel filter,
    DateTime targetDate,
  ) async {
    await box0.clear();
    final strDate = DateUtil.getStringDate(targetDate);

    if (filter.classId == null ||
        filter.classId == 0 ||
        filter.jigenIdx == null) {
      return const ApiState.loaded();
    }

    var url = 'api/shozoku/${filter.classId}/JigenbetsuShussekibo';
    url = '$url?date=$strDate&kouryuGakkyu=${filter.kouryuGakkyu}';
    final response = await _api.get(url);

    response.when(
      success: (success) {},
      error: (error) {
        return ApiState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) change response to list
        final timedMeibo = attendanceTimedMeiboListFromJson(
          value as List<dynamic>,
        );

        // 2) change list to map
        final timedMeiboMap = timedMeibo.asMap();

        // set save button enable
        if (timedMeibo.isNotEmpty) {
          ref.read(buttonEnableProvider.notifier).state = true;
        } else {
          ref.read(buttonEnableProvider.notifier).state = false;
        }

        // 3) save to hive with key
        await box0.putAll(timedMeiboMap);

        return const ApiState.loaded();
      } catch (e) {
        return ApiState.error(
          AppException.errorWithMessage(e.toString()),
        );
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

    // 010) データの取得
    final meibos = box0.values.toList();
    if (meibos.isEmpty) {
      return const ApiState.loaded();
    }

    // 020) 対象外データの削除
    meibos.removeWhere((e) {
      var flg = true;
      try {
        final jokyo =
            e.jokyoList!.firstWhere((e) => e.jigenIdx == filter.jigenIdx);
        if (jokyo.jigenIdx == filter.jigenIdx) {
          flg = false;
        }
      } catch (ex) {
        flg = true;
      }
      return flg;
    });

    if (meibos.isEmpty) {
      return const ApiState.loaded();
    }

    // 030) jokyoList について　filter.jigenIdx に該当するデータのみを残す
    final newMeibos = <AttendanceTimedMeiboModel>[];
    for (final meibo in meibos) {
      final jokyo = meibo.jokyoList!.firstWhere((e) => e.jigenIdx == filter.jigenIdx);
      newMeibos.add(meibo.copyWith(jokyoList: [jokyo]));
    }

    // 040) 送信データの作成
    final json = jsonEncode(
      newMeibos.map((v) => v.toNewJson()).toList(),
    ); 

    final url =
        'api/shozoku/${filter.classId}/JigenbetsuShussekibo?date=$strDate';
    final response = await _api.post2(url, json);

    return response.when(
      success: (success) async {
        return const ApiState.loaded();
      },
      error: (error) {
        return ApiState.error(error);
      },
    );
  }
}
