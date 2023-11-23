import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'home_attendance_model.freezed.dart';
part 'home_attendance_model.g.dart';

List<HomeAttendanceModel> homeAttendanceListFromJson(List<dynamic> data) =>
    List<HomeAttendanceModel>.from(data.map((x) => 
    HomeAttendanceModel.fromJson(x as Map<String, dynamic>),),);

HomeAttendanceModel homeAttendanceFromJson(String str) => 
HomeAttendanceModel.fromJson(json.decode(str) as Map<String, dynamic>);


@freezed
abstract class HomeAttendanceModel with _$HomeAttendanceModel {
  @HiveType(typeId: 38, adapterName: 'HomeAttendanceModelAdapter')
  const factory HomeAttendanceModel({

    @JsonKey(name: 'ClassName', disallowNullValue: false) @HiveField(0) String? className,
    @JsonKey(name: 'Zaiseki', disallowNullValue: false) @HiveField(1) int? zaiseki,
    @JsonKey(name: 'Shusseki', disallowNullValue: false) @HiveField(2) int? shusseki,
    @JsonKey(name: 'Tikoku', disallowNullValue: false) @HiveField(3) int? tikoku,
    @JsonKey(name: 'Sotai', disallowNullValue: false) @HiveField(4) int? sotai,
    @JsonKey(name: 'KessekiShuttei', disallowNullValue: false) @HiveField(5) int? kessekiShuttei,
    @JsonKey(name: 'Influenza', disallowNullValue: false) @HiveField(6) int? influenza,
    @JsonKey(name: 'DoneAttendanceFlg', disallowNullValue: false) @HiveField(7) bool? doneAttendanceFlg,
  }) = _HomeAttendanceModel;

  @override
  String toString() {
    return 'HomeAttendanceModel($className, $zaiseki, $shusseki, $tikoku, $sotai, $kessekiShuttei, $influenza, $doneAttendanceFlg)';
  }
  factory HomeAttendanceModel.fromJson(Map<String, dynamic> json) => _$HomeAttendanceModelFromJson(json);
}
