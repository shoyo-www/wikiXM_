import 'dart:convert';

import 'group_sections.dart' show ActivitiesItem;
import 'search_group.dart' show Pagination;

GroupActivitiesResponse groupActivitiesResponseFromJson(String str) => GroupActivitiesResponse.fromJson(json.decode(str));

class GroupActivitiesResponse {
  final bool? success;
  final String? message;
  final GroupActivitiesData? data;

  GroupActivitiesResponse({this.success, this.message, this.data});

  factory GroupActivitiesResponse.fromJson(Map<String, dynamic> json) =>
      GroupActivitiesResponse(success: json["success"], message: json["message"], data: json["data"] == null ? null : GroupActivitiesData.fromJson(json["data"]));
}

class GroupActivitiesData {
  final List<ActivitiesItem>? items;
  final Pagination? pagination;
  final GroupActivitiesStatistics? statistics;
  final List<GroupActivitiesInterest>? interests;

  GroupActivitiesData({this.items, this.pagination, this.statistics, this.interests});

  factory GroupActivitiesData.fromJson(Map<String, dynamic> json) => GroupActivitiesData(
    items: json["items"] == null ? [] : List<ActivitiesItem>.from(json["items"]!.map((x) => ActivitiesItem.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    statistics: json["statistics"] == null ? null : GroupActivitiesStatistics.fromJson(json["statistics"]),
    interests: json["interests"] == null ? [] : List<GroupActivitiesInterest>.from(json["interests"]!.map((x) => GroupActivitiesInterest.fromJson(x))),
  );
}

class GroupActivitiesStatistics {
  final int? activities;
  final int? participants;
  final int? weekend;

  GroupActivitiesStatistics({this.activities, this.participants, this.weekend});

  factory GroupActivitiesStatistics.fromJson(Map<String, dynamic> json) => GroupActivitiesStatistics(activities: json["activities"], participants: json["participants"], weekend: json["weekend"]);
}

class GroupActivitiesInterest {
  final String? id;
  final String? name;
  final String? icon;
  final int? activityCount;

  GroupActivitiesInterest({this.id, this.name, this.icon, this.activityCount});

  factory GroupActivitiesInterest.fromJson(Map<String, dynamic> json) => GroupActivitiesInterest(id: json["id"], name: json["name"], icon: json["icon"], activityCount: json["activity_count"]);
}
