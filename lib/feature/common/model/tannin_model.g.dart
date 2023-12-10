// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tannin_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TanninModelAdapter extends TypeAdapter<_$TanninModelImpl> {
  @override
  final int typeId = 43;

  @override
  _$TanninModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TanninModelImpl(
      gakunenCode: fields[0] as String?,
      className: fields[1] as String?,
      shozokuId: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, _$TanninModelImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.gakunenCode)
      ..writeByte(1)
      ..write(obj.className)
      ..writeByte(2)
      ..write(obj.shozokuId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TanninModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TanninModelImpl _$$TanninModelImplFromJson(Map<String, dynamic> json) =>
    _$TanninModelImpl(
      gakunenCode: json['GakunenCode'] as String?,
      className: json['ClassName'] as String?,
      shozokuId: json['ShozokuId'] as int?,
    );

Map<String, dynamic> _$$TanninModelImplToJson(_$TanninModelImpl instance) =>
    <String, dynamic>{
      'GakunenCode': instance.gakunenCode,
      'ClassName': instance.className,
      'ShozokuId': instance.shozokuId,
    };
