import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'contact_linkage_model.freezed.dart';
part 'contact_linkage_model.g.dart';

List<ContactLinkageModel> contactLinkageListFromJson(List<dynamic> data) =>
    List<ContactLinkageModel>.from(data.map(
      (x) => ContactLinkageModel.fromJson(x as Map<String, dynamic>),),);

ContactLinkageModel contactLinkageFromJson(String str) => 
ContactLinkageModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class ContactLinkageModel with _$ContactLinkageModel {
  @HiveType(typeId: 50, adapterName: 'ContactLinkageModelAdapter')
  const factory ContactLinkageModel({
    @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
    @JsonKey(name: 'TenantId', disallowNullValue: false) @HiveField(1) int? tenantId,
    @JsonKey(name: 'DantaiName', disallowNullValue: false) @HiveField(2) String? dantaiName,
    @JsonKey(name: 'ShozokuId', disallowNullValue: false) @HiveField(3) int? shozokuId,
    @JsonKey(name: 'ShozokuName', disallowNullValue: false) @HiveField(4) String? shozokuName,
    @JsonKey(name: 'Nendo', disallowNullValue: false) @HiveField(5) String? nendo,
    @JsonKey(name: 'TaishoDate', disallowNullValue: false) @HiveField(6) DateTime? taishoDate,
    @JsonKey(name: 'RegistDateTime', disallowNullValue: false) @HiveField(7) DateTime? registDateTime,
    @JsonKey(name: 'MemberId', disallowNullValue: false) @HiveField(8) int? memberId,
    @JsonKey(name: 'StudentName', disallowNullValue: false) @HiveField(9) String? studentName,
    @JsonKey(name: 'ShussekiNo', disallowNullValue: false) @HiveField(10) String? shussekiNo,
    @JsonKey(name: 'RenkeiJokyoCd', disallowNullValue: false) @HiveField(11) String? renkeiJokyoCd,
    @JsonKey(name: 'RenkeiJokyo', disallowNullValue: false) @HiveField(12) String? renkeiJokyo,
    @JsonKey(name: 'Jiyu', disallowNullValue: false) @HiveField(13) String? jiyu,
    @JsonKey(name: 'Biko', disallowNullValue: false) @HiveField(14) String? biko,
    @JsonKey(name: 'RenkeiStatus', disallowNullValue: false) @HiveField(15) int? renkeiStatus,
    @JsonKey(name: 'ProcessStatus', disallowNullValue: false) @HiveField(16) int? processStatus,
    @JsonKey(name: 'DeleteFlg', disallowNullValue: false) @HiveField(17) bool? deleteFlg,
    @JsonKey(name: 'CrtUserId', disallowNullValue: false) @HiveField(18) int? crtUserId,
    @JsonKey(name: 'CrtUserName', disallowNullValue: false) @HiveField(19) String? crtUserName,
    @JsonKey(name: 'CrtDateTime', disallowNullValue: false) @HiveField(20) DateTime? crtDateTime,
  }) = _ContactLinkageModel;

  @override
  String toString() {
    return 'ContactLinkageModel($id, $tenantId, $dantaiName, $shozokuId, $shozokuName, $nendo, $taishoDate, $registDateTime, $memberId, $studentName, $shussekiNo, $renkeiJokyoCd, $renkeiJokyo, $jiyu, $biko, $renkeiStatus, $processStatus, $deleteFlg, $crtUserId, $crtUserName, $crtDateTime)';
  }
  factory ContactLinkageModel.fromJson(Map<String, dynamic> json) => _$ContactLinkageModelFromJson(json);
}

class ContactLinkageViewModel {
  ContactLinkageViewModel({
    required this.ids,
    required this.names,
    required this.no,
    required this.jyokyo,
    required this.strDate,
    required this.text,
  });

  List<int> ids;
  String names;
  String no;
  String jyokyo;
  String strDate; 
  String text; 
}
