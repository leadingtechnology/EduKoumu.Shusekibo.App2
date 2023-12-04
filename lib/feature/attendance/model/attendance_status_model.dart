import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'attendance_status_model.freezed.dart';
part 'attendance_status_model.g.dart';

List<AttendanceStatusModel> attendanceStatusListFromJson(List<dynamic> data) =>
    List<AttendanceStatusModel>.from(data.map((x) => 
    AttendanceStatusModel.fromJson(x as Map<String, dynamic>),),);

AttendanceStatusModel attendanceStatusFromJson(String str) => 
AttendanceStatusModel.fromJson(json.decode(str) as Map<String, dynamic>);



@freezed
abstract class AttendanceStatusModel with _$AttendanceStatusModel {
  @HiveType(typeId: 17, adapterName: 'AttendanceStatusModelAdapter')
  const factory AttendanceStatusModel({

    @JsonKey(name: 'Date', disallowNullValue: false) @HiveField(0) DateTime? jokyoDate,
    @JsonKey(name: 'JigenIdx', disallowNullValue: false) @HiveField(1) int? jigenIdx,
    @JsonKey(name: 'Ryaku', disallowNullValue: false) @HiveField(2) String? ryaku,
    @JsonKey(name: 'ShukketsuBunrui', disallowNullValue: false) @HiveField(3) String? shukketsuBunrui,
    @JsonKey(name: 'ShukketsuKbn', disallowNullValue: false) @HiveField(4) String? shukketsuKbn,
    @JsonKey(name: 'Jiyu1', disallowNullValue: false) @HiveField(5) String? jiyu1,
    @JsonKey(name: 'Jiyu2', disallowNullValue: false) @HiveField(6) String? jiyu2,
    @JsonKey(name: 'IsEditable', disallowNullValue: false) @HiveField(7) bool? isEditable,
  }) = _AttendanceStatusModel;

  @override
  String toString() {
    return 'AttendanceStatusModel($jokyoDate, $jigenIdx, $ryaku, $shukketsuBunrui, $shukketsuKbn, $jiyu1, $jiyu2, $isEditable)';
  }
  factory AttendanceStatusModel.fromJson(Map<String, dynamic> json) => _$AttendanceStatusModelFromJson(json);
}

extension NewJson on AttendanceStatusModel {
  Map<String, dynamic> toNewJson() => {
        'ShukketsuBunrui': shukketsuBunrui,
        'ShukketsuKbn': shukketsuKbn,
        'Jiyu1': jiyu1,
        'Jiyu2': jiyu2,
      };
}
