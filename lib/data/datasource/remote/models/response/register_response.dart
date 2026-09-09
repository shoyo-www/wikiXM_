
import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));


class RegisterResponse {
  final bool? success;
  final String? message;
  final RegisterData? data;
  final dynamic error;

  RegisterResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : RegisterData.fromJson(json["data"]),
    error: json["error"],
  );

}

class RegisterData {
  final String? identifier;
  final String? type;
  final String? purpose;
  final String? registrationToken;
  final String? navigateTo;

  RegisterData({
    this.identifier,
    this.type,
    this.purpose,
    this.registrationToken,
    this.navigateTo,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
    identifier: json["identifier"],
    type: json["type"],
    purpose: json["purpose"],
    registrationToken: json["registration_token"],
    navigateTo: json["navigateTo"],
  );

}
