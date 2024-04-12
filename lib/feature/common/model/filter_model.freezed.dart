// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FilterModel _$FilterModelFromJson(Map<String, dynamic> json) {
  return _FilterModel.fromJson(json);
}

/// @nodoc
mixin _$FilterModel {
  @JsonKey(name: 'DantaiId', disallowNullValue: false)
  @HiveField(0)
  int? get dantaiId => throw _privateConstructorUsedError;
  @JsonKey(name: 'OrganizationKbn', disallowNullValue: false)
  @HiveField(1)
  String? get organizationKbn => throw _privateConstructorUsedError;
  @JsonKey(name: 'DantaiName', disallowNullValue: false)
  @HiveField(2)
  String? get dantaiName => throw _privateConstructorUsedError;
  @JsonKey(name: 'GakunenCode', disallowNullValue: false)
  @HiveField(3)
  String? get gakunenCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
  @HiveField(4)
  String? get gakunenRyakusho => throw _privateConstructorUsedError;
  @JsonKey(name: 'kouryuGakkyu', disallowNullValue: false)
  @HiveField(5)
  bool? get kouryuGakkyu => throw _privateConstructorUsedError;
  @JsonKey(name: 'ClassId', disallowNullValue: false)
  @HiveField(6)
  int? get classId => throw _privateConstructorUsedError;
  @JsonKey(name: 'ClassCode', disallowNullValue: false)
  @HiveField(7)
  String? get classCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'ClassName', disallowNullValue: false)
  @HiveField(8)
  String? get className => throw _privateConstructorUsedError;
  @JsonKey(name: 'TargetDate', disallowNullValue: false)
  @HiveField(9)
  DateTime? get targetDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'JapanDate', disallowNullValue: false)
  @HiveField(10)
  String? get japanDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'BeginDate', disallowNullValue: false)
  @HiveField(11)
  DateTime? get beginDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'EndDate', disallowNullValue: false)
  @HiveField(12)
  DateTime? get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'JigenIdx', disallowNullValue: false)
  @HiveField(13)
  int? get jigenIdx => throw _privateConstructorUsedError;
  @JsonKey(name: 'JigenRyaku', disallowNullValue: false)
  @HiveField(14)
  String? get jigenRyaku => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterModelCopyWith<FilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterModelCopyWith<$Res> {
  factory $FilterModelCopyWith(
          FilterModel value, $Res Function(FilterModel) then) =
      _$FilterModelCopyWithImpl<$Res, FilterModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'DantaiId', disallowNullValue: false)
      @HiveField(0)
      int? dantaiId,
      @JsonKey(name: 'OrganizationKbn', disallowNullValue: false)
      @HiveField(1)
      String? organizationKbn,
      @JsonKey(name: 'DantaiName', disallowNullValue: false)
      @HiveField(2)
      String? dantaiName,
      @JsonKey(name: 'GakunenCode', disallowNullValue: false)
      @HiveField(3)
      String? gakunenCode,
      @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
      @HiveField(4)
      String? gakunenRyakusho,
      @JsonKey(name: 'kouryuGakkyu', disallowNullValue: false)
      @HiveField(5)
      bool? kouryuGakkyu,
      @JsonKey(name: 'ClassId', disallowNullValue: false)
      @HiveField(6)
      int? classId,
      @JsonKey(name: 'ClassCode', disallowNullValue: false)
      @HiveField(7)
      String? classCode,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(8)
      String? className,
      @JsonKey(name: 'TargetDate', disallowNullValue: false)
      @HiveField(9)
      DateTime? targetDate,
      @JsonKey(name: 'JapanDate', disallowNullValue: false)
      @HiveField(10)
      String? japanDate,
      @JsonKey(name: 'BeginDate', disallowNullValue: false)
      @HiveField(11)
      DateTime? beginDate,
      @JsonKey(name: 'EndDate', disallowNullValue: false)
      @HiveField(12)
      DateTime? endDate,
      @JsonKey(name: 'JigenIdx', disallowNullValue: false)
      @HiveField(13)
      int? jigenIdx,
      @JsonKey(name: 'JigenRyaku', disallowNullValue: false)
      @HiveField(14)
      String? jigenRyaku});
}

/// @nodoc
class _$FilterModelCopyWithImpl<$Res, $Val extends FilterModel>
    implements $FilterModelCopyWith<$Res> {
  _$FilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dantaiId = freezed,
    Object? organizationKbn = freezed,
    Object? dantaiName = freezed,
    Object? gakunenCode = freezed,
    Object? gakunenRyakusho = freezed,
    Object? kouryuGakkyu = freezed,
    Object? classId = freezed,
    Object? classCode = freezed,
    Object? className = freezed,
    Object? targetDate = freezed,
    Object? japanDate = freezed,
    Object? beginDate = freezed,
    Object? endDate = freezed,
    Object? jigenIdx = freezed,
    Object? jigenRyaku = freezed,
  }) {
    return _then(_value.copyWith(
      dantaiId: freezed == dantaiId
          ? _value.dantaiId
          : dantaiId // ignore: cast_nullable_to_non_nullable
              as int?,
      organizationKbn: freezed == organizationKbn
          ? _value.organizationKbn
          : organizationKbn // ignore: cast_nullable_to_non_nullable
              as String?,
      dantaiName: freezed == dantaiName
          ? _value.dantaiName
          : dantaiName // ignore: cast_nullable_to_non_nullable
              as String?,
      gakunenCode: freezed == gakunenCode
          ? _value.gakunenCode
          : gakunenCode // ignore: cast_nullable_to_non_nullable
              as String?,
      gakunenRyakusho: freezed == gakunenRyakusho
          ? _value.gakunenRyakusho
          : gakunenRyakusho // ignore: cast_nullable_to_non_nullable
              as String?,
      kouryuGakkyu: freezed == kouryuGakkyu
          ? _value.kouryuGakkyu
          : kouryuGakkyu // ignore: cast_nullable_to_non_nullable
              as bool?,
      classId: freezed == classId
          ? _value.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as int?,
      classCode: freezed == classCode
          ? _value.classCode
          : classCode // ignore: cast_nullable_to_non_nullable
              as String?,
      className: freezed == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      targetDate: freezed == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      japanDate: freezed == japanDate
          ? _value.japanDate
          : japanDate // ignore: cast_nullable_to_non_nullable
              as String?,
      beginDate: freezed == beginDate
          ? _value.beginDate
          : beginDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      jigenIdx: freezed == jigenIdx
          ? _value.jigenIdx
          : jigenIdx // ignore: cast_nullable_to_non_nullable
              as int?,
      jigenRyaku: freezed == jigenRyaku
          ? _value.jigenRyaku
          : jigenRyaku // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilterModelImplCopyWith<$Res>
    implements $FilterModelCopyWith<$Res> {
  factory _$$FilterModelImplCopyWith(
          _$FilterModelImpl value, $Res Function(_$FilterModelImpl) then) =
      __$$FilterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'DantaiId', disallowNullValue: false)
      @HiveField(0)
      int? dantaiId,
      @JsonKey(name: 'OrganizationKbn', disallowNullValue: false)
      @HiveField(1)
      String? organizationKbn,
      @JsonKey(name: 'DantaiName', disallowNullValue: false)
      @HiveField(2)
      String? dantaiName,
      @JsonKey(name: 'GakunenCode', disallowNullValue: false)
      @HiveField(3)
      String? gakunenCode,
      @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
      @HiveField(4)
      String? gakunenRyakusho,
      @JsonKey(name: 'kouryuGakkyu', disallowNullValue: false)
      @HiveField(5)
      bool? kouryuGakkyu,
      @JsonKey(name: 'ClassId', disallowNullValue: false)
      @HiveField(6)
      int? classId,
      @JsonKey(name: 'ClassCode', disallowNullValue: false)
      @HiveField(7)
      String? classCode,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(8)
      String? className,
      @JsonKey(name: 'TargetDate', disallowNullValue: false)
      @HiveField(9)
      DateTime? targetDate,
      @JsonKey(name: 'JapanDate', disallowNullValue: false)
      @HiveField(10)
      String? japanDate,
      @JsonKey(name: 'BeginDate', disallowNullValue: false)
      @HiveField(11)
      DateTime? beginDate,
      @JsonKey(name: 'EndDate', disallowNullValue: false)
      @HiveField(12)
      DateTime? endDate,
      @JsonKey(name: 'JigenIdx', disallowNullValue: false)
      @HiveField(13)
      int? jigenIdx,
      @JsonKey(name: 'JigenRyaku', disallowNullValue: false)
      @HiveField(14)
      String? jigenRyaku});
}

/// @nodoc
class __$$FilterModelImplCopyWithImpl<$Res>
    extends _$FilterModelCopyWithImpl<$Res, _$FilterModelImpl>
    implements _$$FilterModelImplCopyWith<$Res> {
  __$$FilterModelImplCopyWithImpl(
      _$FilterModelImpl _value, $Res Function(_$FilterModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dantaiId = freezed,
    Object? organizationKbn = freezed,
    Object? dantaiName = freezed,
    Object? gakunenCode = freezed,
    Object? gakunenRyakusho = freezed,
    Object? kouryuGakkyu = freezed,
    Object? classId = freezed,
    Object? classCode = freezed,
    Object? className = freezed,
    Object? targetDate = freezed,
    Object? japanDate = freezed,
    Object? beginDate = freezed,
    Object? endDate = freezed,
    Object? jigenIdx = freezed,
    Object? jigenRyaku = freezed,
  }) {
    return _then(_$FilterModelImpl(
      dantaiId: freezed == dantaiId
          ? _value.dantaiId
          : dantaiId // ignore: cast_nullable_to_non_nullable
              as int?,
      organizationKbn: freezed == organizationKbn
          ? _value.organizationKbn
          : organizationKbn // ignore: cast_nullable_to_non_nullable
              as String?,
      dantaiName: freezed == dantaiName
          ? _value.dantaiName
          : dantaiName // ignore: cast_nullable_to_non_nullable
              as String?,
      gakunenCode: freezed == gakunenCode
          ? _value.gakunenCode
          : gakunenCode // ignore: cast_nullable_to_non_nullable
              as String?,
      gakunenRyakusho: freezed == gakunenRyakusho
          ? _value.gakunenRyakusho
          : gakunenRyakusho // ignore: cast_nullable_to_non_nullable
              as String?,
      kouryuGakkyu: freezed == kouryuGakkyu
          ? _value.kouryuGakkyu
          : kouryuGakkyu // ignore: cast_nullable_to_non_nullable
              as bool?,
      classId: freezed == classId
          ? _value.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as int?,
      classCode: freezed == classCode
          ? _value.classCode
          : classCode // ignore: cast_nullable_to_non_nullable
              as String?,
      className: freezed == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      targetDate: freezed == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      japanDate: freezed == japanDate
          ? _value.japanDate
          : japanDate // ignore: cast_nullable_to_non_nullable
              as String?,
      beginDate: freezed == beginDate
          ? _value.beginDate
          : beginDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      jigenIdx: freezed == jigenIdx
          ? _value.jigenIdx
          : jigenIdx // ignore: cast_nullable_to_non_nullable
              as int?,
      jigenRyaku: freezed == jigenRyaku
          ? _value.jigenRyaku
          : jigenRyaku // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 13, adapterName: 'FilterModelAdapter')
class _$FilterModelImpl implements _FilterModel {
  const _$FilterModelImpl(
      {@JsonKey(name: 'DantaiId', disallowNullValue: false)
      @HiveField(0)
      this.dantaiId,
      @JsonKey(name: 'OrganizationKbn', disallowNullValue: false)
      @HiveField(1)
      this.organizationKbn,
      @JsonKey(name: 'DantaiName', disallowNullValue: false)
      @HiveField(2)
      this.dantaiName,
      @JsonKey(name: 'GakunenCode', disallowNullValue: false)
      @HiveField(3)
      this.gakunenCode,
      @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
      @HiveField(4)
      this.gakunenRyakusho,
      @JsonKey(name: 'kouryuGakkyu', disallowNullValue: false)
      @HiveField(5)
      this.kouryuGakkyu,
      @JsonKey(name: 'ClassId', disallowNullValue: false)
      @HiveField(6)
      this.classId,
      @JsonKey(name: 'ClassCode', disallowNullValue: false)
      @HiveField(7)
      this.classCode,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(8)
      this.className,
      @JsonKey(name: 'TargetDate', disallowNullValue: false)
      @HiveField(9)
      this.targetDate,
      @JsonKey(name: 'JapanDate', disallowNullValue: false)
      @HiveField(10)
      this.japanDate,
      @JsonKey(name: 'BeginDate', disallowNullValue: false)
      @HiveField(11)
      this.beginDate,
      @JsonKey(name: 'EndDate', disallowNullValue: false)
      @HiveField(12)
      this.endDate,
      @JsonKey(name: 'JigenIdx', disallowNullValue: false)
      @HiveField(13)
      this.jigenIdx,
      @JsonKey(name: 'JigenRyaku', disallowNullValue: false)
      @HiveField(14)
      this.jigenRyaku});

  factory _$FilterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilterModelImplFromJson(json);

  @override
  @JsonKey(name: 'DantaiId', disallowNullValue: false)
  @HiveField(0)
  final int? dantaiId;
  @override
  @JsonKey(name: 'OrganizationKbn', disallowNullValue: false)
  @HiveField(1)
  final String? organizationKbn;
  @override
  @JsonKey(name: 'DantaiName', disallowNullValue: false)
  @HiveField(2)
  final String? dantaiName;
  @override
  @JsonKey(name: 'GakunenCode', disallowNullValue: false)
  @HiveField(3)
  final String? gakunenCode;
  @override
  @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
  @HiveField(4)
  final String? gakunenRyakusho;
  @override
  @JsonKey(name: 'kouryuGakkyu', disallowNullValue: false)
  @HiveField(5)
  final bool? kouryuGakkyu;
  @override
  @JsonKey(name: 'ClassId', disallowNullValue: false)
  @HiveField(6)
  final int? classId;
  @override
  @JsonKey(name: 'ClassCode', disallowNullValue: false)
  @HiveField(7)
  final String? classCode;
  @override
  @JsonKey(name: 'ClassName', disallowNullValue: false)
  @HiveField(8)
  final String? className;
  @override
  @JsonKey(name: 'TargetDate', disallowNullValue: false)
  @HiveField(9)
  final DateTime? targetDate;
  @override
  @JsonKey(name: 'JapanDate', disallowNullValue: false)
  @HiveField(10)
  final String? japanDate;
  @override
  @JsonKey(name: 'BeginDate', disallowNullValue: false)
  @HiveField(11)
  final DateTime? beginDate;
  @override
  @JsonKey(name: 'EndDate', disallowNullValue: false)
  @HiveField(12)
  final DateTime? endDate;
  @override
  @JsonKey(name: 'JigenIdx', disallowNullValue: false)
  @HiveField(13)
  final int? jigenIdx;
  @override
  @JsonKey(name: 'JigenRyaku', disallowNullValue: false)
  @HiveField(14)
  final String? jigenRyaku;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterModelImpl &&
            (identical(other.dantaiId, dantaiId) ||
                other.dantaiId == dantaiId) &&
            (identical(other.organizationKbn, organizationKbn) ||
                other.organizationKbn == organizationKbn) &&
            (identical(other.dantaiName, dantaiName) ||
                other.dantaiName == dantaiName) &&
            (identical(other.gakunenCode, gakunenCode) ||
                other.gakunenCode == gakunenCode) &&
            (identical(other.gakunenRyakusho, gakunenRyakusho) ||
                other.gakunenRyakusho == gakunenRyakusho) &&
            (identical(other.kouryuGakkyu, kouryuGakkyu) ||
                other.kouryuGakkyu == kouryuGakkyu) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.classCode, classCode) ||
                other.classCode == classCode) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.japanDate, japanDate) ||
                other.japanDate == japanDate) &&
            (identical(other.beginDate, beginDate) ||
                other.beginDate == beginDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.jigenIdx, jigenIdx) ||
                other.jigenIdx == jigenIdx) &&
            (identical(other.jigenRyaku, jigenRyaku) ||
                other.jigenRyaku == jigenRyaku));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      dantaiId,
      organizationKbn,
      dantaiName,
      gakunenCode,
      gakunenRyakusho,
      kouryuGakkyu,
      classId,
      classCode,
      className,
      targetDate,
      japanDate,
      beginDate,
      endDate,
      jigenIdx,
      jigenRyaku);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterModelImplCopyWith<_$FilterModelImpl> get copyWith =>
      __$$FilterModelImplCopyWithImpl<_$FilterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterModelImplToJson(
      this,
    );
  }
}

abstract class _FilterModel implements FilterModel {
  const factory _FilterModel(
      {@JsonKey(name: 'DantaiId', disallowNullValue: false)
      @HiveField(0)
      final int? dantaiId,
      @JsonKey(name: 'OrganizationKbn', disallowNullValue: false)
      @HiveField(1)
      final String? organizationKbn,
      @JsonKey(name: 'DantaiName', disallowNullValue: false)
      @HiveField(2)
      final String? dantaiName,
      @JsonKey(name: 'GakunenCode', disallowNullValue: false)
      @HiveField(3)
      final String? gakunenCode,
      @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
      @HiveField(4)
      final String? gakunenRyakusho,
      @JsonKey(name: 'kouryuGakkyu', disallowNullValue: false)
      @HiveField(5)
      final bool? kouryuGakkyu,
      @JsonKey(name: 'ClassId', disallowNullValue: false)
      @HiveField(6)
      final int? classId,
      @JsonKey(name: 'ClassCode', disallowNullValue: false)
      @HiveField(7)
      final String? classCode,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(8)
      final String? className,
      @JsonKey(name: 'TargetDate', disallowNullValue: false)
      @HiveField(9)
      final DateTime? targetDate,
      @JsonKey(name: 'JapanDate', disallowNullValue: false)
      @HiveField(10)
      final String? japanDate,
      @JsonKey(name: 'BeginDate', disallowNullValue: false)
      @HiveField(11)
      final DateTime? beginDate,
      @JsonKey(name: 'EndDate', disallowNullValue: false)
      @HiveField(12)
      final DateTime? endDate,
      @JsonKey(name: 'JigenIdx', disallowNullValue: false)
      @HiveField(13)
      final int? jigenIdx,
      @JsonKey(name: 'JigenRyaku', disallowNullValue: false)
      @HiveField(14)
      final String? jigenRyaku}) = _$FilterModelImpl;

  factory _FilterModel.fromJson(Map<String, dynamic> json) =
      _$FilterModelImpl.fromJson;

  @override
  @JsonKey(name: 'DantaiId', disallowNullValue: false)
  @HiveField(0)
  int? get dantaiId;
  @override
  @JsonKey(name: 'OrganizationKbn', disallowNullValue: false)
  @HiveField(1)
  String? get organizationKbn;
  @override
  @JsonKey(name: 'DantaiName', disallowNullValue: false)
  @HiveField(2)
  String? get dantaiName;
  @override
  @JsonKey(name: 'GakunenCode', disallowNullValue: false)
  @HiveField(3)
  String? get gakunenCode;
  @override
  @JsonKey(name: 'GakunenRyakusho', disallowNullValue: false)
  @HiveField(4)
  String? get gakunenRyakusho;
  @override
  @JsonKey(name: 'kouryuGakkyu', disallowNullValue: false)
  @HiveField(5)
  bool? get kouryuGakkyu;
  @override
  @JsonKey(name: 'ClassId', disallowNullValue: false)
  @HiveField(6)
  int? get classId;
  @override
  @JsonKey(name: 'ClassCode', disallowNullValue: false)
  @HiveField(7)
  String? get classCode;
  @override
  @JsonKey(name: 'ClassName', disallowNullValue: false)
  @HiveField(8)
  String? get className;
  @override
  @JsonKey(name: 'TargetDate', disallowNullValue: false)
  @HiveField(9)
  DateTime? get targetDate;
  @override
  @JsonKey(name: 'JapanDate', disallowNullValue: false)
  @HiveField(10)
  String? get japanDate;
  @override
  @JsonKey(name: 'BeginDate', disallowNullValue: false)
  @HiveField(11)
  DateTime? get beginDate;
  @override
  @JsonKey(name: 'EndDate', disallowNullValue: false)
  @HiveField(12)
  DateTime? get endDate;
  @override
  @JsonKey(name: 'JigenIdx', disallowNullValue: false)
  @HiveField(13)
  int? get jigenIdx;
  @override
  @JsonKey(name: 'JigenRyaku', disallowNullValue: false)
  @HiveField(14)
  String? get jigenRyaku;
  @override
  @JsonKey(ignore: true)
  _$$FilterModelImplCopyWith<_$FilterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
