import 'dart:convert';

MyGroupSettingsResponse myGroupSettingsResponseFromJson(String str) => MyGroupSettingsResponse.fromJson(json.decode(str));

class MyGroupSettingsResponse {
  final bool? success;
  final String? message;
  final bool? recommendations;

  MyGroupSettingsResponse({
    this.success,
    this.message,
    this.recommendations,
  });

  factory MyGroupSettingsResponse.fromJson(Map<String, dynamic> json) => MyGroupSettingsResponse(
    success: json["success"],
    message: json["message"],
    recommendations: json["data"] is Map ? json["data"]["recommendations"] : null,
  );
}
