// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthStatusModelImpl _$$HealthStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthStatusModelImpl(
      kokyoDate:
          json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
      jokyoCode: json['JokyoCode'] as String?,
      ryaku: json['Ryaku'] as String?,
      jiyu1Code: json['Jiyu1Code'] as String?,
      jiyu1: json['Jiyu1'] as String?,
      jiyu2: json['Jiyu2'] as String?,
      isEditable: json['IsEditable'] as bool?,
    );

Map<String, dynamic> _$$HealthStatusModelImplToJson(
        _$HealthStatusModelImpl instance) =>
    <String, dynamic>{
      'Date': instance.kokyoDate?.toIso8601String(),
      'JokyoCode': instance.jokyoCode,
      'Ryaku': instance.ryaku,
      'Jiyu1Code': instance.jiyu1Code,
      'Jiyu1': instance.jiyu1,
      'Jiyu2': instance.jiyu2,
      'IsEditable': instance.isEditable,
    };
