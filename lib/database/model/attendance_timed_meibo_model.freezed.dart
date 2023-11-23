// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_timed_meibo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AttendanceTimedMeiboModel _$AttendanceTimedMeiboModelFromJson(
    Map<String, dynamic> json) {
  return _AttendanceTimedMeiboModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceTimedMeiboModel {
  @JsonKey(name: 'StudentKihonId', disallowNullValue: false)
  @HiveField(0)
  int? get studentKihonId => throw _privateConstructorUsedError;
  @JsonKey(name: 'StudentSeq', disallowNullValue: false)
  @HiveField(1)
  String? get studentSeq => throw _privateConstructorUsedError;
  @JsonKey(name: 'Gakunen', disallowNullValue: false)
  @HiveField(2)
  String? get gakunen => throw _privateConstructorUsedError;
  @JsonKey(name: 'ClassName', disallowNullValue: false)
  @HiveField(3)
  String? get className => throw _privateConstructorUsedError;
  @JsonKey(name: 'StudentNumber', disallowNullValue: false)
  @HiveField(4)
  String? get studentNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'PhotoImageFlg', disallowNullValue: false)
  @HiveField(5)
  bool? get photoImageFlg => throw _privateConstructorUsedError;
  @JsonKey(name: 'Name', disallowNullValue: false)
  @HiveField(6)
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'GenderCode', disallowNullValue: false)
  @HiveField(7)
  String? get genderCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
  @HiveField(8)
  String? get photoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'JokyoList', disallowNullValue: false)
  @HiveField(9)
  List<AttendanceTimedStatusModel>? get jokyoList =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceTimedMeiboModelCopyWith<AttendanceTimedMeiboModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceTimedMeiboModelCopyWith<$Res> {
  factory $AttendanceTimedMeiboModelCopyWith(AttendanceTimedMeiboModel value,
          $Res Function(AttendanceTimedMeiboModel) then) =
      _$AttendanceTimedMeiboModelCopyWithImpl<$Res, AttendanceTimedMeiboModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'StudentKihonId', disallowNullValue: false)
      @HiveField(0)
      int? studentKihonId,
      @JsonKey(name: 'StudentSeq', disallowNullValue: false)
      @HiveField(1)
      String? studentSeq,
      @JsonKey(name: 'Gakunen', disallowNullValue: false)
      @HiveField(2)
      String? gakunen,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(3)
      String? className,
      @JsonKey(name: 'StudentNumber', disallowNullValue: false)
      @HiveField(4)
      String? studentNumber,
      @JsonKey(name: 'PhotoImageFlg', disallowNullValue: false)
      @HiveField(5)
      bool? photoImageFlg,
      @JsonKey(name: 'Name', disallowNullValue: false)
      @HiveField(6)
      String? name,
      @JsonKey(name: 'GenderCode', disallowNullValue: false)
      @HiveField(7)
      String? genderCode,
      @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
      @HiveField(8)
      String? photoUrl,
      @JsonKey(name: 'JokyoList', disallowNullValue: false)
      @HiveField(9)
      List<AttendanceTimedStatusModel>? jokyoList});
}

/// @nodoc
class _$AttendanceTimedMeiboModelCopyWithImpl<$Res,
        $Val extends AttendanceTimedMeiboModel>
    implements $AttendanceTimedMeiboModelCopyWith<$Res> {
  _$AttendanceTimedMeiboModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentKihonId = freezed,
    Object? studentSeq = freezed,
    Object? gakunen = freezed,
    Object? className = freezed,
    Object? studentNumber = freezed,
    Object? photoImageFlg = freezed,
    Object? name = freezed,
    Object? genderCode = freezed,
    Object? photoUrl = freezed,
    Object? jokyoList = freezed,
  }) {
    return _then(_value.copyWith(
      studentKihonId: freezed == studentKihonId
          ? _value.studentKihonId
          : studentKihonId // ignore: cast_nullable_to_non_nullable
              as int?,
      studentSeq: freezed == studentSeq
          ? _value.studentSeq
          : studentSeq // ignore: cast_nullable_to_non_nullable
              as String?,
      gakunen: freezed == gakunen
          ? _value.gakunen
          : gakunen // ignore: cast_nullable_to_non_nullable
              as String?,
      className: freezed == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      studentNumber: freezed == studentNumber
          ? _value.studentNumber
          : studentNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoImageFlg: freezed == photoImageFlg
          ? _value.photoImageFlg
          : photoImageFlg // ignore: cast_nullable_to_non_nullable
              as bool?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      genderCode: freezed == genderCode
          ? _value.genderCode
          : genderCode // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      jokyoList: freezed == jokyoList
          ? _value.jokyoList
          : jokyoList // ignore: cast_nullable_to_non_nullable
              as List<AttendanceTimedStatusModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceTimedMeiboModelImplCopyWith<$Res>
    implements $AttendanceTimedMeiboModelCopyWith<$Res> {
  factory _$$AttendanceTimedMeiboModelImplCopyWith(
          _$AttendanceTimedMeiboModelImpl value,
          $Res Function(_$AttendanceTimedMeiboModelImpl) then) =
      __$$AttendanceTimedMeiboModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'StudentKihonId', disallowNullValue: false)
      @HiveField(0)
      int? studentKihonId,
      @JsonKey(name: 'StudentSeq', disallowNullValue: false)
      @HiveField(1)
      String? studentSeq,
      @JsonKey(name: 'Gakunen', disallowNullValue: false)
      @HiveField(2)
      String? gakunen,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(3)
      String? className,
      @JsonKey(name: 'StudentNumber', disallowNullValue: false)
      @HiveField(4)
      String? studentNumber,
      @JsonKey(name: 'PhotoImageFlg', disallowNullValue: false)
      @HiveField(5)
      bool? photoImageFlg,
      @JsonKey(name: 'Name', disallowNullValue: false)
      @HiveField(6)
      String? name,
      @JsonKey(name: 'GenderCode', disallowNullValue: false)
      @HiveField(7)
      String? genderCode,
      @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
      @HiveField(8)
      String? photoUrl,
      @JsonKey(name: 'JokyoList', disallowNullValue: false)
      @HiveField(9)
      List<AttendanceTimedStatusModel>? jokyoList});
}

/// @nodoc
class __$$AttendanceTimedMeiboModelImplCopyWithImpl<$Res>
    extends _$AttendanceTimedMeiboModelCopyWithImpl<$Res,
        _$AttendanceTimedMeiboModelImpl>
    implements _$$AttendanceTimedMeiboModelImplCopyWith<$Res> {
  __$$AttendanceTimedMeiboModelImplCopyWithImpl(
      _$AttendanceTimedMeiboModelImpl _value,
      $Res Function(_$AttendanceTimedMeiboModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentKihonId = freezed,
    Object? studentSeq = freezed,
    Object? gakunen = freezed,
    Object? className = freezed,
    Object? studentNumber = freezed,
    Object? photoImageFlg = freezed,
    Object? name = freezed,
    Object? genderCode = freezed,
    Object? photoUrl = freezed,
    Object? jokyoList = freezed,
  }) {
    return _then(_$AttendanceTimedMeiboModelImpl(
      studentKihonId: freezed == studentKihonId
          ? _value.studentKihonId
          : studentKihonId // ignore: cast_nullable_to_non_nullable
              as int?,
      studentSeq: freezed == studentSeq
          ? _value.studentSeq
          : studentSeq // ignore: cast_nullable_to_non_nullable
              as String?,
      gakunen: freezed == gakunen
          ? _value.gakunen
          : gakunen // ignore: cast_nullable_to_non_nullable
              as String?,
      className: freezed == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      studentNumber: freezed == studentNumber
          ? _value.studentNumber
          : studentNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoImageFlg: freezed == photoImageFlg
          ? _value.photoImageFlg
          : photoImageFlg // ignore: cast_nullable_to_non_nullable
              as bool?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      genderCode: freezed == genderCode
          ? _value.genderCode
          : genderCode // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      jokyoList: freezed == jokyoList
          ? _value._jokyoList
          : jokyoList // ignore: cast_nullable_to_non_nullable
              as List<AttendanceTimedStatusModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 28, adapterName: 'AttendanceTimedMeiboModelAdapter')
class _$AttendanceTimedMeiboModelImpl implements _AttendanceTimedMeiboModel {
  const _$AttendanceTimedMeiboModelImpl(
      {@JsonKey(name: 'StudentKihonId', disallowNullValue: false)
      @HiveField(0)
      this.studentKihonId,
      @JsonKey(name: 'StudentSeq', disallowNullValue: false)
      @HiveField(1)
      this.studentSeq,
      @JsonKey(name: 'Gakunen', disallowNullValue: false)
      @HiveField(2)
      this.gakunen,
      @JsonKey(name: 'ClassName', disallowNullValue: false)
      @HiveField(3)
      this.className,
      @JsonKey(name: 'StudentNumber', disallowNullValue: false)
      @HiveField(4)
      this.studentNumber,
      @JsonKey(name: 'PhotoImageFlg', disallowNullValue: false)
      @HiveField(5)
      this.photoImageFlg,
      @JsonKey(name: 'Name', disallowNullValue: false) @HiveField(6) this.name,
      @JsonKey(name: 'GenderCode', disallowNullValue: false)
      @HiveField(7)
      this.genderCode,
      @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
      @HiveField(8)
      this.photoUrl,
      @JsonKey(name: 'JokyoList', disallowNullValue: false)
      @HiveField(9)
      final List<AttendanceTimedStatusModel>? jokyoList})
      : _jokyoList = jokyoList;

  factory _$AttendanceTimedMeiboModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceTimedMeiboModelImplFromJson(json);

  @override
  @JsonKey(name: 'StudentKihonId', disallowNullValue: false)
  @HiveField(0)
  final int? studentKihonId;
  @override
  @JsonKey(name: 'StudentSeq', disallowNullValue: false)
  @HiveField(1)
  final String? studentSeq;
  @override
  @JsonKey(name: 'Gakunen', disallowNullValue: false)
  @HiveField(2)
  final String? gakunen;
  @override
  @JsonKey(name: 'ClassName', disallowNullValue: false)
  @HiveField(3)
  final String? className;
  @override
  @JsonKey(name: 'StudentNumber', disallowNullValue: false)
  @HiveField(4)
  final String? studentNumber;
  @override
  @JsonKey(name: 'PhotoImageFlg', disallowNullValue: false)
  @HiveField(5)
  final bool? photoImageFlg;
  @override
  @JsonKey(name: 'Name', disallowNullValue: false)
  @HiveField(6)
  final String? name;
  @override
  @JsonKey(name: 'GenderCode', disallowNullValue: false)
  @HiveField(7)
  final String? genderCode;
  @override
  @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
  @HiveField(8)
  final String? photoUrl;
  final List<AttendanceTimedStatusModel>? _jokyoList;
  @override
  @JsonKey(name: 'JokyoList', disallowNullValue: false)
  @HiveField(9)
  List<AttendanceTimedStatusModel>? get jokyoList {
    final value = _jokyoList;
    if (value == null) return null;
    if (_jokyoList is EqualUnmodifiableListView) return _jokyoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceTimedMeiboModelImpl &&
            (identical(other.studentKihonId, studentKihonId) ||
                other.studentKihonId == studentKihonId) &&
            (identical(other.studentSeq, studentSeq) ||
                other.studentSeq == studentSeq) &&
            (identical(other.gakunen, gakunen) || other.gakunen == gakunen) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.studentNumber, studentNumber) ||
                other.studentNumber == studentNumber) &&
            (identical(other.photoImageFlg, photoImageFlg) ||
                other.photoImageFlg == photoImageFlg) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.genderCode, genderCode) ||
                other.genderCode == genderCode) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            const DeepCollectionEquality()
                .equals(other._jokyoList, _jokyoList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      studentKihonId,
      studentSeq,
      gakunen,
      className,
      studentNumber,
      photoImageFlg,
      name,
      genderCode,
      photoUrl,
      const DeepCollectionEquality().hash(_jokyoList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceTimedMeiboModelImplCopyWith<_$AttendanceTimedMeiboModelImpl>
      get copyWith => __$$AttendanceTimedMeiboModelImplCopyWithImpl<
          _$AttendanceTimedMeiboModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceTimedMeiboModelImplToJson(
      this,
    );
  }
}

abstract class _AttendanceTimedMeiboModel implements AttendanceTimedMeiboModel {
  const factory _AttendanceTimedMeiboModel(
          {@JsonKey(name: 'StudentKihonId', disallowNullValue: false)
          @HiveField(0)
          final int? studentKihonId,
          @JsonKey(name: 'StudentSeq', disallowNullValue: false)
          @HiveField(1)
          final String? studentSeq,
          @JsonKey(name: 'Gakunen', disallowNullValue: false)
          @HiveField(2)
          final String? gakunen,
          @JsonKey(name: 'ClassName', disallowNullValue: false)
          @HiveField(3)
          final String? className,
          @JsonKey(name: 'StudentNumber', disallowNullValue: false)
          @HiveField(4)
          final String? studentNumber,
          @JsonKey(name: 'PhotoImageFlg', disallowNullValue: false)
          @HiveField(5)
          final bool? photoImageFlg,
          @JsonKey(name: 'Name', disallowNullValue: false)
          @HiveField(6)
          final String? name,
          @JsonKey(name: 'GenderCode', disallowNullValue: false)
          @HiveField(7)
          final String? genderCode,
          @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
          @HiveField(8)
          final String? photoUrl,
          @JsonKey(name: 'JokyoList', disallowNullValue: false)
          @HiveField(9)
          final List<AttendanceTimedStatusModel>? jokyoList}) =
      _$AttendanceTimedMeiboModelImpl;

  factory _AttendanceTimedMeiboModel.fromJson(Map<String, dynamic> json) =
      _$AttendanceTimedMeiboModelImpl.fromJson;

  @override
  @JsonKey(name: 'StudentKihonId', disallowNullValue: false)
  @HiveField(0)
  int? get studentKihonId;
  @override
  @JsonKey(name: 'StudentSeq', disallowNullValue: false)
  @HiveField(1)
  String? get studentSeq;
  @override
  @JsonKey(name: 'Gakunen', disallowNullValue: false)
  @HiveField(2)
  String? get gakunen;
  @override
  @JsonKey(name: 'ClassName', disallowNullValue: false)
  @HiveField(3)
  String? get className;
  @override
  @JsonKey(name: 'StudentNumber', disallowNullValue: false)
  @HiveField(4)
  String? get studentNumber;
  @override
  @JsonKey(name: 'PhotoImageFlg', disallowNullValue: false)
  @HiveField(5)
  bool? get photoImageFlg;
  @override
  @JsonKey(name: 'Name', disallowNullValue: false)
  @HiveField(6)
  String? get name;
  @override
  @JsonKey(name: 'GenderCode', disallowNullValue: false)
  @HiveField(7)
  String? get genderCode;
  @override
  @JsonKey(name: 'PhotoUrl', disallowNullValue: false)
  @HiveField(8)
  String? get photoUrl;
  @override
  @JsonKey(name: 'JokyoList', disallowNullValue: false)
  @HiveField(9)
  List<AttendanceTimedStatusModel>? get jokyoList;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceTimedMeiboModelImplCopyWith<_$AttendanceTimedMeiboModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
