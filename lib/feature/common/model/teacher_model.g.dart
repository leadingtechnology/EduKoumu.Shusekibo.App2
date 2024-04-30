// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeacherModelAdapter extends TypeAdapter<_$TeacherModelImpl> {
  @override
  final int typeId = 51;

  @override
  _$TeacherModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TeacherModelImpl(
      dantaiBunrui: fields[0] as String?,
      dantaiKbn: fields[1] as String?,
      dantaiCode: fields[2] as String?,
      schoolId: fields[3] as int?,
      shozokuId: fields[4] as int?,
      memberId: fields[5] as int?,
      teacherKihonId: fields[6] as int?,
      userId: fields[7] as String?,
      loginId: fields[8] as String?,
      kyoinID: fields[9] as String?,
      shokushuCd: fields[10] as String?,
      seiTsushoName: fields[11] as String?,
      meiTsushoName: fields[12] as String?,
      teacherTsushoName: fields[13] as String?,
      seiTsushoKana: fields[14] as String?,
      meiTsushoKana: fields[15] as String?,
      teacherTsushoNameKana: fields[16] as String?,
      seiSeishikiName: fields[17] as String?,
      meiSeishikiName: fields[18] as String?,
      teacherSeishikiName: fields[19] as String?,
      seiSeishikiKana: fields[20] as String?,
      meiSeishikiKana: fields[21] as String?,
      teacherSeishikiNameKana: fields[22] as String?,
      seibetsuCode: fields[23] as String?,
      yubinNo: fields[24] as String?,
      address1: fields[25] as String?,
      telNo: fields[26] as String?,
      telNoKeitai: fields[27] as String?,
      kaishiDate: fields[28] as DateTime?,
      shuryoDate: fields[29] as DateTime?,
      operatorUserId: fields[30] as int?,
      tenantId: fields[31] as int?,
      dantaiId: fields[32] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, _$TeacherModelImpl obj) {
    writer
      ..writeByte(33)
      ..writeByte(0)
      ..write(obj.dantaiBunrui)
      ..writeByte(1)
      ..write(obj.dantaiKbn)
      ..writeByte(2)
      ..write(obj.dantaiCode)
      ..writeByte(3)
      ..write(obj.schoolId)
      ..writeByte(4)
      ..write(obj.shozokuId)
      ..writeByte(5)
      ..write(obj.memberId)
      ..writeByte(6)
      ..write(obj.teacherKihonId)
      ..writeByte(7)
      ..write(obj.userId)
      ..writeByte(8)
      ..write(obj.loginId)
      ..writeByte(9)
      ..write(obj.kyoinID)
      ..writeByte(10)
      ..write(obj.shokushuCd)
      ..writeByte(11)
      ..write(obj.seiTsushoName)
      ..writeByte(12)
      ..write(obj.meiTsushoName)
      ..writeByte(13)
      ..write(obj.teacherTsushoName)
      ..writeByte(14)
      ..write(obj.seiTsushoKana)
      ..writeByte(15)
      ..write(obj.meiTsushoKana)
      ..writeByte(16)
      ..write(obj.teacherTsushoNameKana)
      ..writeByte(17)
      ..write(obj.seiSeishikiName)
      ..writeByte(18)
      ..write(obj.meiSeishikiName)
      ..writeByte(19)
      ..write(obj.teacherSeishikiName)
      ..writeByte(20)
      ..write(obj.seiSeishikiKana)
      ..writeByte(21)
      ..write(obj.meiSeishikiKana)
      ..writeByte(22)
      ..write(obj.teacherSeishikiNameKana)
      ..writeByte(23)
      ..write(obj.seibetsuCode)
      ..writeByte(24)
      ..write(obj.yubinNo)
      ..writeByte(25)
      ..write(obj.address1)
      ..writeByte(26)
      ..write(obj.telNo)
      ..writeByte(27)
      ..write(obj.telNoKeitai)
      ..writeByte(28)
      ..write(obj.kaishiDate)
      ..writeByte(29)
      ..write(obj.shuryoDate)
      ..writeByte(30)
      ..write(obj.operatorUserId)
      ..writeByte(31)
      ..write(obj.tenantId)
      ..writeByte(32)
      ..write(obj.dantaiId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeacherModelImpl _$$TeacherModelImplFromJson(Map<String, dynamic> json) =>
    _$TeacherModelImpl(
      dantaiBunrui: json['DantaiBunrui'] as String?,
      dantaiKbn: json['DantaiKbn'] as String?,
      dantaiCode: json['DantaiCode'] as String?,
      schoolId: json['SchoolId'] as int?,
      shozokuId: json['ShozokuId'] as int?,
      memberId: json['MemberId'] as int?,
      teacherKihonId: json['TeacherKihonId'] as int?,
      userId: json['UserId'] as String?,
      loginId: json['LoginId'] as String?,
      kyoinID: json['KyoinID'] as String?,
      shokushuCd: json['ShokushuCd'] as String?,
      seiTsushoName: json['SeiTsushoName'] as String?,
      meiTsushoName: json['MeiTsushoName'] as String?,
      teacherTsushoName: json['TeacherTsushoName'] as String?,
      seiTsushoKana: json['SeiTsushoKana'] as String?,
      meiTsushoKana: json['MeiTsushoKana'] as String?,
      teacherTsushoNameKana: json['TeacherTsushoNameKana'] as String?,
      seiSeishikiName: json['SeiSeishikiName'] as String?,
      meiSeishikiName: json['MeiSeishikiName'] as String?,
      teacherSeishikiName: json['TeacherSeishikiName'] as String?,
      seiSeishikiKana: json['SeiSeishikiKana'] as String?,
      meiSeishikiKana: json['MeiSeishikiKana'] as String?,
      teacherSeishikiNameKana: json['TeacherSeishikiNameKana'] as String?,
      seibetsuCode: json['SeibetsuCode'] as String?,
      yubinNo: json['YubinNo'] as String?,
      address1: json['Address1'] as String?,
      telNo: json['TelNo'] as String?,
      telNoKeitai: json['TelNoKeitai'] as String?,
      kaishiDate: json['KaishiDate'] == null
          ? null
          : DateTime.parse(json['KaishiDate'] as String),
      shuryoDate: json['ShuryoDate'] == null
          ? null
          : DateTime.parse(json['ShuryoDate'] as String),
      operatorUserId: json['OperatorUserId'] as int?,
      tenantId: json['TenantId'] as int?,
      dantaiId: json['DantaiId'] as int?,
    );

Map<String, dynamic> _$$TeacherModelImplToJson(_$TeacherModelImpl instance) =>
    <String, dynamic>{
      'DantaiBunrui': instance.dantaiBunrui,
      'DantaiKbn': instance.dantaiKbn,
      'DantaiCode': instance.dantaiCode,
      'SchoolId': instance.schoolId,
      'ShozokuId': instance.shozokuId,
      'MemberId': instance.memberId,
      'TeacherKihonId': instance.teacherKihonId,
      'UserId': instance.userId,
      'LoginId': instance.loginId,
      'KyoinID': instance.kyoinID,
      'ShokushuCd': instance.shokushuCd,
      'SeiTsushoName': instance.seiTsushoName,
      'MeiTsushoName': instance.meiTsushoName,
      'TeacherTsushoName': instance.teacherTsushoName,
      'SeiTsushoKana': instance.seiTsushoKana,
      'MeiTsushoKana': instance.meiTsushoKana,
      'TeacherTsushoNameKana': instance.teacherTsushoNameKana,
      'SeiSeishikiName': instance.seiSeishikiName,
      'MeiSeishikiName': instance.meiSeishikiName,
      'TeacherSeishikiName': instance.teacherSeishikiName,
      'SeiSeishikiKana': instance.seiSeishikiKana,
      'MeiSeishikiKana': instance.meiSeishikiKana,
      'TeacherSeishikiNameKana': instance.teacherSeishikiNameKana,
      'SeibetsuCode': instance.seibetsuCode,
      'YubinNo': instance.yubinNo,
      'Address1': instance.address1,
      'TelNo': instance.telNo,
      'TelNoKeitai': instance.telNoKeitai,
      'KaishiDate': instance.kaishiDate?.toIso8601String(),
      'ShuryoDate': instance.shuryoDate?.toIso8601String(),
      'OperatorUserId': instance.operatorUserId,
      'TenantId': instance.tenantId,
      'DantaiId': instance.dantaiId,
    };
