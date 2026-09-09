import 'dart:convert';

VerifyOtpResponse verifyOtpResponseFromJson(String str) => VerifyOtpResponse.fromJson(json.decode(str));

class VerifyOtpResponse {
  final bool? success;
  final String? message;
  final Data? data;
  final dynamic error;

  VerifyOtpResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) => VerifyOtpResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"],
  );

}

class Data {
  final String? identifier;
  final String? type;
  final String? purpose;
  final String? registrationToken;
  final String? navigateTo;

  Data({
    this.identifier,
    this.type,
    this.purpose,
    this.registrationToken,
    this.navigateTo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    identifier: json["identifier"],
    type: json["type"],
    purpose: json["purpose"],
    registrationToken: json["registration_token"],
    navigateTo: json["navigateTo"],
  );

}
