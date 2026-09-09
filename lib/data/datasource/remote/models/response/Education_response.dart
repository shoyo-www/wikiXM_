
import 'dart:convert';

EducationHomeResponse educationHomeResponseFromJson(String str) => EducationHomeResponse.fromJson(json.decode(str));


class EducationHomeResponse {
  final bool? success;
  final String? message;
  final EducationData? data;

  EducationHomeResponse({
    this.success,
    this.message,
    this.data,
  });

  factory EducationHomeResponse.fromJson(Map<String, dynamic> json) => EducationHomeResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : EducationData.fromJson(json["data"]),
  );
}

class EducationData {
  final Location? location;
  final Banner? banner;
  final Hero? hero;
  final TopPanels? topPanels;
  final MidPanels? midPanels;
  final StoryGrid? storyGrid;
  final Resources? resources;
  final SchoolRail? schoolRail;
  final Partners? partners;
  final PopularTopics? popularTopics;

  EducationData({
    this.location,
    this.banner,
    this.hero,
    this.topPanels,
    this.midPanels,
    this.storyGrid,
    this.resources,
    this.schoolRail,
    this.partners,
    this.popularTopics,
  });

  factory EducationData.fromJson(Map<String, dynamic> json) => EducationData(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    banner: json["banner"] == null ? null : Banner.fromJson(json["banner"]),
    hero: json["hero"] == null ? null : Hero.fromJson(json["hero"]),
    topPanels: json["top_panels"] == null ? null : TopPanels.fromJson(json["top_panels"]),
    midPanels: json["mid_panels"] == null ? null : MidPanels.fromJson(json["mid_panels"]),
    storyGrid: json["story_grid"] == null ? null : StoryGrid.fromJson(json["story_grid"]),
    resources: json["resources"] == null ? null : Resources.fromJson(json["resources"]),
    schoolRail: json["school_rail"] == null ? null : SchoolRail.fromJson(json["school_rail"]),
    partners: json["partners"] == null ? null : Partners.fromJson(json["partners"]),
    popularTopics: json["popular_topics"] == null ? null : PopularTopics.fromJson(json["popular_topics"]),
  );
}

class Banner {
  final String? ariaLabel;
  final String? image;
  final String? imageAlt;
  final String? sponsorTag;
  final String? mark;
  final String? title;
  final String? description;
  final String? supportingText;
  final Button? button;

  Banner({
    this.ariaLabel,
    this.image,
    this.imageAlt,
    this.sponsorTag,
    this.mark,
    this.title,
    this.description,
    this.supportingText,
    this.button,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    ariaLabel: json["aria_label"],
    image: json["image"],
    imageAlt: json["image_alt"],
    sponsorTag: json["sponsor_tag"],
    mark: json["mark"],
    title: json["title"],
    description: json["description"],
    supportingText: json["supporting_text"],
    button: json["button"] == null ? null : Button.fromJson(json["button"]),
  );

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

}

class Hero {
  final String? greeting;
  final String? title;
  final String? description;
  final String? image;
  final String? imageAlt;
  final List<Stat>? stats;
  final Live? live;
  final String? quickLinksTitle;
  final List<QuickLink>? quickLinks;
  final List<StoryTab>? storyTabs;

  Hero({
    this.greeting,
    this.title,
    this.description,
    this.image,
    this.imageAlt,
    this.stats,
    this.live,
    this.quickLinksTitle,
    this.quickLinks,
    this.storyTabs,
  });

  factory Hero.fromJson(Map<String, dynamic> json) => Hero(
    greeting: json["greeting"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    imageAlt: json["image_alt"],
    stats: json["stats"] == null ? [] : List<Stat>.from(json["stats"]!.map((x) => Stat.fromJson(x))),
    live: json["live"] == null ? null : Live.fromJson(json["live"]),
    quickLinksTitle: json["quick_links_title"],
    quickLinks: json["quick_links"] == null ? [] : List<QuickLink>.from(json["quick_links"]!.map((x) => QuickLink.fromJson(x))),
    storyTabs: json["story_tabs"] == null ? [] : List<StoryTab>.from(json["story_tabs"]!.map((x) => StoryTab.fromJson(x))),
  );
}

class Live {
  final String? title;
  final String? status;
  final List<Updated>? items;
  final ViewAll? link;

  Live({
    this.title,
    this.status,
    this.items,
    this.link,
  });

  factory Live.fromJson(Map<String, dynamic> json) => Live(
    title: json["title"],
    status: json["status"],
    items: json["items"] == null ? [] : List<Updated>.from(json["items"]!.map((x) => Updated.fromJson(x))),
    link: json["link"] == null ? null : ViewAll.fromJson(json["link"]),
  );

}

class Updated {
  final String? icon;
  final String? text;

  Updated({
    this.icon,
    this.text,
  });

  factory Updated.fromJson(Map<String, dynamic> json) => Updated(
    icon: json["icon"],
    text: json["text"],
  );

}

class ViewAll {
  final String? text;
  final String? url;
  final String? icon;

  ViewAll({
    this.text,
    this.url,
    this.icon,
  });

  factory ViewAll.fromJson(Map<String, dynamic> json) => ViewAll(
    text: json["text"],
    url: json["url"],
    icon: json["icon"],
  );

}

class QuickLink {
  final String? label;
  final String? url;

  QuickLink({
    this.label,
    this.url,
  });

  factory QuickLink.fromJson(Map<String, dynamic> json) => QuickLink(
    label: json["label"],
    url: json["url"],
  );

}

class Stat {
  final String? icon;
  final String? label;
  final int? value;

  Stat({
    this.icon,
    this.label,
    this.value,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
    icon: json["icon"],
    label: json["label"],
    value: json["value"],
  );

}

class StoryTab {
  final String? label;
  final String? url;
  final bool? active;

  StoryTab({
    this.label,
    this.url,
    this.active,
  });

  factory StoryTab.fromJson(Map<String, dynamic> json) => StoryTab(
    label: json["label"],
    url: json["url"],
    active: json["active"],
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

class MidPanels {
  final Browse? browse;
  final Topics? topics;

  MidPanels({
    this.browse,
    this.topics,
  });

  factory MidPanels.fromJson(Map<String, dynamic> json) => MidPanels(
    browse: json["browse"] == null ? null : Browse.fromJson(json["browse"]),
    topics: json["topics"] == null ? null : Topics.fromJson(json["topics"]),
  );

}

class Browse {
  final String? title;
  final ViewAll? link;
  final List<Filter>? filters;
  final String? allStatus;
  final String? filteredStatus;
  final List<School>? schools;
  final More? more;

  Browse({
    this.title,
    this.link,
    this.filters,
    this.allStatus,
    this.filteredStatus,
    this.schools,
    this.more,
  });

  factory Browse.fromJson(Map<String, dynamic> json) => Browse(
    title: json["title"],
    link: json["link"] == null ? null : ViewAll.fromJson(json["link"]),
    filters: json["filters"] == null ? [] : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
    allStatus: json["all_status"],
    filteredStatus: json["filtered_status"],
    schools: json["schools"] == null ? [] : List<School>.from(json["schools"]!.map((x) => School.fromJson(x))),
    more: json["more"] == null ? null : More.fromJson(json["more"]),
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

class More {
  final String? icon;
  final String? title;
  final int? count;
  final String? url;

  More({
    this.icon,
    this.title,
    this.count,
    this.url,
  });

  factory More.fromJson(Map<String, dynamic> json) => More(
    icon: json["icon"],
    title: json["title"],
    count: json["count"],
    url: json["url"],
  );

}

class School {
  final String? type;
  final String? image;
  final String? alt;
  final String? icon;
  final String? name;
  final String? grades;
  final int? students;

  School({
    this.type,
    this.image,
    this.alt,
    this.icon,
    this.name,
    this.grades,
    this.students,
  });

  factory School.fromJson(Map<String, dynamic> json) => School(
    type: json["type"],
    image: json["image"],
    alt: json["alt"],
    icon: json["icon"],
    name: json["name"],
    grades: json["grades"],
    students: json["students"],
  );

}

class Topics {
  final String? title;
  final ViewAll? link;
  final List<TopicsItem>? items;

  Topics({
    this.title,
    this.link,
    this.items,
  });

  factory Topics.fromJson(Map<String, dynamic> json) => Topics(
    title: json["title"],
    link: json["link"] == null ? null : ViewAll.fromJson(json["link"]),
    items: json["items"] == null ? [] : List<TopicsItem>.from(json["items"]!.map((x) => TopicsItem.fromJson(x))),
  );

}

class TopicsItem {
  final String? id;
  final String? iconClass;
  final String? icon;
  final String? title;
  final int? discussions;
  final String? updated;
  final String? priority;
  final String? priorityClass;

  TopicsItem({
    this.id,
    this.iconClass,
    this.icon,
    this.title,
    this.discussions,
    this.updated,
    this.priority,
    this.priorityClass,
  });

  factory TopicsItem.fromJson(Map<String, dynamic> json) => TopicsItem(
    id: json["id"],
    iconClass: json["icon_class"],
    icon: json["icon"],
    title: json["title"],
    discussions: json["discussions"],
    updated: json["updated"],
    priority: json["priority"],
    priorityClass: json["priority_class"],
  );
}

class Partners {
  final String? title;
  final List<PartnersItem>? items;
  final ViewAll? viewAll;

  Partners({
    this.title,
    this.items,
    this.viewAll,
  });

  factory Partners.fromJson(Map<String, dynamic> json) => Partners(
    title: json["title"],
    items: json["items"] == null ? [] : List<PartnersItem>.from(json["items"]!.map((x) => PartnersItem.fromJson(x))),
    viewAll: json["view_all"] == null ? null : ViewAll.fromJson(json["view_all"]),
  );

}

class PartnersItem {
  final String? name;
  final String? description;
  final String? icon;
  final String? url;

  PartnersItem({
    this.name,
    this.description,
    this.icon,
    this.url,
  });

  factory PartnersItem.fromJson(Map<String, dynamic> json) => PartnersItem(
    name: json["name"],
    description: json["description"],
    icon: json["icon"],
    url: json["url"],
  );

}

class PopularTopics {
  final String? title;
  final String? ariaLabel;
  final List<QuickLink>? items;
  final Button? manage;

  PopularTopics({
    this.title,
    this.ariaLabel,
    this.items,
    this.manage,
  });

  factory PopularTopics.fromJson(Map<String, dynamic> json) => PopularTopics(
    title: json["title"],
    ariaLabel: json["aria_label"],
    items: json["items"] == null ? [] : List<QuickLink>.from(json["items"]!.map((x) => QuickLink.fromJson(x))),
    manage: json["manage"] == null ? null : Button.fromJson(json["manage"]),
  );

}

class Resources {
  final String? title;
  final List<ResourcesItem>? items;

  Resources({
    this.title,
    this.items,
  });

  factory Resources.fromJson(Map<String, dynamic> json) => Resources(
    title: json["title"],
    items: json["items"] == null ? [] : List<ResourcesItem>.from(json["items"]!.map((x) => ResourcesItem.fromJson(x))),
  );

}

class ResourcesItem {
  final String? icon;
  final String? iconClass;
  final String? title;
  final String? description;
  final String? url;
  final int? points;

  ResourcesItem({
    this.icon,
    this.iconClass,
    this.title,
    this.description,
    this.url,
    this.points,
  });

  factory ResourcesItem.fromJson(Map<String, dynamic> json) => ResourcesItem(
    icon: json["icon"],
    iconClass: json["icon_class"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    points: json["points"],
  );

}

class SchoolRail {
  final AiBrief? aiBrief;
  final Pulse? pulse;
  final ParentCorner? parentCorner;
  final Subscribe? subscribe;

  SchoolRail({
    this.aiBrief,
    this.pulse,
    this.parentCorner,
    this.subscribe,
  });

  factory SchoolRail.fromJson(Map<String, dynamic> json) => SchoolRail(
    aiBrief: json["ai_brief"] == null ? null : AiBrief.fromJson(json["ai_brief"]),
    pulse: json["pulse"] == null ? null : Pulse.fromJson(json["pulse"]),
    parentCorner: json["parent_corner"] == null ? null : ParentCorner.fromJson(json["parent_corner"]),
    subscribe: json["subscribe"] == null ? null : Subscribe.fromJson(json["subscribe"]),
  );

}

class AiBrief {
  final String? title;
  final String? badge;
  final String? image;
  final String? imageAlt;
  final String? greeting;
  final String? intro;
  final String? introHighlight;
  final String? highlight;
  final String? description;
  final Updated? updated;
  final ViewAll? action;

  AiBrief({
    this.title,
    this.badge,
    this.image,
    this.imageAlt,
    this.greeting,
    this.intro,
    this.introHighlight,
    this.highlight,
    this.description,
    this.updated,
    this.action,
  });

  factory AiBrief.fromJson(Map<String, dynamic> json) => AiBrief(
    title: json["title"],
    badge: json["badge"],
    image: json["image"],
    imageAlt: json["image_alt"],
    greeting: json["greeting"],
    intro: json["intro"],
    introHighlight: json["intro_highlight"],
    highlight: json["highlight"],
    description: json["description"],
    updated: json["updated"] == null ? null : Updated.fromJson(json["updated"]),
    action: json["action"] == null ? null : ViewAll.fromJson(json["action"]),
  );

}

class ParentCorner {
  final String? title;
  final List<ParentCornerItem>? items;

  ParentCorner({
    this.title,
    this.items,
  });

  factory ParentCorner.fromJson(Map<String, dynamic> json) => ParentCorner(
    title: json["title"],
    items: json["items"] == null ? [] : List<ParentCornerItem>.from(json["items"]!.map((x) => ParentCornerItem.fromJson(x))),
  );

}

class ParentCornerItem {
  final String? icon;
  final String? title;
  final String? description;

  ParentCornerItem({
    this.icon,
    this.title,
    this.description,
  });

  factory ParentCornerItem.fromJson(Map<String, dynamic> json) => ParentCornerItem(
    icon: json["icon"],
    title: json["title"],
    description: json["description"],
  );

}

class Pulse {
  final String? title;
  final ViewAll? link;
  final int? score;
  final String? scoreLabel;
  final Summary? summary;
  final List<Metric>? metrics;

  Pulse({
    this.title,
    this.link,
    this.score,
    this.scoreLabel,
    this.summary,
    this.metrics,
  });

  factory Pulse.fromJson(Map<String, dynamic> json) => Pulse(
    title: json["title"],
    link: json["link"] == null ? null : ViewAll.fromJson(json["link"]),
    score: json["score"],
    scoreLabel: json["score_label"],
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    metrics: json["metrics"] == null ? [] : List<Metric>.from(json["metrics"]!.map((x) => Metric.fromJson(x))),
  );

}

class Metric {
  final String? icon;
  final String? label;
  final String? value;
  final String? change;
  final String? valueClass;
  final String? changeClass;

  Metric({
    this.icon,
    this.label,
    this.value,
    this.change,
    this.valueClass,
    this.changeClass,
  });

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
    icon: json["icon"],
    label: json["label"],
    value: json["value"],
    change: json["change"],
    valueClass: json["value_class"],
    changeClass: json["change_class"],
  );

}

class Summary {
  final String? title;
  final String? subtitle;

  Summary({
    this.title,
    this.subtitle,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    title: json["title"],
    subtitle: json["subtitle"],
  );

}

class Subscribe {
  final String? title;
  final String? description;
  final String? emailLabel;
  final String? emailPlaceholder;
  final String? buttonText;
  final String? statusId;

  Subscribe({
    this.title,
    this.description,
    this.emailLabel,
    this.emailPlaceholder,
    this.buttonText,
    this.statusId,
  });

  factory Subscribe.fromJson(Map<String, dynamic> json) => Subscribe(
    title: json["title"],
    description: json["description"],
    emailLabel: json["email_label"],
    emailPlaceholder: json["email_placeholder"],
    buttonText: json["button_text"],
    statusId: json["status_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "email_label": emailLabel,
    "email_placeholder": emailPlaceholder,
    "button_text": buttonText,
    "status_id": statusId,
  };
}

class StoryGrid {
  final Board? board;
  final Memories? spotlight;
  final Events? events;
  final Memories? memories;

  StoryGrid({
    this.board,
    this.spotlight,
    this.events,
    this.memories,
  });

  factory StoryGrid.fromJson(Map<String, dynamic> json) => StoryGrid(
    board: json["board"] == null ? null : Board.fromJson(json["board"]),
    spotlight: json["spotlight"] == null ? null : Memories.fromJson(json["spotlight"]),
    events: json["events"] == null ? null : Events.fromJson(json["events"]),
    memories: json["memories"] == null ? null : Memories.fromJson(json["memories"]),
  );

}

class Board {
  final String? title;
  final String? id;
  final List<BoardItem>? items;

  Board({
    this.title,
    this.id,
    this.items,
  });

  factory Board.fromJson(Map<String, dynamic> json) => Board(
    title: json["title"],
    id: json["id"],
    items: json["items"] == null ? [] : List<BoardItem>.from(json["items"]!.map((x) => BoardItem.fromJson(x))),
  );

}

class BoardItem {
  final String? id;
  final String? icon;
  final String? title;
  final String? status;
  final String? meta;

  BoardItem({
    this.id,
    this.icon,
    this.title,
    this.status,
    this.meta,
  });

  factory BoardItem.fromJson(Map<String, dynamic> json) => BoardItem(
    id: json["id"],
    icon: json["icon"],
    title: json["title"],
    status: json["status"],
    meta: json["meta"],
  );

}

class Events {
  final String? title;
  final String? id;
  final ViewAll? link;
  final List<BoardItem>? items;
  final ViewAll? bottomLink;

  Events({
    this.title,
    this.id,
    this.link,
    this.items,
    this.bottomLink,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
    title: json["title"],
    id: json["id"],
    link: json["link"] == null ? null : ViewAll.fromJson(json["link"]),
    items: json["items"] == null ? [] : List<BoardItem>.from(json["items"]!.map((x) => BoardItem.fromJson(x))),
    bottomLink: json["bottom_link"] == null ? null : ViewAll.fromJson(json["bottom_link"]),
  );

}

class Memories {
  final String? title;
  final ViewAll? link;
  final String? image;
  final String? imageAlt;
  final String? label;
  final String? headline;
  final String? description;
  final List<Updated>? meta;

  Memories({
    this.title,
    this.link,
    this.image,
    this.imageAlt,
    this.label,
    this.headline,
    this.description,
    this.meta,
  });

  factory Memories.fromJson(Map<String, dynamic> json) => Memories(
    title: json["title"],
    link: json["link"] == null ? null : ViewAll.fromJson(json["link"]),
    image: json["image"],
    imageAlt: json["image_alt"],
    label: json["label"],
    headline: json["headline"],
    description: json["description"],
    meta: json["meta"] == null ? [] : List<Updated>.from(json["meta"]!.map((x) => Updated.fromJson(x))),
  );

}

class TopPanels {
  final Matters? matters;
  final Today? today;

  TopPanels({
    this.matters,
    this.today,
  });

  factory TopPanels.fromJson(Map<String, dynamic> json) => TopPanels(
    matters: json["matters"] == null ? null : Matters.fromJson(json["matters"]),
    today: json["today"] == null ? null : Today.fromJson(json["today"]),
  );

}

class Matters {
  final String? title;
  final ViewAll? link;
  final List<Card>? cards;

  Matters({
    this.title,
    this.link,
    this.cards,
  });

  factory Matters.fromJson(Map<String, dynamic> json) => Matters(
    title: json["title"],
    link: json["link"] == null ? null : ViewAll.fromJson(json["link"]),
    cards: json["cards"] == null ? [] : List<Card>.from(json["cards"]!.map((x) => Card.fromJson(x))),
  );

}

class Card {
  final int? rank;
  final Priority? priority;
  final String? image;
  final String? imageAlt;
  final String? title;
  final String? url;
  final String? topic;
  final int? comments;
  final int? readTime;

  Card({
    this.rank,
    this.priority,
    this.image,
    this.imageAlt,
    this.title,
    this.url,
    this.topic,
    this.comments,
    this.readTime,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    rank: json["rank"],
    priority: json["priority"] == null ? null : Priority.fromJson(json["priority"]),
    image: json["image"],
    imageAlt: json["image_alt"],
    title: json["title"],
    url: json["url"],
    topic: json["topic"],
    comments: json["comments"],
    readTime: json["read_time"],
  );

}

class Priority {
  final String? label;
  final String? className;

  Priority({
    this.label,
    this.className,
  });

  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
    label: json["label"],
    className: json["class_name"],
  );

}

class Today {
  final String? title;
  final ViewAll? link;
  final List<ResourcesItem>? items;

  Today({
    this.title,
    this.link,
    this.items,
  });

  factory Today.fromJson(Map<String, dynamic> json) => Today(
    title: json["title"],
    link: json["link"] == null ? null : ViewAll.fromJson(json["link"]),
    items: json["items"] == null ? [] : List<ResourcesItem>.from(json["items"]!.map((x) => ResourcesItem.fromJson(x))),
  );
}
