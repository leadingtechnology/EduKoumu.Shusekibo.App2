// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shozoku_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShozokuModelImpl _$$ShozokuModelImplFromJson(Map<String, dynamic> json) =>
    _$ShozokuModelImpl(
      organizationCode: json['OrganizationCode'] as String?,
      organizationId: json['OrganizationId'] as int?,
      nendo: json['Nendo'] as String?,
      gakunenCode: json['GakunenCode'] as String?,
      classId: json['ClassId'] as int?,
      classBunrui: json['ClassBunrui'] as String?,
      classKbn: json['ClassKbn'] as String?,
      classCode: json['ClassCode'] as String?,
      className: json['ClassName'] as String?,
      shozokuId: json['ShozokuId'] as int?,
      shozokuCode: json['ShozokuCode'] as String?,
      isGakuseki: json['IsGakuseki'] as bool?,
      isTokubetsuShien: json['IsTokubetsuShien'] as bool?,
      hyojijun: json['Hyojijun'] as int?,
      isTanninClass: json['IsTanninClass'] as bool?,
      isTantoClass: json['IsTantoClass'] as bool?,
      id: json['Id'] as int?,
      code: json['Code'] as String?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$$ShozokuModelImplToJson(_$ShozokuModelImpl instance) =>
    <String, dynamic>{
      'OrganizationCode': instance.organizationCode,
      'OrganizationId': instance.organizationId,
      'Nendo': instance.nendo,
      'GakunenCode': instance.gakunenCode,
      'ClassId': instance.classId,
      'ClassBunrui': instance.classBunrui,
      'ClassKbn': instance.classKbn,
      'ClassCode': instance.classCode,
      'ClassName': instance.className,
      'ShozokuId': instance.shozokuId,
      'ShozokuCode': instance.shozokuCode,
      'IsGakuseki': instance.isGakuseki,
      'IsTokubetsuShien': instance.isTokubetsuShien,
      'Hyojijun': instance.hyojijun,
      'IsTanninClass': instance.isTanninClass,
      'IsTantoClass': instance.isTantoClass,
      'Id': instance.id,
      'Code': instance.code,
      'Name': instance.name,
    };
