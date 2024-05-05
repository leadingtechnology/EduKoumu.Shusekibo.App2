// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kizuki_comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KizukiCommentModel _$KizukiCommentModelFromJson(Map<String, dynamic> json) {
  return _KizukiCommentModel.fromJson(json);
}

/// @nodoc
mixin _$KizukiCommentModel {
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(0)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'KizukiId', disallowNullValue: false)
  @HiveField(1)
  int? get kizukiId => throw _privateConstructorUsedError;
  @JsonKey(name: 'CommentTorokuUserId', disallowNullValue: false)
  @HiveField(2)
  int? get commentTorokuUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'CommentTorokuUserName', disallowNullValue: false)
  @HiveField(3)
  String? get commentTorokuUserName => throw _privateConstructorUsedError;
  @JsonKey(name: 'CommentTorokuDateTime', disallowNullValue: false)
  @HiveField(4)
  DateTime? get commentTorokuDateTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'Commentbun', disallowNullValue: false)
  @HiveField(5)
  String? get commentbun => throw _privateConstructorUsedError;
  @JsonKey(name: 'HasAttachment', disallowNullValue: false)
  @HiveField(6)
  bool? get hasAttachment => throw _privateConstructorUsedError;
  @JsonKey(name: 'AttachmentList', disallowNullValue: false)
  @HiveField(7)
  List<TenpuModel>? get attachmentList => throw _privateConstructorUsedError;
  @JsonKey(name: 'JuyoFlg', disallowNullValue: false)
  @HiveField(8)
  bool? get juyoFlg => throw _privateConstructorUsedError;
  @JsonKey(name: 'TimeStamp', disallowNullValue: false)
  @HiveField(9)
  String? get timeStamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KizukiCommentModelCopyWith<KizukiCommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KizukiCommentModelCopyWith<$Res> {
  factory $KizukiCommentModelCopyWith(
          KizukiCommentModel value, $Res Function(KizukiCommentModel) then) =
      _$KizukiCommentModelCopyWithImpl<$Res, KizukiCommentModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
      @JsonKey(name: 'KizukiId', disallowNullValue: false)
      @HiveField(1)
      int? kizukiId,
      @JsonKey(name: 'CommentTorokuUserId', disallowNullValue: false)
      @HiveField(2)
      int? commentTorokuUserId,
      @JsonKey(name: 'CommentTorokuUserName', disallowNullValue: false)
      @HiveField(3)
      String? commentTorokuUserName,
      @JsonKey(name: 'CommentTorokuDateTime', disallowNullValue: false)
      @HiveField(4)
      DateTime? commentTorokuDateTime,
      @JsonKey(name: 'Commentbun', disallowNullValue: false)
      @HiveField(5)
      String? commentbun,
      @JsonKey(name: 'HasAttachment', disallowNullValue: false)
      @HiveField(6)
      bool? hasAttachment,
      @JsonKey(name: 'AttachmentList', disallowNullValue: false)
      @HiveField(7)
      List<TenpuModel>? attachmentList,
      @JsonKey(name: 'JuyoFlg', disallowNullValue: false)
      @HiveField(8)
      bool? juyoFlg,
      @JsonKey(name: 'TimeStamp', disallowNullValue: false)
      @HiveField(9)
      String? timeStamp});
}

/// @nodoc
class _$KizukiCommentModelCopyWithImpl<$Res, $Val extends KizukiCommentModel>
    implements $KizukiCommentModelCopyWith<$Res> {
  _$KizukiCommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? kizukiId = freezed,
    Object? commentTorokuUserId = freezed,
    Object? commentTorokuUserName = freezed,
    Object? commentTorokuDateTime = freezed,
    Object? commentbun = freezed,
    Object? hasAttachment = freezed,
    Object? attachmentList = freezed,
    Object? juyoFlg = freezed,
    Object? timeStamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      kizukiId: freezed == kizukiId
          ? _value.kizukiId
          : kizukiId // ignore: cast_nullable_to_non_nullable
              as int?,
      commentTorokuUserId: freezed == commentTorokuUserId
          ? _value.commentTorokuUserId
          : commentTorokuUserId // ignore: cast_nullable_to_non_nullable
              as int?,
      commentTorokuUserName: freezed == commentTorokuUserName
          ? _value.commentTorokuUserName
          : commentTorokuUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      commentTorokuDateTime: freezed == commentTorokuDateTime
          ? _value.commentTorokuDateTime
          : commentTorokuDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      commentbun: freezed == commentbun
          ? _value.commentbun
          : commentbun // ignore: cast_nullable_to_non_nullable
              as String?,
      hasAttachment: freezed == hasAttachment
          ? _value.hasAttachment
          : hasAttachment // ignore: cast_nullable_to_non_nullable
              as bool?,
      attachmentList: freezed == attachmentList
          ? _value.attachmentList
          : attachmentList // ignore: cast_nullable_to_non_nullable
              as List<TenpuModel>?,
      juyoFlg: freezed == juyoFlg
          ? _value.juyoFlg
          : juyoFlg // ignore: cast_nullable_to_non_nullable
              as bool?,
      timeStamp: freezed == timeStamp
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KizukiCommentModelImplCopyWith<$Res>
    implements $KizukiCommentModelCopyWith<$Res> {
  factory _$$KizukiCommentModelImplCopyWith(_$KizukiCommentModelImpl value,
          $Res Function(_$KizukiCommentModelImpl) then) =
      __$$KizukiCommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
      @JsonKey(name: 'KizukiId', disallowNullValue: false)
      @HiveField(1)
      int? kizukiId,
      @JsonKey(name: 'CommentTorokuUserId', disallowNullValue: false)
      @HiveField(2)
      int? commentTorokuUserId,
      @JsonKey(name: 'CommentTorokuUserName', disallowNullValue: false)
      @HiveField(3)
      String? commentTorokuUserName,
      @JsonKey(name: 'CommentTorokuDateTime', disallowNullValue: false)
      @HiveField(4)
      DateTime? commentTorokuDateTime,
      @JsonKey(name: 'Commentbun', disallowNullValue: false)
      @HiveField(5)
      String? commentbun,
      @JsonKey(name: 'HasAttachment', disallowNullValue: false)
      @HiveField(6)
      bool? hasAttachment,
      @JsonKey(name: 'AttachmentList', disallowNullValue: false)
      @HiveField(7)
      List<TenpuModel>? attachmentList,
      @JsonKey(name: 'JuyoFlg', disallowNullValue: false)
      @HiveField(8)
      bool? juyoFlg,
      @JsonKey(name: 'TimeStamp', disallowNullValue: false)
      @HiveField(9)
      String? timeStamp});
}

/// @nodoc
class __$$KizukiCommentModelImplCopyWithImpl<$Res>
    extends _$KizukiCommentModelCopyWithImpl<$Res, _$KizukiCommentModelImpl>
    implements _$$KizukiCommentModelImplCopyWith<$Res> {
  __$$KizukiCommentModelImplCopyWithImpl(_$KizukiCommentModelImpl _value,
      $Res Function(_$KizukiCommentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? kizukiId = freezed,
    Object? commentTorokuUserId = freezed,
    Object? commentTorokuUserName = freezed,
    Object? commentTorokuDateTime = freezed,
    Object? commentbun = freezed,
    Object? hasAttachment = freezed,
    Object? attachmentList = freezed,
    Object? juyoFlg = freezed,
    Object? timeStamp = freezed,
  }) {
    return _then(_$KizukiCommentModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      kizukiId: freezed == kizukiId
          ? _value.kizukiId
          : kizukiId // ignore: cast_nullable_to_non_nullable
              as int?,
      commentTorokuUserId: freezed == commentTorokuUserId
          ? _value.commentTorokuUserId
          : commentTorokuUserId // ignore: cast_nullable_to_non_nullable
              as int?,
      commentTorokuUserName: freezed == commentTorokuUserName
          ? _value.commentTorokuUserName
          : commentTorokuUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      commentTorokuDateTime: freezed == commentTorokuDateTime
          ? _value.commentTorokuDateTime
          : commentTorokuDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      commentbun: freezed == commentbun
          ? _value.commentbun
          : commentbun // ignore: cast_nullable_to_non_nullable
              as String?,
      hasAttachment: freezed == hasAttachment
          ? _value.hasAttachment
          : hasAttachment // ignore: cast_nullable_to_non_nullable
              as bool?,
      attachmentList: freezed == attachmentList
          ? _value._attachmentList
          : attachmentList // ignore: cast_nullable_to_non_nullable
              as List<TenpuModel>?,
      juyoFlg: freezed == juyoFlg
          ? _value.juyoFlg
          : juyoFlg // ignore: cast_nullable_to_non_nullable
              as bool?,
      timeStamp: freezed == timeStamp
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 54, adapterName: 'KizukiCommentModelAdapter')
class _$KizukiCommentModelImpl implements _KizukiCommentModel {
  const _$KizukiCommentModelImpl(
      {@JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) this.id,
      @JsonKey(name: 'KizukiId', disallowNullValue: false)
      @HiveField(1)
      this.kizukiId,
      @JsonKey(name: 'CommentTorokuUserId', disallowNullValue: false)
      @HiveField(2)
      this.commentTorokuUserId,
      @JsonKey(name: 'CommentTorokuUserName', disallowNullValue: false)
      @HiveField(3)
      this.commentTorokuUserName,
      @JsonKey(name: 'CommentTorokuDateTime', disallowNullValue: false)
      @HiveField(4)
      this.commentTorokuDateTime,
      @JsonKey(name: 'Commentbun', disallowNullValue: false)
      @HiveField(5)
      this.commentbun,
      @JsonKey(name: 'HasAttachment', disallowNullValue: false)
      @HiveField(6)
      this.hasAttachment,
      @JsonKey(name: 'AttachmentList', disallowNullValue: false)
      @HiveField(7)
      final List<TenpuModel>? attachmentList,
      @JsonKey(name: 'JuyoFlg', disallowNullValue: false)
      @HiveField(8)
      this.juyoFlg,
      @JsonKey(name: 'TimeStamp', disallowNullValue: false)
      @HiveField(9)
      this.timeStamp})
      : _attachmentList = attachmentList;

  factory _$KizukiCommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$KizukiCommentModelImplFromJson(json);

  @override
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(0)
  final int? id;
  @override
  @JsonKey(name: 'KizukiId', disallowNullValue: false)
  @HiveField(1)
  final int? kizukiId;
  @override
  @JsonKey(name: 'CommentTorokuUserId', disallowNullValue: false)
  @HiveField(2)
  final int? commentTorokuUserId;
  @override
  @JsonKey(name: 'CommentTorokuUserName', disallowNullValue: false)
  @HiveField(3)
  final String? commentTorokuUserName;
  @override
  @JsonKey(name: 'CommentTorokuDateTime', disallowNullValue: false)
  @HiveField(4)
  final DateTime? commentTorokuDateTime;
  @override
  @JsonKey(name: 'Commentbun', disallowNullValue: false)
  @HiveField(5)
  final String? commentbun;
  @override
  @JsonKey(name: 'HasAttachment', disallowNullValue: false)
  @HiveField(6)
  final bool? hasAttachment;
  final List<TenpuModel>? _attachmentList;
  @override
  @JsonKey(name: 'AttachmentList', disallowNullValue: false)
  @HiveField(7)
  List<TenpuModel>? get attachmentList {
    final value = _attachmentList;
    if (value == null) return null;
    if (_attachmentList is EqualUnmodifiableListView) return _attachmentList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'JuyoFlg', disallowNullValue: false)
  @HiveField(8)
  final bool? juyoFlg;
  @override
  @JsonKey(name: 'TimeStamp', disallowNullValue: false)
  @HiveField(9)
  final String? timeStamp;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KizukiCommentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.kizukiId, kizukiId) ||
                other.kizukiId == kizukiId) &&
            (identical(other.commentTorokuUserId, commentTorokuUserId) ||
                other.commentTorokuUserId == commentTorokuUserId) &&
            (identical(other.commentTorokuUserName, commentTorokuUserName) ||
                other.commentTorokuUserName == commentTorokuUserName) &&
            (identical(other.commentTorokuDateTime, commentTorokuDateTime) ||
                other.commentTorokuDateTime == commentTorokuDateTime) &&
            (identical(other.commentbun, commentbun) ||
                other.commentbun == commentbun) &&
            (identical(other.hasAttachment, hasAttachment) ||
                other.hasAttachment == hasAttachment) &&
            const DeepCollectionEquality()
                .equals(other._attachmentList, _attachmentList) &&
            (identical(other.juyoFlg, juyoFlg) || other.juyoFlg == juyoFlg) &&
            (identical(other.timeStamp, timeStamp) ||
                other.timeStamp == timeStamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      kizukiId,
      commentTorokuUserId,
      commentTorokuUserName,
      commentTorokuDateTime,
      commentbun,
      hasAttachment,
      const DeepCollectionEquality().hash(_attachmentList),
      juyoFlg,
      timeStamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KizukiCommentModelImplCopyWith<_$KizukiCommentModelImpl> get copyWith =>
      __$$KizukiCommentModelImplCopyWithImpl<_$KizukiCommentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KizukiCommentModelImplToJson(
      this,
    );
  }
}

abstract class _KizukiCommentModel implements KizukiCommentModel {
  const factory _KizukiCommentModel(
      {@JsonKey(name: 'Id', disallowNullValue: false)
      @HiveField(0)
      final int? id,
      @JsonKey(name: 'KizukiId', disallowNullValue: false)
      @HiveField(1)
      final int? kizukiId,
      @JsonKey(name: 'CommentTorokuUserId', disallowNullValue: false)
      @HiveField(2)
      final int? commentTorokuUserId,
      @JsonKey(name: 'CommentTorokuUserName', disallowNullValue: false)
      @HiveField(3)
      final String? commentTorokuUserName,
      @JsonKey(name: 'CommentTorokuDateTime', disallowNullValue: false)
      @HiveField(4)
      final DateTime? commentTorokuDateTime,
      @JsonKey(name: 'Commentbun', disallowNullValue: false)
      @HiveField(5)
      final String? commentbun,
      @JsonKey(name: 'HasAttachment', disallowNullValue: false)
      @HiveField(6)
      final bool? hasAttachment,
      @JsonKey(name: 'AttachmentList', disallowNullValue: false)
      @HiveField(7)
      final List<TenpuModel>? attachmentList,
      @JsonKey(name: 'JuyoFlg', disallowNullValue: false)
      @HiveField(8)
      final bool? juyoFlg,
      @JsonKey(name: 'TimeStamp', disallowNullValue: false)
      @HiveField(9)
      final String? timeStamp}) = _$KizukiCommentModelImpl;

  factory _KizukiCommentModel.fromJson(Map<String, dynamic> json) =
      _$KizukiCommentModelImpl.fromJson;

  @override
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(0)
  int? get id;
  @override
  @JsonKey(name: 'KizukiId', disallowNullValue: false)
  @HiveField(1)
  int? get kizukiId;
  @override
  @JsonKey(name: 'CommentTorokuUserId', disallowNullValue: false)
  @HiveField(2)
  int? get commentTorokuUserId;
  @override
  @JsonKey(name: 'CommentTorokuUserName', disallowNullValue: false)
  @HiveField(3)
  String? get commentTorokuUserName;
  @override
  @JsonKey(name: 'CommentTorokuDateTime', disallowNullValue: false)
  @HiveField(4)
  DateTime? get commentTorokuDateTime;
  @override
  @JsonKey(name: 'Commentbun', disallowNullValue: false)
  @HiveField(5)
  String? get commentbun;
  @override
  @JsonKey(name: 'HasAttachment', disallowNullValue: false)
  @HiveField(6)
  bool? get hasAttachment;
  @override
  @JsonKey(name: 'AttachmentList', disallowNullValue: false)
  @HiveField(7)
  List<TenpuModel>? get attachmentList;
  @override
  @JsonKey(name: 'JuyoFlg', disallowNullValue: false)
  @HiveField(8)
  bool? get juyoFlg;
  @override
  @JsonKey(name: 'TimeStamp', disallowNullValue: false)
  @HiveField(9)
  String? get timeStamp;
  @override
  @JsonKey(ignore: true)
  _$$KizukiCommentModelImplCopyWith<_$KizukiCommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
