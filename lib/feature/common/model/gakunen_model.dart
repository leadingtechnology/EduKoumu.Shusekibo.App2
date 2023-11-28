import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'gakunen_model.freezed.dart';
part 'gakunen_model.g.dart';

List<GakunenModel> gakunenListFromJson(List<dynamic> data) =>
    List<GakunenModel>.from(data.map((x) => 
    GakunenModel.fromJson(x as Map<String, dynamic>),),);

GakunenModel gakunenFromJson(String str) => 
GakunenModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class GakunenModel with _$GakunenModel {
  @HiveType(typeId: 3, adapterName: 'GakunenModelAdapter')
  const factory GakunenModel({

    @JsonKey(name: 'OrganizationId', disallowNullValue: false) @HiveField(0) int? organizationId,
    @JsonKey(name: 'GakunenCode', disallowNullValue: false) @HiveField(1) String? gakunenCode,
    @JsonKey(name: 'GakunenName', disallowNullValue: false) @HiveField(2) String? gakunenName,
    @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false) @HiveField(3) String? gakunenRyakusho,
    @JsonKey(name: 'KateiKbn', disallowNullValue: false) @HiveField(4) String? kateiKbn,
    @JsonKey(name: 'ZaisekiAgeLowLimit', disallowNullValue: false) @HiveField(5) int? zaisekiAgeLowLimit,
    @JsonKey(name: 'IsTantoGakunen', disallowNullValue: false) @HiveField(6) bool? isTantoGakunen,
    @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(7) int? id,
    @JsonKey(name: 'Code', disallowNullValue: false) @HiveField(8) String? code,
    @JsonKey(name: 'Name', disallowNullValue: false) @HiveField(9) String? name,
  }) = _GakunenModel;

  @override
  String toString() {
    return 'GakunenModel($organizationId, $gakunenCode, $gakunenName, $gakunenRyakusho, $kateiKbn, $zaisekiAgeLowLimit, $isTantoGakunen, $id, $code, $name)';
  }
  factory GakunenModel.fromJson(Map<String, dynamic> json) => _$GakunenModelFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GakunenModel && other.id == id;
  }
}
