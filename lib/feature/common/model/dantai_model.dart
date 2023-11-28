import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'dantai_model.freezed.dart';
part 'dantai_model.g.dart';

List<DantaiModel> dantaiListFromJson(List<dynamic> data) =>
    List<DantaiModel>.from(data.map((x) => 
    DantaiModel.fromJson(x as Map<String, dynamic>),),);

DantaiModel dantaiFromJson(String str) => 
DantaiModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class DantaiModel with _$DantaiModel {
  @HiveType(typeId: 2, adapterName: 'DantaiModelAdapter')
  const factory DantaiModel({

    @JsonKey(name: 'OrganizationBunrui', disallowNullValue: false) @HiveField(0) String? organizationBunrui,
    @JsonKey(name: 'OrganizationKbn', disallowNullValue: false) @HiveField(1) String? organizationKbn,
    @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(2) int? id,
    @JsonKey(name: 'Code', disallowNullValue: false) @HiveField(3) String? code,
    @JsonKey(name: 'Name', disallowNullValue: false) @HiveField(4) String? name,
  }) = _DantaiModel;

  @override
  String toString() {
    return 'DantaiModel($organizationBunrui, $organizationKbn, $id, $code, $name)';
  }
  factory DantaiModel.fromJson(Map<String, dynamic> json) => _$DantaiModelFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DantaiModel &&
        other.id == id ;
  }
}
