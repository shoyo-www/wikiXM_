import 'dart:convert';

HomeCatResponse homeCatResponseFromJson(String str) => HomeCatResponse.fromJson(json.decode(str));

class HomeCatResponse {
  final bool? success;
  final dynamic message;
  final HomeCatData? data;

  HomeCatResponse({
    this.success,
    this.message,
    this.data,
  });

  factory HomeCatResponse.fromJson(Map<String, dynamic> json) => HomeCatResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : HomeCatData.fromJson(json["data"]),
  );

}

class HomeCatData {
  final String? sectionGroup;
  final NewsAroundYou? newsAroundYou;
  final WhatsHappeningThisWeek? whatsHappeningThisWeek;
  final TownHall? townHall;
  final BusinessAndEconomy? businessAndEconomy;
  final SchoolsAndEducation? schoolsAndEducation;

  HomeCatData({
    this.sectionGroup,
    this.newsAroundYou,
    this.whatsHappeningThisWeek,
    this.townHall,
    this.businessAndEconomy,
    this.schoolsAndEducation,
  });

  factory HomeCatData.fromJson(Map<String, dynamic> json) => HomeCatData(
    sectionGroup: json["section_group"],
    newsAroundYou: json["news_around_you"] == null ? null : NewsAroundYou.fromJson(json["news_around_you"]),
    whatsHappeningThisWeek: json["whats_happening_this_week"] == null ? null : WhatsHappeningThisWeek.fromJson(json["whats_happening_this_week"]),
    townHall: json["town_hall"] == null ? null : TownHall.fromJson(json["town_hall"]),
    businessAndEconomy: json["business_and_economy"] == null ? null : BusinessAndEconomy.fromJson(json["business_and_economy"]),
    schoolsAndEducation: json["schools_and_education"] == null ? null : SchoolsAndEducation.fromJson(json["schools_and_education"]),
  );

}

class BusinessAndEconomy {
  final String? title;
  final List<Story>? stories;

  BusinessAndEconomy({
    this.title,
    this.stories,
  });

  factory BusinessAndEconomy.fromJson(Map<String, dynamic> json) => BusinessAndEconomy(
    title: json["title"],
    stories: json["stories"] == null ? [] : List<Story>.from(json["stories"]!.map((x) => Story.fromJson(x))),
  );

}

class Story {
  final int? id;
  final String? sourceType;
  final String? sourceLabel;
  final User? user;
  final String? headline;
  final String? summary;
  final String? image;
  final String? engagementLabel;
  final dynamic location;
  final DateTime? publishedAt;
  final String? relativeTime;
  final String? url;
  final DateTime? sortAt;

  Story({
    this.id,
    this.sourceType,
    this.sourceLabel,
    this.user,
    this.headline,
    this.summary,
    this.image,
    this.engagementLabel,
    this.location,
    this.publishedAt,
    this.relativeTime,
    this.url,
    this.sortAt,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    sourceType: json["source_type"],
    sourceLabel: json["source_label"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    headline: json["headline"],
    summary: json["summary"],
    image: json["image"],
    engagementLabel: json["engagement_label"],
    location: json["location"],
    publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
    relativeTime: json["relative_time"],
    url: json["url"],
    sortAt: json["sort_at"] == null ? null : DateTime.parse(json["sort_at"]),
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

class NewsAroundYou {
  final String? title;
  final PrimaryStory? primaryStory;
  final List<PrimaryStory>? storyCards;

  NewsAroundYou({
    this.title,
    this.primaryStory,
    this.storyCards,
  });

  factory NewsAroundYou.fromJson(Map<String, dynamic> json) => NewsAroundYou(
    title: json["title"],
    primaryStory: json["primary_story"] == null ? null : PrimaryStory.fromJson(json["primary_story"]),
    storyCards: json["story_cards"] == null ? [] : List<PrimaryStory>.from(json["story_cards"]!.map((x) => PrimaryStory.fromJson(x))),
  );

}

class PrimaryStory {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final String? categoryTitle;
  final String? homeUrl;
  final String? categoryUrl;
  final String? reporterName;
  final dynamic profileImage;
  final int? totalComments;
  final int? totalViews;
  final int? totalLikes;
  final String? formattedDate;
  final String? location;

  PrimaryStory({
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
    this.formattedDate,
    this.location,
  });

  factory PrimaryStory.fromJson(Map<String, dynamic> json) => PrimaryStory(
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
    formattedDate: json["formatted_date"],
    location: json["location"],
  );

}

class SchoolsAndEducation {
  final String? title;
  final List<PrimaryStory>? stories;

  SchoolsAndEducation({
    this.title,
    this.stories,
  });

  factory SchoolsAndEducation.fromJson(Map<String, dynamic> json) => SchoolsAndEducation(
    title: json["title"],
    stories: json["stories"] == null ? [] : List<PrimaryStory>.from(json["stories"]!.map((x) => PrimaryStory.fromJson(x))),
  );
}

class TownHall {
  final String? title;
  final List<Topic>? topics;
  final int? topicCount;

  TownHall({
    this.title,
    this.topics,
    this.topicCount,
  });

  factory TownHall.fromJson(Map<String, dynamic> json) => TownHall(
    title: json["title"],
    topics: json["topics"] == null ? [] : List<Topic>.from(json["topics"]!.map((x) => Topic.fromJson(x))),
    topicCount: json["topic_count"],
  );

}

class Topic {
  final int? id;
  final int? conversationId;
  final int? cityId;
  final int? stateId;
  final int? countyId;
  final int? countryId;
  final int? itemType;
  final int? conversationType;
  final int? type;
  final dynamic categoryId;
  final String? title;
  final String? description;
  final dynamic repreId;
  final String? createdAt;
  final int? postedById;
  final String? firstName;
  final String? lastName;
  final int? likeCount;
  final int? dislikeCount;
  final String? categoryTitle;
  final String? imageUrl;
  final String? topicTitle;
  final String? topicDescription;
  final String? shareUrl;
  final String? postedBy;

  Topic({
    this.id,
    this.conversationId,
    this.cityId,
    this.stateId,
    this.countyId,
    this.countryId,
    this.itemType,
    this.conversationType,
    this.type,
    this.categoryId,
    this.title,
    this.description,
    this.repreId,
    this.createdAt,
    this.postedById,
    this.firstName,
    this.lastName,
    this.likeCount,
    this.dislikeCount,
    this.categoryTitle,
    this.imageUrl,
    this.topicTitle,
    this.topicDescription,
    this.shareUrl,
    this.postedBy,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    id: json["id"],
    conversationId: json["conversation_id"],
    cityId: json["city_id"],
    stateId: json["state_id"],
    countyId: json["county_id"],
    countryId: json["country_id"],
    itemType: json["item_type"],
    conversationType: json["conversation_type"],
    type: json["type"],
    categoryId: json["category_id"],
    title: json["title"],
    description: json["description"],
    repreId: json["repre_id"],
    createdAt: json["created_at"],
    postedById: json["posted_by_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    likeCount: json["like_count"],
    dislikeCount: json["dislike_count"],
    categoryTitle: json["category_title"],
    imageUrl: json["image_url"],
    topicTitle: json["topic_title"],
    topicDescription: json["topic_description"],
    shareUrl: json["share_url"],
    postedBy: json["posted_by"],
  );
}

class WhatsHappeningThisWeek {
  final String? title;
  final List<dynamic>? eventCards;

  WhatsHappeningThisWeek({
    this.title,
    this.eventCards,
  });

  factory WhatsHappeningThisWeek.fromJson(Map<String, dynamic> json) => WhatsHappeningThisWeek(
    title: json["title"],
    eventCards: json["event_cards"] == null ? [] : List<dynamic>.from(json["event_cards"]!.map((x) => x)),
  );

}
