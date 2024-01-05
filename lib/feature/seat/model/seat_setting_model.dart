import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'seat_setting_model.freezed.dart';
part 'seat_setting_model.g.dart';

List<SeatSettingModel> seatSettingListFromJson(List<dynamic> data) =>
    List<SeatSettingModel>.from(data.map(
      (x) => SeatSettingModel.fromJson(x as Map<String, dynamic>),
    ),);

SeatSettingModel seatSettingFromJson(String str) => 
SeatSettingModel.fromJson(json.decode(str) as Map<String, dynamic>);



@freezed
abstract class SeatSettingModel with _$SeatSettingModel {
  @HiveType(typeId: 45, adapterName: 'SeatSettingModelAdapter')
  const factory SeatSettingModel({

    @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
    @JsonKey(name: 'TenantId', disallowNullValue: false) @HiveField(1) int? tenantId,
    @JsonKey(name: 'DantaiId', disallowNullValue: false) @HiveField(2) int? dantaiId,
    @JsonKey(name: 'ShozokuId', disallowNullValue: false) @HiveField(3) int? shozokuId,
    @JsonKey(name: 'SeatPattern', disallowNullValue: false) @HiveField(4) String? seatPattern,
    @JsonKey(name: 'SeatPatternName', disallowNullValue: false) @HiveField(5) String? seatPatternName,
    @JsonKey(name: 'Row', disallowNullValue: false) @HiveField(6) int? row,
    @JsonKey(name: 'Column', disallowNullValue: false) @HiveField(7) int? column,
    @JsonKey(name: 'SeatOrder', disallowNullValue: false) @HiveField(8) int? seatOrder,
    @JsonKey(name: 'StartDate', disallowNullValue: false) @HiveField(9) DateTime? startDate,
    @JsonKey(name: 'EndDate', disallowNullValue: false) @HiveField(10) DateTime? endDate,
    @JsonKey(name: 'CrtUserId', disallowNullValue: false) @HiveField(11) int? crtUserId,
    @JsonKey(name: 'CrtUserName', disallowNullValue: false) @HiveField(12) String? crtUserName,
    @JsonKey(name: 'CrtDateTime', disallowNullValue: false) @HiveField(13) DateTime? crtDateTime,
    @JsonKey(name: 'UpdUserId', disallowNullValue: false) @HiveField(14) int? updUserId,
    @JsonKey(name: 'UpdUserName', disallowNullValue: false) @HiveField(15) String? updUserName,
    @JsonKey(name: 'UpdDateTime', disallowNullValue: false) @HiveField(16) DateTime? updDateTime,
    @JsonKey(name: 'DeleteFlg', disallowNullValue: false) @HiveField(17) bool? deleteFlg,
//    @JsonKey(name: 'TimeStamp', disallowNullValue: false) @HiveField(18) Timest? timeStamp,
  }) = _SeatSettingModel;

  @override
  String toString() {
    return 'SeatSettingModel($id, $tenantId, $dantaiId, $shozokuId, $seatPattern, $seatPatternName, $row, $column, $seatOrder, $startDate, $endDate, $crtUserId, $crtUserName, $crtDateTime, $updUserId, $updUserName, $updDateTime, $deleteFlg)';
  }
  factory SeatSettingModel.fromJson(Map<String, dynamic> json) => _$SeatSettingModelFromJson(json);
}
