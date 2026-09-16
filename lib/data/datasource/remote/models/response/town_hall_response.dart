import 'dart:convert';

TownHallResponse townHallResponseFromJson(String str) => TownHallResponse.fromJson(json.decode(str));

class TownHallResponse {
  final bool? success;
  final String? message;
  final TownHallData? data;

  TownHallResponse({
    this.success,
    this.message,
    this.data,
  });

  factory TownHallResponse.fromJson(Map<String, dynamic> json) => TownHallResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : TownHallData.fromJson(json["data"]),
  );
}

class TownHallData {
  final Location? location;
  final Hero? hero;
  final AiBrief? aiBrief;
  final TownHallBills? bills;
  final NextMeeting? nextMeeting;
  final CommunityOverview? communityOverview;

  TownHallData({
    this.location,
    this.hero,
    this.aiBrief,
    this.bills,
    this.nextMeeting,
    this.communityOverview,
  });

  factory TownHallData.fromJson(Map<String, dynamic> json) => TownHallData(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    hero: json["hero"] == null ? null : Hero.fromJson(json["hero"]),
    aiBrief: json["ai_brief"] == null ? null : AiBrief.fromJson(json["ai_brief"]),
    bills: json["bills"] == null ? null : TownHallBills.fromJson(json["bills"]),
    nextMeeting: json["next_meeting"] == null ? null : NextMeeting.fromJson(json["next_meeting"]),
    communityOverview: json["community_overview"] == null ? null : CommunityOverview.fromJson(json["community_overview"]),
  );
}

class AiBrief {
  final AiBriefKicker? kicker;
  final String? title;
  final String? lede;
  final List<TownHallColumn>? columns;
  final WhyItMatters? whyItMatters;
  final AiBriefActions? actions;
  final AiBriefFooter? footer;

  AiBrief({
    this.kicker,
    this.title,
    this.lede,
    this.columns,
    this.whyItMatters,
    this.actions,
    this.footer,
  });

  factory AiBrief.fromJson(Map<String, dynamic> json) => AiBrief(
    kicker: json["kicker"] == null ? null : AiBriefKicker.fromJson(json["kicker"]),
    title: json["title"],
    lede: json["lede"],
    columns: json["columns"] == null ? [] : List<TownHallColumn>.from(json["columns"]!.map((x) => TownHallColumn.fromJson(x))),
    whyItMatters: json["why_it_matters"] == null ? null : WhyItMatters.fromJson(json["why_it_matters"]),
    actions: json["actions"] == null ? null : AiBriefActions.fromJson(json["actions"]),
    footer: json["footer"] == null ? null : AiBriefFooter.fromJson(json["footer"]),
  );
}

class AiBriefActions {
  final String? title;
  final List<ViewAll>? items;

  AiBriefActions({
    this.title,
    this.items,
  });

  factory AiBriefActions.fromJson(Map<String, dynamic> json) => AiBriefActions(
    title: json["title"],
    items: json["items"] == null ? [] : List<ViewAll>.from(json["items"]!.map((x) => ViewAll.fromJson(x))),
  );
}

class ViewAll {
  final String? text;
  final String? href;

  ViewAll({
    this.text,
    this.href,
  });

  factory ViewAll.fromJson(Map<String, dynamic> json) => ViewAll(
    text: json["text"],
    href: json["href"],
  );
}

class TownHallColumn {
  final String? icon;
  final int? value;
  final String? title;
  final String? tone;
  final String? text;
  final ViewAll? link;
  final ColumnDelta? delta;
  final bool? inline;

  TownHallColumn({
    this.icon,
    this.value,
    this.title,
    this.tone,
    this.text,
    this.link,
    this.delta,
    this.inline,
  });

  factory TownHallColumn.fromJson(Map<String, dynamic> json) => TownHallColumn(
    icon: json["icon"],
    value: json["value"],
    title: json["title"],
    tone: json["tone"],
    text: json["text"],
    link: json["link"] == null ? null : ViewAll.fromJson(json["link"]),
    delta: json["delta"] == null ? null : ColumnDelta.fromJson(json["delta"]),
    inline: json["inline"],
  );
}

class ColumnDelta {
  final String? text;
  final String? tone;

  ColumnDelta({
    this.text,
    this.tone,
  });

  factory ColumnDelta.fromJson(Map<String, dynamic> json) => ColumnDelta(
    text: json["text"],
    tone: json["tone"],
  );
}


class AiBriefFooter {
  final ViewAll? readFull;
  final ViewAll? share;
  final Compare? compare;

  AiBriefFooter({
    this.readFull,
    this.share,
    this.compare,
  });

  factory AiBriefFooter.fromJson(Map<String, dynamic> json) => AiBriefFooter(
    readFull: json["read_full"] == null ? null : ViewAll.fromJson(json["read_full"]),
    share: json["share"] == null ? null : ViewAll.fromJson(json["share"]),
    compare: json["compare"] == null ? null : Compare.fromJson(json["compare"]),
  );
}

class Compare {
  final String? text;
  final String? href;
  final String? icon;

  Compare({
    this.text,
    this.href,
    this.icon,
  });

  factory Compare.fromJson(Map<String, dynamic> json) => Compare(
    text: json["text"],
    href: json["href"],
    icon: json["icon"],
  );
}

class AiBriefKicker {
  final String? icon;
  final String? text;
  final String? badge;

  AiBriefKicker({
    this.icon,
    this.text,
    this.badge,
  });

  factory AiBriefKicker.fromJson(Map<String, dynamic> json) => AiBriefKicker(
    icon: json["icon"],
    text: json["text"],
    badge: json["badge"],
  );
}

class WhyItMatters {
  final String? title;
  final String? text;

  WhyItMatters({
    this.title,
    this.text,
  });

  factory WhyItMatters.fromJson(Map<String, dynamic> json) => WhyItMatters(
    title: json["title"],
    text: json["text"],
  );
}

class TownHallBills {
  final String? title;
  final List<BillsFilter>? filters;
  final ViewAll? viewAll;
  final List<PriorityLegend>? priorityLegend;
  final Featured? featured;
  final List<BillsItem>? items;
  final Pagination? pagination;

  TownHallBills({
    this.title,
    this.filters,
    this.viewAll,
    this.priorityLegend,
    this.featured,
    this.items,
    this.pagination,
  });

  factory TownHallBills.fromJson(Map<String, dynamic> json) => TownHallBills(
    title: json["title"],
    filters: json["filters"] == null ? [] : List<BillsFilter>.from(json["filters"]!.map((x) => BillsFilter.fromJson(x))),
    viewAll: json["view_all"] == null ? null : ViewAll.fromJson(json["view_all"]),
    priorityLegend: json["priority_legend"] == null ? [] : List<PriorityLegend>.from(json["priority_legend"]!.map((x) => PriorityLegend.fromJson(x))),
    featured: json["featured"] == null ? null : Featured.fromJson(json["featured"]),
    items: json["items"] == null ? [] : List<BillsItem>.from(json["items"]!.map((x) => BillsItem.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class Featured {
  final String? description;
  final FeaturedImpact? impact;
  final String? responses;
  final int? following;
  final List<Agenda>? actions;

  Featured({
    this.description,
    this.impact,
    this.responses,
    this.following,
    this.actions,
  });

  factory Featured.fromJson(Map<String, dynamic> json) => Featured(
    description: json["description"],
    impact: json["impact"] == null ? null : FeaturedImpact.fromJson(json["impact"]),
    responses: json["responses"],
    following: json["following"],
    actions: json["actions"] == null ? [] : List<Agenda>.from(json["actions"]!.map((x) => Agenda.fromJson(x))),
  );
}

class Agenda {
  final String? text;
  final String? href;
  final String? variant;

  Agenda({
    this.text,
    this.href,
    this.variant,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
    text: json["text"],
    href: json["href"],
    variant: json["variant"],
  );
}

class FeaturedImpact {
  final String? value;
  final String? tone;

  FeaturedImpact({
    this.value,
    this.tone,
  });

  factory FeaturedImpact.fromJson(Map<String, dynamic> json) => FeaturedImpact(
    value: json["value"],
    tone: json["tone"],
  );
}

class BillsFilter {
  final String? label;
  final String? value;
  final String? filterClass;

  BillsFilter({
    this.label,
    this.value,
    this.filterClass,
  });

  factory BillsFilter.fromJson(Map<String, dynamic> json) => BillsFilter(
    label: json["label"],
    value: json["value"],
    filterClass: json["class"],
  );
}

class BillsItem {
  final String? title;
  final String? id;
  final List<Status>? ribbons;
  final Status? tag;
  final Status? status;
  final String? age;
  final String? description;
  final OverallClass? impact;
  final String? responses;
  final int? following;
  final List<Agenda>? actions;

  BillsItem({
    this.title,
    this.id,
    this.ribbons,
    this.tag,
    this.status,
    this.age,
    this.description,
    this.impact,
    this.responses,
    this.following,
    this.actions,
  });

  factory BillsItem.fromJson(Map<String, dynamic> json) => BillsItem(
    title: json["title"],
    id: json["id"],
    ribbons: json["ribbons"] == null ? [] : List<Status>.from(json["ribbons"]!.map((x) => Status.fromJson(x))),
    tag: json["tag"] == null ? null : Status.fromJson(json["tag"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    age: json["age"],
    description: json["description"],
    impact: json["impact"] == null ? null : OverallClass.fromJson(json["impact"]),
    responses: json["responses"],
    following: json["following"],
    actions: json["actions"] == null ? [] : List<Agenda>.from(json["actions"]!.map((x) => Agenda.fromJson(x))),
  );
}

class OverallClass {
  final String? label;
  final String? value;
  final String? tone;
  final String? icon;

  OverallClass({
    this.label,
    this.value,
    this.tone,
    this.icon,
  });

  factory OverallClass.fromJson(Map<String, dynamic> json) => OverallClass(
    label: json["label"],
    value: json["value"],
    tone: json["tone"],
    icon: json["icon"],
  );
}

class Status {
  final String? label;
  final String? statusClass;

  Status({
    this.label,
    this.statusClass,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    label: json["label"],
    statusClass: json["class"],
  );
}

class Pagination {
  final int? currentPage;
  final int? perPage;
  final int? total;

  Pagination({
    this.currentPage,
    this.perPage,
    this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    perPage: json["per_page"],
    total: json["total"],
  );
}

class PriorityLegend {
  final String? label;
  final String? timing;
  final String? dotClass;

  PriorityLegend({
    this.label,
    this.timing,
    this.dotClass,
  });

  factory PriorityLegend.fromJson(Map<String, dynamic> json) => PriorityLegend(
    label: json["label"],
    timing: json["timing"],
    dotClass: json["dot_class"],
  );
}

class CommunityOverview {
  final Priorities? priorities;
  final Representatives? representatives;
  final Engagement? engagement;
  final Stats? stats;

  CommunityOverview({
    this.priorities,
    this.representatives,
    this.engagement,
    this.stats,
  });

  factory CommunityOverview.fromJson(Map<String, dynamic> json) => CommunityOverview(
    priorities: json["priorities"] == null ? null : Priorities.fromJson(json["priorities"]),
    representatives: json["representatives"] == null ? null : Representatives.fromJson(json["representatives"]),
    engagement: json["engagement"] == null ? null : Engagement.fromJson(json["engagement"]),
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
  );
}

class Engagement {
  final String? title;
  final Compare? viewAll;
  final List<EngagementItem>? items;

  Engagement({
    this.title,
    this.viewAll,
    this.items,
  });

  factory Engagement.fromJson(Map<String, dynamic> json) => Engagement(
    title: json["title"],
    viewAll: json["view_all"] == null ? null : Compare.fromJson(json["view_all"]),
    items: json["items"] == null ? [] : List<EngagementItem>.from(json["items"]!.map((x) => EngagementItem.fromJson(x))),
  );
}

class EngagementItem {
  final int? id;
  final String? name;
  final List<Part>? parts;
  final String? time;
  final Background? image;
  final String? icon;
  final String? iconClass;

  EngagementItem({
    this.id,
    this.name,
    this.parts,
    this.time,
    this.image,
    this.icon,
    this.iconClass,
  });

  factory EngagementItem.fromJson(Map<String, dynamic> json) => EngagementItem(
    id: json["id"],
    name: json["name"],
    parts: json["parts"] == null ? [] : List<Part>.from(json["parts"]!.map((x) => Part.fromJson(x))),
    time: json["time"],
    image: json["image"] == null ? null : Background.fromJson(json["image"]),
    icon: json["icon"],
    iconClass: json["icon_class"],
  );
}

class Background {
  final String? src;
  final int? width;
  final int? height;
  final String? alt;

  Background({
    this.src,
    this.width,
    this.height,
    this.alt,
  });

  factory Background.fromJson(Map<String, dynamic> json) => Background(
    src: json["src"],
    width: json["width"],
    height: json["height"],
    alt: json["alt"],
  );
}

class Part {
  final String? text;
  final bool? bold;

  Part({
    this.text,
    this.bold,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
    text: json["text"],
    bold: json["bold"],
  );
}

class Priorities {
  final String? title;
  final ViewAll? viewAll;
  final List<PrioritiesItem>? items;
  final Participants? participants;

  Priorities({
    this.title,
    this.viewAll,
    this.items,
    this.participants,
  });

  factory Priorities.fromJson(Map<String, dynamic> json) => Priorities(
    title: json["title"],
    viewAll: json["view_all"] == null ? null : ViewAll.fromJson(json["view_all"]),
    items: json["items"] == null ? [] : List<PrioritiesItem>.from(json["items"]!.map((x) => PrioritiesItem.fromJson(x))),
    participants: json["participants"] == null ? null : Participants.fromJson(json["participants"]),
  );
}

class PrioritiesItem {
  final int? rank;
  final String? name;
  final int? percentage;
  final String? rankClass;
  final String? meterClass;

  PrioritiesItem({
    this.rank,
    this.name,
    this.percentage,
    this.rankClass,
    this.meterClass,
  });

  factory PrioritiesItem.fromJson(Map<String, dynamic> json) => PrioritiesItem(
    rank: json["rank"],
    name: json["name"],
    percentage: json["percentage"],
    rankClass: json["rank_class"],
    meterClass: json["meter_class"],
  );
}

class Participants {
  final int? count;
  final String? label;

  Participants({
    this.count,
    this.label,
  });

  factory Participants.fromJson(Map<String, dynamic> json) => Participants(
    count: json["count"],
    label: json["label"],
  );
}

class Representatives {
  final String? title;
  final Compare? rankingsLink;
  final List<RepresentativesFilter>? filters;
  final Table? table;
  final List<Representative>? representatives;
  final Compare? footer;

  Representatives({
    this.title,
    this.rankingsLink,
    this.filters,
    this.table,
    this.representatives,
    this.footer,
  });

  factory Representatives.fromJson(Map<String, dynamic> json) => Representatives(
    title: json["title"],
    rankingsLink: json["rankings_link"] == null ? null : Compare.fromJson(json["rankings_link"]),
    filters: json["filters"] == null ? [] : List<RepresentativesFilter>.from(json["filters"]!.map((x) => RepresentativesFilter.fromJson(x))),
    table: json["table"] == null ? null : Table.fromJson(json["table"]),
    representatives: json["representatives"] == null ? [] : List<Representative>.from(json["representatives"]!.map((x) => Representative.fromJson(x))),
    footer: json["footer"] == null ? null : Compare.fromJson(json["footer"]),
  );
}

class RepresentativesFilter {
  final String? label;
  final String? value;
  final bool? active;

  RepresentativesFilter({
    this.label,
    this.value,
    this.active,
  });

  factory RepresentativesFilter.fromJson(Map<String, dynamic> json) => RepresentativesFilter(
    label: json["label"],
    value: json["value"],
    active: json["active"],
  );
}

class Representative {
  final int? rank;
  final String? name;
  final String? role;
  final Background? image;
  final String? level;
  final String? levelClass;
  final int? score;
  final String? scoreClass;
  final String? confidence;
  final String? confidenceClass;
  final String? medalClass;

  Representative({
    this.rank,
    this.name,
    this.role,
    this.image,
    this.level,
    this.levelClass,
    this.score,
    this.scoreClass,
    this.confidence,
    this.confidenceClass,
    this.medalClass,
  });

  factory Representative.fromJson(Map<String, dynamic> json) => Representative(
    rank: json["rank"],
    name: json["name"],
    role: json["role"],
    image: json["image"] == null ? null : Background.fromJson(json["image"]),
    level: json["level"],
    levelClass: json["level_class"],
    score: json["score"],
    scoreClass: json["score_class"],
    confidence: json["confidence"],
    confidenceClass: json["confidence_class"],
    medalClass: json["medal_class"],
  );
}

class Table {
  final String? rank;
  final String? representative;
  final String? level;
  final String? score;
  final String? scoreSuffix;
  final String? confidence;

  Table({
    this.rank,
    this.representative,
    this.level,
    this.score,
    this.scoreSuffix,
    this.confidence,
  });

  factory Table.fromJson(Map<String, dynamic> json) => Table(
    rank: json["rank"],
    representative: json["representative"],
    level: json["level"],
    score: json["score"],
    scoreSuffix: json["score_suffix"],
    confidence: json["confidence"],
  );
}

class Stats {
  final Projects? projects;
  final Transparency? transparency;
  final StatsSentiment? sentiment;
  final Poll? poll;

  Stats({
    this.projects,
    this.transparency,
    this.sentiment,
    this.poll,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    projects: json["projects"] == null ? null : Projects.fromJson(json["projects"]),
    transparency: json["transparency"] == null ? null : Transparency.fromJson(json["transparency"]),
    sentiment: json["sentiment"] == null ? null : StatsSentiment.fromJson(json["sentiment"]),
    poll: json["poll"] == null ? null : Poll.fromJson(json["poll"]),
  );
}

class Poll {
  final String? title;
  final Compare? viewAll;
  final String? question;
  final List<Option>? options;
  final PollFooter? footer;

  Poll({
    this.title,
    this.viewAll,
    this.question,
    this.options,
    this.footer,
  });

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
    title: json["title"],
    viewAll: json["view_all"] == null ? null : Compare.fromJson(json["view_all"]),
    question: json["question"],
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    footer: json["footer"] == null ? null : PollFooter.fromJson(json["footer"]),
  );
}

class PollFooter {
  final int? votesCast;
  final ViewAll? voteAction;

  PollFooter({
    this.votesCast,
    this.voteAction,
  });

  factory PollFooter.fromJson(Map<String, dynamic> json) => PollFooter(
    votesCast: json["votes_cast"],
    voteAction: json["vote_action"] == null ? null : ViewAll.fromJson(json["vote_action"]),
  );
}

class Option {
  final String? name;
  final int? percentage;

  Option({
    this.name,
    this.percentage,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    name: json["name"],
    percentage: json["percentage"],
  );
}

class Projects {
  final String? title;
  final Compare? viewAll;
  final Totals? totals;
  final List<Option>? projects;

  Projects({
    this.title,
    this.viewAll,
    this.totals,
    this.projects,
  });

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
    title: json["title"],
    viewAll: json["view_all"] == null ? null : Compare.fromJson(json["view_all"]),
    totals: json["totals"] == null ? null : Totals.fromJson(json["totals"]),
    projects: json["projects"] == null ? [] : List<Option>.from(json["projects"]!.map((x) => Option.fromJson(x))),
  );
}

class Totals {
  final int? activeProjects;
  final int? totalParticipants;
  final TotalsDelta? delta;

  Totals({
    this.activeProjects,
    this.totalParticipants,
    this.delta,
  });

  factory Totals.fromJson(Map<String, dynamic> json) => Totals(
    activeProjects: json["active_projects"],
    totalParticipants: json["total_participants"],
    delta: json["delta"] == null ? null : TotalsDelta.fromJson(json["delta"]),
  );
}

class TotalsDelta {
  final int? value;
  final String? text;
  final String? tone;

  TotalsDelta({
    this.value,
    this.text,
    this.tone,
  });

  factory TotalsDelta.fromJson(Map<String, dynamic> json) => TotalsDelta(
    value: json["value"],
    text: json["text"],
    tone: json["tone"],
  );
}

class StatsSentiment {
  final String? title;
  final List<SentimentElement>? sentiments;
  final OverallClass? overall;

  StatsSentiment({
    this.title,
    this.sentiments,
    this.overall,
  });

  factory StatsSentiment.fromJson(Map<String, dynamic> json) => StatsSentiment(
    title: json["title"],
    sentiments: json["sentiments"] == null ? [] : List<SentimentElement>.from(json["sentiments"]!.map((x) => SentimentElement.fromJson(x))),
    overall: json["overall"] == null ? null : OverallClass.fromJson(json["overall"]),
  );
}

class SentimentElement {
  final String? label;
  final int? percentage;
  final String? swatchClass;

  SentimentElement({
    this.label,
    this.percentage,
    this.swatchClass,
  });

  factory SentimentElement.fromJson(Map<String, dynamic> json) => SentimentElement(
    label: json["label"],
    percentage: json["percentage"],
    swatchClass: json["swatch_class"],
  );
}

class Transparency {
  final String? title;
  final Compare? viewDashboard;
  final List<Option>? metrics;
  final Overall? overall;

  Transparency({
    this.title,
    this.viewDashboard,
    this.metrics,
    this.overall,
  });

  factory Transparency.fromJson(Map<String, dynamic> json) => Transparency(
    title: json["title"],
    viewDashboard: json["view_dashboard"] == null ? null : Compare.fromJson(json["view_dashboard"]),
    metrics: json["metrics"] == null ? [] : List<Option>.from(json["metrics"]!.map((x) => Option.fromJson(x))),
    overall: json["overall"] == null ? null : Overall.fromJson(json["overall"]),
  );
}

class Overall {
  final String? icon;
  final String? label;
  final String? status;
  final String? statusTone;
  final int? percentage;

  Overall({
    this.icon,
    this.label,
    this.status,
    this.statusTone,
    this.percentage,
  });

  factory Overall.fromJson(Map<String, dynamic> json) => Overall(
    icon: json["icon"],
    label: json["label"],
    status: json["status"],
    statusTone: json["status_tone"],
    percentage: json["percentage"],
  );
}

class Hero {
  final Background? background;
  final String? title;
  final bool? verified;
  final String? subtitle;
  final String? description;
  final List<Action>? actions;
  final HeroImpact? impact;

  Hero({
    this.background,
    this.title,
    this.verified,
    this.subtitle,
    this.description,
    this.actions,
    this.impact,
  });

  factory Hero.fromJson(Map<String, dynamic> json) => Hero(
    background: json["background"] == null ? null : Background.fromJson(json["background"]),
    title: json["title"],
    verified: json["verified"],
    subtitle: json["subtitle"],
    description: json["description"],
    actions: json["actions"] == null ? [] : List<Action>.from(json["actions"]!.map((x) => Action.fromJson(x))),
    impact: json["impact"] == null ? null : HeroImpact.fromJson(json["impact"]),
  );
}

class Action {
  final String? icon;
  final String? title;
  final String? subtitle;
  final String? href;
  final String? variant;

  Action({
    this.icon,
    this.title,
    this.subtitle,
    this.href,
    this.variant,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
    icon: json["icon"],
    title: json["title"],
    subtitle: json["subtitle"],
    href: json["href"],
    variant: json["variant"],
  );
}

class HeroImpact {
  final String? title;
  final String? updatedAt;
  final List<Bottom>? top;
  final List<Bottom>? bottom;

  HeroImpact({
    this.title,
    this.updatedAt,
    this.top,
    this.bottom,
  });

  factory HeroImpact.fromJson(Map<String, dynamic> json) => HeroImpact(
    title: json["title"],
    updatedAt: json["updated_at"],
    top: json["top"] == null ? [] : List<Bottom>.from(json["top"]!.map((x) => Bottom.fromJson(x))),
    bottom: json["bottom"] == null ? [] : List<Bottom>.from(json["bottom"]!.map((x) => Bottom.fromJson(x))),
  );
}

class Bottom {
  final int? value;
  final String? icon;
  final String? label;
  final String? note;
  final String? tone;
  final String? suffix;

  Bottom({
    this.value,
    this.icon,
    this.label,
    this.note,
    this.tone,
    this.suffix,
  });

  factory Bottom.fromJson(Map<String, dynamic> json) => Bottom(
    value: json["value"],
    icon: json["icon"],
    label: json["label"],
    note: json["note"],
    tone: json["tone"],
    suffix: json["suffix"],
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

class NextMeeting {
  final NextMeetingKicker? kicker;
  final Date? date;
  final String? title;
  final List<Meta>? meta;
  final String? description;
  final NextMeetingActions? actions;
  final Committed? committed;
  final Glance? glance;
  final Qualification? qualification;

  NextMeeting({
    this.kicker,
    this.date,
    this.title,
    this.meta,
    this.description,
    this.actions,
    this.committed,
    this.glance,
    this.qualification,
  });

  factory NextMeeting.fromJson(Map<String, dynamic> json) => NextMeeting(
    kicker: json["kicker"] == null ? null : NextMeetingKicker.fromJson(json["kicker"]),
    date: json["date"] == null ? null : Date.fromJson(json["date"]),
    title: json["title"],
    meta: json["meta"] == null ? [] : List<Meta>.from(json["meta"]!.map((x) => Meta.fromJson(x))),
    description: json["description"],
    actions: json["actions"] == null ? null : NextMeetingActions.fromJson(json["actions"]),
    committed: json["committed"] == null ? null : Committed.fromJson(json["committed"]),
    glance: json["glance"] == null ? null : Glance.fromJson(json["glance"]),
    qualification: json["qualification"] == null ? null : Qualification.fromJson(json["qualification"]),
  );
}

class NextMeetingActions {
  final Agenda? agenda;
  final Agenda? attend;

  NextMeetingActions({
    this.agenda,
    this.attend,
  });

  factory NextMeetingActions.fromJson(Map<String, dynamic> json) => NextMeetingActions(
    agenda: json["agenda"] == null ? null : Agenda.fromJson(json["agenda"]),
    attend: json["attend"] == null ? null : Agenda.fromJson(json["attend"]),
  );
}

class Committed {
  final String? icon;
  final int? count;
  final String? label;

  Committed({
    this.icon,
    this.count,
    this.label,
  });

  factory Committed.fromJson(Map<String, dynamic> json) => Committed(
    icon: json["icon"],
    count: json["count"],
    label: json["label"],
  );
}

class Date {
  final String? day;
  final String? month;
  final int? number;

  Date({
    this.day,
    this.month,
    this.number,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    day: json["day"],
    month: json["month"],
    number: json["number"],
  );
}

class Glance {
  final String? title;
  final List<Meta>? items;

  Glance({
    this.title,
    this.items,
  });

  factory Glance.fromJson(Map<String, dynamic> json) => Glance(
    title: json["title"],
    items: json["items"] == null ? [] : List<Meta>.from(json["items"]!.map((x) => Meta.fromJson(x))),
  );
}

class Meta {
  final String? icon;
  final String? text;

  Meta({
    this.icon,
    this.text,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    icon: json["icon"],
    text: json["text"],
  );
}

class NextMeetingKicker {
  final String? text;
  final String? badge;

  NextMeetingKicker({
    this.text,
    this.badge,
  });

  factory NextMeetingKicker.fromJson(Map<String, dynamic> json) => NextMeetingKicker(
    text: json["text"],
    badge: json["badge"],
  );
}

class Qualification {
  final String? title;
  final String? closeText;
  final int? progress;
  final Requirements? requirements;
  final Meta? status;

  Qualification({
    this.title,
    this.closeText,
    this.progress,
    this.requirements,
    this.status,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
    title: json["title"],
    closeText: json["close_text"],
    progress: json["progress"],
    requirements: json["requirements"] == null ? null : Requirements.fromJson(json["requirements"]),
    status: json["status"] == null ? null : Meta.fromJson(json["status"]),
  );
}

class Requirements {
  final int? completed;
  final int? total;

  Requirements({
    this.completed,
    this.total,
  });

  factory Requirements.fromJson(Map<String, dynamic> json) => Requirements(
    completed: json["completed"],
    total: json["total"],
  );
}
