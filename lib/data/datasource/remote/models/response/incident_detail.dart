import 'dart:convert';
import 'alerts_home.dart' show TimelinePagination;

IncidentDetailResponse incidentDetailResponseFromJson(String str) => IncidentDetailResponse.fromJson(json.decode(str));
IncidentContentResponse incidentContentResponseFromJson(String str) => IncidentContentResponse.fromJson(json.decode(str));

class IncidentDetailResponse {
  final bool? success;
  final String? message;
  final Incident? data;

  IncidentDetailResponse({this.success, this.message, this.data});

  factory IncidentDetailResponse.fromJson(Map<String, dynamic> json) => IncidentDetailResponse(success: json["success"], message: json["message"], data: json["data"] == null ? null : Incident.fromJson(json["data"]));
}

class Incident {
  final int? id;
  final String? title;
  final String? summary;
  final String? slug;
  final String? categorySlug;
  final String? categoryTitle;
  final String? incidentStatus;
  final String? severity;
  final String? locationName;
  final int? commentsCount;
  final String? imageUrl;
  final String? defaultTab;
  final List<IncidentTab>? tabs;
  final String? description;
  final String? sourceUrl;
  final String? sourceType;
  final bool? isMostActive;
  final IncidentAuthor? author;
  final List<IncidentMedia>? media;
  final List<IncidentEntry>? contributions;
  final List<IncidentEntry>? timelinePreview;
  final IncidentPreview? solutionPreview;
  final IncidentPreview? questionPreview;
  final String? occurredAtLabel;
  final String? updatedAtLabel;
  final String? reportedAtLabel;
  final DisplayTimestamp? displayTimestamp;

  Incident({
    this.id,
    this.title,
    this.summary,
    this.slug,
    this.categorySlug,
    this.categoryTitle,
    this.incidentStatus,
    this.severity,
    this.locationName,
    this.commentsCount,
    this.imageUrl,
    this.defaultTab,
    this.tabs,
    this.description,
    this.sourceUrl,
    this.sourceType,
    this.isMostActive,
    this.author,
    this.media,
    this.contributions,
    this.timelinePreview,
    this.solutionPreview,
    this.questionPreview,
    this.occurredAtLabel,
    this.updatedAtLabel,
    this.reportedAtLabel,
    this.displayTimestamp,
  });

  factory Incident.fromJson(Map<String, dynamic> json) => Incident(
    id: json["id"],
    title: json["title"],
    summary: json["summary"],
    slug: json["slug"],
    categorySlug: json["category_slug"],
    categoryTitle: json["category_title"],
    incidentStatus: json["incident_status"],
    severity: json["severity"]?.toString(),
    locationName: json["location_name"],
    commentsCount: json["comments_count"],
    imageUrl: json["image_url"],
    defaultTab: json["default_tab"],
    tabs: json["tabs"] == null ? [] : List<IncidentTab>.from(json["tabs"]!.map((x) => IncidentTab.fromJson(x))),
    description: json["description"],
    sourceUrl: json["source_url"],
    sourceType: json["source_type"],
    isMostActive: json["is_most_active"],
    author: json["author"] == null ? null : IncidentAuthor.fromJson(json["author"]),
    media: json["media"] == null ? [] : List<IncidentMedia>.from(json["media"]!.map((x) => IncidentMedia.fromJson(x))),
    contributions: json["contributions"] == null ? [] : List<IncidentEntry>.from(json["contributions"]!.map((x) => IncidentEntry.fromJson(x))),
    timelinePreview: json["timeline_preview"] == null ? [] : List<IncidentEntry>.from(json["timeline_preview"]!.map((x) => IncidentEntry.fromJson(x))),
    solutionPreview: json["solution_preview"] == null ? null : IncidentPreview.fromJson(json["solution_preview"]),
    questionPreview: json["question_preview"] == null ? null : IncidentPreview.fromJson(json["question_preview"]),
    occurredAtLabel: json["occurred_at_label"],
    updatedAtLabel: json["updated_at_label"],
    reportedAtLabel: json["reported_at_label"],
    displayTimestamp: json["display_timestamp"] == null ? null : DisplayTimestamp.fromJson(json["display_timestamp"]),
  );
}

class IncidentTab {
  final String? id;
  final String? label;
  final String? icon;
  // null for the overview tab, otherwise the `type` sent to the content endpoint
  final String? contentType;

  IncidentTab({this.id, this.label, this.icon, this.contentType});

  factory IncidentTab.fromJson(Map<String, dynamic> json) => IncidentTab(id: json["id"], label: json["label"], icon: json["icon"], contentType: json["content_type"]);
}

class IncidentAuthor {
  final int? id;
  final String? name;
  final String? username;
  final String? profileImage;

  IncidentAuthor({this.id, this.name, this.username, this.profileImage});

  factory IncidentAuthor.fromJson(Map<String, dynamic> json) => IncidentAuthor(id: json["id"], name: json["name"], username: json["username"], profileImage: json["profile_image"]);
}

class IncidentMedia {
  final int? id;
  final String? caption;
  final String? url;

  IncidentMedia({this.id, this.caption, this.url});

  factory IncidentMedia.fromJson(Map<String, dynamic> json) => IncidentMedia(id: json["id"], caption: json["caption"], url: json["url"]);
}

class IncidentPreview {
  final int? total;
  final List<IncidentEntry>? items;

  IncidentPreview({this.total, this.items});

  factory IncidentPreview.fromJson(Map<String, dynamic> json) => IncidentPreview(total: json["total"], items: json["items"] == null ? [] : List<IncidentEntry>.from(json["items"]!.map((x) => IncidentEntry.fromJson(x))));
}

/// One item of any incident list: timeline update, comment, reply, question or solution.
class IncidentEntry {
  final int? id;
  final int? parentId;
  final String? type;
  final String? title;
  final String? description;
  final String? body;
  final String? authorName;
  final IncidentAuthor? author;
  final int? likesCount;
  final bool? isLiked;
  final int? repliesCount;
  final int? answersCount;
  final String? createdAtLabel;
  final String? occurredAtLabel;
  final DisplayTimestamp? displayTimestamp;

  IncidentEntry({this.id, this.parentId, this.type, this.title, this.description, this.body, this.authorName, this.author, this.likesCount, this.isLiked, this.repliesCount, this.answersCount, this.createdAtLabel, this.occurredAtLabel, this.displayTimestamp});

  factory IncidentEntry.fromJson(Map<String, dynamic> json) => IncidentEntry(
    id: json["id"],
    parentId: json["parent_id"],
    type: json["type"],
    title: json["title"],
    description: json["description"],
    body: json["body"],
    authorName: json["author_name"],
    author: json["author"] == null ? null : IncidentAuthor.fromJson(json["author"]),
    likesCount: json["likes_count"],
    isLiked: json["is_liked"],
    repliesCount: json["replies_count"],
    answersCount: json["answers_count"],
    createdAtLabel: json["created_at_label"],
    occurredAtLabel: json["occurred_at_label"],
    displayTimestamp: json["display_timestamp"] == null ? null : DisplayTimestamp.fromJson(json["display_timestamp"]),
  );
}

class DisplayTimestamp {
  final String? value;
  final String? label;
  final String? time;
  final String? date;

  DisplayTimestamp({this.value, this.label, this.time, this.date});

  factory DisplayTimestamp.fromJson(Map<String, dynamic> json) => DisplayTimestamp(value: json["value"], label: json["label"], time: json["time"], date: json["date"]);
}

class IncidentContentResponse {
  final bool? success;
  final String? message;
  final IncidentContent? data;

  IncidentContentResponse({this.success, this.message, this.data});

  factory IncidentContentResponse.fromJson(Map<String, dynamic> json) => IncidentContentResponse(success: json["success"], message: json["message"], data: json["data"] == null ? null : IncidentContent.fromJson(json["data"]));
}

class IncidentContent {
  final List<IncidentEntry>? items;
  final TimelinePagination? pagination;

  IncidentContent({this.items, this.pagination});

  factory IncidentContent.fromJson(Map<String, dynamic> json) => IncidentContent(items: json["items"] == null ? [] : List<IncidentEntry>.from(json["items"]!.map((x) => IncidentEntry.fromJson(x))), pagination: json["pagination"] == null ? null : TimelinePagination.fromJson(json["pagination"]));
}
