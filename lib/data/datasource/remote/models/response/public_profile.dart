// To parse this JSON data, do
//
//     final publicProfileResponse = publicProfileResponseFromJson(jsonString);

import 'dart:convert';

PublicProfileResponse publicProfileResponseFromJson(String str) => PublicProfileResponse.fromJson(json.decode(str));

String publicProfileResponseToJson(PublicProfileResponse data) => json.encode(data.toJson());

class PublicProfileResponse {
  final bool? success;
  final String? message;
  final ProfileData? data;

  PublicProfileResponse({
    this.success,
    this.message,
    this.data,
  });

  factory PublicProfileResponse.fromJson(Map<String, dynamic> json) => PublicProfileResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProfileData {
  final int? id;
  final String? name;
  final bool? verified;
  final bool? isPublic;
  final String? publicReference;
  final String? detailUrl;
  final Ui? ui;
  final String? avatar;
  final String? cover;
  final String? bio;
  final String? location;
  final List<String>? roles;
  final String? memberSince;
  final Statistics? statistics;
  final List<Metric>? metrics;
  final About? about;
  final List<Interest>? interests;
  final List<Activity>? activities;
  final List<GroupElement>? groups;
  final HasMore? hasMore;

  ProfileData({
    this.id,
    this.name,
    this.verified,
    this.isPublic,
    this.publicReference,
    this.detailUrl,
    this.ui,
    this.avatar,
    this.cover,
    this.bio,
    this.location,
    this.roles,
    this.memberSince,
    this.statistics,
    this.metrics,
    this.about,
    this.interests,
    this.activities,
    this.groups,
    this.hasMore,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json["id"],
    name: json["name"],
    verified: json["verified"],
    isPublic: json["isPublic"],
    publicReference: json["public_reference"],
    detailUrl: json["detail_url"],
    ui: json["ui"] == null ? null : Ui.fromJson(json["ui"]),
    avatar: json["avatar"],
    cover: json["cover"],
    bio: json["bio"],
    location: json["location"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    memberSince: json["memberSince"],
    statistics: json["statistics"] == null ? null : Statistics.fromJson(json["statistics"]),
    metrics: json["metrics"] == null ? [] : List<Metric>.from(json["metrics"]!.map((x) => Metric.fromJson(x))),
    about: json["about"] == null ? null : About.fromJson(json["about"]),
    interests: json["interests"] == null ? [] : List<Interest>.from(json["interests"]!.map((x) => Interest.fromJson(x))),
    activities: json["activities"] == null ? [] : List<Activity>.from(json["activities"]!.map((x) => Activity.fromJson(x))),
    groups: json["groups"] == null ? [] : List<GroupElement>.from(json["groups"]!.map((x) => GroupElement.fromJson(x))),
    hasMore: json["has_more"] == null ? null : HasMore.fromJson(json["has_more"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "verified": verified,
    "isPublic": isPublic,
    "public_reference": publicReference,
    "detail_url": detailUrl,
    "ui": ui?.toJson(),
    "avatar": avatar,
    "cover": cover,
    "bio": bio,
    "location": location,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "memberSince": memberSince,
    "statistics": statistics?.toJson(),
    "metrics": metrics == null ? [] : List<dynamic>.from(metrics!.map((x) => x.toJson())),
    "about": about?.toJson(),
    "interests": interests == null ? [] : List<dynamic>.from(interests!.map((x) => x.toJson())),
    "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toJson())),
    "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x.toJson())),
    "has_more": hasMore?.toJson(),
  };
}

class About {
  final String? title;
  final List<Item>? items;
  final String? description;

  About({
    this.title,
    this.items,
    this.description,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
    title: json["title"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "description": description,
  };
}

class Item {
  final String? id;
  final String? icon;
  final String? text;

  Item({
    this.id,
    this.icon,
    this.text,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    icon: json["icon"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "text": text,
  };
}

class Activity {
  final DateTime? date;
  final String? dateLabel;
  final String? shortDateLabel;
  final String? time;
  final String? timeLabel;
  final String? monthLabel;
  final String? dayLabel;
  final String? id;
  final String? title;
  final String? description;
  final String? image;
  final String? imageAlt;
  final String? status;
  final String? statusClass;
  final ActivityGroup? group;
  final int? likes;
  final int? comments;
  final String? commentsDescription;
  final String? detailDescription;

  Activity({
    this.date,
    this.dateLabel,
    this.shortDateLabel,
    this.time,
    this.timeLabel,
    this.monthLabel,
    this.dayLabel,
    this.id,
    this.title,
    this.description,
    this.image,
    this.imageAlt,
    this.status,
    this.statusClass,
    this.group,
    this.likes,
    this.comments,
    this.commentsDescription,
    this.detailDescription,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    dateLabel: json["date_label"],
    shortDateLabel: json["short_date_label"],
    time: json["time"],
    timeLabel: json["time_label"],
    monthLabel: json["month_label"],
    dayLabel: json["day_label"],
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    imageAlt: json["imageAlt"],
    status: json["status"],
    statusClass: json["statusClass"],
    group: json["group"] == null ? null : ActivityGroup.fromJson(json["group"]),
    likes: json["likes"],
    comments: json["comments"],
    commentsDescription: json["commentsDescription"],
    detailDescription: json["detail_description"],
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "date_label": dateLabel,
    "short_date_label": shortDateLabel,
    "time": time,
    "time_label": timeLabel,
    "month_label": monthLabel,
    "day_label": dayLabel,
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "imageAlt": imageAlt,
    "status": status,
    "statusClass": statusClass,
    "group": group?.toJson(),
    "likes": likes,
    "comments": comments,
    "commentsDescription": commentsDescription,
    "detail_description": detailDescription,
  };
}

class ActivityGroup {
  final String? name;
  final String? icon;
  final String? className;

  ActivityGroup({
    this.name,
    this.icon,
    this.className,
  });

  factory ActivityGroup.fromJson(Map<String, dynamic> json) => ActivityGroup(
    name: json["name"],
    icon: json["icon"],
    className: json["className"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "icon": icon,
    "className": className,
  };
}

class GroupElement {
  final String? id;
  final String? name;
  final String? description;
  final String? image;
  final String? imageAlt;
  final String? icon;
  final String? className;
  final int? memberCount;
  final String? memberCountLabel;
  final String? status;
  final String? detailUrl;
  final String? detailDescription;

  GroupElement({
    this.id,
    this.name,
    this.description,
    this.image,
    this.imageAlt,
    this.icon,
    this.className,
    this.memberCount,
    this.memberCountLabel,
    this.status,
    this.detailUrl,
    this.detailDescription,
  });

  factory GroupElement.fromJson(Map<String, dynamic> json) => GroupElement(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    imageAlt: json["imageAlt"],
    icon: json["icon"],
    className: json["className"],
    memberCount: json["memberCount"],
    memberCountLabel: json["member_count_label"],
    status: json["status"],
    detailUrl: json["detail_url"],
    detailDescription: json["detail_description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "imageAlt": imageAlt,
    "icon": icon,
    "className": className,
    "memberCount": memberCount,
    "member_count_label": memberCountLabel,
    "status": status,
    "detail_url": detailUrl,
    "detail_description": detailDescription,
  };
}

class HasMore {
  final bool? interests;
  final bool? activities;
  final bool? groups;

  HasMore({
    this.interests,
    this.activities,
    this.groups,
  });

  factory HasMore.fromJson(Map<String, dynamic> json) => HasMore(
    interests: json["interests"],
    activities: json["activities"],
    groups: json["groups"],
  );

  Map<String, dynamic> toJson() => {
    "interests": interests,
    "activities": activities,
    "groups": groups,
  };
}

class Interest {
  final String? id;
  final String? name;
  final String? icon;
  final String? className;
  final String? detailDescription;

  Interest({
    this.id,
    this.name,
    this.icon,
    this.className,
    this.detailDescription,
  });

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    className: json["className"],
    detailDescription: json["detail_description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "className": className,
    "detail_description": detailDescription,
  };
}

class Metric {
  final String? id;
  final String? icon;
  final int? value;
  final String? label;
  final String? action;

  Metric({
    this.id,
    this.icon,
    this.value,
    this.label,
    this.action,
  });

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
    id: json["id"],
    icon: json["icon"],
    value: json["value"],
    label: json["label"],
    action: json["action"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "value": value,
    "label": label,
    "action": action,
  };
}

class Statistics {
  final int? groups;
  final int? activities;
  final int? discussions;
  final int? organized;

  Statistics({
    this.groups,
    this.activities,
    this.discussions,
    this.organized,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    groups: json["groups"],
    activities: json["activities"],
    discussions: json["discussions"],
    organized: json["organized"],
  );

  Map<String, dynamic> toJson() => {
    "groups": groups,
    "activities": activities,
    "discussions": discussions,
    "organized": organized,
  };
}

class Ui {
  final String? defaultTab;
  final List<Action>? tabs;
  final List<Action>? actions;
  final Inventory? inventoryLabels;
  final Inventory? inventoryTitles;
  final Inventory? inventoryActions;
  final Summary? summary;

  Ui({
    this.defaultTab,
    this.tabs,
    this.actions,
    this.inventoryLabels,
    this.inventoryTitles,
    this.inventoryActions,
    this.summary,
  });

  factory Ui.fromJson(Map<String, dynamic> json) => Ui(
    defaultTab: json["default_tab"],
    tabs: json["tabs"] == null ? [] : List<Action>.from(json["tabs"]!.map((x) => Action.fromJson(x))),
    actions: json["actions"] == null ? [] : List<Action>.from(json["actions"]!.map((x) => Action.fromJson(x))),
    inventoryLabels: json["inventory_labels"] == null ? null : Inventory.fromJson(json["inventory_labels"]),
    inventoryTitles: json["inventory_titles"] == null ? null : Inventory.fromJson(json["inventory_titles"]),
    inventoryActions: json["inventory_actions"] == null ? null : Inventory.fromJson(json["inventory_actions"]),
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "default_tab": defaultTab,
    "tabs": tabs == null ? [] : List<dynamic>.from(tabs!.map((x) => x.toJson())),
    "actions": actions == null ? [] : List<dynamic>.from(actions!.map((x) => x.toJson())),
    "inventory_labels": inventoryLabels?.toJson(),
    "inventory_titles": inventoryTitles?.toJson(),
    "inventory_actions": inventoryActions?.toJson(),
    "summary": summary?.toJson(),
  };
}

class Action {
  final String? id;
  final String? label;
  final String? activeLabel;
  final bool? hide;
  final String? icon;

  Action({
    this.id,
    this.label,
    this.activeLabel,
    this.hide,
    this.icon,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
    id: json["id"],
    label: json["label"],
    activeLabel: json["active_label"],
    hide: json["hide"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "active_label": activeLabel,
    "hide": hide,
    "icon": icon,
  };
}

class Inventory {
  final String? groups;
  final String? activities;
  final String? upcoming;
  final String? discussions;
  final String? photos;
  final String? interests;

  Inventory({
    this.groups,
    this.activities,
    this.upcoming,
    this.discussions,
    this.photos,
    this.interests,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
    groups: json["groups"],
    activities: json["activities"],
    upcoming: json["upcoming"],
    discussions: json["discussions"],
    photos: json["photos"],
    interests: json["interests"],
  );

  Map<String, dynamic> toJson() => {
    "groups": groups,
    "activities": activities,
    "upcoming": upcoming,
    "discussions": discussions,
    "photos": photos,
    "interests": interests,
  };
}

class Summary {
  final String? title;
  final bool? beta;
  final String? info;

  Summary({
    this.title,
    this.beta,
    this.info,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    title: json["title"],
    beta: json["beta"],
    info: json["info"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "beta": beta,
    "info": info,
  };
}
