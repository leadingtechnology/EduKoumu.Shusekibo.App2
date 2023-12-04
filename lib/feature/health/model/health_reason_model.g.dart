// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_reason_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthReasonModelAdapter extends TypeAdapter<_$HealthReasonModelImpl> {
  @override
  final int typeId = 6;

  @override
  _$HealthReasonModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$HealthReasonModelImpl(
      jokyoCd: fields[0] as String?,
      jiyuCd: fields[1] as String?,
      jiyuNmSeishiki: fields[2] as String?,
      jiyuNmRyaku: fields[3] as String?,
      kenkoFlg: fields[4] as bool?,
      delFlg: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, _$HealthReasonModelImpl obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.jokyoCd)
      ..writeByte(1)
      ..write(obj.jiyuCd)
      ..writeByte(2)
      ..write(obj.jiyuNmSeishiki)
      ..writeByte(3)
      ..write(obj.jiyuNmRyaku)
      ..writeByte(4)
      ..write(obj.kenkoFlg)
      ..writeByte(5)
      ..write(obj.delFlg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthReasonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthReasonModelImpl _$$HealthReasonModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthReasonModelImpl(
      jokyoCd: json['JokyoCd'] as String?,
      jiyuCd: json['JiyuCd'] as String?,
      jiyuNmSeishiki: json['JiyuNmSeishiki'] as String?,
      jiyuNmRyaku: json['JiyuNmRyaku'] as String?,
      kenkoFlg: json['KenkoFlg'] as bool?,
      delFlg: json['DelFlg'] as bool?,
    );

Map<String, dynamic> _$$HealthReasonModelImplToJson(
        _$HealthReasonModelImpl instance) =>
    <String, dynamic>{
      'JokyoCd': instance.jokyoCd,
      'JiyuCd': instance.jiyuCd,
      'JiyuNmSeishiki': instance.jiyuNmSeishiki,
      'JiyuNmRyaku': instance.jiyuNmRyaku,
      'KenkoFlg': instance.kenkoFlg,
      'DelFlg': instance.delFlg,
    };
