import 'dart:convert';

GroupDetailResponse groupDetailResponseFromJson(String str) => GroupDetailResponse.fromJson(json.decode(str));

String groupDetailResponseToJson(GroupDetailResponse data) => json.encode(data.toJson());

class GroupDetailResponse {
  final bool? success;
  final String? message;
  final GroupDetailData? data;

  GroupDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  factory GroupDetailResponse.fromJson(Map<String, dynamic> json) => GroupDetailResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : GroupDetailData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class GroupDetailData {
  final Profile? profile;
  final Group? group;
  final bool? canRead;
  final Map<String, bool>? permissions;
  final About? about;
  final List<Post>? posts;
  final List<Activity>? activities;
  final List<Member>? members;
  final Coverage? coverage;
  final Stats? stats;
  final Pagination? pagination;
  final bool? hasMore;
  final List<Avatar>? gallery;

  GroupDetailData({
    this.profile,
    this.group,
    this.canRead,
    this.permissions,
    this.about,
    this.posts,
    this.activities,
    this.members,
    this.coverage,
    this.stats,
    this.pagination,
    this.hasMore,
    this.gallery,
  });

  factory GroupDetailData.fromJson(Map<String, dynamic> json) => GroupDetailData(
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    group: json["group"] == null ? null : Group.fromJson(json["group"]),
    canRead: json["can_read"],
    permissions: json["permissions"] == null ? null : Map.from(json["permissions"]).map((k, v) => MapEntry<String, bool>(k, v)),
    about: json["about"] == null ? null : About.fromJson(json["about"]),
    posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
    activities: json["activities"] == null ? [] : List<Activity>.from(json["activities"]!.map((x) => Activity.fromJson(x))),
    members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
    coverage: json["coverage"] == null ? null : Coverage.fromJson(json["coverage"]),
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    hasMore: json["has_more"],
    gallery: json["gallery"] == null ? [] : List<Avatar>.from(json["gallery"]!.map((x) => Avatar.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile?.toJson(),
    "group": group?.toJson(),
    "can_read": canRead,
    "permissions": permissions == null ? null : Map.from(permissions!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "about": about?.toJson(),
    "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
    "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toJson())),
    "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x.toJson())),
    "coverage": coverage?.toJson(),
    "stats": stats?.toJson(),
    "pagination": pagination?.toJson(),
    "has_more": hasMore,
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x.toJson())),
  };
}

class Post {
  final int? id;
  final int? groupId;
  final int? userId;
  final String? kind;
  final String? title;
  final String? body;
  final String? topic;
  final String? url;
  final String? imagePath;
  final int? status;
  final int? isPinned;
  final DateTime? createdAt;
  final String? updatedAt;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final int? isSaved;
  final String? authorRoleLabel;
  final int? likesCount;
  final int? commentsCount;
  final int? isLiked;
  final String? createdAtLabel;
  final String? createdAtFull;
  final String? avatar;
  final String? image;

  Post({
    this.id,
    this.groupId,
    this.userId,
    this.kind,
    this.title,
    this.body,
    this.topic,
    this.url,
    this.imagePath,
    this.status,
    this.isPinned,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.isSaved,
    this.authorRoleLabel,
    this.likesCount,
    this.commentsCount,
    this.isLiked,
    this.createdAtLabel,
    this.createdAtFull,
    this.avatar,
    this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    groupId: json["group_id"],
    userId: json["user_id"],
    kind: json["kind"],
    title: json["title"],
    body: json["body"],
    topic: json["topic"],
    url: json["url"],
    imagePath: json["image_path"],
    status: json["status"],
    isPinned: json["is_pinned"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    profileImage: json["profile_image"],
    isSaved: json["is_saved"],
    authorRoleLabel: json["author_role_label"],
    likesCount: json["likes_count"],
    commentsCount: json["comments_count"],
    isLiked: json["is_liked"],
    createdAtLabel: json["created_at_label"],
    createdAtFull: json["created_at_full"],
    avatar: json["avatar"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "group_id": groupId,
    "user_id": userId,
    "kind": kind,
    "title": title,
    "body": body,
    "topic": topic,
    "url": url,
    "image_path": imagePath,
    "status": status,
    "is_pinned": isPinned,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
    "first_name": firstName,
    "last_name": lastName,
    "profile_image": profileImage,
    "is_saved": isSaved,
    "author_role_label": authorRoleLabel,
    "likes_count": likesCount,
    "comments_count": commentsCount,
    "is_liked": isLiked,
    "created_at_label": createdAtLabel,
    "created_at_full": createdAtFull,
    "avatar": avatar,
    "image": image,
  };
}

class About {
  final String? description;

  About({
    this.description,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
  };
}

class Activity {
  final String? id;
  final int? activityId;
  final String? slug;
  final String? detailUrl;
  final int? createdBy;
  final int? groupId;
  final int? cityId;
  final String? title;
  final String? description;
  final double? latitude;
  final double? longitude;
  final String? searchable;
  final List<String>? interestIds;
  final Avatar? image;
  final Badge? badge;
  final List<Detail>? details;
  final DateTime? startsAt;
  final int? goingCount;
  final int? spotsAvailable;
  final List<Avatar>? attendees;
  final String? attendanceStatus;
  final bool? isOrganizer;
  final bool? canJoin;
  final bool? isJoined;
  final bool? isInterested;
  final bool? canInterest;
  final bool? canLeave;

  Activity({
    this.id,
    this.activityId,
    this.slug,
    this.detailUrl,
    this.createdBy,
    this.groupId,
    this.cityId,
    this.title,
    this.description,
    this.latitude,
    this.longitude,
    this.searchable,
    this.interestIds,
    this.image,
    this.badge,
    this.details,
    this.startsAt,
    this.goingCount,
    this.spotsAvailable,
    this.attendees,
    this.attendanceStatus,
    this.isOrganizer,
    this.canJoin,
    this.isJoined,
    this.isInterested,
    this.canInterest,
    this.canLeave,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: json["id"],
    activityId: json["activity_id"],
    slug: json["slug"],
    detailUrl: json["detail_url"],
    createdBy: json["created_by"],
    groupId: json["group_id"],
    cityId: json["city_id"],
    title: json["title"],
    description: json["description"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    searchable: json["searchable"],
    interestIds: json["interest_ids"] == null ? [] : List<String>.from(json["interest_ids"]!.map((x) => x)),
    image: json["image"] == null ? null : Avatar.fromJson(json["image"]),
    badge: json["badge"] == null ? null : Badge.fromJson(json["badge"]),
    details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
    startsAt: json["starts_at"] == null ? null : DateTime.parse(json["starts_at"]),
    goingCount: json["going_count"],
    spotsAvailable: json["spots_available"],
    attendees: json["attendees"] == null ? [] : List<Avatar>.from(json["attendees"]!.map((x) => Avatar.fromJson(x))),
    attendanceStatus: json["attendance_status"],
    isOrganizer: json["is_organizer"],
    canJoin: json["can_join"],
    isJoined: json["is_joined"],
    isInterested: json["is_interested"],
    canInterest: json["can_interest"],
    canLeave: json["can_leave"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "activity_id": activityId,
    "slug": slug,
    "detail_url": detailUrl,
    "created_by": createdBy,
    "group_id": groupId,
    "city_id": cityId,
    "title": title,
    "description": description,
    "latitude": latitude,
    "longitude": longitude,
    "searchable": searchable,
    "interest_ids": interestIds == null ? [] : List<dynamic>.from(interestIds!.map((x) => x)),
    "image": image?.toJson(),
    "badge": badge?.toJson(),
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
    "starts_at": startsAt?.toIso8601String(),
    "going_count": goingCount,
    "spots_available": spotsAvailable,
    "attendees": attendees == null ? [] : List<dynamic>.from(attendees!.map((x) => x.toJson())),
    "attendance_status": attendanceStatus,
    "is_organizer": isOrganizer,
    "can_join": canJoin,
    "is_joined": isJoined,
    "is_interested": isInterested,
    "can_interest": canInterest,
    "can_leave": canLeave,
  };
}

class Avatar {
  final String? url;
  final String? alt;
  final int? width;
  final int? height;

  Avatar({
    this.url,
    this.alt,
    this.width,
    this.height,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "text": text,
  };
}

class Coverage {
  final double? latitude;
  final double? longitude;

  Coverage({
    this.latitude,
    this.longitude,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) => Coverage(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Group {
  final int? groupId;
  final dynamic templateId;
  final String? slug;
  final int? cityId;
  final String? name;
  final String? description;
  final String? town;
  final int? radiusMiles;
  final String? privacy;
  final bool? requiresApproval;
  final Avatar? cover;
  final Avatar? avatar;
  final Interest? interest;
  final int? membersCount;
  final List<Avatar>? avatars;
  final bool? isJoined;
  final bool? isRequested;
  final bool? canLeave;
  final bool? canJoin;
  final bool? isOwner;

  Group({
    this.groupId,
    this.templateId,
    this.slug,
    this.cityId,
    this.name,
    this.description,
    this.town,
    this.radiusMiles,
    this.privacy,
    this.requiresApproval,
    this.cover,
    this.avatar,
    this.interest,
    this.membersCount,
    this.avatars,
    this.isJoined,
    this.isRequested,
    this.canLeave,
    this.canJoin,
    this.isOwner
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    groupId: json["group_id"],
    templateId: json["template_id"],
    slug: json["slug"],
    cityId: json["city_id"],
    name: json["name"],
    description: json["description"],
    town: json["town"],
    radiusMiles: json["radius_miles"],
    privacy: json["privacy"],
    requiresApproval: json["requires_approval"],
    cover: json["cover"] == null ? null : Avatar.fromJson(json["cover"]),
    avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
    interest: json["interest"] == null ? null : Interest.fromJson(json["interest"]),
    membersCount: json["members_count"],
    avatars: json["avatars"] == null ? [] : List<Avatar>.from(json["avatars"]!.map((x) => Avatar.fromJson(x))),
    isJoined: json["is_joined"],
    isRequested: json["is_requested"],
    canLeave: json["can_leave"],
    canJoin: json["can_join"],
    isOwner: json['is_owner']
  );

  Map<String, dynamic> toJson() => {
    "group_id": groupId,
    "template_id": templateId,
    "slug": slug,
    "city_id": cityId,
    "name": name,
    "description": description,
    "town": town,
    "radius_miles": radiusMiles,
    "privacy": privacy,
    "requires_approval": requiresApproval,
    "cover": cover?.toJson(),
    "avatar": avatar?.toJson(),
    "interest": interest?.toJson(),
    "members_count": membersCount,
    "avatars": avatars == null ? [] : List<dynamic>.from(avatars!.map((x) => x.toJson())),
    "is_joined": isJoined,
    "is_requested": isRequested,
    "can_leave": canLeave,
    "can_join": canJoin,
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

class Member {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final int? role;
  final String? avatar;
  final String? roleLabel;
  final String? town;

  Member({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.role,
    this.avatar,
    this.roleLabel,
    this.town,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    role: json["role"],
    avatar: json["avatar"],
    roleLabel: json["role_label"],
    town: json["town"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "role": role,
    "avatar": avatar,
    "role_label": roleLabel,
    "town": town,
  };
}

class Pagination {
  final bool? posts;
  final bool? activities;
  final bool? members;

  Pagination({
    this.posts,
    this.activities,
    this.members,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    posts: json["posts"],
    activities: json["activities"],
    members: json["members"],
  );

  Map<String, dynamic> toJson() => {
    "posts": posts,
    "activities": activities,
    "members": members,
  };
}

class Profile {
  final String? activitySearchLabel;
  final String? activityLabel;
  final String? activityAction;
  final String? peopleLabel;
  final String? peopleAction;
  final DetailFields? detailFields;
  final List<Topic>? topics;
  final List<Tab>? tabs;
  final List<Tab>? discussionTabs;

  Profile({
    this.activitySearchLabel,
    this.activityLabel,
    this.activityAction,
    this.peopleLabel,
    this.peopleAction,
    this.detailFields,
    this.topics,
    this.tabs,
    this.discussionTabs,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    activitySearchLabel: json["activity_search_label"],
    activityLabel: json["activity_label"],
    activityAction: json["activity_action"],
    peopleLabel: json["people_label"],
    peopleAction: json["people_action"],
    detailFields: json["detail_fields"] == null ? null : DetailFields.fromJson(json["detail_fields"]),
    topics: json["topics"] == null ? [] : List<Topic>.from(json["topics"]!.map((x) => Topic.fromJson(x))),
    tabs: json["tabs"] == null ? [] : List<Tab>.from(json["tabs"]!.map((x) => Tab.fromJson(x))),
    discussionTabs: json["discussion_tabs"] == null ? [] : List<Tab>.from(json["discussion_tabs"]!.map((x) => Tab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "activity_search_label": activitySearchLabel,
    "activity_label": activityLabel,
    "activity_action": activityAction,
    "people_label": peopleLabel,
    "people_action": peopleAction,
    "detail_fields": detailFields?.toJson(),
    "topics": topics == null ? [] : List<dynamic>.from(topics!.map((x) => x.toJson())),
    "tabs": tabs == null ? [] : List<dynamic>.from(tabs!.map((x) => x.toJson())),
    "discussion_tabs": discussionTabs == null ? [] : List<dynamic>.from(discussionTabs!.map((x) => x.toJson())),
  };
}

class DetailFields {
  final Bring? meetingNotes;
  final Bring? bring;

  DetailFields({
    this.meetingNotes,
    this.bring,
  });

  factory DetailFields.fromJson(Map<String, dynamic> json) => DetailFields(
    meetingNotes: json["meeting_notes"] == null ? null : Bring.fromJson(json["meeting_notes"]),
    bring: json["bring"] == null ? null : Bring.fromJson(json["bring"]),
  );

  Map<String, dynamic> toJson() => {
    "meeting_notes": meetingNotes?.toJson(),
    "bring": bring?.toJson(),
  };
}

class Bring {
  final String? label;
  final String? icon;

  Bring({
    this.label,
    this.icon,
  });

  factory Bring.fromJson(Map<String, dynamic> json) => Bring(
    label: json["label"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "icon": icon,
  };
}

class Tab {
  final String? id;
  final String? label;
  final String? icon;

  Tab({
    this.id,
    this.label,
    this.icon,
  });

  factory Tab.fromJson(Map<String, dynamic> json) => Tab(
    id: json["id"],
    label: json["label"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "icon": icon,
  };
}

class Topic {
  final String? id;
  final String? label;

  Topic({
    this.id,
    this.label,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    id: json["id"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
  };
}

class Stats {
  final int? activities;
  final int? posts;

  Stats({
    this.activities,
    this.posts,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    activities: json["activities"],
    posts: json["posts"],
  );

  Map<String, dynamic> toJson() => {
    "activities": activities,
    "posts": posts,
  };
}
