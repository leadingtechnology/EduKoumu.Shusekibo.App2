// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_timed_stamp_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceTimedStampModelAdapter
    extends TypeAdapter<_$AttendanceTimedStampModelImpl> {
  @override
  final int typeId = 25;

  @override
  _$AttendanceTimedStampModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AttendanceTimedStampModelImpl(
      shukketsuJokyoCd: fields[0] as String?,
      shukketsuBunrui: fields[1] as String?,
      shukketsuKbn: fields[2] as String?,
      shukketsuJokyoNmSeishiki: fields[3] as String?,
      shukketsuJokyoNmRyaku: fields[4] as String?,
      shukketsuJokyoNmTsu: fields[5] as String?,
      shukketsuJokyoKey: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$AttendanceTimedStampModelImpl obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.shukketsuJokyoCd)
      ..writeByte(1)
      ..write(obj.shukketsuBunrui)
      ..writeByte(2)
      ..write(obj.shukketsuKbn)
      ..writeByte(3)
      ..write(obj.shukketsuJokyoNmSeishiki)
      ..writeByte(4)
      ..write(obj.shukketsuJokyoNmRyaku)
      ..writeByte(5)
      ..write(obj.shukketsuJokyoNmTsu)
      ..writeByte(6)
      ..write(obj.shukketsuJokyoKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceTimedStampModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceTimedStampModelImpl _$$AttendanceTimedStampModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceTimedStampModelImpl(
      shukketsuJokyoCd: json['ShukketsuJokyoCd'] as String?,
      shukketsuBunrui: json['ShukketsuBunrui'] as String?,
      shukketsuKbn: json['ShukketsuKbn'] as String?,
      shukketsuJokyoNmSeishiki: json['ShukketsuJokyoNmSeishiki'] as String?,
      shukketsuJokyoNmRyaku: json['ShukketsuJokyoNmRyaku'] as String?,
      shukketsuJokyoNmTsu: json['ShukketsuJokyoNmTsu'] as String?,
      shukketsuJokyoKey: json['ShukketsuJokyoKey'] as String?,
    );

Map<String, dynamic> _$$AttendanceTimedStampModelImplToJson(
        _$AttendanceTimedStampModelImpl instance) =>
    <String, dynamic>{
      'ShukketsuJokyoCd': instance.shukketsuJokyoCd,
      'ShukketsuBunrui': instance.shukketsuBunrui,
      'ShukketsuKbn': instance.shukketsuKbn,
      'ShukketsuJokyoNmSeishiki': instance.shukketsuJokyoNmSeishiki,
      'ShukketsuJokyoNmRyaku': instance.shukketsuJokyoNmRyaku,
      'ShukketsuJokyoNmTsu': instance.shukketsuJokyoNmTsu,
      'ShukketsuJokyoKey': instance.shukketsuJokyoKey,
    };
