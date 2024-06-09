// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_meibo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceMeiboModel _$AttendanceMeiboModelFromJson(Map<String, dynamic> json) {
  return _AttendanceMeiboModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceMeiboModel {
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
  @JsonKey(name: 'TenshutsuYoteiFlg', disallowNullValue: false)
  @HiveField(9)
  bool? get tenshutsuYoteiFlg => throw _privateConstructorUsedError;
  @JsonKey(name: 'TenshutsuSumiFlg', disallowNullValue: false)
  @HiveField(10)
  bool? get tenshutsuSumiFlg => throw _privateConstructorUsedError;
  @JsonKey(name: 'StudentTsushoName', disallowNullValue: false)
  @HiveField(11)
  String? get studentTsushoName => throw _privateConstructorUsedError;
  @JsonKey(name: 'JokyoList', disallowNullValue: false)
  @HiveField(12)
  List<AttendanceStatusModel>? get jokyoList =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceMeiboModelCopyWith<AttendanceMeiboModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceMeiboModelCopyWith<$Res> {
  factory $AttendanceMeiboModelCopyWith(AttendanceMeiboModel value,
          $Res Function(AttendanceMeiboModel) then) =
      _$AttendanceMeiboModelCopyWithImpl<$Res, AttendanceMeiboModel>;
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
      @JsonKey(name: 'TenshutsuYoteiFlg', disallowNullValue: false)
      @HiveField(9)
      bool? tenshutsuYoteiFlg,
      @JsonKey(name: 'TenshutsuSumiFlg', disallowNullValue: false)
      @HiveField(10)
      bool? tenshutsuSumiFlg,
      @JsonKey(name: 'StudentTsushoName', disallowNullValue: false)
      @HiveField(11)
      String? studentTsushoName,
      @JsonKey(name: 'JokyoList', disallowNullValue: false)
      @HiveField(12)
      List<AttendanceStatusModel>? jokyoList});
}

/// @nodoc
class _$AttendanceMeiboModelCopyWithImpl<$Res,
        $Val extends AttendanceMeiboModel>
    implements $AttendanceMeiboModelCopyWith<$Res> {
  _$AttendanceMeiboModelCopyWithImpl(this._value, this._then);

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
    Object? tenshutsuYoteiFlg = freezed,
    Object? tenshutsuSumiFlg = freezed,
    Object? studentTsushoName = freezed,
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
      tenshutsuYoteiFlg: freezed == tenshutsuYoteiFlg
          ? _value.tenshutsuYoteiFlg
          : tenshutsuYoteiFlg // ignore: cast_nullable_to_non_nullable
              as bool?,
      tenshutsuSumiFlg: freezed == tenshutsuSumiFlg
          ? _value.tenshutsuSumiFlg
          : tenshutsuSumiFlg // ignore: cast_nullable_to_non_nullable
              as bool?,
      studentTsushoName: freezed == studentTsushoName
          ? _value.studentTsushoName
          : studentTsushoName // ignore: cast_nullable_to_non_nullable
              as String?,
      jokyoList: freezed == jokyoList
          ? _value.jokyoList
          : jokyoList // ignore: cast_nullable_to_non_nullable
              as List<AttendanceStatusModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceMeiboModelImplCopyWith<$Res>
    implements $AttendanceMeiboModelCopyWith<$Res> {
  factory _$$AttendanceMeiboModelImplCopyWith(_$AttendanceMeiboModelImpl value,
          $Res Function(_$AttendanceMeiboModelImpl) then) =
      __$$AttendanceMeiboModelImplCopyWithImpl<$Res>;
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
      @JsonKey(name: 'TenshutsuYoteiFlg', disallowNullValue: false)
      @HiveField(9)
      bool? tenshutsuYoteiFlg,
      @JsonKey(name: 'TenshutsuSumiFlg', disallowNullValue: false)
      @HiveField(10)
      bool? tenshutsuSumiFlg,
      @JsonKey(name: 'StudentTsushoName', disallowNullValue: false)
      @HiveField(11)
      String? studentTsushoName,
      @JsonKey(name: 'JokyoList', disallowNullValue: false)
      @HiveField(12)
      List<AttendanceStatusModel>? jokyoList});
}

/// @nodoc
class __$$AttendanceMeiboModelImplCopyWithImpl<$Res>
    extends _$AttendanceMeiboModelCopyWithImpl<$Res, _$AttendanceMeiboModelImpl>
    implements _$$AttendanceMeiboModelImplCopyWith<$Res> {
  __$$AttendanceMeiboModelImplCopyWithImpl(_$AttendanceMeiboModelImpl _value,
      $Res Function(_$AttendanceMeiboModelImpl) _then)
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
    Object? tenshutsuYoteiFlg = freezed,
    Object? tenshutsuSumiFlg = freezed,
    Object? studentTsushoName = freezed,
    Object? jokyoList = freezed,
  }) {
    return _then(_$AttendanceMeiboModelImpl(
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
      tenshutsuYoteiFlg: freezed == tenshutsuYoteiFlg
          ? _value.tenshutsuYoteiFlg
          : tenshutsuYoteiFlg // ignore: cast_nullable_to_non_nullable
              as bool?,
      tenshutsuSumiFlg: freezed == tenshutsuSumiFlg
          ? _value.tenshutsuSumiFlg
          : tenshutsuSumiFlg // ignore: cast_nullable_to_non_nullable
              as bool?,
      studentTsushoName: freezed == studentTsushoName
          ? _value.studentTsushoName
          : studentTsushoName // ignore: cast_nullable_to_non_nullable
              as String?,
      jokyoList: freezed == jokyoList
          ? _value._jokyoList
          : jokyoList // ignore: cast_nullable_to_non_nullable
              as List<AttendanceStatusModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 18, adapterName: 'AttendanceMeiboModelAdapter')
class _$AttendanceMeiboModelImpl implements _AttendanceMeiboModel {
  const _$AttendanceMeiboModelImpl(
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
      @JsonKey(name: 'TenshutsuYoteiFlg', disallowNullValue: false)
      @HiveField(9)
      this.tenshutsuYoteiFlg,
      @JsonKey(name: 'TenshutsuSumiFlg', disallowNullValue: false)
      @HiveField(10)
      this.tenshutsuSumiFlg,
      @JsonKey(name: 'StudentTsushoName', disallowNullValue: false)
      @HiveField(11)
      this.studentTsushoName,
      @JsonKey(name: 'JokyoList', disallowNullValue: false)
      @HiveField(12)
      final List<AttendanceStatusModel>? jokyoList})
      : _jokyoList = jokyoList;

  factory _$AttendanceMeiboModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceMeiboModelImplFromJson(json);

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
  @override
  @JsonKey(name: 'TenshutsuYoteiFlg', disallowNullValue: false)
  @HiveField(9)
  final bool? tenshutsuYoteiFlg;
  @override
  @JsonKey(name: 'TenshutsuSumiFlg', disallowNullValue: false)
  @HiveField(10)
  final bool? tenshutsuSumiFlg;
  @override
  @JsonKey(name: 'StudentTsushoName', disallowNullValue: false)
  @HiveField(11)
  final String? studentTsushoName;
  final List<AttendanceStatusModel>? _jokyoList;
  @override
  @JsonKey(name: 'JokyoList', disallowNullValue: false)
  @HiveField(12)
  List<AttendanceStatusModel>? get jokyoList {
    final value = _jokyoList;
    if (value == null) return null;
    if (_jokyoList is EqualUnmodifiableListView) return _jokyoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceMeiboModelImpl &&
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
            (identical(other.tenshutsuYoteiFlg, tenshutsuYoteiFlg) ||
                other.tenshutsuYoteiFlg == tenshutsuYoteiFlg) &&
            (identical(other.tenshutsuSumiFlg, tenshutsuSumiFlg) ||
                other.tenshutsuSumiFlg == tenshutsuSumiFlg) &&
            (identical(other.studentTsushoName, studentTsushoName) ||
                other.studentTsushoName == studentTsushoName) &&
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
      tenshutsuYoteiFlg,
      tenshutsuSumiFlg,
      studentTsushoName,
      const DeepCollectionEquality().hash(_jokyoList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceMeiboModelImplCopyWith<_$AttendanceMeiboModelImpl>
      get copyWith =>
          __$$AttendanceMeiboModelImplCopyWithImpl<_$AttendanceMeiboModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceMeiboModelImplToJson(
      this,
    );
  }
}

abstract class _AttendanceMeiboModel implements AttendanceMeiboModel {
  const factory _AttendanceMeiboModel(
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
          @JsonKey(name: 'TenshutsuYoteiFlg', disallowNullValue: false)
          @HiveField(9)
          final bool? tenshutsuYoteiFlg,
          @JsonKey(name: 'TenshutsuSumiFlg', disallowNullValue: false)
          @HiveField(10)
          final bool? tenshutsuSumiFlg,
          @JsonKey(name: 'StudentTsushoName', disallowNullValue: false)
          @HiveField(11)
          final String? studentTsushoName,
          @JsonKey(name: 'JokyoList', disallowNullValue: false)
          @HiveField(12)
          final List<AttendanceStatusModel>? jokyoList}) =
      _$AttendanceMeiboModelImpl;

  factory _AttendanceMeiboModel.fromJson(Map<String, dynamic> json) =
      _$AttendanceMeiboModelImpl.fromJson;

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
  @JsonKey(name: 'TenshutsuYoteiFlg', disallowNullValue: false)
  @HiveField(9)
  bool? get tenshutsuYoteiFlg;
  @override
  @JsonKey(name: 'TenshutsuSumiFlg', disallowNullValue: false)
  @HiveField(10)
  bool? get tenshutsuSumiFlg;
  @override
  @JsonKey(name: 'StudentTsushoName', disallowNullValue: false)
  @HiveField(11)
  String? get studentTsushoName;
  @override
  @JsonKey(name: 'JokyoList', disallowNullValue: false)
  @HiveField(12)
  List<AttendanceStatusModel>? get jokyoList;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceMeiboModelImplCopyWith<_$AttendanceMeiboModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
