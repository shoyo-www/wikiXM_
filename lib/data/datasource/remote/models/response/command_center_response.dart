import 'dart:convert';

CommandCenterResponse commandCenterResponseFromJson(String str) => CommandCenterResponse.fromJson(json.decode(str));

class CommandCenterResponse {
  final bool? success;
  final String? message;
  final CommandCenterData? data;

  CommandCenterResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CommandCenterResponse.fromJson(Map<String, dynamic> json) => CommandCenterResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : CommandCenterData.fromJson(json["data"]),
  );
}

class CommandCenterData {
  final Location? location;
  final Hero? hero;
  final List<Priority>? priorities;
  final Bills? bills;
  final ActionPlan? actionPlan;
  final LiveActivity? liveActivity;
  final TownHall? townHall;
  final CivicSolutions? civicSolutions;
  final Representatives? representatives;
  final CommunityBottom? communityBottom;
  final CommunityInsights? communityInsights;

  CommandCenterData({
    this.location,
    this.hero,
    this.priorities,
    this.bills,
    this.actionPlan,
    this.liveActivity,
    this.townHall,
    this.civicSolutions,
    this.representatives,
    this.communityBottom,
    this.communityInsights,
  });

  factory CommandCenterData.fromJson(Map<String, dynamic> json) => CommandCenterData(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    hero: json["hero"] == null ? null : Hero.fromJson(json["hero"]),
    priorities: json["priorities"] == null ? [] : List<Priority>.from(json["priorities"]!.map((x) => Priority.fromJson(x))),
    bills: json["bills"] == null ? null : Bills.fromJson(json["bills"]),
    actionPlan: json["action_plan"] == null ? null : ActionPlan.fromJson(json["action_plan"]),
    liveActivity: json["live_activity"] == null ? null : LiveActivity.fromJson(json["live_activity"]),
    townHall: json["town_hall"] == null ? null : TownHall.fromJson(json["town_hall"]),
    civicSolutions: json["civic_solutions"] == null ? null : CivicSolutions.fromJson(json["civic_solutions"]),
    representatives: json["representatives"] == null ? null : Representatives.fromJson(json["representatives"]),
    communityBottom: json["community_bottom"] == null ? null : CommunityBottom.fromJson(json["community_bottom"]),
    communityInsights: json["community_insights"] == null ? null : CommunityInsights.fromJson(json["community_insights"]),
  );
}

class ActionPlan {
  final String? title;
  final Banner? banner;
  final List<Action>? actions;
  final Follow? follow;

  ActionPlan({
    this.title,
    this.banner,
    this.actions,
    this.follow,
  });

  factory ActionPlan.fromJson(Map<String, dynamic> json) => ActionPlan(
    title: json["title"],
    banner: json["banner"] == null ? null : Banner.fromJson(json["banner"]),
    actions: json["actions"] == null ? [] : List<Action>.from(json["actions"]!.map((x) => Action.fromJson(x))),
    follow: json["follow"] == null ? null : Follow.fromJson(json["follow"]),
  );
}

class Action {
  final int? id;
  final String? duration;
  final String? title;
  final String? description;
  final Link? button;

  Action({
    this.id,
    this.duration,
    this.title,
    this.description,
    this.button,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
    id: json["id"],
    duration: json["duration"],
    title: json["title"],
    description: json["description"],
    button: json["button"] == null ? null : Link.fromJson(json["button"]),
  );
}

class Link {
  final String? text;
  final String? href;
  final String? icon;

  Link({
    this.text,
    this.href,
    this.icon,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    text: json["text"],
    href: json["href"],
    icon: json["icon"],
  );
}

class Banner {
  final String? label;
  final String? title;
  final String? description;
  final int? count;

  Banner({
    this.label,
    this.title,
    this.description,
    this.count,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    label: json["label"],
    title: json["title"],
    description: json["description"],
    count: json["count"],
  );
}

class Follow {
  final String? icon;
  final String? title;
  final String? description;
  final Button? button;
  final int? id;

  Follow({
    this.icon,
    this.title,
    this.description,
    this.button,
    this.id,
  });

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
    icon: json["icon"],
    title: json["title"],
    description: json["description"],
    button: json["button"] == null ? null : Button.fromJson(json["button"]),
    id: json["id"],
  );
}

class Button {
  final String? text;

  Button({
    this.text,
  });

  factory Button.fromJson(Map<String, dynamic> json) => Button(
    text: json["text"],
  );
}

class Bills {
  final String? title;
  final String? intro;
  final List<BillsItem>? items;

  Bills({
    this.title,
    this.intro,
    this.items,
  });

  factory Bills.fromJson(Map<String, dynamic> json) => Bills(
    title: json["title"],
    intro: json["intro"],
    items: json["items"] == null ? [] : List<BillsItem>.from(json["items"]!.map((x) => BillsItem.fromJson(x))),
  );
}

class BillsItem {
  final int? id;
  final String? level;
  final String? billNumber;
  final String? title;
  final String? tone;
  final String? status;
  final String? description;
  final Impact? impact;
  final Fact? note;
  final Comments? comments;

  BillsItem({
    this.id,
    this.level,
    this.billNumber,
    this.title,
    this.tone,
    this.status,
    this.description,
    this.impact,
    this.note,
    this.comments,
  });

  factory BillsItem.fromJson(Map<String, dynamic> json) => BillsItem(
    id: json["id"],
    level: json["level"],
    billNumber: json["bill_number"],
    title: json["title"],
    tone: json["tone"],
    status: json["status"],
    description: json["description"],
    impact: json["impact"] == null ? null : Impact.fromJson(json["impact"]),
    note: json["note"] == null ? null : Fact.fromJson(json["note"]),
    comments: json["comments"] == null ? null : Comments.fromJson(json["comments"]),
  );
}

class Comments {
  final String? icon;
  final int? count;

  Comments({
    this.icon,
    this.count,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    icon: json["icon"],
    count: json["count"],
  );
}

class Impact {
  final String? label;
  final String? value;

  Impact({
    this.label,
    this.value,
  });

  factory Impact.fromJson(Map<String, dynamic> json) => Impact(
    label: json["label"],
    value: json["value"],
  );
}

class Fact {
  final String? icon;
  final String? text;

  Fact({
    this.icon,
    this.text,
  });

  factory Fact.fromJson(Map<String, dynamic> json) => Fact(
    icon: json["icon"],
    text: json["text"],
  );
}

class CivicSolutions {
  final String? title;
  final String? intro;
  final List<CivicSolutionsItem>? items;

  CivicSolutions({
    this.title,
    this.intro,
    this.items,
  });

  factory CivicSolutions.fromJson(Map<String, dynamic> json) => CivicSolutions(
    title: json["title"],
    intro: json["intro"],
    items: json["items"] == null ? [] : List<CivicSolutionsItem>.from(json["items"]!.map((x) => CivicSolutionsItem.fromJson(x))),
  );
}

class CivicSolutionsItem {
  final int? id;
  final String? stage;
  final int? progress;
  final String? title;
  final String? description;
  final String? nextStep;

  CivicSolutionsItem({
    this.id,
    this.stage,
    this.progress,
    this.title,
    this.description,
    this.nextStep,
  });

  factory CivicSolutionsItem.fromJson(Map<String, dynamic> json) => CivicSolutionsItem(
    id: json["id"],
    stage: json["stage"],
    progress: json["progress"],
    title: json["title"],
    description: json["description"],
    nextStep: json["next_step"],
  );
}

class CommunityBottom {
  final Wins? wins;
  final Sponsors? sponsors;

  CommunityBottom({
    this.wins,
    this.sponsors,
  });

  factory CommunityBottom.fromJson(Map<String, dynamic> json) => CommunityBottom(
    wins: json["wins"] == null ? null : Wins.fromJson(json["wins"]),
    sponsors: json["sponsors"] == null ? null : Sponsors.fromJson(json["sponsors"]),
  );
}

class Sponsors {
  final String? title;
  final List<Sponsor>? items;

  Sponsors({
    this.title,
    this.items,
  });

  factory Sponsors.fromJson(Map<String, dynamic> json) => Sponsors(
    title: json["title"],
    items: json["items"] == null ? [] : List<Sponsor>.from(json["items"]!.map((x) => Sponsor.fromJson(x))),
  );
}

class Sponsor {
  final int? id;
  final Guide? image;
  final String? badge;
  final String? title;
  final String? description;

  Sponsor({
    this.id,
    this.image,
    this.badge,
    this.title,
    this.description,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) => Sponsor(
    id: json["id"],
    image: json["image"] == null ? null : Guide.fromJson(json["image"]),
    badge: json["badge"],
    title: json["title"],
    description: json["description"],
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

class Wins {
  final String? title;
  final List<Follow>? items;

  Wins({
    this.title,
    this.items,
  });

  factory Wins.fromJson(Map<String, dynamic> json) => Wins(
    title: json["title"],
    items: json["items"] == null ? [] : List<Follow>.from(json["items"]!.map((x) => Follow.fromJson(x))),
  );
}

class CommunityInsights {
  final Health? health;
  final UpcomingMeetings? upcomingMeetings;
  final LocalAd? localAd;
  final Wins? recentlySolved;
  final CivicJourney? civicJourney;
  final Sponsorship? sponsorship;

  CommunityInsights({
    this.health,
    this.upcomingMeetings,
    this.localAd,
    this.recentlySolved,
    this.civicJourney,
    this.sponsorship,
  });

  factory CommunityInsights.fromJson(Map<String, dynamic> json) => CommunityInsights(
    health: json["health"] == null ? null : Health.fromJson(json["health"]),
    upcomingMeetings: json["upcoming_meetings"] == null ? null : UpcomingMeetings.fromJson(json["upcoming_meetings"]),
    localAd: json["local_ad"] == null ? null : LocalAd.fromJson(json["local_ad"]),
    recentlySolved: json["recently_solved"] == null ? null : Wins.fromJson(json["recently_solved"]),
    civicJourney: json["civic_journey"] == null ? null : CivicJourney.fromJson(json["civic_journey"]),
    sponsorship: json["sponsorship"] == null ? null : Sponsorship.fromJson(json["sponsorship"]),
  );
}

class CivicJourney {
  final String? title;
  final List<CivicJourneyStat>? stats;
  final Highlight? highlight;

  CivicJourney({
    this.title,
    this.stats,
    this.highlight,
  });

  factory CivicJourney.fromJson(Map<String, dynamic> json) => CivicJourney(
    title: json["title"],
    stats: json["stats"] == null ? [] : List<CivicJourneyStat>.from(json["stats"]!.map((x) => CivicJourneyStat.fromJson(x))),
    highlight: json["highlight"] == null ? null : Highlight.fromJson(json["highlight"]),
  );
}

class Highlight {
  final int? value;
  final String? title;
  final String? description;

  Highlight({
    this.value,
    this.title,
    this.description,
  });

  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
    value: json["value"],
    title: json["title"],
    description: json["description"],
  );
}

class CivicJourneyStat {
  final int? id;
  final String? label;
  final int? value;

  CivicJourneyStat({
    this.id,
    this.label,
    this.value,
  });

  factory CivicJourneyStat.fromJson(Map<String, dynamic> json) => CivicJourneyStat(
    id: json["id"],
    label: json["label"],
    value: json["value"],
  );
}

class Health {
  final String? title;
  final List<HealthItem>? items;

  Health({
    this.title,
    this.items,
  });

  factory Health.fromJson(Map<String, dynamic> json) => Health(
    title: json["title"],
    items: json["items"] == null ? [] : List<HealthItem>.from(json["items"]!.map((x) => HealthItem.fromJson(x))),
  );
}

class HealthItem {
  final int? id;
  final String? grade;
  final String? gradeClass;
  final String? title;
  final String? description;

  HealthItem({
    this.id,
    this.grade,
    this.gradeClass,
    this.title,
    this.description,
  });

  factory HealthItem.fromJson(Map<String, dynamic> json) => HealthItem(
    id: json["id"],
    grade: json["grade"],
    gradeClass: json["grade_class"],
    title: json["title"],
    description: json["description"],
  );
}

class LocalAd {
  final String? title;
  final Sponsor? sponsor;

  LocalAd({
    this.title,
    this.sponsor,
  });

  factory LocalAd.fromJson(Map<String, dynamic> json) => LocalAd(
    title: json["title"],
    sponsor: json["sponsor"] == null ? null : Sponsor.fromJson(json["sponsor"]),
  );
}

class Sponsorship {
  final String? title;
  final String? description;

  Sponsorship({
    this.title,
    this.description,
  });

  factory Sponsorship.fromJson(Map<String, dynamic> json) => Sponsorship(
    title: json["title"],
    description: json["description"],
  );
}

class UpcomingMeetings {
  final String? title;
  final Link? link;
  final List<UpcomingMeetingsItem>? items;

  UpcomingMeetings({
    this.title,
    this.link,
    this.items,
  });

  factory UpcomingMeetings.fromJson(Map<String, dynamic> json) => UpcomingMeetings(
    title: json["title"],
    link: json["link"] == null ? null : Link.fromJson(json["link"]),
    items: json["items"] == null ? [] : List<UpcomingMeetingsItem>.from(json["items"]!.map((x) => UpcomingMeetingsItem.fromJson(x))),
  );
}

class UpcomingMeetingsItem {
  final int? id;
  final DateTime? date;
  final String? month;
  final int? day;
  final String? title;
  final String? details;

  UpcomingMeetingsItem({
    this.id,
    this.date,
    this.month,
    this.day,
    this.title,
    this.details,
  });

  factory UpcomingMeetingsItem.fromJson(Map<String, dynamic> json) => UpcomingMeetingsItem(
    id: json["id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    month: json["month"],
    day: json["day"],
    title: json["title"],
    details: json["details"],
  );
}

class Hero {
  final Background? background;
  final String? greeting;
  final String? title;
  final String? summary;
  final Status? status;
  final AiBrief? aiBrief;
  final List<HeroStat>? stats;
  final List<QuickLink>? quickLinks;

  Hero({
    this.background,
    this.greeting,
    this.title,
    this.summary,
    this.status,
    this.aiBrief,
    this.stats,
    this.quickLinks,
  });

  factory Hero.fromJson(Map<String, dynamic> json) => Hero(
    background: json["background"] == null ? null : Background.fromJson(json["background"]),
    greeting: json["greeting"],
    title: json["title"],
    summary: json["summary"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    aiBrief: json["ai_brief"] == null ? null : AiBrief.fromJson(json["ai_brief"]),
    stats: json["stats"] == null ? [] : List<HeroStat>.from(json["stats"]!.map((x) => HeroStat.fromJson(x))),
    quickLinks: json["quick_links"] == null ? [] : List<QuickLink>.from(json["quick_links"]!.map((x) => QuickLink.fromJson(x))),
  );
}

class AiBrief {
  final String? title;
  final Guide? guide;
  final String? greeting;
  final String? subtitle;
  final String? highlight;
  final String? description;
  final QuickLink? button;

  AiBrief({
    this.title,
    this.guide,
    this.greeting,
    this.subtitle,
    this.highlight,
    this.description,
    this.button,
  });

  factory AiBrief.fromJson(Map<String, dynamic> json) => AiBrief(
    title: json["title"],
    guide: json["guide"] == null ? null : Guide.fromJson(json["guide"]),
    greeting: json["greeting"],
    subtitle: json["subtitle"],
    highlight: json["highlight"],
    description: json["description"],
    button: json["button"] == null ? null : QuickLink.fromJson(json["button"]),
  );
}

class QuickLink {
  final String? text;
  final String? href;

  QuickLink({
    this.text,
    this.href,
  });

  factory QuickLink.fromJson(Map<String, dynamic> json) => QuickLink(
    text: json["text"],
    href: json["href"],
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

class HeroStat {
  final String? icon;
  final int? value;
  final String? label;

  HeroStat({
    this.icon,
    this.value,
    this.label,
  });

  factory HeroStat.fromJson(Map<String, dynamic> json) => HeroStat(
    icon: json["icon"],
    value: json["value"],
    label: json["label"],
  );
}

class Status {
  final String? label;
  final String? message;

  Status({
    this.label,
    this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    label: json["label"],
    message: json["message"],
  );
}

class LiveActivity {
  final String? title;
  final List<Filter>? filters;
  final List<LiveActivityItem>? items;

  LiveActivity({
    this.title,
    this.filters,
    this.items,
  });

  factory LiveActivity.fromJson(Map<String, dynamic> json) => LiveActivity(
    title: json["title"],
    filters: json["filters"] == null ? [] : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
    items: json["items"] == null ? [] : List<LiveActivityItem>.from(json["items"]!.map((x) => LiveActivityItem.fromJson(x))),
  );
}

class Filter {
  final String? key;
  final String? label;
  final bool? active;

  Filter({
    this.key,
    this.label,
    this.active,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    key: json["key"],
    label: json["label"],
    active: json["active"],
  );
}

class LiveActivityItem {
  final int? id;
  final String? kind;
  final Avatar? avatar;
  final String? meta;
  final String? name;
  final String? description;
  final Link? link;

  LiveActivityItem({
    this.id,
    this.kind,
    this.avatar,
    this.meta,
    this.name,
    this.description,
    this.link,
  });

  factory LiveActivityItem.fromJson(Map<String, dynamic> json) => LiveActivityItem(
    id: json["id"],
    kind: json["kind"],
    avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
    meta: json["meta"],
    name: json["name"],
    description: json["description"],
    link: json["link"] == null ? null : Link.fromJson(json["link"]),
  );
}

class Avatar {
  final String? type;
  final String? value;
  final String? variant;

  Avatar({
    this.type,
    this.value,
    this.variant,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
    type: json["type"],
    value: json["value"],
    variant: json["variant"],
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

class Priority {
  final int? id;
  final int? rank;
  final String? title;
  final String? tone;
  final String? stage;
  final int? momentum;
  final List<String>? residents;
  final List<Fact>? facts;
  final QuickLink? button;

  Priority({
    this.id,
    this.rank,
    this.title,
    this.tone,
    this.stage,
    this.momentum,
    this.residents,
    this.facts,
    this.button,
  });

  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
    id: json["id"],
    rank: json["rank"],
    title: json["title"],
    tone: json["tone"],
    stage: json["stage"],
    momentum: json["momentum"],
    residents: json["residents"] == null ? [] : List<String>.from(json["residents"]!.map((x) => x)),
    facts: json["facts"] == null ? [] : List<Fact>.from(json["facts"]!.map((x) => Fact.fromJson(x))),
    button: json["button"] == null ? null : QuickLink.fromJson(json["button"]),
  );
}

class Representatives {
  final String? title;
  final List<RepresentativesItem>? items;

  Representatives({
    this.title,
    this.items,
  });

  factory Representatives.fromJson(Map<String, dynamic> json) => Representatives(
    title: json["title"],
    items: json["items"] == null ? [] : List<RepresentativesItem>.from(json["items"]!.map((x) => RepresentativesItem.fromJson(x))),
  );
}

class RepresentativesItem {
  final int? id;
  final String? initials;
  final String? variant;
  final String? name;
  final String? role;
  final String? status;
  final double? rating;

  RepresentativesItem({
    this.id,
    this.initials,
    this.variant,
    this.name,
    this.role,
    this.status,
    this.rating,
  });

  factory RepresentativesItem.fromJson(Map<String, dynamic> json) => RepresentativesItem(
    id: json["id"],
    initials: json["initials"],
    variant: json["variant"],
    name: json["name"],
    role: json["role"],
    status: json["status"],
    rating: json["rating"]?.toDouble(),
  );

}

class TownHall {
  final String? title;
  final Meeting? meeting;
  final Readiness? readiness;
  final List<Agenda>? agenda;
  final Rsvp? rsvp;

  TownHall({
    this.title,
    this.meeting,
    this.readiness,
    this.agenda,
    this.rsvp,
  });

  factory TownHall.fromJson(Map<String, dynamic> json) => TownHall(
    title: json["title"],
    meeting: json["meeting"] == null ? null : Meeting.fromJson(json["meeting"]),
    readiness: json["readiness"] == null ? null : Readiness.fromJson(json["readiness"]),
    agenda: json["agenda"] == null ? [] : List<Agenda>.from(json["agenda"]!.map((x) => Agenda.fromJson(x))),
    rsvp: json["rsvp"] == null ? null : Rsvp.fromJson(json["rsvp"]),
  );
}

class Agenda {
  final int? id;
  final String? title;
  final String? duration;

  Agenda({
    this.id,
    this.title,
    this.duration,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
    id: json["id"],
    title: json["title"],
    duration: json["duration"],
  );
}

class Meeting {
  final String? day;
  final String? date;
  final String? time;
  final String? location;

  Meeting({
    this.day,
    this.date,
    this.time,
    this.location,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
    day: json["day"],
    date: json["date"],
    time: json["time"],
    location: json["location"],
  );
}

class Readiness {
  final AgendaReviewed? topicsPrepared;
  final AgendaReviewed? residentsConfirmed;
  final AgendaReviewed? representativesInvited;
  final AgendaReviewed? agendaReviewed;
  final Overall? overall;

  Readiness({
    this.topicsPrepared,
    this.residentsConfirmed,
    this.representativesInvited,
    this.agendaReviewed,
    this.overall,
  });

  factory Readiness.fromJson(Map<String, dynamic> json) => Readiness(
    topicsPrepared: json["topics_prepared"] == null ? null : AgendaReviewed.fromJson(json["topics_prepared"]),
    residentsConfirmed: json["residents_confirmed"] == null ? null : AgendaReviewed.fromJson(json["residents_confirmed"]),
    representativesInvited: json["representatives_invited"] == null ? null : AgendaReviewed.fromJson(json["representatives_invited"]),
    agendaReviewed: json["agenda_reviewed"] == null ? null : AgendaReviewed.fromJson(json["agenda_reviewed"]),
    overall: json["overall"] == null ? null : Overall.fromJson(json["overall"]),
  );
}

class AgendaReviewed {
  final String? label;
  final int? value;
  final String? display;

  AgendaReviewed({
    this.label,
    this.value,
    this.display,
  });

  factory AgendaReviewed.fromJson(Map<String, dynamic> json) => AgendaReviewed(
    label: json["label"],
    value: json["value"],
    display: json["display"],
  );
}

class Overall {
  final int? value;
  final String? label;

  Overall({
    this.value,
    this.label,
  });

  factory Overall.fromJson(Map<String, dynamic> json) => Overall(
    value: json["value"],
    label: json["label"],
  );
}

class Rsvp {
  final String? icon;
  final int? interestedCount;
  final String? buttonText;

  Rsvp({
    this.icon,
    this.interestedCount,
    this.buttonText,
  });

  factory Rsvp.fromJson(Map<String, dynamic> json) => Rsvp(
    icon: json["icon"],
    interestedCount: json["interested_count"],
    buttonText: json["button_text"],
  );
}
