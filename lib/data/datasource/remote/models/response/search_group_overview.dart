import 'dart:convert';

SearchGroupOverviewResponse searchGroupOverviewResponseFromJson(String str) => SearchGroupOverviewResponse.fromJson(json.decode(str));

String searchGroupOverviewResponseToJson(SearchGroupOverviewResponse data) => json.encode(data.toJson());

class SearchGroupOverviewResponse {
  final bool? success;
  final String? message;
  final SearchGroupOverviewData? data;

  SearchGroupOverviewResponse({
    this.success,
    this.message,
    this.data,
  });

  factory SearchGroupOverviewResponse.fromJson(Map<String, dynamic> json) => SearchGroupOverviewResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : SearchGroupOverviewData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class SearchGroupOverviewData {
  final Town? town;
  final Statistics? statistics;
  final List<Category>? categories;
  final List<String>? popularCategoryIds;
  final Filters? filters;
  final DefaultFilters? defaultFilters;
  final String? defaultGroupImage;
  final List<Navigation>? navigation;
  final List<Navigation>? quickLinks;

  SearchGroupOverviewData({
    this.town,
    this.statistics,
    this.categories,
    this.popularCategoryIds,
    this.filters,
    this.defaultFilters,
    this.defaultGroupImage,
    this.navigation,
    this.quickLinks,
  });

  factory SearchGroupOverviewData.fromJson(Map<String, dynamic> json) => SearchGroupOverviewData(
    town: json["town"] == null ? null : Town.fromJson(json["town"]),
    statistics: json["statistics"] == null ? null : Statistics.fromJson(json["statistics"]),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    popularCategoryIds: json["popular_category_ids"] == null ? [] : List<String>.from(json["popular_category_ids"]!.map((x) => x)),
    filters: json["filters"] == null ? null : Filters.fromJson(json["filters"]),
    defaultFilters: json["default_filters"] == null ? null : DefaultFilters.fromJson(json["default_filters"]),
    defaultGroupImage: json["default_group_image"],
    navigation: json["navigation"] == null ? [] : List<Navigation>.from(json["navigation"]!.map((x) => Navigation.fromJson(x))),
    quickLinks: json["quick_links"] == null ? [] : List<Navigation>.from(json["quick_links"]!.map((x) => Navigation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "town": town?.toJson(),
    "statistics": statistics?.toJson(),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "popular_category_ids": popularCategoryIds == null ? [] : List<dynamic>.from(popularCategoryIds!.map((x) => x)),
    "filters": filters?.toJson(),
    "default_filters": defaultFilters?.toJson(),
    "default_group_image": defaultGroupImage,
    "navigation": navigation == null ? [] : List<dynamic>.from(navigation!.map((x) => x.toJson())),
    "quick_links": quickLinks == null ? [] : List<dynamic>.from(quickLinks!.map((x) => x.toJson())),
  };
}

class Category {
  final String? id;
  final String? name;
  final String? icon;
  final String? color;
  final int? groupCount;

  Category({
    this.id,
    this.name,
    this.icon,
    this.color,
    this.groupCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    color: json["color"],
    groupCount: json["group_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "color": color,
    "group_count": groupCount,
  };
}

class DefaultFilters {
  final String? distance;
  final String? category;
  final List<String>? type;
  final List<String>? level;
  final String? sort;

  DefaultFilters({
    this.distance,
    this.category,
    this.type,
    this.level,
    this.sort,
  });

  factory DefaultFilters.fromJson(Map<String, dynamic> json) => DefaultFilters(
    distance: json["distance"],
    category: json["category"],
    type: json["type"] == null ? [] : List<String>.from(json["type"]!.map((x) => x)),
    level: json["level"] == null ? [] : List<String>.from(json["level"]!.map((x) => x)),
    sort: json["sort"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "category": category,
    "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x)),
    "level": level == null ? [] : List<dynamic>.from(level!.map((x) => x)),
    "sort": sort,
  };
}

class Filters {
  final List<int>? distanceOptions;
  final List<ActivityLevel>? groupTypes;
  final List<ActivityLevel>? activityLevels;
  final List<ActivityLevel>? sortOptions;

  Filters({
    this.distanceOptions,
    this.groupTypes,
    this.activityLevels,
    this.sortOptions,
  });

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
    distanceOptions: json["distance_options"] == null ? [] : List<int>.from(json["distance_options"]!.map((x) => x)),
    groupTypes: json["group_types"] == null ? [] : List<ActivityLevel>.from(json["group_types"]!.map((x) => ActivityLevel.fromJson(x))),
    activityLevels: json["activity_levels"] == null ? [] : List<ActivityLevel>.from(json["activity_levels"]!.map((x) => ActivityLevel.fromJson(x))),
    sortOptions: json["sort_options"] == null ? [] : List<ActivityLevel>.from(json["sort_options"]!.map((x) => ActivityLevel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "distance_options": distanceOptions == null ? [] : List<dynamic>.from(distanceOptions!.map((x) => x)),
    "group_types": groupTypes == null ? [] : List<dynamic>.from(groupTypes!.map((x) => x.toJson())),
    "activity_levels": activityLevels == null ? [] : List<dynamic>.from(activityLevels!.map((x) => x.toJson())),
    "sort_options": sortOptions == null ? [] : List<dynamic>.from(sortOptions!.map((x) => x.toJson())),
  };
}

class ActivityLevel {
  final String? value;
  final String? label;

  ActivityLevel({
    this.value,
    this.label,
  });

  factory ActivityLevel.fromJson(Map<String, dynamic> json) => ActivityLevel(
    value: json["value"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "label": label,
  };
}

class Navigation {
  final String? id;
  final String? label;
  final String? icon;
  final String? href;

  Navigation({
    this.id,
    this.label,
    this.icon,
    this.href,
  });

  factory Navigation.fromJson(Map<String, dynamic> json) => Navigation(
    id: json["id"],
    label: json["label"],
    icon: json["icon"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "icon": icon,
    "href": href,
  };
}

class Statistics {
  final int? totalGroups;
  final int? totalMembers;
  final int? activeGroupsThisWeek;
  final int? newGroupsThisMonth;
  final int? newMembersThisMonth;
  final int? totalCategories;

  Statistics({
    this.totalGroups,
    this.totalMembers,
    this.activeGroupsThisWeek,
    this.newGroupsThisMonth,
    this.newMembersThisMonth,
    this.totalCategories,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    totalGroups: json["total_groups"],
    totalMembers: json["total_members"],
    activeGroupsThisWeek: json["active_groups_this_week"],
    newGroupsThisMonth: json["new_groups_this_month"],
    newMembersThisMonth: json["new_members_this_month"],
    totalCategories: json["total_categories"],
  );

  Map<String, dynamic> toJson() => {
    "total_groups": totalGroups,
    "total_members": totalMembers,
    "active_groups_this_week": activeGroupsThisWeek,
    "new_groups_this_month": newGroupsThisMonth,
    "new_members_this_month": newMembersThisMonth,
    "total_categories": totalCategories,
  };
}

class Town {
  final int? id;
  final String? name;
  final String? state;
  final String? displayName;
  final String? description;
  final String? image;
  final String? href;

  Town({
    this.id,
    this.name,
    this.state,
    this.displayName,
    this.description,
    this.image,
    this.href,
  });

  factory Town.fromJson(Map<String, dynamic> json) => Town(
    id: json["id"],
    name: json["name"],
    state: json["state"],
    displayName: json["display_name"],
    description: json["description"],
    image: json["image"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state": state,
    "display_name": displayName,
    "description": description,
    "image": image,
    "href": href,
  };
}
