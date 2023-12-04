// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokobi_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokobiModelAdapter extends TypeAdapter<_$TokobiModelImpl> {
  @override
  final int typeId = 37;

  @override
  _$TokobiModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TokobiModelImpl(
      tokobi: fields[0] as DateTime?,
      yobiCd: fields[1] as String?,
      weekName: fields[2] as String?,
      jigen: fields[3] as int?,
      isToday: fields[4] as bool?,
      isEditable: fields[5] as bool?,
      stampedCount: fields[6] as int?,
      totalCount: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, _$TokobiModelImpl obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.tokobi)
      ..writeByte(1)
      ..write(obj.yobiCd)
      ..writeByte(2)
      ..write(obj.weekName)
      ..writeByte(3)
      ..write(obj.jigen)
      ..writeByte(4)
      ..write(obj.isToday)
      ..writeByte(5)
      ..write(obj.isEditable)
      ..writeByte(6)
      ..write(obj.stampedCount)
      ..writeByte(7)
      ..write(obj.totalCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokobiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokobiModelImpl _$$TokobiModelImplFromJson(Map<String, dynamic> json) =>
    _$TokobiModelImpl(
      tokobi:
          json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
      yobiCd: json['YobiCd'] as String?,
      weekName: json['WeekName'] as String?,
      jigen: json['Jigen'] as int?,
      isToday: json['IsToday'] as bool?,
      isEditable: json['IsEditable'] as bool?,
      stampedCount: json['StampedCount'] as int?,
      totalCount: json['TotalCount'] as int?,
    );

Map<String, dynamic> _$$TokobiModelImplToJson(_$TokobiModelImpl instance) =>
    <String, dynamic>{
      'Date': instance.tokobi?.toIso8601String(),
      'YobiCd': instance.yobiCd,
      'WeekName': instance.weekName,
      'Jigen': instance.jigen,
      'IsToday': instance.isToday,
      'IsEditable': instance.isEditable,
      'StampedCount': instance.stampedCount,
      'TotalCount': instance.totalCount,
    };
