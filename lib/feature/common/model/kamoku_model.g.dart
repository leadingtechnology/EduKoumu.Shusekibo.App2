// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kamoku_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KamokuModelAdapter extends TypeAdapter<_$KamokuModelImpl> {
  @override
  final int typeId = 52;

  @override
  _$KamokuModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$KamokuModelImpl(
      isChecked: fields[0] as bool?,
      id: fields[1] as int?,
      stscd: fields[2] as String?,
      dantaiBunrui: fields[3] as String?,
      dantaiKbn: fields[4] as String?,
      kyokaId: fields[5] as int?,
      kyokaBunrui: fields[6] as String?,
      kamokuCode: fields[7] as String?,
      seisekiFlg: fields[8] as bool?,
      shuanFlg: fields[9] as bool?,
      kamokuNameSeishiki: fields[10] as String?,
      kamokuNameRyakusho: fields[11] as String?,
      danjoBunkatsuFlg: fields[12] as bool?,
      updKyoinId: fields[13] as String?,
      crtUserId: fields[14] as int?,
      crtUserName: fields[15] as String?,
      crtDateTime: fields[16] as DateTime?,
      updUserId: fields[17] as int?,
      updUserName: fields[18] as String?,
      updDateTime: fields[19] as DateTime?,
      deleteFlg: fields[20] as bool?,
      timeStamp: fields[21] as String?,
      operatorUserId: fields[22] as int?,
      tenantId: fields[23] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, _$KamokuModelImpl obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.isChecked)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.stscd)
      ..writeByte(3)
      ..write(obj.dantaiBunrui)
      ..writeByte(4)
      ..write(obj.dantaiKbn)
      ..writeByte(5)
      ..write(obj.kyokaId)
      ..writeByte(6)
      ..write(obj.kyokaBunrui)
      ..writeByte(7)
      ..write(obj.kamokuCode)
      ..writeByte(8)
      ..write(obj.seisekiFlg)
      ..writeByte(9)
      ..write(obj.shuanFlg)
      ..writeByte(10)
      ..write(obj.kamokuNameSeishiki)
      ..writeByte(11)
      ..write(obj.kamokuNameRyakusho)
      ..writeByte(12)
      ..write(obj.danjoBunkatsuFlg)
      ..writeByte(13)
      ..write(obj.updKyoinId)
      ..writeByte(14)
      ..write(obj.crtUserId)
      ..writeByte(15)
      ..write(obj.crtUserName)
      ..writeByte(16)
      ..write(obj.crtDateTime)
      ..writeByte(17)
      ..write(obj.updUserId)
      ..writeByte(18)
      ..write(obj.updUserName)
      ..writeByte(19)
      ..write(obj.updDateTime)
      ..writeByte(20)
      ..write(obj.deleteFlg)
      ..writeByte(21)
      ..write(obj.timeStamp)
      ..writeByte(22)
      ..write(obj.operatorUserId)
      ..writeByte(23)
      ..write(obj.tenantId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KamokuModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KamokuModelImpl _$$KamokuModelImplFromJson(Map<String, dynamic> json) =>
    _$KamokuModelImpl(
      isChecked: json['IsChecked'] as bool?,
      id: json['Id'] as int?,
      stscd: json['Stscd'] as String?,
      dantaiBunrui: json['DantaiBunrui'] as String?,
      dantaiKbn: json['DantaiKbn'] as String?,
      kyokaId: json['KyokaId'] as int?,
      kyokaBunrui: json['KyokaBunrui'] as String?,
      kamokuCode: json['KamokuCode'] as String?,
      seisekiFlg: json['SeisekiFlg'] as bool?,
      shuanFlg: json['ShuanFlg'] as bool?,
      kamokuNameSeishiki: json['KamokuNameSeishiki'] as String?,
      kamokuNameRyakusho: json['KamokuNameRyakusho'] as String?,
      danjoBunkatsuFlg: json['DanjoBunkatsuFlg'] as bool?,
      updKyoinId: json['UpdKyoinId'] as String?,
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
      timeStamp: json['TimeStamp'] as String?,
      operatorUserId: json['OperatorUserId'] as int?,
      tenantId: json['TenantId'] as int?,
    );

Map<String, dynamic> _$$KamokuModelImplToJson(_$KamokuModelImpl instance) =>
    <String, dynamic>{
      'IsChecked': instance.isChecked,
      'Id': instance.id,
      'Stscd': instance.stscd,
      'DantaiBunrui': instance.dantaiBunrui,
      'DantaiKbn': instance.dantaiKbn,
      'KyokaId': instance.kyokaId,
      'KyokaBunrui': instance.kyokaBunrui,
      'KamokuCode': instance.kamokuCode,
      'SeisekiFlg': instance.seisekiFlg,
      'ShuanFlg': instance.shuanFlg,
      'KamokuNameSeishiki': instance.kamokuNameSeishiki,
      'KamokuNameRyakusho': instance.kamokuNameRyakusho,
      'DanjoBunkatsuFlg': instance.danjoBunkatsuFlg,
      'UpdKyoinId': instance.updKyoinId,
      'CrtUserId': instance.crtUserId,
      'CrtUserName': instance.crtUserName,
      'CrtDateTime': instance.crtDateTime?.toIso8601String(),
      'UpdUserId': instance.updUserId,
      'UpdUserName': instance.updUserName,
      'UpdDateTime': instance.updDateTime?.toIso8601String(),
      'DeleteFlg': instance.deleteFlg,
      'TimeStamp': instance.timeStamp,
      'OperatorUserId': instance.operatorUserId,
      'TenantId': instance.tenantId,
    };
