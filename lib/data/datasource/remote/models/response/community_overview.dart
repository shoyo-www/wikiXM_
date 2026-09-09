// To parse this JSON data, do
//
//     final communityOverviewResponse = communityOverviewResponseFromJson(jsonString);

import 'dart:convert';

CommunityOverviewResponse communityOverviewResponseFromJson(String str) => CommunityOverviewResponse.fromJson(json.decode(str));

String communityOverviewResponseToJson(CommunityOverviewResponse data) => json.encode(data.toJson());

class CommunityOverviewResponse {
  final bool? success;
  final String? message;
  final CommunityOverview? data;

  CommunityOverviewResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CommunityOverviewResponse.fromJson(Map<String, dynamic> json) => CommunityOverviewResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : CommunityOverview.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class CommunityOverview {
  final Location? location;
  final Hero? hero;
  final Pulse? pulse;
  final List<Snapshot>? snapshot;
  final List<Snapshot>? today;

  CommunityOverview({
    this.location,
    this.hero,
    this.pulse,
    this.snapshot,
    this.today,
  });

  factory CommunityOverview.fromJson(Map<String, dynamic> json) => CommunityOverview(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    hero: json["hero"] == null ? null : Hero.fromJson(json["hero"]),
    pulse: json["pulse"] == null ? null : Pulse.fromJson(json["pulse"]),
    snapshot: json["snapshot"] == null ? [] : List<Snapshot>.from(json["snapshot"]!.map((x) => Snapshot.fromJson(x))),
    today: json["today"] == null ? [] : List<Snapshot>.from(json["today"]!.map((x) => Snapshot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "hero": hero?.toJson(),
    "pulse": pulse?.toJson(),
    "snapshot": snapshot == null ? [] : List<dynamic>.from(snapshot!.map((x) => x.toJson())),
    "today": today == null ? [] : List<dynamic>.from(today!.map((x) => x.toJson())),
  };
}

class Hero {
  final String? eyebrow;
  final List<Point>? points;
  final AiBrief? aiBrief;

  Hero({
    this.eyebrow,
    this.points,
    this.aiBrief,
  });

  factory Hero.fromJson(Map<String, dynamic> json) => Hero(
    eyebrow: json["eyebrow"],
    points: json["points"] == null ? [] : List<Point>.from(json["points"]!.map((x) => Point.fromJson(x))),
    aiBrief: json["ai_brief"] == null ? null : AiBrief.fromJson(json["ai_brief"]),
  );

  Map<String, dynamic> toJson() => {
    "eyebrow": eyebrow,
    "points": points == null ? [] : List<dynamic>.from(points!.map((x) => x.toJson())),
    "ai_brief": aiBrief?.toJson(),
  };
}

class AiBrief {
  final String? label;
  final String? icon;
  final String? arrowIcon;

  AiBrief({
    this.label,
    this.icon,
    this.arrowIcon,
  });

  factory AiBrief.fromJson(Map<String, dynamic> json) => AiBrief(
    label: json["label"],
    icon: json["icon"],
    arrowIcon: json["arrow_icon"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "icon": icon,
    "arrow_icon": arrowIcon,
  };
}

class Point {
  final String? text;
  final String? icon;

  Point({
    this.text,
    this.icon,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
    text: json["text"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "icon": icon,
  };
}

class Location {
  final int? cityId;
  final String? name;
  final String? stateName;
  final String? abbreviation;
  final String? timezone;
  final String? image;

  Location({
    this.cityId,
    this.name,
    this.stateName,
    this.abbreviation,
    this.timezone,
    this.image,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    cityId: json["city_id"],
    name: json["name"],
    stateName: json["state_name"],
    abbreviation: json["abbreviation"],
    timezone: json["timezone"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "name": name,
    "state_name": stateName,
    "abbreviation": abbreviation,
    "timezone": timezone,
    "image": image,
  };
}

class Pulse {
  final bool? available;
  final int? score;
  final Index? index;
  final String? updatedLabel;

  Pulse({
    this.available,
    this.score,
    this.index,
    this.updatedLabel,
  });

  factory Pulse.fromJson(Map<String, dynamic> json) => Pulse(
    available: json["available"],
    score: json["score"],
    index: json["index"] == null ? null : Index.fromJson(json["index"]),
    updatedLabel: json["updated_label"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "score": score,
    "index": index?.toJson(),
    "updated_label": updatedLabel,
  };
}

class Index {
  final String? label;
  final String? icon;
  final int? max;
  final String? calculationLabel;

  Index({
    this.label,
    this.icon,
    this.max,
    this.calculationLabel,
  });

  factory Index.fromJson(Map<String, dynamic> json) => Index(
    label: json["label"],
    icon: json["icon"],
    max: json["max"],
    calculationLabel: json["calculation_label"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "icon": icon,
    "max": max,
    "calculation_label": calculationLabel,
  };
}

class Snapshot {
  final String? key;
  final String? label;
  final String? context;
  final int? value;
  final String? icon;
  final String? variant;

  Snapshot({
    this.key,
    this.label,
    this.context,
    this.value,
    this.icon,
    this.variant,
  });

  factory Snapshot.fromJson(Map<String, dynamic> json) => Snapshot(
    key: json["key"],
    label: json["label"],
    context: json["context"],
    value: json["value"],
    icon: json["icon"],
    variant: json["variant"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "label": label,
    "context": context,
    "value": value,
    "icon": icon,
    "variant": variant,
  };
}
