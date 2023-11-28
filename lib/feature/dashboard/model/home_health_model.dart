import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'home_health_model.freezed.dart';
part 'home_health_model.g.dart';

List<HomeHealthModel> homeHealthListFromJson(List<dynamic> data) =>
    List<HomeHealthModel>.from(data.map((x) => 
    HomeHealthModel.fromJson(x as Map<String, dynamic>),),);

HomeHealthModel homeHealthFromJson(String str) => 
    HomeHealthModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class HomeHealthModel with _$HomeHealthModel {
  @HiveType(typeId: 39, adapterName: 'HomeHealthModelAdapter')
  const factory HomeHealthModel({

    @JsonKey(name: 'ClassName', disallowNullValue: false) @HiveField(0) String? className,
    @JsonKey(name: 'Zaiseki', disallowNullValue: false) @HiveField(1) int? zaiseki,
    @JsonKey(name: 'Shusseki', disallowNullValue: false) @HiveField(2) int? shusseki,
    @JsonKey(name: 'Tikoku', disallowNullValue: false) @HiveField(3) int? tikoku,
    @JsonKey(name: 'Sotai', disallowNullValue: false) @HiveField(4) int? sotai,
    @JsonKey(name: 'KessekiShuttei', disallowNullValue: false) @HiveField(5) int? kessekiShuttei,
    @JsonKey(name: 'Influenza', disallowNullValue: false) @HiveField(6) int? influenza,
    @JsonKey(name: 'DoneKenkoKansatsuFlg', disallowNullValue: false) @HiveField(7) bool? doneKenkoKansatsuFlg,
  }) = _HomeHealthModel;


  @override
  String toString() {
    return 'HomeHealthModel($className, $zaiseki, $shusseki, $tikoku, $sotai, $kessekiShuttei, $influenza, $doneKenkoKansatsuFlg)';
  }
  factory HomeHealthModel.fromJson(Map<String, dynamic> json) => _$HomeHealthModelFromJson(json);
}
