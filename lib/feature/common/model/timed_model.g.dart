// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timed_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimedModelAdapter extends TypeAdapter<_$TimedModelImpl> {
  @override
  final int typeId = 24;

  @override
  _$TimedModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TimedModelImpl(
      yobiCd: fields[0] as String?,
      jigenIdx: fields[1] as int?,
      ryaku: fields[2] as String?,
      nikkahyoShubetsuCode: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$TimedModelImpl obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.yobiCd)
      ..writeByte(1)
      ..write(obj.jigenIdx)
      ..writeByte(2)
      ..write(obj.ryaku)
      ..writeByte(3)
      ..write(obj.nikkahyoShubetsuCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimedModelImpl _$$TimedModelImplFromJson(Map<String, dynamic> json) =>
    _$TimedModelImpl(
      yobiCd: json['YobiCd'] as String?,
      jigenIdx: json['JigenIdx'] as int?,
      ryaku: json['Ryaku'] as String?,
      nikkahyoShubetsuCode: json['NikkahyoShubetsuCode'] as String?,
    );

Map<String, dynamic> _$$TimedModelImplToJson(_$TimedModelImpl instance) =>
    <String, dynamic>{
      'YobiCd': instance.yobiCd,
      'JigenIdx': instance.jigenIdx,
      'Ryaku': instance.ryaku,
      'NikkahyoShubetsuCode': instance.nikkahyoShubetsuCode,
    };
