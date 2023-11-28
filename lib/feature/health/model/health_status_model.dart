import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'health_status_model.freezed.dart';
part 'health_status_model.g.dart';

List<HealthStatusModel> healthStatusListFromJson(List<dynamic> data) =>
    List<HealthStatusModel>.from(data.map((x) => 
    HealthStatusModel.fromJson(x as Map<String, dynamic>),),);

HealthStatusModel healthStatusFromJson(String str) => 
HealthStatusModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class HealthStatusModel with _$HealthStatusModel {
  @HiveType(typeId: 7, adapterName: 'HealthStatusModelAdapter')
  const factory HealthStatusModel({

    @JsonKey(name: 'Date', disallowNullValue: false) @HiveField(0) DateTime? kokyoDate,
    @JsonKey(name: 'JokyoCode', disallowNullValue: false) @HiveField(1) String? jokyoCode,
    @JsonKey(name: 'Ryaku', disallowNullValue: false) @HiveField(2) String? ryaku,
    @JsonKey(name: 'Jiyu1Code', disallowNullValue: false) @HiveField(3) String? jiyu1Code,
    @JsonKey(name: 'Jiyu1', disallowNullValue: false) @HiveField(4) String? jiyu1,
    @JsonKey(name: 'Jiyu2', disallowNullValue: false) @HiveField(5) String? jiyu2,
    @JsonKey(name: 'IsEditable', disallowNullValue: false) @HiveField(6) bool? isEditable,
  }) = _HealthStatusModel;

  @override
  String toString() {
    return 'HealthStatusModel($kokyoDate, $jokyoCode, $ryaku, $jiyu1Code, $jiyu1, $jiyu2, $isEditable)';
  }
  factory HealthStatusModel.fromJson(Map<String, dynamic> json) => _$HealthStatusModelFromJson(json);
}

extension NewJson on HealthStatusModel {
  Map<String, dynamic> toNewJson() => {
        'KenkoKansatsuJokyoCd': jokyoCode,
        'KenkoKansatsuJiyuCd': jiyu1Code,
        'Jiyu1': jiyu1,
        'Jiyu2': jiyu2,
      };
}

