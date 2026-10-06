import 'dart:convert';

MarketPlaceContentResponse marketPlaceContentResponseFromJson(String str) => MarketPlaceContentResponse.fromJson(json.decode(str));

class MarketPlaceContentResponse {
  final bool? success;
  final String? message;
  final ContentData? data;

  MarketPlaceContentResponse({this.success, this.message, this.data});

  factory MarketPlaceContentResponse.fromJson(Map<String, dynamic> json) => MarketPlaceContentResponse(success: json["success"], message: json["message"], data: json["data"] == null ? null : ContentData.fromJson(json["data"]));
}

class ContentData {
  final DateTime? updatedAt;
  final Search? search;
  final Scope? scope;
  final Deals? deals;
  final Pulse? pulse;
  final Rail? rail;

  ContentData({this.updatedAt, this.search, this.scope, this.deals, this.pulse, this.rail});

  factory ContentData.fromJson(Map<String, dynamic> json) => ContentData(
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    search: json["search"] == null ? null : Search.fromJson(json["search"]),
    scope: json["scope"] == null ? null : Scope.fromJson(json["scope"]),
    deals: json["deals"] == null ? null : Deals.fromJson(json["deals"]),
    pulse: json["pulse"] == null ? null : Pulse.fromJson(json["pulse"]),
    rail: json["rail"] == null ? null : Rail.fromJson(json["rail"]),
  );
}

class Deals {
  final String? title;
  final String? icon;
  final bool? available;
  final String? description;
  final List<Option>? options;

  Deals({this.title, this.icon, this.available, this.description, this.options});

  factory Deals.fromJson(Map<String, dynamic> json) => Deals(title: json["title"], icon: json["icon"], available: json["available"], description: json["description"], options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))));
}

class Option {
  final String? value;
  final String? label;
  final String? className;
  final int? count;
  final bool? enabled;

  Option({this.value, this.label, this.className, this.count, this.enabled});

  factory Option.fromJson(Map<String, dynamic> json) => Option(value: json["value"], label: json["label"], className: json["class_name"], count: json["count"], enabled: json["enabled"]);
}

class Pulse {
  final String? title;
  final String? icon;
  final List<Metric>? metrics;
  final Trending? trending;
  final String? trendEmpty;
  final String? trendIcon;
  final Link? link;

  Pulse({this.title, this.icon, this.metrics, this.trending, this.trendEmpty, this.trendIcon, this.link});

  factory Pulse.fromJson(Map<String, dynamic> json) => Pulse(
    title: json["title"],
    icon: json["icon"],
    metrics: json["metrics"] == null ? [] : List<Metric>.from(json["metrics"]!.map((x) => Metric.fromJson(x))),
    trending: json["trending"] == null ? null : Trending.fromJson(json["trending"]),
    trendEmpty: json["trend_empty"],
    trendIcon: json["trend_icon"],
    link: json["link"] == null ? null : Link.fromJson(json["link"]),
  );
}

class Link {
  final String? label;
  final String? href;
  final String? icon;

  Link({this.label, this.href, this.icon});

  factory Link.fromJson(Map<String, dynamic> json) => Link(label: json["label"], href: json["href"], icon: json["icon"]);
}

class Metric {
  final String? key;
  final int? value;
  final String? label;
  final String? className;

  Metric({this.key, this.value, this.label, this.className});

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(key: json["key"], value: json["value"], label: json["label"], className: json["class_name"]);
}

class Trending {
  final int? categoryId;
  final String? label;
  final int? currentListings;
  final int? previousListings;

  Trending({this.categoryId, this.label, this.currentListings, this.previousListings});

  factory Trending.fromJson(Map<String, dynamic> json) => Trending(categoryId: json["category_id"], label: json["label"], currentListings: json["current_listings"], previousListings: json["previous_listings"]);
}

class Rail {
  final List<Action>? actions;
  final Popular? popular;
  final Safety? safety;

  Rail({this.actions, this.popular, this.safety});

  factory Rail.fromJson(Map<String, dynamic> json) => Rail(actions: json["actions"] == null ? [] : List<Action>.from(json["actions"]!.map((x) => Action.fromJson(x))), popular: json["popular"] == null ? null : Popular.fromJson(json["popular"]), safety: json["safety"] == null ? null : Safety.fromJson(json["safety"]));
}

class Action {
  final String? key;
  final String? className;
  final String? icon;
  final String? title;
  final String? description;
  final bool? enabled;
  final Link? link;

  Action({this.key, this.className, this.icon, this.title, this.description, this.enabled, this.link});

  factory Action.fromJson(Map<String, dynamic> json) => Action(key: json["key"], className: json["class_name"], icon: json["icon"], title: json["title"], description: json["description"], enabled: json["enabled"], link: json["link"] == null ? null : Link.fromJson(json["link"]));
}

class Popular {
  final String? title;
  final String? icon;
  final String? basis;
  final String? empty;
  final List<Item>? items;

  Popular({this.title, this.icon, this.basis, this.empty, this.items});

  factory Popular.fromJson(Map<String, dynamic> json) => Popular(title: json["title"], icon: json["icon"], basis: json["basis"], empty: json["empty"], items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))));
}

class Item {
  final String? label;
  final int? count;
  final Filters? filters;

  Item({this.label, this.count, this.filters});

  factory Item.fromJson(Map<String, dynamic> json) => Item(label: json["label"], count: json["count"], filters: json["filters"] == null ? null : Filters.fromJson(json["filters"]));
}

class Filters {
  final String? categoryId;
  final String? search;

  Filters({this.categoryId, this.search});

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(categoryId: json["category_id"], search: json["search"]);
}

class Safety {
  final String? title;
  final String? icon;
  final List<Tip>? tips;
  final Link? link;

  Safety({this.title, this.icon, this.tips, this.link});

  factory Safety.fromJson(Map<String, dynamic> json) => Safety(title: json["title"], icon: json["icon"], tips: json["tips"] == null ? [] : List<Tip>.from(json["tips"]!.map((x) => Tip.fromJson(x))), link: json["link"] == null ? null : Link.fromJson(json["link"]));
}

class Tip {
  final String? label;
  final String? icon;

  Tip({this.label, this.icon});

  factory Tip.fromJson(Map<String, dynamic> json) => Tip(label: json["label"], icon: json["icon"]);
}

class Scope {
  final int? cityId;
  final String? timezone;
  final String? basis;

  Scope({this.cityId, this.timezone, this.basis});

  factory Scope.fromJson(Map<String, dynamic> json) => Scope(cityId: json["city_id"], timezone: json["timezone"], basis: json["basis"]);
}

class Search {
  final String? placeholder;

  Search({this.placeholder});

  factory Search.fromJson(Map<String, dynamic> json) => Search(placeholder: json["placeholder"]);
}
