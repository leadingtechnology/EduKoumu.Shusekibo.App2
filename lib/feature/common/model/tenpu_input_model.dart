import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'tenpu_input_model.freezed.dart';
part 'tenpu_input_model.g.dart';

List<TenpuInputModel> tenpuInputListFromJson(List<dynamic> data) =>
    List<TenpuInputModel>.from(data.map(
      (x) => TenpuInputModel.fromJson(x  as Map<String, dynamic>),),
    );

TenpuInputModel tenpuInputFromJson(String str) => TenpuInputModel.fromJson(
  json.decode(str) as Map<String, dynamic>,
);

@freezed
abstract class TenpuInputModel with _$TenpuInputModel {
  @HiveType(typeId: 95, adapterName: 'TenpuInputModelAdapter')
  const factory TenpuInputModel({

    @JsonKey(name: 'TenpuId', disallowNullValue: false) @HiveField(0) int? tenpuId,
    @JsonKey(name: 'TenpuFileName', disallowNullValue: false) @HiveField(1) String? tenpuFileName,
    @JsonKey(name: 'TenpuFileSize', disallowNullValue: false) @HiveField(2) int? tenpuFileSize,
    @JsonKey(name: 'TenpuFileData', disallowNullValue: false,) @HiveField(3) String? tenpuFileData,
  }) = _TenpuInputModel;

  @override
  String toString() {
    return 'TenpuInputModel($tenpuId, $tenpuFileName, $tenpuFileSize, $tenpuFileData)';
  }
  factory TenpuInputModel.fromJson(Map<String, dynamic> json) => _$TenpuInputModelFromJson(json);
}
