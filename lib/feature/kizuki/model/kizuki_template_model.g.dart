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
      karuteSettingId: fields[3] as int?,
      karuteShubetsuNaibuCode: fields[4] as String?,
      karuteBunruiCode: fields[5] as String?,
      title: fields[6] as String?,
      kizukiTemplate: fields[7] as String?,
      commonFlg: fields[8] as bool?,
      modifiedDateTime: fields[9] as String?,
      timeStamp: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$KizukiTemplateModelImpl obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tenantId)
      ..writeByte(2)
      ..write(obj.kinyuKyoinId)
      ..writeByte(3)
      ..write(obj.karuteSettingId)
      ..writeByte(4)
      ..write(obj.karuteShubetsuNaibuCode)
      ..writeByte(5)
      ..write(obj.karuteBunruiCode)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.kizukiTemplate)
      ..writeByte(8)
      ..write(obj.commonFlg)
      ..writeByte(9)
      ..write(obj.modifiedDateTime)
      ..writeByte(10)
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
      karuteSettingId: json['KaruteSettingId'] as int?,
      karuteShubetsuNaibuCode: json['KaruteShubetsuNaibuCode'] as String?,
      karuteBunruiCode: json['KaruteBunruiCode'] as String?,
      title: json['Title'] as String?,
      kizukiTemplate: json['KizukiTemplate'] as String?,
      commonFlg: json['CommonFlg'] as bool?,
      modifiedDateTime: json['ModifiedDateTime'] as String?,
      timeStamp: json['TIMESTAMP'] as String?,
    );

Map<String, dynamic> _$$KizukiTemplateModelImplToJson(
        _$KizukiTemplateModelImpl instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'TenantId': instance.tenantId,
      'KinyuKyoinId': instance.kinyuKyoinId,
      'KaruteSettingId': instance.karuteSettingId,
      'KaruteShubetsuNaibuCode': instance.karuteShubetsuNaibuCode,
      'KaruteBunruiCode': instance.karuteBunruiCode,
      'Title': instance.title,
      'KizukiTemplate': instance.kizukiTemplate,
      'CommonFlg': instance.commonFlg,
      'ModifiedDateTime': instance.modifiedDateTime,
      'TIMESTAMP': instance.timeStamp,
    };
