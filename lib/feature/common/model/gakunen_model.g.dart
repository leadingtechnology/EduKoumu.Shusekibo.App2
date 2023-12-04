// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gakunen_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GakunenModelAdapter extends TypeAdapter<_$GakunenModelImpl> {
  @override
  final int typeId = 3;

  @override
  _$GakunenModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$GakunenModelImpl(
      organizationId: fields[0] as int?,
      gakunenCode: fields[1] as String?,
      gakunenName: fields[2] as String?,
      gakunenRyakusho: fields[3] as String?,
      kateiKbn: fields[4] as String?,
      zaisekiAgeLowLimit: fields[5] as int?,
      isTantoGakunen: fields[6] as bool?,
      id: fields[7] as int?,
      code: fields[8] as String?,
      name: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$GakunenModelImpl obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.organizationId)
      ..writeByte(1)
      ..write(obj.gakunenCode)
      ..writeByte(2)
      ..write(obj.gakunenName)
      ..writeByte(3)
      ..write(obj.gakunenRyakusho)
      ..writeByte(4)
      ..write(obj.kateiKbn)
      ..writeByte(5)
      ..write(obj.zaisekiAgeLowLimit)
      ..writeByte(6)
      ..write(obj.isTantoGakunen)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.code)
      ..writeByte(9)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GakunenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GakunenModelImpl _$$GakunenModelImplFromJson(Map<String, dynamic> json) =>
    _$GakunenModelImpl(
      organizationId: json['OrganizationId'] as int?,
      gakunenCode: json['GakunenCode'] as String?,
      gakunenName: json['GakunenName'] as String?,
      gakunenRyakusho: json['GakunenRyakusho'] as String?,
      kateiKbn: json['KateiKbn'] as String?,
      zaisekiAgeLowLimit: json['ZaisekiAgeLowLimit'] as int?,
      isTantoGakunen: json['IsTantoGakunen'] as bool?,
      id: json['Id'] as int?,
      code: json['Code'] as String?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$$GakunenModelImplToJson(_$GakunenModelImpl instance) =>
    <String, dynamic>{
      'OrganizationId': instance.organizationId,
      'GakunenCode': instance.gakunenCode,
      'GakunenName': instance.gakunenName,
      'GakunenRyakusho': instance.gakunenRyakusho,
      'KateiKbn': instance.kateiKbn,
      'ZaisekiAgeLowLimit': instance.zaisekiAgeLowLimit,
      'IsTantoGakunen': instance.isTantoGakunen,
      'Id': instance.id,
      'Code': instance.code,
      'Name': instance.name,
    };
