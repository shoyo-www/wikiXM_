import 'dart:convert';

import 'my_group_list.dart';

MyGroupActivitiesResponse myGroupActivitiesResponseFromJson(String str) => MyGroupActivitiesResponse.fromJson(json.decode(str));

class MyGroupActivitiesResponse {
  final bool? success;
  final String? message;
  final List<MyActivityItem>? items;

  MyGroupActivitiesResponse({
    this.success,
    this.message,
    this.items,
  });

  factory MyGroupActivitiesResponse.fromJson(Map<String, dynamic> json) => MyGroupActivitiesResponse(
    success: json["success"],
    message: json["message"],
    items: json["data"]?["items"] == null ? [] : List<MyActivityItem>.from(json["data"]["items"].map((x) => MyActivityItem.fromJson(x))),
  );
}

class MyActivityItem {
  final int? activityId;
  final int? cityId;
  final int? groupId;
  final String? groupName;
  final String? title;
  final String? startsAt;
  final String? location;
  final String? town;
  final MyGroupImage? image;
  final String? attendanceStatus;
  final int? goingCount;
  final bool? isOrganizer;

  MyActivityItem({
    this.activityId,
    this.cityId,
    this.groupId,
    this.groupName,
    this.title,
    this.startsAt,
    this.location,
    this.town,
    this.image,
    this.attendanceStatus,
    this.goingCount,
    this.isOrganizer,
  });

  factory MyActivityItem.fromJson(Map<String, dynamic> json) => MyActivityItem(
    activityId: json["activity_id"],
    cityId: json["city_id"],
    groupId: json["group_id"],
    groupName: json["group_name"],
    title: json["title"],
    startsAt: json["starts_at"],
    location: json["location"],
    town: json["town"],
    image: json["image"] == null ? null : MyGroupImage.fromJson(json["image"]),
    attendanceStatus: json["attendance_status"],
    goingCount: json["going_count"],
    isOrganizer: json["is_organizer"],
  );
}
