import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:kyoumutechou/feature/health/model/health_status_model.dart';

part 'health_meibo_model.freezed.dart';
part 'health_meibo_model.g.dart';

List<HealthMeiboModel> healthMeiboListFromJson(List<dynamic> data) =>
    List<HealthMeiboModel>.from(data.map((x) => 
    HealthMeiboModel.fromJson(x as Map<String, dynamic>),),);

HealthMeiboModel healthMeiboFromJson(String str) => 
HealthMeiboModel.fromJson(json.decode(str) as Map<String, dynamic>);



@freezed
abstract class HealthMeiboModel with _$HealthMeiboModel {
  @HiveType(typeId: 8, adapterName: 'HealthMeiboModelAdapter')
  const factory HealthMeiboModel({

    @JsonKey(name: 'StudentKihonId', disallowNullValue: false) @HiveField(0) int? studentKihonId,
    @JsonKey(name: 'StudentSeq', disallowNullValue: false) @HiveField(1) String? studentSeq,
    @JsonKey(name: 'Gakunen', disallowNullValue: false) @HiveField(2) String? gakunen,
    @JsonKey(name: 'ClassName', disallowNullValue: false) @HiveField(3) String? className,
    @JsonKey(name: 'StudentNumber', disallowNullValue: false) @HiveField(4) String? studentNumber,
    @JsonKey(name: 'PhotoImageFlg', disallowNullValue: false) @HiveField(5) bool? photoImageFlg,
    @JsonKey(name: 'Name', disallowNullValue: false) @HiveField(6) String? name,
    @JsonKey(name: 'GenderCode', disallowNullValue: false) @HiveField(7) String? genderCode,
    @JsonKey(name: 'PhotoUrl', disallowNullValue: false) @HiveField(8) String? photoUrl,
    @JsonKey(name: 'TenshutsuYoteiFlg', disallowNullValue: false) @HiveField(9) bool? tenshutsuYoteiFlg,
    @JsonKey(name: 'TenshutsuSumiFlg',  disallowNullValue: false) @HiveField(10) bool? tenshutsuSumiFlg,
    @JsonKey(name: 'JokyoList', disallowNullValue: false) @HiveField(11) List<HealthStatusModel>? jokyoList,
  }) = _HealthMeiboModel;

  @override
  String toString() {
    return 'HealthMeiboModel($studentKihonId, $studentSeq, $gakunen, $className, $studentNumber, $photoImageFlg, $name, $genderCode, $photoUrl, $tenshutsuYoteiFlg, $tenshutsuSumiFlg, $jokyoList)';
  }
  factory HealthMeiboModel.fromJson(Map<String, dynamic> json) => _$HealthMeiboModelFromJson(json);
}

extension NewJson on HealthMeiboModel {
  Map<String, dynamic> toNewJson() => {
        'SeitoSeq': studentSeq,
        'StudentKihonId': studentKihonId,
        'KenkoKansatsuModelList': jokyoList == null
            ? '[]'
            : jokyoList?.map((v) => v.toNewJson()).toList(),
      };
}
