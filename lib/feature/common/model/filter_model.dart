import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'filter_model.freezed.dart';
part 'filter_model.g.dart';

List<FilterModel> filterListFromJson(List<dynamic> data) =>
    List<FilterModel>.from(data.map((x) => 
    FilterModel.fromJson(x as Map<String, dynamic>),),);

FilterModel filterFromJson(String str) => 
FilterModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class FilterModel with _$FilterModel {
  @HiveType(typeId: 13, adapterName: 'FilterModelAdapter')
  const factory FilterModel({
    @JsonKey(name: 'DantaiId', disallowNullValue: false) @HiveField(0) int? dantaiId,
    @JsonKey(name: 'OrganizationKbn', disallowNullValue: false) @HiveField(1) String? organizationKbn,
    @JsonKey(name: 'DantaiName', disallowNullValue: false) @HiveField(2) String? dantaiName,
    @JsonKey(name: 'GakunenCode', disallowNullValue: false) @HiveField(3) String? gakunenCode,
    @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false) @HiveField(4) String? gakunenRyakusho,
    @JsonKey(name: 'kouryuGakkyu', disallowNullValue: false) @HiveField(5) bool? kouryuGakkyu,
    @JsonKey(name: 'ClassId', disallowNullValue: false) @HiveField(6) int? classId,
    @JsonKey(name: 'ClassCode', disallowNullValue: false) @HiveField(7) String? classCode,
    @JsonKey(name: 'ClassName', disallowNullValue: false) @HiveField(8) String? className,
    @JsonKey(name: 'TargetDate', disallowNullValue: false) @HiveField(9) DateTime? targetDate,
    @JsonKey(name: 'JapanDate', disallowNullValue: false) @HiveField(10) String? japanDate,
    @JsonKey(name: 'BeginDate', disallowNullValue: false) @HiveField(11) DateTime? beginDate,
    @JsonKey(name: 'EndDate', disallowNullValue: false) @HiveField(12) DateTime? endDate,
    @JsonKey(name: 'JigenIdx', disallowNullValue: false) @HiveField(13) int? jigenIdx,
    @JsonKey(name: 'JigenRyaku', disallowNullValue: false) @HiveField(14) String? jigenRyaku,
  }) = _FilterModel;

  @override
  String toString() {
    return 'FilterModel($dantaiId, $organizationKbn, $dantaiName, $gakunenCode, $gakunenRyakusho, $kouryuGakkyu, $classId, $classCode, $className, $targetDate, $japanDate, $beginDate, $endDate, $jigenIdx, $jigenRyaku)';
  }
  factory FilterModel.fromJson(Map<String, dynamic> json) => _$FilterModelFromJson(json);
}
