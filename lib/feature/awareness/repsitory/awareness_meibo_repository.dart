import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_meibo_model.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

abstract class AwarenessMeiboRepositoryProtocol { 
  Future<ApiState> fetchAwarenessMeibo(); 
  Future<ApiState> save(String json);
}

final awarenessMeiboRepositoryProvider = Provider(
  AwarenessMeiboRepository.new,
);

class AwarenessMeiboRepository implements AwarenessMeiboRepositoryProtocol {
  AwarenessMeiboRepository(this.ref);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> fetchAwarenessMeibo() async {
    final filter = ref.read(filterProvider);

    if (filter.classId == null) {
      return const ApiState.loading();
    }

    final response = await _api.get('api/shozoku/${filter.classId}/kizuki');

    response.when(
        success: (success) {},
        error: (error) {return ApiState.error(error);},
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) change response to list
        final meiboList = awarenessMeiboListFromJson(value as List<dynamic>);

        // 2) change list to map
        final meiboMap = meiboList.asMap();


        // 3) save to hive with key
        await Boxes.getAwarenessMeiboBox().clear();
        await Boxes.getAwarenessMeiboBox().putAll(meiboMap);

        return const ApiState.loaded();
      } catch (e) {
        return ApiState.error(
            AppException.errorWithMessage(e.toString(),),);
      }
    } else if (response is APIError) {
      return ApiState.error(response.exception);
    } else {
      return const ApiState.loading();
    }
  }

  @override
  Future<ApiState> save(String json) async {
    final box = Boxes.getAwarenessMeiboBox();
    
    final response = await _api.post2('api/kizuki', json);

    if (response is APISuccess) {
      final value = response.value as List;
      try {
        // 1) change response to list
        final meibos = awarenessMeiboListFromJson(value);

        // 2) save to hive with key
        final studentList = box.values.toList().where(
          (e) => e.selectFlag ?? false,
        ).toList();
        
        for (final m in studentList){
          final meibo = meibos.where((e) => e.studentId == m.studentId).first;
          if (meibo.kizukiCount == null || meibo.kizukiCount! <= 0) {
            continue;
          }
          final meibo2 = AwarenessMeiboModel(
            gakunen: meibo.gakunen,
            shozokuId: meibo.shozokuId,
            className: meibo.className,
            shussekiNo: meibo.shussekiNo,
            studentId: meibo.studentId,
            studentName: meibo.studentName,
            photoUrl: meibo.photoUrl,
            genderCode: meibo.genderCode,
            kizukiCount: meibo.kizukiCount,
            selectFlag: false,
            changedFlag: true,
          );

          final index = box.keys
              .firstWhere(
                (k) => box.getAt(k as int)?.studentId == meibo.studentId,
              );
          await Boxes.getAwarenessMeiboBox().put(index, meibo2);
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
}
