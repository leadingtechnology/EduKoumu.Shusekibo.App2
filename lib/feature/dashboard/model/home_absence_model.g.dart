// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_absence_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeAbsenceModelAdapter extends TypeAdapter<_$HomeAbsenceModelImpl> {
  @override
  final int typeId = 48;

  @override
  _$HomeAbsenceModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$HomeAbsenceModelImpl(
      studentSeq: fields[0] as String?,
      studentKihonId: fields[1] as int?,
      gakunen: fields[2] as String?,
      className: fields[3] as String?,
      studentNumber: fields[4] as String?,
      photoImageFlg: fields[5] as bool?,
      name: fields[6] as String?,
      genderCode: fields[7] as String?,
      ryaku: fields[8] as String?,
      jiyu1: fields[9] as String?,
      jiyu2: fields[10] as String?,
      photoUrl: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$HomeAbsenceModelImpl obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.studentSeq)
      ..writeByte(1)
      ..write(obj.studentKihonId)
      ..writeByte(2)
      ..write(obj.gakunen)
      ..writeByte(3)
      ..write(obj.className)
      ..writeByte(4)
      ..write(obj.studentNumber)
      ..writeByte(5)
      ..write(obj.photoImageFlg)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.genderCode)
      ..writeByte(8)
      ..write(obj.ryaku)
      ..writeByte(9)
      ..write(obj.jiyu1)
      ..writeByte(10)
      ..write(obj.jiyu2)
      ..writeByte(11)
      ..write(obj.photoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeAbsenceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeAbsenceModelImpl _$$HomeAbsenceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeAbsenceModelImpl(
      studentSeq: json['StudentSeq'] as String?,
      studentKihonId: json['StudentKihonId'] as int?,
      gakunen: json['Gakunen'] as String?,
      className: json['ClassName'] as String?,
      studentNumber: json['StudentNumber'] as String?,
      photoImageFlg: json['PhotoImageFlg'] as bool?,
      name: json['Name'] as String?,
      genderCode: json['GenderCode'] as String?,
      ryaku: json['Ryaku'] as String?,
      jiyu1: json['Jiyu1'] as String?,
      jiyu2: json['Jiyu2'] as String?,
      photoUrl: json['PhotoUrl'] as String?,
    );

Map<String, dynamic> _$$HomeAbsenceModelImplToJson(
        _$HomeAbsenceModelImpl instance) =>
    <String, dynamic>{
      'StudentSeq': instance.studentSeq,
      'StudentKihonId': instance.studentKihonId,
      'Gakunen': instance.gakunen,
      'ClassName': instance.className,
      'StudentNumber': instance.studentNumber,
      'PhotoImageFlg': instance.photoImageFlg,
      'Name': instance.name,
      'GenderCode': instance.genderCode,
      'Ryaku': instance.ryaku,
      'Jiyu1': instance.jiyu1,
      'Jiyu2': instance.jiyu2,
      'PhotoUrl': instance.photoUrl,
    };
