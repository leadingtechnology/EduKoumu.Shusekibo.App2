// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokobi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokobiModelImpl _$$TokobiModelImplFromJson(Map<String, dynamic> json) =>
    _$TokobiModelImpl(
      tokobi:
          json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
      yobiCd: json['YobiCd'] as String?,
      weekName: json['WeekName'] as String?,
      jigen: json['Jigen'] as int?,
      isToday: json['IsToday'] as bool?,
      isEditable: json['IsEditable'] as bool?,
      stampedCount: json['StampedCount'] as int?,
      totalCount: json['TotalCount'] as int?,
    );

Map<String, dynamic> _$$TokobiModelImplToJson(_$TokobiModelImpl instance) =>
    <String, dynamic>{
      'Date': instance.tokobi?.toIso8601String(),
      'YobiCd': instance.yobiCd,
      'WeekName': instance.weekName,
      'Jigen': instance.jigen,
      'IsToday': instance.isToday,
      'IsEditable': instance.isEditable,
      'StampedCount': instance.stampedCount,
      'TotalCount': instance.totalCount,
    };
