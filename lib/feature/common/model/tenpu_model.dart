import 'dart:convert';
import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'tenpu_model.freezed.dart';
part 'tenpu_model.g.dart';

List<TenpuModel> tenpuListFromJson(List<dynamic> data) =>
    List<TenpuModel>.from(data.map(
      (x) => TenpuModel.fromJson(x  as Map<String, dynamic>),),
    );

TenpuModel tenpuFromJson(String str) => TenpuModel.fromJson(
  json.decode(str) as Map<String, dynamic>,
);

@freezed
abstract class TenpuModel with _$TenpuModel {
  @HiveType(typeId: 44, adapterName: 'TenpuModelAdapter')
  const factory TenpuModel({

    @JsonKey(name: 'TenpuId', disallowNullValue: false) @HiveField(0) int? tenpuId,
    @JsonKey(name: 'TenpuFileName', disallowNullValue: false) @HiveField(1) String? tenpuFileName,
    @JsonKey(name: 'TenpuFileSize', disallowNullValue: false) @HiveField(2) int? tenpuFileSize,
    @JsonKey(
      name: 'TenpuFileData', 
      disallowNullValue: false,) @Uint8ListConverter() @HiveField(3) Uint8List? tenpuFileData,
  }) = _TenpuModel;

  @override
  String toString() {
    return 'TenpuModel($tenpuId, $tenpuFileName, $tenpuFileSize, $tenpuFileData)';
  }
  factory TenpuModel.fromJson(Map<String, dynamic> json) => _$TenpuModelFromJson(json);
}


class Uint8ListConverter implements JsonConverter<Uint8List?, List<int>?> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(json) {
    return json == null ? null : base64.decode(json as String);
  }

  @override
  List<int>? toJson(Uint8List? object) {
    return object?.toList();
  }
}
