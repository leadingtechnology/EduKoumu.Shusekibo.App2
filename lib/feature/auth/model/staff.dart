import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff.freezed.dart';
part 'staff.g.dart';

Staff staffFromJson(String str) => Staff.fromJson(json.decode(str) as Map<String, dynamic>);
String staffToJson(Staff data) => json.encode(data.toJson());

@freezed
class Staff with _$Staff {
  const Staff._();
  const factory Staff({
    required String access_token,
    required String token_type,
    //required DateTime expires_in,
    required String TenantId,
    required String LoginId,
    required String DantaiId,
    required String UserName,
    required String KihonId,
    required String UserId,
    required String DantaiList,
  }) = _Staff;

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);
}
