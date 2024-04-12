// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tokobi_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TokobiModel _$TokobiModelFromJson(Map<String, dynamic> json) {
  return _TokobiModel.fromJson(json);
}

/// @nodoc
mixin _$TokobiModel {
  @JsonKey(name: 'Date', disallowNullValue: false)
  @HiveField(0)
  DateTime? get tokobi => throw _privateConstructorUsedError;
  @JsonKey(name: 'YobiCd', disallowNullValue: false)
  @HiveField(1)
  String? get yobiCd => throw _privateConstructorUsedError;
  @JsonKey(name: 'WeekName', disallowNullValue: false)
  @HiveField(2)
  String? get weekName => throw _privateConstructorUsedError;
  @JsonKey(name: 'Jigen', disallowNullValue: false)
  @HiveField(3)
  int? get jigen => throw _privateConstructorUsedError;
  @JsonKey(name: 'IsToday', disallowNullValue: false)
  @HiveField(4)
  bool? get isToday => throw _privateConstructorUsedError;
  @JsonKey(name: 'IsEditable', disallowNullValue: false)
  @HiveField(5)
  bool? get isEditable => throw _privateConstructorUsedError;
  @JsonKey(name: 'IsLocked', disallowNullValue: false)
  @HiveField(6)
  bool? get isLocked => throw _privateConstructorUsedError;
  @JsonKey(name: 'StampedCount', disallowNullValue: false)
  @HiveField(7)
  int? get stampedCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'TotalCount', disallowNullValue: false)
  @HiveField(8)
  int? get totalCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokobiModelCopyWith<TokobiModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokobiModelCopyWith<$Res> {
  factory $TokobiModelCopyWith(
          TokobiModel value, $Res Function(TokobiModel) then) =
      _$TokobiModelCopyWithImpl<$Res, TokobiModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Date', disallowNullValue: false)
      @HiveField(0)
      DateTime? tokobi,
      @JsonKey(name: 'YobiCd', disallowNullValue: false)
      @HiveField(1)
      String? yobiCd,
      @JsonKey(name: 'WeekName', disallowNullValue: false)
      @HiveField(2)
      String? weekName,
      @JsonKey(name: 'Jigen', disallowNullValue: false)
      @HiveField(3)
      int? jigen,
      @JsonKey(name: 'IsToday', disallowNullValue: false)
      @HiveField(4)
      bool? isToday,
      @JsonKey(name: 'IsEditable', disallowNullValue: false)
      @HiveField(5)
      bool? isEditable,
      @JsonKey(name: 'IsLocked', disallowNullValue: false)
      @HiveField(6)
      bool? isLocked,
      @JsonKey(name: 'StampedCount', disallowNullValue: false)
      @HiveField(7)
      int? stampedCount,
      @JsonKey(name: 'TotalCount', disallowNullValue: false)
      @HiveField(8)
      int? totalCount});
}

/// @nodoc
class _$TokobiModelCopyWithImpl<$Res, $Val extends TokobiModel>
    implements $TokobiModelCopyWith<$Res> {
  _$TokobiModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokobi = freezed,
    Object? yobiCd = freezed,
    Object? weekName = freezed,
    Object? jigen = freezed,
    Object? isToday = freezed,
    Object? isEditable = freezed,
    Object? isLocked = freezed,
    Object? stampedCount = freezed,
    Object? totalCount = freezed,
  }) {
    return _then(_value.copyWith(
      tokobi: freezed == tokobi
          ? _value.tokobi
          : tokobi // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      yobiCd: freezed == yobiCd
          ? _value.yobiCd
          : yobiCd // ignore: cast_nullable_to_non_nullable
              as String?,
      weekName: freezed == weekName
          ? _value.weekName
          : weekName // ignore: cast_nullable_to_non_nullable
              as String?,
      jigen: freezed == jigen
          ? _value.jigen
          : jigen // ignore: cast_nullable_to_non_nullable
              as int?,
      isToday: freezed == isToday
          ? _value.isToday
          : isToday // ignore: cast_nullable_to_non_nullable
              as bool?,
      isEditable: freezed == isEditable
          ? _value.isEditable
          : isEditable // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLocked: freezed == isLocked
          ? _value.isLocked
          : isLocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      stampedCount: freezed == stampedCount
          ? _value.stampedCount
          : stampedCount // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokobiModelImplCopyWith<$Res>
    implements $TokobiModelCopyWith<$Res> {
  factory _$$TokobiModelImplCopyWith(
          _$TokobiModelImpl value, $Res Function(_$TokobiModelImpl) then) =
      __$$TokobiModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Date', disallowNullValue: false)
      @HiveField(0)
      DateTime? tokobi,
      @JsonKey(name: 'YobiCd', disallowNullValue: false)
      @HiveField(1)
      String? yobiCd,
      @JsonKey(name: 'WeekName', disallowNullValue: false)
      @HiveField(2)
      String? weekName,
      @JsonKey(name: 'Jigen', disallowNullValue: false)
      @HiveField(3)
      int? jigen,
      @JsonKey(name: 'IsToday', disallowNullValue: false)
      @HiveField(4)
      bool? isToday,
      @JsonKey(name: 'IsEditable', disallowNullValue: false)
      @HiveField(5)
      bool? isEditable,
      @JsonKey(name: 'IsLocked', disallowNullValue: false)
      @HiveField(6)
      bool? isLocked,
      @JsonKey(name: 'StampedCount', disallowNullValue: false)
      @HiveField(7)
      int? stampedCount,
      @JsonKey(name: 'TotalCount', disallowNullValue: false)
      @HiveField(8)
      int? totalCount});
}

/// @nodoc
class __$$TokobiModelImplCopyWithImpl<$Res>
    extends _$TokobiModelCopyWithImpl<$Res, _$TokobiModelImpl>
    implements _$$TokobiModelImplCopyWith<$Res> {
  __$$TokobiModelImplCopyWithImpl(
      _$TokobiModelImpl _value, $Res Function(_$TokobiModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokobi = freezed,
    Object? yobiCd = freezed,
    Object? weekName = freezed,
    Object? jigen = freezed,
    Object? isToday = freezed,
    Object? isEditable = freezed,
    Object? isLocked = freezed,
    Object? stampedCount = freezed,
    Object? totalCount = freezed,
  }) {
    return _then(_$TokobiModelImpl(
      tokobi: freezed == tokobi
          ? _value.tokobi
          : tokobi // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      yobiCd: freezed == yobiCd
          ? _value.yobiCd
          : yobiCd // ignore: cast_nullable_to_non_nullable
              as String?,
      weekName: freezed == weekName
          ? _value.weekName
          : weekName // ignore: cast_nullable_to_non_nullable
              as String?,
      jigen: freezed == jigen
          ? _value.jigen
          : jigen // ignore: cast_nullable_to_non_nullable
              as int?,
      isToday: freezed == isToday
          ? _value.isToday
          : isToday // ignore: cast_nullable_to_non_nullable
              as bool?,
      isEditable: freezed == isEditable
          ? _value.isEditable
          : isEditable // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLocked: freezed == isLocked
          ? _value.isLocked
          : isLocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      stampedCount: freezed == stampedCount
          ? _value.stampedCount
          : stampedCount // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 37, adapterName: 'TokobiModelAdapter')
class _$TokobiModelImpl implements _TokobiModel {
  const _$TokobiModelImpl(
      {@JsonKey(name: 'Date', disallowNullValue: false)
      @HiveField(0)
      this.tokobi,
      @JsonKey(name: 'YobiCd', disallowNullValue: false)
      @HiveField(1)
      this.yobiCd,
      @JsonKey(name: 'WeekName', disallowNullValue: false)
      @HiveField(2)
      this.weekName,
      @JsonKey(name: 'Jigen', disallowNullValue: false)
      @HiveField(3)
      this.jigen,
      @JsonKey(name: 'IsToday', disallowNullValue: false)
      @HiveField(4)
      this.isToday,
      @JsonKey(name: 'IsEditable', disallowNullValue: false)
      @HiveField(5)
      this.isEditable,
      @JsonKey(name: 'IsLocked', disallowNullValue: false)
      @HiveField(6)
      this.isLocked,
      @JsonKey(name: 'StampedCount', disallowNullValue: false)
      @HiveField(7)
      this.stampedCount,
      @JsonKey(name: 'TotalCount', disallowNullValue: false)
      @HiveField(8)
      this.totalCount});

  factory _$TokobiModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokobiModelImplFromJson(json);

  @override
  @JsonKey(name: 'Date', disallowNullValue: false)
  @HiveField(0)
  final DateTime? tokobi;
  @override
  @JsonKey(name: 'YobiCd', disallowNullValue: false)
  @HiveField(1)
  final String? yobiCd;
  @override
  @JsonKey(name: 'WeekName', disallowNullValue: false)
  @HiveField(2)
  final String? weekName;
  @override
  @JsonKey(name: 'Jigen', disallowNullValue: false)
  @HiveField(3)
  final int? jigen;
  @override
  @JsonKey(name: 'IsToday', disallowNullValue: false)
  @HiveField(4)
  final bool? isToday;
  @override
  @JsonKey(name: 'IsEditable', disallowNullValue: false)
  @HiveField(5)
  final bool? isEditable;
  @override
  @JsonKey(name: 'IsLocked', disallowNullValue: false)
  @HiveField(6)
  final bool? isLocked;
  @override
  @JsonKey(name: 'StampedCount', disallowNullValue: false)
  @HiveField(7)
  final int? stampedCount;
  @override
  @JsonKey(name: 'TotalCount', disallowNullValue: false)
  @HiveField(8)
  final int? totalCount;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokobiModelImpl &&
            (identical(other.tokobi, tokobi) || other.tokobi == tokobi) &&
            (identical(other.yobiCd, yobiCd) || other.yobiCd == yobiCd) &&
            (identical(other.weekName, weekName) ||
                other.weekName == weekName) &&
            (identical(other.jigen, jigen) || other.jigen == jigen) &&
            (identical(other.isToday, isToday) || other.isToday == isToday) &&
            (identical(other.isEditable, isEditable) ||
                other.isEditable == isEditable) &&
            (identical(other.isLocked, isLocked) ||
                other.isLocked == isLocked) &&
            (identical(other.stampedCount, stampedCount) ||
                other.stampedCount == stampedCount) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tokobi, yobiCd, weekName, jigen,
      isToday, isEditable, isLocked, stampedCount, totalCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokobiModelImplCopyWith<_$TokobiModelImpl> get copyWith =>
      __$$TokobiModelImplCopyWithImpl<_$TokobiModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokobiModelImplToJson(
      this,
    );
  }
}

abstract class _TokobiModel implements TokobiModel {
  const factory _TokobiModel(
      {@JsonKey(name: 'Date', disallowNullValue: false)
      @HiveField(0)
      final DateTime? tokobi,
      @JsonKey(name: 'YobiCd', disallowNullValue: false)
      @HiveField(1)
      final String? yobiCd,
      @JsonKey(name: 'WeekName', disallowNullValue: false)
      @HiveField(2)
      final String? weekName,
      @JsonKey(name: 'Jigen', disallowNullValue: false)
      @HiveField(3)
      final int? jigen,
      @JsonKey(name: 'IsToday', disallowNullValue: false)
      @HiveField(4)
      final bool? isToday,
      @JsonKey(name: 'IsEditable', disallowNullValue: false)
      @HiveField(5)
      final bool? isEditable,
      @JsonKey(name: 'IsLocked', disallowNullValue: false)
      @HiveField(6)
      final bool? isLocked,
      @JsonKey(name: 'StampedCount', disallowNullValue: false)
      @HiveField(7)
      final int? stampedCount,
      @JsonKey(name: 'TotalCount', disallowNullValue: false)
      @HiveField(8)
      final int? totalCount}) = _$TokobiModelImpl;

  factory _TokobiModel.fromJson(Map<String, dynamic> json) =
      _$TokobiModelImpl.fromJson;

  @override
  @JsonKey(name: 'Date', disallowNullValue: false)
  @HiveField(0)
  DateTime? get tokobi;
  @override
  @JsonKey(name: 'YobiCd', disallowNullValue: false)
  @HiveField(1)
  String? get yobiCd;
  @override
  @JsonKey(name: 'WeekName', disallowNullValue: false)
  @HiveField(2)
  String? get weekName;
  @override
  @JsonKey(name: 'Jigen', disallowNullValue: false)
  @HiveField(3)
  int? get jigen;
  @override
  @JsonKey(name: 'IsToday', disallowNullValue: false)
  @HiveField(4)
  bool? get isToday;
  @override
  @JsonKey(name: 'IsEditable', disallowNullValue: false)
  @HiveField(5)
  bool? get isEditable;
  @override
  @JsonKey(name: 'IsLocked', disallowNullValue: false)
  @HiveField(6)
  bool? get isLocked;
  @override
  @JsonKey(name: 'StampedCount', disallowNullValue: false)
  @HiveField(7)
  int? get stampedCount;
  @override
  @JsonKey(name: 'TotalCount', disallowNullValue: false)
  @HiveField(8)
  int? get totalCount;
  @override
  @JsonKey(ignore: true)
  _$$TokobiModelImplCopyWith<_$TokobiModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
