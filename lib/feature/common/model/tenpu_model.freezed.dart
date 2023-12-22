// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenpu_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TenpuModel _$TenpuModelFromJson(Map<String, dynamic> json) {
  return _TenpuModel.fromJson(json);
}

/// @nodoc
mixin _$TenpuModel {
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
  @Uint8ListConverter()
  @HiveField(3)
  Uint8List? get tenpuFileData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TenpuModelCopyWith<TenpuModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenpuModelCopyWith<$Res> {
  factory $TenpuModelCopyWith(
          TenpuModel value, $Res Function(TenpuModel) then) =
      _$TenpuModelCopyWithImpl<$Res, TenpuModel>;
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
      @Uint8ListConverter()
      @HiveField(3)
      Uint8List? tenpuFileData});
}

/// @nodoc
class _$TenpuModelCopyWithImpl<$Res, $Val extends TenpuModel>
    implements $TenpuModelCopyWith<$Res> {
  _$TenpuModelCopyWithImpl(this._value, this._then);

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
              as Uint8List?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TenpuModelImplCopyWith<$Res>
    implements $TenpuModelCopyWith<$Res> {
  factory _$$TenpuModelImplCopyWith(
          _$TenpuModelImpl value, $Res Function(_$TenpuModelImpl) then) =
      __$$TenpuModelImplCopyWithImpl<$Res>;
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
      @Uint8ListConverter()
      @HiveField(3)
      Uint8List? tenpuFileData});
}

/// @nodoc
class __$$TenpuModelImplCopyWithImpl<$Res>
    extends _$TenpuModelCopyWithImpl<$Res, _$TenpuModelImpl>
    implements _$$TenpuModelImplCopyWith<$Res> {
  __$$TenpuModelImplCopyWithImpl(
      _$TenpuModelImpl _value, $Res Function(_$TenpuModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenpuId = freezed,
    Object? tenpuFileName = freezed,
    Object? tenpuFileSize = freezed,
    Object? tenpuFileData = freezed,
  }) {
    return _then(_$TenpuModelImpl(
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
              as Uint8List?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 44, adapterName: 'TenpuModelAdapter')
class _$TenpuModelImpl implements _TenpuModel {
  const _$TenpuModelImpl(
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
      @Uint8ListConverter()
      @HiveField(3)
      this.tenpuFileData});

  factory _$TenpuModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenpuModelImplFromJson(json);

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
  @Uint8ListConverter()
  @HiveField(3)
  final Uint8List? tenpuFileData;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenpuModelImpl &&
            (identical(other.tenpuId, tenpuId) || other.tenpuId == tenpuId) &&
            (identical(other.tenpuFileName, tenpuFileName) ||
                other.tenpuFileName == tenpuFileName) &&
            (identical(other.tenpuFileSize, tenpuFileSize) ||
                other.tenpuFileSize == tenpuFileSize) &&
            const DeepCollectionEquality()
                .equals(other.tenpuFileData, tenpuFileData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tenpuId, tenpuFileName,
      tenpuFileSize, const DeepCollectionEquality().hash(tenpuFileData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TenpuModelImplCopyWith<_$TenpuModelImpl> get copyWith =>
      __$$TenpuModelImplCopyWithImpl<_$TenpuModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TenpuModelImplToJson(
      this,
    );
  }
}

abstract class _TenpuModel implements TenpuModel {
  const factory _TenpuModel(
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
      @Uint8ListConverter()
      @HiveField(3)
      final Uint8List? tenpuFileData}) = _$TenpuModelImpl;

  factory _TenpuModel.fromJson(Map<String, dynamic> json) =
      _$TenpuModelImpl.fromJson;

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
  @Uint8ListConverter()
  @HiveField(3)
  Uint8List? get tenpuFileData;
  @override
  @JsonKey(ignore: true)
  _$$TenpuModelImplCopyWith<_$TenpuModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
