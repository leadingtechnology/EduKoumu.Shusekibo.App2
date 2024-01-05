// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seat_setting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SeatSettingModel _$SeatSettingModelFromJson(Map<String, dynamic> json) {
  return _SeatSettingModel.fromJson(json);
}

/// @nodoc
mixin _$SeatSettingModel {
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(0)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'TenantId', disallowNullValue: false)
  @HiveField(1)
  int? get tenantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'DantaiId', disallowNullValue: false)
  @HiveField(2)
  int? get dantaiId => throw _privateConstructorUsedError;
  @JsonKey(name: 'ShozokuId', disallowNullValue: false)
  @HiveField(3)
  int? get shozokuId => throw _privateConstructorUsedError;
  @JsonKey(name: 'SeatPattern', disallowNullValue: false)
  @HiveField(4)
  String? get seatPattern => throw _privateConstructorUsedError;
  @JsonKey(name: 'SeatPatternName', disallowNullValue: false)
  @HiveField(5)
  String? get seatPatternName => throw _privateConstructorUsedError;
  @JsonKey(name: 'Row', disallowNullValue: false)
  @HiveField(6)
  int? get row => throw _privateConstructorUsedError;
  @JsonKey(name: 'Column', disallowNullValue: false)
  @HiveField(7)
  int? get column => throw _privateConstructorUsedError;
  @JsonKey(name: 'SeatOrder', disallowNullValue: false)
  @HiveField(8)
  int? get seatOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'StartDate', disallowNullValue: false)
  @HiveField(9)
  DateTime? get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'EndDate', disallowNullValue: false)
  @HiveField(10)
  DateTime? get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'CrtUserId', disallowNullValue: false)
  @HiveField(11)
  int? get crtUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'CrtUserName', disallowNullValue: false)
  @HiveField(12)
  String? get crtUserName => throw _privateConstructorUsedError;
  @JsonKey(name: 'CrtDateTime', disallowNullValue: false)
  @HiveField(13)
  DateTime? get crtDateTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'UpdUserId', disallowNullValue: false)
  @HiveField(14)
  int? get updUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'UpdUserName', disallowNullValue: false)
  @HiveField(15)
  String? get updUserName => throw _privateConstructorUsedError;
  @JsonKey(name: 'UpdDateTime', disallowNullValue: false)
  @HiveField(16)
  DateTime? get updDateTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'DeleteFlg', disallowNullValue: false)
  @HiveField(17)
  bool? get deleteFlg => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeatSettingModelCopyWith<SeatSettingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatSettingModelCopyWith<$Res> {
  factory $SeatSettingModelCopyWith(
          SeatSettingModel value, $Res Function(SeatSettingModel) then) =
      _$SeatSettingModelCopyWithImpl<$Res, SeatSettingModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
      @JsonKey(name: 'TenantId', disallowNullValue: false)
      @HiveField(1)
      int? tenantId,
      @JsonKey(name: 'DantaiId', disallowNullValue: false)
      @HiveField(2)
      int? dantaiId,
      @JsonKey(name: 'ShozokuId', disallowNullValue: false)
      @HiveField(3)
      int? shozokuId,
      @JsonKey(name: 'SeatPattern', disallowNullValue: false)
      @HiveField(4)
      String? seatPattern,
      @JsonKey(name: 'SeatPatternName', disallowNullValue: false)
      @HiveField(5)
      String? seatPatternName,
      @JsonKey(name: 'Row', disallowNullValue: false) @HiveField(6) int? row,
      @JsonKey(name: 'Column', disallowNullValue: false)
      @HiveField(7)
      int? column,
      @JsonKey(name: 'SeatOrder', disallowNullValue: false)
      @HiveField(8)
      int? seatOrder,
      @JsonKey(name: 'StartDate', disallowNullValue: false)
      @HiveField(9)
      DateTime? startDate,
      @JsonKey(name: 'EndDate', disallowNullValue: false)
      @HiveField(10)
      DateTime? endDate,
      @JsonKey(name: 'CrtUserId', disallowNullValue: false)
      @HiveField(11)
      int? crtUserId,
      @JsonKey(name: 'CrtUserName', disallowNullValue: false)
      @HiveField(12)
      String? crtUserName,
      @JsonKey(name: 'CrtDateTime', disallowNullValue: false)
      @HiveField(13)
      DateTime? crtDateTime,
      @JsonKey(name: 'UpdUserId', disallowNullValue: false)
      @HiveField(14)
      int? updUserId,
      @JsonKey(name: 'UpdUserName', disallowNullValue: false)
      @HiveField(15)
      String? updUserName,
      @JsonKey(name: 'UpdDateTime', disallowNullValue: false)
      @HiveField(16)
      DateTime? updDateTime,
      @JsonKey(name: 'DeleteFlg', disallowNullValue: false)
      @HiveField(17)
      bool? deleteFlg});
}

/// @nodoc
class _$SeatSettingModelCopyWithImpl<$Res, $Val extends SeatSettingModel>
    implements $SeatSettingModelCopyWith<$Res> {
  _$SeatSettingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? dantaiId = freezed,
    Object? shozokuId = freezed,
    Object? seatPattern = freezed,
    Object? seatPatternName = freezed,
    Object? row = freezed,
    Object? column = freezed,
    Object? seatOrder = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? crtUserId = freezed,
    Object? crtUserName = freezed,
    Object? crtDateTime = freezed,
    Object? updUserId = freezed,
    Object? updUserName = freezed,
    Object? updDateTime = freezed,
    Object? deleteFlg = freezed,
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
      dantaiId: freezed == dantaiId
          ? _value.dantaiId
          : dantaiId // ignore: cast_nullable_to_non_nullable
              as int?,
      shozokuId: freezed == shozokuId
          ? _value.shozokuId
          : shozokuId // ignore: cast_nullable_to_non_nullable
              as int?,
      seatPattern: freezed == seatPattern
          ? _value.seatPattern
          : seatPattern // ignore: cast_nullable_to_non_nullable
              as String?,
      seatPatternName: freezed == seatPatternName
          ? _value.seatPatternName
          : seatPatternName // ignore: cast_nullable_to_non_nullable
              as String?,
      row: freezed == row
          ? _value.row
          : row // ignore: cast_nullable_to_non_nullable
              as int?,
      column: freezed == column
          ? _value.column
          : column // ignore: cast_nullable_to_non_nullable
              as int?,
      seatOrder: freezed == seatOrder
          ? _value.seatOrder
          : seatOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      crtUserId: freezed == crtUserId
          ? _value.crtUserId
          : crtUserId // ignore: cast_nullable_to_non_nullable
              as int?,
      crtUserName: freezed == crtUserName
          ? _value.crtUserName
          : crtUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      crtDateTime: freezed == crtDateTime
          ? _value.crtDateTime
          : crtDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updUserId: freezed == updUserId
          ? _value.updUserId
          : updUserId // ignore: cast_nullable_to_non_nullable
              as int?,
      updUserName: freezed == updUserName
          ? _value.updUserName
          : updUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      updDateTime: freezed == updDateTime
          ? _value.updDateTime
          : updDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deleteFlg: freezed == deleteFlg
          ? _value.deleteFlg
          : deleteFlg // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeatSettingModelImplCopyWith<$Res>
    implements $SeatSettingModelCopyWith<$Res> {
  factory _$$SeatSettingModelImplCopyWith(_$SeatSettingModelImpl value,
          $Res Function(_$SeatSettingModelImpl) then) =
      __$$SeatSettingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) int? id,
      @JsonKey(name: 'TenantId', disallowNullValue: false)
      @HiveField(1)
      int? tenantId,
      @JsonKey(name: 'DantaiId', disallowNullValue: false)
      @HiveField(2)
      int? dantaiId,
      @JsonKey(name: 'ShozokuId', disallowNullValue: false)
      @HiveField(3)
      int? shozokuId,
      @JsonKey(name: 'SeatPattern', disallowNullValue: false)
      @HiveField(4)
      String? seatPattern,
      @JsonKey(name: 'SeatPatternName', disallowNullValue: false)
      @HiveField(5)
      String? seatPatternName,
      @JsonKey(name: 'Row', disallowNullValue: false) @HiveField(6) int? row,
      @JsonKey(name: 'Column', disallowNullValue: false)
      @HiveField(7)
      int? column,
      @JsonKey(name: 'SeatOrder', disallowNullValue: false)
      @HiveField(8)
      int? seatOrder,
      @JsonKey(name: 'StartDate', disallowNullValue: false)
      @HiveField(9)
      DateTime? startDate,
      @JsonKey(name: 'EndDate', disallowNullValue: false)
      @HiveField(10)
      DateTime? endDate,
      @JsonKey(name: 'CrtUserId', disallowNullValue: false)
      @HiveField(11)
      int? crtUserId,
      @JsonKey(name: 'CrtUserName', disallowNullValue: false)
      @HiveField(12)
      String? crtUserName,
      @JsonKey(name: 'CrtDateTime', disallowNullValue: false)
      @HiveField(13)
      DateTime? crtDateTime,
      @JsonKey(name: 'UpdUserId', disallowNullValue: false)
      @HiveField(14)
      int? updUserId,
      @JsonKey(name: 'UpdUserName', disallowNullValue: false)
      @HiveField(15)
      String? updUserName,
      @JsonKey(name: 'UpdDateTime', disallowNullValue: false)
      @HiveField(16)
      DateTime? updDateTime,
      @JsonKey(name: 'DeleteFlg', disallowNullValue: false)
      @HiveField(17)
      bool? deleteFlg});
}

/// @nodoc
class __$$SeatSettingModelImplCopyWithImpl<$Res>
    extends _$SeatSettingModelCopyWithImpl<$Res, _$SeatSettingModelImpl>
    implements _$$SeatSettingModelImplCopyWith<$Res> {
  __$$SeatSettingModelImplCopyWithImpl(_$SeatSettingModelImpl _value,
      $Res Function(_$SeatSettingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? dantaiId = freezed,
    Object? shozokuId = freezed,
    Object? seatPattern = freezed,
    Object? seatPatternName = freezed,
    Object? row = freezed,
    Object? column = freezed,
    Object? seatOrder = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? crtUserId = freezed,
    Object? crtUserName = freezed,
    Object? crtDateTime = freezed,
    Object? updUserId = freezed,
    Object? updUserName = freezed,
    Object? updDateTime = freezed,
    Object? deleteFlg = freezed,
  }) {
    return _then(_$SeatSettingModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as int?,
      dantaiId: freezed == dantaiId
          ? _value.dantaiId
          : dantaiId // ignore: cast_nullable_to_non_nullable
              as int?,
      shozokuId: freezed == shozokuId
          ? _value.shozokuId
          : shozokuId // ignore: cast_nullable_to_non_nullable
              as int?,
      seatPattern: freezed == seatPattern
          ? _value.seatPattern
          : seatPattern // ignore: cast_nullable_to_non_nullable
              as String?,
      seatPatternName: freezed == seatPatternName
          ? _value.seatPatternName
          : seatPatternName // ignore: cast_nullable_to_non_nullable
              as String?,
      row: freezed == row
          ? _value.row
          : row // ignore: cast_nullable_to_non_nullable
              as int?,
      column: freezed == column
          ? _value.column
          : column // ignore: cast_nullable_to_non_nullable
              as int?,
      seatOrder: freezed == seatOrder
          ? _value.seatOrder
          : seatOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      crtUserId: freezed == crtUserId
          ? _value.crtUserId
          : crtUserId // ignore: cast_nullable_to_non_nullable
              as int?,
      crtUserName: freezed == crtUserName
          ? _value.crtUserName
          : crtUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      crtDateTime: freezed == crtDateTime
          ? _value.crtDateTime
          : crtDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updUserId: freezed == updUserId
          ? _value.updUserId
          : updUserId // ignore: cast_nullable_to_non_nullable
              as int?,
      updUserName: freezed == updUserName
          ? _value.updUserName
          : updUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      updDateTime: freezed == updDateTime
          ? _value.updDateTime
          : updDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deleteFlg: freezed == deleteFlg
          ? _value.deleteFlg
          : deleteFlg // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 45, adapterName: 'SeatSettingModelAdapter')
class _$SeatSettingModelImpl implements _SeatSettingModel {
  const _$SeatSettingModelImpl(
      {@JsonKey(name: 'Id', disallowNullValue: false) @HiveField(0) this.id,
      @JsonKey(name: 'TenantId', disallowNullValue: false)
      @HiveField(1)
      this.tenantId,
      @JsonKey(name: 'DantaiId', disallowNullValue: false)
      @HiveField(2)
      this.dantaiId,
      @JsonKey(name: 'ShozokuId', disallowNullValue: false)
      @HiveField(3)
      this.shozokuId,
      @JsonKey(name: 'SeatPattern', disallowNullValue: false)
      @HiveField(4)
      this.seatPattern,
      @JsonKey(name: 'SeatPatternName', disallowNullValue: false)
      @HiveField(5)
      this.seatPatternName,
      @JsonKey(name: 'Row', disallowNullValue: false) @HiveField(6) this.row,
      @JsonKey(name: 'Column', disallowNullValue: false)
      @HiveField(7)
      this.column,
      @JsonKey(name: 'SeatOrder', disallowNullValue: false)
      @HiveField(8)
      this.seatOrder,
      @JsonKey(name: 'StartDate', disallowNullValue: false)
      @HiveField(9)
      this.startDate,
      @JsonKey(name: 'EndDate', disallowNullValue: false)
      @HiveField(10)
      this.endDate,
      @JsonKey(name: 'CrtUserId', disallowNullValue: false)
      @HiveField(11)
      this.crtUserId,
      @JsonKey(name: 'CrtUserName', disallowNullValue: false)
      @HiveField(12)
      this.crtUserName,
      @JsonKey(name: 'CrtDateTime', disallowNullValue: false)
      @HiveField(13)
      this.crtDateTime,
      @JsonKey(name: 'UpdUserId', disallowNullValue: false)
      @HiveField(14)
      this.updUserId,
      @JsonKey(name: 'UpdUserName', disallowNullValue: false)
      @HiveField(15)
      this.updUserName,
      @JsonKey(name: 'UpdDateTime', disallowNullValue: false)
      @HiveField(16)
      this.updDateTime,
      @JsonKey(name: 'DeleteFlg', disallowNullValue: false)
      @HiveField(17)
      this.deleteFlg});

  factory _$SeatSettingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeatSettingModelImplFromJson(json);

  @override
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(0)
  final int? id;
  @override
  @JsonKey(name: 'TenantId', disallowNullValue: false)
  @HiveField(1)
  final int? tenantId;
  @override
  @JsonKey(name: 'DantaiId', disallowNullValue: false)
  @HiveField(2)
  final int? dantaiId;
  @override
  @JsonKey(name: 'ShozokuId', disallowNullValue: false)
  @HiveField(3)
  final int? shozokuId;
  @override
  @JsonKey(name: 'SeatPattern', disallowNullValue: false)
  @HiveField(4)
  final String? seatPattern;
  @override
  @JsonKey(name: 'SeatPatternName', disallowNullValue: false)
  @HiveField(5)
  final String? seatPatternName;
  @override
  @JsonKey(name: 'Row', disallowNullValue: false)
  @HiveField(6)
  final int? row;
  @override
  @JsonKey(name: 'Column', disallowNullValue: false)
  @HiveField(7)
  final int? column;
  @override
  @JsonKey(name: 'SeatOrder', disallowNullValue: false)
  @HiveField(8)
  final int? seatOrder;
  @override
  @JsonKey(name: 'StartDate', disallowNullValue: false)
  @HiveField(9)
  final DateTime? startDate;
  @override
  @JsonKey(name: 'EndDate', disallowNullValue: false)
  @HiveField(10)
  final DateTime? endDate;
  @override
  @JsonKey(name: 'CrtUserId', disallowNullValue: false)
  @HiveField(11)
  final int? crtUserId;
  @override
  @JsonKey(name: 'CrtUserName', disallowNullValue: false)
  @HiveField(12)
  final String? crtUserName;
  @override
  @JsonKey(name: 'CrtDateTime', disallowNullValue: false)
  @HiveField(13)
  final DateTime? crtDateTime;
  @override
  @JsonKey(name: 'UpdUserId', disallowNullValue: false)
  @HiveField(14)
  final int? updUserId;
  @override
  @JsonKey(name: 'UpdUserName', disallowNullValue: false)
  @HiveField(15)
  final String? updUserName;
  @override
  @JsonKey(name: 'UpdDateTime', disallowNullValue: false)
  @HiveField(16)
  final DateTime? updDateTime;
  @override
  @JsonKey(name: 'DeleteFlg', disallowNullValue: false)
  @HiveField(17)
  final bool? deleteFlg;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatSettingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.dantaiId, dantaiId) ||
                other.dantaiId == dantaiId) &&
            (identical(other.shozokuId, shozokuId) ||
                other.shozokuId == shozokuId) &&
            (identical(other.seatPattern, seatPattern) ||
                other.seatPattern == seatPattern) &&
            (identical(other.seatPatternName, seatPatternName) ||
                other.seatPatternName == seatPatternName) &&
            (identical(other.row, row) || other.row == row) &&
            (identical(other.column, column) || other.column == column) &&
            (identical(other.seatOrder, seatOrder) ||
                other.seatOrder == seatOrder) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.crtUserId, crtUserId) ||
                other.crtUserId == crtUserId) &&
            (identical(other.crtUserName, crtUserName) ||
                other.crtUserName == crtUserName) &&
            (identical(other.crtDateTime, crtDateTime) ||
                other.crtDateTime == crtDateTime) &&
            (identical(other.updUserId, updUserId) ||
                other.updUserId == updUserId) &&
            (identical(other.updUserName, updUserName) ||
                other.updUserName == updUserName) &&
            (identical(other.updDateTime, updDateTime) ||
                other.updDateTime == updDateTime) &&
            (identical(other.deleteFlg, deleteFlg) ||
                other.deleteFlg == deleteFlg));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tenantId,
      dantaiId,
      shozokuId,
      seatPattern,
      seatPatternName,
      row,
      column,
      seatOrder,
      startDate,
      endDate,
      crtUserId,
      crtUserName,
      crtDateTime,
      updUserId,
      updUserName,
      updDateTime,
      deleteFlg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatSettingModelImplCopyWith<_$SeatSettingModelImpl> get copyWith =>
      __$$SeatSettingModelImplCopyWithImpl<_$SeatSettingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeatSettingModelImplToJson(
      this,
    );
  }
}

abstract class _SeatSettingModel implements SeatSettingModel {
  const factory _SeatSettingModel(
      {@JsonKey(name: 'Id', disallowNullValue: false)
      @HiveField(0)
      final int? id,
      @JsonKey(name: 'TenantId', disallowNullValue: false)
      @HiveField(1)
      final int? tenantId,
      @JsonKey(name: 'DantaiId', disallowNullValue: false)
      @HiveField(2)
      final int? dantaiId,
      @JsonKey(name: 'ShozokuId', disallowNullValue: false)
      @HiveField(3)
      final int? shozokuId,
      @JsonKey(name: 'SeatPattern', disallowNullValue: false)
      @HiveField(4)
      final String? seatPattern,
      @JsonKey(name: 'SeatPatternName', disallowNullValue: false)
      @HiveField(5)
      final String? seatPatternName,
      @JsonKey(name: 'Row', disallowNullValue: false)
      @HiveField(6)
      final int? row,
      @JsonKey(name: 'Column', disallowNullValue: false)
      @HiveField(7)
      final int? column,
      @JsonKey(name: 'SeatOrder', disallowNullValue: false)
      @HiveField(8)
      final int? seatOrder,
      @JsonKey(name: 'StartDate', disallowNullValue: false)
      @HiveField(9)
      final DateTime? startDate,
      @JsonKey(name: 'EndDate', disallowNullValue: false)
      @HiveField(10)
      final DateTime? endDate,
      @JsonKey(name: 'CrtUserId', disallowNullValue: false)
      @HiveField(11)
      final int? crtUserId,
      @JsonKey(name: 'CrtUserName', disallowNullValue: false)
      @HiveField(12)
      final String? crtUserName,
      @JsonKey(name: 'CrtDateTime', disallowNullValue: false)
      @HiveField(13)
      final DateTime? crtDateTime,
      @JsonKey(name: 'UpdUserId', disallowNullValue: false)
      @HiveField(14)
      final int? updUserId,
      @JsonKey(name: 'UpdUserName', disallowNullValue: false)
      @HiveField(15)
      final String? updUserName,
      @JsonKey(name: 'UpdDateTime', disallowNullValue: false)
      @HiveField(16)
      final DateTime? updDateTime,
      @JsonKey(name: 'DeleteFlg', disallowNullValue: false)
      @HiveField(17)
      final bool? deleteFlg}) = _$SeatSettingModelImpl;

  factory _SeatSettingModel.fromJson(Map<String, dynamic> json) =
      _$SeatSettingModelImpl.fromJson;

  @override
  @JsonKey(name: 'Id', disallowNullValue: false)
  @HiveField(0)
  int? get id;
  @override
  @JsonKey(name: 'TenantId', disallowNullValue: false)
  @HiveField(1)
  int? get tenantId;
  @override
  @JsonKey(name: 'DantaiId', disallowNullValue: false)
  @HiveField(2)
  int? get dantaiId;
  @override
  @JsonKey(name: 'ShozokuId', disallowNullValue: false)
  @HiveField(3)
  int? get shozokuId;
  @override
  @JsonKey(name: 'SeatPattern', disallowNullValue: false)
  @HiveField(4)
  String? get seatPattern;
  @override
  @JsonKey(name: 'SeatPatternName', disallowNullValue: false)
  @HiveField(5)
  String? get seatPatternName;
  @override
  @JsonKey(name: 'Row', disallowNullValue: false)
  @HiveField(6)
  int? get row;
  @override
  @JsonKey(name: 'Column', disallowNullValue: false)
  @HiveField(7)
  int? get column;
  @override
  @JsonKey(name: 'SeatOrder', disallowNullValue: false)
  @HiveField(8)
  int? get seatOrder;
  @override
  @JsonKey(name: 'StartDate', disallowNullValue: false)
  @HiveField(9)
  DateTime? get startDate;
  @override
  @JsonKey(name: 'EndDate', disallowNullValue: false)
  @HiveField(10)
  DateTime? get endDate;
  @override
  @JsonKey(name: 'CrtUserId', disallowNullValue: false)
  @HiveField(11)
  int? get crtUserId;
  @override
  @JsonKey(name: 'CrtUserName', disallowNullValue: false)
  @HiveField(12)
  String? get crtUserName;
  @override
  @JsonKey(name: 'CrtDateTime', disallowNullValue: false)
  @HiveField(13)
  DateTime? get crtDateTime;
  @override
  @JsonKey(name: 'UpdUserId', disallowNullValue: false)
  @HiveField(14)
  int? get updUserId;
  @override
  @JsonKey(name: 'UpdUserName', disallowNullValue: false)
  @HiveField(15)
  String? get updUserName;
  @override
  @JsonKey(name: 'UpdDateTime', disallowNullValue: false)
  @HiveField(16)
  DateTime? get updDateTime;
  @override
  @JsonKey(name: 'DeleteFlg', disallowNullValue: false)
  @HiveField(17)
  bool? get deleteFlg;
  @override
  @JsonKey(ignore: true)
  _$$SeatSettingModelImplCopyWith<_$SeatSettingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
