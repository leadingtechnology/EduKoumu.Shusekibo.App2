import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_reason_model.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

abstract class AttendanceReasonRepositoryProtocol { 
  Future<ApiState> fetch(String jokyoCd, String shukketsuKbn); 
}

final attendanceReasonRepositoryProvider = Provider(AttendanceReasonRepository.new);

class AttendanceReasonRepository implements AttendanceReasonRepositoryProtocol {
  AttendanceReasonRepository(this.ref,);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> fetch(String jokyoCd, String shukketsuKbn) async {

    // jokyoCdが空の場合、正常終了
    if (jokyoCd.isEmpty) return const ApiState.loaded();    

    // if box had saved the data. then return ok.
    if (Boxes.getAttendanceReason1().values.isNotEmpty) {
      final keys = Boxes.getAttendanceReason1().keys.toList().where(
        (element) => element.toString().startsWith('$jokyoCd-'),
      );
      
      if (keys.isNotEmpty ) return const ApiState.loaded();
    }

    final response = await _api.get('api/ShukketsuShussekibo/reasons/$jokyoCd');

    response.when(
        success: (success) {},
        error: (error) {return ApiState.error(error);}
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        // ['JiyuList']
        final v1 = value['JiyuList'];
        final reasonList = attendanceReasonListFromJson(v1 as List<dynamic>);

        // _reason1ListのLengthが１以上の場合、空白の理由を追加する
        if (reasonList.isNotEmpty) {
          reasonList.insert(
              0,
              AttendanceReasonModel(
                shukketsuJokyoCd: jokyoCd,
                shukketsuJiyuCd: '',
                hyoujijun: '0',
                shukketsuJiyuNmRyaku: '',
                shukketsuJiyuNmSeishiki: '',
              ),);
        }

        // Reason1
        final reasonMap = Map.fromIterables(
          reasonList.map((e) => '$jokyoCd-${e.shukketsuJiyuCd}').toList(),
          reasonList.map((e) => e).toList(),
        );
        
        await Boxes.getAttendanceReason1().putAll(reasonMap);
        // Reason2
        if (shukketsuKbn == '403') {
          await Boxes.getAttendanceReason2().putAll(reasonMap);
        }

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
