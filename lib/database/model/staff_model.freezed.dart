// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StaffModel _$StaffModelFromJson(Map<String, dynamic> json) {
  return _StaffModel.fromJson(json);
}

/// @nodoc
mixin _$StaffModel {
  @JsonKey(name: 'access_token', disallowNullValue: false)
  @HiveField(0)
  String? get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_type', disallowNullValue: false)
  @HiveField(1)
  String? get tokenType => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_in', disallowNullValue: false)
  @HiveField(2)
  String? get expiresIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'TenantId', disallowNullValue: false)
  @HiveField(3)
  String? get tenantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'LoginId', disallowNullValue: false)
  @HiveField(4)
  String? get loginId => throw _privateConstructorUsedError;
  @JsonKey(name: 'Dantai', disallowNullValue: false)
  @HiveField(5)
  String? get dantai => throw _privateConstructorUsedError;
  @JsonKey(name: 'UserName', disallowNullValue: false)
  @HiveField(6)
  String? get userName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StaffModelCopyWith<StaffModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffModelCopyWith<$Res> {
  factory $StaffModelCopyWith(
          StaffModel value, $Res Function(StaffModel) then) =
      _$StaffModelCopyWithImpl<$Res, StaffModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token', disallowNullValue: false)
      @HiveField(0)
      String? accessToken,
      @JsonKey(name: 'token_type', disallowNullValue: false)
      @HiveField(1)
      String? tokenType,
      @JsonKey(name: 'expires_in', disallowNullValue: false)
      @HiveField(2)
      String? expiresIn,
      @JsonKey(name: 'TenantId', disallowNullValue: false)
      @HiveField(3)
      String? tenantId,
      @JsonKey(name: 'LoginId', disallowNullValue: false)
      @HiveField(4)
      String? loginId,
      @JsonKey(name: 'Dantai', disallowNullValue: false)
      @HiveField(5)
      String? dantai,
      @JsonKey(name: 'UserName', disallowNullValue: false)
      @HiveField(6)
      String? userName});
}

/// @nodoc
class _$StaffModelCopyWithImpl<$Res, $Val extends StaffModel>
    implements $StaffModelCopyWith<$Res> {
  _$StaffModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? tokenType = freezed,
    Object? expiresIn = freezed,
    Object? tenantId = freezed,
    Object? loginId = freezed,
    Object? dantai = freezed,
    Object? userName = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenType: freezed == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      loginId: freezed == loginId
          ? _value.loginId
          : loginId // ignore: cast_nullable_to_non_nullable
              as String?,
      dantai: freezed == dantai
          ? _value.dantai
          : dantai // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaffModelImplCopyWith<$Res>
    implements $StaffModelCopyWith<$Res> {
  factory _$$StaffModelImplCopyWith(
          _$StaffModelImpl value, $Res Function(_$StaffModelImpl) then) =
      __$$StaffModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token', disallowNullValue: false)
      @HiveField(0)
      String? accessToken,
      @JsonKey(name: 'token_type', disallowNullValue: false)
      @HiveField(1)
      String? tokenType,
      @JsonKey(name: 'expires_in', disallowNullValue: false)
      @HiveField(2)
      String? expiresIn,
      @JsonKey(name: 'TenantId', disallowNullValue: false)
      @HiveField(3)
      String? tenantId,
      @JsonKey(name: 'LoginId', disallowNullValue: false)
      @HiveField(4)
      String? loginId,
      @JsonKey(name: 'Dantai', disallowNullValue: false)
      @HiveField(5)
      String? dantai,
      @JsonKey(name: 'UserName', disallowNullValue: false)
      @HiveField(6)
      String? userName});
}

/// @nodoc
class __$$StaffModelImplCopyWithImpl<$Res>
    extends _$StaffModelCopyWithImpl<$Res, _$StaffModelImpl>
    implements _$$StaffModelImplCopyWith<$Res> {
  __$$StaffModelImplCopyWithImpl(
      _$StaffModelImpl _value, $Res Function(_$StaffModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? tokenType = freezed,
    Object? expiresIn = freezed,
    Object? tenantId = freezed,
    Object? loginId = freezed,
    Object? dantai = freezed,
    Object? userName = freezed,
  }) {
    return _then(_$StaffModelImpl(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenType: freezed == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      loginId: freezed == loginId
          ? _value.loginId
          : loginId // ignore: cast_nullable_to_non_nullable
              as String?,
      dantai: freezed == dantai
          ? _value.dantai
          : dantai // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'StaffModelAdapter')
class _$StaffModelImpl implements _StaffModel {
  const _$StaffModelImpl(
      {@JsonKey(name: 'access_token', disallowNullValue: false)
      @HiveField(0)
      this.accessToken,
      @JsonKey(name: 'token_type', disallowNullValue: false)
      @HiveField(1)
      this.tokenType,
      @JsonKey(name: 'expires_in', disallowNullValue: false)
      @HiveField(2)
      this.expiresIn,
      @JsonKey(name: 'TenantId', disallowNullValue: false)
      @HiveField(3)
      this.tenantId,
      @JsonKey(name: 'LoginId', disallowNullValue: false)
      @HiveField(4)
      this.loginId,
      @JsonKey(name: 'Dantai', disallowNullValue: false)
      @HiveField(5)
      this.dantai,
      @JsonKey(name: 'UserName', disallowNullValue: false)
      @HiveField(6)
      this.userName});

  factory _$StaffModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffModelImplFromJson(json);

  @override
  @JsonKey(name: 'access_token', disallowNullValue: false)
  @HiveField(0)
  final String? accessToken;
  @override
  @JsonKey(name: 'token_type', disallowNullValue: false)
  @HiveField(1)
  final String? tokenType;
  @override
  @JsonKey(name: 'expires_in', disallowNullValue: false)
  @HiveField(2)
  final String? expiresIn;
  @override
  @JsonKey(name: 'TenantId', disallowNullValue: false)
  @HiveField(3)
  final String? tenantId;
  @override
  @JsonKey(name: 'LoginId', disallowNullValue: false)
  @HiveField(4)
  final String? loginId;
  @override
  @JsonKey(name: 'Dantai', disallowNullValue: false)
  @HiveField(5)
  final String? dantai;
  @override
  @JsonKey(name: 'UserName', disallowNullValue: false)
  @HiveField(6)
  final String? userName;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffModelImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.loginId, loginId) || other.loginId == loginId) &&
            (identical(other.dantai, dantai) || other.dantai == dantai) &&
            (identical(other.userName, userName) ||
                other.userName == userName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, tokenType,
      expiresIn, tenantId, loginId, dantai, userName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffModelImplCopyWith<_$StaffModelImpl> get copyWith =>
      __$$StaffModelImplCopyWithImpl<_$StaffModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffModelImplToJson(
      this,
    );
  }
}

abstract class _StaffModel implements StaffModel {
  const factory _StaffModel(
      {@JsonKey(name: 'access_token', disallowNullValue: false)
      @HiveField(0)
      final String? accessToken,
      @JsonKey(name: 'token_type', disallowNullValue: false)
      @HiveField(1)
      final String? tokenType,
      @JsonKey(name: 'expires_in', disallowNullValue: false)
      @HiveField(2)
      final String? expiresIn,
      @JsonKey(name: 'TenantId', disallowNullValue: false)
      @HiveField(3)
      final String? tenantId,
      @JsonKey(name: 'LoginId', disallowNullValue: false)
      @HiveField(4)
      final String? loginId,
      @JsonKey(name: 'Dantai', disallowNullValue: false)
      @HiveField(5)
      final String? dantai,
      @JsonKey(name: 'UserName', disallowNullValue: false)
      @HiveField(6)
      final String? userName}) = _$StaffModelImpl;

  factory _StaffModel.fromJson(Map<String, dynamic> json) =
      _$StaffModelImpl.fromJson;

  @override
  @JsonKey(name: 'access_token', disallowNullValue: false)
  @HiveField(0)
  String? get accessToken;
  @override
  @JsonKey(name: 'token_type', disallowNullValue: false)
  @HiveField(1)
  String? get tokenType;
  @override
  @JsonKey(name: 'expires_in', disallowNullValue: false)
  @HiveField(2)
  String? get expiresIn;
  @override
  @JsonKey(name: 'TenantId', disallowNullValue: false)
  @HiveField(3)
  String? get tenantId;
  @override
  @JsonKey(name: 'LoginId', disallowNullValue: false)
  @HiveField(4)
  String? get loginId;
  @override
  @JsonKey(name: 'Dantai', disallowNullValue: false)
  @HiveField(5)
  String? get dantai;
  @override
  @JsonKey(name: 'UserName', disallowNullValue: false)
  @HiveField(6)
  String? get userName;
  @override
  @JsonKey(ignore: true)
  _$$StaffModelImplCopyWith<_$StaffModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
