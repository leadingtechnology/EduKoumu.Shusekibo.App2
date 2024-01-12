import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_stamp_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_stamp_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class AttendanceStampRepositoryProtocol { 
  Future<ApiState> fetch(); 
}

final attendanceStampRepositoryProvider = 
  Provider(AttendanceStampRepository.new);

class AttendanceStampRepository implements AttendanceStampRepositoryProtocol {
  AttendanceStampRepository(this.ref);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> fetch() async {

    // box にデータがあれば、それを返す
    // final registStampBox = Boxes.getRegistAttendanceStamp();
    // final unregistStampBox = Boxes.getUnregistAttendanceStamp();
    // if (registStampBox.isNotEmpty && unregistStampBox.isNotEmpty) {
    //   return const ApiState.loaded();
    // }

    final response = await _api.get('api/ShukketsuShussekibo/stamps');

    response.when(
        success: (success) {},
        error: (error) {return ApiState.error(error);},
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) Regist Stamp // value['RegistStampList']
        final registValue = value['RegistStampList'];
        final registStampList = attendanceStampListFromJson(
          registValue as List<dynamic>,
        );
        
        // Add 2 stamps
        const handStamp = AttendanceStampModel(
            shukketsuJokyoCd: '001',
            shukketsuJokyoNmRyaku: '(未選択)',
            shukketsuJokyoKey: '',
            shukketsuJokyoNmTsu: '(未選択)',
            );
        const delStamp = AttendanceStampModel(
            shukketsuJokyoCd: '999',
            shukketsuJokyoNmRyaku: 'クリア',
            shukketsuJokyoKey: 'Delete',
            shukketsuJokyoNmTsu: 'クリア',
            );

        registStampList
        ..insert(0, handStamp)
        ..add(delStamp);

        final registStampMap = Map.fromIterables(
          registStampList.map((e) => e.shukketsuJokyoCd).toList(),
          registStampList.map((e) => e).toList(),
        );

        await Boxes.getRegistAttendanceStamp().putAll(registStampMap);
        ref.read(attendanceStampProvider.notifier).state=registStampList.first;

        // 2) Unregist Stamp  // value['UnregistStampList']
        final unregistValue = value['UnregistStampList'];
        final unregistStampList = attendanceStampListFromJson(
          unregistValue as List<dynamic>,
        );

        final unregistStampMap = Map.fromIterables(
          unregistStampList.map((e) => e.shukketsuJokyoCd).toList(),
          unregistStampList.map((e) => e).toList(),
        );
        await Boxes.getUnregistAttendanceStamp().putAll(unregistStampMap);

        return const ApiState.loaded();
      } catch (e) {
        return ApiState.error(
            AppException.errorWithMessage(e.toString()),);
      }
    } else if (response is APIError) {
      return ApiState.error(response.exception);
    } else {
      return const ApiState.loading();
    }
  }
}
