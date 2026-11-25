import 'dart:convert';

AlertsHomeResponse alertsHomeResponseFromJson(String str) => AlertsHomeResponse.fromJson(json.decode(str));


class AlertsHomeResponse {
  final bool? success;
  final String? message;
  final Data? data;

  AlertsHomeResponse({
    this.success,
    this.message,
    this.data,
  });

  factory AlertsHomeResponse.fromJson(Map<String, dynamic> json) => AlertsHomeResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  final Town? town;
  final Sections? sections;

  Data({
    this.town,
    this.sections,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    town: json["town"] == null ? null : Town.fromJson(json["town"]),
    sections: json["sections"] == null ? null : Sections.fromJson(json["sections"]),
  );

}

class Sections {
  final Heading? heading;
  final Hero? hero;
  final Categories? categories;
  final Actions? actions;
  final Breaking? breaking;
  final Snapshot? snapshot;
  final FeaturedIncident? featuredIncident;
  final News? news;
  final Gallery? gallery;
  final Breaking? travel;
  final Journal? journal;
  final Breaking? communitySolutions;
  final ImpactMap? impactMap;

  Sections({
    this.heading,
    this.hero,
    this.categories,
    this.actions,
    this.breaking,
    this.snapshot,
    this.featuredIncident,
    this.news,
    this.gallery,
    this.travel,
    this.journal,
    this.communitySolutions,
    this.impactMap,
  });

  factory Sections.fromJson(Map<String, dynamic> json) => Sections(
    heading: json["heading"] == null ? null : Heading.fromJson(json["heading"]),
    hero: json["hero"] == null ? null : Hero.fromJson(json["hero"]),
    categories: json["categories"] == null ? null : Categories.fromJson(json["categories"]),
    actions: json["actions"] == null ? null : Actions.fromJson(json["actions"]),
    breaking: json["breaking"] == null ? null : Breaking.fromJson(json["breaking"]),
    snapshot: json["snapshot"] == null ? null : Snapshot.fromJson(json["snapshot"]),
    featuredIncident: json["featured_incident"] == null ? null : FeaturedIncident.fromJson(json["featured_incident"]),
    news: json["news"] == null ? null : News.fromJson(json["news"]),
    gallery: json["gallery"] == null ? null : Gallery.fromJson(json["gallery"]),
    travel: json["travel"] == null ? null : Breaking.fromJson(json["travel"]),
    journal: json["journal"] == null ? null : Journal.fromJson(json["journal"]),
    communitySolutions: json["community_solutions"] == null ? null : Breaking.fromJson(json["community_solutions"]),
    impactMap: json["impact_map"] == null ? null : ImpactMap.fromJson(json["impact_map"]),
  );

}

class Actions {
  final List<MoreActionElement>? items;

  Actions({
    this.items,
  });

  factory Actions.fromJson(Map<String, dynamic> json) => Actions(
    items: json["items"] == null ? [] : List<MoreActionElement>.from(json["items"]!.map((x) => MoreActionElement.fromJson(x))),
  );

}

class MoreActionElement {
  final String? label;
  final String? icon;
  final String? kind;
  final String? composeType;
  final String? category;

  MoreActionElement({
    this.label,
    this.icon,
    this.kind,
    this.composeType,
    this.category,
  });

  factory MoreActionElement.fromJson(Map<String, dynamic> json) => MoreActionElement(
    label: json["label"],
    icon: json["icon"],
    kind: json["kind"],
    composeType: json["compose_type"],
    category: json["category"],
  );

}


class Breaking {
  final String? title;
  final List<BreakingItem>? items;
  final String? emptyLabel;
  final MoreActionElement? action;
  final MoreActionElement? moreAction;
  final String? description;

  Breaking({
    this.title,
    this.items,
    this.emptyLabel,
    this.action,
    this.moreAction,
    this.description,
  });

  factory Breaking.fromJson(Map<String, dynamic> json) => Breaking(
    title: json["title"],
    items: json["items"] == null ? [] : List<BreakingItem>.from(json["items"]!.map((x) => BreakingItem.fromJson(x))),
    emptyLabel: json["empty_label"],
    action: json["action"] == null ? null : MoreActionElement.fromJson(json["action"]),
    moreAction: json["more_action"] == null ? null : MoreActionElement.fromJson(json["more_action"]),
    description: json["description"],
  );

}

class BreakingItem {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? icon;
  final String? tone;
  final String? categorySlug;
  final String? categoryTitle;
  final String? incidentStatus;
  final String? severity;
  final String? publishedAt;
  final DateTime? updatedAt;
  final ItemAction? action;

  BreakingItem({
    this.id,
    this.title,
    this.subtitle,
    this.icon,
    this.tone,
    this.categorySlug,
    this.categoryTitle,
    this.incidentStatus,
    this.severity,
    this.publishedAt,
    this.updatedAt,
    this.action,
  });

  factory BreakingItem.fromJson(Map<String, dynamic> json) => BreakingItem(
    id: json["id"]?.toString(),
    title: json["title"],
    subtitle: json["subtitle"],
    icon: json["icon"],
    tone: json["tone"],
    categorySlug: json["category_slug"],
    categoryTitle: json["category_title"],
    incidentStatus: json["incident_status"],
    severity: json["severity"],
    publishedAt: json["published_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    action: json["action"] == null ? null : ItemAction.fromJson(json["action"]),
  );

}

class ItemAction {
  final String? label;
  final String? icon;
  final String? kind;
  final int? incidentId;
  final String? incidentSlug;
  final String? section;

  ItemAction({
    this.label,
    this.icon,
    this.kind,
    this.incidentId,
    this.incidentSlug,
    this.section,
  });

  factory ItemAction.fromJson(Map<String, dynamic> json) => ItemAction(
    label: json["label"],
    icon: json["icon"],
    kind: json["kind"],
    incidentId: json["incident_id"],
    incidentSlug: json["incident_slug"],
    section: json["section"],
  );

}


class Categories {
  final String? title;
  final String? actionLabel;
  final List<CategoriesItem>? items;

  Categories({
    this.title,
    this.actionLabel,
    this.items,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    title: json["title"],
    actionLabel: json["action_label"],
    items: json["items"] == null ? [] : List<CategoriesItem>.from(json["items"]!.map((x) => CategoriesItem.fromJson(x))),
  );

}

class CategoriesItem {
  final int? id;
  final String? slug;
  final String? label;
  final String? description;
  final String? icon;
  final String? tone;

  CategoriesItem({
    this.id,
    this.slug,
    this.label,
    this.description,
    this.icon,
    this.tone,
  });

  factory CategoriesItem.fromJson(Map<String, dynamic> json) => CategoriesItem(
    id: json["id"],
    slug: json["slug"],
    label: json["label"],
    description: json["description"],
    icon: json["icon"],
    tone: json["tone"],
  );

}

class FeaturedIncident {
  final int? id;
  final int? incidentId;
  final String? heading;
  final String? badge;
  final String? updatedLabel;
  final String? imageUrl;
  final String? imageAlt;
  final String? icon;
  final String? tone;
  final String? statusLabel;
  final String? title;
  final String? source;
  final String? description;
  final List<Stat>? stats;
  final List<Tab>? tabs;
  final List<Timeline>? timeline;
  final TimelinePagination? timelinePagination;
  final DetailActionElement? detailAction;
  final List<DetailActionElement>? actions;
  final String? note;

  FeaturedIncident({
    this.id,
    this.incidentId,
    this.heading,
    this.badge,
    this.updatedLabel,
    this.imageUrl,
    this.imageAlt,
    this.icon,
    this.tone,
    this.statusLabel,
    this.title,
    this.source,
    this.description,
    this.stats,
    this.tabs,
    this.timeline,
    this.timelinePagination,
    this.detailAction,
    this.actions,
    this.note,
  });

  factory FeaturedIncident.fromJson(Map<String, dynamic> json) => FeaturedIncident(
    id: json["id"],
    incidentId: json["incident_id"],
    heading: json["heading"],
    badge: json["badge"],
    updatedLabel: json["updated_label"],
    imageUrl: json["image_url"],
    imageAlt: json["image_alt"],
    icon: json["icon"],
    tone: json["tone"],
    statusLabel: json["status_label"],
    title: json["title"],
    source: json["source"],
    description: json["description"],
    stats: json["stats"] == null ? [] : List<Stat>.from(json["stats"]!.map((x) => Stat.fromJson(x))),
    tabs: json["tabs"] == null ? [] : List<Tab>.from(json["tabs"]!.map((x) => Tab.fromJson(x))),
    timeline: json["timeline"] == null ? [] : List<Timeline>.from(json["timeline"]!.map((x) => Timeline.fromJson(x))),
    timelinePagination: json["timeline_pagination"] == null ? null : TimelinePagination.fromJson(json["timeline_pagination"]),
    detailAction: json["detail_action"] == null ? null : DetailActionElement.fromJson(json["detail_action"]),
    actions: json["actions"] == null ? [] : List<DetailActionElement>.from(json["actions"]!.map((x) => DetailActionElement.fromJson(x))),
    note: json["note"],
  );

}

class DetailActionElement {
  final String? kind;
  final String? label;
  final String? icon;
  final int? incidentId;
  final String? incidentSlug;
  final String? section;
  final String? composeType;

  DetailActionElement({
    this.kind,
    this.label,
    this.icon,
    this.incidentId,
    this.incidentSlug,
    this.section,
    this.composeType,
  });

  factory DetailActionElement.fromJson(Map<String, dynamic> json) => DetailActionElement(
    kind: json["kind"],
    label: json["label"],
    icon: json["icon"],
    incidentId: json["incident_id"],
    incidentSlug: json["incident_slug"],
    section: json["section"],
    composeType: json["compose_type"],
  );
}

class Stat {
  final String? id;
  final String? label;
  final String? value;
  final String? note;
  final String? icon;

  Stat({
    this.id,
    this.label,
    this.value,
    this.note,
    this.icon,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
    id: json["id"],
    label: json["label"],
    value: json["value"],
    note: json["note"],
    icon: json["icon"],
  );

}

class Tab {
  final String? id;
  final ItemAction? action;

  Tab({
    this.id,
    this.action,
  });

  factory Tab.fromJson(Map<String, dynamic> json) => Tab(
    id: json["id"],
    action: json["action"] == null ? null : ItemAction.fromJson(json["action"]),
  );

}

class Timeline {
  final int? id;
  final String? type;
  final String? title;
  final String? description;
  final String? publishedAt;
  final DateTime? occurredAt;
  final DateTime? createdAt;

  Timeline({
    this.id,
    this.type,
    this.title,
    this.description,
    this.publishedAt,
    this.occurredAt,
    this.createdAt,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
    id: json["id"],
    type: json["type"],
    title: json["title"],
    description: json["description"],
    publishedAt: json["published_at"],
    occurredAt: json["occurred_at"] == null ? null : DateTime.parse(json["occurred_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

}

class TimelinePagination {
  final int? currentPage;
  final int? lastPage;
  final int? total;
  final int? perPage;

  TimelinePagination({
    this.currentPage,
    this.lastPage,
    this.total,
    this.perPage,
  });

  factory TimelinePagination.fromJson(Map<String, dynamic> json) => TimelinePagination(
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    total: json["total"],
    perPage: json["per_page"],
  );

}

class Gallery {
  final String? title;
  final List<GalleryItem>? items;
  final String? emptyLabel;

  Gallery({
    this.title,
    this.items,
    this.emptyLabel,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    title: json["title"],
    items: json["items"] == null ? [] : List<GalleryItem>.from(json["items"]!.map((x) => GalleryItem.fromJson(x))),
    emptyLabel: json["empty_label"],
  );

}

class GalleryItem {
  final String? imageUrl;
  final String? caption;

  GalleryItem({
    this.imageUrl,
    this.caption,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) => GalleryItem(
    imageUrl: json["image_url"],
    caption: json["caption"],
  );

}

class Heading {
  final String? title;
  final String? locationLabel;
  final String? browseLabel;

  Heading({
    this.title,
    this.locationLabel,
    this.browseLabel,
  });

  factory Heading.fromJson(Map<String, dynamic> json) => Heading(
    title: json["title"],
    locationLabel: json["location_label"],
    browseLabel: json["browse_label"],
  );

}

class Hero {
  final String? title;
  final String? imageUrl;
  final String? imageAlt;
  final String? description;

  Hero({
    this.title,
    this.imageUrl,
    this.imageAlt,
    this.description,
  });

  factory Hero.fromJson(Map<String, dynamic> json) => Hero(
    title: json["title"],
    imageUrl: json["image_url"],
    imageAlt: json["image_alt"],
    description: json["description"],
  );

}

class ImpactMap {
  final String? title;
  final Center? center;
  final List<dynamic>? pins;
  final List<Layer>? layers;
  final String? note;
  final String? emptyLabel;

  ImpactMap({
    this.title,
    this.center,
    this.pins,
    this.layers,
    this.note,
    this.emptyLabel,
  });

  factory ImpactMap.fromJson(Map<String, dynamic> json) => ImpactMap(
    title: json["title"],
    center: json["center"] == null ? null : Center.fromJson(json["center"]),
    pins: json["pins"] == null ? [] : List<dynamic>.from(json["pins"]!.map((x) => x)),
    layers: json["layers"] == null ? [] : List<Layer>.from(json["layers"]!.map((x) => Layer.fromJson(x))),
    note: json["note"],
    emptyLabel: json["empty_label"],
  );

}

class Center {
  final double? latitude;
  final double? longitude;

  Center({
    this.latitude,
    this.longitude,
  });

  factory Center.fromJson(Map<String, dynamic> json) => Center(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

}

class Layer {
  final String? id;
  final String? label;

  Layer({
    this.id,
    this.label,
  });

  factory Layer.fromJson(Map<String, dynamic> json) => Layer(
    id: json["id"],
    label: json["label"],
  );

}

class Journal {
  final String? title;
  final List<Layer>? filters;
  final List<Feature>? items;
  final MoreActionElement? action;
  final String? emptyTitle;
  final String? emptyDescription;

  Journal({
    this.title,
    this.filters,
    this.items,
    this.action,
    this.emptyTitle,
    this.emptyDescription,
  });

  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
    title: json["title"],
    filters: json["filters"] == null ? [] : List<Layer>.from(json["filters"]!.map((x) => Layer.fromJson(x))),
    items: json["items"] == null ? [] : List<Feature>.from(json["items"]!.map((x) => Feature.fromJson(x))),
    action: json["action"] == null ? null : MoreActionElement.fromJson(json["action"]),
    emptyTitle: json["empty_title"],
    emptyDescription: json["empty_description"],
  );
}

class Feature {
  final String? id;
  final String? kind;
  final String? categorySlug;
  final String? area;
  final String? title;
  final String? description;
  final String? details;
  final String? source;
  final String? badge;
  final String? badgeClass;
  final String? icon;
  final String? tone;
  final String? imageUrl;
  final String? imageAlt;
  final String? updated;
  final String? updatedLabel;
  final int? photos;
  final int? replies;
  final int? solutions;
  final List<Tag>? tags;
  final ItemAction? action;

  Feature({
    this.id,
    this.kind,
    this.categorySlug,
    this.area,
    this.title,
    this.description,
    this.details,
    this.source,
    this.badge,
    this.badgeClass,
    this.icon,
    this.tone,
    this.imageUrl,
    this.imageAlt,
    this.updated,
    this.updatedLabel,
    this.photos,
    this.replies,
    this.solutions,
    this.tags,
    this.action,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    id: json["id"],
    kind: json["kind"],
    categorySlug: json["category_slug"],
    area: json["area"],
    title: json["title"],
    description: json["description"],
    details: json["details"],
    source: json["source"],
    badge: json["badge"],
    badgeClass: json["badge_class"],
    icon: json["icon"],
    tone: json["tone"],
    imageUrl: json["image_url"],
    imageAlt: json["image_alt"],
    updated: json["updated"],
    updatedLabel: json["updated_label"],
    photos: json["photos"],
    replies: json["replies"],
    solutions: json["solutions"],
    tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
    action: json["action"] == null ? null : ItemAction.fromJson(json["action"]),
  );
}

class Tag {
  final String? label;
  final String? icon;

  Tag({
    this.label,
    this.icon,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    label: json["label"],
    icon: json["icon"],
  );
}

class News {
  final String? title;
  final String? badge;
  final String? description;
  final Feature? feature;
  final List<Feature>? items;
  final String? emptyLabel;

  News({
    this.title,
    this.badge,
    this.description,
    this.feature,
    this.items,
    this.emptyLabel,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    title: json["title"],
    badge: json["badge"],
    description: json["description"],
    feature: json["feature"] == null ? null : Feature.fromJson(json["feature"]),
    items: json["items"] == null ? [] : List<Feature>.from(json["items"]!.map((x) => Feature.fromJson(x))),
    emptyLabel: json["empty_label"],
  );
}

class Snapshot {
  final String? title;
  final DateTime? updatedAt;
  final String? timezone;
  final String? updatedLabel;
  final MoreActionElement? action;
  final List<Metric>? metrics;

  Snapshot({
    this.title,
    this.updatedAt,
    this.timezone,
    this.updatedLabel,
    this.action,
    this.metrics,
  });

  factory Snapshot.fromJson(Map<String, dynamic> json) => Snapshot(
    title: json["title"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    timezone: json["timezone"],
    updatedLabel: json["updated_label"],
    action: json["action"] == null ? null : MoreActionElement.fromJson(json["action"]),
    metrics: json["metrics"] == null ? [] : List<Metric>.from(json["metrics"]!.map((x) => Metric.fromJson(x))),
  );
}

class Metric {
  final String? id;
  final String? label;
  final int? value;
  final String? icon;
  final String? tone;

  Metric({
    this.id,
    this.label,
    this.value,
    this.icon,
    this.tone,
  });

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
    id: json["id"],
    label: json["label"],
    value: json["value"],
    icon: json["icon"],
    tone: json["tone"],
  );
}

class Town {
  final int? id;
  final String? name;
  final String? state;
  final String? timezone;

  Town({
    this.id,
    this.name,
    this.state,
    this.timezone,
  });

  factory Town.fromJson(Map<String, dynamic> json) => Town(
    id: json["id"],
    name: json["name"],
    state: json["state"],
    timezone: json["timezone"],
  );

}

