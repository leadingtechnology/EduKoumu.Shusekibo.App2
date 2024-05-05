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
    @JsonKey(name: 'CommentTorokuUserId', disallowNullValue: false) @HiveField(2) int? commentTorokuUserId,
    @JsonKey(name: 'CommentTorokuUserName', disallowNullValue: false) @HiveField(3) String? commentTorokuUserName,
    @JsonKey(name: 'CommentTorokuDateTime', disallowNullValue: false) @HiveField(4) DateTime? commentTorokuDateTime,
    @JsonKey(name: 'Commentbun', disallowNullValue: false) @HiveField(5) String? commentbun,
    @JsonKey(name: 'HasAttachment', disallowNullValue: false) @HiveField(6) bool? hasAttachment,
    @JsonKey(name: 'AttachmentList', disallowNullValue: false) @HiveField(7) List<TenpuModel>? attachmentList,
    @JsonKey(name: 'JuyoFlg', disallowNullValue: false) @HiveField(8) bool? juyoFlg,
    @JsonKey(name: 'TimeStamp', disallowNullValue: false) @HiveField(9) String? timeStamp,
  }) = _KizukiCommentModel;

  @override
  String toString() {
    return 'KizukiCommentModel($id, $kizukiId, $commentTorokuUserId, $commentTorokuUserName, $commentTorokuDateTime, $commentbun, $hasAttachment, $attachmentList, $juyoFlg, $timeStamp)';
  }
  factory KizukiCommentModel.fromJson(Map<String, dynamic> json) => _$KizukiCommentModelFromJson(json);
}
