// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterModelAdapter extends TypeAdapter<_$FilterModelImpl> {
  @override
  final int typeId = 13;

  @override
  _$FilterModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$FilterModelImpl(
      dantaiId: fields[0] as int?,
      organizationKbn: fields[1] as String?,
      dantaiName: fields[2] as String?,
      gakunenCode: fields[3] as String?,
      gakunenRyakusho: fields[4] as String?,
      kouryuGakkyu: fields[5] as bool?,
      classId: fields[6] as int?,
      classCode: fields[7] as String?,
      className: fields[8] as String?,
      targetDate: fields[9] as DateTime?,
      japanDate: fields[10] as String?,
      beginDate: fields[11] as DateTime?,
      endDate: fields[12] as DateTime?,
      jigenIdx: fields[13] as int?,
      jigenRyaku: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$FilterModelImpl obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.dantaiId)
      ..writeByte(1)
      ..write(obj.organizationKbn)
      ..writeByte(2)
      ..write(obj.dantaiName)
      ..writeByte(3)
      ..write(obj.gakunenCode)
      ..writeByte(4)
      ..write(obj.gakunenRyakusho)
      ..writeByte(5)
      ..write(obj.kouryuGakkyu)
      ..writeByte(6)
      ..write(obj.classId)
      ..writeByte(7)
      ..write(obj.classCode)
      ..writeByte(8)
      ..write(obj.className)
      ..writeByte(9)
      ..write(obj.targetDate)
      ..writeByte(10)
      ..write(obj.japanDate)
      ..writeByte(11)
      ..write(obj.beginDate)
      ..writeByte(12)
      ..write(obj.endDate)
      ..writeByte(13)
      ..write(obj.jigenIdx)
      ..writeByte(14)
      ..write(obj.jigenRyaku);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilterModelImpl _$$FilterModelImplFromJson(Map<String, dynamic> json) =>
    _$FilterModelImpl(
      dantaiId: json['DantaiId'] as int?,
      organizationKbn: json['OrganizationKbn'] as String?,
      dantaiName: json['DantaiName'] as String?,
      gakunenCode: json['GakunenCode'] as String?,
      gakunenRyakusho: json['GakunenRyakusho'] as String?,
      kouryuGakkyu: json['kouryuGakkyu'] as bool?,
      classId: json['ClassId'] as int?,
      classCode: json['ClassCode'] as String?,
      className: json['ClassName'] as String?,
      targetDate: json['TargetDate'] == null
          ? null
          : DateTime.parse(json['TargetDate'] as String),
      japanDate: json['JapanDate'] as String?,
      beginDate: json['BeginDate'] == null
          ? null
          : DateTime.parse(json['BeginDate'] as String),
      endDate: json['EndDate'] == null
          ? null
          : DateTime.parse(json['EndDate'] as String),
      jigenIdx: json['JigenIdx'] as int?,
      jigenRyaku: json['JigenRyaku'] as String?,
    );

Map<String, dynamic> _$$FilterModelImplToJson(_$FilterModelImpl instance) =>
    <String, dynamic>{
      'DantaiId': instance.dantaiId,
      'OrganizationKbn': instance.organizationKbn,
      'DantaiName': instance.dantaiName,
      'GakunenCode': instance.gakunenCode,
      'GakunenRyakusho': instance.gakunenRyakusho,
      'kouryuGakkyu': instance.kouryuGakkyu,
      'ClassId': instance.classId,
      'ClassCode': instance.classCode,
      'ClassName': instance.className,
      'TargetDate': instance.targetDate?.toIso8601String(),
      'JapanDate': instance.japanDate,
      'BeginDate': instance.beginDate?.toIso8601String(),
      'EndDate': instance.endDate?.toIso8601String(),
      'JigenIdx': instance.jigenIdx,
      'JigenRyaku': instance.jigenRyaku,
    };
