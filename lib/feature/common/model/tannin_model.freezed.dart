// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tannin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TanninModel _$TanninModelFromJson(Map<String, dynamic> json) {
  return _TanninModel.fromJson(json);
}

/// @nodoc
mixin _$TanninModel {
  @JsonKey(name: 'GakunenCode', disallowNullValue: false)
  @HiveField(0)
  String? get gakunenCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'ClassName', disallowNullValue: false)
  @HiveField(1)
  String? get className => throw _privateConstructorUsedError;
  @JsonKey(name: 'ShozokuId', disallowNullValue: false)
  @HiveField(2)
  int? get shozokuId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TanninModelCopyWith<TanninModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TanninModelCopyWith<$Res> {
  factory $TanninModelCopyWith(
          TanninModel value, $Res Function(TanninModel) then) =
      _$TanninModelCopyWithImpl<$Res, TanninModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'GakunenCode', disallowNullValue: false)
      @HiveField(0)
      String? gakunenCode,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(1)
      String? className,
      @JsonKey(name: 'ShozokuId', disallowNullValue: false)
      @HiveField(2)
      int? shozokuId});
}

/// @nodoc
class _$TanninModelCopyWithImpl<$Res, $Val extends TanninModel>
    implements $TanninModelCopyWith<$Res> {
  _$TanninModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gakunenCode = freezed,
    Object? className = freezed,
    Object? shozokuId = freezed,
  }) {
    return _then(_value.copyWith(
      gakunenCode: freezed == gakunenCode
          ? _value.gakunenCode
          : gakunenCode // ignore: cast_nullable_to_non_nullable
              as String?,
      className: freezed == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      shozokuId: freezed == shozokuId
          ? _value.shozokuId
          : shozokuId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TanninModelImplCopyWith<$Res>
    implements $TanninModelCopyWith<$Res> {
  factory _$$TanninModelImplCopyWith(
          _$TanninModelImpl value, $Res Function(_$TanninModelImpl) then) =
      __$$TanninModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'GakunenCode', disallowNullValue: false)
      @HiveField(0)
      String? gakunenCode,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(1)
      String? className,
      @JsonKey(name: 'ShozokuId', disallowNullValue: false)
      @HiveField(2)
      int? shozokuId});
}

/// @nodoc
class __$$TanninModelImplCopyWithImpl<$Res>
    extends _$TanninModelCopyWithImpl<$Res, _$TanninModelImpl>
    implements _$$TanninModelImplCopyWith<$Res> {
  __$$TanninModelImplCopyWithImpl(
      _$TanninModelImpl _value, $Res Function(_$TanninModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gakunenCode = freezed,
    Object? className = freezed,
    Object? shozokuId = freezed,
  }) {
    return _then(_$TanninModelImpl(
      gakunenCode: freezed == gakunenCode
          ? _value.gakunenCode
          : gakunenCode // ignore: cast_nullable_to_non_nullable
              as String?,
      className: freezed == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      shozokuId: freezed == shozokuId
          ? _value.shozokuId
          : shozokuId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 43, adapterName: 'TanninModelAdapter')
class _$TanninModelImpl implements _TanninModel {
  const _$TanninModelImpl(
      {@JsonKey(name: 'GakunenCode', disallowNullValue: false)
      @HiveField(0)
      this.gakunenCode,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(1)
      this.className,
      @JsonKey(name: 'ShozokuId', disallowNullValue: false)
      @HiveField(2)
      this.shozokuId});

  factory _$TanninModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TanninModelImplFromJson(json);

  @override
  @JsonKey(name: 'GakunenCode', disallowNullValue: false)
  @HiveField(0)
  final String? gakunenCode;
  @override
  @JsonKey(name: 'ClassName', disallowNullValue: false)
  @HiveField(1)
  final String? className;
  @override
  @JsonKey(name: 'ShozokuId', disallowNullValue: false)
  @HiveField(2)
  final int? shozokuId;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TanninModelImpl &&
            (identical(other.gakunenCode, gakunenCode) ||
                other.gakunenCode == gakunenCode) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.shozokuId, shozokuId) ||
                other.shozokuId == shozokuId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, gakunenCode, className, shozokuId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TanninModelImplCopyWith<_$TanninModelImpl> get copyWith =>
      __$$TanninModelImplCopyWithImpl<_$TanninModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TanninModelImplToJson(
      this,
    );
  }
}

abstract class _TanninModel implements TanninModel {
  const factory _TanninModel(
      {@JsonKey(name: 'GakunenCode', disallowNullValue: false)
      @HiveField(0)
      final String? gakunenCode,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(1)
      final String? className,
      @JsonKey(name: 'ShozokuId', disallowNullValue: false)
      @HiveField(2)
      final int? shozokuId}) = _$TanninModelImpl;

  factory _TanninModel.fromJson(Map<String, dynamic> json) =
      _$TanninModelImpl.fromJson;

  @override
  @JsonKey(name: 'GakunenCode', disallowNullValue: false)
  @HiveField(0)
  String? get gakunenCode;
  @override
  @JsonKey(name: 'ClassName', disallowNullValue: false)
  @HiveField(1)
  String? get className;
  @override
  @JsonKey(name: 'ShozokuId', disallowNullValue: false)
  @HiveField(2)
  int? get shozokuId;
  @override
  @JsonKey(ignore: true)
  _$$TanninModelImplCopyWith<_$TanninModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
