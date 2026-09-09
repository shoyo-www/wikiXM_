

import 'dart:convert';

WeatherAlertsResponse weatherAlertsResponseFromJson(String str) => WeatherAlertsResponse.fromJson(json.decode(str));

String weatherAlertsResponseToJson(WeatherAlertsResponse data) => json.encode(data.toJson());

class WeatherAlertsResponse {
  final bool? success;
  final dynamic message;
  final WeatherData? data;

  WeatherAlertsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory WeatherAlertsResponse.fromJson(Map<String, dynamic> json) => WeatherAlertsResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : WeatherData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class WeatherData {
  final Weather? weather;
  final List<Alert>? alerts;

  WeatherData({
    this.weather,
    this.alerts,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
    weather: json["weather"] == null ? null : Weather.fromJson(json["weather"]),
    alerts: json["alerts"] == null ? [] : List<Alert>.from(json["alerts"]!.map((x) => Alert.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "weather": weather?.toJson(),
    "alerts": alerts == null ? [] : List<dynamic>.from(alerts!.map((x) => x.toJson())),
  };
}

class Alert {
  final String? title;
  final String? icon;
  final String? url;
  final String? category;
  final String? time;
  final String? shortTitle;

  Alert({
    this.title,
    this.icon,
    this.url,
    this.category,
    this.time,
    this.shortTitle,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    title: json["title"],
    icon: json["icon"],
    url: json["url"],
    category: json["category"],
    time: json["time"],
    shortTitle: json["short_title"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "icon": icon,
    "url": url,
    "category": category,
    "time": time,
    "short_title": shortTitle,
  };
}

class Weather {
  final int? temperatureCelsius;
  final String? temperatureText;
  final String? condition;
  final String? icon;
  final int? high;
  final String? highText;
  final int? low;
  final String? lowText;
  final String? summary;

  Weather({
    this.temperatureCelsius,
    this.temperatureText,
    this.condition,
    this.icon,
    this.high,
    this.highText,
    this.low,
    this.lowText,
    this.summary,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    temperatureCelsius: json["temperature_celsius"],
    temperatureText: json["temperature_text"],
    condition: json["condition"],
    icon: json["icon"],
    high: json["high"],
    highText: json["high_text"],
    low: json["low"],
    lowText: json["low_text"],
    summary: json["summary"],
  );

  Map<String, dynamic> toJson() => {
    "temperature_celsius": temperatureCelsius,
    "temperature_text": temperatureText,
    "condition": condition,
    "icon": icon,
    "high": high,
    "high_text": highText,
    "low": low,
    "low_text": lowText,
    "summary": summary,
  };
}
