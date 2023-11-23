// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'awareness_kizuki_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AwarenessKizukiModelImpl _$$AwarenessKizukiModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AwarenessKizukiModelImpl(
      id: json['Id'] as int?,
      nendo: json['Nendo'] as String?,
      karuteSettingId: json['KaruteSettingId'] as int?,
      shubetsuCode: json['ShubetsuCode'] as String?,
      shubetsuName: json['ShubetsuName'] as String?,
      bunruiCode: json['BunruiCode'] as String?,
      bunruiName: json['BunruiName'] as String?,
      naiyou: json['Naiyou'] as String?,
      gakkiId: json['GakkiId'] as int?,
      gakkiName: json['GakkiName'] as String?,
      gakunen: json['Gakunen'] as String?,
      shozokuId: json['ShozokuId'] as int?,
      shozokuBunrui: json['ShozokuBunrui'] as String?,
      shozokuKbn: json['ShozokuKbn'] as String?,
      shozokuCode: json['ShozokuCode'] as String?,
      className: json['ClassName'] as String?,
      shussekiNo: json['ShussekiNo'] as String?,
      studentId: json['StudentId'] as int?,
      seitoSeq: json['SeitoSeq'] as String?,
      studentName: json['StudentName'] as String?,
      existPhoto: json['ExistPhoto'] as bool?,
      tourokusyaId: json['TourokusyaId'] as int?,
      tourokusyaName: json['TourokusyaName'] as String?,
      juyoFlg: json['JuyoFlg'] as bool?,
      torokuDate: json['TorokuDate'] as String?,
      hasAttachment: json['HasAttachment'] as bool?,
      commentCount: json['CommentCount'] as int?,
      createDate: json['CreateDate'] == null
          ? null
          : DateTime.parse(json['CreateDate'] as String),
      updateDate: json['UpdateDate'] == null
          ? null
          : DateTime.parse(json['UpdateDate'] as String),
      timeStamp: json['TimeStamp'] as String?,
      photoUrl: json['PhotoUrl'] as String?,
    );

Map<String, dynamic> _$$AwarenessKizukiModelImplToJson(
        _$AwarenessKizukiModelImpl instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Nendo': instance.nendo,
      'KaruteSettingId': instance.karuteSettingId,
      'ShubetsuCode': instance.shubetsuCode,
      'ShubetsuName': instance.shubetsuName,
      'BunruiCode': instance.bunruiCode,
      'BunruiName': instance.bunruiName,
      'Naiyou': instance.naiyou,
      'GakkiId': instance.gakkiId,
      'GakkiName': instance.gakkiName,
      'Gakunen': instance.gakunen,
      'ShozokuId': instance.shozokuId,
      'ShozokuBunrui': instance.shozokuBunrui,
      'ShozokuKbn': instance.shozokuKbn,
      'ShozokuCode': instance.shozokuCode,
      'ClassName': instance.className,
      'ShussekiNo': instance.shussekiNo,
      'StudentId': instance.studentId,
      'SeitoSeq': instance.seitoSeq,
      'StudentName': instance.studentName,
      'ExistPhoto': instance.existPhoto,
      'TourokusyaId': instance.tourokusyaId,
      'TourokusyaName': instance.tourokusyaName,
      'JuyoFlg': instance.juyoFlg,
      'TorokuDate': instance.torokuDate,
      'HasAttachment': instance.hasAttachment,
      'CommentCount': instance.commentCount,
      'CreateDate': instance.createDate?.toIso8601String(),
      'UpdateDate': instance.updateDate?.toIso8601String(),
      'TimeStamp': instance.timeStamp,
      'PhotoUrl': instance.photoUrl,
    };
