// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'awareness_meibo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AwarenessMeiboModelAdapter
    extends TypeAdapter<_$AwarenessMeiboModelImpl> {
  @override
  final int typeId = 34;

  @override
  _$AwarenessMeiboModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AwarenessMeiboModelImpl(
      gakunen: fields[0] as String?,
      shozokuId: fields[1] as int?,
      className: fields[2] as String?,
      shussekiNo: fields[3] as String?,
      studentKihonId: fields[4] as int?,
      studentId: fields[5] as int?,
      studentName: fields[6] as String?,
      photoUrl: fields[7] as String?,
      genderCode: fields[8] as String?,
      kizukiCount: fields[9] as int?,
      selectFlag: fields[10] as bool?,
      changedFlag: fields[11] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, _$AwarenessMeiboModelImpl obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.gakunen)
      ..writeByte(1)
      ..write(obj.shozokuId)
      ..writeByte(2)
      ..write(obj.className)
      ..writeByte(3)
      ..write(obj.shussekiNo)
      ..writeByte(4)
      ..write(obj.studentKihonId)
      ..writeByte(5)
      ..write(obj.studentId)
      ..writeByte(6)
      ..write(obj.studentName)
      ..writeByte(7)
      ..write(obj.photoUrl)
      ..writeByte(8)
      ..write(obj.genderCode)
      ..writeByte(9)
      ..write(obj.kizukiCount)
      ..writeByte(10)
      ..write(obj.selectFlag)
      ..writeByte(11)
      ..write(obj.changedFlag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AwarenessMeiboModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AwarenessMeiboModelImpl _$$AwarenessMeiboModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AwarenessMeiboModelImpl(
      gakunen: json['Gakunen'] as String?,
      shozokuId: json['ShozokuId'] as int?,
      className: json['ClassName'] as String?,
      shussekiNo: json['ShussekiNo'] as String?,
      studentKihonId: json['StudentKihonId'] as int?,
      studentId: json['StudentId'] as int?,
      studentName: json['StudentName'] as String?,
      photoUrl: json['PhotoUrl'] as String?,
      genderCode: json['GenderCode'] as String?,
      kizukiCount: json['KizukiCount'] as int?,
      selectFlag: json['SelectFlag'] as bool?,
      changedFlag: json['ChangedFlag'] as bool?,
    );

Map<String, dynamic> _$$AwarenessMeiboModelImplToJson(
        _$AwarenessMeiboModelImpl instance) =>
    <String, dynamic>{
      'Gakunen': instance.gakunen,
      'ShozokuId': instance.shozokuId,
      'ClassName': instance.className,
      'ShussekiNo': instance.shussekiNo,
      'StudentKihonId': instance.studentKihonId,
      'StudentId': instance.studentId,
      'StudentName': instance.studentName,
      'PhotoUrl': instance.photoUrl,
      'GenderCode': instance.genderCode,
      'KizukiCount': instance.kizukiCount,
      'SelectFlag': instance.selectFlag,
      'ChangedFlag': instance.changedFlag,
    };
