// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeAttendanceModelImpl _$$HomeAttendanceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeAttendanceModelImpl(
      className: json['ClassName'] as String?,
      zaiseki: json['Zaiseki'] as int?,
      shusseki: json['Shusseki'] as int?,
      tikoku: json['Tikoku'] as int?,
      sotai: json['Sotai'] as int?,
      kessekiShuttei: json['KessekiShuttei'] as int?,
      influenza: json['Influenza'] as int?,
      doneAttendanceFlg: json['DoneAttendanceFlg'] as bool?,
    );

Map<String, dynamic> _$$HomeAttendanceModelImplToJson(
        _$HomeAttendanceModelImpl instance) =>
    <String, dynamic>{
      'ClassName': instance.className,
      'Zaiseki': instance.zaiseki,
      'Shusseki': instance.shusseki,
      'Tikoku': instance.tikoku,
      'Sotai': instance.sotai,
      'KessekiShuttei': instance.kessekiShuttei,
      'Influenza': instance.influenza,
      'DoneAttendanceFlg': instance.doneAttendanceFlg,
    };
