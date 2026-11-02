import 'dart:convert';

GroupSectionsResponse groupSectionsResponseFromJson(String str) => GroupSectionsResponse.fromJson(json.decode(str));


class GroupSectionsResponse {
  final bool? success;
  final String? message;
  final GroupSectionData? data;

  GroupSectionsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory GroupSectionsResponse.fromJson(Map<String, dynamic> json) => GroupSectionsResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : GroupSectionData.fromJson(json["data"]),
  );
}

class GroupSectionData {
  final Activities? activities;
  final FeaturedGroups? featuredGroups;
  final People? people;
  final Nearby? nearby;

  GroupSectionData({
    this.activities,
    this.featuredGroups,
    this.people,
    this.nearby,
  });

  factory GroupSectionData.fromJson(Map<String, dynamic> json) => GroupSectionData(
    activities: json["activities"] == null ? null : Activities.fromJson(json["activities"]),
    featuredGroups: json["featured_groups"] == null ? null : FeaturedGroups.fromJson(json["featured_groups"]),
    people: json["people"] == null ? null : People.fromJson(json["people"]),
    nearby: json["nearby"] == null ? null : Nearby.fromJson(json["nearby"]),
  );
}

class Activities {
  final String? title;
  final String? description;
  final String? emptyMessage;
  final List<ActivitiesItem>? items;

  Activities({
    this.title,
    this.description,
    this.emptyMessage,
    this.items,
  });

  factory Activities.fromJson(Map<String, dynamic> json) => Activities(
    title: json["title"],
    description: json["description"],
    emptyMessage: json["empty_message"],
    items: json["items"] == null ? [] : List<ActivitiesItem>.from(json["items"]!.map((x) => ActivitiesItem.fromJson(x))),
  );
}

class ActivitiesItem {
  final String? id;
  final int? activityId;
  final int? createdBy;
  final int? groupId;
  final int? cityId;
  final String? title;
  final List<String>? interestIds;
  final Image? image;
  final Badge? badge;
  final List<Detail>? details;
  final DateTime? startsAt;
  final int? goingCount;
  final int? spotsAvailable;
  final List<Image>? attendees;
  final String? actionLabel;
  final String? attendanceStatus;
  final bool? canJoin;
  final bool? isJoined;

  ActivitiesItem({
    this.id,
    this.activityId,
    this.createdBy,
    this.groupId,
    this.cityId,
    this.title,
    this.interestIds,
    this.image,
    this.badge,
    this.details,
    this.startsAt,
    this.goingCount,
    this.spotsAvailable,
    this.attendees,
    this.actionLabel,
    this.attendanceStatus,
    this.canJoin,
    this.isJoined,
  });

  factory ActivitiesItem.fromJson(Map<String, dynamic> json) => ActivitiesItem(
    id: json["id"],
    activityId: json["activity_id"],
    createdBy: json["created_by"],
    groupId: json["group_id"],
    cityId: json["city_id"],
    title: json["title"],
    interestIds: json["interest_ids"] == null ? [] : List<String>.from(json["interest_ids"]!.map((x) => x)),
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    badge: json["badge"] == null ? null : Badge.fromJson(json["badge"]),
    details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
    startsAt: json["starts_at"] == null ? null : DateTime.parse(json["starts_at"]),
    goingCount: json["going_count"],
    spotsAvailable: json["spots_available"],
    attendees: json["attendees"] == null ? [] : List<Image>.from(json["attendees"]!.map((x) => Image.fromJson(x))),
    actionLabel: json["action_label"],
    attendanceStatus: json["attendance_status"],
    canJoin: json["can_join"],
    isJoined: json["is_joined"],
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

class Badge {
  final String? label;
  final String? color;

  Badge({
    this.label,
    this.color,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
    label: json["label"],
    color: json["color"],
  );
}

class Detail {
  final String? id;
  final String? icon;
  final String? text;

  Detail({
    this.id,
    this.icon,
    this.text,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    icon: json["icon"],
    text: json["text"],
  );
}

class FeaturedGroups {
  final String? title;
  final String? description;
  final String? emptyMessage;
  final List<FeaturedGroupsItem>? items;
  final int? total;

  FeaturedGroups({
    this.title,
    this.description,
    this.emptyMessage,
    this.items,
    this.total,
  });

  factory FeaturedGroups.fromJson(Map<String, dynamic> json) => FeaturedGroups(
    title: json["title"],
    description: json["description"],
    emptyMessage: json["empty_message"],
    items: json["items"] == null ? [] : List<FeaturedGroupsItem>.from(json["items"]!.map((x) => FeaturedGroupsItem.fromJson(x))),
    total: json["total"],
  );
}

class FeaturedGroupsItem {
  final String? id;
  final int? groupId;
  final int? templateId;
  final bool? isOwner;
  final bool? isVirtual;
  final String? title;
  final String? description;
  final List<String>? interestIds;
  final Image? image;
  int? membersCount;
  String? membersLabel;
  final List<dynamic>? avatars;
  bool? isJoined;
  bool? canJoin;

  FeaturedGroupsItem({
    this.id,
    this.groupId,
    this.templateId,
    this.isVirtual,
    this.title,
    this.description,
    this.interestIds,
    this.image,
    this.membersCount,
    this.membersLabel,
    this.avatars,
    this.isJoined,
    this.canJoin,
    this.isOwner
  });

  factory FeaturedGroupsItem.fromJson(Map<String, dynamic> json) => FeaturedGroupsItem(
    id: json["id"],
    groupId: json["group_id"],
    templateId: json["template_id"],
    isVirtual: json["is_virtual"],
    title: json["title"],
    description: json["description"],
    interestIds: json["interest_ids"] == null ? [] : List<String>.from(json["interest_ids"]!.map((x) => x)),
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    membersCount: json["members_count"],
    membersLabel: json["members_label"],
    avatars: json["avatars"] == null ? [] : List<dynamic>.from(json["avatars"]!.map((x) => x)),
    isJoined: json["is_joined"],
    canJoin: json["can_join"],
    isOwner: json['is_owner']
  );
}

class Nearby {
  final String? title;
  final MapClass? map;

  Nearby({
    this.title,
    this.map,
  });

  factory Nearby.fromJson(Map<String, dynamic> json) => Nearby(
    title: json["title"],
    map: json["map"] == null ? null : MapClass.fromJson(json["map"]),
  );
}

class MapClass {
  final String? label;
  final String? caption;
  final CenterData? center;
  final Zoom? zoom;
  final InitialPreview? initialPreview;
  final List<InitialPreview>? markers;

  MapClass({
    this.label,
    this.caption,
    this.center,
    this.zoom,
    this.initialPreview,
    this.markers,
  });

  factory MapClass.fromJson(Map<String, dynamic> json) => MapClass(
    label: json["label"],
    caption: json["caption"],
    center: json["center"] == null ? null : CenterData.fromJson(json["center"]),
    zoom: json["zoom"] == null ? null : Zoom.fromJson(json["zoom"]),
    initialPreview: json["initial_preview"] == null ? null : InitialPreview.fromJson(json["initial_preview"]),
    markers: json["markers"] == null ? [] : List<InitialPreview>.from(json["markers"]!.map((x) => InitialPreview.fromJson(x))),
  );
}

class CenterData {
  final double? latitude;
  final double? longitude;

  CenterData({
    this.latitude,
    this.longitude,
  });

  factory CenterData.fromJson(Map<String, dynamic> json) => CenterData(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );
}

class InitialPreview {
  final String? id;
  final int? activityId;
  final int? groupId;
  final String? name;
  final String? date;
  final String? place;
  final String? interestId;
  final String? icon;
  final String? color;
  final double? latitude;
  final double? longitude;
  final Image? image;

  InitialPreview({
    this.id,
    this.activityId,
    this.groupId,
    this.name,
    this.date,
    this.place,
    this.interestId,
    this.icon,
    this.color,
    this.latitude,
    this.longitude,
    this.image,
  });

  factory InitialPreview.fromJson(Map<String, dynamic> json) => InitialPreview(
    id: json["id"],
    activityId: json["activity_id"],
    groupId: json["group_id"],
    name: json["name"],
    date: json["date"],
    place: json["place"],
    interestId: json["interest_id"],
    icon: json["icon"],
    color: json["color"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );
}

class Zoom {
  final int? min;
  final int? max;
  final int? initial;
  final int? step;

  Zoom({
    this.min,
    this.max,
    this.initial,
    this.step,
  });

  factory Zoom.fromJson(Map<String, dynamic> json) => Zoom(
    min: json["min"],
    max: json["max"],
    initial: json["initial"],
    step: json["step"],
  );
}

class People {
  final String? title;
  final dynamic description;
  final String? emptyMessage;
  final List<PeopleItem>? items;

  People({
    this.title,
    this.description,
    this.emptyMessage,
    this.items,
  });

  factory People.fromJson(Map<String, dynamic> json) => People(
    title: json["title"],
    description: json["description"],
    emptyMessage: json["empty_message"],
    items: json["items"] == null ? [] : List<PeopleItem>.from(json["items"]!.map((x) => PeopleItem.fromJson(x))),
  );
}

class PeopleItem {
  final String? id;
  final int? requestId;
  final int? userId;
  final int? groupId;
  final int? cityId;
  final String? name;
  final String? description;
  final String? details;
  final List<String>? interestIds;
  final Image? image;
  final String? icon;
  final String? color;
  final bool? canConnect;
  final String? connectionStatus;

  PeopleItem({
    this.id,
    this.requestId,
    this.userId,
    this.groupId,
    this.cityId,
    this.name,
    this.description,
    this.details,
    this.interestIds,
    this.image,
    this.icon,
    this.color,
    this.canConnect,
    this.connectionStatus,
  });

  factory PeopleItem.fromJson(Map<String, dynamic> json) => PeopleItem(
    id: json["id"],
    requestId: json["request_id"],
    userId: json["user_id"],
    groupId: json["group_id"],
    cityId: json["city_id"],
    name: json["name"],
    description: json["description"],
    details: json["details"],
    interestIds: json["interest_ids"] == null ? [] : List<String>.from(json["interest_ids"]!.map((x) => x)),
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    icon: json["icon"],
    color: json["color"],
    canConnect: json["can_connect"],
    connectionStatus: json["connection_status"],
  );
}
