import 'dart:convert';

SearchTownResponse searchTownResponseFromJson(String str) => SearchTownResponse.fromJson(json.decode(str));

class SearchTownResponse {
  final int? code;
  final bool? success;
  final String? message;
  final Body? body;

  SearchTownResponse({
    this.code,
    this.success,
    this.message,
    this.body,
  });

  factory SearchTownResponse.fromJson(Map<String, dynamic> json) => SearchTownResponse(
    code: json["code"],
    success: json["success"],
    message: json["message"],
    body: json["body"] == null ? null : Body.fromJson(json["body"]),
  );

}

class Body {
  final List<Town>? towns;
  final int? limit;

  Body({
    this.towns,
    this.limit,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    towns: json["towns"] == null ? [] : List<Town>.from(json["towns"]!.map((x) => Town.fromJson(x))),
    limit: json["limit"],
  );

}

class Town {
  final int? cityId;
  final String? cityName;
  final String? stateName;
  final String? stateAbbreviation;
  final String? areaName;

  Town({
    this.cityId,
    this.cityName,
    this.stateName,
    this.stateAbbreviation,
    this.areaName,
  });

  factory Town.fromJson(Map<String, dynamic> json) => Town(
    cityId: json["city_id"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    stateAbbreviation: json["state_abbreviation"],
    areaName: json["area_name"],
  );

}
