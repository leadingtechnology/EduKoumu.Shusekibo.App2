import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'attendance_timed_stamp_model.freezed.dart';
part 'attendance_timed_stamp_model.g.dart';

List<AttendanceTimedStampModel> attendanceTimedStampListFromJson(List<dynamic> data) =>
    List<AttendanceTimedStampModel>.from(data.map((x) => 
    AttendanceTimedStampModel.fromJson(x as Map<String, dynamic>),),);

AttendanceTimedStampModel attendanceTimedStampFromJson(String str) => 
AttendanceTimedStampModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class AttendanceTimedStampModel with _$AttendanceTimedStampModel {
  @HiveType(typeId: 25, adapterName: 'AttendanceTimedStampModelAdapter')
  const factory AttendanceTimedStampModel({

    @JsonKey(name: 'ShukketsuJokyoCd', disallowNullValue: false) @HiveField(0) String? shukketsuJokyoCd,
    @JsonKey(name: 'ShukketsuBunrui', disallowNullValue: false) @HiveField(1) String? shukketsuBunrui,
    @JsonKey(name: 'ShukketsuKbn', disallowNullValue: false) @HiveField(2) String? shukketsuKbn,
    @JsonKey(name: 'ShukketsuJokyoNmSeishiki', disallowNullValue: false) @HiveField(3) String? shukketsuJokyoNmSeishiki,
    @JsonKey(name: 'ShukketsuJokyoNmRyaku', disallowNullValue: false) @HiveField(4) String? shukketsuJokyoNmRyaku,
    @JsonKey(name: 'ShukketsuJokyoNmTsu', disallowNullValue: false) @HiveField(5) String? shukketsuJokyoNmTsu,
    @JsonKey(name: 'ShukketsuJokyoKey', disallowNullValue: false) @HiveField(6) String? shukketsuJokyoKey,
  }) = _AttendanceTimedStampModel;

  @override
  String toString() {
    return 'AttendanceTimedStampModel($shukketsuJokyoCd, $shukketsuBunrui, $shukketsuKbn, $shukketsuJokyoNmSeishiki, $shukketsuJokyoNmRyaku, $shukketsuJokyoNmTsu, $shukketsuJokyoKey)';
  }
  factory AttendanceTimedStampModel.fromJson(Map<String, dynamic> json) => _$AttendanceTimedStampModelFromJson(json);
}
