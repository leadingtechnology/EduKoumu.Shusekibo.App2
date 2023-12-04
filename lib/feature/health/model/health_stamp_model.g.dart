// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_stamp_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthStampModelAdapter extends TypeAdapter<_$HealthStampModelImpl> {
  @override
  final int typeId = 5;

  @override
  _$HealthStampModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$HealthStampModelImpl(
      jokyoCd: fields[0] as String?,
      bunrui: fields[1] as String?,
      kubun: fields[2] as String?,
      jokyoNmSeishiki: fields[3] as String?,
      jokyoNmRyaku: fields[4] as String?,
      jokyoNmTsu: fields[5] as String?,
      jokyoKey: fields[6] as String?,
      shukketsuBunrui: fields[7] as String?,
      shukketsuKubun: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$HealthStampModelImpl obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.jokyoCd)
      ..writeByte(1)
      ..write(obj.bunrui)
      ..writeByte(2)
      ..write(obj.kubun)
      ..writeByte(3)
      ..write(obj.jokyoNmSeishiki)
      ..writeByte(4)
      ..write(obj.jokyoNmRyaku)
      ..writeByte(5)
      ..write(obj.jokyoNmTsu)
      ..writeByte(6)
      ..write(obj.jokyoKey)
      ..writeByte(7)
      ..write(obj.shukketsuBunrui)
      ..writeByte(8)
      ..write(obj.shukketsuKubun);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthStampModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthStampModelImpl _$$HealthStampModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthStampModelImpl(
      jokyoCd: json['JokyoCd'] as String?,
      bunrui: json['Bunrui'] as String?,
      kubun: json['Kubun'] as String?,
      jokyoNmSeishiki: json['JokyoNmSeishiki'] as String?,
      jokyoNmRyaku: json['JokyoNmRyaku'] as String?,
      jokyoNmTsu: json['JokyoNmTsu'] as String?,
      jokyoKey: json['JokyoKey'] as String?,
      shukketsuBunrui: json['ShukketsuBunrui'] as String?,
      shukketsuKubun: json['ShukketsuKubun'] as String?,
    );

Map<String, dynamic> _$$HealthStampModelImplToJson(
        _$HealthStampModelImpl instance) =>
    <String, dynamic>{
      'JokyoCd': instance.jokyoCd,
      'Bunrui': instance.bunrui,
      'Kubun': instance.kubun,
      'JokyoNmSeishiki': instance.jokyoNmSeishiki,
      'JokyoNmRyaku': instance.jokyoNmRyaku,
      'JokyoNmTsu': instance.jokyoNmTsu,
      'JokyoKey': instance.jokyoKey,
      'ShukketsuBunrui': instance.shukketsuBunrui,
      'ShukketsuKubun': instance.shukketsuKubun,
    };
