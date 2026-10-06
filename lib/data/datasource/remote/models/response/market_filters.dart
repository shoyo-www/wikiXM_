import 'dart:convert';

MarketPlaceFiltersResponse marketPlaceFiltersResponseFromJson(String str) => MarketPlaceFiltersResponse.fromJson(json.decode(str));

String marketPlaceFiltersResponseToJson(MarketPlaceFiltersResponse data) => json.encode(data.toJson());

class MarketPlaceFiltersResponse {
  final bool? success;
  final String? message;
  final MarketFilters? data;

  MarketPlaceFiltersResponse({
    this.success,
    this.message,
    this.data,
  });

  factory MarketPlaceFiltersResponse.fromJson(Map<String, dynamic> json) => MarketPlaceFiltersResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : MarketFilters.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class MarketFilters {
  final Town? town;
  final List<Navigation>? navigation;
  final List<Category>? categories;
  final List<Condition>? conditions;
  final List<Condition>? distances;
  final List<Condition>? dates;
  final List<More>? sellers;
  final List<More>? more;
  final List<Condition>? sorts;
  final Defaults? defaults;
  final bool? canSave;
  final String? distanceBasis;

  MarketFilters({
    this.town,
    this.navigation,
    this.categories,
    this.conditions,
    this.distances,
    this.dates,
    this.sellers,
    this.more,
    this.sorts,
    this.defaults,
    this.canSave,
    this.distanceBasis,
  });

  factory MarketFilters.fromJson(Map<String, dynamic> json) => MarketFilters(
    town: json["town"] == null ? null : Town.fromJson(json["town"]),
    navigation: json["navigation"] == null ? [] : List<Navigation>.from(json["navigation"]!.map((x) => Navigation.fromJson(x))),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    conditions: json["conditions"] == null ? [] : List<Condition>.from(json["conditions"]!.map((x) => Condition.fromJson(x))),
    distances: json["distances"] == null ? [] : List<Condition>.from(json["distances"]!.map((x) => Condition.fromJson(x))),
    dates: json["dates"] == null ? [] : List<Condition>.from(json["dates"]!.map((x) => Condition.fromJson(x))),
    sellers: json["sellers"] == null ? [] : List<More>.from(json["sellers"]!.map((x) => More.fromJson(x))),
    more: json["more"] == null ? [] : List<More>.from(json["more"]!.map((x) => More.fromJson(x))),
    sorts: json["sorts"] == null ? [] : List<Condition>.from(json["sorts"]!.map((x) => Condition.fromJson(x))),
    defaults: json["defaults"] == null ? null : Defaults.fromJson(json["defaults"]),
    canSave: json["can_save"],
    distanceBasis: json["distance_basis"],
  );

  Map<String, dynamic> toJson() => {
    "town": town?.toJson(),
    "navigation": navigation == null ? [] : List<dynamic>.from(navigation!.map((x) => x.toJson())),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "conditions": conditions == null ? [] : List<dynamic>.from(conditions!.map((x) => x.toJson())),
    "distances": distances == null ? [] : List<dynamic>.from(distances!.map((x) => x.toJson())),
    "dates": dates == null ? [] : List<dynamic>.from(dates!.map((x) => x.toJson())),
    "sellers": sellers == null ? [] : List<dynamic>.from(sellers!.map((x) => x.toJson())),
    "more": more == null ? [] : List<dynamic>.from(more!.map((x) => x.toJson())),
    "sorts": sorts == null ? [] : List<dynamic>.from(sorts!.map((x) => x.toJson())),
    "defaults": defaults?.toJson(),
    "can_save": canSave,
    "distance_basis": distanceBasis,
  };
}

class Category {
  final String? value;
  final String? label;
  final String? icon;
  final String? slug;

  Category({
    this.value,
    this.label,
    this.icon,
    this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    value: json["value"],
    label: json["label"],
    icon: json["icon"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "label": label,
    "icon": icon,
    "slug": slug,
  };
}

class Condition {
  final String? value;
  final String? label;

  Condition({
    this.value,
    this.label,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    value: json["value"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "label": label,
  };
}

class Defaults {
  final String? distance;
  final String? date;
  final String? seller;
  final String? sort;
  final int? perPage;

  Defaults({
    this.distance,
    this.date,
    this.seller,
    this.sort,
    this.perPage,
  });

  factory Defaults.fromJson(Map<String, dynamic> json) => Defaults(
    distance: json["distance"],
    date: json["date"],
    seller: json["seller"],
    sort: json["sort"],
    perPage: json["per_page"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "date": date,
    "seller": seller,
    "sort": sort,
    "per_page": perPage,
  };
}

class More {
  final String? value;
  final String? label;
  final bool? disabled;
  final String? reason;

  More({
    this.value,
    this.label,
    this.disabled,
    this.reason,
  });

  factory More.fromJson(Map<String, dynamic> json) => More(
    value: json["value"],
    label: json["label"],
    disabled: json["disabled"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "label": label,
    "disabled": disabled,
    "reason": reason,
  };
}

class Navigation {
  final String? label;
  final String? href;
  final String? icon;
  final bool? active;

  Navigation({
    this.label,
    this.href,
    this.icon,
    this.active,
  });

  factory Navigation.fromJson(Map<String, dynamic> json) => Navigation(
    label: json["label"],
    href: json["href"],
    icon: json["icon"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "href": href,
    "icon": icon,
    "active": active,
  };
}

class Town {
  final int? id;
  final String? name;
  final String? label;
  final String? path;

  Town({
    this.id,
    this.name,
    this.label,
    this.path,
  });

  factory Town.fromJson(Map<String, dynamic> json) => Town(
    id: json["id"],
    name: json["name"],
    label: json["label"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "label": label,
    "path": path,
  };
}
