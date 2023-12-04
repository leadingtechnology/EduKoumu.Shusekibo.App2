import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'awareness_meibo_model.freezed.dart';
part 'awareness_meibo_model.g.dart';

List<AwarenessMeiboModel> awarenessMeiboListFromJson(List<dynamic> data) =>
    List<AwarenessMeiboModel>.from(data.map((x) => 
    AwarenessMeiboModel.fromJson(x as Map<String, dynamic>),),);

AwarenessMeiboModel awarenessMeiboFromJson(String str) => 
AwarenessMeiboModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class AwarenessMeiboModel with _$AwarenessMeiboModel {
  @HiveType(typeId: 34, adapterName: 'AwarenessMeiboModelAdapter')
  const factory AwarenessMeiboModel({

    @JsonKey(name: 'Gakunen', disallowNullValue: false) @HiveField(0) String? gakunen,
    @JsonKey(name: 'ShozokuId', disallowNullValue: false) @HiveField(1) int? shozokuId,
    @JsonKey(name: 'ClassName', disallowNullValue: false) @HiveField(2) String? className,
    @JsonKey(name: 'ShussekiNo', disallowNullValue: false) @HiveField(3) String? shussekiNo,
    @JsonKey(name: 'StudentKihonId', disallowNullValue: false) @HiveField(4) int? studentKihonId,
    @JsonKey(name: 'StudentId', disallowNullValue: false) @HiveField(5) int? studentId,
    @JsonKey(name: 'StudentName', disallowNullValue: false) @HiveField(6) String? studentName,
    @JsonKey(name: 'PhotoUrl', disallowNullValue: false) @HiveField(7) String? photoUrl,
    @JsonKey(name: 'GenderCode', disallowNullValue: false) @HiveField(8) String? genderCode,
    @JsonKey(name: 'KizukiCount', disallowNullValue: false) @HiveField(9) int? kizukiCount,
    @JsonKey(name: 'SelectFlag', disallowNullValue: false) @HiveField(10) bool? selectFlag,
    @JsonKey(name: 'ChangedFlag', disallowNullValue: false) @HiveField(11) bool? changedFlag,
  }) = _AwarenessMeiboModel;

  @override
  String toString() {
    return 'AwarenessMeiboModel($gakunen, $shozokuId, $className, $shussekiNo, $studentKihonId, $studentId, $studentName, $photoUrl, $genderCode, $kizukiCount, $selectFlag, $changedFlag)';
  }
  factory AwarenessMeiboModel.fromJson(Map<String, dynamic> json) => _$AwarenessMeiboModelFromJson(json);
}
