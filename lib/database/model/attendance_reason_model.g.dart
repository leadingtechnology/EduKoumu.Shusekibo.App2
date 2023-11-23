// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_reason_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceReasonModelImpl _$$AttendanceReasonModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceReasonModelImpl(
      shukketsuJokyoCd: json['ShukketsuJokyoCd'] as String?,
      shukketsuJiyuCd: json['ShukketsuJiyuCd'] as String?,
      hyoujijun: json['Hyoujijun'] as String?,
      shukketsuJiyuNmSeishiki: json['ShukketsuJiyuNmSeishiki'] as String?,
      shukketsuJiyuNmRyaku: json['ShukketsuJiyuNmRyaku'] as String?,
    );

Map<String, dynamic> _$$AttendanceReasonModelImplToJson(
        _$AttendanceReasonModelImpl instance) =>
    <String, dynamic>{
      'ShukketsuJokyoCd': instance.shukketsuJokyoCd,
      'ShukketsuJiyuCd': instance.shukketsuJiyuCd,
      'Hyoujijun': instance.hyoujijun,
      'ShukketsuJiyuNmSeishiki': instance.shukketsuJiyuNmSeishiki,
      'ShukketsuJiyuNmRyaku': instance.shukketsuJiyuNmRyaku,
    };
