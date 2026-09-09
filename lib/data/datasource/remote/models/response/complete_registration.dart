import 'dart:convert';

CompleteRegistrationResponse completeRegistrationResponseFromJson(String str) => CompleteRegistrationResponse.fromJson(json.decode(str));


class CompleteRegistrationResponse {
  final bool? success;
  final String? message;
  final Data? data;
  final dynamic error;

  CompleteRegistrationResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory CompleteRegistrationResponse.fromJson(Map<String, dynamic> json) => CompleteRegistrationResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"],
  );

}

class Data {
  final String? token;
  final String? tokenType;
  final User? user;
  final String? navigateTo;

  Data({
    this.token,
    this.tokenType,
    this.user,
    this.navigateTo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    tokenType: json["token_type"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    navigateTo: json["navigateTo"],
  );

}

class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final int? primaryCityId;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.primaryCityId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    primaryCityId: json["primary_city_id"],
  );

}
