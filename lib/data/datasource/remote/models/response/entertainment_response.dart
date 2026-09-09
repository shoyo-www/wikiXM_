import 'dart:convert';

EntertainmentResponse entertainmentResponseFromJson(String str) => EntertainmentResponse.fromJson(json.decode(str));

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
}

class EntertainmentData {
  final Location? location;
  final Hero? hero;
  final Events? events;
  final Today? today;
  final Categories? categories;
  final Contributors? contributors;
  final FeaturedNews? featuredNews;
  final News? news;
  final NewsWide? newsWide;
  final Ads? ads;
  final Planner? planner;
  final Calendar? calendar;
  final Newsletter? newsletter;
  final Involve? involve;
  final Explore? explore;
  final Celebrate? celebrate;

  EntertainmentData({
    this.location,
    this.hero,
    this.events,
    this.today,
    this.categories,
    this.contributors,
    this.featuredNews,
    this.news,
    this.newsWide,
    this.ads,
    this.planner,
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
    today: json["today"] == null ? null : Today.fromJson(json["today"]),
    categories: json["categories"] == null ? null : Categories.fromJson(json["categories"]),
    contributors: json["contributors"] == null ? null : Contributors.fromJson(json["contributors"]),
    featuredNews: json["featured_news"] == null ? null : FeaturedNews.fromJson(json["featured_news"]),
    news: json["news"] == null ? null : News.fromJson(json["news"]),
    newsWide: json["news_wide"] == null ? null : NewsWide.fromJson(json["news_wide"]),
    ads: json["ads"] == null ? null : Ads.fromJson(json["ads"]),
    planner: json["planner"] == null ? null : Planner.fromJson(json["planner"]),
    calendar: json["calendar"] == null ? null : Calendar.fromJson(json["calendar"]),
    newsletter: json["newsletter"] == null ? null : Newsletter.fromJson(json["newsletter"]),
    involve: json["involve"] == null ? null : Involve.fromJson(json["involve"]),
    explore: json["explore"] == null ? null : Explore.fromJson(json["explore"]),
    celebrate: json["celebrate"] == null ? null : Celebrate.fromJson(json["celebrate"]),
  );

}

class Ads {
  final List<AdsItem>? items;

  Ads({
    this.items,
  });

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
    items: json["items"] == null ? [] : List<AdsItem>.from(json["items"]!.map((x) => AdsItem.fromJson(x))),
  );
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

}

class ItemCta {
  final String? label;

  ItemCta({
    this.label,
  });

  factory ItemCta.fromJson(Map<String, dynamic> json) => ItemCta(
    label: json["label"],
  );

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

}

class PurpleItem {
  final String? id;
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

}

class Author {
  final String? name;

  Author({
    this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json["name"],
  );

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
}

class News {
  final List<NewsItem>? items;

  News({
    this.items,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    items: json["items"] == null ? [] : List<NewsItem>.from(json["items"]!.map((x) => NewsItem.fromJson(x))),
  );

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
}

class NewsWide {
  final List<NewsWideItem>? items;

  NewsWide({
    this.items,
  });

  factory NewsWide.fromJson(Map<String, dynamic> json) => NewsWide(
    items: json["items"] == null ? [] : List<NewsWideItem>.from(json["items"]!.map((x) => NewsWideItem.fromJson(x))),
  );

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
}


class PlannerItem {
  final String? id;
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
    filterIds: json["filter_ids"] == null ? [] : List<String>.from(json["filter_ids"]),
    icons: json["icons"] == null ? null : Icons.fromJson(json["icons"]),
  );

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

}
