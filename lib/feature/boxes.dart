import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_stamp_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_status_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_stamp_model.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_code_model.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_kizuki_model.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_meibo_model.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/model/tannin_model.dart';
import 'package:kyoumutechou/feature/common/model/tenpu_model.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/model/tokobi_model.dart';
import 'package:kyoumutechou/feature/health/model/health_meibo_model.dart';
import 'package:kyoumutechou/feature/health/model/health_reason_model.dart';
import 'package:kyoumutechou/feature/health/model/health_stamp_model.dart';
import 'package:kyoumutechou/feature/seat/model/seat_chart_model.dart';
import 'package:kyoumutechou/feature/seat/model/seat_setting_model.dart';

class Boxes {
  static Box<String> getBox() => Hive.box<String>('shusekibo');

  // common
  static Box<DantaiModel> getDantais() => Hive.box<DantaiModel>('Dantai');
  static Box<GakunenModel> getGakunens() => Hive.box<GakunenModel>('Gakunen');
  static Box<ShozokuModel> getShozokus() => Hive.box<ShozokuModel>('Shozoku');
  static Box<TokobiModel> getTokobis() => Hive.box<TokobiModel>('Tokobi');
  static Box<TanninModel> getTannin() => Hive.box<TanninModel>('Tannin');

  // Health
  static Box<HealthStampModel> getRegistHealthStamp() =>
      Hive.box<HealthStampModel>('RegistHealthStamp');
  static Box<HealthStampModel> getUnregistHealthStamp() =>
      Hive.box<HealthStampModel>('UnregistHealthStamp');
  //
  static Box<bool> getHealthReason() => Hive.box<bool>('HealthReason');
  static Box<HealthReasonModel> getHealthReason1() =>
      Hive.box<HealthReasonModel>('HealthReason1');
  static Box<HealthReasonModel> getHealthReason2() =>
      Hive.box<HealthReasonModel>('HealthReason2');
  //
  static Box<HealthMeiboModel> getHealthMeiboBox() =>
      Hive.box<HealthMeiboModel>('HealthMeibo');
  static Box<HealthMeiboModel> getHealthMeiboBox1() =>
      Hive.box<HealthMeiboModel>('HealthMeibo1');
  static Box<HealthMeiboModel> getHealthMeiboBox2() =>
      Hive.box<HealthMeiboModel>('HealthMeibo2');
  // attendance
  static Box<AttendanceStampModel> getRegistAttendanceStamp() =>
      Hive.box<AttendanceStampModel>('RegistAttendanceStamp');
  static Box<AttendanceStampModel> getUnregistAttendanceStamp() =>
      Hive.box<AttendanceStampModel>('UnregistAttendanceStamp');
  static Box<bool> getAttendanceReason() => Hive.box<bool>('AttendanceReason');
  static Box<AttendanceReasonModel> getAttendanceReason1() =>
      Hive.box('AttendanceReason1');
  static Box<AttendanceReasonModel> getAttendanceReason2() =>
      Hive.box('AttendanceReason2');

  static Box<AttendanceStatusModel> getAttendanceStatus() =>
      Hive.box<AttendanceStatusModel>('AttendanceStatusModel');
  static Box<AttendanceMeiboModel> getAttendanceMeibo() =>
      Hive.box<AttendanceMeiboModel>('AttendanceMeibo');
  static Box<AttendanceMeiboModel> getAttendanceMeibo1() =>
      Hive.box<AttendanceMeiboModel>('AttendanceMeibo1');
  static Box<AttendanceMeiboModel> getAttendanceMeibo2() =>
      Hive.box<AttendanceMeiboModel>('AttendanceMeibo2');


  static Box<TimedModel> getTimeds() => Hive.box<TimedModel>('Timed');
  static Box<AttendanceTimedMeiboModel> getAttendanceTimedMeibo() =>
      Hive.box<AttendanceTimedMeiboModel>('AttendanceTimedMeibo');
  static Box<AttendanceTimedMeiboModel> getAttendanceTimedMeibo1() =>
      Hive.box<AttendanceTimedMeiboModel>('AttendanceTimedMeibo1');
  static Box<AttendanceTimedMeiboModel> getAttendanceTimedMeibo2() =>
      Hive.box<AttendanceTimedMeiboModel>('AttendanceTimedMeibo2');

  static Box<AttendanceTimedStampModel> getRegistAttendanceTimedStampBox() =>
      Hive.box<AttendanceTimedStampModel>('RegistAttendanceTimedStamp');
  static Box<AttendanceTimedStampModel> getUnregistAttendanceTimedStampBox() =>
      Hive.box<AttendanceTimedStampModel>('UnregistAttendanceTimedStamp');
  static Box<AttendanceTimedReasonModel> getAttendanceTimedReason1() =>
      Hive.box('AttendanceTimedReason1');
  static Box<AttendanceTimedReasonModel> getAttendanceTimedReason2() =>
      Hive.box('AttendanceTimedReason2');

  // awareness
  static Box<AwarenessMeiboModel> getAwarenessMeiboBox() =>
      Hive.box<AwarenessMeiboModel>('AwarenessMeibo');
  static Box<AwarenessKizukiModel> getAwarenessKizukiModelBox() =>
      Hive.box<AwarenessKizukiModel>('AwarenessKizuki');
  static Box<TenpuModel> getTenpuBox() => Hive.box<TenpuModel>('Tenpu');
  static Box<String> getImageUrl() => Hive.box<String>('ImageUrl');
  static Box<AwarenessCodeModel> getBunruiBox() =>
      Hive.box<AwarenessCodeModel>('bunrui');

  // setting
  static Box<SeatSettingModel> getSeatSetting() =>
      Hive.box<SeatSettingModel>('SeatSetting');

  // seat chart
  static Box<SeatChartModel> getSeatChart() =>
      Hive.box<SeatChartModel>('SeatChart');
}


List<DateTime> getFilteredTokobiDates(DateTime targetDate) {
  final box = Boxes.getTokobis();

  final inputDate = DateTime(targetDate.year, targetDate.month, targetDate.day);

  // 対象日付より前の登校日データを取得する
  final filteredList = box.values
      .where((e) =>
          e.isEditable! == true && e.tokobi!.isBefore(inputDate),) 
      .toList(); 

  // 登校日データを降順に並び替える
  filteredList.sort((a, b) => b.tokobi!.compareTo(a.tokobi!));

  
  final result = <DateTime>[inputDate];
  for (var i = 0; i < 2; i++) {
    if (filteredList[i].tokobi != null){
      result.add(filteredList[i].tokobi!);
    }
  }

  result.sort((a, b) => b.compareTo(a));

  return result;
}
