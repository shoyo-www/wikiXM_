
import 'dart:convert';

PersonalisationResponse personalisationResponseFromJson(String str) => PersonalisationResponse.fromJson(json.decode(str));

class PersonalisationResponse {
  final bool? success;
  final String? message;
  final PersonalisationData? data;
  final dynamic error;

  PersonalisationResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory PersonalisationResponse.fromJson(Map<String, dynamic> json) => PersonalisationResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : PersonalisationData.fromJson(json["data"]),
    error: json["error"],
  );

}

class PersonalisationData {
  final Communities? communities;
  final List<Option>? interestOptions;
  final List<Option>? notificationOptions;
  final List<Option>? deliveryOptions;
  final Selected? selected;

  PersonalisationData({
    this.communities,
    this.interestOptions,
    this.notificationOptions,
    this.deliveryOptions,
    this.selected,
  });

  factory PersonalisationData.fromJson(Map<String, dynamic> json) => PersonalisationData(
    communities: json["communities"] == null ? null : Communities.fromJson(json["communities"]),
    interestOptions: json["interest_options"] == null ? [] : List<Option>.from(json["interest_options"]!.map((x) => Option.fromJson(x))),
    notificationOptions: json["notification_options"] == null ? [] : List<Option>.from(json["notification_options"]!.map((x) => Option.fromJson(x))),
    deliveryOptions: json["delivery_options"] == null ? [] : List<Option>.from(json["delivery_options"]!.map((x) => Option.fromJson(x))),
    selected: json["selected"] == null ? null : Selected.fromJson(json["selected"]),
  );

}

class Communities {
  final Ary? primary;
  final List<Ary>? secondary;

  Communities({
    this.primary,
    this.secondary,
  });

  factory Communities.fromJson(Map<String, dynamic> json) => Communities(
    primary: json["primary"] == null ? null : Ary.fromJson(json["primary"]),
    secondary: json["secondary"] == null ? [] : List<Ary>.from(json["secondary"]!.map((x) => Ary.fromJson(x))),
  );

}

class Ary {
  final int? cityId;
  final String? cityName;
  final String? stateName;
  final String? stateAbbreviation;
  final String? areaName;
  final String? path;
  final String? cityImage;
  final String? cityType;
  final String? cityFallbackImage;

  Ary({
    this.cityId,
    this.cityName,
    this.stateName,
    this.stateAbbreviation,
    this.areaName,
    this.path,
    this.cityImage,
    this.cityType,
    this.cityFallbackImage,
  });

  factory Ary.fromJson(Map<String, dynamic> json) => Ary(
    cityId: json["city_id"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    stateAbbreviation: json["state_abbreviation"],
    areaName: json["area_name"],
    path: json["path"],
    cityImage: json["city_image"],
    cityType: json["city_type"],
    cityFallbackImage: json["city_fallback_image"],
  );

}

class Option {
  final int? id;
  final String? slug;
  final String? label;
  final String? icon;
  final bool? defaultEnabled;
  final int? sortOrder;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? group;
  final bool? defaultSelected;
  final String? description;

  Option({
    this.id,
    this.slug,
    this.label,
    this.icon,
    this.defaultEnabled,
    this.sortOrder,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.group,
    this.defaultSelected,
    this.description,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    slug: json["slug"],
    label: json["label"],
    icon: json["icon"],
    defaultEnabled: json["default_enabled"],
    sortOrder: json["sort_order"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    group: json["group"],
    defaultSelected: json["default_selected"],
    description: json["description"],
  );

}


class Selected {
  final List<int>? interests;
  final List<int>? notifications;
  final List<int>? deliveryChannels;

  Selected({
    this.interests,
    this.notifications,
    this.deliveryChannels,
  });

  factory Selected.fromJson(Map<String, dynamic> json) => Selected(
    interests: json["interests"] == null ? [] : List<int>.from(json["interests"]!.map((x) => x)),
    notifications: json["notifications"] == null ? [] : List<int>.from(json["notifications"]!.map((x) => x)),
    deliveryChannels: json["delivery_channels"] == null ? [] : List<int>.from(json["delivery_channels"]!.map((x) => x)),
  );
}

