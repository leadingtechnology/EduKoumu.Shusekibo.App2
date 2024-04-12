// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'awareness_code_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AwarenessCodeModel _$AwarenessCodeModelFromJson(Map<String, dynamic> json) {
  return _AwarenessCodeModel.fromJson(json);
}

/// @nodoc
mixin _$AwarenessCodeModel {
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(0)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'Code', disallowNullValue: false)
  @HiveField(1)
  String? get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'Name', disallowNullValue: false)
  @HiveField(2)
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'ShortName', disallowNullValue: false)
  @HiveField(3)
  String? get shortName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AwarenessCodeModelCopyWith<AwarenessCodeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AwarenessCodeModelCopyWith<$Res> {
  factory $AwarenessCodeModelCopyWith(
          AwarenessCodeModel value, $Res Function(AwarenessCodeModel) then) =
      _$AwarenessCodeModelCopyWithImpl<$Res, AwarenessCodeModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
      @JsonKey(name: 'Code', disallowNullValue: false)
      @HiveField(1)
      String? code,
      @JsonKey(name: 'Name', disallowNullValue: false)
      @HiveField(2)
      String? name,
      @JsonKey(name: 'ShortName', disallowNullValue: false)
      @HiveField(3)
      String? shortName});
}

/// @nodoc
class _$AwarenessCodeModelCopyWithImpl<$Res, $Val extends AwarenessCodeModel>
    implements $AwarenessCodeModelCopyWith<$Res> {
  _$AwarenessCodeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AwarenessCodeModelImplCopyWith<$Res>
    implements $AwarenessCodeModelCopyWith<$Res> {
  factory _$$AwarenessCodeModelImplCopyWith(_$AwarenessCodeModelImpl value,
          $Res Function(_$AwarenessCodeModelImpl) then) =
      __$$AwarenessCodeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
      @JsonKey(name: 'Code', disallowNullValue: false)
      @HiveField(1)
      String? code,
      @JsonKey(name: 'Name', disallowNullValue: false)
      @HiveField(2)
      String? name,
      @JsonKey(name: 'ShortName', disallowNullValue: false)
      @HiveField(3)
      String? shortName});
}

/// @nodoc
class __$$AwarenessCodeModelImplCopyWithImpl<$Res>
    extends _$AwarenessCodeModelCopyWithImpl<$Res, _$AwarenessCodeModelImpl>
    implements _$$AwarenessCodeModelImplCopyWith<$Res> {
  __$$AwarenessCodeModelImplCopyWithImpl(_$AwarenessCodeModelImpl _value,
      $Res Function(_$AwarenessCodeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_$AwarenessCodeModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 33, adapterName: 'AwarenessCodeModelAdapter')
class _$AwarenessCodeModelImpl implements _AwarenessCodeModel {
  const _$AwarenessCodeModelImpl(
      {@JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) this.id,
      @JsonKey(name: 'Code', disallowNullValue: false) @HiveField(1) this.code,
      @JsonKey(name: 'Name', disallowNullValue: false) @HiveField(2) this.name,
      @JsonKey(name: 'ShortName', disallowNullValue: false)
      @HiveField(3)
      this.shortName});

  factory _$AwarenessCodeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AwarenessCodeModelImplFromJson(json);

  @override
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(0)
  final int? id;
  @override
  @JsonKey(name: 'Code', disallowNullValue: false)
  @HiveField(1)
  final String? code;
  @override
  @JsonKey(name: 'Name', disallowNullValue: false)
  @HiveField(2)
  final String? name;
  @override
  @JsonKey(name: 'ShortName', disallowNullValue: false)
  @HiveField(3)
  final String? shortName;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AwarenessCodeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, code, name, shortName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AwarenessCodeModelImplCopyWith<_$AwarenessCodeModelImpl> get copyWith =>
      __$$AwarenessCodeModelImplCopyWithImpl<_$AwarenessCodeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AwarenessCodeModelImplToJson(
      this,
    );
  }
}

abstract class _AwarenessCodeModel implements AwarenessCodeModel {
  const factory _AwarenessCodeModel(
      {@JsonKey(name: 'Id', disallowNullValue: false)
      @HiveField(0)
      final int? id,
      @JsonKey(name: 'Code', disallowNullValue: false)
      @HiveField(1)
      final String? code,
      @JsonKey(name: 'Name', disallowNullValue: false)
      @HiveField(2)
      final String? name,
      @JsonKey(name: 'ShortName', disallowNullValue: false)
      @HiveField(3)
      final String? shortName}) = _$AwarenessCodeModelImpl;

  factory _AwarenessCodeModel.fromJson(Map<String, dynamic> json) =
      _$AwarenessCodeModelImpl.fromJson;

  @override
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(0)
  int? get id;
  @override
  @JsonKey(name: 'Code', disallowNullValue: false)
  @HiveField(1)
  String? get code;
  @override
  @JsonKey(name: 'Name', disallowNullValue: false)
  @HiveField(2)
  String? get name;
  @override
  @JsonKey(name: 'ShortName', disallowNullValue: false)
  @HiveField(3)
  String? get shortName;
  @override
  @JsonKey(ignore: true)
  _$$AwarenessCodeModelImplCopyWith<_$AwarenessCodeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
