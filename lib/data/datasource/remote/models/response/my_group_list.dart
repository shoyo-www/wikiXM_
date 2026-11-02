import 'dart:convert';

MyGroupListResponse myGroupListResponseFromJson(String str) => MyGroupListResponse.fromJson(json.decode(str));

class MyGroupListResponse {
  final bool? success;
  final String? message;
  final MyGroupListData? data;

  MyGroupListResponse({
    this.success,
    this.message,
    this.data,
  });

  factory MyGroupListResponse.fromJson(Map<String, dynamic> json) => MyGroupListResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : MyGroupListData.fromJson(json["data"]),
  );
}

class MyGroupListData {
  final List<MyGroupItem>? items;
  final MyGroupPagination? pagination;

  MyGroupListData({
    this.items,
    this.pagination,
  });

  factory MyGroupListData.fromJson(Map<String, dynamic> json) => MyGroupListData(
    items: json["items"] == null ? [] : List<MyGroupItem>.from(json["items"].map((x) => MyGroupItem.fromJson(x))),
    pagination: json["pagination"] == null ? null : MyGroupPagination.fromJson(json["pagination"]),
  );
}

class MyGroupItem {
  final int? id;
  final String? slug;
  final String? name;
  final String? description;
  final MyGroupImage? image;
  final MyGroupInterest? interest;
  final MyGroupPrivacy? privacy;
  final MyGroupTown? town;
  final int? radiusMiles;
  final int? memberCount;
  final int? postCount;
  final int? upcomingActivityCount;
  final int? unreadPostCount;
  final String? role;
  final String? updatedAt;
  final String? detailUrl;

  MyGroupItem({
    this.id,
    this.slug,
    this.name,
    this.description,
    this.image,
    this.interest,
    this.privacy,
    this.town,
    this.radiusMiles,
    this.memberCount,
    this.postCount,
    this.upcomingActivityCount,
    this.unreadPostCount,
    this.role,
    this.updatedAt,
    this.detailUrl,
  });

  factory MyGroupItem.fromJson(Map<String, dynamic> json) => MyGroupItem(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    description: json["description"],
    image: json["image"] == null ? null : MyGroupImage.fromJson(json["image"]),
    interest: json["interest"] == null ? null : MyGroupInterest.fromJson(json["interest"]),
    privacy: json["privacy"] == null ? null : MyGroupPrivacy.fromJson(json["privacy"]),
    town: json["town"] == null ? null : MyGroupTown.fromJson(json["town"]),
    radiusMiles: json["radius_miles"],
    memberCount: json["member_count"],
    postCount: json["post_count"],
    upcomingActivityCount: json["upcoming_activity_count"],
    unreadPostCount: json["unread_post_count"],
    role: json["role"],
    updatedAt: json["updated_at"],
    detailUrl: json["detail_url"],
  );
}

class MyGroupImage {
  final String? url;
  final String? alt;

  MyGroupImage({
    this.url,
    this.alt,
  });

  factory MyGroupImage.fromJson(Map<String, dynamic> json) => MyGroupImage(
    url: json["url"],
    alt: json["alt"],
  );
}

class MyGroupInterest {
  final int? id;
  final String? slug;
  final String? name;

  MyGroupInterest({
    this.id,
    this.slug,
    this.name,
  });

  factory MyGroupInterest.fromJson(Map<String, dynamic> json) => MyGroupInterest(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
  );
}

class MyGroupPrivacy {
  final int? code;
  final String? label;

  MyGroupPrivacy({
    this.code,
    this.label,
  });

  factory MyGroupPrivacy.fromJson(Map<String, dynamic> json) => MyGroupPrivacy(
    code: json["code"],
    label: json["label"],
  );
}

class MyGroupTown {
  final int? id;
  final String? name;

  MyGroupTown({
    this.id,
    this.name,
  });

  factory MyGroupTown.fromJson(Map<String, dynamic> json) => MyGroupTown(
    id: json["id"],
    name: json["name"],
  );
}

class MyGroupPagination {
  final int? currentPage;
  final int? perPage;
  final int? total;
  final int? lastPage;

  MyGroupPagination({
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
  });

  factory MyGroupPagination.fromJson(Map<String, dynamic> json) => MyGroupPagination(
    currentPage: json["current_page"],
    perPage: json["per_page"],
    total: json["total"],
    lastPage: json["last_page"],
  );
}
