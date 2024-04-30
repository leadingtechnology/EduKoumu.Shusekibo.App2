// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tanto_kyoin_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TantoKyoinModelAdapter extends TypeAdapter<_$TantoKyoinModelImpl> {
  @override
  final int typeId = 53;

  @override
  _$TantoKyoinModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TantoKyoinModelImpl(
      teacherTsushoName: fields[0] as String?,
      kamokuNameRyakusho: fields[1] as String?,
      isChecked: fields[2] as bool?,
      stscd: fields[3] as String?,
      dantaiBunrui: fields[4] as String?,
      dantaiKbn: fields[5] as String?,
      dantaiCd: fields[6] as String?,
      nendo: fields[7] as String?,
      shozokuId: fields[8] as int?,
      shozokuBunrui: fields[9] as String?,
      shozokuKbn: fields[10] as String?,
      shozokuCd: fields[11] as String?,
      taishoDate: fields[12] as DateTime?,
      strTaishoDate: fields[13] as String?,
      jigenIdx: fields[14] as int?,
      jigenBunkatsuIdx: fields[15] as int?,
      kyoinID: fields[16] as String?,
      kyokaDantaiBunrui: fields[17] as String?,
      kyokaDantaiKbn: fields[18] as String?,
      kyokaBunrui: fields[19] as String?,
      kamokuCd: fields[20] as String?,
      tangenSeq: fields[21] as String?,
      shidoNaiyoSeq: fields[22] as String?,
      shidoKiroku: fields[23] as String?,
      jisu: fields[24] as int?,
      jisuBunsuCode: fields[25] as String?,
      jisuBunsuName: fields[26] as String?,
      jisuBunsuBunshi: fields[27] as int?,
      jisuBunsuBunbo: fields[28] as int?,
      updKyoinId: fields[29] as String?,
      crtUserId: fields[30] as int?,
      crtUserName: fields[31] as String?,
      crtDateTime: fields[32] as DateTime?,
      updUserId: fields[33] as int?,
      updUserName: fields[34] as String?,
      updDateTime: fields[35] as DateTime?,
      deleteFlg: fields[36] as bool?,
      timeStamp: fields[37] as String?,
      operatorUserId: fields[38] as int?,
      tenantId: fields[39] as int?,
      dantaiId: fields[40] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, _$TantoKyoinModelImpl obj) {
    writer
      ..writeByte(41)
      ..writeByte(0)
      ..write(obj.teacherTsushoName)
      ..writeByte(1)
      ..write(obj.kamokuNameRyakusho)
      ..writeByte(2)
      ..write(obj.isChecked)
      ..writeByte(3)
      ..write(obj.stscd)
      ..writeByte(4)
      ..write(obj.dantaiBunrui)
      ..writeByte(5)
      ..write(obj.dantaiKbn)
      ..writeByte(6)
      ..write(obj.dantaiCd)
      ..writeByte(7)
      ..write(obj.nendo)
      ..writeByte(8)
      ..write(obj.shozokuId)
      ..writeByte(9)
      ..write(obj.shozokuBunrui)
      ..writeByte(10)
      ..write(obj.shozokuKbn)
      ..writeByte(11)
      ..write(obj.shozokuCd)
      ..writeByte(12)
      ..write(obj.taishoDate)
      ..writeByte(13)
      ..write(obj.strTaishoDate)
      ..writeByte(14)
      ..write(obj.jigenIdx)
      ..writeByte(15)
      ..write(obj.jigenBunkatsuIdx)
      ..writeByte(16)
      ..write(obj.kyoinID)
      ..writeByte(17)
      ..write(obj.kyokaDantaiBunrui)
      ..writeByte(18)
      ..write(obj.kyokaDantaiKbn)
      ..writeByte(19)
      ..write(obj.kyokaBunrui)
      ..writeByte(20)
      ..write(obj.kamokuCd)
      ..writeByte(21)
      ..write(obj.tangenSeq)
      ..writeByte(22)
      ..write(obj.shidoNaiyoSeq)
      ..writeByte(23)
      ..write(obj.shidoKiroku)
      ..writeByte(24)
      ..write(obj.jisu)
      ..writeByte(25)
      ..write(obj.jisuBunsuCode)
      ..writeByte(26)
      ..write(obj.jisuBunsuName)
      ..writeByte(27)
      ..write(obj.jisuBunsuBunshi)
      ..writeByte(28)
      ..write(obj.jisuBunsuBunbo)
      ..writeByte(29)
      ..write(obj.updKyoinId)
      ..writeByte(30)
      ..write(obj.crtUserId)
      ..writeByte(31)
      ..write(obj.crtUserName)
      ..writeByte(32)
      ..write(obj.crtDateTime)
      ..writeByte(33)
      ..write(obj.updUserId)
      ..writeByte(34)
      ..write(obj.updUserName)
      ..writeByte(35)
      ..write(obj.updDateTime)
      ..writeByte(36)
      ..write(obj.deleteFlg)
      ..writeByte(37)
      ..write(obj.timeStamp)
      ..writeByte(38)
      ..write(obj.operatorUserId)
      ..writeByte(39)
      ..write(obj.tenantId)
      ..writeByte(40)
      ..write(obj.dantaiId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TantoKyoinModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TantoKyoinModelImpl _$$TantoKyoinModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TantoKyoinModelImpl(
      teacherTsushoName: json['TeacherTsushoName'] as String?,
      kamokuNameRyakusho: json['KamokuNameRyakusho'] as String?,
      isChecked: json['IsChecked'] as bool?,
      stscd: json['Stscd'] as String?,
      dantaiBunrui: json['DantaiBunrui'] as String?,
      dantaiKbn: json['DantaiKbn'] as String?,
      dantaiCd: json['DantaiCd'] as String?,
      nendo: json['Nendo'] as String?,
      shozokuId: json['ShozokuId'] as int?,
      shozokuBunrui: json['ShozokuBunrui'] as String?,
      shozokuKbn: json['ShozokuKbn'] as String?,
      shozokuCd: json['ShozokuCd'] as String?,
      taishoDate: json['TaishoDate'] == null
          ? null
          : DateTime.parse(json['TaishoDate'] as String),
      strTaishoDate: json['StrTaishoDate'] as String?,
      jigenIdx: json['JigenIdx'] as int?,
      jigenBunkatsuIdx: json['JigenBunkatsuIdx'] as int?,
      kyoinID: json['KyoinID'] as String?,
      kyokaDantaiBunrui: json['KyokaDantaiBunrui'] as String?,
      kyokaDantaiKbn: json['KyokaDantaiKbn'] as String?,
      kyokaBunrui: json['KyokaBunrui'] as String?,
      kamokuCd: json['KamokuCd'] as String?,
      tangenSeq: json['TangenSeq'] as String?,
      shidoNaiyoSeq: json['ShidoNaiyoSeq'] as String?,
      shidoKiroku: json['ShidoKiroku'] as String?,
      jisu: json['Jisu'] as int?,
      jisuBunsuCode: json['JisuBunsuCode'] as String?,
      jisuBunsuName: json['JisuBunsuName'] as String?,
      jisuBunsuBunshi: json['JisuBunsuBunshi'] as int?,
      jisuBunsuBunbo: json['JisuBunsuBunbo'] as int?,
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
      dantaiId: json['DantaiId'] as int?,
    );

Map<String, dynamic> _$$TantoKyoinModelImplToJson(
        _$TantoKyoinModelImpl instance) =>
    <String, dynamic>{
      'TeacherTsushoName': instance.teacherTsushoName,
      'KamokuNameRyakusho': instance.kamokuNameRyakusho,
      'IsChecked': instance.isChecked,
      'Stscd': instance.stscd,
      'DantaiBunrui': instance.dantaiBunrui,
      'DantaiKbn': instance.dantaiKbn,
      'DantaiCd': instance.dantaiCd,
      'Nendo': instance.nendo,
      'ShozokuId': instance.shozokuId,
      'ShozokuBunrui': instance.shozokuBunrui,
      'ShozokuKbn': instance.shozokuKbn,
      'ShozokuCd': instance.shozokuCd,
      'TaishoDate': instance.taishoDate?.toIso8601String(),
      'StrTaishoDate': instance.strTaishoDate,
      'JigenIdx': instance.jigenIdx,
      'JigenBunkatsuIdx': instance.jigenBunkatsuIdx,
      'KyoinID': instance.kyoinID,
      'KyokaDantaiBunrui': instance.kyokaDantaiBunrui,
      'KyokaDantaiKbn': instance.kyokaDantaiKbn,
      'KyokaBunrui': instance.kyokaBunrui,
      'KamokuCd': instance.kamokuCd,
      'TangenSeq': instance.tangenSeq,
      'ShidoNaiyoSeq': instance.shidoNaiyoSeq,
      'ShidoKiroku': instance.shidoKiroku,
      'Jisu': instance.jisu,
      'JisuBunsuCode': instance.jisuBunsuCode,
      'JisuBunsuName': instance.jisuBunsuName,
      'JisuBunsuBunshi': instance.jisuBunsuBunshi,
      'JisuBunsuBunbo': instance.jisuBunsuBunbo,
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
      'DantaiId': instance.dantaiId,
    };
