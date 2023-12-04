// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'awareness_code_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AwarenessCodeModelAdapter extends TypeAdapter<_$AwarenessCodeModelImpl> {
  @override
  final int typeId = 33;

  @override
  _$AwarenessCodeModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AwarenessCodeModelImpl(
      id: fields[0] as int?,
      code: fields[1] as String?,
      name: fields[2] as String?,
      shortName: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$AwarenessCodeModelImpl obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.shortName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AwarenessCodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AwarenessCodeModelImpl _$$AwarenessCodeModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AwarenessCodeModelImpl(
      id: json['Id'] as int?,
      code: json['Code'] as String?,
      name: json['Name'] as String?,
      shortName: json['ShortName'] as String?,
    );

Map<String, dynamic> _$$AwarenessCodeModelImplToJson(
        _$AwarenessCodeModelImpl instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Code': instance.code,
      'Name': instance.name,
      'ShortName': instance.shortName,
    };
