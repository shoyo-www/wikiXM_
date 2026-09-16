// To parse this JSON data, do
//
//     final entertainmentResponse = entertainmentResponseFromJson(jsonString);

import 'dart:convert';

EntertainmentResponse entertainmentResponseFromJson(String str) => EntertainmentResponse.fromJson(json.decode(str));

String entertainmentResponseToJson(EntertainmentResponse data) => json.encode(data.toJson());

class EntertainmentResponse {
  final bool? success;
  final String? message;
  final EntertainmentData? data;

  EntertainmentResponse({
    this.success,
    this.message,
    this.data,
  });

  factory EntertainmentResponse.fromJson(Map<String, dynamic> json) => EntertainmentResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : EntertainmentData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class EntertainmentData {
  final Location? location;
  final Hero? hero;
  final Events? events;
  final Planner? planner;
  final Today? today;
  final Categories? categories;
  final Contributors? contributors;
  final FeaturedNews? featuredNews;
  final News? news;
  final NewsWide? newsWide;
  final Ads? ads;
  final Calendar? calendar;
  final Newsletter? newsletter;
  final Involve? involve;
  final Explore? explore;
  final Celebrate? celebrate;

  EntertainmentData({
    this.location,
    this.hero,
    this.events,
    this.planner,
    this.today,
    this.categories,
    this.contributors,
    this.featuredNews,
    this.news,
    this.newsWide,
    this.ads,
    this.calendar,
    this.newsletter,
    this.involve,
    this.explore,
    this.celebrate,
  });

  factory EntertainmentData.fromJson(Map<String, dynamic> json) => EntertainmentData(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    hero: json["hero"] == null ? null : Hero.fromJson(json["hero"]),
    events: json["events"] == null ? null : Events.fromJson(json["events"]),
    planner: json["planner"] == null ? null : Planner.fromJson(json["planner"]),
    today: json["today"] == null ? null : Today.fromJson(json["today"]),
    categories: json["categories"] == null ? null : Categories.fromJson(json["categories"]),
    contributors: json["contributors"] == null ? null : Contributors.fromJson(json["contributors"]),
    featuredNews: json["featured_news"] == null ? null : FeaturedNews.fromJson(json["featured_news"]),
    news: json["news"] == null ? null : News.fromJson(json["news"]),
    newsWide: json["news_wide"] == null ? null : NewsWide.fromJson(json["news_wide"]),
    ads: json["ads"] == null ? null : Ads.fromJson(json["ads"]),
    calendar: json["calendar"] == null ? null : Calendar.fromJson(json["calendar"]),
    newsletter: json["newsletter"] == null ? null : Newsletter.fromJson(json["newsletter"]),
    involve: json["involve"] == null ? null : Involve.fromJson(json["involve"]),
    explore: json["explore"] == null ? null : Explore.fromJson(json["explore"]),
    celebrate: json["celebrate"] == null ? null : Celebrate.fromJson(json["celebrate"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "hero": hero?.toJson(),
    "events": events?.toJson(),
    "planner": planner?.toJson(),
    "today": today?.toJson(),
    "categories": categories?.toJson(),
    "contributors": contributors?.toJson(),
    "featured_news": featuredNews?.toJson(),
    "news": news?.toJson(),
    "news_wide": newsWide?.toJson(),
    "ads": ads?.toJson(),
    "calendar": calendar?.toJson(),
    "newsletter": newsletter?.toJson(),
    "involve": involve?.toJson(),
    "explore": explore?.toJson(),
    "celebrate": celebrate?.toJson(),
  };
}

class Ads {
  final List<AdsItem>? items;

  Ads({
    this.items,
  });

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
    items: json["items"] == null ? [] : List<AdsItem>.from(json["items"]!.map((x) => AdsItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class AdsItem {
  final String? id;
  final String? variant;
  final String? label;
  final String? url;
  final String? image;
  final String? imageAlt;
  final Title? headline;
  final ItemBrand? brand;
  final ItemCta? cta;

  AdsItem({
    this.id,
    this.variant,
    this.label,
    this.url,
    this.image,
    this.imageAlt,
    this.headline,
    this.brand,
    this.cta,
  });

  factory AdsItem.fromJson(Map<String, dynamic> json) => AdsItem(
    id: json["id"],
    variant: json["variant"],
    label: json["label"],
    url: json["url"],
    image: json["image"],
    imageAlt: json["image_alt"],
    headline: json["headline"] == null ? null : Title.fromJson(json["headline"]),
    brand: json["brand"] == null ? null : ItemBrand.fromJson(json["brand"]),
    cta: json["cta"] == null ? null : ItemCta.fromJson(json["cta"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "variant": variant,
    "label": label,
    "url": url,
    "image": image,
    "image_alt": imageAlt,
    "headline": headline?.toJson(),
    "brand": brand?.toJson(),
    "cta": cta?.toJson(),
  };
}

class ItemBrand {
  final String? name;
  final String? secondaryName;
  final String? icon;

  ItemBrand({
    this.name,
    this.secondaryName,
    this.icon,
  });

  factory ItemBrand.fromJson(Map<String, dynamic> json) => ItemBrand(
    name: json["name"],
    secondaryName: json["secondary_name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "secondary_name": secondaryName,
    "icon": icon,
  };
}

class ItemCta {
  final String? label;

  ItemCta({
    this.label,
  });

  factory ItemCta.fromJson(Map<String, dynamic> json) => ItemCta(
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
  };
}

class Title {
  final String? line1;
  final String? line2;

  Title({
    this.line1,
    this.line2,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    line1: json["line1"],
    line2: json["line2"],
  );

  Map<String, dynamic> toJson() => {
    "line1": line1,
    "line2": line2,
  };
}

class Calendar {
  final String? title;
  final List<View>? views;
  final Actions? actions;
  final String? month;
  final Navigation? navigation;
  final List<Weekday>? weekdays;
  final List<Legend>? legend;

  Calendar({
    this.title,
    this.views,
    this.actions,
    this.month,
    this.navigation,
    this.weekdays,
    this.legend,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
    title: json["title"],
    views: json["views"] == null ? [] : List<View>.from(json["views"]!.map((x) => View.fromJson(x))),
    actions: json["actions"] == null ? null : Actions.fromJson(json["actions"]),
    month: json["month"],
    navigation: json["navigation"] == null ? null : Navigation.fromJson(json["navigation"]),
    weekdays: json["weekdays"] == null ? [] : List<Weekday>.from(json["weekdays"]!.map((x) => Weekday.fromJson(x))),
    legend: json["legend"] == null ? [] : List<Legend>.from(json["legend"]!.map((x) => Legend.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "views": views == null ? [] : List<dynamic>.from(views!.map((x) => x.toJson())),
    "actions": actions?.toJson(),
    "month": month,
    "navigation": navigation?.toJson(),
    "weekdays": weekdays == null ? [] : List<dynamic>.from(weekdays!.map((x) => x.toJson())),
    "legend": legend == null ? [] : List<dynamic>.from(legend!.map((x) => x.toJson())),
  };
}

class Actions {
  final Link? submitEvent;
  final Link? viewAll;

  Actions({
    this.submitEvent,
    this.viewAll,
  });

  factory Actions.fromJson(Map<String, dynamic> json) => Actions(
    submitEvent: json["submit_event"] == null ? null : Link.fromJson(json["submit_event"]),
    viewAll: json["view_all"] == null ? null : Link.fromJson(json["view_all"]),
  );

  Map<String, dynamic> toJson() => {
    "submit_event": submitEvent?.toJson(),
    "view_all": viewAll?.toJson(),
  };
}

class Link {
  final String? label;
  final String? url;
  final String? icon;
  final String? id;
  final int? value;

  Link({
    this.label,
    this.url,
    this.icon,
    this.id,
    this.value,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    label: json["label"],
    url: json["url"],
    icon: json["icon"],
    id: json["id"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "url": url,
    "icon": icon,
    "id": id,
    "value": value,
  };
}

class Legend {
  final String? id;
  final String? label;
  final String? type;

  Legend({
    this.id,
    this.label,
    this.type,
  });

  factory Legend.fromJson(Map<String, dynamic> json) => Legend(
    id: json["id"],
    label: json["label"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "type": type,
  };
}

class Navigation {
  final Next? previous;
  final Next? next;

  Navigation({
    this.previous,
    this.next,
  });

  factory Navigation.fromJson(Map<String, dynamic> json) => Navigation(
    previous: json["previous"] == null ? null : Next.fromJson(json["previous"]),
    next: json["next"] == null ? null : Next.fromJson(json["next"]),
  );

  Map<String, dynamic> toJson() => {
    "previous": previous?.toJson(),
    "next": next?.toJson(),
  };
}

class Next {
  final String? label;
  final String? icon;

  Next({
    this.label,
    this.icon,
  });

  factory Next.fromJson(Map<String, dynamic> json) => Next(
    label: json["label"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "icon": icon,
  };
}

class View {
  final String? id;
  final String? label;
  final bool? active;

  View({
    this.id,
    this.label,
    this.active,
  });

  factory View.fromJson(Map<String, dynamic> json) => View(
    id: json["id"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "active": active,
  };
}

class Weekday {
  final String? short;
  final String? label;

  Weekday({
    this.short,
    this.label,
  });

  factory Weekday.fromJson(Map<String, dynamic> json) => Weekday(
    short: json["short"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "short": short,
    "label": label,
  };
}

class Categories {
  final String? title;
  final List<LinkElement>? items;
  final Link? link;

  Categories({
    this.title,
    this.items,
    this.link,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    title: json["title"],
    items: json["items"] == null ? [] : List<LinkElement>.from(json["items"]!.map((x) => LinkElement.fromJson(x))),
    link: json["link"] == null ? null : Link.fromJson(json["link"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "link": link?.toJson(),
  };
}

class LinkElement {
  final String? id;
  final String? label;
  final String? url;
  final String? icon;
  final String? tone;
  final dynamic value;

  LinkElement({
    this.id,
    this.label,
    this.url,
    this.icon,
    this.tone,
    this.value,
  });

  factory LinkElement.fromJson(Map<String, dynamic> json) => LinkElement(
    id: json["id"],
    label: json["label"],
    url: json["url"],
    icon: json["icon"],
    tone: json["tone"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "url": url,
    "icon": icon,
    "tone": tone,
    "value": value,
  };
}

class Celebrate {
  final String? title;
  final String? subtitle;
  final List<CelebrateItem>? items;

  Celebrate({
    this.title,
    this.subtitle,
    this.items,
  });

  factory Celebrate.fromJson(Map<String, dynamic> json) => Celebrate(
    title: json["title"],
    subtitle: json["subtitle"],
    items: json["items"] == null ? [] : List<CelebrateItem>.from(json["items"]!.map((x) => CelebrateItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class CelebrateItem {
  final String? id;
  final String? title;
  final String? description;
  final String? url;
  final String? icon;
  final String? tone;
  final LinkElement? action;

  CelebrateItem({
    this.id,
    this.title,
    this.description,
    this.url,
    this.icon,
    this.tone,
    this.action,
  });

  factory CelebrateItem.fromJson(Map<String, dynamic> json) => CelebrateItem(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    icon: json["icon"],
    tone: json["tone"],
    action: json["action"] == null ? null : LinkElement.fromJson(json["action"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "url": url,
    "icon": icon,
    "tone": tone,
    "action": action?.toJson(),
  };
}

class Contributors {
  final String? title;
  final List<ContributorsItem>? items;
  final Note? note;

  Contributors({
    this.title,
    this.items,
    this.note,
  });

  factory Contributors.fromJson(Map<String, dynamic> json) => Contributors(
    title: json["title"],
    items: json["items"] == null ? [] : List<ContributorsItem>.from(json["items"]!.map((x) => ContributorsItem.fromJson(x))),
    note: json["note"] == null ? null : Note.fromJson(json["note"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "note": note?.toJson(),
  };
}

class ContributorsItem {
  final String? id;
  final int? rank;
  final String? name;
  final String? url;
  final String? image;
  final String? alt;
  final String? beat;

  ContributorsItem({
    this.id,
    this.rank,
    this.name,
    this.url,
    this.image,
    this.alt,
    this.beat,
  });

  factory ContributorsItem.fromJson(Map<String, dynamic> json) => ContributorsItem(
    id: json["id"],
    rank: json["rank"],
    name: json["name"],
    url: json["url"],
    image: json["image"],
    alt: json["alt"],
    beat: json["beat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rank": rank,
    "name": name,
    "url": url,
    "image": image,
    "alt": alt,
    "beat": beat,
  };
}

class Note {
  final String? text;
  final String? icon;

  Note({
    this.text,
    this.icon,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    text: json["text"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "icon": icon,
  };
}

class Events {
  final String? title;
  final List<LinkElement>? links;
  final List<PurpleItem>? items;
  final Advertisement? advertisement;

  Events({
    this.title,
    this.links,
    this.items,
    this.advertisement,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
    title: json["title"],
    links: json["links"] == null ? [] : List<LinkElement>.from(json["links"]!.map((x) => LinkElement.fromJson(x))),
    items: json["items"] == null ? [] : List<PurpleItem>.from(json["items"]!.map((x) => PurpleItem.fromJson(x))),
    advertisement: json["advertisement"] == null ? null : Advertisement.fromJson(json["advertisement"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "advertisement": advertisement?.toJson(),
  };
}

class Advertisement {
  final String? label;
  final String? url;
  final String? image;
  final String? imageAlt;
  final Title? headline;
  final AdvertisementBrand? brand;
  final ItemCta? cta;

  Advertisement({
    this.label,
    this.url,
    this.image,
    this.imageAlt,
    this.headline,
    this.brand,
    this.cta,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) => Advertisement(
    label: json["label"],
    url: json["url"],
    image: json["image"],
    imageAlt: json["image_alt"],
    headline: json["headline"] == null ? null : Title.fromJson(json["headline"]),
    brand: json["brand"] == null ? null : AdvertisementBrand.fromJson(json["brand"]),
    cta: json["cta"] == null ? null : ItemCta.fromJson(json["cta"]),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "url": url,
    "image": image,
    "image_alt": imageAlt,
    "headline": headline?.toJson(),
    "brand": brand?.toJson(),
    "cta": cta?.toJson(),
  };
}

class AdvertisementBrand {
  final String? name;
  final String? icon;

  AdvertisementBrand({
    this.name,
    this.icon,
  });

  factory AdvertisementBrand.fromJson(Map<String, dynamic> json) => AdvertisementBrand(
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "icon": icon,
  };
}

class PurpleItem {
  final int? id;
  final String? title;
  final String? url;
  final String? image;
  final String? imageAlt;
  final Date? date;
  final Next? category;
  final Next? location;
  final PublishedAt? time;
  final String? timeIcon;
  final int? savedCount;
  final String? savedIcon;

  PurpleItem({
    this.id,
    this.title,
    this.url,
    this.image,
    this.imageAlt,
    this.date,
    this.category,
    this.location,
    this.time,
    this.timeIcon,
    this.savedCount,
    this.savedIcon,
  });

  factory PurpleItem.fromJson(Map<String, dynamic> json) => PurpleItem(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    image: json["image"],
    imageAlt: json["image_alt"],
    date: json["date"] == null ? null : Date.fromJson(json["date"]),
    category: json["category"] == null ? null : Next.fromJson(json["category"]),
    location: json["location"] == null ? null : Next.fromJson(json["location"]),
    time: json["time"] == null ? null : PublishedAt.fromJson(json["time"]),
    timeIcon: json["time_icon"],
    savedCount: json["saved_count"],
    savedIcon: json["saved_icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "image": image,
    "image_alt": imageAlt,
    "date": date?.toJson(),
    "category": category?.toJson(),
    "location": location?.toJson(),
    "time": time?.toJson(),
    "time_icon": timeIcon,
    "saved_count": savedCount,
    "saved_icon": savedIcon,
  };
}

class Date {
  final String? month;
  final String? day;
  final DateTime? value;
  final String? weekday;

  Date({
    this.month,
    this.day,
    this.value,
    this.weekday,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    month: json["month"],
    day: json["day"],
    value: json["value"] == null ? null : DateTime.parse(json["value"]),
    weekday: json["weekday"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "day": day,
    "value": value == null ? null : "${value!.year.toString().padLeft(4, '0')}-${value!.month.toString().padLeft(2, '0')}-${value!.day.toString().padLeft(2, '0')}",
    "weekday": weekday,
  };
}

class PublishedAt {
  final String? label;
  final String? value;

  PublishedAt({
    this.label,
    this.value,
  });

  factory PublishedAt.fromJson(Map<String, dynamic> json) => PublishedAt(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}

class Explore {
  final String? title;
  final Weekend? weekend;
  final Businesses? deals;
  final Businesses? venues;
  final Businesses? businesses;

  Explore({
    this.title,
    this.weekend,
    this.deals,
    this.venues,
    this.businesses,
  });

  factory Explore.fromJson(Map<String, dynamic> json) => Explore(
    title: json["title"],
    weekend: json["weekend"] == null ? null : Weekend.fromJson(json["weekend"]),
    deals: json["deals"] == null ? null : Businesses.fromJson(json["deals"]),
    venues: json["venues"] == null ? null : Businesses.fromJson(json["venues"]),
    businesses: json["businesses"] == null ? null : Businesses.fromJson(json["businesses"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "weekend": weekend?.toJson(),
    "deals": deals?.toJson(),
    "venues": venues?.toJson(),
    "businesses": businesses?.toJson(),
  };
}

class Businesses {
  final String? title;
  final List<BusinessesItem>? items;
  final Action? action;

  Businesses({
    this.title,
    this.items,
    this.action,
  });

  factory Businesses.fromJson(Map<String, dynamic> json) => Businesses(
    title: json["title"],
    items: json["items"] == null ? [] : List<BusinessesItem>.from(json["items"]!.map((x) => BusinessesItem.fromJson(x))),
    action: json["action"] == null ? null : Action.fromJson(json["action"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "action": action?.toJson(),
  };
}

class Action {
  final String? label;
  final String? url;
  final String? icon;

  Action({
    this.label,
    this.url,
    this.icon,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
    label: json["label"],
    url: json["url"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "url": url,
    "icon": icon,
  };
}

class BusinessesItem {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? url;
  final String? image;
  final String? imageAlt;

  BusinessesItem({
    this.id,
    this.title,
    this.subtitle,
    this.url,
    this.image,
    this.imageAlt,
  });

  factory BusinessesItem.fromJson(Map<String, dynamic> json) => BusinessesItem(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    url: json["url"],
    image: json["image"],
    imageAlt: json["image_alt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "url": url,
    "image": image,
    "image_alt": imageAlt,
  };
}

class Weekend {
  final String? eyebrow;
  final String? dates;
  final String? description;
  final String? image;
  final String? imageAlt;
  final LinkElement? action;

  Weekend({
    this.eyebrow,
    this.dates,
    this.description,
    this.image,
    this.imageAlt,
    this.action,
  });

  factory Weekend.fromJson(Map<String, dynamic> json) => Weekend(
    eyebrow: json["eyebrow"],
    dates: json["dates"],
    description: json["description"],
    image: json["image"],
    imageAlt: json["image_alt"],
    action: json["action"] == null ? null : LinkElement.fromJson(json["action"]),
  );

  Map<String, dynamic> toJson() => {
    "eyebrow": eyebrow,
    "dates": dates,
    "description": description,
    "image": image,
    "image_alt": imageAlt,
    "action": action?.toJson(),
  };
}

class FeaturedNews {
  final String? image;
  final String? imageAlt;
  final String? kicker;
  final String? title;
  final String? url;
  final Author? author;
  final PublishedAt? publishedAt;
  final String? readTime;
  final String? excerpt;
  final List<LinkElement>? stats;

  FeaturedNews({
    this.image,
    this.imageAlt,
    this.kicker,
    this.title,
    this.url,
    this.author,
    this.publishedAt,
    this.readTime,
    this.excerpt,
    this.stats,
  });

  factory FeaturedNews.fromJson(Map<String, dynamic> json) => FeaturedNews(
    image: json["image"],
    imageAlt: json["image_alt"],
    kicker: json["kicker"],
    title: json["title"],
    url: json["url"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    publishedAt: json["published_at"] == null ? null : PublishedAt.fromJson(json["published_at"]),
    readTime: json["read_time"],
    excerpt: json["excerpt"],
    stats: json["stats"] == null ? [] : List<LinkElement>.from(json["stats"]!.map((x) => LinkElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "image_alt": imageAlt,
    "kicker": kicker,
    "title": title,
    "url": url,
    "author": author?.toJson(),
    "published_at": publishedAt?.toJson(),
    "read_time": readTime,
    "excerpt": excerpt,
    "stats": stats == null ? [] : List<dynamic>.from(stats!.map((x) => x.toJson())),
  };
}

class Author {
  final String? name;

  Author({
    this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class Hero {
  final String? eyebrow;
  final Title? title;
  final String? description;
  final String? image;
  final List<LinkElement>? stats;
  final List<Link>? actions;
  final AiBrief? aiBrief;

  Hero({
    this.eyebrow,
    this.title,
    this.description,
    this.image,
    this.stats,
    this.actions,
    this.aiBrief,
  });

  factory Hero.fromJson(Map<String, dynamic> json) => Hero(
    eyebrow: json["eyebrow"],
    title: json["title"] == null ? null : Title.fromJson(json["title"]),
    description: json["description"],
    image: json["image"],
    stats: json["stats"] == null ? [] : List<LinkElement>.from(json["stats"]!.map((x) => LinkElement.fromJson(x))),
    actions: json["actions"] == null ? [] : List<Link>.from(json["actions"]!.map((x) => Link.fromJson(x))),
    aiBrief: json["ai_brief"] == null ? null : AiBrief.fromJson(json["ai_brief"]),
  );

  Map<String, dynamic> toJson() => {
    "eyebrow": eyebrow,
    "title": title?.toJson(),
    "description": description,
    "image": image,
    "stats": stats == null ? [] : List<dynamic>.from(stats!.map((x) => x.toJson())),
    "actions": actions == null ? [] : List<dynamic>.from(actions!.map((x) => x.toJson())),
    "ai_brief": aiBrief?.toJson(),
  };
}

class AiBrief {
  final String? title;
  final String? badge;
  final Guide? guide;
  final String? greeting;
  final int? eventCount;
  final String? location;
  final String? highlight;
  final String? description;
  final Next? updated;
  final AiBriefCta? cta;

  AiBrief({
    this.title,
    this.badge,
    this.guide,
    this.greeting,
    this.eventCount,
    this.location,
    this.highlight,
    this.description,
    this.updated,
    this.cta,
  });

  factory AiBrief.fromJson(Map<String, dynamic> json) => AiBrief(
    title: json["title"],
    badge: json["badge"],
    guide: json["guide"] == null ? null : Guide.fromJson(json["guide"]),
    greeting: json["greeting"],
    eventCount: json["event_count"],
    location: json["location"],
    highlight: json["highlight"],
    description: json["description"],
    updated: json["updated"] == null ? null : Next.fromJson(json["updated"]),
    cta: json["cta"] == null ? null : AiBriefCta.fromJson(json["cta"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "badge": badge,
    "guide": guide?.toJson(),
    "greeting": greeting,
    "event_count": eventCount,
    "location": location,
    "highlight": highlight,
    "description": description,
    "updated": updated?.toJson(),
    "cta": cta?.toJson(),
  };
}

class AiBriefCta {
  final String? label;
  final String? url;

  AiBriefCta({
    this.label,
    this.url,
  });

  factory AiBriefCta.fromJson(Map<String, dynamic> json) => AiBriefCta(
    label: json["label"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "url": url,
  };
}

class Guide {
  final String? image;
  final String? alt;

  Guide({
    this.image,
    this.alt,
  });

  factory Guide.fromJson(Map<String, dynamic> json) => Guide(
    image: json["image"],
    alt: json["alt"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "alt": alt,
  };
}

class Involve {
  final String? title;
  final List<CelebrateItem>? items;

  Involve({
    this.title,
    this.items,
  });

  factory Involve.fromJson(Map<String, dynamic> json) => Involve(
    title: json["title"],
    items: json["items"] == null ? [] : List<CelebrateItem>.from(json["items"]!.map((x) => CelebrateItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Location {
  final int? id;
  final String? name;
  final String? state;
  final String? stateCode;
  final String? header;
  final String? image;

  Location({
    this.id,
    this.name,
    this.state,
    this.stateCode,
    this.header,
    this.image,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    name: json["name"],
    state: json["state"],
    stateCode: json["stateCode"],
    header: json["header"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state": state,
    "stateCode": stateCode,
    "header": header,
    "image": image,
  };
}

class News {
  final List<NewsItem>? items;

  News({
    this.items,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    items: json["items"] == null ? [] : List<NewsItem>.from(json["items"]!.map((x) => NewsItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class NewsItem {
  final String? id;
  final String? image;
  final String? imageAlt;
  final String? kicker;
  final String? title;
  final String? url;
  final String? author;
  final PublishedAt? publishedAt;
  final String? excerpt;
  final List<Link>? stats;

  NewsItem({
    this.id,
    this.image,
    this.imageAlt,
    this.kicker,
    this.title,
    this.url,
    this.author,
    this.publishedAt,
    this.excerpt,
    this.stats,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) => NewsItem(
    id: json["id"],
    image: json["image"],
    imageAlt: json["image_alt"],
    kicker: json["kicker"],
    title: json["title"],
    url: json["url"],
    author: json["author"],
    publishedAt: json["published_at"] == null ? null : PublishedAt.fromJson(json["published_at"]),
    excerpt: json["excerpt"],
    stats: json["stats"] == null ? [] : List<Link>.from(json["stats"]!.map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "image_alt": imageAlt,
    "kicker": kicker,
    "title": title,
    "url": url,
    "author": author,
    "published_at": publishedAt?.toJson(),
    "excerpt": excerpt,
    "stats": stats == null ? [] : List<dynamic>.from(stats!.map((x) => x.toJson())),
  };
}

class NewsWide {
  final List<NewsWideItem>? items;

  NewsWide({
    this.items,
  });

  factory NewsWide.fromJson(Map<String, dynamic> json) => NewsWide(
    items: json["items"] == null ? [] : List<NewsWideItem>.from(json["items"]!.map((x) => NewsWideItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class NewsWideItem {
  final String? id;
  final String? variant;
  final String? image;
  final String? imageAlt;
  final String? kicker;
  final String? title;
  final String? url;
  final String? author;
  final PublishedAt? publishedAt;
  final String? excerpt;
  final List<LinkElement>? stats;

  NewsWideItem({
    this.id,
    this.variant,
    this.image,
    this.imageAlt,
    this.kicker,
    this.title,
    this.url,
    this.author,
    this.publishedAt,
    this.excerpt,
    this.stats,
  });

  factory NewsWideItem.fromJson(Map<String, dynamic> json) => NewsWideItem(
    id: json["id"],
    variant: json["variant"],
    image: json["image"],
    imageAlt: json["image_alt"],
    kicker: json["kicker"],
    title: json["title"],
    url: json["url"],
    author: json["author"],
    publishedAt: json["published_at"] == null ? null : PublishedAt.fromJson(json["published_at"]),
    excerpt: json["excerpt"],
    stats: json["stats"] == null ? [] : List<LinkElement>.from(json["stats"]!.map((x) => LinkElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "variant": variant,
    "image": image,
    "image_alt": imageAlt,
    "kicker": kicker,
    "title": title,
    "url": url,
    "author": author,
    "published_at": publishedAt?.toJson(),
    "excerpt": excerpt,
    "stats": stats == null ? [] : List<dynamic>.from(stats!.map((x) => x.toJson())),
  };
}

class Newsletter {
  final String? title;
  final String? subtitle;
  final String? icon;
  final Form? form;

  Newsletter({
    this.title,
    this.subtitle,
    this.icon,
    this.form,
  });

  factory Newsletter.fromJson(Map<String, dynamic> json) => Newsletter(
    title: json["title"],
    subtitle: json["subtitle"],
    icon: json["icon"],
    form: json["form"] == null ? null : Form.fromJson(json["form"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle,
    "icon": icon,
    "form": form?.toJson(),
  };
}

class Form {
  final String? action;
  final String? method;
  final String? emailLabel;
  final String? emailName;
  final String? emailPlaceholder;
  final String? submitLabel;

  Form({
    this.action,
    this.method,
    this.emailLabel,
    this.emailName,
    this.emailPlaceholder,
    this.submitLabel,
  });

  factory Form.fromJson(Map<String, dynamic> json) => Form(
    action: json["action"],
    method: json["method"],
    emailLabel: json["email_label"],
    emailName: json["email_name"],
    emailPlaceholder: json["email_placeholder"],
    submitLabel: json["submit_label"],
  );

  Map<String, dynamic> toJson() => {
    "action": action,
    "method": method,
    "email_label": emailLabel,
    "email_name": emailName,
    "email_placeholder": emailPlaceholder,
    "submit_label": submitLabel,
  };
}

class Planner {
  final String? title;
  final String? subtitle;
  final List<Filter>? filters;
  final List<PlannerItem>? items;

  Planner({
    this.title,
    this.subtitle,
    this.filters,
    this.items,
  });

  factory Planner.fromJson(Map<String, dynamic> json) => Planner(
    title: json["title"],
    subtitle: json["subtitle"],
    filters: json["filters"] == null ? [] : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
    items: json["items"] == null ? [] : List<PlannerItem>.from(json["items"]!.map((x) => PlannerItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle,
    "filters": filters == null ? [] : List<dynamic>.from(filters!.map((x) => x.toJson())),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Filter {
  final String? id;
  final String? label;

  Filter({
    this.id,
    this.label,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    id: json["id"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
  };
}

class PlannerItem {
  final int? id;
  final Date? date;
  final String? image;
  final String? title;
  final String? url;
  final String? time;
  final String? location;
  final String? note;
  final Tag? tag;
  final String? cost;
  final String? distance;
  final List<String>? filterIds;
  final Icons? icons;

  PlannerItem({
    this.id,
    this.date,
    this.image,
    this.title,
    this.url,
    this.time,
    this.location,
    this.note,
    this.tag,
    this.cost,
    this.distance,
    this.filterIds,
    this.icons,
  });

  factory PlannerItem.fromJson(Map<String, dynamic> json) => PlannerItem(
    id: json["id"],
    date: json["date"] == null ? null : Date.fromJson(json["date"]),
    image: json["image"],
    title: json["title"],
    url: json["url"],
    time: json["time"],
    location: json["location"],
    note: json["note"],
    tag: json["tag"] == null ? null : Tag.fromJson(json["tag"]),
    cost: json["cost"],
    distance: json["distance"],
    filterIds: json["filter_ids"] == null ? [] : List<String>.from(json["filter_ids"]!.map((x) => x)),
    icons: json["icons"] == null ? null : Icons.fromJson(json["icons"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date?.toJson(),
    "image": image,
    "title": title,
    "url": url,
    "time": time,
    "location": location,
    "note": note,
    "tag": tag?.toJson(),
    "cost": cost,
    "distance": distance,
    "filter_ids": filterIds == null ? [] : List<dynamic>.from(filterIds!.map((x) => x)),
    "icons": icons?.toJson(),
  };
}

class Icons {
  final String? tickets;
  final String? pin;
  final String? favorite;

  Icons({
    this.tickets,
    this.pin,
    this.favorite,
  });

  factory Icons.fromJson(Map<String, dynamic> json) => Icons(
    tickets: json["tickets"],
    pin: json["pin"],
    favorite: json["favorite"],
  );

  Map<String, dynamic> toJson() => {
    "tickets": tickets,
    "pin": pin,
    "favorite": favorite,
  };
}

class Tag {
  final String? label;
  final String? type;

  Tag({
    this.label,
    this.type,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    label: json["label"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "type": type,
  };
}

class Today {
  final String? title;
  final List<TodayItem>? items;
  final Link? link;

  Today({
    this.title,
    this.items,
    this.link,
  });

  factory Today.fromJson(Map<String, dynamic> json) => Today(
    title: json["title"],
    items: json["items"] == null ? [] : List<TodayItem>.from(json["items"]!.map((x) => TodayItem.fromJson(x))),
    link: json["link"] == null ? null : Link.fromJson(json["link"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "link": link?.toJson(),
  };
}

class TodayItem {
  final String? id;
  final String? label;
  final int? count;
  final String? countLabel;
  final String? icon;
  final String? tone;

  TodayItem({
    this.id,
    this.label,
    this.count,
    this.countLabel,
    this.icon,
    this.tone,
  });

  factory TodayItem.fromJson(Map<String, dynamic> json) => TodayItem(
    id: json["id"],
    label: json["label"],
    count: json["count"],
    countLabel: json["count_label"],
    icon: json["icon"],
    tone: json["tone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "count": count,
    "count_label": countLabel,
    "icon": icon,
    "tone": tone,
  };
}
