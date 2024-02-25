// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seat_chart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SeatChartModel _$SeatChartModelFromJson(Map<String, dynamic> json) {
  return _SeatChartModel.fromJson(json);
}

/// @nodoc
mixin _$SeatChartModel {
  @JsonKey(name: 'SeatIndex', disallowNullValue: false)
  @HiveField(0)
  int? get seatIndex => throw _privateConstructorUsedError;
  @JsonKey(name: 'SeatNumber', disallowNullValue: false)
  @HiveField(1)
  int? get seatNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'SeitoSeq', disallowNullValue: false)
  @HiveField(2)
  String? get seitoSeq => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeatChartModelCopyWith<SeatChartModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatChartModelCopyWith<$Res> {
  factory $SeatChartModelCopyWith(
          SeatChartModel value, $Res Function(SeatChartModel) then) =
      _$SeatChartModelCopyWithImpl<$Res, SeatChartModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'SeatIndex', disallowNullValue: false)
      @HiveField(0)
      int? seatIndex,
      @JsonKey(name: 'SeatNumber', disallowNullValue: false)
      @HiveField(1)
      int? seatNumber,
      @JsonKey(name: 'SeitoSeq', disallowNullValue: false)
      @HiveField(2)
      String? seitoSeq});
}

/// @nodoc
class _$SeatChartModelCopyWithImpl<$Res, $Val extends SeatChartModel>
    implements $SeatChartModelCopyWith<$Res> {
  _$SeatChartModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seatIndex = freezed,
    Object? seatNumber = freezed,
    Object? seitoSeq = freezed,
  }) {
    return _then(_value.copyWith(
      seatIndex: freezed == seatIndex
          ? _value.seatIndex
          : seatIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      seatNumber: freezed == seatNumber
          ? _value.seatNumber
          : seatNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      seitoSeq: freezed == seitoSeq
          ? _value.seitoSeq
          : seitoSeq // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeatChartModelImplCopyWith<$Res>
    implements $SeatChartModelCopyWith<$Res> {
  factory _$$SeatChartModelImplCopyWith(_$SeatChartModelImpl value,
          $Res Function(_$SeatChartModelImpl) then) =
      __$$SeatChartModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'SeatIndex', disallowNullValue: false)
      @HiveField(0)
      int? seatIndex,
      @JsonKey(name: 'SeatNumber', disallowNullValue: false)
      @HiveField(1)
      int? seatNumber,
      @JsonKey(name: 'SeitoSeq', disallowNullValue: false)
      @HiveField(2)
      String? seitoSeq});
}

/// @nodoc
class __$$SeatChartModelImplCopyWithImpl<$Res>
    extends _$SeatChartModelCopyWithImpl<$Res, _$SeatChartModelImpl>
    implements _$$SeatChartModelImplCopyWith<$Res> {
  __$$SeatChartModelImplCopyWithImpl(
      _$SeatChartModelImpl _value, $Res Function(_$SeatChartModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seatIndex = freezed,
    Object? seatNumber = freezed,
    Object? seitoSeq = freezed,
  }) {
    return _then(_$SeatChartModelImpl(
      seatIndex: freezed == seatIndex
          ? _value.seatIndex
          : seatIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      seatNumber: freezed == seatNumber
          ? _value.seatNumber
          : seatNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      seitoSeq: freezed == seitoSeq
          ? _value.seitoSeq
          : seitoSeq // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 46, adapterName: 'SeatChartModelAdapter')
class _$SeatChartModelImpl implements _SeatChartModel {
  const _$SeatChartModelImpl(
      {@JsonKey(name: 'SeatIndex', disallowNullValue: false)
      @HiveField(0)
      this.seatIndex,
      @JsonKey(name: 'SeatNumber', disallowNullValue: false)
      @HiveField(1)
      this.seatNumber,
      @JsonKey(name: 'SeitoSeq', disallowNullValue: false)
      @HiveField(2)
      this.seitoSeq});

  factory _$SeatChartModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeatChartModelImplFromJson(json);

  @override
  @JsonKey(name: 'SeatIndex', disallowNullValue: false)
  @HiveField(0)
  final int? seatIndex;
  @override
  @JsonKey(name: 'SeatNumber', disallowNullValue: false)
  @HiveField(1)
  final int? seatNumber;
  @override
  @JsonKey(name: 'SeitoSeq', disallowNullValue: false)
  @HiveField(2)
  final String? seitoSeq;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatChartModelImpl &&
            (identical(other.seatIndex, seatIndex) ||
                other.seatIndex == seatIndex) &&
            (identical(other.seatNumber, seatNumber) ||
                other.seatNumber == seatNumber) &&
            (identical(other.seitoSeq, seitoSeq) ||
                other.seitoSeq == seitoSeq));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, seatIndex, seatNumber, seitoSeq);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatChartModelImplCopyWith<_$SeatChartModelImpl> get copyWith =>
      __$$SeatChartModelImplCopyWithImpl<_$SeatChartModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeatChartModelImplToJson(
      this,
    );
  }
}

abstract class _SeatChartModel implements SeatChartModel {
  const factory _SeatChartModel(
      {@JsonKey(name: 'SeatIndex', disallowNullValue: false)
      @HiveField(0)
      final int? seatIndex,
      @JsonKey(name: 'SeatNumber', disallowNullValue: false)
      @HiveField(1)
      final int? seatNumber,
      @JsonKey(name: 'SeitoSeq', disallowNullValue: false)
      @HiveField(2)
      final String? seitoSeq}) = _$SeatChartModelImpl;

  factory _SeatChartModel.fromJson(Map<String, dynamic> json) =
      _$SeatChartModelImpl.fromJson;

  @override
  @JsonKey(name: 'SeatIndex', disallowNullValue: false)
  @HiveField(0)
  int? get seatIndex;
  @override
  @JsonKey(name: 'SeatNumber', disallowNullValue: false)
  @HiveField(1)
  int? get seatNumber;
  @override
  @JsonKey(name: 'SeitoSeq', disallowNullValue: false)
  @HiveField(2)
  String? get seitoSeq;
  @override
  @JsonKey(ignore: true)
  _$$SeatChartModelImplCopyWith<_$SeatChartModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
