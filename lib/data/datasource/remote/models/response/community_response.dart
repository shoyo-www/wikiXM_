import 'dart:convert';

CommunityResponse communityResponseFromJson(String str) => CommunityResponse.fromJson(json.decode(str));

String communityResponseToJson(CommunityResponse data) => json.encode(data.toJson());

class CommunityResponse {
  final bool? success;
  final dynamic message;
  final CommunityData? data;

  CommunityResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CommunityResponse.fromJson(Map<String, dynamic> json) => CommunityResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : CommunityData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class CommunityData {
  final Guide? guide;
  final Journey? journey;
  final WhatMatters? whatMatters;
  final Todo? todo;
  final Representative? representative;
  final Brief? brief;
  final Pulse? pulse;
  final HappeningWeek? happeningWeek;
  final SportsHighlights? sportsHighlights;

  CommunityData({
    this.guide,
    this.journey,
    this.whatMatters,
    this.todo,
    this.representative,
    this.brief,
    this.pulse,
    this.happeningWeek,
    this.sportsHighlights,
  });

  factory CommunityData.fromJson(Map<String, dynamic> json) => CommunityData(
    guide: json["guide"] == null ? null : Guide.fromJson(json["guide"]),
    journey: json["journey"] == null ? null : Journey.fromJson(json["journey"]),
    whatMatters: json["what_matters"] == null ? null : WhatMatters.fromJson(json["what_matters"]),
    todo: json["todo"] == null ? null : Todo.fromJson(json["todo"]),
    representative: json["representative"] == null ? null : Representative.fromJson(json["representative"]),
    brief: json["brief"] == null ? null : Brief.fromJson(json["brief"]),
    pulse: json["pulse"] == null ? null : Pulse.fromJson(json["pulse"]),
    happeningWeek: json["happening_week"] == null ? null : HappeningWeek.fromJson(json["happening_week"]),
    sportsHighlights: json["sports_highlights"] == null ? null : SportsHighlights.fromJson(json["sports_highlights"]),
  );

  Map<String, dynamic> toJson() => {
    "guide": guide?.toJson(),
    "journey": journey?.toJson(),
    "what_matters": whatMatters?.toJson(),
    "todo": todo?.toJson(),
    "representative": representative?.toJson(),
    "brief": brief?.toJson(),
    "pulse": pulse?.toJson(),
    "happening_week": happeningWeek?.toJson(),
    "sports_highlights": sportsHighlights?.toJson(),
  };
}

class Brief {
  final String? title;
  final List<BriefItem>? items;

  Brief({
    this.title,
    this.items,
  });

  factory Brief.fromJson(Map<String, dynamic> json) => Brief(
    title: json["title"],
    items: json["items"] == null ? [] : List<BriefItem>.from(json["items"]!.map((x) => BriefItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class BriefItem {
  final int? id;
  final String? title;
  final String? category;
  final String? image;
  final Mood? badge;
  final String? shareUrl;
  final String? createdAt;

  BriefItem({
    this.id,
    this.title,
    this.category,
    this.image,
    this.badge,
    this.shareUrl,
    this.createdAt,
  });

  factory BriefItem.fromJson(Map<String, dynamic> json) => BriefItem(
    id: json["id"],
    title: json["title"],
    category: json["category"],
    image: json["image"],
    badge: json["badge"] == null ? null : Mood.fromJson(json["badge"]),
    shareUrl: json["share_url"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category": category,
    "image": image,
    "badge": badge?.toJson(),
    "share_url": shareUrl,
    "created_at": createdAt,
  };
}

class Mood {
  final String? text;
  final String? moodClass;

  Mood({
    this.text,
    this.moodClass,
  });

  factory Mood.fromJson(Map<String, dynamic> json) => Mood(
    text: json["text"],
    moodClass: json["class"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "class": moodClass,
  };
}

class Guide {
  final String? title;
  final String? badge;
  final String? image;
  final Greeting? greeting;
  final String? intro;
  final List<Highlight>? highlights;
  final Search? search;
  final List<String>? popularTopics;

  Guide({
    this.title,
    this.badge,
    this.image,
    this.greeting,
    this.intro,
    this.highlights,
    this.search,
    this.popularTopics,
  });

  factory Guide.fromJson(Map<String, dynamic> json) => Guide(
    title: json["title"],
    badge: json["badge"],
    image: json["image"],
    greeting: json["greeting"] == null ? null : Greeting.fromJson(json["greeting"]),
    intro: json["intro"],
    highlights: json["highlights"] == null ? [] : List<Highlight>.from(json["highlights"]!.map((x) => Highlight.fromJson(x))),
    search: json["search"] == null ? null : Search.fromJson(json["search"]),
    popularTopics: json["popular_topics"] == null ? [] : List<String>.from(json["popular_topics"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "badge": badge,
    "image": image,
    "greeting": greeting?.toJson(),
    "intro": intro,
    "highlights": highlights == null ? [] : List<dynamic>.from(highlights!.map((x) => x.toJson())),
    "search": search?.toJson(),
    "popular_topics": popularTopics == null ? [] : List<dynamic>.from(popularTopics!.map((x) => x)),
  };
}

class Greeting {
  final String? headline;
  final String? iconClass;

  Greeting({
    this.headline,
    this.iconClass,
  });

  factory Greeting.fromJson(Map<String, dynamic> json) => Greeting(
    headline: json["headline"],
    iconClass: json["icon_class"],
  );

  Map<String, dynamic> toJson() => {
    "headline": headline,
    "icon_class": iconClass,
  };
}

class Highlight {
  final String? iconClass;
  final String? text;

  Highlight({
    this.iconClass,
    this.text,
  });

  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
    iconClass: json["icon_class"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "icon_class": iconClass,
    "text": text,
  };
}

class Search {
  final String? placeholder;
  final String? buttonText;

  Search({
    this.placeholder,
    this.buttonText,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    placeholder: json["placeholder"],
    buttonText: json["button_text"],
  );

  Map<String, dynamic> toJson() => {
    "placeholder": placeholder,
    "button_text": buttonText,
  };
}

class HappeningWeek {
  final String? title;
  final List<HappeningWeekItem>? items;

  HappeningWeek({
    this.title,
    this.items,
  });

  factory HappeningWeek.fromJson(Map<String, dynamic> json) => HappeningWeek(
    title: json["title"],
    items: json["items"] == null ? [] : List<HappeningWeekItem>.from(json["items"]!.map((x) => HappeningWeekItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class HappeningWeekItem {
  final int? id;
  final String? title;
  final Date? date;
  final String? time;
  final String? url;

  HappeningWeekItem({
    this.id,
    this.title,
    this.date,
    this.time,
    this.url,
  });

  factory HappeningWeekItem.fromJson(Map<String, dynamic> json) => HappeningWeekItem(
    id: json["id"],
    title: json["title"],
    date: json["date"] == null ? null : Date.fromJson(json["date"]),
    time: json["time"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date?.toJson(),
    "time": time,
    "url": url,
  };
}

class Date {
  final String? month;
  final String? day;

  Date({
    this.month,
    this.day,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    month: json["month"],
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "day": day,
  };
}

class Journey {
  final String? title;
  final Badge? badge;
  final String? headline;
  final Message? message;
  final Progress? progress;
  final Level? level;
  final List<Stat>? stats;
  final JourneyViewAll? viewAll;
  final Raw? raw;

  Journey({
    this.title,
    this.badge,
    this.headline,
    this.message,
    this.progress,
    this.level,
    this.stats,
    this.viewAll,
    this.raw,
  });

  factory Journey.fromJson(Map<String, dynamic> json) => Journey(
    title: json["title"],
    badge: json["badge"] == null ? null : Badge.fromJson(json["badge"]),
    headline: json["headline"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    progress: json["progress"] == null ? null : Progress.fromJson(json["progress"]),
    level: json["level"] == null ? null : Level.fromJson(json["level"]),
    stats: json["stats"] == null ? [] : List<Stat>.from(json["stats"]!.map((x) => Stat.fromJson(x))),
    viewAll: json["view_all"] == null ? null : JourneyViewAll.fromJson(json["view_all"]),
    raw: json["raw"] == null ? null : Raw.fromJson(json["raw"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "badge": badge?.toJson(),
    "headline": headline,
    "message": message?.toJson(),
    "progress": progress?.toJson(),
    "level": level?.toJson(),
    "stats": stats == null ? [] : List<dynamic>.from(stats!.map((x) => x.toJson())),
    "view_all": viewAll?.toJson(),
    "raw": raw?.toJson(),
  };
}

class Badge {
  final String? title;
  final String? image;

  Badge({
    this.title,
    this.image,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
  };
}

class Level {
  final String? current;
  final String? badge;
  final String? points;
  final bool? showInfo;

  Level({
    this.current,
    this.badge,
    this.points,
    this.showInfo,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
    current: json["current"],
    badge: json["badge"],
    points: json["points"],
    showInfo: json["show_info"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "badge": badge,
    "points": points,
    "show_info": showInfo,
  };
}

class Message {
  final int? count;
  final String? label;
  final String? text;
  final String? highlight;

  Message({
    this.count,
    this.label,
    this.text,
    this.highlight,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    count: json["count"],
    label: json["label"],
    text: json["text"],
    highlight: json["highlight"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "label": label,
    "text": text,
    "highlight": highlight,
  };
}

class Progress {
  final int? percent;
  final String? label;

  Progress({
    this.percent,
    this.label,
  });

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
    percent: json["percent"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "percent": percent,
    "label": label,
  };
}

class Raw {
  final int? pointsTotal;
  final int? pointsTarget;
  final int? pointsLeft;
  final int? progressPercent;
  final BadgeProgress? badgeProgress;
  final int? currentLevelId;
  final dynamic currentBadgeId;
  final int? totalActivities;
  final int? totalTransactions;

  Raw({
    this.pointsTotal,
    this.pointsTarget,
    this.pointsLeft,
    this.progressPercent,
    this.badgeProgress,
    this.currentLevelId,
    this.currentBadgeId,
    this.totalActivities,
    this.totalTransactions,
  });

  factory Raw.fromJson(Map<String, dynamic> json) => Raw(
    pointsTotal: json["points_total"],
    pointsTarget: json["points_target"],
    pointsLeft: json["points_left"],
    progressPercent: json["progress_percent"],
    badgeProgress: json["badge_progress"] == null ? null : BadgeProgress.fromJson(json["badge_progress"]),
    currentLevelId: json["current_level_id"],
    currentBadgeId: json["current_badge_id"],
    totalActivities: json["total_activities"],
    totalTransactions: json["total_transactions"],
  );

  Map<String, dynamic> toJson() => {
    "points_total": pointsTotal,
    "points_target": pointsTarget,
    "points_left": pointsLeft,
    "progress_percent": progressPercent,
    "badge_progress": badgeProgress?.toJson(),
    "current_level_id": currentLevelId,
    "current_badge_id": currentBadgeId,
    "total_activities": totalActivities,
    "total_transactions": totalTransactions,
  };
}

class BadgeProgress {
  final int? current;
  final int? required;
  final int? remaining;
  final int? percent;
  final String? metric;

  BadgeProgress({
    this.current,
    this.required,
    this.remaining,
    this.percent,
    this.metric,
  });

  factory BadgeProgress.fromJson(Map<String, dynamic> json) => BadgeProgress(
    current: json["current"],
    required: json["required"],
    remaining: json["remaining"],
    percent: json["percent"],
    metric: json["metric"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "required": required,
    "remaining": remaining,
    "percent": percent,
    "metric": metric,
  };
}

class Stat {
  final String? title;
  final String? value;
  final String? meta;
  final String? iconClass;
  final String? icon;

  Stat({
    this.title,
    this.value,
    this.meta,
    this.iconClass,
    this.icon,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
    title: json["title"],
    value: json["value"],
    meta: json["meta"],
    iconClass: json["icon_class"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "value": value,
    "meta": meta,
    "icon_class": iconClass,
    "icon": icon,
  };
}

class JourneyViewAll {
  final String? text;
  final String? url;

  JourneyViewAll({
    this.text,
    this.url,
  });

  factory JourneyViewAll.fromJson(Map<String, dynamic> json) => JourneyViewAll(
    text: json["text"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "url": url,
  };
}

class Pulse {
  final String? title;
  final String? subtitle;
  final Score? score;
  final List<Metric>? metrics;
  final Mood? mood;
  final String? reportUrl;

  Pulse({
    this.title,
    this.subtitle,
    this.score,
    this.metrics,
    this.mood,
    this.reportUrl,
  });

  factory Pulse.fromJson(Map<String, dynamic> json) => Pulse(
    title: json["title"],
    subtitle: json["subtitle"],
    score: json["score"] == null ? null : Score.fromJson(json["score"]),
    metrics: json["metrics"] == null ? [] : List<Metric>.from(json["metrics"]!.map((x) => Metric.fromJson(x))),
    mood: json["mood"] == null ? null : Mood.fromJson(json["mood"]),
    reportUrl: json["report_url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle,
    "score": score?.toJson(),
    "metrics": metrics == null ? [] : List<dynamic>.from(metrics!.map((x) => x.toJson())),
    "mood": mood?.toJson(),
    "report_url": reportUrl,
  };
}

class Metric {
  final String? label;
  final String? value;
  final String? icon;
  final String? metricClass;

  Metric({
    this.label,
    this.value,
    this.icon,
    this.metricClass,
  });

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
    label: json["label"],
    value: json["value"],
    icon: json["icon"],
    metricClass: json["class"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
    "icon": icon,
    "class": metricClass,
  };
}

class Score {
  final String? value;
  final String? label;

  Score({
    this.value,
    this.label,
  });

  factory Score.fromJson(Map<String, dynamic> json) => Score(
    value: json["value"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "label": label,
  };
}

class Representative {
  final int? id;
  final String? name;
  final String? role;
  final String? district;
  final String? serving;
  final String? image;
  final String? profileUrl;
  final String? overallRating;
  final String? recentResponse;
  final String? responseTime;

  Representative({
    this.id,
    this.name,
    this.role,
    this.district,
    this.serving,
    this.image,
    this.profileUrl,
    this.overallRating,
    this.recentResponse,
    this.responseTime,
  });

  factory Representative.fromJson(Map<String, dynamic> json) => Representative(
    id: json["id"],
    name: json["name"],
    role: json["role"],
    district: json["district"],
    serving: json["serving"],
    image: json["image"],
    profileUrl: json["profile_url"],
    overallRating: json["overall_rating"],
    recentResponse: json["recent_response"],
    responseTime: json["response_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role": role,
    "district": district,
    "serving": serving,
    "image": image,
    "profile_url": profileUrl,
    "overall_rating": overallRating,
    "recent_response": recentResponse,
    "response_time": responseTime,
  };
}

class SportsHighlights {
  final String? title;
  final List<SportsHighlightsItem>? items;

  SportsHighlights({
    this.title,
    this.items,
  });

  factory SportsHighlights.fromJson(Map<String, dynamic> json) => SportsHighlights(
    title: json["title"],
    items: json["items"] == null ? [] : List<SportsHighlightsItem>.from(json["items"]!.map((x) => SportsHighlightsItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class SportsHighlightsItem {
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
  final dynamic formattedPublishedDate;
  final String? location;

  SportsHighlightsItem({
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
  });

  factory SportsHighlightsItem.fromJson(Map<String, dynamic> json) => SportsHighlightsItem(
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "category_title": categoryTitle,
    "home_url": homeUrl,
    "category_url": categoryUrl,
    "reporter_name": reporterName,
    "profile_image": profileImage,
    "total_comments": totalComments,
    "total_views": totalViews,
    "total_likes": totalLikes,
    "formatted_published_date": formattedPublishedDate,
    "location": location,
  };
}

class Todo {
  final String? title;
  final List<TodoItem>? items;
  final TodoViewAll? viewAll;

  Todo({
    this.title,
    this.items,
    this.viewAll,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    title: json["title"],
    items: json["items"] == null ? [] : List<TodoItem>.from(json["items"]!.map((x) => TodoItem.fromJson(x))),
    viewAll: json["view_all"] == null ? null : TodoViewAll.fromJson(json["view_all"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "view_all": viewAll?.toJson(),
  };
}

class TodoItem {
  final String? label;
  final String? iconClass;
  final String? url;

  TodoItem({
    this.label,
    this.iconClass,
    this.url,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
    label: json["label"],
    iconClass: json["icon_class"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "icon_class": iconClass,
    "url": url,
  };
}

class TodoViewAll {
  final String? text;
  final String? url;
  final String? iconClass;

  TodoViewAll({
    this.text,
    this.url,
    this.iconClass,
  });

  factory TodoViewAll.fromJson(Map<String, dynamic> json) => TodoViewAll(
    text: json["text"],
    url: json["url"],
    iconClass: json["icon_class"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "url": url,
    "icon_class": iconClass,
  };
}

class WhatMatters {
  final String? title;
  final JourneyViewAll? viewAll;
  final List<BriefItem>? items;

  WhatMatters({
    this.title,
    this.viewAll,
    this.items,
  });

  factory WhatMatters.fromJson(Map<String, dynamic> json) => WhatMatters(
    title: json["title"],
    viewAll: json["view_all"] == null ? null : JourneyViewAll.fromJson(json["view_all"]),
    items: json["items"] == null ? [] : List<BriefItem>.from(json["items"]!.map((x) => BriefItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "view_all": viewAll?.toJson(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}
