
import 'dart:convert';

WeatherHeroResponse weatherHeroResponseFromJson(String str) => WeatherHeroResponse.fromJson(json.decode(str));


class WeatherHeroResponse {
  final bool? success;
  final String? message;
  final WeatherHeroData? data;

  WeatherHeroResponse({
    this.success,
    this.message,
    this.data,
  });

  factory WeatherHeroResponse.fromJson(Map<String, dynamic> json) => WeatherHeroResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : WeatherHeroData.fromJson(json["data"]),
  );

}

class WeatherHeroData {
  final City? city;
  final DateTime? updatedAt;
  final String? updatedLabel;
  final String? sceneId;
  final String? greeting;
  final String? daypart;
  final String? weatherType;
  final String? theme;
  final LocalTime? localTime;
  final AiSnapshot? aiSnapshot;
  final CurrentWeather? currentWeather;
  final Source? source;

  WeatherHeroData({
    this.city,
    this.updatedAt,
    this.updatedLabel,
    this.sceneId,
    this.greeting,
    this.daypart,
    this.weatherType,
    this.theme,
    this.localTime,
    this.aiSnapshot,
    this.currentWeather,
    this.source,
  });

  factory WeatherHeroData.fromJson(Map<String, dynamic> json) => WeatherHeroData(
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updatedLabel: json["updated_label"],
    sceneId: json["scene_id"],
    greeting: json["greeting"],
    daypart: json["daypart"],
    weatherType: json["weather_type"],
    theme: json["theme"],
    localTime: json["local_time"] == null ? null : LocalTime.fromJson(json["local_time"]),
    aiSnapshot: json["ai_snapshot"] == null ? null : AiSnapshot.fromJson(json["ai_snapshot"]),
    currentWeather: json["current_weather"] == null ? null : CurrentWeather.fromJson(json["current_weather"]),
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
  );

}

class AiSnapshot {
  final String? text;
  final String? source;
  final bool? isAiGenerated;

  AiSnapshot({
    this.text,
    this.source,
    this.isAiGenerated,
  });

  factory AiSnapshot.fromJson(Map<String, dynamic> json) => AiSnapshot(
    text: json["text"],
    source: json["source"],
    isAiGenerated: json["is_ai_generated"],
  );

}

class City {
  final int? id;
  final String? name;
  final String? state;
  final String? label;
  final double? latitude;
  final double? longitude;
  final String? cityImage;

  City({
    this.id,
    this.name,
    this.state,
    this.label,
    this.latitude,
    this.longitude,
    this.cityImage,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    state: json["state"],
    label: json["label"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    cityImage: json["city_image"],
  );

}

class CurrentWeather {
  final Period? period;
  final Temperature? temperature;
  final FeelsLike? feelsLike;
  final Condition? condition;
  final int? humidityPercent;
  final Wind? wind;
  final int? precipitationProbabilityPercent;

  CurrentWeather({
    this.period,
    this.temperature,
    this.feelsLike,
    this.condition,
    this.humidityPercent,
    this.wind,
    this.precipitationProbabilityPercent,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
    period: json["period"] == null ? null : Period.fromJson(json["period"]),
    temperature: json["temperature"] == null ? null : Temperature.fromJson(json["temperature"]),
    feelsLike: json["feels_like"] == null ? null : FeelsLike.fromJson(json["feels_like"]),
    condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
    humidityPercent: json["humidity_percent"],
    wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
    precipitationProbabilityPercent: json["precipitation_probability_percent"],
  );

}

class Condition {
  final String? label;
  final Icon? icon;

  Condition({
    this.label,
    this.icon,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    label: json["label"],
    icon: json["icon"] == null ? null : Icon.fromJson(json["icon"]),
  );
}

class Icon {
  final String? format;
  final String? symbol;
  final String? path;

  Icon({
    this.format,
    this.symbol,
    this.path,
  });

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
    format: json["format"],
    symbol: json["symbol"],
    path: json["path"],
  );

}

class FeelsLike {
  final int? value;
  final String? unit;
  final bool? calculated;

  FeelsLike({
    this.value,
    this.unit,
    this.calculated,
  });

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
    value: json["value"],
    unit: json["unit"],
    calculated: json["calculated"],
  );

}

class Period {
  final DateTime? startsAt;
  final DateTime? endsAt;
  final bool? isDaytime;

  Period({
    this.startsAt,
    this.endsAt,
    this.isDaytime,
  });

  factory Period.fromJson(Map<String, dynamic> json) => Period(
    startsAt: json["starts_at"] == null ? null : DateTime.parse(json["starts_at"]),
    endsAt: json["ends_at"] == null ? null : DateTime.parse(json["ends_at"]),
    isDaytime: json["is_daytime"],
  );

}

class Temperature {
  final int? value;
  final String? unit;

  Temperature({
    this.value,
    this.unit,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
    value: json["value"],
    unit: json["unit"],
  );

}

class Wind {
  final int? minimum;
  final int? maximum;
  final String? unit;
  final String? raw;
  final String? direction;

  Wind({
    this.minimum,
    this.maximum,
    this.unit,
    this.raw,
    this.direction,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    minimum: json["minimum"],
    maximum: json["maximum"],
    unit: json["unit"],
    raw: json["raw"],
    direction: json["direction"],
  );

}

class LocalTime {
  final String? timezone;
  final DateTime? iso;
  final String? time;
  final String? abbreviation;

  LocalTime({
    this.timezone,
    this.iso,
    this.time,
    this.abbreviation,
  });

  factory LocalTime.fromJson(Map<String, dynamic> json) => LocalTime(
    timezone: json["timezone"],
    iso: json["iso"] == null ? null : DateTime.parse(json["iso"]),
    time: json["time"],
    abbreviation: json["abbreviation"],
  );

}

class Source {
  final String? provider;
  final String? office;

  Source({
    this.provider,
    this.office,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    provider: json["provider"],
    office: json["office"],
  );

}
