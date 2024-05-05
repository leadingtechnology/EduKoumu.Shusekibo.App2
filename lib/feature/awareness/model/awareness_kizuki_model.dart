import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/awareness/model/kizuki_comment_model.dart';
import 'package:kyoumutechou/feature/common/model/tenpu_model.dart';

part 'awareness_kizuki_model.freezed.dart';
part 'awareness_kizuki_model.g.dart';

List<AwarenessKizukiModel> awarenessKizukiListFromJson(List<dynamic> data) =>
    List<AwarenessKizukiModel>.from(data.map((x) => 
    AwarenessKizukiModel.fromJson(x as Map<String, dynamic>),),);

AwarenessKizukiModel awarenessKizukiFromJson(String str) => 
AwarenessKizukiModel.fromJson(json.decode(str) as Map<String, dynamic>);



@freezed
abstract class AwarenessKizukiModel with _$AwarenessKizukiModel {
  @HiveType(typeId: 35, adapterName: 'AwarenessKizukiModelAdapter')
  const factory AwarenessKizukiModel({

    @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
    @JsonKey(name: 'Nendo', disallowNullValue: false) @HiveField(1) String? nendo,
    @JsonKey(name: 'KaruteSettingId', disallowNullValue: false) @HiveField(2) int? karuteSettingId,
    @JsonKey(name: 'ShubetsuCode', disallowNullValue: false) @HiveField(3) String? shubetsuCode,
    @JsonKey(name: 'ShubetsuName', disallowNullValue: false) @HiveField(4) String? shubetsuName,
    @JsonKey(name: 'BunruiCode', disallowNullValue: false) @HiveField(5) String? bunruiCode,
    @JsonKey(name: 'BunruiName', disallowNullValue: false) @HiveField(6) String? bunruiName,
    @JsonKey(name: 'Naiyou', disallowNullValue: false) @HiveField(7) String? naiyou,
    @JsonKey(name: 'GakkiId', disallowNullValue: false) @HiveField(8) int? gakkiId,
    @JsonKey(name: 'GakkiName', disallowNullValue: false) @HiveField(9) String? gakkiName,
    @JsonKey(name: 'Gakunen', disallowNullValue: false) @HiveField(10) String? gakunen,
    @JsonKey(name: 'ShozokuId', disallowNullValue: false) @HiveField(11) int? shozokuId,
    @JsonKey(name: 'ShozokuBunrui', disallowNullValue: false) @HiveField(12) String? shozokuBunrui,
    @JsonKey(name: 'ShozokuKbn', disallowNullValue: false) @HiveField(13) String? shozokuKbn,
    @JsonKey(name: 'ShozokuCode', disallowNullValue: false) @HiveField(14) String? shozokuCode,
    @JsonKey(name: 'ClassName', disallowNullValue: false) @HiveField(15) String? className,
    @JsonKey(name: 'ShussekiNo', disallowNullValue: false) @HiveField(16) String? shussekiNo,
    @JsonKey(name: 'StudentId', disallowNullValue: false) @HiveField(17) int? studentId,
    @JsonKey(name: 'SeitoSeq', disallowNullValue: false) @HiveField(18) String? seitoSeq,
    @JsonKey(name: 'StudentName', disallowNullValue: false) @HiveField(19) String? studentName,
    
    @JsonKey(name: 'GenderCode', disallowNullValue: false) @HiveField(20) String? genderCode,

    @JsonKey(name: 'ExistPhoto', disallowNullValue: false) @HiveField(21) bool? existPhoto,
    @JsonKey(name: 'PhotoUrl', disallowNullValue: false) @HiveField(22) String? photoUrl,

    @JsonKey(name: 'TourokusyaId', disallowNullValue: false) @HiveField(23) int? tourokusyaId,
    @JsonKey(name: 'TourokusyaName', disallowNullValue: false) @HiveField(24) String? tourokusyaName,
    @JsonKey(name: 'JuyoFlg', disallowNullValue: false) @HiveField(25) bool? juyoFlg,
    @JsonKey(name: 'TorokuDate', disallowNullValue: false) @HiveField(26) String? torokuDate,
    @JsonKey(name: 'HasAttachment', disallowNullValue: false) @HiveField(27) bool? hasAttachment,
    @JsonKey(name: 'TenpuFileList', disallowNullValue: false) @HiveField(28) List<TenpuModel>? tenpuFileList,


    @JsonKey(name: 'CommentCount', disallowNullValue: false) @HiveField(29) int? commentCount,
    @JsonKey(name: 'CommentList', disallowNullValue: false) @HiveField(30) List<KizukiCommentModel>? commentList,

    @JsonKey(name: 'CreateDate', disallowNullValue: false) @HiveField(31) DateTime? createDate,
    @JsonKey(name: 'UpdateDate', disallowNullValue: false) @HiveField(32) DateTime? updateDate,
    @JsonKey(name: 'TimeStamp', disallowNullValue: false) @HiveField(33) String? timeStamp,



  }) = _AwarenessKizukiModel;

  @override
  String toString() {
    return 'AwarenessKizukiModel($id, $nendo, $karuteSettingId, $shubetsuCode, $shubetsuName, $bunruiCode, $bunruiName, $naiyou, $gakkiId, $gakkiName, $gakunen, $shozokuId, $shozokuBunrui, $shozokuKbn, $shozokuCode, $className, $shussekiNo, $studentId, $seitoSeq, $studentName, $genderCode, $existPhoto, $photoUrl, $tourokusyaId, $tourokusyaName, $juyoFlg, $torokuDate, $hasAttachment, $tenpuFileList, $commentCount, $commentList, $createDate, $updateDate, $timeStamp)';
  }
  factory AwarenessKizukiModel.fromJson(Map<String, dynamic> json) => _$AwarenessKizukiModelFromJson(json);
}
