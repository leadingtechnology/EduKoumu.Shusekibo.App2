// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_attendance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeAttendanceModelAdapter
    extends TypeAdapter<_$HomeAttendanceModelImpl> {
  @override
  final int typeId = 38;

  @override
  _$HomeAttendanceModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$HomeAttendanceModelImpl(
      className: fields[0] as String?,
      zaiseki: fields[1] as int?,
      shusseki: fields[2] as int?,
      tikoku: fields[3] as int?,
      sotai: fields[4] as int?,
      kessekiShuttei: fields[5] as int?,
      influenza: fields[6] as int?,
      doneAttendanceFlg: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, _$HomeAttendanceModelImpl obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.influenza)
      ..writeByte(7)
      ..write(obj.doneAttendanceFlg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeAttendanceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeAttendanceModelImpl _$$HomeAttendanceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeAttendanceModelImpl(
      className: json['ClassName'] as String?,
      zaiseki: json['Zaiseki'] as int?,
      shusseki: json['Shusseki'] as int?,
      tikoku: json['Tikoku'] as int?,
      sotai: json['Sotai'] as int?,
      kessekiShuttei: json['KessekiShuttei'] as int?,
      influenza: json['Influenza'] as int?,
      doneAttendanceFlg: json['DoneAttendanceFlg'] as bool?,
    );

Map<String, dynamic> _$$HomeAttendanceModelImplToJson(
        _$HomeAttendanceModelImpl instance) =>
    <String, dynamic>{
      'ClassName': instance.className,
      'Zaiseki': instance.zaiseki,
      'Shusseki': instance.shusseki,
      'Tikoku': instance.tikoku,
      'Sotai': instance.sotai,
      'KessekiShuttei': instance.kessekiShuttei,
      'Influenza': instance.influenza,
      'DoneAttendanceFlg': instance.doneAttendanceFlg,
    };
