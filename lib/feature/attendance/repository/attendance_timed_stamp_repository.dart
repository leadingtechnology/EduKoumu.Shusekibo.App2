import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_stamp_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_timed_stamp_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

abstract class AttendanceTimedStampRepositoryProtocol { Future<ApiState> fetchAttendanceTimedStamp(); }

final attendanceTimedStampRepositoryProvider = Provider((ref) => AttendanceTimedStampRepository(ref));

class AttendanceTimedStampRepository implements AttendanceTimedStampRepositoryProtocol {
  AttendanceTimedStampRepository(this.ref);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> fetchAttendanceTimedStamp() async {
    //final ShozokuModel shozoku = _watch(attendanceTimedShozokuProvider);
    
    final response = await _api.get('api/ShukketsuShussekibo/stamps');

    response.when(
        success: (success) {},
        error: (error) {return ApiState.error(error);}
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) Regist Stamp // value['RegistStampList']
        final List<AttendanceTimedStampModel> _registStampList = attendanceTimedStampListFromJson(value as List<dynamic>);
        
        // Add 2 stamps
        final handStamp = AttendanceTimedStampModel(shukketsuJokyoCd: '001', shukketsuJokyoNmRyaku: '(未選択)', shukketsuJokyoKey: '');
        final delStamp = AttendanceTimedStampModel(shukketsuJokyoCd: '999', shukketsuJokyoNmRyaku: 'クリア', shukketsuJokyoKey: 'Delete');
        _registStampList.insert(0, handStamp);
        _registStampList.add(delStamp);

        final _registStampMap = Map.fromIterables(
          _registStampList.map((e) => e.shukketsuJokyoCd).toList(),
          _registStampList.map((e) => e).toList(),
        );

        await Boxes.getRegistAttendanceTimedStampBox().putAll(_registStampMap);
        ref.read(attendanceTimedStampProvider.notifier).state = _registStampList.first;

        // 2) Unregist Stamp // value['UnregistStampList']
        final List<AttendanceTimedStampModel> _unregistStampList = attendanceTimedStampListFromJson(value as List<dynamic>);        
        final _unregistStampMap = Map.fromIterables(
          _unregistStampList.map((e) => e.shukketsuJokyoCd).toList(),
          _unregistStampList.map((e) => e).toList(),
        );
        await Boxes.getUnregistAttendanceTimedStampBox().putAll(_unregistStampMap);

        return const ApiState.loaded();
      } catch (e) {
        return ApiState.error(
            AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return ApiState.error(response.exception);
    } else {
      return const ApiState.loading();
    }
  }
}
