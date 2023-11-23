// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffModelImpl _$$StaffModelImplFromJson(Map<String, dynamic> json) =>
    _$StaffModelImpl(
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      expiresIn: json['expires_in'] as String?,
      tenantId: json['TenantId'] as String?,
      loginId: json['LoginId'] as String?,
      dantai: json['Dantai'] as String?,
      userName: json['UserName'] as String?,
    );

Map<String, dynamic> _$$StaffModelImplToJson(_$StaffModelImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'TenantId': instance.tenantId,
      'LoginId': instance.loginId,
      'Dantai': instance.dantai,
      'UserName': instance.userName,
    };
