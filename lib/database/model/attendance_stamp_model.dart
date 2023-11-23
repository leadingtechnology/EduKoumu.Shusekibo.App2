import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'attendance_stamp_model.freezed.dart';
part 'attendance_stamp_model.g.dart';

List<AttendanceStampModel> attendanceStampListFromJson(List<dynamic> data) =>
    List<AttendanceStampModel>.from(
      data.map((x) => AttendanceStampModel.fromJson(x as Map<String, dynamic>),
      ),);

AttendanceStampModel attendanceStampFromJson(String str) =>
AttendanceStampModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class AttendanceStampModel with _$AttendanceStampModel {
  @HiveType(typeId: 15, adapterName: 'AttendanceStampModelAdapter')
  const factory AttendanceStampModel({

    @JsonKey(name: 'ShukketsuJokyoCd', disallowNullValue: false) @HiveField(0) String? shukketsuJokyoCd,
    @JsonKey(name: 'ShukketsuBunrui', disallowNullValue: false) @HiveField(1) String? shukketsuBunrui,
    @JsonKey(name: 'ShukketsuKbn', disallowNullValue: false) @HiveField(2) String? shukketsuKbn,
    @JsonKey(name: 'ShukketsuJokyoNmSeishiki', disallowNullValue: false) @HiveField(3) String? shukketsuJokyoNmSeishiki,
    @JsonKey(name: 'ShukketsuJokyoNmRyaku', disallowNullValue: false) @HiveField(4) String? shukketsuJokyoNmRyaku,
    @JsonKey(name: 'ShukketsuJokyoNmTsu', disallowNullValue: false) @HiveField(5) String? shukketsuJokyoNmTsu,
    @JsonKey(name: 'ShukketsuJokyoKey', disallowNullValue: false) @HiveField(6) String? shukketsuJokyoKey,
  }) = _AttendanceStampModel;

  @override
  String toString() {
    return 'AttendanceStampModel($shukketsuJokyoCd, $shukketsuBunrui, $shukketsuKbn, $shukketsuJokyoNmSeishiki, $shukketsuJokyoNmRyaku, $shukketsuJokyoNmTsu, $shukketsuJokyoKey)';
  }
  factory AttendanceStampModel.fromJson(Map<String, dynamic> json) => _$AttendanceStampModelFromJson(json);
}
