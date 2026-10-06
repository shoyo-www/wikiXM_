import 'dart:convert';

MyGarageAiResponse myGarageAiResponseFromJson(String str) => MyGarageAiResponse.fromJson(json.decode(str));


class MyGarageAiResponse {
  final bool? success;
  final String? message;
  final AIGarageData? data;

  MyGarageAiResponse({
    this.success,
    this.message,
    this.data,
  });

  factory MyGarageAiResponse.fromJson(Map<String, dynamic> json) => MyGarageAiResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : AIGarageData.fromJson(json["data"]),
  );

}

class AIGarageData {
  final String? answer;
  final List<String>? insights;
  final List<String>? sellNow;
  final List<String>? prepare;
  final List<String>? review;
  final List<dynamic>? hold;
  final List<String>? tips;

  AIGarageData({
    this.answer,
    this.insights,
    this.sellNow,
    this.prepare,
    this.review,
    this.hold,
    this.tips,
  });

  factory AIGarageData.fromJson(Map<String, dynamic> json) => AIGarageData(
    answer: json["answer"],
    insights: json["insights"] == null ? [] : List<String>.from(json["insights"]!.map((x) => x)),
    sellNow: json["sell_now"] == null ? [] : List<String>.from(json["sell_now"]!.map((x) => x)),
    prepare: json["prepare"] == null ? [] : List<String>.from(json["prepare"]!.map((x) => x)),
    review: json["review"] == null ? [] : List<String>.from(json["review"]!.map((x) => x)),
    hold: json["hold"] == null ? [] : List<dynamic>.from(json["hold"]!.map((x) => x)),
    tips: json["tips"] == null ? [] : List<String>.from(json["tips"]!.map((x) => x)),
  );

}
