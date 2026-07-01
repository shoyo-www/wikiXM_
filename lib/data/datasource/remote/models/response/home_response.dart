import 'dart:convert';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

class HomeResponse {
  final bool? success;
  final dynamic message;
  final HomeData? data;

  HomeResponse({
    this.success,
    this.message,
    this.data,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : HomeData.fromJson(json["data"]),
  );

}

class HomeData {
  final String? sectionGroup;
  final String? username;
  final HeroBanner? heroBanner;
  final LiveInTown? liveInTown;
  final TopConversation? topConversation;
  final WhatMattersMost? whatMattersMost;
  final TopStoryToday? topStoryToday;

  HomeData({
    this.sectionGroup,
    this.username,
    this.heroBanner,
    this.liveInTown,
    this.topConversation,
    this.whatMattersMost,
    this.topStoryToday,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    sectionGroup: json["section_group"],
    username: json["username"],
    heroBanner: json["hero_banner"] == null ? null : HeroBanner.fromJson(json["hero_banner"]),
    liveInTown: json["live_in_town"] == null ? null : LiveInTown.fromJson(json["live_in_town"]),
    topConversation: json["top_conversation"] == null ? null : TopConversation.fromJson(json["top_conversation"]),
    whatMattersMost: json["what_matters_most"] == null ? null : WhatMattersMost.fromJson(json["what_matters_most"]),
    topStoryToday: json["top_story_today"] == null ? null : TopStoryToday.fromJson(json["top_story_today"]),
  );

}

class HeroBanner {
  final String? title;
  final Location? location;
  final String? backgroundImage;
  final LeadStory? leadStory;
  final Stats? stats;

  HeroBanner({
    this.title,
    this.location,
    this.backgroundImage,
    this.leadStory,
    this.stats,
  });

  HeroBanner copyWith({
    String? title,
    Location? location,
    String? backgroundImage,
    Weather? weather,
    LeadStory? leadStory,
    Stats? stats,
    List<dynamic>? alerts,
  }) =>
      HeroBanner(
        title: title ?? this.title,
        location: location ?? this.location,
        backgroundImage: backgroundImage ?? this.backgroundImage,
        leadStory: leadStory ?? this.leadStory,
        stats: stats ?? this.stats,
      );

  factory HeroBanner.fromJson(Map<String, dynamic> json) => HeroBanner(
    title: json["title"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    backgroundImage: json["background_image"],
    leadStory: json["lead_story"] == null ? null : LeadStory.fromJson(json["lead_story"]),
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
  );

}

class LeadStory {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final String? categoryTitle;
  final String? homeUrl;
  final String? categoryUrl;
  final String? reporterName;
  final String? profileImage;
  final int? totalComments;
  final int? totalViews;
  final int? totalLikes;
  final String? formattedPublishedDate;
  final String? location;
  final int? rank;

  LeadStory({
    this.id,
    this.title,
    this.description,
    this.image,
    this.categoryTitle,
    this.homeUrl,
    this.categoryUrl,
    this.reporterName,
    this.profileImage,
    this.totalComments,
    this.totalViews,
    this.totalLikes,
    this.formattedPublishedDate,
    this.location,
    this.rank,
  });


  factory LeadStory.fromJson(Map<String, dynamic> json) => LeadStory(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    categoryTitle: json["category_title"],
    homeUrl: json["home_url"],
    categoryUrl: json["category_url"],
    reporterName: json["reporter_name"],
    profileImage: json["profile_image"],
    totalComments: json["total_comments"],
    totalViews: json["total_views"],
    totalLikes: json["total_likes"],
    formattedPublishedDate: json["formatted_published_date"],
    location: json["location"],
    rank: json["rank"],
  );

}

class Location {
  final int? id;
  final String? regionType;
  final String? name;
  final String? header;
  final int? cityId;
  final int? stateId;
  final int? countryId;
  final String? abbreviations;
  final String? image;

  Location({
    this.id,
    this.regionType,
    this.name,
    this.header,
    this.cityId,
    this.stateId,
    this.countryId,
    this.abbreviations,
    this.image,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    regionType: json["region_type"],
    name: json["name"],
    header: json["header"],
    cityId: json["city_id"],
    stateId: json["state_id"],
    countryId: json["country_id"],
    abbreviations: json["abbreviations"],
    image: json["image"],
  );

}

class Stats {
  final int? neighborsOnline;
  final int? storiesToday;
  final int? activeAlerts;

  Stats({
    this.neighborsOnline,
    this.storiesToday,
    this.activeAlerts,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    neighborsOnline: json["neighbors_online"],
    storiesToday: json["stories_today"],
    activeAlerts: json["active_alerts"],
  );

}

class Weather {
  final int? temperatureCelsius;
  final String? temperatureText;
  final String? condition;
  final String? icon;

  Weather({
    this.temperatureCelsius,
    this.temperatureText,
    this.condition,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    temperatureCelsius: json["temperature_celsius"],
    temperatureText: json["temperature_text"],
    condition: json["condition"],
    icon: json["icon"],
  );

}

class LiveInTown {
  final String? title;
  final List<Item>? items;

  LiveInTown({
    this.title,
    this.items,
  });

  factory LiveInTown.fromJson(Map<String, dynamic> json) => LiveInTown(
    title: json["title"],
    items: json["items"] == null
        ? []
        : List<Item>.from(
      json["items"].map((x) => Item.fromJson(x)),
    ),
  );

}
class User {
  final String? name;
  final String? image;

  User({
    this.name,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    image: json["image"],
  );

}

class Item {
  final int? id;
  final String? module;
  final String? activity;
  final String? title;
  final String? description;
  final User? user;
  final String? createdAt;

  Item({
    this.id,
    this.module,
    this.activity,
    this.title,
    this.description,
    this.user,
    this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    module: json["module"],
    activity: json["activity"],
    title: json["title"],
    description: json["description"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    createdAt: json["created_at"],
  );

}

class TopConversation {
  final String? title;
  final Conversation? conversation;

  TopConversation({
    this.title,
    this.conversation,
  });


  factory TopConversation.fromJson(Map<String, dynamic> json) => TopConversation(
    title: json["title"],
    conversation: json["conversation"] == null ? null : Conversation.fromJson(json["conversation"]),
  );

}

class Conversation {
  final int? id;
  final String? headline;
  final String? summary;
  final String? image;
  final String? actorName;
  final String? actorAvatar;
  final int? totalComments;
  final int? totalLikes;
  final String? relativeTime;
  final DateTime? publishedAt;

  Conversation({
    this.id,
    this.headline,
    this.summary,
    this.image,
    this.actorName,
    this.actorAvatar,
    this.totalComments,
    this.totalLikes,
    this.relativeTime,
    this.publishedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    id: json["id"],
    headline: json["headline"],
    summary: json["summary"],
    image: json["image"],
    actorName: json["actor_name"],
    actorAvatar: json["actor_avatar"],
    totalComments: json["total_comments"],
    totalLikes: json["total_likes"],
    relativeTime: json["relative_time"],
    publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
  );

}

class TopStoryToday {
  final String? title;
  final LeadStory? story;

  TopStoryToday({
    this.title,
    this.story,
  });

  factory TopStoryToday.fromJson(Map<String, dynamic> json) => TopStoryToday(
    title: json["title"],
    story: json["story"] == null ? null : LeadStory.fromJson(json["story"]),
  );

}

class WhatMattersMost {
  final String? title;
  final List<LeadStory>? storyCards;

  WhatMattersMost({
    this.title,
    this.storyCards,
  });

  factory WhatMattersMost.fromJson(Map<String, dynamic> json) => WhatMattersMost(
    title: json["title"],
    storyCards: json["story_cards"] == null ? [] : List<LeadStory>.from(json["story_cards"]!.map((x) => LeadStory.fromJson(x))),
  );

}
