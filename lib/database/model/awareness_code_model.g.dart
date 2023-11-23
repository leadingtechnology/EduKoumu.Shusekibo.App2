// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'awareness_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AwarenessCodeModelImpl _$$AwarenessCodeModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AwarenessCodeModelImpl(
      id: json['Id'] as int?,
      code: json['Code'] as String?,
      name: json['Name'] as String?,
      shortName: json['ShortName'] as String?,
    );

Map<String, dynamic> _$$AwarenessCodeModelImplToJson(
        _$AwarenessCodeModelImpl instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Code': instance.code,
      'Name': instance.name,
      'ShortName': instance.shortName,
    };
