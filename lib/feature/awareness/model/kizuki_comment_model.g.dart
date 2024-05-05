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
      commentTorokuUserId: fields[2] as int?,
      commentTorokuUserName: fields[3] as String?,
      commentTorokuDateTime: fields[4] as DateTime?,
      commentbun: fields[5] as String?,
      hasAttachment: fields[6] as bool?,
      attachmentList: (fields[7] as List?)?.cast<TenpuModel>(),
      juyoFlg: fields[8] as bool?,
      timeStamp: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$KizukiCommentModelImpl obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.kizukiId)
      ..writeByte(2)
      ..write(obj.commentTorokuUserId)
      ..writeByte(3)
      ..write(obj.commentTorokuUserName)
      ..writeByte(4)
      ..write(obj.commentTorokuDateTime)
      ..writeByte(5)
      ..write(obj.commentbun)
      ..writeByte(6)
      ..write(obj.hasAttachment)
      ..writeByte(8)
      ..write(obj.juyoFlg)
      ..writeByte(9)
      ..write(obj.timeStamp)
      ..writeByte(7)
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
    );

Map<String, dynamic> _$$KizukiCommentModelImplToJson(
        _$KizukiCommentModelImpl instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'KizukiId': instance.kizukiId,
      'CommentTorokuUserId': instance.commentTorokuUserId,
      'CommentTorokuUserName': instance.commentTorokuUserName,
      'CommentTorokuDateTime':
          instance.commentTorokuDateTime?.toIso8601String(),
      'Commentbun': instance.commentbun,
      'HasAttachment': instance.hasAttachment,
      'AttachmentList': instance.attachmentList,
      'JuyoFlg': instance.juyoFlg,
      'TimeStamp': instance.timeStamp,
    };
