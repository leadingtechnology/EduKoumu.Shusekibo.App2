import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'tannin_model.freezed.dart';
part 'tannin_model.g.dart';

List<TanninModel> tanninListFromJson(List<dynamic> data) =>
    List<TanninModel>.from(data.map(
      (x) => TanninModel.fromJson(x as Map<String, dynamic>),),);

TanninModel tanninFromJson(String str) => 
TanninModel.fromJson(json.decode(str) as Map<String, dynamic>);



@freezed
abstract class TanninModel with _$TanninModel {
  @HiveType(typeId: 43, adapterName: 'TanninModelAdapter')
  const factory TanninModel({

    @JsonKey(name: 'GakunenCode', disallowNullValue: false) @HiveField(0) String? gakunenCode,
    @JsonKey(name: 'ClassName', disallowNullValue: false) @HiveField(1) String? className,
    @JsonKey(name: 'ShozokuId', disallowNullValue: false) @HiveField(2) int? shozokuId,
  }) = _TanninModel;

  @override
  String toString() {
    return 'TanninModel($gakunenCode, $className, $shozokuId)';
  }
  factory TanninModel.fromJson(Map<String, dynamic> json) => _$TanninModelFromJson(json);
}
