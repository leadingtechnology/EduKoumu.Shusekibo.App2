// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_timed_meibo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceTimedMeiboModelImpl _$$AttendanceTimedMeiboModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceTimedMeiboModelImpl(
      studentKihonId: json['StudentKihonId'] as int?,
      studentSeq: json['StudentSeq'] as String?,
      gakunen: json['Gakunen'] as String?,
      className: json['ClassName'] as String?,
      studentNumber: json['StudentNumber'] as String?,
      photoImageFlg: json['PhotoImageFlg'] as bool?,
      name: json['Name'] as String?,
      genderCode: json['GenderCode'] as String?,
      photoUrl: json['PhotoUrl'] as String?,
      jokyoList: (json['JokyoList'] as List<dynamic>?)
          ?.map((e) =>
              AttendanceTimedStatusModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AttendanceTimedMeiboModelImplToJson(
        _$AttendanceTimedMeiboModelImpl instance) =>
    <String, dynamic>{
      'StudentKihonId': instance.studentKihonId,
      'StudentSeq': instance.studentSeq,
      'Gakunen': instance.gakunen,
      'ClassName': instance.className,
      'StudentNumber': instance.studentNumber,
      'PhotoImageFlg': instance.photoImageFlg,
      'Name': instance.name,
      'GenderCode': instance.genderCode,
      'PhotoUrl': instance.photoUrl,
      'JokyoList': instance.jokyoList,
    };
