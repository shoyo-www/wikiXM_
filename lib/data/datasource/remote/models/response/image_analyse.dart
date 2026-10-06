import 'dart:convert';

ImageAnalyseResponse imageAnalyseResponseFromJson(String str) => ImageAnalyseResponse.fromJson(json.decode(str));


class ImageAnalyseResponse {
  final bool? success;
  final String? message;
  final AnalyseData? data;

  ImageAnalyseResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ImageAnalyseResponse.fromJson(Map<String, dynamic> json) => ImageAnalyseResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : AnalyseData.fromJson(json["data"]),
  );
}

class AnalyseData {
  final String? title;
  final String? category;
  final String? subcategory;
  final String? brand;
  final dynamic model;
  final dynamic year;
  final dynamic condition;
  final String? color;
  final String? description;
  final List<String>? attributes;
  final Confidence? confidence;
  final dynamic originalPrice;
  final dynamic recommendedPrice;
  final List<Question>? questions;
  final int? categoryId;
  final int? subcategoryId;
  final String? priceReasoning;

  AnalyseData({
    this.title,
    this.category,
    this.subcategory,
    this.brand,
    this.model,
    this.year,
    this.condition,
    this.color,
    this.description,
    this.attributes,
    this.confidence,
    this.originalPrice,
    this.recommendedPrice,
    this.questions,
    this.categoryId,
    this.subcategoryId,
    this.priceReasoning,
  });

  factory AnalyseData.fromJson(Map<String, dynamic> json) => AnalyseData(
    title: json["title"],
    category: json["category"],
    subcategory: json["subcategory"],
    brand: json["brand"],
    model: json["model"],
    year: json["year"],
    condition: json["condition"],
    color: json["color"],
    description: json["description"],
    attributes: json["attributes"] == null ? [] : List<String>.from(json["attributes"]!.map((x) => x)),
    confidence: json["confidence"] == null ? null : Confidence.fromJson(json["confidence"]),
    originalPrice: json["original_price"],
    recommendedPrice: json["recommended_price"],
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    priceReasoning: json["price_reasoning"],
  );
}

class Confidence {
  final double? overall;
  final double? category;
  final double? brand;
  final double? model;
  final double? year;
  final double? condition;

  Confidence({
    this.overall,
    this.category,
    this.brand,
    this.model,
    this.year,
    this.condition,
  });

  factory Confidence.fromJson(Map<String, dynamic> json) => Confidence(
    overall: json["overall"]?.toDouble(),
    category: json["category"]?.toDouble(),
    brand: json["brand"]?.toDouble(),
    model: json["model"]?.toDouble(),
    year: json["year"]?.toDouble(),
    condition: json["condition"]?.toDouble(),
  );
}

class Question {
  final String? key;
  final String? label;
  final String? placeholder;

  Question({
    this.key,
    this.label,
    this.placeholder,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    key: json["key"],
    label: json["label"],
    placeholder: json["placeholder"],
  );
}
