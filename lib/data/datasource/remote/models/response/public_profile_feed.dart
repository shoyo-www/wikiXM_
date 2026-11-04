import 'dart:convert';

PublicProfileFeedResponse publicProfileFeedResponseFromJson(String str) => PublicProfileFeedResponse.fromJson(json.decode(str));

class PublicProfileFeedResponse {
  final bool? success;
  final String? message;
  final ProfileFeedData? data;

  PublicProfileFeedResponse({this.success, this.message, this.data});

  factory PublicProfileFeedResponse.fromJson(Map<String, dynamic> json) =>
      PublicProfileFeedResponse(success: json["success"], message: json["message"], data: json["data"] == null ? null : ProfileFeedData.fromJson(json["data"]));
}

class ProfileFeedData {
  final List<FeedDiscussion>? discussions;
  final List<FeedUpcoming>? upcomingActivities;
  final List<FeedPhoto>? photos;
  final List<FeedInvolvement>? involvement;
  final FeedQuote? quote;

  ProfileFeedData({this.discussions, this.upcomingActivities, this.photos, this.involvement, this.quote});

  factory ProfileFeedData.fromJson(Map<String, dynamic> json) => ProfileFeedData(
    discussions: json["discussions"] == null ? [] : List<FeedDiscussion>.from(json["discussions"]!.map((x) => FeedDiscussion.fromJson(x))),
    upcomingActivities: json["upcomingActivities"] == null ? [] : List<FeedUpcoming>.from(json["upcomingActivities"]!.map((x) => FeedUpcoming.fromJson(x))),
    photos: json["photos"] == null ? [] : List<FeedPhoto>.from(json["photos"]!.map((x) => FeedPhoto.fromJson(x))),
    involvement: json["involvement"] == null ? [] : List<FeedInvolvement>.from(json["involvement"]!.map((x) => FeedInvolvement.fromJson(x))),
    quote: json["quote"] == null ? null : FeedQuote.fromJson(json["quote"]),
  );
}

class FeedDiscussion {
  final String? id;
  final String? title;
  final String? description;
  final String? group;
  final String? dateLabel;
  final int? replies;

  FeedDiscussion({this.id, this.title, this.description, this.group, this.dateLabel, this.replies});

  factory FeedDiscussion.fromJson(Map<String, dynamic> json) =>
      FeedDiscussion(id: json["id"], title: json["title"], description: json["description"], group: json["group"], dateLabel: json["date_label"], replies: json["replies"]);
}

class FeedUpcoming {
  final String? id;
  final String? title;
  final String? image;
  final String? group;
  final String? location;
  final String? shortDateLabel;
  final String? timeLabel;
  final String? monthLabel;
  final String? dayLabel;

  FeedUpcoming({this.id, this.title, this.image, this.group, this.location, this.shortDateLabel, this.timeLabel, this.monthLabel, this.dayLabel});

  factory FeedUpcoming.fromJson(Map<String, dynamic> json) => FeedUpcoming(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    group: json["group"],
    location: json["location"],
    shortDateLabel: json["short_date_label"],
    timeLabel: json["time_label"],
    monthLabel: json["month_label"],
    dayLabel: json["day_label"],
  );
}

class FeedPhoto {
  final String? id;
  final String? image;
  final String? caption;

  FeedPhoto({this.id, this.image, this.caption});

  factory FeedPhoto.fromJson(Map<String, dynamic> json) => FeedPhoto(id: json["id"], image: json["image"], caption: json["caption"]);
}

class FeedInvolvement {
  final String? id;
  final String? title;
  final String? description;
  final int? count;
  final String? countLabel;

  FeedInvolvement({this.id, this.title, this.description, this.count, this.countLabel});

  factory FeedInvolvement.fromJson(Map<String, dynamic> json) =>
      FeedInvolvement(id: json["id"], title: json["title"], description: json["description"], count: json["count"], countLabel: json["countLabel"]);
}

class FeedQuote {
  final String? text;
  final String? author;

  FeedQuote({this.text, this.author});

  factory FeedQuote.fromJson(Map<String, dynamic> json) => FeedQuote(text: json["text"], author: json["author"]);
}
