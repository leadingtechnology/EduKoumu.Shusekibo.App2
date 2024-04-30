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

    @JsonKey(name: 'KyokaDantaiBunrui', disallowNullValue: false) @HiveField(7) String? kyokaDantaiBunrui,
    @JsonKey(name: 'KyokaDantaiKbn', disallowNullValue: false) @HiveField(8) String? kyokaDantaiKbn,
    @JsonKey(name: 'KyokaBunrui', disallowNullValue: false) @HiveField(9) String? kyokaBunrui,
    @JsonKey(name: 'KamokuCd', disallowNullValue: false) @HiveField(10) String? kamokuCd,
    @JsonKey(name: 'KamokuNameRyakusho', disallowNullValue: false) @HiveField(11) String? kamokuNameRyakusho,

    @JsonKey(name: 'KyoinId1', disallowNullValue: false) @HiveField(12) String? kyoinId1,
    @JsonKey(name: 'KyoinName1', disallowNullValue: false) @HiveField(13) String? kyoinName1,
    @JsonKey(name: 'KyoinId2', disallowNullValue: false) @HiveField(14) String? kyoinId2,
    @JsonKey(name: 'KyoinName2', disallowNullValue: false) @HiveField(15) String? kyoinName2,
    @JsonKey(name: 'KyoinId3', disallowNullValue: false) @HiveField(16) String? kyoinId3,
    @JsonKey(name: 'KyoinName3', disallowNullValue: false) @HiveField(17) String? kyoinName3,


    @JsonKey(name: 'IsEditable', disallowNullValue: false) @HiveField(18) bool? isEditable,
  }) = _AttendanceStatusModel;

  @override
  String toString() {
    return 'AttendanceStatusModel($jokyoDate, $jigenIdx, $ryaku, $shukketsuBunrui, $shukketsuKbn, $jiyu1, $jiyu2, $kyokaDantaiBunrui , $kyokaDantaiKbn, $kyokaBunrui, $kamokuCd, $kamokuNameRyakusho, $kyoinId1, $kyoinName1, $kyoinId2, $kyoinName2, $kyoinId3, $kyoinName3, $isEditable)';
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
