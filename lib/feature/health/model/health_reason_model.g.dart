// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_reason_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthReasonModelImpl _$$HealthReasonModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthReasonModelImpl(
      jokyoCd: json['JokyoCd'] as String?,
      jiyuCd: json['JiyuCd'] as String?,
      jiyuNmSeishiki: json['JiyuNmSeishiki'] as String?,
      jiyuNmRyaku: json['JiyuNmRyaku'] as String?,
      kenkoFlg: json['KenkoFlg'] as bool?,
      delFlg: json['DelFlg'] as bool?,
    );

Map<String, dynamic> _$$HealthReasonModelImplToJson(
        _$HealthReasonModelImpl instance) =>
    <String, dynamic>{
      'JokyoCd': instance.jokyoCd,
      'JiyuCd': instance.jiyuCd,
      'JiyuNmSeishiki': instance.jiyuNmSeishiki,
      'JiyuNmRyaku': instance.jiyuNmRyaku,
      'KenkoFlg': instance.kenkoFlg,
      'DelFlg': instance.delFlg,
    };
