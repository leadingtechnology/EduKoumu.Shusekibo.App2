import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

part 'tokobi_model.freezed.dart';
part 'tokobi_model.g.dart';

List<TokobiModel> tokobiListFromJson(List<dynamic> data) =>
    List<TokobiModel>.from(data.map((x) => 
    TokobiModel.fromJson(x as Map<String, dynamic>)));

TokobiModel tokobiFromJson(String str) => 
TokobiModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class TokobiModel with _$TokobiModel {
  @HiveType(typeId: 37, adapterName: 'TokobiModelAdapter')
  const factory TokobiModel({

    @JsonKey(name: 'Date', disallowNullValue: false) @HiveField(0) DateTime? tokobi,
    @JsonKey(name: 'YobiCd', disallowNullValue: false) @HiveField(1) String? yobiCd,
    @JsonKey(name: 'WeekName', disallowNullValue: false) @HiveField(2) String? weekName,
    @JsonKey(name: 'Jigen', disallowNullValue: false) @HiveField(3) int? jigen,
    @JsonKey(name: 'IsToday', disallowNullValue: false) @HiveField(4) bool? isToday,
    @JsonKey(name: 'IsEditable', disallowNullValue: false) @HiveField(5) bool? isEditable,
    @JsonKey(name: 'StampedCount', disallowNullValue: false) @HiveField(6) int? stampedCount,
    @JsonKey(name: 'TotalCount', disallowNullValue: false) @HiveField(7) int? totalCount,
  }) = _TokobiModel;

  @override
  String toString() {
    return 'TokobiModel($tokobi, $yobiCd, $weekName, $jigen, $isToday, $isEditable, $stampedCount, $totalCount)';
  }
  factory TokobiModel.fromJson(Map<String, dynamic> json) => _$TokobiModelFromJson(json);
}

extension NewMethod on TokobiModel {
  String getKey(){
    return DateFormat('yyyy-MM-dd').format(tokobi??DateTime.now()).toString();
  }
}
