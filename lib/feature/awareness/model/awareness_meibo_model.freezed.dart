// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'awareness_meibo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AwarenessMeiboModel _$AwarenessMeiboModelFromJson(Map<String, dynamic> json) {
  return _AwarenessMeiboModel.fromJson(json);
}

/// @nodoc
mixin _$AwarenessMeiboModel {
  @JsonKey(name: 'Gakunen', disallowNullValue: false)
  @HiveField(0)
  String? get gakunen => throw _privateConstructorUsedError;
  @JsonKey(name: 'ShozokuId', disallowNullValue: false)
  @HiveField(1)
  int? get shozokuId => throw _privateConstructorUsedError;
  @JsonKey(name: 'ClassName', disallowNullValue: false)
  @HiveField(2)
  String? get className => throw _privateConstructorUsedError;
  @JsonKey(name: 'ShussekiNo', disallowNullValue: false)
  @HiveField(3)
  String? get shussekiNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'StudentKihonId', disallowNullValue: false)
  @HiveField(4)
  int? get studentKihonId => throw _privateConstructorUsedError;
  @JsonKey(name: 'StudentId', disallowNullValue: false)
  @HiveField(5)
  int? get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'StudentName', disallowNullValue: false)
  @HiveField(6)
  String? get studentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
  @HiveField(7)
  String? get photoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'GenderCode', disallowNullValue: false)
  @HiveField(8)
  String? get genderCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'KizukiCount', disallowNullValue: false)
  @HiveField(9)
  int? get kizukiCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'SelectFlag', disallowNullValue: false)
  @HiveField(10)
  bool? get selectFlag => throw _privateConstructorUsedError;
  @JsonKey(name: 'ChangedFlag', disallowNullValue: false)
  @HiveField(11)
  bool? get changedFlag => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AwarenessMeiboModelCopyWith<AwarenessMeiboModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AwarenessMeiboModelCopyWith<$Res> {
  factory $AwarenessMeiboModelCopyWith(
          AwarenessMeiboModel value, $Res Function(AwarenessMeiboModel) then) =
      _$AwarenessMeiboModelCopyWithImpl<$Res, AwarenessMeiboModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Gakunen', disallowNullValue: false)
      @HiveField(0)
      String? gakunen,
      @JsonKey(name: 'ShozokuId', disallowNullValue: false)
      @HiveField(1)
      int? shozokuId,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(2)
      String? className,
      @JsonKey(name: 'ShussekiNo', disallowNullValue: false)
      @HiveField(3)
      String? shussekiNo,
      @JsonKey(name: 'StudentKihonId', disallowNullValue: false)
      @HiveField(4)
      int? studentKihonId,
      @JsonKey(name: 'StudentId', disallowNullValue: false)
      @HiveField(5)
      int? studentId,
      @JsonKey(name: 'StudentName', disallowNullValue: false)
      @HiveField(6)
      String? studentName,
      @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
      @HiveField(7)
      String? photoUrl,
      @JsonKey(name: 'GenderCode', disallowNullValue: false)
      @HiveField(8)
      String? genderCode,
      @JsonKey(name: 'KizukiCount', disallowNullValue: false)
      @HiveField(9)
      int? kizukiCount,
      @JsonKey(name: 'SelectFlag', disallowNullValue: false)
      @HiveField(10)
      bool? selectFlag,
      @JsonKey(name: 'ChangedFlag', disallowNullValue: false)
      @HiveField(11)
      bool? changedFlag});
}

/// @nodoc
class _$AwarenessMeiboModelCopyWithImpl<$Res, $Val extends AwarenessMeiboModel>
    implements $AwarenessMeiboModelCopyWith<$Res> {
  _$AwarenessMeiboModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gakunen = freezed,
    Object? shozokuId = freezed,
    Object? className = freezed,
    Object? shussekiNo = freezed,
    Object? studentKihonId = freezed,
    Object? studentId = freezed,
    Object? studentName = freezed,
    Object? photoUrl = freezed,
    Object? genderCode = freezed,
    Object? kizukiCount = freezed,
    Object? selectFlag = freezed,
    Object? changedFlag = freezed,
  }) {
    return _then(_value.copyWith(
      gakunen: freezed == gakunen
          ? _value.gakunen
          : gakunen // ignore: cast_nullable_to_non_nullable
              as String?,
      shozokuId: freezed == shozokuId
          ? _value.shozokuId
          : shozokuId // ignore: cast_nullable_to_non_nullable
              as int?,
      className: freezed == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      shussekiNo: freezed == shussekiNo
          ? _value.shussekiNo
          : shussekiNo // ignore: cast_nullable_to_non_nullable
              as String?,
      studentKihonId: freezed == studentKihonId
          ? _value.studentKihonId
          : studentKihonId // ignore: cast_nullable_to_non_nullable
              as int?,
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as int?,
      studentName: freezed == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      genderCode: freezed == genderCode
          ? _value.genderCode
          : genderCode // ignore: cast_nullable_to_non_nullable
              as String?,
      kizukiCount: freezed == kizukiCount
          ? _value.kizukiCount
          : kizukiCount // ignore: cast_nullable_to_non_nullable
              as int?,
      selectFlag: freezed == selectFlag
          ? _value.selectFlag
          : selectFlag // ignore: cast_nullable_to_non_nullable
              as bool?,
      changedFlag: freezed == changedFlag
          ? _value.changedFlag
          : changedFlag // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AwarenessMeiboModelImplCopyWith<$Res>
    implements $AwarenessMeiboModelCopyWith<$Res> {
  factory _$$AwarenessMeiboModelImplCopyWith(_$AwarenessMeiboModelImpl value,
          $Res Function(_$AwarenessMeiboModelImpl) then) =
      __$$AwarenessMeiboModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Gakunen', disallowNullValue: false)
      @HiveField(0)
      String? gakunen,
      @JsonKey(name: 'ShozokuId', disallowNullValue: false)
      @HiveField(1)
      int? shozokuId,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(2)
      String? className,
      @JsonKey(name: 'ShussekiNo', disallowNullValue: false)
      @HiveField(3)
      String? shussekiNo,
      @JsonKey(name: 'StudentKihonId', disallowNullValue: false)
      @HiveField(4)
      int? studentKihonId,
      @JsonKey(name: 'StudentId', disallowNullValue: false)
      @HiveField(5)
      int? studentId,
      @JsonKey(name: 'StudentName', disallowNullValue: false)
      @HiveField(6)
      String? studentName,
      @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
      @HiveField(7)
      String? photoUrl,
      @JsonKey(name: 'GenderCode', disallowNullValue: false)
      @HiveField(8)
      String? genderCode,
      @JsonKey(name: 'KizukiCount', disallowNullValue: false)
      @HiveField(9)
      int? kizukiCount,
      @JsonKey(name: 'SelectFlag', disallowNullValue: false)
      @HiveField(10)
      bool? selectFlag,
      @JsonKey(name: 'ChangedFlag', disallowNullValue: false)
      @HiveField(11)
      bool? changedFlag});
}

/// @nodoc
class __$$AwarenessMeiboModelImplCopyWithImpl<$Res>
    extends _$AwarenessMeiboModelCopyWithImpl<$Res, _$AwarenessMeiboModelImpl>
    implements _$$AwarenessMeiboModelImplCopyWith<$Res> {
  __$$AwarenessMeiboModelImplCopyWithImpl(_$AwarenessMeiboModelImpl _value,
      $Res Function(_$AwarenessMeiboModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gakunen = freezed,
    Object? shozokuId = freezed,
    Object? className = freezed,
    Object? shussekiNo = freezed,
    Object? studentKihonId = freezed,
    Object? studentId = freezed,
    Object? studentName = freezed,
    Object? photoUrl = freezed,
    Object? genderCode = freezed,
    Object? kizukiCount = freezed,
    Object? selectFlag = freezed,
    Object? changedFlag = freezed,
  }) {
    return _then(_$AwarenessMeiboModelImpl(
      gakunen: freezed == gakunen
          ? _value.gakunen
          : gakunen // ignore: cast_nullable_to_non_nullable
              as String?,
      shozokuId: freezed == shozokuId
          ? _value.shozokuId
          : shozokuId // ignore: cast_nullable_to_non_nullable
              as int?,
      className: freezed == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      shussekiNo: freezed == shussekiNo
          ? _value.shussekiNo
          : shussekiNo // ignore: cast_nullable_to_non_nullable
              as String?,
      studentKihonId: freezed == studentKihonId
          ? _value.studentKihonId
          : studentKihonId // ignore: cast_nullable_to_non_nullable
              as int?,
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as int?,
      studentName: freezed == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      genderCode: freezed == genderCode
          ? _value.genderCode
          : genderCode // ignore: cast_nullable_to_non_nullable
              as String?,
      kizukiCount: freezed == kizukiCount
          ? _value.kizukiCount
          : kizukiCount // ignore: cast_nullable_to_non_nullable
              as int?,
      selectFlag: freezed == selectFlag
          ? _value.selectFlag
          : selectFlag // ignore: cast_nullable_to_non_nullable
              as bool?,
      changedFlag: freezed == changedFlag
          ? _value.changedFlag
          : changedFlag // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 34, adapterName: 'AwarenessMeiboModelAdapter')
class _$AwarenessMeiboModelImpl implements _AwarenessMeiboModel {
  const _$AwarenessMeiboModelImpl(
      {@JsonKey(name: 'Gakunen', disallowNullValue: false)
      @HiveField(0)
      this.gakunen,
      @JsonKey(name: 'ShozokuId', disallowNullValue: false)
      @HiveField(1)
      this.shozokuId,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(2)
      this.className,
      @JsonKey(name: 'ShussekiNo', disallowNullValue: false)
      @HiveField(3)
      this.shussekiNo,
      @JsonKey(name: 'StudentKihonId', disallowNullValue: false)
      @HiveField(4)
      this.studentKihonId,
      @JsonKey(name: 'StudentId', disallowNullValue: false)
      @HiveField(5)
      this.studentId,
      @JsonKey(name: 'StudentName', disallowNullValue: false)
      @HiveField(6)
      this.studentName,
      @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
      @HiveField(7)
      this.photoUrl,
      @JsonKey(name: 'GenderCode', disallowNullValue: false)
      @HiveField(8)
      this.genderCode,
      @JsonKey(name: 'KizukiCount', disallowNullValue: false)
      @HiveField(9)
      this.kizukiCount,
      @JsonKey(name: 'SelectFlag', disallowNullValue: false)
      @HiveField(10)
      this.selectFlag,
      @JsonKey(name: 'ChangedFlag', disallowNullValue: false)
      @HiveField(11)
      this.changedFlag});

  factory _$AwarenessMeiboModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AwarenessMeiboModelImplFromJson(json);

  @override
  @JsonKey(name: 'Gakunen', disallowNullValue: false)
  @HiveField(0)
  final String? gakunen;
  @override
  @JsonKey(name: 'ShozokuId', disallowNullValue: false)
  @HiveField(1)
  final int? shozokuId;
  @override
  @JsonKey(name: 'ClassName', disallowNullValue: false)
  @HiveField(2)
  final String? className;
  @override
  @JsonKey(name: 'ShussekiNo', disallowNullValue: false)
  @HiveField(3)
  final String? shussekiNo;
  @override
  @JsonKey(name: 'StudentKihonId', disallowNullValue: false)
  @HiveField(4)
  final int? studentKihonId;
  @override
  @JsonKey(name: 'StudentId', disallowNullValue: false)
  @HiveField(5)
  final int? studentId;
  @override
  @JsonKey(name: 'StudentName', disallowNullValue: false)
  @HiveField(6)
  final String? studentName;
  @override
  @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
  @HiveField(7)
  final String? photoUrl;
  @override
  @JsonKey(name: 'GenderCode', disallowNullValue: false)
  @HiveField(8)
  final String? genderCode;
  @override
  @JsonKey(name: 'KizukiCount', disallowNullValue: false)
  @HiveField(9)
  final int? kizukiCount;
  @override
  @JsonKey(name: 'SelectFlag', disallowNullValue: false)
  @HiveField(10)
  final bool? selectFlag;
  @override
  @JsonKey(name: 'ChangedFlag', disallowNullValue: false)
  @HiveField(11)
  final bool? changedFlag;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AwarenessMeiboModelImpl &&
            (identical(other.gakunen, gakunen) || other.gakunen == gakunen) &&
            (identical(other.shozokuId, shozokuId) ||
                other.shozokuId == shozokuId) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.shussekiNo, shussekiNo) ||
                other.shussekiNo == shussekiNo) &&
            (identical(other.studentKihonId, studentKihonId) ||
                other.studentKihonId == studentKihonId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.genderCode, genderCode) ||
                other.genderCode == genderCode) &&
            (identical(other.kizukiCount, kizukiCount) ||
                other.kizukiCount == kizukiCount) &&
            (identical(other.selectFlag, selectFlag) ||
                other.selectFlag == selectFlag) &&
            (identical(other.changedFlag, changedFlag) ||
                other.changedFlag == changedFlag));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      gakunen,
      shozokuId,
      className,
      shussekiNo,
      studentKihonId,
      studentId,
      studentName,
      photoUrl,
      genderCode,
      kizukiCount,
      selectFlag,
      changedFlag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AwarenessMeiboModelImplCopyWith<_$AwarenessMeiboModelImpl> get copyWith =>
      __$$AwarenessMeiboModelImplCopyWithImpl<_$AwarenessMeiboModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AwarenessMeiboModelImplToJson(
      this,
    );
  }
}

abstract class _AwarenessMeiboModel implements AwarenessMeiboModel {
  const factory _AwarenessMeiboModel(
      {@JsonKey(name: 'Gakunen', disallowNullValue: false)
      @HiveField(0)
      final String? gakunen,
      @JsonKey(name: 'ShozokuId', disallowNullValue: false)
      @HiveField(1)
      final int? shozokuId,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(2)
      final String? className,
      @JsonKey(name: 'ShussekiNo', disallowNullValue: false)
      @HiveField(3)
      final String? shussekiNo,
      @JsonKey(name: 'StudentKihonId', disallowNullValue: false)
      @HiveField(4)
      final int? studentKihonId,
      @JsonKey(name: 'StudentId', disallowNullValue: false)
      @HiveField(5)
      final int? studentId,
      @JsonKey(name: 'StudentName', disallowNullValue: false)
      @HiveField(6)
      final String? studentName,
      @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
      @HiveField(7)
      final String? photoUrl,
      @JsonKey(name: 'GenderCode', disallowNullValue: false)
      @HiveField(8)
      final String? genderCode,
      @JsonKey(name: 'KizukiCount', disallowNullValue: false)
      @HiveField(9)
      final int? kizukiCount,
      @JsonKey(name: 'SelectFlag', disallowNullValue: false)
      @HiveField(10)
      final bool? selectFlag,
      @JsonKey(name: 'ChangedFlag', disallowNullValue: false)
      @HiveField(11)
      final bool? changedFlag}) = _$AwarenessMeiboModelImpl;

  factory _AwarenessMeiboModel.fromJson(Map<String, dynamic> json) =
      _$AwarenessMeiboModelImpl.fromJson;

  @override
  @JsonKey(name: 'Gakunen', disallowNullValue: false)
  @HiveField(0)
  String? get gakunen;
  @override
  @JsonKey(name: 'ShozokuId', disallowNullValue: false)
  @HiveField(1)
  int? get shozokuId;
  @override
  @JsonKey(name: 'ClassName', disallowNullValue: false)
  @HiveField(2)
  String? get className;
  @override
  @JsonKey(name: 'ShussekiNo', disallowNullValue: false)
  @HiveField(3)
  String? get shussekiNo;
  @override
  @JsonKey(name: 'StudentKihonId', disallowNullValue: false)
  @HiveField(4)
  int? get studentKihonId;
  @override
  @JsonKey(name: 'StudentId', disallowNullValue: false)
  @HiveField(5)
  int? get studentId;
  @override
  @JsonKey(name: 'StudentName', disallowNullValue: false)
  @HiveField(6)
  String? get studentName;
  @override
  @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
  @HiveField(7)
  String? get photoUrl;
  @override
  @JsonKey(name: 'GenderCode', disallowNullValue: false)
  @HiveField(8)
  String? get genderCode;
  @override
  @JsonKey(name: 'KizukiCount', disallowNullValue: false)
  @HiveField(9)
  int? get kizukiCount;
  @override
  @JsonKey(name: 'SelectFlag', disallowNullValue: false)
  @HiveField(10)
  bool? get selectFlag;
  @override
  @JsonKey(name: 'ChangedFlag', disallowNullValue: false)
  @HiveField(11)
  bool? get changedFlag;
  @override
  @JsonKey(ignore: true)
  _$$AwarenessMeiboModelImplCopyWith<_$AwarenessMeiboModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
