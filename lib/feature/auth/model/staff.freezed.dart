// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Staff _$StaffFromJson(Map<String, dynamic> json) {
  return _Staff.fromJson(json);
}

/// @nodoc
mixin _$Staff {
  String get access_token => throw _privateConstructorUsedError;
  String get token_type =>
      throw _privateConstructorUsedError; //required DateTime expires_in,
  String get TenantId => throw _privateConstructorUsedError;
  String get LoginId => throw _privateConstructorUsedError;
  String get DantaiId => throw _privateConstructorUsedError;
  String get Dantai => throw _privateConstructorUsedError;
  String get UserName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StaffCopyWith<Staff> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffCopyWith<$Res> {
  factory $StaffCopyWith(Staff value, $Res Function(Staff) then) =
      _$StaffCopyWithImpl<$Res, Staff>;
  @useResult
  $Res call(
      {String access_token,
      String token_type,
      String TenantId,
      String LoginId,
      String DantaiId,
      String Dantai,
      String UserName});
}

/// @nodoc
class _$StaffCopyWithImpl<$Res, $Val extends Staff>
    implements $StaffCopyWith<$Res> {
  _$StaffCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? access_token = null,
    Object? token_type = null,
    Object? TenantId = null,
    Object? LoginId = null,
    Object? DantaiId = null,
    Object? Dantai = null,
    Object? UserName = null,
  }) {
    return _then(_value.copyWith(
      access_token: null == access_token
          ? _value.access_token
          : access_token // ignore: cast_nullable_to_non_nullable
              as String,
      token_type: null == token_type
          ? _value.token_type
          : token_type // ignore: cast_nullable_to_non_nullable
              as String,
      TenantId: null == TenantId
          ? _value.TenantId
          : TenantId // ignore: cast_nullable_to_non_nullable
              as String,
      LoginId: null == LoginId
          ? _value.LoginId
          : LoginId // ignore: cast_nullable_to_non_nullable
              as String,
      DantaiId: null == DantaiId
          ? _value.DantaiId
          : DantaiId // ignore: cast_nullable_to_non_nullable
              as String,
      Dantai: null == Dantai
          ? _value.Dantai
          : Dantai // ignore: cast_nullable_to_non_nullable
              as String,
      UserName: null == UserName
          ? _value.UserName
          : UserName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaffImplCopyWith<$Res> implements $StaffCopyWith<$Res> {
  factory _$$StaffImplCopyWith(
          _$StaffImpl value, $Res Function(_$StaffImpl) then) =
      __$$StaffImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String access_token,
      String token_type,
      String TenantId,
      String LoginId,
      String DantaiId,
      String Dantai,
      String UserName});
}

/// @nodoc
class __$$StaffImplCopyWithImpl<$Res>
    extends _$StaffCopyWithImpl<$Res, _$StaffImpl>
    implements _$$StaffImplCopyWith<$Res> {
  __$$StaffImplCopyWithImpl(
      _$StaffImpl _value, $Res Function(_$StaffImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? access_token = null,
    Object? token_type = null,
    Object? TenantId = null,
    Object? LoginId = null,
    Object? DantaiId = null,
    Object? Dantai = null,
    Object? UserName = null,
  }) {
    return _then(_$StaffImpl(
      access_token: null == access_token
          ? _value.access_token
          : access_token // ignore: cast_nullable_to_non_nullable
              as String,
      token_type: null == token_type
          ? _value.token_type
          : token_type // ignore: cast_nullable_to_non_nullable
              as String,
      TenantId: null == TenantId
          ? _value.TenantId
          : TenantId // ignore: cast_nullable_to_non_nullable
              as String,
      LoginId: null == LoginId
          ? _value.LoginId
          : LoginId // ignore: cast_nullable_to_non_nullable
              as String,
      DantaiId: null == DantaiId
          ? _value.DantaiId
          : DantaiId // ignore: cast_nullable_to_non_nullable
              as String,
      Dantai: null == Dantai
          ? _value.Dantai
          : Dantai // ignore: cast_nullable_to_non_nullable
              as String,
      UserName: null == UserName
          ? _value.UserName
          : UserName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffImpl extends _Staff {
  const _$StaffImpl(
      {required this.access_token,
      required this.token_type,
      required this.TenantId,
      required this.LoginId,
      required this.DantaiId,
      required this.Dantai,
      required this.UserName})
      : super._();

  factory _$StaffImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffImplFromJson(json);

  @override
  final String access_token;
  @override
  final String token_type;
//required DateTime expires_in,
  @override
  final String TenantId;
  @override
  final String LoginId;
  @override
  final String DantaiId;
  @override
  final String Dantai;
  @override
  final String UserName;

  @override
  String toString() {
    return 'Staff(access_token: $access_token, token_type: $token_type, TenantId: $TenantId, LoginId: $LoginId, DantaiId: $DantaiId, Dantai: $Dantai, UserName: $UserName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffImpl &&
            (identical(other.access_token, access_token) ||
                other.access_token == access_token) &&
            (identical(other.token_type, token_type) ||
                other.token_type == token_type) &&
            (identical(other.TenantId, TenantId) ||
                other.TenantId == TenantId) &&
            (identical(other.LoginId, LoginId) || other.LoginId == LoginId) &&
            (identical(other.DantaiId, DantaiId) ||
                other.DantaiId == DantaiId) &&
            (identical(other.Dantai, Dantai) || other.Dantai == Dantai) &&
            (identical(other.UserName, UserName) ||
                other.UserName == UserName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, access_token, token_type,
      TenantId, LoginId, DantaiId, Dantai, UserName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      __$$StaffImplCopyWithImpl<_$StaffImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffImplToJson(
      this,
    );
  }
}

abstract class _Staff extends Staff {
  const factory _Staff(
      {required final String access_token,
      required final String token_type,
      required final String TenantId,
      required final String LoginId,
      required final String DantaiId,
      required final String Dantai,
      required final String UserName}) = _$StaffImpl;
  const _Staff._() : super._();

  factory _Staff.fromJson(Map<String, dynamic> json) = _$StaffImpl.fromJson;

  @override
  String get access_token;
  @override
  String get token_type;
  @override //required DateTime expires_in,
  String get TenantId;
  @override
  String get LoginId;
  @override
  String get DantaiId;
  @override
  String get Dantai;
  @override
  String get UserName;
  @override
  @JsonKey(ignore: true)
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
