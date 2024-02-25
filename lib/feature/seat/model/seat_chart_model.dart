import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'seat_chart_model.freezed.dart';
part 'seat_chart_model.g.dart';

List<SeatChartModel> seatChartListFromJson(List<dynamic> data) =>
    List<SeatChartModel>.from(data.map((x) => SeatChartModel.fromJson(x as Map<String, dynamic>)));

SeatChartModel seatChartFromJson(String str) => SeatChartModel.fromJson(json.decode(str) as Map<String, dynamic>);



@freezed
abstract class SeatChartModel with _$SeatChartModel {
  @HiveType(typeId: 46, adapterName: 'SeatChartModelAdapter')
  const factory SeatChartModel({

    @JsonKey(name: 'SeatIndex', disallowNullValue: false) @HiveField(0) int? seatIndex,
    @JsonKey(name: 'SeatNumber', disallowNullValue: false) @HiveField(1) int? seatNumber,
    @JsonKey(name: 'SeitoSeq', disallowNullValue: false) @HiveField(2) String? seitoSeq,
  }) = _SeatChartModel;

  @override
  String toString() {
    return 'SeatChartModel($seatIndex, $seatNumber, $seitoSeq)';
  }
  factory SeatChartModel.fromJson(Map<String, dynamic> json) => _$SeatChartModelFromJson(json);
}
