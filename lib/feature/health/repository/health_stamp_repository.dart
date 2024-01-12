import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/health/model/health_stamp_model.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class HealthStampRepositoryProtocol { Future<ApiState> fetch(); }

final healthStampRepositoryProvider = Provider(HealthStampRepository.new);

class HealthStampRepository implements HealthStampRepositoryProtocol {
  HealthStampRepository(this.ref);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> fetch() async {

    // box にデータがあれば、それを返す
    // final registStampBox = Boxes.getRegistHealthStamp();
    // final unregistStampBox = Boxes.getUnregistHealthStamp();
    // if (registStampBox.isNotEmpty && unregistStampBox.isNotEmpty) {
    //   return const ApiState.loaded();
    // }

    final response = await _api.get('api/KenkouKansatsubo/stamps');

    response.when(
        success: (success) {},
        error: (error) {return ApiState.error(error);});

    if (response is APISuccess) {
      final value = response.value;
      try {
        // Regist Stamp
        final reg = value['RegistStampList'];
        final registStampList = healthStampListFromJson(reg as List<dynamic>);

        // Add 2 stamps
        const handStamp = HealthStampModel(
          jokyoCd: '001', 
          jokyoNmRyaku: '(未選択)', 
          jokyoKey : '', 
          jokyoNmTsu: '(未選択)',
        );
        const delStamp = HealthStampModel(
          jokyoCd: '999', 
          jokyoNmRyaku: 'クリア', 
          jokyoKey: 'Delete', 
          jokyoNmTsu: 'クリア',
        );
        
        registStampList
          ..insert(0, handStamp)
          ..add(delStamp);


        final registStampMap = Map.fromIterables(
          registStampList.map((e) => e.jokyoCd).toList(),
          registStampList.map((e) => e).toList(),
        );
        await Boxes.getRegistHealthStamp().putAll(registStampMap);

        // Unregist Stamp
        final unr = value['UnregistStampList'];
        final unregistStampList = healthStampListFromJson(unr as List<dynamic>);
        
        final unregistStampMap = Map.fromIterables(
          unregistStampList.map((e) => e.jokyoCd).toList(),
          unregistStampList.map((e) => e).toList(),
        );
        await Boxes.getUnregistHealthStamp().putAll(unregistStampMap);
    
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
