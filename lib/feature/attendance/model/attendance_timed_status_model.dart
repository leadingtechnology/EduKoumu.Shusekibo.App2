import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'attendance_timed_status_model.freezed.dart';
part 'attendance_timed_status_model.g.dart';

List<AttendanceTimedStatusModel> attendanceTimedStatusListFromJson(List<dynamic> data) =>
    List<AttendanceTimedStatusModel>.from(data.map((x) => 
    AttendanceTimedStatusModel.fromJson(x as Map<String, dynamic>),),);

AttendanceTimedStatusModel attendanceTimedStatusFromJson(String str) => 
AttendanceTimedStatusModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class AttendanceTimedStatusModel with _$AttendanceTimedStatusModel {
  @HiveType(typeId: 27, adapterName: 'AttendanceTimedStatusModelAdapter')
  const factory AttendanceTimedStatusModel({

    @JsonKey(name: 'Date', disallowNullValue: false) @HiveField(0) DateTime? jokyoDate,
    @JsonKey(name: 'JigenIdx', disallowNullValue: false) @HiveField(1) int? jigenIdx,
    @JsonKey(name: 'Ryaku', disallowNullValue: false) @HiveField(2) String? ryaku,
    @JsonKey(name: 'ShukketsuBunrui', disallowNullValue: false) @HiveField(3) String? shukketsuBunrui,
    @JsonKey(name: 'ShukketsuKbn', disallowNullValue: false) @HiveField(4) String? shukketsuKbn,
    @JsonKey(name: 'Jiyu1', disallowNullValue: false) @HiveField(5) String? jiyu1,
    @JsonKey(name: 'Jiyu2', disallowNullValue: false) @HiveField(6) String? jiyu2,
    @JsonKey(name: 'IsEditable', disallowNullValue: false) @HiveField(7) bool? isEditable,
  }) = _AttendanceTimedStatusModel;

  @override
  String toString() {
    return 'AttendanceTimedStatusModel($jokyoDate, $jigenIdx, $ryaku, $shukketsuBunrui, $shukketsuKbn, $jiyu1, $jiyu2, $isEditable)';
  }
  factory AttendanceTimedStatusModel.fromJson(Map<String, dynamic> json) => _$AttendanceTimedStatusModelFromJson(json);
}

extension NewJson on AttendanceTimedStatusModel {
  Map<String, dynamic> toNewJson() => {
        'JigenIdx': jigenIdx,
        'ShukketsuBunrui': shukketsuBunrui,
        'ShukketsuKbn': shukketsuKbn,
        'Jiyu1': jiyu1,
        'Jiyu2': jiyu2,
      };
}
