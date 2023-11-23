import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'staff_model.freezed.dart';
part 'staff_model.g.dart';

List<StaffModel> staffListFromJson(List<dynamic> data) =>
    List<StaffModel>.from(data.map((x) => 
    StaffModel.fromJson(x as Map<String, dynamic>),),);

StaffModel staffFromJson(String str) => 
StaffModel.fromJson(json.decode(str) as Map<String, dynamic>);



@freezed
abstract class StaffModel with _$StaffModel {
  @HiveType(typeId: 1, adapterName: 'StaffModelAdapter')
  const factory StaffModel({

    @JsonKey(name: 'access_token', disallowNullValue: false) @HiveField(0) String? accessToken,
    @JsonKey(name: 'token_type', disallowNullValue: false) @HiveField(1) String? tokenType,
    @JsonKey(name: 'expires_in', disallowNullValue: false) @HiveField(2) String? expiresIn,
    @JsonKey(name: 'TenantId', disallowNullValue: false) @HiveField(3) String? tenantId,
    @JsonKey(name: 'LoginId', disallowNullValue: false) @HiveField(4) String? loginId,
    @JsonKey(name: 'Dantai', disallowNullValue: false) @HiveField(5) String? dantai,
    @JsonKey(name: 'UserName', disallowNullValue: false) @HiveField(6) String? userName,
  }) = _StaffModel;

  @override
  String toString() {
    return 'StaffModel($accessToken, $tokenType, $expiresIn, $tenantId, $loginId, $dantai, $userName)';
  }
  factory StaffModel.fromJson(Map<String, dynamic> json) => _$StaffModelFromJson(json);
}
