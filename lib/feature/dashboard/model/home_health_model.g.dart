// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_health_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeHealthModelAdapter extends TypeAdapter<_$HomeHealthModelImpl> {
  @override
  final int typeId = 39;

  @override
  _$HomeHealthModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$HomeHealthModelImpl(
      className: fields[0] as String?,
      zaiseki: fields[1] as int?,
      shusseki: fields[2] as int?,
      tikoku: fields[3] as int?,
      sotai: fields[4] as int?,
      kessekiShuttei: fields[5] as int?,
      shuttei: fields[6] as int?,
      influenza: fields[7] as int?,
      doneKenkoKansatsuFlg: fields[8] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, _$HomeHealthModelImpl obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.className)
      ..writeByte(1)
      ..write(obj.zaiseki)
      ..writeByte(2)
      ..write(obj.shusseki)
      ..writeByte(3)
      ..write(obj.tikoku)
      ..writeByte(4)
      ..write(obj.sotai)
      ..writeByte(5)
      ..write(obj.kessekiShuttei)
      ..writeByte(6)
      ..write(obj.shuttei)
      ..writeByte(7)
      ..write(obj.influenza)
      ..writeByte(8)
      ..write(obj.doneKenkoKansatsuFlg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeHealthModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeHealthModelImpl _$$HomeHealthModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeHealthModelImpl(
      className: json['ClassName'] as String?,
      zaiseki: json['Zaiseki'] as int?,
      shusseki: json['Shusseki'] as int?,
      tikoku: json['Tikoku'] as int?,
      sotai: json['Sotai'] as int?,
      kessekiShuttei: json['KessekiShuttei'] as int?,
      shuttei: json['Shuttei'] as int?,
      influenza: json['Influenza'] as int?,
      doneKenkoKansatsuFlg: json['DoneKenkoKansatsuFlg'] as bool?,
    );

Map<String, dynamic> _$$HomeHealthModelImplToJson(
        _$HomeHealthModelImpl instance) =>
    <String, dynamic>{
      'ClassName': instance.className,
      'Zaiseki': instance.zaiseki,
      'Shusseki': instance.shusseki,
      'Tikoku': instance.tikoku,
      'Sotai': instance.sotai,
      'KessekiShuttei': instance.kessekiShuttei,
      'Shuttei': instance.shuttei,
      'Influenza': instance.influenza,
      'DoneKenkoKansatsuFlg': instance.doneKenkoKansatsuFlg,
    };
