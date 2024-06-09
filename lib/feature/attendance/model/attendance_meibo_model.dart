import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_status_model.dart';

part 'attendance_meibo_model.g.dart';
part 'attendance_meibo_model.freezed.dart';

List<AttendanceMeiboModel> attendanceMeiboListFromJson(List<dynamic> data) =>
    List<AttendanceMeiboModel>.from(
      data.map((x) => AttendanceMeiboModel.fromJson(x as Map<String, dynamic>),
      ),);

AttendanceMeiboModel attendanceMeiboFromJson(String str) => 
AttendanceMeiboModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class AttendanceMeiboModel with _$AttendanceMeiboModel {
  @HiveType(typeId: 18, adapterName: 'AttendanceMeiboModelAdapter')
  const factory AttendanceMeiboModel({

    @JsonKey(name: 'StudentKihonId', disallowNullValue: false) @HiveField(0) int? studentKihonId,
    @JsonKey(name: 'StudentSeq', disallowNullValue: false) @HiveField(1) String? studentSeq,
    @JsonKey(name: 'Gakunen', disallowNullValue: false) @HiveField(2) String? gakunen,
    @JsonKey(name: 'ClassName', disallowNullValue: false) @HiveField(3) String? className,
    @JsonKey(name: 'StudentNumber', disallowNullValue: false) @HiveField(4) String? studentNumber,
    @JsonKey(name: 'PhotoImageFlg', disallowNullValue: false) @HiveField(5) bool? photoImageFlg,
    @JsonKey(name: 'Name', disallowNullValue: false) @HiveField(6) String? name,
    @JsonKey(name: 'GenderCode', disallowNullValue: false) @HiveField(7) String? genderCode,
    @JsonKey(name: 'PhotoUrl', disallowNullValue: false) @HiveField(8) String? photoUrl,
    @JsonKey(name: 'TenshutsuYoteiFlg', disallowNullValue: false) @HiveField(9) bool? tenshutsuYoteiFlg,
    @JsonKey(name: 'TenshutsuSumiFlg',  disallowNullValue: false) @HiveField(10) bool? tenshutsuSumiFlg,
    @JsonKey(name: 'StudentTsushoName',  disallowNullValue: false) @HiveField(11) String? studentTsushoName,
    @JsonKey(name: 'JokyoList', disallowNullValue: false) @HiveField(12) List<AttendanceStatusModel>? jokyoList,
  }) = _AttendanceMeiboModel;

  @override
  String toString() {
    return 'AttendanceMeiboModel($studentKihonId, $studentSeq, $gakunen, $className, $studentNumber, $photoImageFlg, $name, $genderCode, $photoUrl, $tenshutsuYoteiFlg, $tenshutsuSumiFlg, $studentTsushoName, $jokyoList)';
  }
  factory AttendanceMeiboModel.fromJson(Map<String, dynamic> json) => _$AttendanceMeiboModelFromJson(json);
}

extension NewJson on AttendanceMeiboModel {
  Map<String, dynamic> toNewJson() => {
        'SeitoSeq': studentSeq,
        'StudentKihonId': studentKihonId,
        'StudentTsushoName': name,
        'ShukketsuModelList': jokyoList == null
            ? '[]'
            : jokyoList?.map((v) => v.toNewJson()).toList(),
      };
}
