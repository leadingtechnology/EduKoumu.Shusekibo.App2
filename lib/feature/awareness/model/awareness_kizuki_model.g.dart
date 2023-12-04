// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'awareness_kizuki_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AwarenessKizukiModelAdapter
    extends TypeAdapter<_$AwarenessKizukiModelImpl> {
  @override
  final int typeId = 35;

  @override
  _$AwarenessKizukiModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AwarenessKizukiModelImpl(
      id: fields[0] as int?,
      nendo: fields[1] as String?,
      karuteSettingId: fields[2] as int?,
      shubetsuCode: fields[3] as String?,
      shubetsuName: fields[4] as String?,
      bunruiCode: fields[5] as String?,
      bunruiName: fields[6] as String?,
      naiyou: fields[7] as String?,
      gakkiId: fields[8] as int?,
      gakkiName: fields[9] as String?,
      gakunen: fields[10] as String?,
      shozokuId: fields[11] as int?,
      shozokuBunrui: fields[12] as String?,
      shozokuKbn: fields[13] as String?,
      shozokuCode: fields[14] as String?,
      className: fields[15] as String?,
      shussekiNo: fields[16] as String?,
      studentId: fields[17] as int?,
      seitoSeq: fields[18] as String?,
      studentName: fields[19] as String?,
      existPhoto: fields[20] as bool?,
      tourokusyaId: fields[21] as int?,
      tourokusyaName: fields[22] as String?,
      juyoFlg: fields[23] as bool?,
      torokuDate: fields[24] as String?,
      hasAttachment: fields[25] as bool?,
      commentCount: fields[26] as int?,
      createDate: fields[27] as DateTime?,
      updateDate: fields[28] as DateTime?,
      timeStamp: fields[29] as String?,
      photoUrl: fields[30] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$AwarenessKizukiModelImpl obj) {
    writer
      ..writeByte(31)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nendo)
      ..writeByte(2)
      ..write(obj.karuteSettingId)
      ..writeByte(3)
      ..write(obj.shubetsuCode)
      ..writeByte(4)
      ..write(obj.shubetsuName)
      ..writeByte(5)
      ..write(obj.bunruiCode)
      ..writeByte(6)
      ..write(obj.bunruiName)
      ..writeByte(7)
      ..write(obj.naiyou)
      ..writeByte(8)
      ..write(obj.gakkiId)
      ..writeByte(9)
      ..write(obj.gakkiName)
      ..writeByte(10)
      ..write(obj.gakunen)
      ..writeByte(11)
      ..write(obj.shozokuId)
      ..writeByte(12)
      ..write(obj.shozokuBunrui)
      ..writeByte(13)
      ..write(obj.shozokuKbn)
      ..writeByte(14)
      ..write(obj.shozokuCode)
      ..writeByte(15)
      ..write(obj.className)
      ..writeByte(16)
      ..write(obj.shussekiNo)
      ..writeByte(17)
      ..write(obj.studentId)
      ..writeByte(18)
      ..write(obj.seitoSeq)
      ..writeByte(19)
      ..write(obj.studentName)
      ..writeByte(20)
      ..write(obj.existPhoto)
      ..writeByte(21)
      ..write(obj.tourokusyaId)
      ..writeByte(22)
      ..write(obj.tourokusyaName)
      ..writeByte(23)
      ..write(obj.juyoFlg)
      ..writeByte(24)
      ..write(obj.torokuDate)
      ..writeByte(25)
      ..write(obj.hasAttachment)
      ..writeByte(26)
      ..write(obj.commentCount)
      ..writeByte(27)
      ..write(obj.createDate)
      ..writeByte(28)
      ..write(obj.updateDate)
      ..writeByte(29)
      ..write(obj.timeStamp)
      ..writeByte(30)
      ..write(obj.photoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AwarenessKizukiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
