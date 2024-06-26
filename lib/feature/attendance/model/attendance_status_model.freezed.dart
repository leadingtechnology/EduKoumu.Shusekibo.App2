// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceStatusModel _$AttendanceStatusModelFromJson(
    Map<String, dynamic> json) {
  return _AttendanceStatusModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceStatusModel {
  @JsonKey(name: 'Date', disallowNullValue: false)
  @HiveField(0)
  DateTime? get jokyoDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'JigenIdx', disallowNullValue: false)
  @HiveField(1)
  int? get jigenIdx => throw _privateConstructorUsedError;
  @JsonKey(name: 'Ryaku', disallowNullValue: false)
  @HiveField(2)
  String? get ryaku => throw _privateConstructorUsedError;
  @JsonKey(name: 'ShukketsuBunrui', disallowNullValue: false)
  @HiveField(3)
  String? get shukketsuBunrui => throw _privateConstructorUsedError;
  @JsonKey(name: 'ShukketsuKbn', disallowNullValue: false)
  @HiveField(4)
  String? get shukketsuKbn => throw _privateConstructorUsedError;
  @JsonKey(name: 'Jiyu1', disallowNullValue: false)
  @HiveField(5)
  String? get jiyu1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'Jiyu2', disallowNullValue: false)
  @HiveField(6)
  String? get jiyu2 => throw _privateConstructorUsedError;
  @JsonKey(name: 'IsEditable', disallowNullValue: false)
  @HiveField(7)
  bool? get isEditable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceStatusModelCopyWith<AttendanceStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceStatusModelCopyWith<$Res> {
  factory $AttendanceStatusModelCopyWith(AttendanceStatusModel value,
          $Res Function(AttendanceStatusModel) then) =
      _$AttendanceStatusModelCopyWithImpl<$Res, AttendanceStatusModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Date', disallowNullValue: false)
      @HiveField(0)
      DateTime? jokyoDate,
      @JsonKey(name: 'JigenIdx', disallowNullValue: false)
      @HiveField(1)
      int? jigenIdx,
      @JsonKey(name: 'Ryaku', disallowNullValue: false)
      @HiveField(2)
      String? ryaku,
      @JsonKey(name: 'ShukketsuBunrui', disallowNullValue: false)
      @HiveField(3)
      String? shukketsuBunrui,
      @JsonKey(name: 'ShukketsuKbn', disallowNullValue: false)
      @HiveField(4)
      String? shukketsuKbn,
      @JsonKey(name: 'Jiyu1', disallowNullValue: false)
      @HiveField(5)
      String? jiyu1,
      @JsonKey(name: 'Jiyu2', disallowNullValue: false)
      @HiveField(6)
      String? jiyu2,
      @JsonKey(name: 'IsEditable', disallowNullValue: false)
      @HiveField(7)
      bool? isEditable});
}

/// @nodoc
class _$AttendanceStatusModelCopyWithImpl<$Res,
        $Val extends AttendanceStatusModel>
    implements $AttendanceStatusModelCopyWith<$Res> {
  _$AttendanceStatusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jokyoDate = freezed,
    Object? jigenIdx = freezed,
    Object? ryaku = freezed,
    Object? shukketsuBunrui = freezed,
    Object? shukketsuKbn = freezed,
    Object? jiyu1 = freezed,
    Object? jiyu2 = freezed,
    Object? isEditable = freezed,
  }) {
    return _then(_value.copyWith(
      jokyoDate: freezed == jokyoDate
          ? _value.jokyoDate
          : jokyoDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      jigenIdx: freezed == jigenIdx
          ? _value.jigenIdx
          : jigenIdx // ignore: cast_nullable_to_non_nullable
              as int?,
      ryaku: freezed == ryaku
          ? _value.ryaku
          : ryaku // ignore: cast_nullable_to_non_nullable
              as String?,
      shukketsuBunrui: freezed == shukketsuBunrui
          ? _value.shukketsuBunrui
          : shukketsuBunrui // ignore: cast_nullable_to_non_nullable
              as String?,
      shukketsuKbn: freezed == shukketsuKbn
          ? _value.shukketsuKbn
          : shukketsuKbn // ignore: cast_nullable_to_non_nullable
              as String?,
      jiyu1: freezed == jiyu1
          ? _value.jiyu1
          : jiyu1 // ignore: cast_nullable_to_non_nullable
              as String?,
      jiyu2: freezed == jiyu2
          ? _value.jiyu2
          : jiyu2 // ignore: cast_nullable_to_non_nullable
              as String?,
      isEditable: freezed == isEditable
          ? _value.isEditable
          : isEditable // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceStatusModelImplCopyWith<$Res>
    implements $AttendanceStatusModelCopyWith<$Res> {
  factory _$$AttendanceStatusModelImplCopyWith(
          _$AttendanceStatusModelImpl value,
          $Res Function(_$AttendanceStatusModelImpl) then) =
      __$$AttendanceStatusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Date', disallowNullValue: false)
      @HiveField(0)
      DateTime? jokyoDate,
      @JsonKey(name: 'JigenIdx', disallowNullValue: false)
      @HiveField(1)
      int? jigenIdx,
      @JsonKey(name: 'Ryaku', disallowNullValue: false)
      @HiveField(2)
      String? ryaku,
      @JsonKey(name: 'ShukketsuBunrui', disallowNullValue: false)
      @HiveField(3)
      String? shukketsuBunrui,
      @JsonKey(name: 'ShukketsuKbn', disallowNullValue: false)
      @HiveField(4)
      String? shukketsuKbn,
      @JsonKey(name: 'Jiyu1', disallowNullValue: false)
      @HiveField(5)
      String? jiyu1,
      @JsonKey(name: 'Jiyu2', disallowNullValue: false)
      @HiveField(6)
      String? jiyu2,
      @JsonKey(name: 'IsEditable', disallowNullValue: false)
      @HiveField(7)
      bool? isEditable});
}

/// @nodoc
class __$$AttendanceStatusModelImplCopyWithImpl<$Res>
    extends _$AttendanceStatusModelCopyWithImpl<$Res,
        _$AttendanceStatusModelImpl>
    implements _$$AttendanceStatusModelImplCopyWith<$Res> {
  __$$AttendanceStatusModelImplCopyWithImpl(_$AttendanceStatusModelImpl _value,
      $Res Function(_$AttendanceStatusModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jokyoDate = freezed,
    Object? jigenIdx = freezed,
    Object? ryaku = freezed,
    Object? shukketsuBunrui = freezed,
    Object? shukketsuKbn = freezed,
    Object? jiyu1 = freezed,
    Object? jiyu2 = freezed,
    Object? isEditable = freezed,
  }) {
    return _then(_$AttendanceStatusModelImpl(
      jokyoDate: freezed == jokyoDate
          ? _value.jokyoDate
          : jokyoDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      jigenIdx: freezed == jigenIdx
          ? _value.jigenIdx
          : jigenIdx // ignore: cast_nullable_to_non_nullable
              as int?,
      ryaku: freezed == ryaku
          ? _value.ryaku
          : ryaku // ignore: cast_nullable_to_non_nullable
              as String?,
      shukketsuBunrui: freezed == shukketsuBunrui
          ? _value.shukketsuBunrui
          : shukketsuBunrui // ignore: cast_nullable_to_non_nullable
              as String?,
      shukketsuKbn: freezed == shukketsuKbn
          ? _value.shukketsuKbn
          : shukketsuKbn // ignore: cast_nullable_to_non_nullable
              as String?,
      jiyu1: freezed == jiyu1
          ? _value.jiyu1
          : jiyu1 // ignore: cast_nullable_to_non_nullable
              as String?,
      jiyu2: freezed == jiyu2
          ? _value.jiyu2
          : jiyu2 // ignore: cast_nullable_to_non_nullable
              as String?,
      isEditable: freezed == isEditable
          ? _value.isEditable
          : isEditable // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 17, adapterName: 'AttendanceStatusModelAdapter')
class _$AttendanceStatusModelImpl implements _AttendanceStatusModel {
  const _$AttendanceStatusModelImpl(
      {@JsonKey(name: 'Date', disallowNullValue: false)
      @HiveField(0)
      this.jokyoDate,
      @JsonKey(name: 'JigenIdx', disallowNullValue: false)
      @HiveField(1)
      this.jigenIdx,
      @JsonKey(name: 'Ryaku', disallowNullValue: false)
      @HiveField(2)
      this.ryaku,
      @JsonKey(name: 'ShukketsuBunrui', disallowNullValue: false)
      @HiveField(3)
      this.shukketsuBunrui,
      @JsonKey(name: 'ShukketsuKbn', disallowNullValue: false)
      @HiveField(4)
      this.shukketsuKbn,
      @JsonKey(name: 'Jiyu1', disallowNullValue: false)
      @HiveField(5)
      this.jiyu1,
      @JsonKey(name: 'Jiyu2', disallowNullValue: false)
      @HiveField(6)
      this.jiyu2,
      @JsonKey(name: 'IsEditable', disallowNullValue: false)
      @HiveField(7)
      this.isEditable});

  factory _$AttendanceStatusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceStatusModelImplFromJson(json);

  @override
  @JsonKey(name: 'Date', disallowNullValue: false)
  @HiveField(0)
  final DateTime? jokyoDate;
  @override
  @JsonKey(name: 'JigenIdx', disallowNullValue: false)
  @HiveField(1)
  final int? jigenIdx;
  @override
  @JsonKey(name: 'Ryaku', disallowNullValue: false)
  @HiveField(2)
  final String? ryaku;
  @override
  @JsonKey(name: 'ShukketsuBunrui', disallowNullValue: false)
  @HiveField(3)
  final String? shukketsuBunrui;
  @override
  @JsonKey(name: 'ShukketsuKbn', disallowNullValue: false)
  @HiveField(4)
  final String? shukketsuKbn;
  @override
  @JsonKey(name: 'Jiyu1', disallowNullValue: false)
  @HiveField(5)
  final String? jiyu1;
  @override
  @JsonKey(name: 'Jiyu2', disallowNullValue: false)
  @HiveField(6)
  final String? jiyu2;
  @override
  @JsonKey(name: 'IsEditable', disallowNullValue: false)
  @HiveField(7)
  final bool? isEditable;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceStatusModelImpl &&
            (identical(other.jokyoDate, jokyoDate) ||
                other.jokyoDate == jokyoDate) &&
            (identical(other.jigenIdx, jigenIdx) ||
                other.jigenIdx == jigenIdx) &&
            (identical(other.ryaku, ryaku) || other.ryaku == ryaku) &&
            (identical(other.shukketsuBunrui, shukketsuBunrui) ||
                other.shukketsuBunrui == shukketsuBunrui) &&
            (identical(other.shukketsuKbn, shukketsuKbn) ||
                other.shukketsuKbn == shukketsuKbn) &&
            (identical(other.jiyu1, jiyu1) || other.jiyu1 == jiyu1) &&
            (identical(other.jiyu2, jiyu2) || other.jiyu2 == jiyu2) &&
            (identical(other.isEditable, isEditable) ||
                other.isEditable == isEditable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, jokyoDate, jigenIdx, ryaku,
      shukketsuBunrui, shukketsuKbn, jiyu1, jiyu2, isEditable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceStatusModelImplCopyWith<_$AttendanceStatusModelImpl>
      get copyWith => __$$AttendanceStatusModelImplCopyWithImpl<
          _$AttendanceStatusModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceStatusModelImplToJson(
      this,
    );
  }
}

abstract class _AttendanceStatusModel implements AttendanceStatusModel {
  const factory _AttendanceStatusModel(
      {@JsonKey(name: 'Date', disallowNullValue: false)
      @HiveField(0)
      final DateTime? jokyoDate,
      @JsonKey(name: 'JigenIdx', disallowNullValue: false)
      @HiveField(1)
      final int? jigenIdx,
      @JsonKey(name: 'Ryaku', disallowNullValue: false)
      @HiveField(2)
      final String? ryaku,
      @JsonKey(name: 'ShukketsuBunrui', disallowNullValue: false)
      @HiveField(3)
      final String? shukketsuBunrui,
      @JsonKey(name: 'ShukketsuKbn', disallowNullValue: false)
      @HiveField(4)
      final String? shukketsuKbn,
      @JsonKey(name: 'Jiyu1', disallowNullValue: false)
      @HiveField(5)
      final String? jiyu1,
      @JsonKey(name: 'Jiyu2', disallowNullValue: false)
      @HiveField(6)
      final String? jiyu2,
      @JsonKey(name: 'IsEditable', disallowNullValue: false)
      @HiveField(7)
      final bool? isEditable}) = _$AttendanceStatusModelImpl;

  factory _AttendanceStatusModel.fromJson(Map<String, dynamic> json) =
      _$AttendanceStatusModelImpl.fromJson;

  @override
  @JsonKey(name: 'Date', disallowNullValue: false)
  @HiveField(0)
  DateTime? get jokyoDate;
  @override
  @JsonKey(name: 'JigenIdx', disallowNullValue: false)
  @HiveField(1)
  int? get jigenIdx;
  @override
  @JsonKey(name: 'Ryaku', disallowNullValue: false)
  @HiveField(2)
  String? get ryaku;
  @override
  @JsonKey(name: 'ShukketsuBunrui', disallowNullValue: false)
  @HiveField(3)
  String? get shukketsuBunrui;
  @override
  @JsonKey(name: 'ShukketsuKbn', disallowNullValue: false)
  @HiveField(4)
  String? get shukketsuKbn;
  @override
  @JsonKey(name: 'Jiyu1', disallowNullValue: false)
  @HiveField(5)
  String? get jiyu1;
  @override
  @JsonKey(name: 'Jiyu2', disallowNullValue: false)
  @HiveField(6)
  String? get jiyu2;
  @override
  @JsonKey(name: 'IsEditable', disallowNullValue: false)
  @HiveField(7)
  bool? get isEditable;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceStatusModelImplCopyWith<_$AttendanceStatusModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
