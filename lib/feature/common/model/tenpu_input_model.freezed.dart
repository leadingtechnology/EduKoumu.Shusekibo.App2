// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenpu_input_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TenpuInputModel _$TenpuInputModelFromJson(Map<String, dynamic> json) {
  return _TenpuInputModel.fromJson(json);
}

/// @nodoc
mixin _$TenpuInputModel {
  @JsonKey(name: 'TenpuId', disallowNullValue: false)
  @HiveField(0)
  int? get tenpuId => throw _privateConstructorUsedError;
  @JsonKey(name: 'TenpuFileName', disallowNullValue: false)
  @HiveField(1)
  String? get tenpuFileName => throw _privateConstructorUsedError;
  @JsonKey(name: 'TenpuFileSize', disallowNullValue: false)
  @HiveField(2)
  int? get tenpuFileSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'TenpuFileData', disallowNullValue: false)
  @HiveField(3)
  String? get tenpuFileData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TenpuInputModelCopyWith<TenpuInputModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenpuInputModelCopyWith<$Res> {
  factory $TenpuInputModelCopyWith(
          TenpuInputModel value, $Res Function(TenpuInputModel) then) =
      _$TenpuInputModelCopyWithImpl<$Res, TenpuInputModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'TenpuId', disallowNullValue: false)
      @HiveField(0)
      int? tenpuId,
      @JsonKey(name: 'TenpuFileName', disallowNullValue: false)
      @HiveField(1)
      String? tenpuFileName,
      @JsonKey(name: 'TenpuFileSize', disallowNullValue: false)
      @HiveField(2)
      int? tenpuFileSize,
      @JsonKey(name: 'TenpuFileData', disallowNullValue: false)
      @HiveField(3)
      String? tenpuFileData});
}

/// @nodoc
class _$TenpuInputModelCopyWithImpl<$Res, $Val extends TenpuInputModel>
    implements $TenpuInputModelCopyWith<$Res> {
  _$TenpuInputModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenpuId = freezed,
    Object? tenpuFileName = freezed,
    Object? tenpuFileSize = freezed,
    Object? tenpuFileData = freezed,
  }) {
    return _then(_value.copyWith(
      tenpuId: freezed == tenpuId
          ? _value.tenpuId
          : tenpuId // ignore: cast_nullable_to_non_nullable
              as int?,
      tenpuFileName: freezed == tenpuFileName
          ? _value.tenpuFileName
          : tenpuFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      tenpuFileSize: freezed == tenpuFileSize
          ? _value.tenpuFileSize
          : tenpuFileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      tenpuFileData: freezed == tenpuFileData
          ? _value.tenpuFileData
          : tenpuFileData // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TenpuInputModelImplCopyWith<$Res>
    implements $TenpuInputModelCopyWith<$Res> {
  factory _$$TenpuInputModelImplCopyWith(_$TenpuInputModelImpl value,
          $Res Function(_$TenpuInputModelImpl) then) =
      __$$TenpuInputModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'TenpuId', disallowNullValue: false)
      @HiveField(0)
      int? tenpuId,
      @JsonKey(name: 'TenpuFileName', disallowNullValue: false)
      @HiveField(1)
      String? tenpuFileName,
      @JsonKey(name: 'TenpuFileSize', disallowNullValue: false)
      @HiveField(2)
      int? tenpuFileSize,
      @JsonKey(name: 'TenpuFileData', disallowNullValue: false)
      @HiveField(3)
      String? tenpuFileData});
}

/// @nodoc
class __$$TenpuInputModelImplCopyWithImpl<$Res>
    extends _$TenpuInputModelCopyWithImpl<$Res, _$TenpuInputModelImpl>
    implements _$$TenpuInputModelImplCopyWith<$Res> {
  __$$TenpuInputModelImplCopyWithImpl(
      _$TenpuInputModelImpl _value, $Res Function(_$TenpuInputModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenpuId = freezed,
    Object? tenpuFileName = freezed,
    Object? tenpuFileSize = freezed,
    Object? tenpuFileData = freezed,
  }) {
    return _then(_$TenpuInputModelImpl(
      tenpuId: freezed == tenpuId
          ? _value.tenpuId
          : tenpuId // ignore: cast_nullable_to_non_nullable
              as int?,
      tenpuFileName: freezed == tenpuFileName
          ? _value.tenpuFileName
          : tenpuFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      tenpuFileSize: freezed == tenpuFileSize
          ? _value.tenpuFileSize
          : tenpuFileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      tenpuFileData: freezed == tenpuFileData
          ? _value.tenpuFileData
          : tenpuFileData // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 95, adapterName: 'TenpuInputModelAdapter')
class _$TenpuInputModelImpl implements _TenpuInputModel {
  const _$TenpuInputModelImpl(
      {@JsonKey(name: 'TenpuId', disallowNullValue: false)
      @HiveField(0)
      this.tenpuId,
      @JsonKey(name: 'TenpuFileName', disallowNullValue: false)
      @HiveField(1)
      this.tenpuFileName,
      @JsonKey(name: 'TenpuFileSize', disallowNullValue: false)
      @HiveField(2)
      this.tenpuFileSize,
      @JsonKey(name: 'TenpuFileData', disallowNullValue: false)
      @HiveField(3)
      this.tenpuFileData});

  factory _$TenpuInputModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenpuInputModelImplFromJson(json);

  @override
  @JsonKey(name: 'TenpuId', disallowNullValue: false)
  @HiveField(0)
  final int? tenpuId;
  @override
  @JsonKey(name: 'TenpuFileName', disallowNullValue: false)
  @HiveField(1)
  final String? tenpuFileName;
  @override
  @JsonKey(name: 'TenpuFileSize', disallowNullValue: false)
  @HiveField(2)
  final int? tenpuFileSize;
  @override
  @JsonKey(name: 'TenpuFileData', disallowNullValue: false)
  @HiveField(3)
  final String? tenpuFileData;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenpuInputModelImpl &&
            (identical(other.tenpuId, tenpuId) || other.tenpuId == tenpuId) &&
            (identical(other.tenpuFileName, tenpuFileName) ||
                other.tenpuFileName == tenpuFileName) &&
            (identical(other.tenpuFileSize, tenpuFileSize) ||
                other.tenpuFileSize == tenpuFileSize) &&
            (identical(other.tenpuFileData, tenpuFileData) ||
                other.tenpuFileData == tenpuFileData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, tenpuId, tenpuFileName, tenpuFileSize, tenpuFileData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TenpuInputModelImplCopyWith<_$TenpuInputModelImpl> get copyWith =>
      __$$TenpuInputModelImplCopyWithImpl<_$TenpuInputModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TenpuInputModelImplToJson(
      this,
    );
  }
}

abstract class _TenpuInputModel implements TenpuInputModel {
  const factory _TenpuInputModel(
      {@JsonKey(name: 'TenpuId', disallowNullValue: false)
      @HiveField(0)
      final int? tenpuId,
      @JsonKey(name: 'TenpuFileName', disallowNullValue: false)
      @HiveField(1)
      final String? tenpuFileName,
      @JsonKey(name: 'TenpuFileSize', disallowNullValue: false)
      @HiveField(2)
      final int? tenpuFileSize,
      @JsonKey(name: 'TenpuFileData', disallowNullValue: false)
      @HiveField(3)
      final String? tenpuFileData}) = _$TenpuInputModelImpl;

  factory _TenpuInputModel.fromJson(Map<String, dynamic> json) =
      _$TenpuInputModelImpl.fromJson;

  @override
  @JsonKey(name: 'TenpuId', disallowNullValue: false)
  @HiveField(0)
  int? get tenpuId;
  @override
  @JsonKey(name: 'TenpuFileName', disallowNullValue: false)
  @HiveField(1)
  String? get tenpuFileName;
  @override
  @JsonKey(name: 'TenpuFileSize', disallowNullValue: false)
  @HiveField(2)
  int? get tenpuFileSize;
  @override
  @JsonKey(name: 'TenpuFileData', disallowNullValue: false)
  @HiveField(3)
  String? get tenpuFileData;
  @override
  @JsonKey(ignore: true)
  _$$TenpuInputModelImplCopyWith<_$TenpuInputModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
