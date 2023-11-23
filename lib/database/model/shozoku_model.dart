import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'shozoku_model.freezed.dart';
part 'shozoku_model.g.dart';

List<ShozokuModel> shozokuListFromJson(List<dynamic> data) =>
    List<ShozokuModel>.from(data.map((x) => 
    ShozokuModel.fromJson(x as Map<String, dynamic>),),);

ShozokuModel shozokuFromJson(String str) => 
ShozokuModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class ShozokuModel with _$ShozokuModel {
  @HiveType(typeId: 4, adapterName: 'ShozokuModelAdapter')
  const factory ShozokuModel({

    @JsonKey(name: 'OrganizationCode', disallowNullValue: false) @HiveField(0) String? organizationCode,
    @JsonKey(name: 'OrganizationId', disallowNullValue: false) @HiveField(1) int? organizationId,
    @JsonKey(name: 'Nendo', disallowNullValue: false) @HiveField(2) String? nendo,
    @JsonKey(name: 'GakunenCode', disallowNullValue: false) @HiveField(3) String? gakunenCode,
    @JsonKey(name: 'ClassId', disallowNullValue: false) @HiveField(4) int? classId,
    @JsonKey(name: 'ClassBunrui', disallowNullValue: false) @HiveField(5) String? classBunrui,
    @JsonKey(name: 'ClassKbn', disallowNullValue: false) @HiveField(6) String? classKbn,
    @JsonKey(name: 'ClassCode', disallowNullValue: false) @HiveField(7) String? classCode,
    @JsonKey(name: 'ClassName', disallowNullValue: false) @HiveField(8) String? className,
    @JsonKey(name: 'ShozokuId', disallowNullValue: false) @HiveField(9) int? shozokuId,
    @JsonKey(name: 'ShozokuCode', disallowNullValue: false) @HiveField(10) String? shozokuCode,
    @JsonKey(name: 'IsGakuseki', disallowNullValue: false) @HiveField(11) bool? isGakuseki,
    @JsonKey(name: 'IsTokubetsuShien', disallowNullValue: false) @HiveField(12) bool? isTokubetsuShien,
    @JsonKey(name: 'Hyojijun', disallowNullValue: false) @HiveField(13) int? hyojijun,
    @JsonKey(name: 'IsTanninClass', disallowNullValue: false) @HiveField(14) bool? isTanninClass,
    @JsonKey(name: 'IsTantoClass', disallowNullValue: false) @HiveField(15) bool? isTantoClass,
    @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(16) int? id,
    @JsonKey(name: 'Code', disallowNullValue: false) @HiveField(17) String? code,
    @JsonKey(name: 'Name', disallowNullValue: false) @HiveField(18) String? name,
  }) = _ShozokuModel;

  @override
  String toString() {
    return 'ShozokuModel($organizationCode, $organizationId, $nendo, $gakunenCode, $classId, $classBunrui, $classKbn, $classCode, $className, $shozokuId, $shozokuCode, $isGakuseki, $isTokubetsuShien, $hyojijun, $isTanninClass, $isTantoClass, $id, $code, $name)';
  }
  factory ShozokuModel.fromJson(Map<String, dynamic> json) => _$ShozokuModelFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShozokuModel && other.id == id;
  }
}
