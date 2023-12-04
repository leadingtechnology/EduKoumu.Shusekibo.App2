// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dantai_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DantaiModelAdapter extends TypeAdapter<_$DantaiModelImpl> {
  @override
  final int typeId = 2;

  @override
  _$DantaiModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$DantaiModelImpl(
      organizationBunrui: fields[0] as String?,
      organizationKbn: fields[1] as String?,
      id: fields[2] as int?,
      code: fields[3] as String?,
      name: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$DantaiModelImpl obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.organizationBunrui)
      ..writeByte(1)
      ..write(obj.organizationKbn)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DantaiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DantaiModelImpl _$$DantaiModelImplFromJson(Map<String, dynamic> json) =>
    _$DantaiModelImpl(
      organizationBunrui: json['OrganizationBunrui'] as String?,
      organizationKbn: json['OrganizationKbn'] as String?,
      id: json['Id'] as int?,
      code: json['Code'] as String?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$$DantaiModelImplToJson(_$DantaiModelImpl instance) =>
    <String, dynamic>{
      'OrganizationBunrui': instance.organizationBunrui,
      'OrganizationKbn': instance.organizationKbn,
      'Id': instance.id,
      'Code': instance.code,
      'Name': instance.name,
    };
