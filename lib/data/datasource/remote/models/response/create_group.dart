import 'dart:convert';

CreateGroupOptionsResponse createGroupOptionsResponseFromJson(String str) => CreateGroupOptionsResponse.fromJson(json.decode(str));

GroupCoverageResponse groupCoverageResponseFromJson(String str) => GroupCoverageResponse.fromJson(json.decode(str));

GroupCreatedResponse groupCreatedResponseFromJson(String str) => GroupCreatedResponse.fromJson(json.decode(str));

InvitationRecipientsResponse invitationRecipientsResponseFromJson(String str) => InvitationRecipientsResponse.fromJson(json.decode(str));

List<T> _list<T>(dynamic value, T Function(Map<String, dynamic>) parse) => value is List ? value.whereType<Map<String, dynamic>>().map(parse).toList() : [];

class CreateGroupOptionsResponse {
  final bool? success;
  final String? message;
  final CreateGroupOptions? data;

  CreateGroupOptionsResponse({this.success, this.message, this.data});

  factory CreateGroupOptionsResponse.fromJson(Map<String, dynamic> json) => CreateGroupOptionsResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : CreateGroupOptions.fromJson(json["data"]),
  );
}

class CreateGroupOptions {
  final List<GroupTown> towns;
  final List<int> radiusOptions;
  final List<GroupCategory> categories;
  final List<GroupInterest> interests;
  final GroupFormOptions formOptions;
  final List<String> coverImages;
  final int? locationId;

  CreateGroupOptions({required this.towns, required this.radiusOptions, required this.categories, required this.interests, required this.formOptions, required this.coverImages, this.locationId});

  factory CreateGroupOptions.fromJson(Map<String, dynamic> json) => CreateGroupOptions(
    towns: _list(json["towns"], GroupTown.fromJson),
    radiusOptions: json["radius_options"] is List ? List<int>.from(json["radius_options"].map((x) => (x as num).toInt())) : [],
    categories: _list(json["categories"], GroupCategory.fromJson),
    interests: _list(json["interests"], GroupInterest.fromJson),
    formOptions: GroupFormOptions.fromJson(json["form_options"] ?? {}),
    // shortcut: staging returns an empty list, so the item shape is unknown; reads a plain URL or {url}
    coverImages: json["cover_images"] is List ? List<String>.from(json["cover_images"].map((x) => x is Map ? x["url"] : x).whereType<String>()) : [],
    locationId: json["location"]?["id"],
  );
}

class GroupTown {
  final int? id;
  final String? name;
  final bool? isPrimary;
  final double? distanceMiles;
  final double? latitude;
  final double? longitude;
  final String? cityImage;
  final String? cityFallbackImage;
  final int? population;

  GroupTown({this.id, this.name, this.isPrimary, this.distanceMiles, this.latitude, this.longitude, this.cityImage, this.cityFallbackImage, this.population});

  factory GroupTown.fromJson(Map<String, dynamic> json) => GroupTown(
    id: json["id"],
    name: json["name"],
    isPrimary: json["is_primary"],
    distanceMiles: (json["distance_miles"] as num?)?.toDouble(),
    latitude: (json["latitude"] as num?)?.toDouble(),
    longitude: (json["longitude"] as num?)?.toDouble(),
    cityImage: json["city_image"],
    cityFallbackImage: json["city_fallback_image"],
    population: json["population"],
  );
}

class GroupCategory {
  final int? id;
  final int? parentId;
  final String? name;

  GroupCategory({this.id, this.parentId, this.name});

  factory GroupCategory.fromJson(Map<String, dynamic> json) => GroupCategory(id: json["id"], parentId: json["parent_id"], name: json["name"]);
}

class GroupInterest {
  final int? id;
  final int? categoryId;
  final String? name;

  GroupInterest({this.id, this.categoryId, this.name});

  factory GroupInterest.fromJson(Map<String, dynamic> json) => GroupInterest(id: json["interest_id"], categoryId: json["category_id"], name: json["name"]);
}

class GroupFormOptions {
  final GroupFieldLimits additionalGuidelines;
  final GroupFieldLimits joiningQuestions;
  final List<GroupFormOption> audience;
  final List<GroupFormOption> audienceSkill;
  final List<GroupFormOption> audienceType;
  final List<GroupFormOption> groupPrivacy;
  final List<GroupFormOption> membershipApproval;
  final List<GroupFormOption> memberPermissions;
  final List<GroupFormOption> topics;
  final List<GroupFormOption> moderation;
  final List<GroupFormOption> rules;
  final List<GroupFormOption> sharingOptions;

  GroupFormOptions({
    required this.additionalGuidelines,
    required this.joiningQuestions,
    required this.audience,
    required this.audienceSkill,
    required this.audienceType,
    required this.groupPrivacy,
    required this.membershipApproval,
    required this.memberPermissions,
    required this.topics,
    required this.moderation,
    required this.rules,
    required this.sharingOptions,
  });

  factory GroupFormOptions.fromJson(Map<String, dynamic> json) => GroupFormOptions(
    additionalGuidelines: GroupFieldLimits.fromJson(json["additionalGuidelines"] ?? {}),
    joiningQuestions: GroupFieldLimits.fromJson(json["joiningQuestions"] ?? {}),
    audience: _list(json["audience"], GroupFormOption.fromJson),
    audienceSkill: _list(json["audienceSkill"], GroupFormOption.fromJson),
    audienceType: _list(json["audienceType"], GroupFormOption.fromJson),
    groupPrivacy: _list(json["groupPrivacy"], GroupFormOption.fromJson),
    membershipApproval: _list(json["membershipApproval"], GroupFormOption.fromJson),
    memberPermissions: _list(json["memberPermissions"], GroupFormOption.fromJson),
    topics: _list(json["topics"], GroupFormOption.fromJson),
    moderation: _list(json["moderation"], GroupFormOption.fromJson),
    rules: _list(json["rules"], GroupFormOption.fromJson),
    sharingOptions: _list(json["sharingOptions"], GroupFormOption.fromJson),
  );
}

class GroupFieldLimits {
  final int max;
  final int? maxLength;
  final List<String> placeholders;

  GroupFieldLimits({required this.max, this.maxLength, required this.placeholders});

  factory GroupFieldLimits.fromJson(Map<String, dynamic> json) => GroupFieldLimits(
    max: json["max"] ?? 3,
    maxLength: json["maxLength"],
    placeholders: json["placeholders"] is List ? List<String>.from(json["placeholders"]) : [],
  );
}

class GroupFormOption {
  final String value;
  final String label;
  final String? description;
  final String? icon;
  final bool defaultChecked;
  final String? membership;
  final String? setting;
  final String? permission;

  GroupFormOption({required this.value, required this.label, this.description, this.icon, this.defaultChecked = false, this.membership, this.setting, this.permission});

  factory GroupFormOption.fromJson(Map<String, dynamic> json) => GroupFormOption(
    value: json["value"]?.toString() ?? '',
    label: json["label"] ?? '',
    description: json["description"],
    icon: json["icon"],
    defaultChecked: json["defaultChecked"] == true,
    membership: json["membership"],
    setting: json["setting"],
    permission: json["permission"],
  );
}

class GroupCoverageResponse {
  final bool? success;
  final List<GroupTown> towns;

  GroupCoverageResponse({this.success, required this.towns});

  factory GroupCoverageResponse.fromJson(Map<String, dynamic> json) => GroupCoverageResponse(success: json["success"], towns: _list(json["data"]?["towns"], GroupTown.fromJson));
}

class GroupCreatedResponse {
  final bool? success;
  final GroupCreatedData? data;

  GroupCreatedResponse({this.success, this.data});

  factory GroupCreatedResponse.fromJson(Map<String, dynamic> json) => GroupCreatedResponse(success: json["success"], data: json["data"] == null ? null : GroupCreatedData.fromJson(json["data"]));
}

class GroupCreatedData {
  final int? id;
  final String? name;
  final String? description;
  final String? privacyLabel;
  final int? radiusMiles;
  final String? coverUrl;
  final String? avatarUrl;
  final String? url;
  final String? townName;
  final String? stateAbbreviation;
  final String? organizerFirstName;
  final List<String> interests;
  final int members;
  final int posts;
  final int activities;

  GroupCreatedData({this.id, this.name, this.description, this.privacyLabel, this.radiusMiles, this.coverUrl, this.avatarUrl, this.url, this.townName, this.stateAbbreviation, this.organizerFirstName, required this.interests, this.members = 0, this.posts = 0, this.activities = 0});

  factory GroupCreatedData.fromJson(Map<String, dynamic> json) {
    final group = json["group"] ?? {};
    final counts = json["counts"] ?? {};
    return GroupCreatedData(
      id: group["id"],
      name: group["name"],
      description: group["description"],
      privacyLabel: group["privacy_label"],
      radiusMiles: group["radius_miles"],
      coverUrl: group["cover"]?["url"],
      avatarUrl: group["avatar"]?["url"],
      url: group["url"],
      townName: json["town"]?["name"],
      stateAbbreviation: json["town"]?["state_abbreviation"],
      organizerFirstName: json["organizer"]?["first_name"],
      interests: json["interests"] is List ? List<String>.from(json["interests"].map((x) => x["name"]).whereType<String>()) : [],
      members: counts["members"] ?? 0,
      posts: counts["posts"] ?? 0,
      activities: counts["activities"] ?? 0,
    );
  }
}

class InvitationRecipientsResponse {
  final bool? success;
  final List<InvitationRecipient> items;
  final bool hasMore;

  InvitationRecipientsResponse({this.success, required this.items, this.hasMore = false});

  factory InvitationRecipientsResponse.fromJson(Map<String, dynamic> json) => InvitationRecipientsResponse(
    success: json["success"],
    items: _list(json["data"]?["items"], InvitationRecipient.fromJson),
    hasMore: json["data"]?["has_more"] == true,
  );
}

class InvitationRecipient {
  final int? id;
  final String? name;
  final String? username;
  final String? avatarUrl;
  final String? town;

  InvitationRecipient({this.id, this.name, this.username, this.avatarUrl, this.town});

  /// Staging returns some users with an empty name.
  String get displayName => (name?.isNotEmpty ?? false) ? name! : '@${username ?? ''}';

  factory InvitationRecipient.fromJson(Map<String, dynamic> json) => InvitationRecipient(id: json["id"], name: json["name"], username: json["username"], avatarUrl: json["avatar_url"], town: json["town"]);
}
