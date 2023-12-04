// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shozoku_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShozokuModelAdapter extends TypeAdapter<_$ShozokuModelImpl> {
  @override
  final int typeId = 4;

  @override
  _$ShozokuModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$ShozokuModelImpl(
      organizationCode: fields[0] as String?,
      organizationId: fields[1] as int?,
      nendo: fields[2] as String?,
      gakunenCode: fields[3] as String?,
      classId: fields[4] as int?,
      classBunrui: fields[5] as String?,
      classKbn: fields[6] as String?,
      classCode: fields[7] as String?,
      className: fields[8] as String?,
      shozokuId: fields[9] as int?,
      shozokuCode: fields[10] as String?,
      isGakuseki: fields[11] as bool?,
      isTokubetsuShien: fields[12] as bool?,
      hyojijun: fields[13] as int?,
      isTanninClass: fields[14] as bool?,
      isTantoClass: fields[15] as bool?,
      id: fields[16] as int?,
      code: fields[17] as String?,
      name: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$ShozokuModelImpl obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.organizationCode)
      ..writeByte(1)
      ..write(obj.organizationId)
      ..writeByte(2)
      ..write(obj.nendo)
      ..writeByte(3)
      ..write(obj.gakunenCode)
      ..writeByte(4)
      ..write(obj.classId)
      ..writeByte(5)
      ..write(obj.classBunrui)
      ..writeByte(6)
      ..write(obj.classKbn)
      ..writeByte(7)
      ..write(obj.classCode)
      ..writeByte(8)
      ..write(obj.className)
      ..writeByte(9)
      ..write(obj.shozokuId)
      ..writeByte(10)
      ..write(obj.shozokuCode)
      ..writeByte(11)
      ..write(obj.isGakuseki)
      ..writeByte(12)
      ..write(obj.isTokubetsuShien)
      ..writeByte(13)
      ..write(obj.hyojijun)
      ..writeByte(14)
      ..write(obj.isTanninClass)
      ..writeByte(15)
      ..write(obj.isTantoClass)
      ..writeByte(16)
      ..write(obj.id)
      ..writeByte(17)
      ..write(obj.code)
      ..writeByte(18)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShozokuModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShozokuModelImpl _$$ShozokuModelImplFromJson(Map<String, dynamic> json) =>
    _$ShozokuModelImpl(
      organizationCode: json['OrganizationCode'] as String?,
      organizationId: json['OrganizationId'] as int?,
      nendo: json['Nendo'] as String?,
      gakunenCode: json['GakunenCode'] as String?,
      classId: json['ClassId'] as int?,
      classBunrui: json['ClassBunrui'] as String?,
      classKbn: json['ClassKbn'] as String?,
      classCode: json['ClassCode'] as String?,
      className: json['ClassName'] as String?,
      shozokuId: json['ShozokuId'] as int?,
      shozokuCode: json['ShozokuCode'] as String?,
      isGakuseki: json['IsGakuseki'] as bool?,
      isTokubetsuShien: json['IsTokubetsuShien'] as bool?,
      hyojijun: json['Hyojijun'] as int?,
      isTanninClass: json['IsTanninClass'] as bool?,
      isTantoClass: json['IsTantoClass'] as bool?,
      id: json['Id'] as int?,
      code: json['Code'] as String?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$$ShozokuModelImplToJson(_$ShozokuModelImpl instance) =>
    <String, dynamic>{
      'OrganizationCode': instance.organizationCode,
      'OrganizationId': instance.organizationId,
      'Nendo': instance.nendo,
      'GakunenCode': instance.gakunenCode,
      'ClassId': instance.classId,
      'ClassBunrui': instance.classBunrui,
      'ClassKbn': instance.classKbn,
      'ClassCode': instance.classCode,
      'ClassName': instance.className,
      'ShozokuId': instance.shozokuId,
      'ShozokuCode': instance.shozokuCode,
      'IsGakuseki': instance.isGakuseki,
      'IsTokubetsuShien': instance.isTokubetsuShien,
      'Hyojijun': instance.hyojijun,
      'IsTanninClass': instance.isTanninClass,
      'IsTantoClass': instance.isTantoClass,
      'Id': instance.id,
      'Code': instance.code,
      'Name': instance.name,
    };
