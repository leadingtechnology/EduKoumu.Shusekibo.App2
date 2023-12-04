// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceStatusModelAdapter
    extends TypeAdapter<_$AttendanceStatusModelImpl> {
  @override
  final int typeId = 17;

  @override
  _$AttendanceStatusModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AttendanceStatusModelImpl(
      jokyoDate: fields[0] as DateTime?,
      jigenIdx: fields[1] as int?,
      ryaku: fields[2] as String?,
      shukketsuBunrui: fields[3] as String?,
      shukketsuKbn: fields[4] as String?,
      jiyu1: fields[5] as String?,
      jiyu2: fields[6] as String?,
      isEditable: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, _$AttendanceStatusModelImpl obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.jokyoDate)
      ..writeByte(1)
      ..write(obj.jigenIdx)
      ..writeByte(2)
      ..write(obj.ryaku)
      ..writeByte(3)
      ..write(obj.shukketsuBunrui)
      ..writeByte(4)
      ..write(obj.shukketsuKbn)
      ..writeByte(5)
      ..write(obj.jiyu1)
      ..writeByte(6)
      ..write(obj.jiyu2)
      ..writeByte(7)
      ..write(obj.isEditable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceStatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceStatusModelImpl _$$AttendanceStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceStatusModelImpl(
      jokyoDate:
          json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
      jigenIdx: json['JigenIdx'] as int?,
      ryaku: json['Ryaku'] as String?,
      shukketsuBunrui: json['ShukketsuBunrui'] as String?,
      shukketsuKbn: json['ShukketsuKbn'] as String?,
      jiyu1: json['Jiyu1'] as String?,
      jiyu2: json['Jiyu2'] as String?,
      isEditable: json['IsEditable'] as bool?,
    );

Map<String, dynamic> _$$AttendanceStatusModelImplToJson(
        _$AttendanceStatusModelImpl instance) =>
    <String, dynamic>{
      'Date': instance.jokyoDate?.toIso8601String(),
      'JigenIdx': instance.jigenIdx,
      'Ryaku': instance.ryaku,
      'ShukketsuBunrui': instance.shukketsuBunrui,
      'ShukketsuKbn': instance.shukketsuKbn,
      'Jiyu1': instance.jiyu1,
      'Jiyu2': instance.jiyu2,
      'IsEditable': instance.isEditable,
    };
