import 'dart:convert';

CommonResponse commonResponseFromJson(String str) => CommonResponse.fromJson(json.decode(str));

class CommonResponse {
  final bool? success;
  final String? message;
  final List<dynamic>? data;

  CommonResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );
}
