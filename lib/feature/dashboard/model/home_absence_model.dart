import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'home_absence_model.freezed.dart';
part 'home_absence_model.g.dart';

List<HomeAbsenceModel> homeAbsenceListFromJson(List<dynamic> data) =>
    List<HomeAbsenceModel>.from(data.map((x) => HomeAbsenceModel.fromJson(x as Map<String, dynamic>)));

HomeAbsenceModel homeAbsenceFromJson(String str) => HomeAbsenceModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class HomeAbsenceModel with _$HomeAbsenceModel {
  @HiveType(typeId: 48, adapterName: 'HomeAbsenceModelAdapter')
  const factory HomeAbsenceModel({

    @JsonKey(name: 'StudentSeq', disallowNullValue: false) @HiveField(0) String? studentSeq,
    @JsonKey(name: 'StudentKihonId', disallowNullValue: false) @HiveField(1) int? studentKihonId,
    @JsonKey(name: 'Gakunen', disallowNullValue: false) @HiveField(2) String? gakunen,
    @JsonKey(name: 'ClassName', disallowNullValue: false) @HiveField(3) String? className,
    @JsonKey(name: 'StudentNumber', disallowNullValue: false) @HiveField(4) String? studentNumber,
    @JsonKey(name: 'PhotoImageFlg', disallowNullValue: false) @HiveField(5) bool? photoImageFlg,
    @JsonKey(name: 'Name', disallowNullValue: false) @HiveField(6) String? name,
    @JsonKey(name: 'GenderCode', disallowNullValue: false) @HiveField(7) String? genderCode,
    @JsonKey(name: 'Ryaku', disallowNullValue: false) @HiveField(8) String? ryaku,
    @JsonKey(name: 'Jiyu1', disallowNullValue: false) @HiveField(9) String? jiyu1,
    @JsonKey(name: 'Jiyu2', disallowNullValue: false) @HiveField(10) String? jiyu2,
    @JsonKey(name: 'PhotoUrl', disallowNullValue: false) @HiveField(11) String? photoUrl,
  }) = _HomeAbsenceModel;

  @override
  String toString() {
    return 'HomeAbsenceModel($studentSeq, $studentKihonId, $gakunen, $className, $studentNumber, $photoImageFlg, $name, $genderCode, $ryaku, $jiyu1, $jiyu2, $photoUrl)';
  }
  factory HomeAbsenceModel.fromJson(Map<String, dynamic> json) => _$HomeAbsenceModelFromJson(json);
}
