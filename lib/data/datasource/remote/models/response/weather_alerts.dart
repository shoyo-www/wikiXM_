import 'dart:convert';

WeatherAlertsResponse weatherAlertsResponseFromJson(String str) => WeatherAlertsResponse.fromJson(json.decode(str));

class WeatherAlertsResponse {
  final bool? success;
  final String? message;
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

}

class WeatherData {
  final Weather? weather;
  final int? activeAlerts;
  final List<Alert>? alerts;

  WeatherData({
    this.weather,
    this.activeAlerts,
    this.alerts,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
    weather: json["weather"] == null ? null : Weather.fromJson(json["weather"]),
    activeAlerts: json["active_alerts"],
    alerts: json["alerts"] == null ? [] : List<Alert>.from(json["alerts"]!.map((x) => Alert.fromJson(x))),
  );

}

class Alert {
  final String? title;
  final String? icon;
  final String? url;
  final String? category;
  final String? time;

  Alert({
    this.title,
    this.icon,
    this.url,
    this.category,
    this.time,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    title: json["title"],
    icon: json["icon"],
    url: json["url"],
    category: json["category"],
    time: json["time"],
  );

}




class Weather {
  final int? temperatureCelsius;
  final String? temperatureText;
  final String? condition;
  final String? icon;

  Weather({
    this.temperatureCelsius,
    this.temperatureText,
    this.condition,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    temperatureCelsius: json["temperature_celsius"],
    temperatureText: json["temperature_text"],
    condition: json["condition"],
    icon: json["icon"],
  );

}

