// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kizuki_template_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KizukiTemplateModelAdapter
    extends TypeAdapter<_$KizukiTemplateModelImpl> {
  @override
  final int typeId = 49;

  @override
  _$KizukiTemplateModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$KizukiTemplateModelImpl(
      id: fields[0] as int?,
      tenantId: fields[1] as int?,
      kinyuKyoinId: fields[2] as int?,
      kinyuKyoinName: fields[3] as String?,
      karuteSettingId: fields[4] as int?,
      karuteShubetsuNaibuCode: fields[5] as String?,
      karuteBunruiCode: fields[6] as String?,
      title: fields[7] as String?,
      kizukiTemplate: fields[8] as String?,
      commonFlg: fields[9] as bool?,
      modifiedDateTime: fields[10] as String?,
      crtUserId: fields[11] as int?,
      crtDateTime: fields[12] as DateTime?,
      timeStamp: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$KizukiTemplateModelImpl obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tenantId)
      ..writeByte(2)
      ..write(obj.kinyuKyoinId)
      ..writeByte(3)
      ..write(obj.kinyuKyoinName)
      ..writeByte(4)
      ..write(obj.karuteSettingId)
      ..writeByte(5)
      ..write(obj.karuteShubetsuNaibuCode)
      ..writeByte(6)
      ..write(obj.karuteBunruiCode)
      ..writeByte(7)
      ..write(obj.title)
      ..writeByte(8)
      ..write(obj.kizukiTemplate)
      ..writeByte(9)
      ..write(obj.commonFlg)
      ..writeByte(10)
      ..write(obj.modifiedDateTime)
      ..writeByte(11)
      ..write(obj.crtUserId)
      ..writeByte(12)
      ..write(obj.crtDateTime)
      ..writeByte(13)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KizukiTemplateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KizukiTemplateModelImpl _$$KizukiTemplateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$KizukiTemplateModelImpl(
      id: json['Id'] as int?,
      tenantId: json['TenantId'] as int?,
      kinyuKyoinId: json['KinyuKyoinId'] as int?,
      kinyuKyoinName: json['KinyuKyoinName'] as String?,
      karuteSettingId: json['KaruteSettingId'] as int?,
      karuteShubetsuNaibuCode: json['KaruteShubetsuNaibuCode'] as String?,
      karuteBunruiCode: json['KaruteBunruiCode'] as String?,
      title: json['Title'] as String?,
      kizukiTemplate: json['KizukiTemplate'] as String?,
      commonFlg: json['CommonFlg'] as bool?,
      modifiedDateTime: json['ModifiedDateTime'] as String?,
      crtUserId: json['CrtUserId'] as int?,
      crtDateTime: json['CrtDateTime'] == null
          ? null
          : DateTime.parse(json['CrtDateTime'] as String),
      timeStamp: json['TIMESTAMP'] as String?,
    );

Map<String, dynamic> _$$KizukiTemplateModelImplToJson(
        _$KizukiTemplateModelImpl instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'TenantId': instance.tenantId,
      'KinyuKyoinId': instance.kinyuKyoinId,
      'KinyuKyoinName': instance.kinyuKyoinName,
      'KaruteSettingId': instance.karuteSettingId,
      'KaruteShubetsuNaibuCode': instance.karuteShubetsuNaibuCode,
      'KaruteBunruiCode': instance.karuteBunruiCode,
      'Title': instance.title,
      'KizukiTemplate': instance.kizukiTemplate,
      'CommonFlg': instance.commonFlg,
      'ModifiedDateTime': instance.modifiedDateTime,
      'CrtUserId': instance.crtUserId,
      'CrtDateTime': instance.crtDateTime?.toIso8601String(),
      'TIMESTAMP': instance.timeStamp,
    };
