import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'tanto_kyoin_model.freezed.dart';
part 'tanto_kyoin_model.g.dart';

List<TantoKyoinModel> tantoKyoinListFromJson(List<dynamic> data) =>
    List<TantoKyoinModel>.from(
      data.map((x) => TantoKyoinModel.fromJson(x as Map<String, dynamic>)),
    );

TantoKyoinModel tantoKyoinFromJson(String str) =>
    TantoKyoinModel.fromJson(json.decode(str) as Map<String, dynamic>);



@freezed
abstract class TantoKyoinModel with _$TantoKyoinModel {
  @HiveType(typeId: 53, adapterName: 'TantoKyoinModelAdapter')
  const factory TantoKyoinModel({

    @JsonKey(name: 'TeacherTsushoName', disallowNullValue: false) @HiveField(0) String? teacherTsushoName,
    @JsonKey(name: 'KamokuNameRyakusho', disallowNullValue: false) @HiveField(1) String? kamokuNameRyakusho,
    @JsonKey(name: 'IsChecked', disallowNullValue: false) @HiveField(2) bool? isChecked,
    @JsonKey(name: 'Stscd', disallowNullValue: false) @HiveField(3) String? stscd,
    @JsonKey(name: 'DantaiBunrui', disallowNullValue: false) @HiveField(4) String? dantaiBunrui,
    @JsonKey(name: 'DantaiKbn', disallowNullValue: false) @HiveField(5) String? dantaiKbn,
    @JsonKey(name: 'DantaiCd', disallowNullValue: false) @HiveField(6) String? dantaiCd,
    @JsonKey(name: 'Nendo', disallowNullValue: false) @HiveField(7) String? nendo,
    @JsonKey(name: 'ShozokuId', disallowNullValue: false) @HiveField(8) int? shozokuId,
    @JsonKey(name: 'ShozokuBunrui', disallowNullValue: false) @HiveField(9) String? shozokuBunrui,
    @JsonKey(name: 'ShozokuKbn', disallowNullValue: false) @HiveField(10) String? shozokuKbn,
    @JsonKey(name: 'ShozokuCd', disallowNullValue: false) @HiveField(11) String? shozokuCd,
    @JsonKey(name: 'TaishoDate', disallowNullValue: false) @HiveField(12) DateTime? taishoDate,
    @JsonKey(name: 'StrTaishoDate', disallowNullValue: false) @HiveField(13) String? strTaishoDate,
    @JsonKey(name: 'JigenIdx', disallowNullValue: false) @HiveField(14) int? jigenIdx,
    @JsonKey(name: 'JigenBunkatsuIdx', disallowNullValue: false) @HiveField(15) int? jigenBunkatsuIdx,
    @JsonKey(name: 'KyoinID', disallowNullValue: false) @HiveField(16) String? kyoinID,
    @JsonKey(name: 'KyokaDantaiBunrui', disallowNullValue: false) @HiveField(17) String? kyokaDantaiBunrui,
    @JsonKey(name: 'KyokaDantaiKbn', disallowNullValue: false) @HiveField(18) String? kyokaDantaiKbn,
    @JsonKey(name: 'KyokaBunrui', disallowNullValue: false) @HiveField(19) String? kyokaBunrui,
    @JsonKey(name: 'KamokuCd', disallowNullValue: false) @HiveField(20) String? kamokuCd,
    @JsonKey(name: 'TangenSeq', disallowNullValue: false) @HiveField(21) String? tangenSeq,
    @JsonKey(name: 'ShidoNaiyoSeq', disallowNullValue: false) @HiveField(22) String? shidoNaiyoSeq,
    @JsonKey(name: 'ShidoKiroku', disallowNullValue: false) @HiveField(23) String? shidoKiroku,
    @JsonKey(name: 'Jisu', disallowNullValue: false) @HiveField(24) int? jisu,
    @JsonKey(name: 'JisuBunsuCode', disallowNullValue: false) @HiveField(25) String? jisuBunsuCode,
    @JsonKey(name: 'JisuBunsuName', disallowNullValue: false) @HiveField(26) String? jisuBunsuName,
    @JsonKey(name: 'JisuBunsuBunshi', disallowNullValue: false) @HiveField(27) int? jisuBunsuBunshi,
    @JsonKey(name: 'JisuBunsuBunbo', disallowNullValue: false) @HiveField(28) int? jisuBunsuBunbo,
    @JsonKey(name: 'UpdKyoinId', disallowNullValue: false) @HiveField(29) String? updKyoinId,
    @JsonKey(name: 'CrtUserId', disallowNullValue: false) @HiveField(30) int? crtUserId,
    @JsonKey(name: 'CrtUserName', disallowNullValue: false) @HiveField(31) String? crtUserName,
    @JsonKey(name: 'CrtDateTime', disallowNullValue: false) @HiveField(32) DateTime? crtDateTime,
    @JsonKey(name: 'UpdUserId', disallowNullValue: false) @HiveField(33) int? updUserId,
    @JsonKey(name: 'UpdUserName', disallowNullValue: false) @HiveField(34) String? updUserName,
    @JsonKey(name: 'UpdDateTime', disallowNullValue: false) @HiveField(35) DateTime? updDateTime,
    @JsonKey(name: 'DeleteFlg', disallowNullValue: false) @HiveField(36) bool? deleteFlg,
    @JsonKey(name: 'TimeStamp', disallowNullValue: false) @HiveField(37) String? timeStamp,
    @JsonKey(name: 'OperatorUserId', disallowNullValue: false) @HiveField(38) int? operatorUserId,
    @JsonKey(name: 'TenantId', disallowNullValue: false) @HiveField(39) int? tenantId,
    @JsonKey(name: 'DantaiId', disallowNullValue: false) @HiveField(40) int? dantaiId,
  }) = _TantoKyoinModel;

  @override
  String toString() {
    return 'TantoKyoinModel($teacherTsushoName, $kamokuNameRyakusho, $isChecked, $stscd, $dantaiBunrui, $dantaiKbn, $dantaiCd, $nendo, $shozokuId, $shozokuBunrui, $shozokuKbn, $shozokuCd, $taishoDate, $strTaishoDate, $jigenIdx, $jigenBunkatsuIdx, $kyoinID, $kyokaDantaiBunrui, $kyokaDantaiKbn, $kyokaBunrui, $kamokuCd, $tangenSeq, $shidoNaiyoSeq, $shidoKiroku, $jisu, $jisuBunsuCode, $jisuBunsuName, $jisuBunsuBunshi, $jisuBunsuBunbo, $updKyoinId, $crtUserId, $crtUserName, $crtDateTime, $updUserId, $updUserName, $updDateTime, $deleteFlg, $timeStamp, $operatorUserId, $tenantId, $dantaiId)';
  }
  factory TantoKyoinModel.fromJson(Map<String, dynamic> json) => _$TantoKyoinModelFromJson(json);
}
