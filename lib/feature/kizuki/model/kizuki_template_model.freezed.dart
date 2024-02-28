// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kizuki_template_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KizukiTemplateModel _$KizukiTemplateModelFromJson(Map<String, dynamic> json) {
  return _KizukiTemplateModel.fromJson(json);
}

/// @nodoc
mixin _$KizukiTemplateModel {
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(0)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'TenantId', disallowNullValue: false)
  @HiveField(1)
  int? get tenantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'KinyuKyoinId', disallowNullValue: false)
  @HiveField(2)
  int? get kinyuKyoinId => throw _privateConstructorUsedError;
  @JsonKey(name: 'KinyuKyoinName', disallowNullValue: false)
  @HiveField(3)
  String? get kinyuKyoinName => throw _privateConstructorUsedError;
  @JsonKey(name: 'KaruteSettingId', disallowNullValue: false)
  @HiveField(4)
  int? get karuteSettingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'KaruteShubetsuNaibuCode', disallowNullValue: false)
  @HiveField(5)
  String? get karuteShubetsuNaibuCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'KaruteBunruiCode', disallowNullValue: false)
  @HiveField(6)
  String? get karuteBunruiCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'Title', disallowNullValue: false)
  @HiveField(7)
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'KizukiTemplate', disallowNullValue: false)
  @HiveField(8)
  String? get kizukiTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: 'CommonFlg', disallowNullValue: false)
  @HiveField(9)
  bool? get commonFlg => throw _privateConstructorUsedError;
  @JsonKey(name: 'ModifiedDateTime', disallowNullValue: false)
  @HiveField(10)
  String? get modifiedDateTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'TIMESTAMP', disallowNullValue: false)
  @HiveField(11)
  String? get timeStamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KizukiTemplateModelCopyWith<KizukiTemplateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KizukiTemplateModelCopyWith<$Res> {
  factory $KizukiTemplateModelCopyWith(
          KizukiTemplateModel value, $Res Function(KizukiTemplateModel) then) =
      _$KizukiTemplateModelCopyWithImpl<$Res, KizukiTemplateModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
      @JsonKey(name: 'TenantId', disallowNullValue: false)
      @HiveField(1)
      int? tenantId,
      @JsonKey(name: 'KinyuKyoinId', disallowNullValue: false)
      @HiveField(2)
      int? kinyuKyoinId,
      @JsonKey(name: 'KinyuKyoinName', disallowNullValue: false)
      @HiveField(3)
      String? kinyuKyoinName,
      @JsonKey(name: 'KaruteSettingId', disallowNullValue: false)
      @HiveField(4)
      int? karuteSettingId,
      @JsonKey(name: 'KaruteShubetsuNaibuCode', disallowNullValue: false)
      @HiveField(5)
      String? karuteShubetsuNaibuCode,
      @JsonKey(name: 'KaruteBunruiCode', disallowNullValue: false)
      @HiveField(6)
      String? karuteBunruiCode,
      @JsonKey(name: 'Title', disallowNullValue: false)
      @HiveField(7)
      String? title,
      @JsonKey(name: 'KizukiTemplate', disallowNullValue: false)
      @HiveField(8)
      String? kizukiTemplate,
      @JsonKey(name: 'CommonFlg', disallowNullValue: false)
      @HiveField(9)
      bool? commonFlg,
      @JsonKey(name: 'ModifiedDateTime', disallowNullValue: false)
      @HiveField(10)
      String? modifiedDateTime,
      @JsonKey(name: 'TIMESTAMP', disallowNullValue: false)
      @HiveField(11)
      String? timeStamp});
}

/// @nodoc
class _$KizukiTemplateModelCopyWithImpl<$Res, $Val extends KizukiTemplateModel>
    implements $KizukiTemplateModelCopyWith<$Res> {
  _$KizukiTemplateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? kinyuKyoinId = freezed,
    Object? kinyuKyoinName = freezed,
    Object? karuteSettingId = freezed,
    Object? karuteShubetsuNaibuCode = freezed,
    Object? karuteBunruiCode = freezed,
    Object? title = freezed,
    Object? kizukiTemplate = freezed,
    Object? commonFlg = freezed,
    Object? modifiedDateTime = freezed,
    Object? timeStamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as int?,
      kinyuKyoinId: freezed == kinyuKyoinId
          ? _value.kinyuKyoinId
          : kinyuKyoinId // ignore: cast_nullable_to_non_nullable
              as int?,
      kinyuKyoinName: freezed == kinyuKyoinName
          ? _value.kinyuKyoinName
          : kinyuKyoinName // ignore: cast_nullable_to_non_nullable
              as String?,
      karuteSettingId: freezed == karuteSettingId
          ? _value.karuteSettingId
          : karuteSettingId // ignore: cast_nullable_to_non_nullable
              as int?,
      karuteShubetsuNaibuCode: freezed == karuteShubetsuNaibuCode
          ? _value.karuteShubetsuNaibuCode
          : karuteShubetsuNaibuCode // ignore: cast_nullable_to_non_nullable
              as String?,
      karuteBunruiCode: freezed == karuteBunruiCode
          ? _value.karuteBunruiCode
          : karuteBunruiCode // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      kizukiTemplate: freezed == kizukiTemplate
          ? _value.kizukiTemplate
          : kizukiTemplate // ignore: cast_nullable_to_non_nullable
              as String?,
      commonFlg: freezed == commonFlg
          ? _value.commonFlg
          : commonFlg // ignore: cast_nullable_to_non_nullable
              as bool?,
      modifiedDateTime: freezed == modifiedDateTime
          ? _value.modifiedDateTime
          : modifiedDateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      timeStamp: freezed == timeStamp
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KizukiTemplateModelImplCopyWith<$Res>
    implements $KizukiTemplateModelCopyWith<$Res> {
  factory _$$KizukiTemplateModelImplCopyWith(_$KizukiTemplateModelImpl value,
          $Res Function(_$KizukiTemplateModelImpl) then) =
      __$$KizukiTemplateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
      @JsonKey(name: 'TenantId', disallowNullValue: false)
      @HiveField(1)
      int? tenantId,
      @JsonKey(name: 'KinyuKyoinId', disallowNullValue: false)
      @HiveField(2)
      int? kinyuKyoinId,
      @JsonKey(name: 'KinyuKyoinName', disallowNullValue: false)
      @HiveField(3)
      String? kinyuKyoinName,
      @JsonKey(name: 'KaruteSettingId', disallowNullValue: false)
      @HiveField(4)
      int? karuteSettingId,
      @JsonKey(name: 'KaruteShubetsuNaibuCode', disallowNullValue: false)
      @HiveField(5)
      String? karuteShubetsuNaibuCode,
      @JsonKey(name: 'KaruteBunruiCode', disallowNullValue: false)
      @HiveField(6)
      String? karuteBunruiCode,
      @JsonKey(name: 'Title', disallowNullValue: false)
      @HiveField(7)
      String? title,
      @JsonKey(name: 'KizukiTemplate', disallowNullValue: false)
      @HiveField(8)
      String? kizukiTemplate,
      @JsonKey(name: 'CommonFlg', disallowNullValue: false)
      @HiveField(9)
      bool? commonFlg,
      @JsonKey(name: 'ModifiedDateTime', disallowNullValue: false)
      @HiveField(10)
      String? modifiedDateTime,
      @JsonKey(name: 'TIMESTAMP', disallowNullValue: false)
      @HiveField(11)
      String? timeStamp});
}

/// @nodoc
class __$$KizukiTemplateModelImplCopyWithImpl<$Res>
    extends _$KizukiTemplateModelCopyWithImpl<$Res, _$KizukiTemplateModelImpl>
    implements _$$KizukiTemplateModelImplCopyWith<$Res> {
  __$$KizukiTemplateModelImplCopyWithImpl(_$KizukiTemplateModelImpl _value,
      $Res Function(_$KizukiTemplateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? kinyuKyoinId = freezed,
    Object? kinyuKyoinName = freezed,
    Object? karuteSettingId = freezed,
    Object? karuteShubetsuNaibuCode = freezed,
    Object? karuteBunruiCode = freezed,
    Object? title = freezed,
    Object? kizukiTemplate = freezed,
    Object? commonFlg = freezed,
    Object? modifiedDateTime = freezed,
    Object? timeStamp = freezed,
  }) {
    return _then(_$KizukiTemplateModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as int?,
      kinyuKyoinId: freezed == kinyuKyoinId
          ? _value.kinyuKyoinId
          : kinyuKyoinId // ignore: cast_nullable_to_non_nullable
              as int?,
      kinyuKyoinName: freezed == kinyuKyoinName
          ? _value.kinyuKyoinName
          : kinyuKyoinName // ignore: cast_nullable_to_non_nullable
              as String?,
      karuteSettingId: freezed == karuteSettingId
          ? _value.karuteSettingId
          : karuteSettingId // ignore: cast_nullable_to_non_nullable
              as int?,
      karuteShubetsuNaibuCode: freezed == karuteShubetsuNaibuCode
          ? _value.karuteShubetsuNaibuCode
          : karuteShubetsuNaibuCode // ignore: cast_nullable_to_non_nullable
              as String?,
      karuteBunruiCode: freezed == karuteBunruiCode
          ? _value.karuteBunruiCode
          : karuteBunruiCode // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      kizukiTemplate: freezed == kizukiTemplate
          ? _value.kizukiTemplate
          : kizukiTemplate // ignore: cast_nullable_to_non_nullable
              as String?,
      commonFlg: freezed == commonFlg
          ? _value.commonFlg
          : commonFlg // ignore: cast_nullable_to_non_nullable
              as bool?,
      modifiedDateTime: freezed == modifiedDateTime
          ? _value.modifiedDateTime
          : modifiedDateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      timeStamp: freezed == timeStamp
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 49, adapterName: 'KizukiTemplateModelAdapter')
class _$KizukiTemplateModelImpl implements _KizukiTemplateModel {
  const _$KizukiTemplateModelImpl(
      {@JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) this.id,
      @JsonKey(name: 'TenantId', disallowNullValue: false)
      @HiveField(1)
      this.tenantId,
      @JsonKey(name: 'KinyuKyoinId', disallowNullValue: false)
      @HiveField(2)
      this.kinyuKyoinId,
      @JsonKey(name: 'KinyuKyoinName', disallowNullValue: false)
      @HiveField(3)
      this.kinyuKyoinName,
      @JsonKey(name: 'KaruteSettingId', disallowNullValue: false)
      @HiveField(4)
      this.karuteSettingId,
      @JsonKey(name: 'KaruteShubetsuNaibuCode', disallowNullValue: false)
      @HiveField(5)
      this.karuteShubetsuNaibuCode,
      @JsonKey(name: 'KaruteBunruiCode', disallowNullValue: false)
      @HiveField(6)
      this.karuteBunruiCode,
      @JsonKey(name: 'Title', disallowNullValue: false)
      @HiveField(7)
      this.title,
      @JsonKey(name: 'KizukiTemplate', disallowNullValue: false)
      @HiveField(8)
      this.kizukiTemplate,
      @JsonKey(name: 'CommonFlg', disallowNullValue: false)
      @HiveField(9)
      this.commonFlg,
      @JsonKey(name: 'ModifiedDateTime', disallowNullValue: false)
      @HiveField(10)
      this.modifiedDateTime,
      @JsonKey(name: 'TIMESTAMP', disallowNullValue: false)
      @HiveField(11)
      this.timeStamp});

  factory _$KizukiTemplateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$KizukiTemplateModelImplFromJson(json);

  @override
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(0)
  final int? id;
  @override
  @JsonKey(name: 'TenantId', disallowNullValue: false)
  @HiveField(1)
  final int? tenantId;
  @override
  @JsonKey(name: 'KinyuKyoinId', disallowNullValue: false)
  @HiveField(2)
  final int? kinyuKyoinId;
  @override
  @JsonKey(name: 'KinyuKyoinName', disallowNullValue: false)
  @HiveField(3)
  final String? kinyuKyoinName;
  @override
  @JsonKey(name: 'KaruteSettingId', disallowNullValue: false)
  @HiveField(4)
  final int? karuteSettingId;
  @override
  @JsonKey(name: 'KaruteShubetsuNaibuCode', disallowNullValue: false)
  @HiveField(5)
  final String? karuteShubetsuNaibuCode;
  @override
  @JsonKey(name: 'KaruteBunruiCode', disallowNullValue: false)
  @HiveField(6)
  final String? karuteBunruiCode;
  @override
  @JsonKey(name: 'Title', disallowNullValue: false)
  @HiveField(7)
  final String? title;
  @override
  @JsonKey(name: 'KizukiTemplate', disallowNullValue: false)
  @HiveField(8)
  final String? kizukiTemplate;
  @override
  @JsonKey(name: 'CommonFlg', disallowNullValue: false)
  @HiveField(9)
  final bool? commonFlg;
  @override
  @JsonKey(name: 'ModifiedDateTime', disallowNullValue: false)
  @HiveField(10)
  final String? modifiedDateTime;
  @override
  @JsonKey(name: 'TIMESTAMP', disallowNullValue: false)
  @HiveField(11)
  final String? timeStamp;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KizukiTemplateModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.kinyuKyoinId, kinyuKyoinId) ||
                other.kinyuKyoinId == kinyuKyoinId) &&
            (identical(other.kinyuKyoinName, kinyuKyoinName) ||
                other.kinyuKyoinName == kinyuKyoinName) &&
            (identical(other.karuteSettingId, karuteSettingId) ||
                other.karuteSettingId == karuteSettingId) &&
            (identical(
                    other.karuteShubetsuNaibuCode, karuteShubetsuNaibuCode) ||
                other.karuteShubetsuNaibuCode == karuteShubetsuNaibuCode) &&
            (identical(other.karuteBunruiCode, karuteBunruiCode) ||
                other.karuteBunruiCode == karuteBunruiCode) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.kizukiTemplate, kizukiTemplate) ||
                other.kizukiTemplate == kizukiTemplate) &&
            (identical(other.commonFlg, commonFlg) ||
                other.commonFlg == commonFlg) &&
            (identical(other.modifiedDateTime, modifiedDateTime) ||
                other.modifiedDateTime == modifiedDateTime) &&
            (identical(other.timeStamp, timeStamp) ||
                other.timeStamp == timeStamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tenantId,
      kinyuKyoinId,
      kinyuKyoinName,
      karuteSettingId,
      karuteShubetsuNaibuCode,
      karuteBunruiCode,
      title,
      kizukiTemplate,
      commonFlg,
      modifiedDateTime,
      timeStamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KizukiTemplateModelImplCopyWith<_$KizukiTemplateModelImpl> get copyWith =>
      __$$KizukiTemplateModelImplCopyWithImpl<_$KizukiTemplateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KizukiTemplateModelImplToJson(
      this,
    );
  }
}

abstract class _KizukiTemplateModel implements KizukiTemplateModel {
  const factory _KizukiTemplateModel(
      {@JsonKey(name: 'Id', disallowNullValue: false)
      @HiveField(0)
      final int? id,
      @JsonKey(name: 'TenantId', disallowNullValue: false)
      @HiveField(1)
      final int? tenantId,
      @JsonKey(name: 'KinyuKyoinId', disallowNullValue: false)
      @HiveField(2)
      final int? kinyuKyoinId,
      @JsonKey(name: 'KinyuKyoinName', disallowNullValue: false)
      @HiveField(3)
      final String? kinyuKyoinName,
      @JsonKey(name: 'KaruteSettingId', disallowNullValue: false)
      @HiveField(4)
      final int? karuteSettingId,
      @JsonKey(name: 'KaruteShubetsuNaibuCode', disallowNullValue: false)
      @HiveField(5)
      final String? karuteShubetsuNaibuCode,
      @JsonKey(name: 'KaruteBunruiCode', disallowNullValue: false)
      @HiveField(6)
      final String? karuteBunruiCode,
      @JsonKey(name: 'Title', disallowNullValue: false)
      @HiveField(7)
      final String? title,
      @JsonKey(name: 'KizukiTemplate', disallowNullValue: false)
      @HiveField(8)
      final String? kizukiTemplate,
      @JsonKey(name: 'CommonFlg', disallowNullValue: false)
      @HiveField(9)
      final bool? commonFlg,
      @JsonKey(name: 'ModifiedDateTime', disallowNullValue: false)
      @HiveField(10)
      final String? modifiedDateTime,
      @JsonKey(name: 'TIMESTAMP', disallowNullValue: false)
      @HiveField(11)
      final String? timeStamp}) = _$KizukiTemplateModelImpl;

  factory _KizukiTemplateModel.fromJson(Map<String, dynamic> json) =
      _$KizukiTemplateModelImpl.fromJson;

  @override
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(0)
  int? get id;
  @override
  @JsonKey(name: 'TenantId', disallowNullValue: false)
  @HiveField(1)
  int? get tenantId;
  @override
  @JsonKey(name: 'KinyuKyoinId', disallowNullValue: false)
  @HiveField(2)
  int? get kinyuKyoinId;
  @override
  @JsonKey(name: 'KinyuKyoinName', disallowNullValue: false)
  @HiveField(3)
  String? get kinyuKyoinName;
  @override
  @JsonKey(name: 'KaruteSettingId', disallowNullValue: false)
  @HiveField(4)
  int? get karuteSettingId;
  @override
  @JsonKey(name: 'KaruteShubetsuNaibuCode', disallowNullValue: false)
  @HiveField(5)
  String? get karuteShubetsuNaibuCode;
  @override
  @JsonKey(name: 'KaruteBunruiCode', disallowNullValue: false)
  @HiveField(6)
  String? get karuteBunruiCode;
  @override
  @JsonKey(name: 'Title', disallowNullValue: false)
  @HiveField(7)
  String? get title;
  @override
  @JsonKey(name: 'KizukiTemplate', disallowNullValue: false)
  @HiveField(8)
  String? get kizukiTemplate;
  @override
  @JsonKey(name: 'CommonFlg', disallowNullValue: false)
  @HiveField(9)
  bool? get commonFlg;
  @override
  @JsonKey(name: 'ModifiedDateTime', disallowNullValue: false)
  @HiveField(10)
  String? get modifiedDateTime;
  @override
  @JsonKey(name: 'TIMESTAMP', disallowNullValue: false)
  @HiveField(11)
  String? get timeStamp;
  @override
  @JsonKey(ignore: true)
  _$$KizukiTemplateModelImplCopyWith<_$KizukiTemplateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
