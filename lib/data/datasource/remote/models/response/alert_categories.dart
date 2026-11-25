import 'dart:convert';
import 'alerts_home.dart' show Town, TimelinePagination;

AlertCategoriesResponse alertCategoriesResponseFromJson(String str) => AlertCategoriesResponse.fromJson(json.decode(str));
CategoryIncidentsResponse categoryIncidentsResponseFromJson(String str) => CategoryIncidentsResponse.fromJson(json.decode(str));

class AlertCategoriesResponse {
  final bool? success;
  final String? message;
  final AlertCategoriesData? data;

  AlertCategoriesResponse({this.success, this.message, this.data});

  factory AlertCategoriesResponse.fromJson(Map<String, dynamic> json) => AlertCategoriesResponse(success: json["success"], message: json["message"], data: json["data"] == null ? null : AlertCategoriesData.fromJson(json["data"]));
}

class AlertCategoriesData {
  final Town? town;
  final List<AlertCategory>? categories;
  final CategoryIncidents? results;
  final List<CategoryIncident>? mostDiscussed;

  AlertCategoriesData({this.town, this.categories, this.results, this.mostDiscussed});

  factory AlertCategoriesData.fromJson(Map<String, dynamic> json) => AlertCategoriesData(
    town: json["town"] == null ? null : Town.fromJson(json["town"]),
    categories: json["categories"] == null ? [] : List<AlertCategory>.from(json["categories"]!.map((x) => AlertCategory.fromJson(x))),
    results: json["results"] == null ? null : CategoryIncidents.fromJson(json["results"]),
    mostDiscussed: json["most_discussed"] == null ? [] : List<CategoryIncident>.from(json["most_discussed"]!.map((x) => CategoryIncident.fromJson(x))),
  );
}

class AlertCategory {
  final int? id;
  final String? slug;
  final String? title;
  final int? activeCount;

  AlertCategory({this.id, this.slug, this.title, this.activeCount});

  factory AlertCategory.fromJson(Map<String, dynamic> json) => AlertCategory(id: json["id"], slug: json["slug"], title: json["title"], activeCount: json["active_count"]);
}

class CategoryIncidentsResponse {
  final bool? success;
  final String? message;
  final CategoryIncidents? data;

  CategoryIncidentsResponse({this.success, this.message, this.data});

  factory CategoryIncidentsResponse.fromJson(Map<String, dynamic> json) => CategoryIncidentsResponse(success: json["success"], message: json["message"], data: json["data"] == null ? null : CategoryIncidents.fromJson(json["data"]));
}

class CategoryIncidents {
  final List<CategoryIncident>? items;
  final PhaseCounts? counts;
  final TimelinePagination? pagination;

  CategoryIncidents({this.items, this.counts, this.pagination});

  factory CategoryIncidents.fromJson(Map<String, dynamic> json) =>
      CategoryIncidents(items: json["items"] == null ? [] : List<CategoryIncident>.from(json["items"]!.map((x) => CategoryIncident.fromJson(x))), counts: json["counts"] == null ? null : PhaseCounts.fromJson(json["counts"]), pagination: json["pagination"] == null ? null : TimelinePagination.fromJson(json["pagination"]));
}

class CategoryIncident {
  final int? id;
  final String? title;
  final String? summary;
  final String? slug;
  final int? categoryId;
  final String? categorySlug;
  final String? categoryTitle;
  final String? incidentStatus;
  final String? severity;
  final String? locationName;
  final int? commentsCount;
  final String? publishedAt;
  final String? imageUrl;

  CategoryIncident({this.id, this.title, this.summary, this.slug, this.categoryId, this.categorySlug, this.categoryTitle, this.incidentStatus, this.severity, this.locationName, this.commentsCount, this.publishedAt, this.imageUrl});

  factory CategoryIncident.fromJson(Map<String, dynamic> json) => CategoryIncident(
    id: json["id"],
    title: json["title"],
    summary: json["summary"],
    slug: json["slug"],
    categoryId: json["category_id"],
    categorySlug: json["category_slug"],
    categoryTitle: json["category_title"],
    incidentStatus: json["incident_status"],
    severity: json["severity"]?.toString(),
    locationName: json["location_name"],
    commentsCount: json["comments_count"],
    publishedAt: json["published_at"],
    imageUrl: json["image_url"],
  );
}

class PhaseCounts {
  final int? active;
  final int? developing;
  final int? resolved;
  final int? all;

  PhaseCounts({this.active, this.developing, this.resolved, this.all});

  factory PhaseCounts.fromJson(Map<String, dynamic> json) => PhaseCounts(active: json["active"], developing: json["developing"], resolved: json["resolved"], all: json["all"]);

  int of(String phase) =>
      switch (phase) {
        'active' => active,
        'developing' => developing,
        'resolved' => resolved,
        _ => all,
      } ??
      0;
}
