import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'timed_model.freezed.dart';
part 'timed_model.g.dart';

List<TimedModel> timedListFromJson(List<dynamic> data) =>
    List<TimedModel>.from(data.map((x) => 
    TimedModel.fromJson(x as Map<String, dynamic>),),);

TimedModel timedFromJson(String str) => 
TimedModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class TimedModel with _$TimedModel {
  @HiveType(typeId: 24, adapterName: 'TimedModelAdapter')
  const factory TimedModel({

    @JsonKey(name: 'YobiCd', disallowNullValue: false) @HiveField(0) String? yobiCd,
    @JsonKey(name: 'JigenIdx', disallowNullValue: false) @HiveField(1) int? jigenIdx,
    @JsonKey(name: 'Ryaku', disallowNullValue: false) @HiveField(2) String? ryaku,
    @JsonKey(name: 'NikkahyoShubetsuCode', disallowNullValue: false) @HiveField(3) String? nikkahyoShubetsuCode,
  }) = _TimedModel;

  @override
  String toString() {
    return 'TimedModel($yobiCd, $jigenIdx, $ryaku, $nikkahyoShubetsuCode)';
  }
  factory TimedModel.fromJson(Map<String, dynamic> json) => _$TimedModelFromJson(json);
}
