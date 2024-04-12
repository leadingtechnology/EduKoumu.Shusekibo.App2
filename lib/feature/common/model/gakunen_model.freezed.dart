// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gakunen_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GakunenModel _$GakunenModelFromJson(Map<String, dynamic> json) {
  return _GakunenModel.fromJson(json);
}

/// @nodoc
mixin _$GakunenModel {
  @JsonKey(name: 'OrganizationId', disallowNullValue: false)
  @HiveField(0)
  int? get organizationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'GakunenCode', disallowNullValue: false)
  @HiveField(1)
  String? get gakunenCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'GakunenName', disallowNullValue: false)
  @HiveField(2)
  String? get gakunenName => throw _privateConstructorUsedError;
  @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
  @HiveField(3)
  String? get gakunenRyakusho => throw _privateConstructorUsedError;
  @JsonKey(name: 'KateiKbn', disallowNullValue: false)
  @HiveField(4)
  String? get kateiKbn => throw _privateConstructorUsedError;
  @JsonKey(name: 'ZaisekiAgeLowLimit', disallowNullValue: false)
  @HiveField(5)
  int? get zaisekiAgeLowLimit => throw _privateConstructorUsedError;
  @JsonKey(name: 'IsTantoGakunen', disallowNullValue: false)
  @HiveField(6)
  bool? get isTantoGakunen => throw _privateConstructorUsedError;
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(7)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'Code', disallowNullValue: false)
  @HiveField(8)
  String? get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'Name', disallowNullValue: false)
  @HiveField(9)
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GakunenModelCopyWith<GakunenModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GakunenModelCopyWith<$Res> {
  factory $GakunenModelCopyWith(
          GakunenModel value, $Res Function(GakunenModel) then) =
      _$GakunenModelCopyWithImpl<$Res, GakunenModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'OrganizationId', disallowNullValue: false)
      @HiveField(0)
      int? organizationId,
      @JsonKey(name: 'GakunenCode', disallowNullValue: false)
      @HiveField(1)
      String? gakunenCode,
      @JsonKey(name: 'GakunenName', disallowNullValue: false)
      @HiveField(2)
      String? gakunenName,
      @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
      @HiveField(3)
      String? gakunenRyakusho,
      @JsonKey(name: 'KateiKbn', disallowNullValue: false)
      @HiveField(4)
      String? kateiKbn,
      @JsonKey(name: 'ZaisekiAgeLowLimit', disallowNullValue: false)
      @HiveField(5)
      int? zaisekiAgeLowLimit,
      @JsonKey(name: 'IsTantoGakunen', disallowNullValue: false)
      @HiveField(6)
      bool? isTantoGakunen,
      @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(7) int? id,
      @JsonKey(name: 'Code', disallowNullValue: false)
      @HiveField(8)
      String? code,
      @JsonKey(name: 'Name', disallowNullValue: false)
      @HiveField(9)
      String? name});
}

/// @nodoc
class _$GakunenModelCopyWithImpl<$Res, $Val extends GakunenModel>
    implements $GakunenModelCopyWith<$Res> {
  _$GakunenModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = freezed,
    Object? gakunenCode = freezed,
    Object? gakunenName = freezed,
    Object? gakunenRyakusho = freezed,
    Object? kateiKbn = freezed,
    Object? zaisekiAgeLowLimit = freezed,
    Object? isTantoGakunen = freezed,
    Object? id = freezed,
    Object? code = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as int?,
      gakunenCode: freezed == gakunenCode
          ? _value.gakunenCode
          : gakunenCode // ignore: cast_nullable_to_non_nullable
              as String?,
      gakunenName: freezed == gakunenName
          ? _value.gakunenName
          : gakunenName // ignore: cast_nullable_to_non_nullable
              as String?,
      gakunenRyakusho: freezed == gakunenRyakusho
          ? _value.gakunenRyakusho
          : gakunenRyakusho // ignore: cast_nullable_to_non_nullable
              as String?,
      kateiKbn: freezed == kateiKbn
          ? _value.kateiKbn
          : kateiKbn // ignore: cast_nullable_to_non_nullable
              as String?,
      zaisekiAgeLowLimit: freezed == zaisekiAgeLowLimit
          ? _value.zaisekiAgeLowLimit
          : zaisekiAgeLowLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      isTantoGakunen: freezed == isTantoGakunen
          ? _value.isTantoGakunen
          : isTantoGakunen // ignore: cast_nullable_to_non_nullable
              as bool?,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GakunenModelImplCopyWith<$Res>
    implements $GakunenModelCopyWith<$Res> {
  factory _$$GakunenModelImplCopyWith(
          _$GakunenModelImpl value, $Res Function(_$GakunenModelImpl) then) =
      __$$GakunenModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'OrganizationId', disallowNullValue: false)
      @HiveField(0)
      int? organizationId,
      @JsonKey(name: 'GakunenCode', disallowNullValue: false)
      @HiveField(1)
      String? gakunenCode,
      @JsonKey(name: 'GakunenName', disallowNullValue: false)
      @HiveField(2)
      String? gakunenName,
      @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
      @HiveField(3)
      String? gakunenRyakusho,
      @JsonKey(name: 'KateiKbn', disallowNullValue: false)
      @HiveField(4)
      String? kateiKbn,
      @JsonKey(name: 'ZaisekiAgeLowLimit', disallowNullValue: false)
      @HiveField(5)
      int? zaisekiAgeLowLimit,
      @JsonKey(name: 'IsTantoGakunen', disallowNullValue: false)
      @HiveField(6)
      bool? isTantoGakunen,
      @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(7) int? id,
      @JsonKey(name: 'Code', disallowNullValue: false)
      @HiveField(8)
      String? code,
      @JsonKey(name: 'Name', disallowNullValue: false)
      @HiveField(9)
      String? name});
}

/// @nodoc
class __$$GakunenModelImplCopyWithImpl<$Res>
    extends _$GakunenModelCopyWithImpl<$Res, _$GakunenModelImpl>
    implements _$$GakunenModelImplCopyWith<$Res> {
  __$$GakunenModelImplCopyWithImpl(
      _$GakunenModelImpl _value, $Res Function(_$GakunenModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = freezed,
    Object? gakunenCode = freezed,
    Object? gakunenName = freezed,
    Object? gakunenRyakusho = freezed,
    Object? kateiKbn = freezed,
    Object? zaisekiAgeLowLimit = freezed,
    Object? isTantoGakunen = freezed,
    Object? id = freezed,
    Object? code = freezed,
    Object? name = freezed,
  }) {
    return _then(_$GakunenModelImpl(
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as int?,
      gakunenCode: freezed == gakunenCode
          ? _value.gakunenCode
          : gakunenCode // ignore: cast_nullable_to_non_nullable
              as String?,
      gakunenName: freezed == gakunenName
          ? _value.gakunenName
          : gakunenName // ignore: cast_nullable_to_non_nullable
              as String?,
      gakunenRyakusho: freezed == gakunenRyakusho
          ? _value.gakunenRyakusho
          : gakunenRyakusho // ignore: cast_nullable_to_non_nullable
              as String?,
      kateiKbn: freezed == kateiKbn
          ? _value.kateiKbn
          : kateiKbn // ignore: cast_nullable_to_non_nullable
              as String?,
      zaisekiAgeLowLimit: freezed == zaisekiAgeLowLimit
          ? _value.zaisekiAgeLowLimit
          : zaisekiAgeLowLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      isTantoGakunen: freezed == isTantoGakunen
          ? _value.isTantoGakunen
          : isTantoGakunen // ignore: cast_nullable_to_non_nullable
              as bool?,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 3, adapterName: 'GakunenModelAdapter')
class _$GakunenModelImpl implements _GakunenModel {
  const _$GakunenModelImpl(
      {@JsonKey(name: 'OrganizationId', disallowNullValue: false)
      @HiveField(0)
      this.organizationId,
      @JsonKey(name: 'GakunenCode', disallowNullValue: false)
      @HiveField(1)
      this.gakunenCode,
      @JsonKey(name: 'GakunenName', disallowNullValue: false)
      @HiveField(2)
      this.gakunenName,
      @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
      @HiveField(3)
      this.gakunenRyakusho,
      @JsonKey(name: 'KateiKbn', disallowNullValue: false)
      @HiveField(4)
      this.kateiKbn,
      @JsonKey(name: 'ZaisekiAgeLowLimit', disallowNullValue: false)
      @HiveField(5)
      this.zaisekiAgeLowLimit,
      @JsonKey(name: 'IsTantoGakunen', disallowNullValue: false)
      @HiveField(6)
      this.isTantoGakunen,
      @JsonKey(name: 'Id', disallowNullValue: false) @HiveField(7) this.id,
      @JsonKey(name: 'Code', disallowNullValue: false) @HiveField(8) this.code,
      @JsonKey(name: 'Name', disallowNullValue: false)
      @HiveField(9)
      this.name});

  factory _$GakunenModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GakunenModelImplFromJson(json);

  @override
  @JsonKey(name: 'OrganizationId', disallowNullValue: false)
  @HiveField(0)
  final int? organizationId;
  @override
  @JsonKey(name: 'GakunenCode', disallowNullValue: false)
  @HiveField(1)
  final String? gakunenCode;
  @override
  @JsonKey(name: 'GakunenName', disallowNullValue: false)
  @HiveField(2)
  final String? gakunenName;
  @override
  @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
  @HiveField(3)
  final String? gakunenRyakusho;
  @override
  @JsonKey(name: 'KateiKbn', disallowNullValue: false)
  @HiveField(4)
  final String? kateiKbn;
  @override
  @JsonKey(name: 'ZaisekiAgeLowLimit', disallowNullValue: false)
  @HiveField(5)
  final int? zaisekiAgeLowLimit;
  @override
  @JsonKey(name: 'IsTantoGakunen', disallowNullValue: false)
  @HiveField(6)
  final bool? isTantoGakunen;
  @override
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(7)
  final int? id;
  @override
  @JsonKey(name: 'Code', disallowNullValue: false)
  @HiveField(8)
  final String? code;
  @override
  @JsonKey(name: 'Name', disallowNullValue: false)
  @HiveField(9)
  final String? name;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GakunenModelImplCopyWith<_$GakunenModelImpl> get copyWith =>
      __$$GakunenModelImplCopyWithImpl<_$GakunenModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GakunenModelImplToJson(
      this,
    );
  }
}

abstract class _GakunenModel implements GakunenModel {
  const factory _GakunenModel(
      {@JsonKey(name: 'OrganizationId', disallowNullValue: false)
      @HiveField(0)
      final int? organizationId,
      @JsonKey(name: 'GakunenCode', disallowNullValue: false)
      @HiveField(1)
      final String? gakunenCode,
      @JsonKey(name: 'GakunenName', disallowNullValue: false)
      @HiveField(2)
      final String? gakunenName,
      @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
      @HiveField(3)
      final String? gakunenRyakusho,
      @JsonKey(name: 'KateiKbn', disallowNullValue: false)
      @HiveField(4)
      final String? kateiKbn,
      @JsonKey(name: 'ZaisekiAgeLowLimit', disallowNullValue: false)
      @HiveField(5)
      final int? zaisekiAgeLowLimit,
      @JsonKey(name: 'IsTantoGakunen', disallowNullValue: false)
      @HiveField(6)
      final bool? isTantoGakunen,
      @JsonKey(name: 'Id', disallowNullValue: false)
      @HiveField(7)
      final int? id,
      @JsonKey(name: 'Code', disallowNullValue: false)
      @HiveField(8)
      final String? code,
      @JsonKey(name: 'Name', disallowNullValue: false)
      @HiveField(9)
      final String? name}) = _$GakunenModelImpl;

  factory _GakunenModel.fromJson(Map<String, dynamic> json) =
      _$GakunenModelImpl.fromJson;

  @override
  @JsonKey(name: 'OrganizationId', disallowNullValue: false)
  @HiveField(0)
  int? get organizationId;
  @override
  @JsonKey(name: 'GakunenCode', disallowNullValue: false)
  @HiveField(1)
  String? get gakunenCode;
  @override
  @JsonKey(name: 'GakunenName', disallowNullValue: false)
  @HiveField(2)
  String? get gakunenName;
  @override
  @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
  @HiveField(3)
  String? get gakunenRyakusho;
  @override
  @JsonKey(name: 'KateiKbn', disallowNullValue: false)
  @HiveField(4)
  String? get kateiKbn;
  @override
  @JsonKey(name: 'ZaisekiAgeLowLimit', disallowNullValue: false)
  @HiveField(5)
  int? get zaisekiAgeLowLimit;
  @override
  @JsonKey(name: 'IsTantoGakunen', disallowNullValue: false)
  @HiveField(6)
  bool? get isTantoGakunen;
  @override
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(7)
  int? get id;
  @override
  @JsonKey(name: 'Code', disallowNullValue: false)
  @HiveField(8)
  String? get code;
  @override
  @JsonKey(name: 'Name', disallowNullValue: false)
  @HiveField(9)
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$GakunenModelImplCopyWith<_$GakunenModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
