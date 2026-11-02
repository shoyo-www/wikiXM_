import 'dart:convert';

MyGroupInvitationsResponse myGroupInvitationsResponseFromJson(String str) => MyGroupInvitationsResponse.fromJson(json.decode(str));

class MyGroupInvitationsResponse {
  final bool? success;
  final String? message;
  final List<InvitationItem>? items;

  MyGroupInvitationsResponse({
    this.success,
    this.message,
    this.items,
  });

  factory MyGroupInvitationsResponse.fromJson(Map<String, dynamic> json) => MyGroupInvitationsResponse(
    success: json["success"],
    message: json["message"],
    items: json["data"]?["items"] == null ? [] : List<InvitationItem>.from(json["data"]["items"].map((x) => InvitationItem.fromJson(x))),
  );
}

class InvitationItem {
  final int? invitationId;
  final String? type;
  final int? groupId;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? invitedAt;

  InvitationItem({
    this.invitationId,
    this.type,
    this.groupId,
    this.name,
    this.description,
    this.imageUrl,
    this.invitedAt,
  });

  factory InvitationItem.fromJson(Map<String, dynamic> json) => InvitationItem(
    invitationId: json["invitation_id"],
    type: json["type"],
    groupId: json["group_id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["image_url"],
    invitedAt: json["invited_at"],
  );
}
