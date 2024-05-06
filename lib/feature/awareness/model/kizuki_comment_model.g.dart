// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kizuki_comment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KizukiCommentModelAdapter extends TypeAdapter<_$KizukiCommentModelImpl> {
  @override
  final int typeId = 54;

  @override
  _$KizukiCommentModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$KizukiCommentModelImpl(
      id: fields[0] as int?,
      kizukiId: fields[1] as int?,
      originCommentId: fields[2] as int?,
      commentTorokuUserId: fields[3] as int?,
      commentTorokuUserName: fields[4] as String?,
      commentTorokuDateTime: fields[5] as DateTime?,
      commentbun: fields[6] as String?,
      hasAttachment: fields[7] as bool?,
      attachmentList: (fields[8] as List?)?.cast<TenpuModel>(),
      juyoFlg: fields[9] as bool?,
      timeStamp: fields[10] as String?,
      levelId: fields[11] as int?,
      hasChildren: fields[12] as bool?,
      oyaCommentTorokuUserId: fields[13] as int?,
      oyaCommentTorokuUserName: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$KizukiCommentModelImpl obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.kizukiId)
      ..writeByte(2)
      ..write(obj.originCommentId)
      ..writeByte(3)
      ..write(obj.commentTorokuUserId)
      ..writeByte(4)
      ..write(obj.commentTorokuUserName)
      ..writeByte(5)
      ..write(obj.commentTorokuDateTime)
      ..writeByte(6)
      ..write(obj.commentbun)
      ..writeByte(7)
      ..write(obj.hasAttachment)
      ..writeByte(9)
      ..write(obj.juyoFlg)
      ..writeByte(10)
      ..write(obj.timeStamp)
      ..writeByte(11)
      ..write(obj.levelId)
      ..writeByte(12)
      ..write(obj.hasChildren)
      ..writeByte(13)
      ..write(obj.oyaCommentTorokuUserId)
      ..writeByte(14)
      ..write(obj.oyaCommentTorokuUserName)
      ..writeByte(8)
      ..write(obj.attachmentList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KizukiCommentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KizukiCommentModelImpl _$$KizukiCommentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$KizukiCommentModelImpl(
      id: json['Id'] as int?,
      kizukiId: json['KizukiId'] as int?,
      originCommentId: json['OriginCommentId'] as int?,
      commentTorokuUserId: json['CommentTorokuUserId'] as int?,
      commentTorokuUserName: json['CommentTorokuUserName'] as String?,
      commentTorokuDateTime: json['CommentTorokuDateTime'] == null
          ? null
          : DateTime.parse(json['CommentTorokuDateTime'] as String),
      commentbun: json['Commentbun'] as String?,
      hasAttachment: json['HasAttachment'] as bool?,
      attachmentList: (json['AttachmentList'] as List<dynamic>?)
          ?.map((e) => TenpuModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      juyoFlg: json['JuyoFlg'] as bool?,
      timeStamp: json['TimeStamp'] as String?,
      levelId: json['LevelId'] as int?,
      hasChildren: json['HasChildren'] as bool?,
      oyaCommentTorokuUserId: json['OyaCommentTorokuUserId'] as int?,
      oyaCommentTorokuUserName: json['OyaCommentTorokuUserName'] as String?,
    );

Map<String, dynamic> _$$KizukiCommentModelImplToJson(
        _$KizukiCommentModelImpl instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'KizukiId': instance.kizukiId,
      'OriginCommentId': instance.originCommentId,
      'CommentTorokuUserId': instance.commentTorokuUserId,
      'CommentTorokuUserName': instance.commentTorokuUserName,
      'CommentTorokuDateTime':
          instance.commentTorokuDateTime?.toIso8601String(),
      'Commentbun': instance.commentbun,
      'HasAttachment': instance.hasAttachment,
      'AttachmentList': instance.attachmentList,
      'JuyoFlg': instance.juyoFlg,
      'TimeStamp': instance.timeStamp,
      'LevelId': instance.levelId,
      'HasChildren': instance.hasChildren,
      'OyaCommentTorokuUserId': instance.oyaCommentTorokuUserId,
      'OyaCommentTorokuUserName': instance.oyaCommentTorokuUserName,
    };
