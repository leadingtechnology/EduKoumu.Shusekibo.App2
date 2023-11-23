// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'awareness_meibo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AwarenessMeiboModelImpl _$$AwarenessMeiboModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AwarenessMeiboModelImpl(
      gakunen: json['Gakunen'] as String?,
      shozokuId: json['ShozokuId'] as int?,
      className: json['ClassName'] as String?,
      shussekiNo: json['ShussekiNo'] as String?,
      studentKihonId: json['StudentKihonId'] as int?,
      studentId: json['StudentId'] as int?,
      studentName: json['StudentName'] as String?,
      photoUrl: json['PhotoUrl'] as String?,
      genderCode: json['GenderCode'] as String?,
      kizukiCount: json['KizukiCount'] as int?,
      selectFlag: json['SelectFlag'] as bool?,
      changedFlag: json['ChangedFlag'] as bool?,
    );

Map<String, dynamic> _$$AwarenessMeiboModelImplToJson(
        _$AwarenessMeiboModelImpl instance) =>
    <String, dynamic>{
      'Gakunen': instance.gakunen,
      'ShozokuId': instance.shozokuId,
      'ClassName': instance.className,
      'ShussekiNo': instance.shussekiNo,
      'StudentKihonId': instance.studentKihonId,
      'StudentId': instance.studentId,
      'StudentName': instance.studentName,
      'PhotoUrl': instance.photoUrl,
      'GenderCode': instance.genderCode,
      'KizukiCount': instance.kizukiCount,
      'SelectFlag': instance.selectFlag,
      'ChangedFlag': instance.changedFlag,
    };
