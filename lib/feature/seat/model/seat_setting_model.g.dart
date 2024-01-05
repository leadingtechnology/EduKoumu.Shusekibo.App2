// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_setting_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeatSettingModelAdapter extends TypeAdapter<_$SeatSettingModelImpl> {
  @override
  final int typeId = 45;

  @override
  _$SeatSettingModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SeatSettingModelImpl(
      id: fields[0] as int?,
      tenantId: fields[1] as int?,
      dantaiId: fields[2] as int?,
      shozokuId: fields[3] as int?,
      seatPattern: fields[4] as String?,
      seatPatternName: fields[5] as String?,
      row: fields[6] as int?,
      column: fields[7] as int?,
      seatOrder: fields[8] as int?,
      startDate: fields[9] as DateTime?,
      endDate: fields[10] as DateTime?,
      crtUserId: fields[11] as int?,
      crtUserName: fields[12] as String?,
      crtDateTime: fields[13] as DateTime?,
      updUserId: fields[14] as int?,
      updUserName: fields[15] as String?,
      updDateTime: fields[16] as DateTime?,
      deleteFlg: fields[17] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, _$SeatSettingModelImpl obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tenantId)
      ..writeByte(2)
      ..write(obj.dantaiId)
      ..writeByte(3)
      ..write(obj.shozokuId)
      ..writeByte(4)
      ..write(obj.seatPattern)
      ..writeByte(5)
      ..write(obj.seatPatternName)
      ..writeByte(6)
      ..write(obj.row)
      ..writeByte(7)
      ..write(obj.column)
      ..writeByte(8)
      ..write(obj.seatOrder)
      ..writeByte(9)
      ..write(obj.startDate)
      ..writeByte(10)
      ..write(obj.endDate)
      ..writeByte(11)
      ..write(obj.crtUserId)
      ..writeByte(12)
      ..write(obj.crtUserName)
      ..writeByte(13)
      ..write(obj.crtDateTime)
      ..writeByte(14)
      ..write(obj.updUserId)
      ..writeByte(15)
      ..write(obj.updUserName)
      ..writeByte(16)
      ..write(obj.updDateTime)
      ..writeByte(17)
      ..write(obj.deleteFlg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatSettingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeatSettingModelImpl _$$SeatSettingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SeatSettingModelImpl(
      id: json['Id'] as int?,
      tenantId: json['TenantId'] as int?,
      dantaiId: json['DantaiId'] as int?,
      shozokuId: json['ShozokuId'] as int?,
      seatPattern: json['SeatPattern'] as String?,
      seatPatternName: json['SeatPatternName'] as String?,
      row: json['Row'] as int?,
      column: json['Column'] as int?,
      seatOrder: json['SeatOrder'] as int?,
      startDate: json['StartDate'] == null
          ? null
          : DateTime.parse(json['StartDate'] as String),
      endDate: json['EndDate'] == null
          ? null
          : DateTime.parse(json['EndDate'] as String),
      crtUserId: json['CrtUserId'] as int?,
      crtUserName: json['CrtUserName'] as String?,
      crtDateTime: json['CrtDateTime'] == null
          ? null
          : DateTime.parse(json['CrtDateTime'] as String),
      updUserId: json['UpdUserId'] as int?,
      updUserName: json['UpdUserName'] as String?,
      updDateTime: json['UpdDateTime'] == null
          ? null
          : DateTime.parse(json['UpdDateTime'] as String),
      deleteFlg: json['DeleteFlg'] as bool?,
    );

Map<String, dynamic> _$$SeatSettingModelImplToJson(
        _$SeatSettingModelImpl instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'TenantId': instance.tenantId,
      'DantaiId': instance.dantaiId,
      'ShozokuId': instance.shozokuId,
      'SeatPattern': instance.seatPattern,
      'SeatPatternName': instance.seatPatternName,
      'Row': instance.row,
      'Column': instance.column,
      'SeatOrder': instance.seatOrder,
      'StartDate': instance.startDate?.toIso8601String(),
      'EndDate': instance.endDate?.toIso8601String(),
      'CrtUserId': instance.crtUserId,
      'CrtUserName': instance.crtUserName,
      'CrtDateTime': instance.crtDateTime?.toIso8601String(),
      'UpdUserId': instance.updUserId,
      'UpdUserName': instance.updUserName,
      'UpdDateTime': instance.updDateTime?.toIso8601String(),
      'DeleteFlg': instance.deleteFlg,
    };
