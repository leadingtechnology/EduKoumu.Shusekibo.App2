import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'kamoku_model.freezed.dart';
part 'kamoku_model.g.dart';

List<KamokuModel> kamokuListFromJson(List<dynamic> data) =>
    List<KamokuModel>.from(
      data.map((x) => KamokuModel.fromJson(x as Map<String, dynamic>)),
    );

KamokuModel kamokuFromJson(String str) =>
    KamokuModel.fromJson(json.decode(str) as Map<String, dynamic>);


@freezed
abstract class KamokuModel with _$KamokuModel {
  @HiveType(typeId: 52, adapterName: 'KamokuModelAdapter')
  const factory KamokuModel({

    @JsonKey(name: 'IsChecked', disallowNullValue: false) @HiveField(0) bool? isChecked,
    @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(1) int? id,
    @JsonKey(name: 'Stscd', disallowNullValue: false) @HiveField(2) String? stscd,
    @JsonKey(name: 'DantaiBunrui', disallowNullValue: false) @HiveField(3) String? dantaiBunrui,
    @JsonKey(name: 'DantaiKbn', disallowNullValue: false) @HiveField(4) String? dantaiKbn,
    @JsonKey(name: 'KyokaId', disallowNullValue: false) @HiveField(5) int? kyokaId,
    @JsonKey(name: 'KyokaBunrui', disallowNullValue: false) @HiveField(6) String? kyokaBunrui,
    @JsonKey(name: 'KamokuCode', disallowNullValue: false) @HiveField(7) String? kamokuCode,
    @JsonKey(name: 'SeisekiFlg', disallowNullValue: false) @HiveField(8) bool? seisekiFlg,
    @JsonKey(name: 'ShuanFlg', disallowNullValue: false) @HiveField(9) bool? shuanFlg,
    @JsonKey(name: 'KamokuNameSeishiki', disallowNullValue: false) @HiveField(10) String? kamokuNameSeishiki,
    @JsonKey(name: 'KamokuNameRyakusho', disallowNullValue: false) @HiveField(11) String? kamokuNameRyakusho,
    @JsonKey(name: 'DanjoBunkatsuFlg', disallowNullValue: false) @HiveField(12) bool? danjoBunkatsuFlg,
    @JsonKey(name: 'UpdKyoinId', disallowNullValue: false) @HiveField(13) String? updKyoinId,
    @JsonKey(name: 'CrtUserId', disallowNullValue: false) @HiveField(14) int? crtUserId,
    @JsonKey(name: 'CrtUserName', disallowNullValue: false) @HiveField(15) String? crtUserName,
    @JsonKey(name: 'CrtDateTime', disallowNullValue: false) @HiveField(16) DateTime? crtDateTime,
    @JsonKey(name: 'UpdUserId', disallowNullValue: false) @HiveField(17) int? updUserId,
    @JsonKey(name: 'UpdUserName', disallowNullValue: false) @HiveField(18) String? updUserName,
    @JsonKey(name: 'UpdDateTime', disallowNullValue: false) @HiveField(19) DateTime? updDateTime,
    @JsonKey(name: 'DeleteFlg', disallowNullValue: false) @HiveField(20) bool? deleteFlg,
    @JsonKey(name: 'TimeStamp', disallowNullValue: false) @HiveField(21) String? timeStamp,
    @JsonKey(name: 'OperatorUserId', disallowNullValue: false) @HiveField(22) int? operatorUserId,
    @JsonKey(name: 'TenantId', disallowNullValue: false) @HiveField(23) int? tenantId,
  }) = _KamokuModel;

  @override
  String toString() {
    return 'KamokuModel($isChecked, $id, $stscd, $dantaiBunrui, $dantaiKbn, $kyokaId, $kyokaBunrui, $kamokuCode, $seisekiFlg, $shuanFlg, $kamokuNameSeishiki, $kamokuNameRyakusho, $danjoBunkatsuFlg, $updKyoinId, $crtUserId, $crtUserName, $crtDateTime, $updUserId, $updUserName, $updDateTime, $deleteFlg, $timeStamp, $operatorUserId, $tenantId)';
  }
  factory KamokuModel.fromJson(Map<String, dynamic> json) => _$KamokuModelFromJson(json);
}
