import 'dart:convert';

SearchCityResponse searchCityResponseFromJson(String str) => SearchCityResponse.fromJson(json.decode(str));


class SearchCityResponse {
  final bool? success;
  final String? message;
  final Data? data;
  final dynamic error;

  SearchCityResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory SearchCityResponse.fromJson(Map<String, dynamic> json) => SearchCityResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"],
  );

}

class Data {
  final List<SearchTowns>? items;

  Data({
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: json["items"] == null ? [] : List<SearchTowns>.from(json["items"]!.map((x) => SearchTowns.fromJson(x))),
  );

}

class SearchTowns {
  final int? cityId;
  final String? cityName;
  final String? stateName;
  final String? stateAbbreviation;
  final String? areaName;
  final String? path;
  final String? cityImage;
  final String? cityType;
  final String? cityFallbackImage;

  SearchTowns({
    this.cityId,
    this.cityName,
    this.stateName,
    this.stateAbbreviation,
    this.areaName,
    this.path,
    this.cityImage,
    this.cityType,
    this.cityFallbackImage,
  });

  factory SearchTowns.fromJson(Map<String, dynamic> json) => SearchTowns(
    cityId: json["city_id"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    stateAbbreviation: json["state_abbreviation"],
    areaName: json["area_name"],
    path: json["path"],
    cityImage: json["city_image"],
    cityType: json["city_type"],
    cityFallbackImage: json["city_fallback_image"],
  );

}
