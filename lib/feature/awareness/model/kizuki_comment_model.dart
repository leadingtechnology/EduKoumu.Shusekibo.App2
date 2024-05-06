import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/common/model/tenpu_model.dart';

part 'kizuki_comment_model.freezed.dart';
part 'kizuki_comment_model.g.dart';

List<KizukiCommentModel> kizukiCommentListFromJson(List<dynamic> data) =>
    List<KizukiCommentModel>.from(data
        .map((x) => KizukiCommentModel.fromJson(x as Map<String, dynamic>)));

KizukiCommentModel kizukiCommentFromJson(String str) =>
    KizukiCommentModel.fromJson(json.decode(str) as Map<String, dynamic>);


@freezed
abstract class KizukiCommentModel with _$KizukiCommentModel {
  @HiveType(typeId: 54, adapterName: 'KizukiCommentModelAdapter')
  const factory KizukiCommentModel({

    @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
    @JsonKey(name: 'KizukiId', disallowNullValue: false) @HiveField(1) int? kizukiId,
    @JsonKey(name: 'OriginCommentId', disallowNullValue: false) @HiveField(2) int? originCommentId,
    @JsonKey(name: 'CommentTorokuUserId', disallowNullValue: false) @HiveField(3) int? commentTorokuUserId,
    @JsonKey(name: 'CommentTorokuUserName', disallowNullValue: false) @HiveField(4) String? commentTorokuUserName,
    @JsonKey(name: 'CommentTorokuDateTime', disallowNullValue: false) @HiveField(5) DateTime? commentTorokuDateTime,
    @JsonKey(name: 'Commentbun', disallowNullValue: false) @HiveField(6) String? commentbun,
    @JsonKey(name: 'HasAttachment', disallowNullValue: false) @HiveField(7) bool? hasAttachment,
    @JsonKey(name: 'AttachmentList', disallowNullValue: false) @HiveField(8) List<TenpuModel>? attachmentList,
    @JsonKey(name: 'JuyoFlg', disallowNullValue: false) @HiveField(9) bool? juyoFlg,
    @JsonKey(name: 'TimeStamp', disallowNullValue: false) @HiveField(10) String? timeStamp,

    @JsonKey(name: 'LevelId', disallowNullValue: false) @HiveField(11) int? levelId,
    @JsonKey(name: 'HasChildren', disallowNullValue: false) @HiveField(12) bool? hasChildren,
    @JsonKey(name: 'OyaCommentTorokuUserId', disallowNullValue: false) @HiveField(13) int? oyaCommentTorokuUserId,
    @JsonKey(name: 'OyaCommentTorokuUserName', disallowNullValue: false) @HiveField(14) String? oyaCommentTorokuUserName,
  }) = _KizukiCommentModel;

  @override
  String toString() {
    return 'KizukiCommentModel($id, $kizukiId, $originCommentId, $commentTorokuUserId, $commentTorokuUserName, $commentTorokuDateTime, $commentbun, $hasAttachment, $attachmentList, $juyoFlg, $timeStamp, $levelId, $hasChildren, $oyaCommentTorokuUserId, $oyaCommentTorokuUserName)';
  }
  factory KizukiCommentModel.fromJson(Map<String, dynamic> json) => _$KizukiCommentModelFromJson(json);
}
