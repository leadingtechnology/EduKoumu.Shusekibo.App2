// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_timed_meibo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceTimedMeiboModelAdapter
    extends TypeAdapter<_$AttendanceTimedMeiboModelImpl> {
  @override
  final int typeId = 28;

  @override
  _$AttendanceTimedMeiboModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AttendanceTimedMeiboModelImpl(
      studentKihonId: fields[0] as int?,
      studentSeq: fields[1] as String?,
      gakunen: fields[2] as String?,
      className: fields[3] as String?,
      studentNumber: fields[4] as String?,
      photoImageFlg: fields[5] as bool?,
      name: fields[6] as String?,
      genderCode: fields[7] as String?,
      photoUrl: fields[8] as String?,
      jokyoList: (fields[9] as List?)?.cast<AttendanceTimedStatusModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$AttendanceTimedMeiboModelImpl obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.studentKihonId)
      ..writeByte(1)
      ..write(obj.studentSeq)
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
      ..write(obj.photoUrl)
      ..writeByte(9)
      ..write(obj.jokyoList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceTimedMeiboModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceTimedMeiboModelImpl _$$AttendanceTimedMeiboModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceTimedMeiboModelImpl(
      studentKihonId: json['StudentKihonId'] as int?,
      studentSeq: json['StudentSeq'] as String?,
      gakunen: json['Gakunen'] as String?,
      className: json['ClassName'] as String?,
      studentNumber: json['StudentNumber'] as String?,
      photoImageFlg: json['PhotoImageFlg'] as bool?,
      name: json['Name'] as String?,
      genderCode: json['GenderCode'] as String?,
      photoUrl: json['PhotoUrl'] as String?,
      jokyoList: (json['JokyoList'] as List<dynamic>?)
          ?.map((e) =>
              AttendanceTimedStatusModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AttendanceTimedMeiboModelImplToJson(
        _$AttendanceTimedMeiboModelImpl instance) =>
    <String, dynamic>{
      'StudentKihonId': instance.studentKihonId,
      'StudentSeq': instance.studentSeq,
      'Gakunen': instance.gakunen,
      'ClassName': instance.className,
      'StudentNumber': instance.studentNumber,
      'PhotoImageFlg': instance.photoImageFlg,
      'Name': instance.name,
      'GenderCode': instance.genderCode,
      'PhotoUrl': instance.photoUrl,
      'JokyoList': instance.jokyoList,
    };
