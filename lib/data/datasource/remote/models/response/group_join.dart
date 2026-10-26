import 'dart:convert';

GroupJoinResponse groupJoinResponseFromJson(String str) => GroupJoinResponse.fromJson(json.decode(str));



class GroupJoinResponse {
  final bool? success;
  final String? message;
  final JoinLeaveData? data;

  GroupJoinResponse({
    this.success,
    this.message,
    this.data,
  });

  factory GroupJoinResponse.fromJson(Map<String, dynamic> json) => GroupJoinResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : JoinLeaveData.fromJson(json["data"]),
  );
}

class JoinLeaveData {
  final int? groupId;
  final int? cityId;
  final int? templateId;
  final bool? isVirtual;
  final bool? isJoined;
  final bool? canLeave;
  final bool? canJoin;
  final int? membersCount;
  final String? membersLabel;

  JoinLeaveData({
    this.groupId,
    this.cityId,
    this.templateId,
    this.isVirtual,
    this.isJoined,
    this.canLeave,
    this.canJoin,
    this.membersCount,
    this.membersLabel,
  });

  factory JoinLeaveData.fromJson(Map<String, dynamic> json) => JoinLeaveData(
    groupId: json["group_id"],
    cityId: json["city_id"],
    templateId: json["template_id"],
    isVirtual: json["is_virtual"],
    isJoined: json["is_joined"],
    canLeave: json["can_leave"],
    canJoin: json["can_join"],
    membersCount: json["members_count"],
    membersLabel: json["members_label"],
  );

}
