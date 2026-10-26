import 'dart:convert';

IntersetDetailResponse intersetDetailResponseFromJson(String str) => IntersetDetailResponse.fromJson(json.decode(str));

String intersetDetailResponseToJson(IntersetDetailResponse data) => json.encode(data.toJson());

class IntersetDetailResponse {
  final bool? success;
  final String? message;
  final InterestData? data;

  IntersetDetailResponse({this.success, this.message, this.data});

  factory IntersetDetailResponse.fromJson(Map<String, dynamic> json) =>
      IntersetDetailResponse(success: json["success"], message: json["message"], data: json["data"] == null ? null : InterestData.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"success": success, "message": message, "data": data?.toJson()};
}

class InterestData {
  final int? viewerId;
  final List<Item>? items;
  final Pagination? pagination;
  final Discovery? discovery;
  final Profile? profile;
  final int? cityId;

  InterestData({this.viewerId, this.items, this.pagination, this.discovery, this.profile, this.cityId});

  factory InterestData.fromJson(Map<String, dynamic> json) => InterestData(
    viewerId: json["viewer_id"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    discovery: json["discovery"] == null ? null : Discovery.fromJson(json["discovery"]),
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    cityId: json["city_id"],
  );

  Map<String, dynamic> toJson() => {
    "viewer_id": viewerId,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
    "discovery": discovery?.toJson(),
    "profile": profile?.toJson(),
    "city_id": cityId,
  };
}

class Discovery {
  final String? activeTab;
  final String? type;
  final String? interestName;
  final String? searchLabel;
  final DiscoveryImage? image;
  final String? heading;
  final String? intro;
  final List<Filter>? filters;
  final List<Category>? categories;
  final List<Sort>? sorts;
  final List<Tab>? tabs;

  Discovery({this.activeTab, this.type, this.interestName, this.searchLabel, this.image, this.heading, this.intro, this.filters, this.categories, this.sorts, this.tabs});

  factory Discovery.fromJson(Map<String, dynamic> json) => Discovery(
    activeTab: json["active_tab"],
    type: json["type"],
    interestName: json["interest_name"],
    searchLabel: json["search_label"],
    image: json["image"] == null ? null : DiscoveryImage.fromJson(json["image"]),
    heading: json["heading"],
    intro: json["intro"],
    filters: json["filters"] == null ? [] : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    sorts: json["sorts"] == null ? [] : List<Sort>.from(json["sorts"]!.map((x) => Sort.fromJson(x))),
    tabs: json["tabs"] == null ? [] : List<Tab>.from(json["tabs"]!.map((x) => Tab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "active_tab": activeTab,
    "type": type,
    "interest_name": interestName,
    "search_label": searchLabel,
    "image": image?.toJson(),
    "heading": heading,
    "intro": intro,
    "filters": filters == null ? [] : List<dynamic>.from(filters!.map((x) => x.toJson())),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "sorts": sorts == null ? [] : List<dynamic>.from(sorts!.map((x) => x.toJson())),
    "tabs": tabs == null ? [] : List<dynamic>.from(tabs!.map((x) => x.toJson())),
  };
}

class Category {
  final String? value;
  final String? label;
  final bool? disabled;

  Category({this.value, this.label, this.disabled});

  factory Category.fromJson(Map<String, dynamic> json) => Category(value: json["value"], label: json["label"], disabled: json["disabled"]);

  Map<String, dynamic> toJson() => {"value": value, "label": label, "disabled": disabled};
}

class Filter {
  final String? name;
  final String? label;
  final List<Sort>? options;
  final bool? disabled;
  final String? kind;
  final bool? multiple;

  Filter({this.name, this.label, this.options, this.disabled, this.kind, this.multiple});

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    name: json["name"],
    label: json["label"],
    options: json["options"] == null ? [] : List<Sort>.from(json["options"]!.map((x) => Sort.fromJson(x))),
    disabled: json["disabled"],
    kind: json["kind"],
    multiple: json["multiple"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "label": label,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    "disabled": disabled,
    "kind": kind,
    "multiple": multiple,
  };
}

class Sort {
  final String? value;
  final String? label;

  Sort({this.value, this.label});

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(value: json["value"], label: json["label"]);

  Map<String, dynamic> toJson() => {"value": value, "label": label};
}

class DiscoveryImage {
  final String? url;
  final String? alt;

  DiscoveryImage({this.url, this.alt});

  factory DiscoveryImage.fromJson(Map<String, dynamic> json) => DiscoveryImage(url: json["url"], alt: json["alt"]);

  Map<String, dynamic> toJson() => {"url": url, "alt": alt};
}

class Tab {
  final String? id;
  final String? type;
  final String? label;
  final String? icon;

  Tab({this.id, this.type, this.label, this.icon});

  factory Tab.fromJson(Map<String, dynamic> json) => Tab(id: json["id"], type: json["type"], label: json["label"], icon: json["icon"]);

  Map<String, dynamic> toJson() => {"id": id, "type": type, "label": label, "icon": icon};
}

class Item {
  final String? id;
  final int? activityId;
  final String? detailUrl;
  final int? groupId;
  final int? cityId;
  final String? title;
  final String? description;
  final double? latitude;
  final double? longitude;
  final List<String>? interestIds;
  final ItemImage? image;
  final Badge? badge;
  final List<Detail>? details;
  final DateTime? startsAt;
  final int? goingCount;
  final int? spotsAvailable;
  final List<Attendee>? attendees;
  final bool? isOrganizer;
  final bool? canJoin;
  final bool? isJoined;
  final bool? canLeave;
  // People-tab fields.
  final int? requestId;
  final int? userId;
  final String? profileUrl;
  final String? name;
  final DateTime? availableFrom;
  final String? location;
  final String? icon;
  final String? color;
  final bool? canConnect;
  final String? connectionStatus;
  final bool? canDisconnect;
  final String? membersLabel;

  Item({
    this.id,
    this.activityId,
    this.detailUrl,
    this.groupId,
    this.cityId,
    this.title,
    this.description,
    this.latitude,
    this.longitude,
    this.interestIds,
    this.image,
    this.badge,
    this.details,
    this.startsAt,
    this.goingCount,
    this.spotsAvailable,
    this.attendees,
    this.isOrganizer,
    this.canJoin,
    this.isJoined,
    this.canLeave,
    this.requestId,
    this.userId,
    this.profileUrl,
    this.name,
    this.availableFrom,
    this.location,
    this.icon,
    this.color,
    this.canConnect,
    this.connectionStatus,
    this.canDisconnect,
    this.membersLabel
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"]?.toString(),
    activityId: json["activity_id"],
    detailUrl: json["detail_url"],
    groupId: json["group_id"],
    cityId: json["city_id"],
    title: json["title"],
    description: json["description"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    interestIds: json["interest_ids"] == null ? [] : List<String>.from(json["interest_ids"]!.map((x) => x.toString())),
    image: json["image"] == null ? null : ItemImage.fromJson(json["image"]),
    badge: json["badge"] == null ? null : Badge.fromJson(json["badge"]),
    details: switch (json["details"]) {
      List list => List<Detail>.from(list.map((x) => Detail.fromJson(x))),
      String text => text.split(' - ').map((part) => Detail(text: part.trim())).toList(),
      _ => [],
    },
    startsAt: json["starts_at"] == null ? null : DateTime.tryParse(json["starts_at"]),
    goingCount: json["going_count"],
    spotsAvailable: json["spots_available"],
    attendees: json["attendees"] == null ? [] : List<Attendee>.from(json["attendees"]!.map((x) => Attendee.fromJson(x))),
    isOrganizer: json["is_organizer"],
    canJoin: json["can_join"],
    isJoined: json["is_joined"],
    canLeave: json["can_leave"],
    requestId: json["request_id"],
    userId: json["user_id"],
    profileUrl: json["profile_url"],
    name: json["name"],
    availableFrom: json["available_from"] == null ? null : DateTime.tryParse(json["available_from"]),
    location: json["location"],
    icon: json["icon"],
    color: json["color"],
    canConnect: json["can_connect"],
    connectionStatus: json["connection_status"],
    canDisconnect: json["can_disconnect"],
    membersLabel: json['members_label']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "activity_id": activityId,
    "detail_url": detailUrl,
    "group_id": groupId,
    "city_id": cityId,
    "title": title,
    "description": description,
    "latitude": latitude,
    "longitude": longitude,
    "interest_ids": interestIds == null ? [] : List<dynamic>.from(interestIds!.map((x) => x)),
    "image": image?.toJson(),
    "badge": badge?.toJson(),
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
    "starts_at": startsAt?.toIso8601String(),
    "going_count": goingCount,
    "spots_available": spotsAvailable,
    "attendees": attendees == null ? [] : List<dynamic>.from(attendees!.map((x) => x.toJson())),
    "is_organizer": isOrganizer,
    "can_join": canJoin,
    "is_joined": isJoined,
    "can_leave": canLeave,
    "request_id": requestId,
    "user_id": userId,
    "profile_url": profileUrl,
    "name": name,
    "available_from": availableFrom?.toIso8601String(),
    "location": location,
    "icon": icon,
    "color": color,
    "can_connect": canConnect,
    "connection_status": connectionStatus,
    "can_disconnect": canDisconnect,
  };
}

class Attendee {
  final String? url;

  Attendee({this.url});

  factory Attendee.fromJson(Map<String, dynamic> json) => Attendee(url: json["url"]);

  Map<String, dynamic> toJson() => {"url": url};
}

class Badge {
  final String? label;

  Badge({this.label});

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(label: json["label"]);

  Map<String, dynamic> toJson() => {"label": label};
}

class Detail {
  final String? id;
  final String? text;

  Detail({this.id, this.text});

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(id: json["id"], text: json["text"]);

  Map<String, dynamic> toJson() => {"id": id, "text": text};
}

class ItemImage {
  final String? url;
  final String? alt;
  final int? width;
  final int? height;

  ItemImage({this.url, this.alt, this.width, this.height});

  factory ItemImage.fromJson(Map<String, dynamic> json) => ItemImage(url: json["url"], alt: json["alt"], width: json["width"], height: json["height"]);

  Map<String, dynamic> toJson() => {"url": url, "alt": alt, "width": width, "height": height};
}

class Pagination {
  final bool? hasMore;

  Pagination({this.hasMore});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(hasMore: json["has_more"]);

  Map<String, dynamic> toJson() => {"has_more": hasMore};
}

class Profile {
  final String? activitySearchLabel;
  final String? activityLabel;
  final String? activityAction;
  final String? peopleLabel;
  final String? peopleAction;

  Profile({this.activitySearchLabel, this.activityLabel, this.activityAction, this.peopleLabel, this.peopleAction});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    activitySearchLabel: json["activity_search_label"],
    activityLabel: json["activity_label"],
    activityAction: json["activity_action"],
    peopleLabel: json["people_label"],
    peopleAction: json["people_action"],
  );

  Map<String, dynamic> toJson() => {
    "activity_search_label": activitySearchLabel,
    "activity_label": activityLabel,
    "activity_action": activityAction,
    "people_label": peopleLabel,
    "people_action": peopleAction,
  };
}
