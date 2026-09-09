import 'dart:convert';

String verifyOtpRequestToJson(VerifyOtpRequest data) => json.encode(data.toJson());

class VerifyOtpRequest {
  String identifier;
  String type;
  String purpose;
  String otp;

  VerifyOtpRequest({
    required this.identifier,
    required this.type,
    required this.purpose,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "type": type,
    "purpose": purpose,
    "otp": otp,
  };
}