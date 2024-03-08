import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'kizuki_template_model.freezed.dart';
part 'kizuki_template_model.g.dart';

List<KizukiTemplateModel> kizukiTemplateListFromJson(List<dynamic> data) =>
    List<KizukiTemplateModel>.from(data.map(
      (x) => KizukiTemplateModel.fromJson(x as Map<String, dynamic>),),);

KizukiTemplateModel kizukiTemplateFromJson(String str) => 
KizukiTemplateModel.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class KizukiTemplateModel with _$KizukiTemplateModel {
  @HiveType(typeId: 49, adapterName: 'KizukiTemplateModelAdapter')
  const factory KizukiTemplateModel({

    @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
    @JsonKey(name: 'TenantId', disallowNullValue: false) @HiveField(1) int? tenantId,
    @JsonKey(name: 'KinyuKyoinId', disallowNullValue: false) @HiveField(2) int? kinyuKyoinId,
    @JsonKey(name: 'KinyuKyoinName', disallowNullValue: false) @HiveField(3) String? kinyuKyoinName,
    @JsonKey(name: 'KaruteSettingId', disallowNullValue: false) @HiveField(4) int? karuteSettingId,
    @JsonKey(name: 'KaruteShubetsuNaibuCode', disallowNullValue: false) @HiveField(5) String? karuteShubetsuNaibuCode,
    @JsonKey(name: 'KaruteBunruiCode', disallowNullValue: false) @HiveField(6) String? karuteBunruiCode,
    @JsonKey(name: 'Title', disallowNullValue: false) @HiveField(7) String? title,
    @JsonKey(name: 'KizukiTemplate', disallowNullValue: false) @HiveField(8) String? kizukiTemplate,
    @JsonKey(name: 'CommonFlg', disallowNullValue: false) @HiveField(9) bool? commonFlg,
    @JsonKey(name: 'ModifiedDateTime', disallowNullValue: false) @HiveField(10) String? modifiedDateTime,
    @JsonKey(name: 'CrtUserId', disallowNullValue: false) @HiveField(11) int? crtUserId,
    @JsonKey(name: 'CrtDateTime', disallowNullValue: false) @HiveField(12) DateTime? crtDateTime,
    @JsonKey(name: 'TIMESTAMP', disallowNullValue: false) @HiveField(13) String? timeStamp,
  }) = _KizukiTemplateModel;

  @override
  String toString() {
    return 'KizukiTemplateModel($id, $tenantId, $kinyuKyoinId, $kinyuKyoinName, $karuteSettingId, $karuteShubetsuNaibuCode, $karuteBunruiCode, $title, $kizukiTemplate, $commonFlg, $modifiedDateTime, $crtUserId, $crtDateTime, $timeStamp)';
  }
  factory KizukiTemplateModel.fromJson(Map<String, dynamic> json) => _$KizukiTemplateModelFromJson(json);
}
