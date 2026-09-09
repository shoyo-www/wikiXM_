// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

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

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class HomeData {
  final Header? header;
  final Hero? hero;
  final SummaryCards? summaryCards;
  final List<FeatureStat>? featureStats;
  final LiveFeed? liveFeed;
  final BottomNavigation? bottomNavigation;
  final Holiday? holiday;

  HomeData({
    this.header,
    this.hero,
    this.summaryCards,
    this.featureStats,
    this.liveFeed,
    this.bottomNavigation,
    this.holiday
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    header: json["header"] == null ? null : Header.fromJson(json["header"]),
    hero: json["hero"] == null ? null : Hero.fromJson(json["hero"]),
    summaryCards: json["summary_cards"] == null ? null : SummaryCards.fromJson(json["summary_cards"]),
    featureStats: json["feature_stats"] == null ? [] : List<FeatureStat>.from(json["feature_stats"]!.map((x) => FeatureStat.fromJson(x))),
    liveFeed: json["live_feed"] == null ? null : LiveFeed.fromJson(json["live_feed"]),
    bottomNavigation: json["bottom_navigation"] == null ? null : BottomNavigation.fromJson(json["bottom_navigation"]),
    holiday: json["holiday"] == null ? null : Holiday.fromJson(json["holiday"]),
  );

  Map<String, dynamic> toJson() => {
    "header": header?.toJson(),
    "hero": hero?.toJson(),
    "summary_cards": summaryCards?.toJson(),
    "feature_stats": featureStats == null ? [] : List<dynamic>.from(featureStats!.map((x) => x.toJson())),
    "live_feed": liveFeed?.toJson(),
    "bottom_navigation": bottomNavigation?.toJson(),
  };
}

class BottomNavigation {
  final Desktop? desktop;
  final Mobile? mobile;

  BottomNavigation({
    this.desktop,
    this.mobile,
  });

  factory BottomNavigation.fromJson(Map<String, dynamic> json) => BottomNavigation(
    desktop: json["desktop"] == null ? null : Desktop.fromJson(json["desktop"]),
    mobile: json["mobile"] == null ? null : Mobile.fromJson(json["mobile"]),
  );

  Map<String, dynamic> toJson() => {
    "desktop": desktop?.toJson(),
    "mobile": mobile?.toJson(),
  };
}

class Desktop {
  final List<Cta>? items;
  final Cta? cta;

  Desktop({
    this.items,
    this.cta,
  });

  factory Desktop.fromJson(Map<String, dynamic> json) => Desktop(
    items: json["items"] == null ? [] : List<Cta>.from(json["items"]!.map((x) => Cta.fromJson(x))),
    cta: json["cta"] == null ? null : Cta.fromJson(json["cta"]),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "cta": cta?.toJson(),
  };
}

class Cta {
  final String? label;
  final String? description;
  final String? slug;
  final String? iconClass;
  final String? arrowIconClass;
  final int? badgeCount;

  Cta({
    this.label,
    this.description,
    this.slug,
    this.iconClass,
    this.arrowIconClass,
    this.badgeCount,
  });

  factory Cta.fromJson(Map<String, dynamic> json) => Cta(
    label: json["label"],
    description: json["description"],
    slug: json["slug"],
    iconClass: json["icon_class"],
    arrowIconClass: json["arrow_icon_class"],
    badgeCount: json["badge_count"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "description": description,
    "slug": slug,
    "icon_class": iconClass,
    "arrow_icon_class": arrowIconClass,
    "badge_count": badgeCount,
  };
}

class Mobile {
  final List<MobileItem>? items;

  Mobile({
    this.items,
  });

  factory Mobile.fromJson(Map<String, dynamic> json) => Mobile(
    items: json["items"] == null ? [] : List<MobileItem>.from(json["items"]!.map((x) => MobileItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class MobileItem {
  final String? label;
  final String? slug;
  final String? iconImage;
  final bool? active;
  final bool? postAction;

  MobileItem({
    this.label,
    this.slug,
    this.iconImage,
    this.active,
    this.postAction,
  });

  factory MobileItem.fromJson(Map<String, dynamic> json) => MobileItem(
    label: json["label"],
    slug: json["slug"],
    iconImage: json["icon_image"],
    active: json["active"],
    postAction: json["post_action"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "slug": slug,
    "icon_image": iconImage,
    "active": active,
    "post_action": postAction,
  };
}

class FeatureStat {
  final String? label;
  final String? iconClass;
  final String? toneClass;

  FeatureStat({
    this.label,
    this.iconClass,
    this.toneClass,
  });

  factory FeatureStat.fromJson(Map<String, dynamic> json) => FeatureStat(
    label: json["label"],
    iconClass: json["icon_class"],
    toneClass: json["tone_class"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "icon_class": iconClass,
    "tone_class": toneClass,
  };
}

class Header {
  final Location? location;
  final User? user;

  Header({
    this.location,
    this.user,
  });

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "user": user?.toJson(),
  };
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "region_type": regionType,
    "name": name,
    "header": header,
    "city_id": cityId,
    "state_id": stateId,
    "country_id": countryId,
    "abbreviations": abbreviations,
    "image": image,
  };
}

class User {
  final int? id;
  final String? name;
  final String? avatar;

  User({
    this.id,
    this.name,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
  };
}

class Hero {
  final String? greeting;
  final String? backgroundImage;

  Hero({
    this.greeting,
    this.backgroundImage,
  });

  factory Hero.fromJson(Map<String, dynamic> json) => Hero(
    greeting: json["greeting"],
    backgroundImage: json["background_image"],
  );

  Map<String, dynamic> toJson() => {
    "greeting": greeting,
    "background_image": backgroundImage,
  };
}

class LiveFeed {
  final String? title;
  final Button? button;
  final List<LiveFeedItem>? items;

  LiveFeed({
    this.title,
    this.button,
    this.items,
  });

  factory LiveFeed.fromJson(Map<String, dynamic> json) => LiveFeed(
    title: json["title"],
    button: json["button"] == null ? null : Button.fromJson(json["button"]),
    items: json["items"] == null ? [] : List<LiveFeedItem>.from(json["items"]!.map((x) => LiveFeedItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "button": button?.toJson(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Button {
  final String? text;
  final String? url;

  Button({
    this.text,
    this.url,
  });

  factory Button.fromJson(Map<String, dynamic> json) => Button(
    text: json["text"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "url": url,
  };
}

class Holiday {
  final int? id;
  final String? name;
  final String? image;
  final String? logo;
  final String? url;
  final String? displayDate;
  final String? dateMessage;
  final Countdown? countdown;

  Holiday({
    this.id,
    this.name,
    this.image,
    this.logo,
    this.url,
    this.displayDate,
    this.dateMessage,
    this.countdown,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    logo: json["logo"],
    url: json["url"],
    displayDate: json["display_date"],
    dateMessage: json["date_message"],
    countdown: json["countdown"] == null
        ? null
        : Countdown.fromJson(json["countdown"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "logo": logo,
    "url": url,
    "display_date": displayDate,
    "date_message": dateMessage,
    "countdown": countdown?.toJson(),
  };
}

class Countdown {
  final int? days;
  final int? hours;
  final int? minutes;
  final int? seconds;

  Countdown({
    this.days,
    this.hours,
    this.minutes,
    this.seconds,
  });

  factory Countdown.fromJson(Map<String, dynamic> json) => Countdown(
    days: json["days"],
    hours: json["hours"],
    minutes: json["minutes"],
    seconds: json["seconds"],
  );

  Map<String, dynamic> toJson() => {
    "days": days,
    "hours": hours,
    "minutes": minutes,
    "seconds": seconds,
  };
}

class LiveFeedItem {
  final int? id;
  final String? module;
  final int? moduleId;
  final String? activity;
  final String? title;
  final String? description;
  final String? image;
  final dynamic icon;
  final String? userName;
  final String? profileImage;
  final String? postedAt;
  final List<dynamic>? metadata;

  LiveFeedItem({
    this.id,
    this.module,
    this.moduleId,
    this.activity,
    this.title,
    this.description,
    this.image,
    this.icon,
    this.userName,
    this.profileImage,
    this.postedAt,
    this.metadata,
  });

  factory LiveFeedItem.fromJson(Map<String, dynamic> json) => LiveFeedItem(
    id: json["id"],
    module: json["module"],
    moduleId: json["module_id"],
    activity: json["activity"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    icon: json["icon"],
    userName: json["user_name"],
    profileImage: json["profile_image"],
    postedAt: json["posted_at"],
    metadata: json["metadata"] == null ? [] : List<dynamic>.from(json["metadata"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "module": module,
    "module_id": moduleId,
    "activity": activity,
    "title": title,
    "description": description,
    "image": image,
    "icon": icon,
    "user_name": userName,
    "profile_image": profileImage,
    "posted_at": postedAt,
    "metadata": metadata == null ? [] : List<dynamic>.from(metadata!.map((x) => x)),
  };
}

class SummaryCards {
  final Announcements? neighborsActive;
  final Announcements? discussionsGrowing;
  final Announcements? newArticlesToday;
  final Announcements? repResponses;
  final Announcements? announcements;

  SummaryCards({
    this.neighborsActive,
    this.discussionsGrowing,
    this.newArticlesToday,
    this.repResponses,
    this.announcements,
  });

  factory SummaryCards.fromJson(Map<String, dynamic> json) => SummaryCards(
    neighborsActive: json["neighbors_active"] == null ? null : Announcements.fromJson(json["neighbors_active"]),
    discussionsGrowing: json["discussions_growing"] == null ? null : Announcements.fromJson(json["discussions_growing"]),
    newArticlesToday: json["new_articles_today"] == null ? null : Announcements.fromJson(json["new_articles_today"]),
    repResponses: json["rep_responses"] == null ? null : Announcements.fromJson(json["rep_responses"]),
    announcements: json["announcements"] == null ? null : Announcements.fromJson(json["announcements"]),
  );

  Map<String, dynamic> toJson() => {
    "neighbors_active": neighborsActive?.toJson(),
    "discussions_growing": discussionsGrowing?.toJson(),
    "new_articles_today": newArticlesToday?.toJson(),
    "rep_responses": repResponses?.toJson(),
    "announcements": announcements?.toJson(),
  };
}

class Announcements {
  final String? label;
  final int? value;
  final String? iconClass;
  final String? toneClass;
  final String? trend;
  final String? iconImage;

  Announcements({
    this.label,
    this.value,
    this.iconClass,
    this.toneClass,
    this.trend,
    this.iconImage,
  });

  factory Announcements.fromJson(Map<String, dynamic> json) => Announcements(
    label: json["label"],
    value: json["value"],
    iconClass: json["icon_class"],
    toneClass: json["tone_class"],
    trend: json["trend"],
    iconImage: json["icon_image"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
    "icon_class": iconClass,
    "tone_class": toneClass,
    "trend": trend,
    "icon_image": iconImage,
  };
}
