
import 'dart:convert';

PoliticsResponse politicsResponseFromJson(String str) => PoliticsResponse.fromJson(json.decode(str));

class PoliticsResponse {
  final bool? success;
  final String? message;
  final PoliticsData? data;

  PoliticsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory PoliticsResponse.fromJson(Map<String, dynamic> json) => PoliticsResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : PoliticsData.fromJson(json["data"]),
  );
}

class PoliticsData {
  final Location? location;
  final Hero? hero;
  final Representation? representation;
  final Score? score;
  final HappeningNow? happeningNow;
  final TopDiscussions? topDiscussions;
  final Bills? bills;
  final LocalNews? localNews;
  final CommunityVoices? communityVoices;
  final AskRepresentatives? askRepresentatives;
  final CivicActivity? townHall;
  final CivicActivity? civicActivity;

  PoliticsData({
    this.location,
    this.hero,
    this.representation,
    this.score,
    this.happeningNow,
    this.topDiscussions,
    this.bills,
    this.localNews,
    this.communityVoices,
    this.askRepresentatives,
    this.townHall,
    this.civicActivity,
  });

  factory PoliticsData.fromJson(Map<String, dynamic> json) => PoliticsData(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    hero: json["hero"] == null ? null : Hero.fromJson(json["hero"]),
    representation: json["representation"] == null ? null : Representation.fromJson(json["representation"]),
    score: json["score"] == null ? null : Score.fromJson(json["score"]),
    happeningNow: json["happening_now"] == null ? null : HappeningNow.fromJson(json["happening_now"]),
    topDiscussions: json["top_discussions"] == null ? null : TopDiscussions.fromJson(json["top_discussions"]),
    bills: json["bills"] == null ? null : Bills.fromJson(json["bills"]),
    localNews: json["local_news"] == null ? null : LocalNews.fromJson(json["local_news"]),
    communityVoices: json["community_voices"] == null ? null : CommunityVoices.fromJson(json["community_voices"]),
    askRepresentatives: json["ask_representatives"] == null ? null : AskRepresentatives.fromJson(json["ask_representatives"]),
    townHall: json["town_hall"] == null ? null : CivicActivity.fromJson(json["town_hall"]),
    civicActivity: json["civic_activity"] == null ? null : CivicActivity.fromJson(json["civic_activity"]),
  );
}

class AskRepresentatives {
  final String? title;
  final String? subtitle;
  final List<AskRepresentativesItem>? items;
  final Button? button;

  AskRepresentatives({
    this.title,
    this.subtitle,
    this.items,
    this.button,
  });

  factory AskRepresentatives.fromJson(Map<String, dynamic> json) => AskRepresentatives(
    title: json["title"],
    subtitle: json["subtitle"],
    items: json["items"] == null ? [] : List<AskRepresentativesItem>.from(json["items"]!.map((x) => AskRepresentativesItem.fromJson(x))),
    button: json["button"] == null ? null : Button.fromJson(json["button"]),
  );
}

class Button {
  final String? text;

  Button({this.text});

  factory Button.fromJson(Map<String, dynamic> json) => Button(
    text: json["text"]);
}

class AskRepresentativesItem {
  final String? question;
  final DateTime? askedAt;
  final String? askedBy;
  final String? status;
  final Resident? resident;

  AskRepresentativesItem({
    this.question,
    this.askedAt,
    this.askedBy,
    this.status,
    this.resident,
  });

  factory AskRepresentativesItem.fromJson(Map<String, dynamic> json) => AskRepresentativesItem(
    question: json["question"],
    askedAt: json["asked_at"] == null ? null : DateTime.parse(json["asked_at"]),
    askedBy: json["asked_by"],
    status: json["status"],
    resident: json["resident"] == null ? null : Resident.fromJson(json["resident"]),
  );
}

class Resident {
  final Guide? image;

  Resident({
    this.image,
  });

  factory Resident.fromJson(Map<String, dynamic> json) => Resident(
    image: json["image"] == null ? null : Guide.fromJson(json["image"]),
  );
}

class Guide {
  final String? src;
  final int? width;
  final int? height;
  final String? alt;

  Guide({
    this.src,
    this.width,
    this.height,
    this.alt,
  });

  factory Guide.fromJson(Map<String, dynamic> json) => Guide(
    src: json["src"],
    width: json["width"],
    height: json["height"],
    alt: json["alt"],
  );
}

class Bills {
  final String? title;
  final String? subtitle;
  final String? viewAllUrl;
  final List<Tab>? tabs;
  final List<Bill>? bills;

  Bills({
    this.title,
    this.subtitle,
    this.viewAllUrl,
    this.tabs,
    this.bills,
  });

  factory Bills.fromJson(Map<String, dynamic> json) => Bills(
    title: json["title"],
    subtitle: json["subtitle"],
    viewAllUrl: json["view_all_url"],
    tabs: json["tabs"] == null ? [] : List<Tab>.from(json["tabs"]!.map((x) => Tab.fromJson(x))),
    bills: json["bills"] == null ? [] : List<Bill>.from(json["bills"]!.map((x) => Bill.fromJson(x))),
  );
}

class Bill {
  final String? id;
  final String? name;
  final String? code;
  final Level? level;
  final String? description;
  final List<Progress>? progress;
  final StatusClass? status;
  final Source? source;
  final Button? follow;

  Bill({
    this.id,
    this.name,
    this.code,
    this.level,
    this.description,
    this.progress,
    this.status,
    this.source,
    this.follow,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    level: json["level"] == null ? null : Level.fromJson(json["level"]),
    description: json["description"],
    progress: json["progress"] == null ? [] : List<Progress>.from(json["progress"]!.map((x) => Progress.fromJson(x))),
    status: json["status"] == null ? null : StatusClass.fromJson(json["status"]),
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
    follow: json["follow"] == null ? null : Button.fromJson(json["follow"]),
  );
}

class Level {
  final String? value;
  final String? label;

  Level({
    this.value,
    this.label,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
    value: json["value"],
    label: json["label"],
  );
}

class Progress {
  final String? label;
  final String? status;

  Progress({
    this.label,
    this.status,
  });

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
    label: json["label"],
    status: json["status"],
  );
}

class Source {
  final String? label;
  final String? url;

  Source({
    this.label,
    this.url,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    label: json["label"],
    url: json["url"],
  );
}

class StatusClass {
  final String? label;
  final DateTime? date;
  final String? dateText;

  StatusClass({
    this.label,
    this.date,
    this.dateText,
  });

  factory StatusClass.fromJson(Map<String, dynamic> json) => StatusClass(
    label: json["label"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    dateText: json["date_text"],
  );
}

class Tab {
  final String? label;
  final String? value;
  final bool? active;

  Tab({
    this.label,
    this.value,
    this.active,
  });

  factory Tab.fromJson(Map<String, dynamic> json) => Tab(
    label: json["label"],
    value: json["value"],
    active: json["active"],
  );
}

class CivicActivity {
  final String? title;
  final String? subtitle;
  final List<StatElement>? items;
  final ViewAll? viewAll;
  final List<CivicActivityEvent>? events;

  CivicActivity({
    this.title,
    this.subtitle,
    this.items,
    this.viewAll,
    this.events,
  });

  factory CivicActivity.fromJson(Map<String, dynamic> json) => CivicActivity(
    title: json["title"],
    subtitle: json["subtitle"],
    items: json["items"] == null ? [] : List<StatElement>.from(json["items"]!.map((x) => StatElement.fromJson(x))),
    viewAll: json["view_all"] == null ? null : ViewAll.fromJson(json["view_all"]),
    events: json["events"] == null ? [] : List<CivicActivityEvent>.from(json["events"]!.map((x) => CivicActivityEvent.fromJson(x))),
  );
}

class CivicActivityEvent {
  final String? date;
  final String? title;
  final String? time;
  final String? location;
  final String? rsvpText;

  CivicActivityEvent({
    this.date,
    this.title,
    this.time,
    this.location,
    this.rsvpText,
  });

  factory CivicActivityEvent.fromJson(Map<String, dynamic> json) => CivicActivityEvent(
    date: json["date"],
    title: json["title"],
    time: json["time"],
    location: json["location"],
    rsvpText: json["rsvp_text"],
  );
}

class StatElement {
  final String? icon;
  final int? value;
  final String? label;
  final Delta? delta;

  StatElement({
    this.icon,
    this.value,
    this.label,
    this.delta,
  });

  factory StatElement.fromJson(Map<String, dynamic> json) => StatElement(
    icon: json["icon"],
    value: json["value"],
    label: json["label"],
    delta: json["delta"] == null ? null : Delta.fromJson(json["delta"]),
  );
}

class Delta {
  final int? value;
  final String? prefix;
  final String? label;

  Delta({
    this.value,
    this.prefix,
    this.label,
  });

  factory Delta.fromJson(Map<String, dynamic> json) => Delta(
    value: json["value"],
    prefix: json["prefix"],
    label: json["label"],
  );
}

class ViewAll {
  final String? text;
  final String? url;

  ViewAll({
    this.text,
    this.url,
  });

  factory ViewAll.fromJson(Map<String, dynamic> json) => ViewAll(
    text: json["text"],
    url: json["url"],
  );
}

class CommunityVoices {
  final String? title;
  final String? note;
  final String? writeButtonText;
  final String? writeButtonUrl;
  final List<Voice>? voices;

  CommunityVoices({
    this.title,
    this.note,
    this.writeButtonText,
    this.writeButtonUrl,
    this.voices,
  });

  factory CommunityVoices.fromJson(Map<String, dynamic> json) => CommunityVoices(
    title: json["title"],
    note: json["note"],
    writeButtonText: json["write_button_text"],
    writeButtonUrl: json["write_button_url"],
    voices: json["voices"] == null ? [] : List<Voice>.from(json["voices"]!.map((x) => Voice.fromJson(x))),
  );
}

class Voice {
  final String? type;
  final String? tag;
  final Author? author;
  final String? title;
  final String? url;
  final String? description;
  final DateTime? date;
  final String? dateText;

  Voice({
    this.type,
    this.tag,
    this.author,
    this.title,
    this.url,
    this.description,
    this.date,
    this.dateText,
  });

  factory Voice.fromJson(Map<String, dynamic> json) => Voice(
    type: json["type"],
    tag: json["tag"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    title: json["title"],
    url: json["url"],
    description: json["description"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    dateText: json["date_text"],
  );
}

class Author {
  final String? name;
  final String? role;
  final Guide? image;

  Author({
    this.name,
    this.role,
    this.image,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json["name"],
    role: json["role"],
    image: json["image"] == null ? null : Guide.fromJson(json["image"]),
  );
}

class HappeningNow {
  final String? title;
  final String? viewAllUrl;
  final String? viewAllText;
  final List<Legend>? legend;
  final List<HappeningNowEvent>? events;

  HappeningNow({
    this.title,
    this.viewAllUrl,
    this.viewAllText,
    this.legend,
    this.events,
  });

  factory HappeningNow.fromJson(Map<String, dynamic> json) => HappeningNow(
    title: json["title"],
    viewAllUrl: json["view_all_url"],
    viewAllText: json["view_all_text"],
    legend: json["legend"] == null ? [] : List<Legend>.from(json["legend"]!.map((x) => Legend.fromJson(x))),
    events: json["events"] == null ? [] : List<HappeningNowEvent>.from(json["events"]!.map((x) => HappeningNowEvent.fromJson(x))),
  );
}

class HappeningNowEvent {
  final String? date;
  final String? title;
  final String? description;
  final When? when;

  HappeningNowEvent({
    this.date,
    this.title,
    this.description,
    this.when,
  });

  factory HappeningNowEvent.fromJson(Map<String, dynamic> json) => HappeningNowEvent(
    date: json["date"],
    title: json["title"],
    description: json["description"],
    when: json["when"] == null ? null : When.fromJson(json["when"]),
  );
}

class When {
  final String? day;
  final String? time;
  final String? location;

  When({
    this.day,
    this.time,
    this.location,
  });

  factory When.fromJson(Map<String, dynamic> json) => When(
    day: json["day"],
    time: json["time"],
    location: json["location"],
  );
}

class Legend {
  final String? icon;
  final String? label;

  Legend({
    this.icon,
    this.label,
  });

  factory Legend.fromJson(Map<String, dynamic> json) => Legend(
    icon: json["icon"],
    label: json["label"],
  );
}

class Hero {
  final Background? background;
  final Greeting? greeting;
  final String? eyebrow;
  final String? title;
  final String? subtitle;
  final AiBrief? aiBrief;
  final List<StatElement>? stats;

  Hero({
    this.background,
    this.greeting,
    this.eyebrow,
    this.title,
    this.subtitle,
    this.aiBrief,
    this.stats,
  });

  factory Hero.fromJson(Map<String, dynamic> json) => Hero(
    background: json["background"] == null ? null : Background.fromJson(json["background"]),
    greeting: json["greeting"] == null ? null : Greeting.fromJson(json["greeting"]),
    eyebrow: json["eyebrow"],
    title: json["title"],
    subtitle: json["subtitle"],
    aiBrief: json["ai_brief"] == null ? null : AiBrief.fromJson(json["ai_brief"]),
    stats: json["stats"] == null ? [] : List<StatElement>.from(json["stats"]!.map((x) => StatElement.fromJson(x))),
  );
}

class AiBrief {
  final String? title;
  final String? badge;
  final Guide? guide;
  final String? greeting;
  final Lead? lead;
  final List<String>? items;
  final String? buttonText;

  AiBrief({
    this.title,
    this.badge,
    this.guide,
    this.greeting,
    this.lead,
    this.items,
    this.buttonText,
  });

  factory AiBrief.fromJson(Map<String, dynamic> json) => AiBrief(
    title: json["title"],
    badge: json["badge"],
    guide: json["guide"] == null ? null : Guide.fromJson(json["guide"]),
    greeting: json["greeting"],
    lead: json["lead"] == null ? null : Lead.fromJson(json["lead"]),
    items: json["items"] == null ? [] : List<String>.from(json["items"]!.map((x) => x)),
    buttonText: json["button_text"],
  );
}

class Lead {
  final String? before;
  final int? value;
  final String? valueLabel;
  final String? after;

  Lead({
    this.before,
    this.value,
    this.valueLabel,
    this.after,
  });

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
    before: json["before"],
    value: json["value"],
    valueLabel: json["value_label"],
    after: json["after"],
  );
}

class Background {
  final Guide? desktop;
  final Guide? mobile;

  Background({
    this.desktop,
    this.mobile,
  });

  factory Background.fromJson(Map<String, dynamic> json) => Background(
    desktop: json["desktop"] == null ? null : Guide.fromJson(json["desktop"]),
    mobile: json["mobile"] == null ? null : Guide.fromJson(json["mobile"]),
  );
}

class Greeting {
  final String? text;
  final bool? showWave;
  final String? wave;

  Greeting({
    this.text,
    this.showWave,
    this.wave,
  });

  factory Greeting.fromJson(Map<String, dynamic> json) => Greeting(
    text: json["text"],
    showWave: json["show_wave"],
    wave: json["wave"],
  );
}

class LocalNews {
  final String? title;
  final String? viewAllUrl;
  final List<Story>? stories;

  LocalNews({
    this.title,
    this.viewAllUrl,
    this.stories,
  });

  factory LocalNews.fromJson(Map<String, dynamic> json) => LocalNews(
    title: json["title"],
    viewAllUrl: json["view_all_url"],
    stories: json["stories"] == null ? [] : List<Story>.from(json["stories"]!.map((x) => Story.fromJson(x))),
  );
}

class Story {
  final String? id;
  final String? title;
  final String? description;
  final String? author;
  final String? publishedAt;
  final String? publishedText;
  final String? url;
  final bool? featured;
  final Guide? image;

  Story({
    this.id,
    this.title,
    this.description,
    this.author,
    this.publishedAt,
    this.publishedText,
    this.url,
    this.featured,
    this.image,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    author: json["author"],
    publishedAt: json["published_at"],
    publishedText: json["published_text"],
    url: json["url"],
    featured: json["featured"],
    image: json["image"] == null ? null : Guide.fromJson(json["image"]),
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

class Representation {
  final String? title;
  final List<Tab>? tabs;
  final String? viewAllUrl;
  final List<Representative>? representatives;

  Representation({
    this.title,
    this.tabs,
    this.viewAllUrl,
    this.representatives,
  });

  factory Representation.fromJson(Map<String, dynamic> json) => Representation(
    title: json["title"],
    tabs: json["tabs"] == null ? [] : List<Tab>.from(json["tabs"]!.map((x) => Tab.fromJson(x))),
    viewAllUrl: json["view_all_url"],
    representatives: json["representatives"] == null ? [] : List<Representative>.from(json["representatives"]!.map((x) => Representative.fromJson(x))),
  );
}

class Representative {
  final String? level;
  final String? name;
  final String? detail;
  final String? email;
  final String? phone;
  final String? grade;
  final String? gradeLabel;
  final Guide? image;
  final String? icon;
  final String? followText;
  final String? askText;

  Representative({
    this.level,
    this.name,
    this.detail,
    this.email,
    this.phone,
    this.grade,
    this.gradeLabel,
    this.image,
    this.icon,
    this.followText,
    this.askText,
  });

  factory Representative.fromJson(Map<String, dynamic> json) => Representative(
    level: json["level"],
    name: json["name"],
    detail: json["detail"],
    email: json["email"],
    phone: json["phone"],
    grade: json["grade"],
    gradeLabel: json["grade_label"],
    image: json["image"] == null ? null : Guide.fromJson(json["image"]),
    icon: json["icon"],
    followText: json["follow_text"],
    askText: json["ask_text"],
  );
}

class Score {
  final String? title;
  final String? subtitle;
  final List<Tab>? tabs;
  final Overall? overall;
  final List<Breakdown>? breakdown;
  final List<TopRepresentative>? topRepresentatives;
  final String? viewRankingsUrl;
  final String? calculatedUrl;
  final String? calculatedText;
  final String? note;

  Score({
    this.title,
    this.subtitle,
    this.tabs,
    this.overall,
    this.breakdown,
    this.topRepresentatives,
    this.viewRankingsUrl,
    this.calculatedUrl,
    this.calculatedText,
    this.note,
  });

  factory Score.fromJson(Map<String, dynamic> json) => Score(
    title: json["title"],
    subtitle: json["subtitle"],
    tabs: json["tabs"] == null ? [] : List<Tab>.from(json["tabs"]!.map((x) => Tab.fromJson(x))),
    overall: json["overall"] == null ? null : Overall.fromJson(json["overall"]),
    breakdown: json["breakdown"] == null ? [] : List<Breakdown>.from(json["breakdown"]!.map((x) => Breakdown.fromJson(x))),
    topRepresentatives: json["top_representatives"] == null ? [] : List<TopRepresentative>.from(json["top_representatives"]!.map((x) => TopRepresentative.fromJson(x))),
    viewRankingsUrl: json["view_rankings_url"],
    calculatedUrl: json["calculated_url"],
    calculatedText: json["calculated_text"],
    note: json["note"],
  );
}

class Breakdown {
  final String? name;
  final int? fill;
  final String? grade;

  Breakdown({
    this.name,
    this.fill,
    this.grade,
  });

  factory Breakdown.fromJson(Map<String, dynamic> json) => Breakdown(
    name: json["name"],
    fill: json["fill"],
    grade: json["grade"],
  );
}

class Overall {
  final String? label;
  final String? score;
  final String? scoreLabel;
  final List<Level>? averages;
  final DateTime? updatedAt;
  final String? updatedText;

  Overall({
    this.label,
    this.score,
    this.scoreLabel,
    this.averages,
    this.updatedAt,
    this.updatedText,
  });

  factory Overall.fromJson(Map<String, dynamic> json) => Overall(
    label: json["label"],
    score: json["score"],
    scoreLabel: json["score_label"],
    averages: json["averages"] == null ? [] : List<Level>.from(json["averages"]!.map((x) => Level.fromJson(x))),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updatedText: json["updated_text"],
  );
}

class TopRepresentative {
  final String? name;
  final String? role;
  final int? score;
  final String? grade;
  final String? trend;
  final String? trendLabel;
  final Guide? image;

  TopRepresentative({
    this.name,
    this.role,
    this.score,
    this.grade,
    this.trend,
    this.trendLabel,
    this.image,
  });

  factory TopRepresentative.fromJson(Map<String, dynamic> json) => TopRepresentative(
    name: json["name"],
    role: json["role"],
    score: json["score"],
    grade: json["grade"],
    trend: json["trend"],
    trendLabel: json["trend_label"],
    image: json["image"] == null ? null : Guide.fromJson(json["image"]),
  );
}

class TopDiscussions {
  final String? title;
  final String? viewAllUrl;
  final String? viewAllText;
  final List<Discussion>? discussions;

  TopDiscussions({
    this.title,
    this.viewAllUrl,
    this.viewAllText,
    this.discussions,
  });

  factory TopDiscussions.fromJson(Map<String, dynamic> json) => TopDiscussions(
    title: json["title"],
    viewAllUrl: json["view_all_url"],
    viewAllText: json["view_all_text"],
    discussions: json["discussions"] == null ? [] : List<Discussion>.from(json["discussions"]!.map((x) => Discussion.fromJson(x))),
  );
}

class Discussion {
  final String? title;
  final String? url;
  final int? comments;
  final String? commentsText;
  final String? icon;
  final String? iconClass;

  Discussion({
    this.title,
    this.url,
    this.comments,
    this.commentsText,
    this.icon,
    this.iconClass,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) => Discussion(
    title: json["title"],
    url: json["url"],
    comments: json["comments"],
    commentsText: json["comments_text"],
    icon: json["icon"],
    iconClass: json["icon_class"],
  );
}

