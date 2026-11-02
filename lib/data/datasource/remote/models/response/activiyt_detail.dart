import 'dart:convert';

GroupActivityResponse groupActivityResponseFromJson(String str) => GroupActivityResponse.fromJson(json.decode(str));

String groupActivityResponseToJson(GroupActivityResponse data) => json.encode(data.toJson());

class GroupActivityResponse {
  final bool? success;
  final String? message;
  final ActivityDetailData? data;

  GroupActivityResponse({
    this.success,
    this.message,
    this.data,
  });

  factory GroupActivityResponse.fromJson(Map<String, dynamic> json) => GroupActivityResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : ActivityDetailData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class ActivityDetailData {
  final Activity? activity;
  final bool? isPublic;
  final List<Tab>? tabs;
  final String? label;
  final Interest? interest;
  final List<Field>? fields;
  final String? startsAtLabel;
  final dynamic endsAtLabel;
  final String? timezone;
  final int? capacity;
  final bool? hasStarted;
  final dynamic venueAddress;
  final Organizer? organizer;
  final List<dynamic>? participants;
  final Group? group;

  ActivityDetailData({
    this.activity,
    this.isPublic,
    this.tabs,
    this.label,
    this.interest,
    this.fields,
    this.startsAtLabel,
    this.endsAtLabel,
    this.timezone,
    this.capacity,
    this.hasStarted,
    this.venueAddress,
    this.organizer,
    this.participants,
    this.group,
  });

  factory ActivityDetailData.fromJson(Map<String, dynamic> json) => ActivityDetailData(
    activity: json["activity"] == null ? null : Activity.fromJson(json["activity"]),
    isPublic: json["is_public"],
    tabs: json["tabs"] == null ? [] : List<Tab>.from(json["tabs"]!.map((x) => Tab.fromJson(x))),
    label: json["label"],
    interest: json["interest"] == null ? null : Interest.fromJson(json["interest"]),
    fields: json["fields"] == null ? [] : List<Field>.from(json["fields"]!.map((x) => Field.fromJson(x))),
    startsAtLabel: json["starts_at_label"],
    endsAtLabel: json["ends_at_label"],
    timezone: json["timezone"],
    capacity: json["capacity"],
    hasStarted: json["has_started"],
    venueAddress: json["venue_address"],
    organizer: json["organizer"] == null ? null : Organizer.fromJson(json["organizer"]),
    participants: json["participants"] == null ? [] : List<dynamic>.from(json["participants"]!.map((x) => x)),
    group: json["group"] == null ? null : Group.fromJson(json["group"]),
  );

  Map<String, dynamic> toJson() => {
    "activity": activity?.toJson(),
    "is_public": isPublic,
    "tabs": tabs == null ? [] : List<dynamic>.from(tabs!.map((x) => x.toJson())),
    "label": label,
    "interest": interest?.toJson(),
    "fields": fields == null ? [] : List<dynamic>.from(fields!.map((x) => x.toJson())),
    "starts_at_label": startsAtLabel,
    "ends_at_label": endsAtLabel,
    "timezone": timezone,
    "capacity": capacity,
    "has_started": hasStarted,
    "venue_address": venueAddress,
    "organizer": organizer?.toJson(),
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x)),
    "group": group?.toJson(),
  };
}

class Activity {
  final int? activityId;
  final String? slug;
  final String? detailUrl;
  final int? createdBy;
  final int? cityId;
  final String? title;
  final String? description;
  final double? latitude;
  final double? longitude;
  final Image? image;
  final Badge? badge;
  final List<Field>? details;
  final DateTime? startsAt;
  final int? goingCount;
  final int? spotsAvailable;
  final String? attendanceStatus;
  final bool? isOrganizer;
  final bool? canJoin;
  final bool? isJoined;
  final bool? isInterested;
  final bool? canInterest;
  final bool? canLeave;

  Activity({
    this.activityId,
    this.slug,
    this.detailUrl,
    this.createdBy,
    this.cityId,
    this.title,
    this.description,
    this.latitude,
    this.longitude,
    this.image,
    this.badge,
    this.details,
    this.startsAt,
    this.goingCount,
    this.spotsAvailable,
    this.attendanceStatus,
    this.isOrganizer,
    this.canJoin,
    this.isJoined,
    this.isInterested,
    this.canInterest,
    this.canLeave,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    activityId: json["activity_id"],
    slug: json["slug"],
    detailUrl: json["detail_url"],
    createdBy: json["created_by"],
    cityId: json["city_id"],
    title: json["title"],
    description: json["description"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    badge: json["badge"] == null ? null : Badge.fromJson(json["badge"]),
    details: json["details"] == null ? [] : List<Field>.from(json["details"]!.map((x) => Field.fromJson(x))),
    startsAt: json["starts_at"] == null ? null : DateTime.parse(json["starts_at"]),
    goingCount: json["going_count"],
    spotsAvailable: json["spots_available"],
    attendanceStatus: json["attendance_status"],
    isOrganizer: json["is_organizer"],
    canJoin: json["can_join"],
    isJoined: json["is_joined"],
    isInterested: json["is_interested"],
    canInterest: json["can_interest"],
    canLeave: json["can_leave"],
  );

  Map<String, dynamic> toJson() => {
    "activity_id": activityId,
    "slug": slug,
    "detail_url": detailUrl,
    "created_by": createdBy,
    "city_id": cityId,
    "title": title,
    "description": description,
    "latitude": latitude,
    "longitude": longitude,
    "image": image?.toJson(),
    "badge": badge?.toJson(),
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
    "starts_at": startsAt?.toIso8601String(),
    "going_count": goingCount,
    "spots_available": spotsAvailable,
    "attendance_status": attendanceStatus,
    "is_organizer": isOrganizer,
    "can_join": canJoin,
    "is_joined": isJoined,
    "is_interested": isInterested,
    "can_interest": canInterest,
    "can_leave": canLeave,
  };
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

  Map<String, dynamic> toJson() => {
    "label": label,
    "color": color,
  };
}

class Field {
  final String? id;
  final String? icon;
  final String? text;
  final String? label;

  Field({
    this.id,
    this.icon,
    this.text,
    this.label,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    id: json["id"],
    icon: json["icon"],
    text: json["text"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "text": text,
    "label": label,
  };
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

  Map<String, dynamic> toJson() => {
    "url": url,
    "alt": alt,
    "width": width,
    "height": height,
  };
}

class Group {
  final String? name;
  final String? slug;

  Group({
    this.name,
    this.slug,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
  };
}

class Interest {
  final String? slug;
  final String? name;
  final dynamic icon;

  Interest({
    this.slug,
    this.name,
    this.icon,
  });

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    slug: json["slug"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "name": name,
    "icon": icon,
  };
}

class Organizer {
  final int? id;
  final String? name;
  final Image? image;

  Organizer({
    this.id,
    this.name,
    this.image,
  });

  factory Organizer.fromJson(Map<String, dynamic> json) => Organizer(
    id: json["id"],
    name: json["name"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image?.toJson(),
  };
}

class Tab {
  final String? id;
  final String? label;
  final String? kind;
  final String? target;
  final String? icon;

  Tab({
    this.id,
    this.label,
    this.kind,
    this.target,
    this.icon,
  });

  factory Tab.fromJson(Map<String, dynamic> json) => Tab(
    id: json["id"],
    label: json["label"],
    kind: json["kind"],
    target: json["target"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "kind": kind,
    "target": target,
    "icon": icon,
  };
}
