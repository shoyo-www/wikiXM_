import 'dart:convert';

MyGroupSummaryResponse myGroupSummaryResponseFromJson(String str) => MyGroupSummaryResponse.fromJson(json.decode(str));

class MyGroupSummaryResponse {
  final bool? success;
  final String? message;
  final MyGroupSummaryData? data;

  MyGroupSummaryResponse({
    this.success,
    this.message,
    this.data,
  });

  factory MyGroupSummaryResponse.fromJson(Map<String, dynamic> json) => MyGroupSummaryResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : MyGroupSummaryData.fromJson(json["data"]),
  );
}

class MyGroupSummaryData {
  final MyGroupFilters? filters;
  final MyGroupStats? stats;

  MyGroupSummaryData({
    this.filters,
    this.stats,
  });

  factory MyGroupSummaryData.fromJson(Map<String, dynamic> json) => MyGroupSummaryData(
    filters: json["filters"] == null ? null : MyGroupFilters.fromJson(json["filters"]),
    stats: json["stats"] == null ? null : MyGroupStats.fromJson(json["stats"]),
  );
}

class MyGroupFilters {
  final List<String>? interests;
  final List<String>? towns;

  MyGroupFilters({
    this.interests,
    this.towns,
  });

  factory MyGroupFilters.fromJson(Map<String, dynamic> json) => MyGroupFilters(
    interests: json["interests"] == null ? [] : List<String>.from(json["interests"].map((x) => x.toString())),
    towns: json["towns"] == null ? [] : List<String>.from(json["towns"].map((x) => x.toString())),
  );
}

class MyGroupStats {
  final int? managedGroups;
  final int? memberGroups;
  final int? totalGroups;
  final int? pendingInvitations;

  MyGroupStats({
    this.managedGroups,
    this.memberGroups,
    this.totalGroups,
    this.pendingInvitations,
  });

  factory MyGroupStats.fromJson(Map<String, dynamic> json) => MyGroupStats(
    managedGroups: json["managed_groups"],
    memberGroups: json["member_groups"],
    totalGroups: json["total_groups"],
    pendingInvitations: json["pending_invitations"],
  );
}
