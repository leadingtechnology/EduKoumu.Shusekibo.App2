// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_linkage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactLinkageModelAdapter
    extends TypeAdapter<_$ContactLinkageModelImpl> {
  @override
  final int typeId = 50;

  @override
  _$ContactLinkageModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$ContactLinkageModelImpl(
      id: fields[0] as int?,
      tenantId: fields[1] as int?,
      dantaiName: fields[2] as String?,
      shozokuId: fields[3] as int?,
      shozokuName: fields[4] as String?,
      nendo: fields[5] as String?,
      taishoDate: fields[6] as DateTime?,
      registDateTime: fields[7] as DateTime?,
      memberId: fields[8] as int?,
      studentName: fields[9] as String?,
      shussekiNo: fields[10] as String?,
      renkeiJokyoCd: fields[11] as String?,
      renkeiJokyo: fields[12] as String?,
      jiyu: fields[13] as String?,
      biko: fields[14] as String?,
      renkeiStatus: fields[15] as int?,
      processStatus: fields[16] as int?,
      deleteFlg: fields[17] as bool?,
      crtUserId: fields[18] as int?,
      crtUserName: fields[19] as String?,
      crtDateTime: fields[20] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, _$ContactLinkageModelImpl obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tenantId)
      ..writeByte(2)
      ..write(obj.dantaiName)
      ..writeByte(3)
      ..write(obj.shozokuId)
      ..writeByte(4)
      ..write(obj.shozokuName)
      ..writeByte(5)
      ..write(obj.nendo)
      ..writeByte(6)
      ..write(obj.taishoDate)
      ..writeByte(7)
      ..write(obj.registDateTime)
      ..writeByte(8)
      ..write(obj.memberId)
      ..writeByte(9)
      ..write(obj.studentName)
      ..writeByte(10)
      ..write(obj.shussekiNo)
      ..writeByte(11)
      ..write(obj.renkeiJokyoCd)
      ..writeByte(12)
      ..write(obj.renkeiJokyo)
      ..writeByte(13)
      ..write(obj.jiyu)
      ..writeByte(14)
      ..write(obj.biko)
      ..writeByte(15)
      ..write(obj.renkeiStatus)
      ..writeByte(16)
      ..write(obj.processStatus)
      ..writeByte(17)
      ..write(obj.deleteFlg)
      ..writeByte(18)
      ..write(obj.crtUserId)
      ..writeByte(19)
      ..write(obj.crtUserName)
      ..writeByte(20)
      ..write(obj.crtDateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactLinkageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactLinkageModelImpl _$$ContactLinkageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ContactLinkageModelImpl(
      id: json['Id'] as int?,
      tenantId: json['TenantId'] as int?,
      dantaiName: json['DantaiName'] as String?,
      shozokuId: json['ShozokuId'] as int?,
      shozokuName: json['ShozokuName'] as String?,
      nendo: json['Nendo'] as String?,
      taishoDate: json['TaishoDate'] == null
          ? null
          : DateTime.parse(json['TaishoDate'] as String),
      registDateTime: json['RegistDateTime'] == null
          ? null
          : DateTime.parse(json['RegistDateTime'] as String),
      memberId: json['MemberId'] as int?,
      studentName: json['StudentName'] as String?,
      shussekiNo: json['ShussekiNo'] as String?,
      renkeiJokyoCd: json['RenkeiJokyoCd'] as String?,
      renkeiJokyo: json['RenkeiJokyo'] as String?,
      jiyu: json['Jiyu'] as String?,
      biko: json['Biko'] as String?,
      renkeiStatus: json['RenkeiStatus'] as int?,
      processStatus: json['ProcessStatus'] as int?,
      deleteFlg: json['DeleteFlg'] as bool?,
      crtUserId: json['CrtUserId'] as int?,
      crtUserName: json['CrtUserName'] as String?,
      crtDateTime: json['CrtDateTime'] == null
          ? null
          : DateTime.parse(json['CrtDateTime'] as String),
    );

Map<String, dynamic> _$$ContactLinkageModelImplToJson(
        _$ContactLinkageModelImpl instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'TenantId': instance.tenantId,
      'DantaiName': instance.dantaiName,
      'ShozokuId': instance.shozokuId,
      'ShozokuName': instance.shozokuName,
      'Nendo': instance.nendo,
      'TaishoDate': instance.taishoDate?.toIso8601String(),
      'RegistDateTime': instance.registDateTime?.toIso8601String(),
      'MemberId': instance.memberId,
      'StudentName': instance.studentName,
      'ShussekiNo': instance.shussekiNo,
      'RenkeiJokyoCd': instance.renkeiJokyoCd,
      'RenkeiJokyo': instance.renkeiJokyo,
      'Jiyu': instance.jiyu,
      'Biko': instance.biko,
      'RenkeiStatus': instance.renkeiStatus,
      'ProcessStatus': instance.processStatus,
      'DeleteFlg': instance.deleteFlg,
      'CrtUserId': instance.crtUserId,
      'CrtUserName': instance.crtUserName,
      'CrtDateTime': instance.crtDateTime?.toIso8601String(),
    };
