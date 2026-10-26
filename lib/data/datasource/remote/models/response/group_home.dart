import 'dart:convert';

GroupHomeResponse groupHomeResponseFromJson(String str) => GroupHomeResponse.fromJson(json.decode(str));


class GroupHomeResponse {
  final bool? success;
  final String? message;
  final GroupData? data;

  GroupHomeResponse({
    this.success,
    this.message,
    this.data,
  });

  factory GroupHomeResponse.fromJson(Map<String, dynamic> json) => GroupHomeResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : GroupData.fromJson(json["data"]),
  );

}

class GroupData {
  final Hero? hero;
  final Interests? interests;
  final Location? location;
  final Viewer? viewer;

  GroupData({
    this.hero,
    this.interests,
    this.location,
    this.viewer,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) => GroupData(
    hero: json["hero"] == null ? null : Hero.fromJson(json["hero"]),
    interests: json["interests"] == null ? null : Interests.fromJson(json["interests"]),
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    viewer: json["viewer"] == null ? null : Viewer.fromJson(json["viewer"]),
  );
}

class Hero {
  final String? eyebrow;
  final String? titlePrefix;
  final String? title;
  final String? description;
  final Image? image;
  final List<Stat>? stats;

  Hero({
    this.eyebrow,
    this.titlePrefix,
    this.title,
    this.description,
    this.image,
    this.stats,
  });

  factory Hero.fromJson(Map<String, dynamic> json) => Hero(
    eyebrow: json["eyebrow"],
    titlePrefix: json["title_prefix"],
    title: json["title"],
    description: json["description"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    stats: json["stats"] == null ? [] : List<Stat>.from(json["stats"]!.map((x) => Stat.fromJson(x))),
  );
}

class Image {
  final String? url;
  final String? alt;
  final int? width;
  final int? height;

  Image({
    this.url,
    this.alt,
    this.width,
    this.height,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    url: json["url"],
    alt: json["alt"],
    width: json["width"],
    height: json["height"],
  );
}

class Stat {
  final String? id;
  final String? icon;
  final String? label;
  final int? value;
  final String? displayValue;

  Stat({
    this.id,
    this.icon,
    this.label,
    this.value,
    this.displayValue,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
    id: json["id"],
    icon: json["icon"],
    label: json["label"],
    value: json["value"],
    displayValue: json["display_value"],
  );
}

class Interests {
  final String? title;
  final String? description;
  final String? emptyMessage;
  final List<Item>? items;

  Interests({
    this.title,
    this.description,
    this.emptyMessage,
    this.items,
  });

  factory Interests.fromJson(Map<String, dynamic> json) => Interests(
    title: json["title"],
    description: json["description"],
    emptyMessage: json["empty_message"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );
}

class Item {
  final String? id;
  final int? interestId;
  final String? name;
  final String? icon;
  final String? color;
  final int? groupsCount;
  final String? groupsLabel;
  final Image? image;

  Item({
    this.id,
    this.interestId,
    this.name,
    this.icon,
    this.color,
    this.groupsCount,
    this.groupsLabel,
    this.image,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    interestId: json["interest_id"],
    name: json["name"],
    icon: json["icon"],
    color: json["color"],
    groupsCount: json["groups_count"],
    groupsLabel: json["groups_label"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );

}

class Location {
  final int? id;
  final String? name;
  final int? stateId;
  final String? stateName;
  final int? countryId;
  final String? timezone;

  Location({
    this.id,
    this.name,
    this.stateId,
    this.stateName,
    this.countryId,
    this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    stateName: json["state_name"],
    countryId: json["country_id"],
    timezone: json["timezone"],
  );

}

class Viewer {
  final int? id;
  final String? firstName;
  final bool? authenticated;

  Viewer({
    this.id,
    this.firstName,
    this.authenticated,
  });

  factory Viewer.fromJson(Map<String, dynamic> json) => Viewer(
    id: json["id"],
    firstName: json["first_name"],
    authenticated: json["authenticated"],
  );
}

