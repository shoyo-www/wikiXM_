import 'dart:convert';

String resendOtpRequestToJson(ResendOtpRequest data) => json.encode(data.toJson());

class ResendOtpRequest {
  String identifier;
  String type;
  String purpose;

  ResendOtpRequest({
    required this.identifier,
    required this.type,
    required this.purpose,
  });

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "type": type,
    "purpose": purpose,
  };
}