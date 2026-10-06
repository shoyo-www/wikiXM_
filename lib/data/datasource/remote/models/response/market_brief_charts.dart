
import 'dart:convert';

MarketBriefChartsResponse marketBriefChartsResponseFromJson(String str) => MarketBriefChartsResponse.fromJson(json.decode(str));


class MarketBriefChartsResponse {
  final bool? success;
  final String? message;
  final BriefChartsData? data;

  MarketBriefChartsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory MarketBriefChartsResponse.fromJson(Map<String, dynamic> json) => MarketBriefChartsResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : BriefChartsData.fromJson(json["data"]),
  );

}

class BriefChartsData {
  final int? months;
  final List<Point>? points;

  BriefChartsData({
    this.months,
    this.points,
  });

  factory BriefChartsData.fromJson(Map<String, dynamic> json) => BriefChartsData(
    months: json["months"],
    points: json["points"] == null ? [] : List<Point>.from(json["points"]!.map((x) => Point.fromJson(x))),
  );

}

class Point {
  final String? month;
  final int? pointNew;
  final int? sold;
  final double? averagePrice;

  Point({
    this.month,
    this.pointNew,
    this.sold,
    this.averagePrice,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
    month: json["month"],
    pointNew: json["new"],
    sold: json["sold"],
    averagePrice: json["average_price"]?.toDouble(),
  );

}
