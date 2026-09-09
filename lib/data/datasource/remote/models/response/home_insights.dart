// To parse this JSON data, do
//
//     final homeInsightsResponse = homeInsightsResponseFromJson(jsonString);

import 'dart:convert';

HomeInsightsResponse homeInsightsResponseFromJson(String str) => HomeInsightsResponse.fromJson(json.decode(str));

String homeInsightsResponseToJson(HomeInsightsResponse data) => json.encode(data.toJson());

class HomeInsightsResponse {
  final bool? success;
  final dynamic message;
  final HomeInsights? data;

  HomeInsightsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory HomeInsightsResponse.fromJson(Map<String, dynamic> json) => HomeInsightsResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : HomeInsights.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class HomeInsights {
  final TownMemory? townMemory;
  final List<SHighlight>? newsHighlights;
  final TopContributors? topContributors;
  final List<SHighlight>? sportsHighlights;
  final Newsletter? newsletter;

  HomeInsights({
    this.townMemory,
    this.newsHighlights,
    this.topContributors,
    this.sportsHighlights,
    this.newsletter,
  });

  factory HomeInsights.fromJson(Map<String, dynamic> json) => HomeInsights(
    townMemory: json["town_memory"] == null ? null : TownMemory.fromJson(json["town_memory"]),
    newsHighlights: json["news_highlights"] == null ? [] : List<SHighlight>.from(json["news_highlights"]!.map((x) => SHighlight.fromJson(x))),
    topContributors: json["top_contributors"] == null ? null : TopContributors.fromJson(json["top_contributors"]),
    sportsHighlights: json["sports_highlights"] == null ? [] : List<SHighlight>.from(json["sports_highlights"]!.map((x) => SHighlight.fromJson(x))),
    newsletter: json["newsletter"] == null ? null : Newsletter.fromJson(json["newsletter"]),
  );

  Map<String, dynamic> toJson() => {
    "town_memory": townMemory?.toJson(),
    "news_highlights": newsHighlights == null ? [] : List<dynamic>.from(newsHighlights!.map((x) => x.toJson())),
    "top_contributors": topContributors?.toJson(),
    "sports_highlights": sportsHighlights == null ? [] : List<dynamic>.from(sportsHighlights!.map((x) => x.toJson())),
    "newsletter": newsletter?.toJson(),
  };
}

class SHighlight {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final String? categoryTitle;
  final String? homeUrl;
  final String? categoryUrl;
  final String? reporterName;
  final String? profileImage;
  final int? totalComments;
  final int? totalViews;
  final int? totalLikes;
  final dynamic formattedPublishedDate;
  final String? location;

  SHighlight({
    this.id,
    this.title,
    this.description,
    this.image,
    this.categoryTitle,
    this.homeUrl,
    this.categoryUrl,
    this.reporterName,
    this.profileImage,
    this.totalComments,
    this.totalViews,
    this.totalLikes,
    this.formattedPublishedDate,
    this.location,
  });

  factory SHighlight.fromJson(Map<String, dynamic> json) => SHighlight(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    categoryTitle: json["category_title"],
    homeUrl: json["home_url"],
    categoryUrl: json["category_url"],
    reporterName: json["reporter_name"],
    profileImage: json["profile_image"],
    totalComments: json["total_comments"],
    totalViews: json["total_views"],
    totalLikes: json["total_likes"],
    formattedPublishedDate: json["formatted_published_date"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "category_title": categoryTitle,
    "home_url": homeUrl,
    "category_url": categoryUrl,
    "reporter_name": reporterName,
    "profile_image": profileImage,
    "total_comments": totalComments,
    "total_views": totalViews,
    "total_likes": totalLikes,
    "formatted_published_date": formattedPublishedDate,
    "location": location,
  };
}

class Newsletter {
  final String? title;
  final String? description;

  Newsletter({
    this.title,
    this.description,
  });

  factory Newsletter.fromJson(Map<String, dynamic> json) => Newsletter(
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}

class TopContributors {
  final String? title;
  final String? subtitle;
  final List<Item>? items;
  final String? viewAllUrl;

  TopContributors({
    this.title,
    this.subtitle,
    this.items,
    this.viewAllUrl,
  });

  factory TopContributors.fromJson(Map<String, dynamic> json) => TopContributors(
    title: json["title"],
    subtitle: json["subtitle"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    viewAllUrl: json["view_all_url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "view_all_url": viewAllUrl,
  };
}

class Item {
  final int? id;
  final String? name;
  final String? profileImage;

  Item({
    this.id,
    this.name,
    this.profileImage,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_image": profileImage,
  };
}

class TownMemory {
  final String? title;
  final String? image;
  final String? caption;
  final Date? date;
  final Button? button;

  TownMemory({
    this.title,
    this.image,
    this.caption,
    this.date,
    this.button,
  });

  factory TownMemory.fromJson(Map<String, dynamic> json) => TownMemory(
    title: json["title"],
    image: json["image"],
    caption: json["caption"],
    date: json["date"] == null ? null : Date.fromJson(json["date"]),
    button: json["button"] == null ? null : Button.fromJson(json["button"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "caption": caption,
    "date": date?.toJson(),
    "button": button?.toJson(),
  };
}

class Button {
  final String? text;
  final String? url;

  Button({
    this.text,
    this.url,
  });

  factory Button.fromJson(Map<String, dynamic> json) => Button(
    text: json["text"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "url": url,
  };
}

class Date {
  final int? year;
  final dynamic month;
  final dynamic day;

  Date({
    this.year,
    this.month,
    this.day,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    year: json["year"],
    month: json["month"],
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "month": month,
    "day": day,
  };
}
