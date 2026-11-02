import 'dart:convert';

SearchGroupResponse searchGroupResponseFromJson(String str) => SearchGroupResponse.fromJson(json.decode(str));


class SearchGroupResponse {
  final bool? success;
  final String? message;
  final GroupItemsData? data;

  SearchGroupResponse({
    this.success,
    this.message,
    this.data,
  });

  factory SearchGroupResponse.fromJson(Map<String, dynamic> json) => SearchGroupResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : GroupItemsData.fromJson(json["data"]),
  );

}

class GroupItemsData {
  final List<Item>? items;
  final Pagination? pagination;

  GroupItemsData({
    this.items,
    this.pagination,
  });

  factory GroupItemsData.fromJson(Map<String, dynamic> json) => GroupItemsData(
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

}

class Item {
  final String? id;
  final int? groupId;
  final int? templateId;
  final bool? isVirtual;
  final String? title;
  final String? slug;
  final String? description;
  final List<String>? interestIds;
  final List<Interest>? interests;
  final String? icon;
  final String? color;
  final String? location;
  final int? distanceMiles;
  final int? cityId;
  final String? detailPath;
  final Image? image;
  final int? membersCount;
  final String? membersLabel;
  final String? searchable;
  final List<dynamic>? avatars;
  final bool? isOwner;
  final bool? isJoined;
  final bool? isRequested;
  final String? privacyLabel;
  final bool? requiresApproval;
  final bool? canLeave;
  final bool? canJoin;

  Item({
    this.id,
    this.groupId,
    this.templateId,
    this.isVirtual,
    this.title,
    this.slug,
    this.description,
    this.interestIds,
    this.interests,
    this.icon,
    this.color,
    this.location,
    this.distanceMiles,
    this.cityId,
    this.detailPath,
    this.image,
    this.membersCount,
    this.membersLabel,
    this.searchable,
    this.avatars,
    this.isOwner,
    this.isJoined,
    this.isRequested,
    this.privacyLabel,
    this.requiresApproval,
    this.canLeave,
    this.canJoin,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    groupId: json["group_id"],
    templateId: json["template_id"],
    isVirtual: json["is_virtual"],
    title: json["title"],
    slug: json["slug"],
    description: json["description"],
    interestIds: json["interest_ids"] == null ? [] : List<String>.from(json["interest_ids"]!.map((x) => x)),
    interests: json["interests"] == null ? [] : List<Interest>.from(json["interests"]!.map((x) => Interest.fromJson(x))),
    icon: json["icon"],
    color: json["color"],
    location: json["location"],
    distanceMiles: json["distance_miles"],
    cityId: json["city_id"],
    detailPath: json["detail_path"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    membersCount: json["members_count"],
    membersLabel: json["members_label"],
    searchable: json["searchable"],
    avatars: json["avatars"] == null ? [] : List<dynamic>.from(json["avatars"]!.map((x) => x)),
    isOwner: json["is_owner"],
    isJoined: json["is_joined"],
    isRequested: json["is_requested"],
    privacyLabel:json["privacy_label"],
    requiresApproval: json["requires_approval"],
    canLeave: json["can_leave"],
    canJoin: json["can_join"],
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

  Map<String, dynamic> toJson() => {
    "url": url,
    "alt": alt,
    "width": width,
    "height": height,
  };
}

class Interest {
  final String? id;
  final String? name;

  Interest({
    this.id,
    this.name,
  });

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Pagination {
  final int? currentPage;
  final int? perPage;
  final int? total;
  final int? lastPage;
  final int? from;
  final int? to;

  Pagination({
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
    this.from,
    this.to,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    perPage: json["per_page"],
    total: json["total"],
    lastPage: json["last_page"],
    from: json["from"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "per_page": perPage,
    "total": total,
    "last_page": lastPage,
    "from": from,
    "to": to,
  };
}

