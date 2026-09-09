import 'dart:convert';

ResendResponse resendResponseFromJson(String str) => ResendResponse.fromJson(json.decode(str));

class ResendResponse {
  final bool? success;
  final String? message;
  final dynamic data;
  final dynamic error;

  ResendResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory ResendResponse.fromJson(Map<String, dynamic> json) => ResendResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"],
    error: json["error"],
  );
}
