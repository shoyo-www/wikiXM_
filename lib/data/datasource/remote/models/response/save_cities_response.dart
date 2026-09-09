import 'dart:convert';

SaveCitiesResponse saveCitiesResponseFromJson(String str) => SaveCitiesResponse.fromJson(json.decode(str));

class SaveCitiesResponse {
  final bool? success;
  final String? message;
  final Data? data;
  final dynamic error;

  SaveCitiesResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory SaveCitiesResponse.fromJson(Map<String, dynamic> json) => SaveCitiesResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"],
  );

}

class Data {
  final String? navigateTo;

  Data({
    this.navigateTo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    navigateTo: json["navigateTo"],
  );

}
