import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/health/model/health_reason_model.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class HealthReasonRepositoryProtocol { 
  Future<ApiState> fetch(String jokyoCd, String kubun); 
}

final healthReasonRepositoryProvider = Provider(HealthReasonRepository.new);

class HealthReasonRepository implements HealthReasonRepositoryProtocol {
  HealthReasonRepository(this.ref);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> fetch(String jokyoCd, String kubun) async {

    // if box had saved the data. then return ok.
    // if (Boxes.getHealthReason1().values.isNotEmpty) {
    //   final keys = Boxes.getHealthReason1().keys.toList().where(
    //     (element) => element.toString().startsWith(jokyoCd),
    //   );
      
    //   if (keys.isNotEmpty ) return const ApiState.loaded();
    // }

    // jokyoCdが空の場合、正常終了
    if (jokyoCd.isEmpty) return const ApiState.loaded();

    // 理由マスタ理由
    final response = await _api.get('api/KenkouKansatsubo/reasons/$jokyoCd');

    response.when(
        success: (success) {},
        error: (error) {return ApiState.error(error);},);

    if (response is APISuccess) {
      final value = response.value;
      try {
        
        final reason1List = 
          (value['Reason1List'][0]['ReasonList'] as List<dynamic>)
          .map(
            (e) => HealthReasonModel
            .fromJson(Map<String, dynamic>.from(e as Map<dynamic, dynamic>),),)
          .toList();

        // _reason1ListのLengthが１以上の場合、空白の理由を追加する
        if (reason1List.isNotEmpty) {
          reason1List.insert(
              0,
              HealthReasonModel(
                jokyoCd: jokyoCd,
                jiyuCd: '',
                jiyuNmSeishiki: '',
                jiyuNmRyaku: '',
                kenkoFlg: false,
                delFlg: false,
              ),);
        }

        // Reason1
        final reason1Map = Map.fromIterables(
          reason1List.map((e) => e.getKey()).toList(),
          reason1List.map((e) => e).toList(),
        );
        
        await Boxes.getHealthReason1().putAll(reason1Map);

        if (kubun == '403') {
          final reason2List = 
            healthReasonListFromJson(
              value['Reason2List'][0]['ReasonList'] as List<dynamic>,
            );

          // _reason1ListのLengthが１以上の場合、空白の理由を追加する
          if (reason2List.isNotEmpty) {
            reason2List.insert(
                0,
                HealthReasonModel(
                  jokyoCd: jokyoCd,
                  jiyuCd: '',
                  jiyuNmSeishiki: '',
                  jiyuNmRyaku: '',
                  kenkoFlg: false,
                  delFlg: false,
                ),);
          }

          final reason2Map = Map.fromIterables(
            reason2List.map((e) => e.getKey()).toList(),
            reason2List.map((e) => e).toList(),
          );
          await Boxes.getHealthReason2().putAll(reason2Map);
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
