// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthStatusModelAdapter extends TypeAdapter<_$HealthStatusModelImpl> {
  @override
  final int typeId = 7;

  @override
  _$HealthStatusModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$HealthStatusModelImpl(
      kokyoDate: fields[0] as DateTime?,
      jokyoCode: fields[1] as String?,
      ryaku: fields[2] as String?,
      jiyu1Code: fields[3] as String?,
      jiyu1: fields[4] as String?,
      jiyu2: fields[5] as String?,
      isEditable: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, _$HealthStatusModelImpl obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.kokyoDate)
      ..writeByte(1)
      ..write(obj.jokyoCode)
      ..writeByte(2)
      ..write(obj.ryaku)
      ..writeByte(3)
      ..write(obj.jiyu1Code)
      ..writeByte(4)
      ..write(obj.jiyu1)
      ..writeByte(5)
      ..write(obj.jiyu2)
      ..writeByte(6)
      ..write(obj.isEditable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthStatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthStatusModelImpl _$$HealthStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthStatusModelImpl(
      kokyoDate:
          json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
      jokyoCode: json['JokyoCode'] as String?,
      ryaku: json['Ryaku'] as String?,
      jiyu1Code: json['Jiyu1Code'] as String?,
      jiyu1: json['Jiyu1'] as String?,
      jiyu2: json['Jiyu2'] as String?,
      isEditable: json['IsEditable'] as bool?,
    );

Map<String, dynamic> _$$HealthStatusModelImplToJson(
        _$HealthStatusModelImpl instance) =>
    <String, dynamic>{
      'Date': instance.kokyoDate?.toIso8601String(),
      'JokyoCode': instance.jokyoCode,
      'Ryaku': instance.ryaku,
      'Jiyu1Code': instance.jiyu1Code,
      'Jiyu1': instance.jiyu1,
      'Jiyu2': instance.jiyu2,
      'IsEditable': instance.isEditable,
    };
