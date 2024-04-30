import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'teacher_model.freezed.dart';
part 'teacher_model.g.dart';

List<TeacherModel> teacherListFromJson(List<dynamic> data) =>
    List<TeacherModel>.from(
        data.map((x) => TeacherModel.fromJson(x as Map<String, dynamic>)),);

TeacherModel teacherFromJson(String str) =>
    TeacherModel.fromJson(json.decode(str) as Map<String, dynamic>);


@freezed
abstract class TeacherModel with _$TeacherModel {
  @HiveType(typeId: 51, adapterName: 'TeacherModelAdapter')
  const factory TeacherModel({

    @JsonKey(name: 'DantaiBunrui', disallowNullValue: false) @HiveField(0) String? dantaiBunrui,
    @JsonKey(name: 'DantaiKbn', disallowNullValue: false) @HiveField(1) String? dantaiKbn,
    @JsonKey(name: 'DantaiCode', disallowNullValue: false) @HiveField(2) String? dantaiCode,
    @JsonKey(name: 'SchoolId', disallowNullValue: false) @HiveField(3) int? schoolId,
    @JsonKey(name: 'ShozokuId', disallowNullValue: false) @HiveField(4) int? shozokuId,
    @JsonKey(name: 'MemberId', disallowNullValue: false) @HiveField(5) int? memberId,
    @JsonKey(name: 'TeacherKihonId', disallowNullValue: false) @HiveField(6) int? teacherKihonId,
    @JsonKey(name: 'UserId', disallowNullValue: false) @HiveField(7) String? userId,
    @JsonKey(name: 'LoginId', disallowNullValue: false) @HiveField(8) String? loginId,
    @JsonKey(name: 'KyoinID', disallowNullValue: false) @HiveField(9) String? kyoinID,
    @JsonKey(name: 'ShokushuCd', disallowNullValue: false) @HiveField(10) String? shokushuCd,
    @JsonKey(name: 'SeiTsushoName', disallowNullValue: false) @HiveField(11) String? seiTsushoName,
    @JsonKey(name: 'MeiTsushoName', disallowNullValue: false) @HiveField(12) String? meiTsushoName,
    @JsonKey(name: 'TeacherTsushoName', disallowNullValue: false) @HiveField(13) String? teacherTsushoName,
    @JsonKey(name: 'SeiTsushoKana', disallowNullValue: false) @HiveField(14) String? seiTsushoKana,
    @JsonKey(name: 'MeiTsushoKana', disallowNullValue: false) @HiveField(15) String? meiTsushoKana,
    @JsonKey(name: 'TeacherTsushoNameKana', disallowNullValue: false) @HiveField(16) String? teacherTsushoNameKana,
    @JsonKey(name: 'SeiSeishikiName', disallowNullValue: false) @HiveField(17) String? seiSeishikiName,
    @JsonKey(name: 'MeiSeishikiName', disallowNullValue: false) @HiveField(18) String? meiSeishikiName,
    @JsonKey(name: 'TeacherSeishikiName', disallowNullValue: false) @HiveField(19) String? teacherSeishikiName,
    @JsonKey(name: 'SeiSeishikiKana', disallowNullValue: false) @HiveField(20) String? seiSeishikiKana,
    @JsonKey(name: 'MeiSeishikiKana', disallowNullValue: false) @HiveField(21) String? meiSeishikiKana,
    @JsonKey(name: 'TeacherSeishikiNameKana', disallowNullValue: false) @HiveField(22) String? teacherSeishikiNameKana,
    @JsonKey(name: 'SeibetsuCode', disallowNullValue: false) @HiveField(23) String? seibetsuCode,
    @JsonKey(name: 'YubinNo', disallowNullValue: false) @HiveField(24) String? yubinNo,
    @JsonKey(name: 'Address1', disallowNullValue: false) @HiveField(25) String? address1,
    @JsonKey(name: 'TelNo', disallowNullValue: false) @HiveField(26) String? telNo,
    @JsonKey(name: 'TelNoKeitai', disallowNullValue: false) @HiveField(27) String? telNoKeitai,
    @JsonKey(name: 'KaishiDate', disallowNullValue: false) @HiveField(28) DateTime? kaishiDate,
    @JsonKey(name: 'ShuryoDate', disallowNullValue: false) @HiveField(29) DateTime? shuryoDate,
    @JsonKey(name: 'OperatorUserId', disallowNullValue: false) @HiveField(30) int? operatorUserId,
    @JsonKey(name: 'TenantId', disallowNullValue: false) @HiveField(31) int? tenantId,
    @JsonKey(name: 'DantaiId', disallowNullValue: false) @HiveField(32) int? dantaiId,
  }) = _TeacherModel;

  @override
  String toString() {
    return 'TeacherModel($dantaiBunrui, $dantaiKbn, $dantaiCode, $schoolId, $shozokuId, $memberId, $teacherKihonId, $userId, $loginId, $kyoinID, $shokushuCd, $seiTsushoName, $meiTsushoName, $teacherTsushoName, $seiTsushoKana, $meiTsushoKana, $teacherTsushoNameKana, $seiSeishikiName, $meiSeishikiName, $teacherSeishikiName, $seiSeishikiKana, $meiSeishikiKana, $teacherSeishikiNameKana, $seibetsuCode, $yubinNo, $address1, $telNo, $telNoKeitai, $kaishiDate, $shuryoDate, $operatorUserId, $tenantId, $dantaiId)';
  }
  factory TeacherModel.fromJson(Map<String, dynamic> json) => _$TeacherModelFromJson(json);
}
