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
      kyokaDantaiBunrui: fields[7] as String?,
      kyokaDantaiKbn: fields[8] as String?,
      kyokaBunrui: fields[9] as String?,
      kamokuCd: fields[10] as String?,
      kamokuNameRyakusho: fields[11] as String?,
      kyoinId1: fields[12] as String?,
      kyoinName1: fields[13] as String?,
      kyoinId2: fields[14] as String?,
      kyoinName2: fields[15] as String?,
      kyoinId3: fields[16] as String?,
      kyoinName3: fields[17] as String?,
      isEditable: fields[18] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, _$AttendanceStatusModelImpl obj) {
    writer
      ..writeByte(19)
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
      ..write(obj.kyokaDantaiBunrui)
      ..writeByte(8)
      ..write(obj.kyokaDantaiKbn)
      ..writeByte(9)
      ..write(obj.kyokaBunrui)
      ..writeByte(10)
      ..write(obj.kamokuCd)
      ..writeByte(11)
      ..write(obj.kamokuNameRyakusho)
      ..writeByte(12)
      ..write(obj.kyoinId1)
      ..writeByte(13)
      ..write(obj.kyoinName1)
      ..writeByte(14)
      ..write(obj.kyoinId2)
      ..writeByte(15)
      ..write(obj.kyoinName2)
      ..writeByte(16)
      ..write(obj.kyoinId3)
      ..writeByte(17)
      ..write(obj.kyoinName3)
      ..writeByte(18)
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
      kyokaDantaiBunrui: json['KyokaDantaiBunrui'] as String?,
      kyokaDantaiKbn: json['KyokaDantaiKbn'] as String?,
      kyokaBunrui: json['KyokaBunrui'] as String?,
      kamokuCd: json['KamokuCd'] as String?,
      kamokuNameRyakusho: json['KamokuNameRyakusho'] as String?,
      kyoinId1: json['KyoinId1'] as String?,
      kyoinName1: json['KyoinName1'] as String?,
      kyoinId2: json['KyoinId2'] as String?,
      kyoinName2: json['KyoinName2'] as String?,
      kyoinId3: json['KyoinId3'] as String?,
      kyoinName3: json['KyoinName3'] as String?,
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
      'KyokaDantaiBunrui': instance.kyokaDantaiBunrui,
      'KyokaDantaiKbn': instance.kyokaDantaiKbn,
      'KyokaBunrui': instance.kyokaBunrui,
      'KamokuCd': instance.kamokuCd,
      'KamokuNameRyakusho': instance.kamokuNameRyakusho,
      'KyoinId1': instance.kyoinId1,
      'KyoinName1': instance.kyoinName1,
      'KyoinId2': instance.kyoinId2,
      'KyoinName2': instance.kyoinName2,
      'KyoinId3': instance.kyoinId3,
      'KyoinName3': instance.kyoinName3,
      'IsEditable': instance.isEditable,
    };
