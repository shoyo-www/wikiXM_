import 'dart:convert';

MarketAiBriefResponse marketAiBriefResponseFromJson(String str) => MarketAiBriefResponse.fromJson(json.decode(str));

class MarketAiBriefResponse {
  final bool? success;
  final String? message;
  final MarketAiBrief? data;

  MarketAiBriefResponse({
    this.success,
    this.message,
    this.data,
  });

  factory MarketAiBriefResponse.fromJson(Map<String, dynamic> json) => MarketAiBriefResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : MarketAiBrief.fromJson(json["data"]),
  );

}

class MarketAiBrief {
  final List<dynamic>? hold;
  final List<dynamic>? tips;
  final String? answer;
  final List<dynamic>? review;
  final String? source;
  final List<dynamic>? prepare;
  final List<String>? insights;
  final List<dynamic>? sellNow;
  final DateTime? updatedAt;

  MarketAiBrief({
    this.hold,
    this.tips,
    this.answer,
    this.review,
    this.source,
    this.prepare,
    this.insights,
    this.sellNow,
    this.updatedAt,
  });

  factory MarketAiBrief.fromJson(Map<String, dynamic> json) => MarketAiBrief(
    hold: json["hold"] == null ? [] : List<dynamic>.from(json["hold"]!.map((x) => x)),
    tips: json["tips"] == null ? [] : List<dynamic>.from(json["tips"]!.map((x) => x)),
    answer: json["answer"],
    review: json["review"] == null ? [] : List<dynamic>.from(json["review"]!.map((x) => x)),
    source: json["source"],
    prepare: json["prepare"] == null ? [] : List<dynamic>.from(json["prepare"]!.map((x) => x)),
    insights: json["insights"] == null ? [] : List<String>.from(json["insights"]!.map((x) => x)),
    sellNow: json["sell_now"] == null ? [] : List<dynamic>.from(json["sell_now"]!.map((x) => x)),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

}
