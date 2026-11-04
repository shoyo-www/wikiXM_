import 'dart:convert';

import 'public_profile.dart';
import 'public_profile_feed.dart';

PublicProfileItemsResponse publicProfileItemsResponseFromJson(String str) => PublicProfileItemsResponse.fromJson(json.decode(str));

class PublicProfileItemsResponse {
  final bool? success;
  final String? message;
  final ProfileItemsData? data;

  PublicProfileItemsResponse({this.success, this.message, this.data});

  factory PublicProfileItemsResponse.fromJson(Map<String, dynamic> json) =>
      PublicProfileItemsResponse(success: json["success"], message: json["message"], data: json["data"] == null ? null : ProfileItemsData.fromJson(json["data"]));
}

/// One page of a profile section. [items] hold the same models the profile and feed use:
/// groups → GroupElement, activities → Activity, discussions → FeedDiscussion, photos → FeedPhoto,
/// interests → Interest, involvement → FeedInvolvement, upcoming → FeedUpcoming.
class ProfileItemsData {
  final String? type;
  final List<Object> items;
  final bool hasMore;

  ProfileItemsData({this.type, this.items = const [], this.hasMore = false});

  factory ProfileItemsData.fromJson(Map<String, dynamic> json) {
    final Object Function(Map<String, dynamic>) parse = switch (json["type"]) {
      'groups' => GroupElement.fromJson,
      'activities' => Activity.fromJson,
      'discussions' => FeedDiscussion.fromJson,
      'photos' => FeedPhoto.fromJson,
      'interests' => Interest.fromJson,
      'involvement' => FeedInvolvement.fromJson,
      'upcoming' => FeedUpcoming.fromJson,
      _ => (m) => m,
    };
    return ProfileItemsData(
      type: json["type"],
      items: [for (final x in json["items"] ?? []) parse(x)],
      hasMore: json["pagination"]?["has_more"] == true,
    );
  }
}
