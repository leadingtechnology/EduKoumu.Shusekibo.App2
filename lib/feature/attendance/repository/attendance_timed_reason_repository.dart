import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_stamp_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_timed_stamp_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// abstract class AttendanceTimedReasonRepositoryProtocol { Future<ApiState> fetch(); }

// final attendanceTimedReasonRepositoryProvider = Provider((ref) => AttendanceTimedReasonRepository(ref));

// class AttendanceTimedReasonRepository implements AttendanceTimedReasonRepositoryProtocol {
//   AttendanceTimedReasonRepository(this.ref);

//   late final ApiProvider _api = ref.read(apiProvider);
//   final Ref ref;

//   @override
//   Future<ApiState> fetch() async {
//     final AttendanceTimedStampModel stamp = ref.read(attendanceTimedStampProvider);

//     // if box had saved the data. then return ok.
//     if (Boxes.getAttendanceTimedReason1().values.length > 0) {
//       Iterable keys = Boxes.getAttendanceTimedReason1().keys.toList().where(
//         (element) => element.toString().startsWith('${stamp.shukketsuJokyoCd}'),
//       );
      
//       if (keys.length > 0 ) return ApiState.loaded();
//     }

//     final response = await _api.get('api/ShukketsuShussekibo/reasons/${stamp.shukketsuJokyoCd}');

//     response.when(
//         success: (success) {},
//         error: (error) {return ApiState.error(error);}
//     );

//     if (response is APISuccess) {
//       final value = response.value;
//       try {
//         // value['JiyuList']
//         final List<AttendanceTimedReasonModel> _reasonList = attendanceTimedReasonListFromJson(value as List<dynamic>);

//         // _reason1ListのLengthが１以上の場合、空白の理由を追加する
//         if (_reasonList.length > 0) {
//           _reasonList.insert(
//               0,
//               AttendanceTimedReasonModel(
//                 shukketsuJokyoCd: stamp.shukketsuJokyoCd,
//                 shukketsuJiyuCd: '',
//                 hyoujijun: '0',
//                 shukketsuJiyuNmRyaku: '',
//                 shukketsuJiyuNmSeishiki: '',
//               ));
//         }

//         // Reason1
//         final _reasonMap = Map.fromIterables(
//           _reasonList.map((e) => e.getKey()).toList(),
//           _reasonList.map((e) => e).toList(),
//         );

//         await Boxes.getAttendanceTimedReason1().putAll(_reasonMap);
//         // Reason2
//         if (stamp.shukketsuJokyoCd == '430') {
//           await Boxes.getAttendanceTimedReason2().putAll(_reasonMap);
//         }

//         return ApiState.loaded();
//       } catch (e) {
//         return ApiState.error(
//             AppException.errorWithMessage(e.toString()));
//       }
//     } else if (response is APIError) {
//       return ApiState.error(response.exception);
//     } else {
//       return const ApiState.loading();
//     }
//   }
// }
