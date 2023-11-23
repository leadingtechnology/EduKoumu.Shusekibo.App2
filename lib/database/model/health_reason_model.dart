import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'health_reason_model.freezed.dart';
part 'health_reason_model.g.dart';

List<HealthReasonModel> healthReasonListFromJson(List<dynamic> data) =>
    List<HealthReasonModel>.from(data.map((x) => 
    HealthReasonModel.fromJson(x as Map<String, dynamic>),),);

HealthReasonModel healthReasonFromJson(String str) => 
HealthReasonModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class HealthReasonModel with _$HealthReasonModel {
  @HiveType(typeId: 6, adapterName: 'HealthReasonModelAdapter')
  const factory HealthReasonModel({

    @JsonKey(name: 'JokyoCd', disallowNullValue: false) @HiveField(0) String? jokyoCd,
    @JsonKey(name: 'JiyuCd', disallowNullValue: false) @HiveField(1) String? jiyuCd,
    @JsonKey(name: 'JiyuNmSeishiki', disallowNullValue: false) @HiveField(2) String? jiyuNmSeishiki,
    @JsonKey(name: 'JiyuNmRyaku', disallowNullValue: false) @HiveField(3) String? jiyuNmRyaku,
    @JsonKey(name: 'KenkoFlg', disallowNullValue: false) @HiveField(4) bool? kenkoFlg,
    @JsonKey(name: 'DelFlg', disallowNullValue: false) @HiveField(5) bool? delFlg,
  }) = _HealthReasonModel;

  @override
  String toString() {
    return 'HealthReasonModel($jokyoCd, $jiyuCd, $jiyuNmSeishiki, $jiyuNmRyaku, $kenkoFlg, $delFlg)';
  }
  factory HealthReasonModel.fromJson(Map<String, dynamic> json) => _$HealthReasonModelFromJson(json);
}

extension NewMethod on HealthReasonModel {
  String getKey() {
    return '$jokyoCd$jiyuCd';
  }
}
