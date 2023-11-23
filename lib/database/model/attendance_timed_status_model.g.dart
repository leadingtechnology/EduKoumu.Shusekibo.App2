// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_timed_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceTimedStatusModelImpl _$$AttendanceTimedStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceTimedStatusModelImpl(
      jokyoDate:
          json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
      jigenIdx: json['JigenIdx'] as int?,
      ryaku: json['Ryaku'] as String?,
      shukketsuBunrui: json['ShukketsuBunrui'] as String?,
      shukketsuKbn: json['ShukketsuKbn'] as String?,
      jiyu1: json['Jiyu1'] as String?,
      jiyu2: json['Jiyu2'] as String?,
      isEditable: json['IsEditable'] as bool?,
    );

Map<String, dynamic> _$$AttendanceTimedStatusModelImplToJson(
        _$AttendanceTimedStatusModelImpl instance) =>
    <String, dynamic>{
      'Date': instance.jokyoDate?.toIso8601String(),
      'JigenIdx': instance.jigenIdx,
      'Ryaku': instance.ryaku,
      'ShukketsuBunrui': instance.shukketsuBunrui,
      'ShukketsuKbn': instance.shukketsuKbn,
      'Jiyu1': instance.jiyu1,
      'Jiyu2': instance.jiyu2,
      'IsEditable': instance.isEditable,
    };
