import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'awareness_code_model.freezed.dart';
part 'awareness_code_model.g.dart';

List<AwarenessCodeModel> awarenessCodeListFromJson(List<dynamic> data) =>
    List<AwarenessCodeModel>.from(data.map((x) => 
    AwarenessCodeModel.fromJson(x as Map<String, dynamic>),),);

AwarenessCodeModel awarenessCodeFromJson(String str) =>
    AwarenessCodeModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class AwarenessCodeModel with _$AwarenessCodeModel {
  @HiveType(typeId: 33, adapterName: 'AwarenessCodeModelAdapter')
  const factory AwarenessCodeModel({
    @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
    @JsonKey(name: 'Code', disallowNullValue: false) @HiveField(1) String? code,
    @JsonKey(name: 'Name', disallowNullValue: false) @HiveField(2) String? name,
    @JsonKey(name: 'ShortName', disallowNullValue: false)
    @HiveField(3)
        String? shortName,
  }) = _AwarenessCodeModel;

  @override
  String toString() {
    return 'AwarenessCodeModel($id, $code, $name, $shortName)';
  }

  factory AwarenessCodeModel.fromJson(Map<String, dynamic> json) =>
      _$AwarenessCodeModelFromJson(json);
}
