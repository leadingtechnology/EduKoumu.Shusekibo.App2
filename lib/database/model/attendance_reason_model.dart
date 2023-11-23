import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'attendance_reason_model.freezed.dart';
part 'attendance_reason_model.g.dart';

List<AttendanceReasonModel> attendanceReasonListFromJson(List<dynamic> data) =>
    List<AttendanceReasonModel>.from(
      data.map((x) => AttendanceReasonModel.fromJson(x as Map<String, dynamic>),
      ),);

AttendanceReasonModel attendanceReasonFromJson(String str) => 
AttendanceReasonModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class AttendanceReasonModel with _$AttendanceReasonModel {
  @HiveType(typeId: 16, adapterName: 'AttendanceReasonModelAdapter')
  const factory AttendanceReasonModel({

    @JsonKey(name: 'ShukketsuJokyoCd', disallowNullValue: false) @HiveField(0) String? shukketsuJokyoCd,
    @JsonKey(name: 'ShukketsuJiyuCd', disallowNullValue: false) @HiveField(1) String? shukketsuJiyuCd,
    @JsonKey(name: 'Hyoujijun', disallowNullValue: false) @HiveField(2) String? hyoujijun,
    @JsonKey(name: 'ShukketsuJiyuNmSeishiki', disallowNullValue: false) @HiveField(3) String? shukketsuJiyuNmSeishiki,
    @JsonKey(name: 'ShukketsuJiyuNmRyaku', disallowNullValue: false) @HiveField(4) String? shukketsuJiyuNmRyaku,
  }) = _AttendanceReasonModel;

  @override
  String toString() {
    return 'AttendanceReasonModel($shukketsuJokyoCd, $shukketsuJiyuCd, $hyoujijun, $shukketsuJiyuNmSeishiki, $shukketsuJiyuNmRyaku)';
  }
  factory AttendanceReasonModel.fromJson(Map<String, dynamic> json) => _$AttendanceReasonModelFromJson(json);
}
extension NewMethod on AttendanceReasonModel {
  String getKey(){
    return '$shukketsuJokyoCd$shukketsuJiyuCd';
  }
}
