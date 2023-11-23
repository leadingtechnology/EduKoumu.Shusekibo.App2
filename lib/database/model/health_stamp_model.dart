import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'health_stamp_model.freezed.dart';
part 'health_stamp_model.g.dart';

List<HealthStampModel> healthStampListFromJson(List<dynamic> data) =>
    List<HealthStampModel>.from(data.map((x) => 
    HealthStampModel.fromJson(x as Map<String, dynamic>),),);

HealthStampModel healthStampFromJson(String str) => 
HealthStampModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class HealthStampModel with _$HealthStampModel {
  @HiveType(typeId: 5, adapterName: 'HealthStampModelAdapter')
  const factory HealthStampModel({

    @JsonKey(name: 'JokyoCd', disallowNullValue: false) @HiveField(0) String? jokyoCd,
    @JsonKey(name: 'Bunrui', disallowNullValue: false) @HiveField(1) String? bunrui,
    @JsonKey(name: 'Kubun', disallowNullValue: false) @HiveField(2) String? kubun,
    @JsonKey(name: 'JokyoNmSeishiki', disallowNullValue: false) @HiveField(3) String? jokyoNmSeishiki,
    @JsonKey(name: 'JokyoNmRyaku', disallowNullValue: false) @HiveField(4) String? jokyoNmRyaku,
    @JsonKey(name: 'JokyoNmTsu', disallowNullValue: false) @HiveField(5) String? jokyoNmTsu,
    @JsonKey(name: 'JokyoKey', disallowNullValue: false) @HiveField(6) String? jokyoKey,
    @JsonKey(name: 'ShukketsuBunrui', disallowNullValue: false) @HiveField(7) String? shukketsuBunrui,
    @JsonKey(name: 'ShukketsuKubun', disallowNullValue: false) @HiveField(8) String? shukketsuKubun,
  }) = _HealthStampModel;

  @override
  String toString() {
    return 'HealthStampModel($jokyoCd, $bunrui, $kubun, $jokyoNmSeishiki, $jokyoNmRyaku, $jokyoNmTsu, $jokyoKey, $shukketsuBunrui, $shukketsuKubun)';
  }
  factory HealthStampModel.fromJson(Map<String, dynamic> json) => _$HealthStampModelFromJson(json);
}
