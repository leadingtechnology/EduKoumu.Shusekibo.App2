// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffImpl _$$StaffImplFromJson(Map<String, dynamic> json) => _$StaffImpl(
      access_token: json['access_token'] as String,
      token_type: json['token_type'] as String,
      TenantId: json['TenantId'] as String,
      LoginId: json['LoginId'] as String,
      DantaiId: json['DantaiId'] as String,
      Dantai: json['Dantai'] as String,
      UserName: json['UserName'] as String,
      KihonId: json['KihonId'] as String,
    );

Map<String, dynamic> _$$StaffImplToJson(_$StaffImpl instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'TenantId': instance.TenantId,
      'LoginId': instance.LoginId,
      'DantaiId': instance.DantaiId,
      'Dantai': instance.Dantai,
      'UserName': instance.UserName,
      'KihonId': instance.KihonId,
    };
