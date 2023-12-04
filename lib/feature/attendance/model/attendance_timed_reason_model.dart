import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'attendance_timed_reason_model.freezed.dart';
part 'attendance_timed_reason_model.g.dart';

List<AttendanceTimedReasonModel> attendanceTimedReasonListFromJson(List<dynamic> data) =>
    List<AttendanceTimedReasonModel>.from(data.map((x) => 
    AttendanceTimedReasonModel.fromJson(x as Map<String, dynamic>),),);

AttendanceTimedReasonModel attendanceTimedReasonFromJson(String str) => 
AttendanceTimedReasonModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class AttendanceTimedReasonModel with _$AttendanceTimedReasonModel {
  @HiveType(typeId: 26, adapterName: 'AttendanceTimedReasonModelAdapter')
  const factory AttendanceTimedReasonModel({

    @JsonKey(name: 'ShukketsuJokyoCd', disallowNullValue: false) @HiveField(0) String? shukketsuJokyoCd,
    @JsonKey(name: 'ShukketsuJiyuCd', disallowNullValue: false) @HiveField(1) String? shukketsuJiyuCd,
    @JsonKey(name: 'Hyoujijun', disallowNullValue: false) @HiveField(2) String? hyoujijun,
    @JsonKey(name: 'ShukketsuJiyuNmSeishiki', disallowNullValue: false) @HiveField(3) String? shukketsuJiyuNmSeishiki,
    @JsonKey(name: 'ShukketsuJiyuNmRyaku', disallowNullValue: false) @HiveField(4) String? shukketsuJiyuNmRyaku,
  }) = _AttendanceTimedReasonModel;

  @override
  String toString() {
    return 'AttendanceTimedReasonModel($shukketsuJokyoCd, $shukketsuJiyuCd, $hyoujijun, $shukketsuJiyuNmSeishiki, $shukketsuJiyuNmRyaku)';
  }
  factory AttendanceTimedReasonModel.fromJson(Map<String, dynamic> json) => _$AttendanceTimedReasonModelFromJson(json);
}


extension NewMethod on AttendanceTimedReasonModel {
  String getKey() {
    return '$shukketsuJokyoCd$shukketsuJiyuCd';
  }
}
