import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_status_model.dart';


part 'attendance_timed_meibo_model.freezed.dart';
part 'attendance_timed_meibo_model.g.dart';

List<AttendanceTimedMeiboModel> attendanceTimedMeiboListFromJson(List<dynamic> data) =>
    List<AttendanceTimedMeiboModel>.from(data.map((x) => 
    AttendanceTimedMeiboModel.fromJson(x as Map<String, dynamic>),),);

AttendanceTimedMeiboModel attendanceTimedMeiboFromJson(String str) => 
AttendanceTimedMeiboModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class AttendanceTimedMeiboModel with _$AttendanceTimedMeiboModel {
  @HiveType(typeId: 28, adapterName: 'AttendanceTimedMeiboModelAdapter')
  const factory AttendanceTimedMeiboModel({

    @JsonKey(name: 'StudentKihonId', disallowNullValue: false) @HiveField(0) int? studentKihonId,
    @JsonKey(name: 'StudentSeq', disallowNullValue: false) @HiveField(1) String? studentSeq,
    @JsonKey(name: 'Gakunen', disallowNullValue: false) @HiveField(2) String? gakunen,
    @JsonKey(name: 'ClassName', disallowNullValue: false) @HiveField(3) String? className,
    @JsonKey(name: 'StudentNumber', disallowNullValue: false) @HiveField(4) String? studentNumber,
    @JsonKey(name: 'PhotoImageFlg', disallowNullValue: false) @HiveField(5) bool? photoImageFlg,
    @JsonKey(name: 'Name', disallowNullValue: false) @HiveField(6) String? name,
    @JsonKey(name: 'GenderCode', disallowNullValue: false) @HiveField(7) String? genderCode,
    @JsonKey(name: 'PhotoUrl', disallowNullValue: false) @HiveField(8) String? photoUrl,
    @JsonKey(name: 'TenshutsuDateKyokouDate', disallowNullValue: false) @HiveField(9) DateTime? tenshutsuDateKyokouDate,
    @JsonKey(name: 'TenshutsuYoteiFlg', disallowNullValue: false) @HiveField(10) bool? tenshutsuYoteiFlg,
    @JsonKey(name: 'TenshutsuSumiFlg',  disallowNullValue: false) @HiveField(11) bool? tenshutsuSumiFlg,
    @JsonKey(name: 'JokyoList', disallowNullValue: false) @HiveField(12) List<AttendanceTimedStatusModel>? jokyoList,
  }) = _AttendanceTimedMeiboModel;

  @override
  String toString() {
    return 'AttendanceTimedMeiboModel($studentKihonId, $studentSeq, $gakunen, $className, $studentNumber, $photoImageFlg, $name, $genderCode, $photoUrl, $tenshutsuDateKyokouDate, $tenshutsuYoteiFlg, $tenshutsuSumiFlg, $jokyoList)';
  }
  factory AttendanceTimedMeiboModel.fromJson(Map<String, dynamic> json) => _$AttendanceTimedMeiboModelFromJson(json);
}


extension NewJson on AttendanceTimedMeiboModel {
  Map<String, dynamic> toNewJson() => {
        'SeitoSeq': studentSeq,
        'StudentKihonId': studentKihonId,
        'StudentTsushoName': name,
        'ShukketsuJigenModelList': jokyoList == null
            ? '[]'
            : jokyoList?.map((v) => v.toNewJson()).toList(),
      };
}
