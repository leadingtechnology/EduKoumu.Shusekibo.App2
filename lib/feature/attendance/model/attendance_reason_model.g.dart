// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_reason_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceReasonModelAdapter
    extends TypeAdapter<_$AttendanceReasonModelImpl> {
  @override
  final int typeId = 16;

  @override
  _$AttendanceReasonModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AttendanceReasonModelImpl(
      shukketsuJokyoCd: fields[0] as String?,
      shukketsuJiyuCd: fields[1] as String?,
      hyoujijun: fields[2] as String?,
      shukketsuJiyuNmSeishiki: fields[3] as String?,
      shukketsuJiyuNmRyaku: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$AttendanceReasonModelImpl obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.shukketsuJokyoCd)
      ..writeByte(1)
      ..write(obj.shukketsuJiyuCd)
      ..writeByte(2)
      ..write(obj.hyoujijun)
      ..writeByte(3)
      ..write(obj.shukketsuJiyuNmSeishiki)
      ..writeByte(4)
      ..write(obj.shukketsuJiyuNmRyaku);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceReasonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceReasonModelImpl _$$AttendanceReasonModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceReasonModelImpl(
      shukketsuJokyoCd: json['ShukketsuJokyoCd'] as String?,
      shukketsuJiyuCd: json['ShukketsuJiyuCd'] as String?,
      hyoujijun: json['Hyoujijun'] as String?,
      shukketsuJiyuNmSeishiki: json['ShukketsuJiyuNmSeishiki'] as String?,
      shukketsuJiyuNmRyaku: json['ShukketsuJiyuNmRyaku'] as String?,
    );

Map<String, dynamic> _$$AttendanceReasonModelImplToJson(
        _$AttendanceReasonModelImpl instance) =>
    <String, dynamic>{
      'ShukketsuJokyoCd': instance.shukketsuJokyoCd,
      'ShukketsuJiyuCd': instance.shukketsuJiyuCd,
      'Hyoujijun': instance.hyoujijun,
      'ShukketsuJiyuNmSeishiki': instance.shukketsuJiyuNmSeishiki,
      'ShukketsuJiyuNmRyaku': instance.shukketsuJiyuNmRyaku,
    };
