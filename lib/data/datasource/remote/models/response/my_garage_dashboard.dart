import 'dart:convert';

MyGarageDashboardResponse myGarageDashboardResponseFromJson(String str) => MyGarageDashboardResponse.fromJson(json.decode(str));

class MyGarageDashboardResponse {
  final bool? success;
  final String? message;
  final GarageDashboardData? data;

  MyGarageDashboardResponse({this.success, this.message, this.data});

  factory MyGarageDashboardResponse.fromJson(Map<String, dynamic> json) => MyGarageDashboardResponse(success: json["success"], message: json["message"], data: json["data"] == null ? null : GarageDashboardData.fromJson(json["data"]));
}

class GarageDashboardData {
  final Counts? counts;
  final String? location;
  final Sections? sections;
  final Assistant? assistant;
  final BestMoves? bestMoves;
  final AiBrief? aiBrief;
  final Inventory? inventory;

  GarageDashboardData({this.counts, this.location, this.sections, this.assistant, this.bestMoves, this.aiBrief, this.inventory});

  factory GarageDashboardData.fromJson(Map<String, dynamic> json) => GarageDashboardData(
    counts: json["counts"] == null ? null : Counts.fromJson(json["counts"]),
    location: json["location"],
    sections: json["sections"] == null ? null : Sections.fromJson(json["sections"]),
    assistant: json["assistant"] == null ? null : Assistant.fromJson(json["assistant"]),
    bestMoves: json["best_moves"] == null ? null : BestMoves.fromJson(json["best_moves"]),
    aiBrief: json["ai_brief"] == null ? null : AiBrief.fromJson(json["ai_brief"]),
    inventory: json["inventory"] == null ? null : Inventory.fromJson(json["inventory"]),
  );
}

class AiBrief {
  final bool? eligible;
  final DateTime? version;

  AiBrief({this.eligible, this.version});

  factory AiBrief.fromJson(Map<String, dynamic> json) => AiBrief(eligible: json["eligible"], version: json["version"] == null ? null : DateTime.parse(json["version"]));
}

class Assistant {
  final List<String>? suggestedQuestions;

  Assistant({this.suggestedQuestions});

  factory Assistant.fromJson(Map<String, dynamic> json) => Assistant(suggestedQuestions: json["suggested_questions"] == null ? [] : List<String>.from(json["suggested_questions"]!.map((x) => x)));
}

class BestMoves {
  final CompleteDraft? priceReview;
  final CompleteDraft? completeDraft;
  final CompleteDraft? inventoryReview;

  BestMoves({this.priceReview, this.completeDraft, this.inventoryReview});

  factory BestMoves.fromJson(Map<String, dynamic> json) =>
      BestMoves(priceReview: json["price_review"] == null ? null : CompleteDraft.fromJson(json["price_review"]), completeDraft: json["complete_draft"] == null ? null : CompleteDraft.fromJson(json["complete_draft"]), inventoryReview: json["inventory_review"] == null ? null : CompleteDraft.fromJson(json["inventory_review"]));
}

class CompleteDraft {
  final String? title;
  final String? description;
  final CompleteDraftItem? item;
  final CompleteDraftAction? action;

  CompleteDraft({this.title, this.description, this.item, this.action});

  factory CompleteDraft.fromJson(Map<String, dynamic> json) => CompleteDraft(title: json["title"], description: json["description"], item: json["item"] == null ? null : CompleteDraftItem.fromJson(json["item"]), action: json["action"] == null ? null : CompleteDraftAction.fromJson(json["action"]));
}

class CompleteDraftAction {
  final String? type;
  final String? label;
  final bool? enabled;

  CompleteDraftAction({this.type, this.label, this.enabled});

  factory CompleteDraftAction.fromJson(Map<String, dynamic> json) => CompleteDraftAction(type: json["type"], label: json["label"], enabled: json["enabled"]);
}

class CompleteDraftItem {
  final int? id;
  final String? title;
  final int? price;
  final String? imageUrl;

  CompleteDraftItem({this.id, this.title, this.price, this.imageUrl});

  factory CompleteDraftItem.fromJson(Map<String, dynamic> json) => CompleteDraftItem(id: json["id"], title: json["title"], price: json["price"], imageUrl: json["image_url"]);
}

class Counts {
  final int? totalItems;
  final int? activeCount;
  final int? draftCount;
  final int? soldCount;
  final int? expiredCount;
  final int? estimatedValue;
  final int? activeValue;
  final int? draftValue;
  final int? lifetimeEarned;

  Counts({this.totalItems, this.activeCount, this.draftCount, this.soldCount, this.expiredCount, this.estimatedValue, this.activeValue, this.draftValue, this.lifetimeEarned});

  factory Counts.fromJson(Map<String, dynamic> json) =>
      Counts(totalItems: json["total_items"], activeCount: json["active_count"], draftCount: json["draft_count"], soldCount: json["sold_count"], expiredCount: json["expired_count"], estimatedValue: json["estimated_value"], activeValue: json["active_value"], draftValue: json["draft_value"], lifetimeEarned: json["lifetime_earned"]);
}

class Inventory {
  final List<ItemElement>? items;
  final Pagination? pagination;
  final Filters? filters;
  final Counts? counts;

  Inventory({this.items, this.pagination, this.filters, this.counts});

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
    items: json["items"] == null ? [] : List<ItemElement>.from(json["items"]!.map((x) => ItemElement.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    filters: json["filters"] == null ? null : Filters.fromJson(json["filters"]),
    counts: json["counts"] == null ? null : Counts.fromJson(json["counts"]),
  );
}

class Filters {
  final String? tab;
  final String? sort;

  Filters({this.tab, this.sort});

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(tab: json["tab"], sort: json["sort"]);
}

class ItemElement {
  final int? id;
  final String? title;
  final String? brand;
  final int? price;
  final dynamic soldPrice;
  final int? status;
  final bool? isSold;
  final bool? isFeatured;
  final String? itemCondition;
  final String? imageUrl;
  final String? cityName;
  final String? categoryTitle;
  final int? totalViews;
  final int? totalSaves;
  final String? createdAt;
  final String? updatedAt;

  ItemElement({this.id, this.title, this.brand, this.price, this.soldPrice, this.status, this.isSold, this.isFeatured, this.itemCondition, this.imageUrl, this.cityName, this.categoryTitle, this.totalViews, this.totalSaves, this.createdAt, this.updatedAt});

  factory ItemElement.fromJson(Map<String, dynamic> json) => ItemElement(
    id: json["id"],
    title: json["title"],
    brand: json["brand"],
    price: json["price"],
    soldPrice: json["sold_price"],
    status: json["status"],
    isSold: json["is_sold"],
    isFeatured: json["is_featured"],
    itemCondition: json["item_condition"],
    imageUrl: json["image_url"],
    cityName: json["city_name"],
    categoryTitle: json["category_title"],
    totalViews: json["total_views"],
    totalSaves: json["total_saves"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}

class Pagination {
  final int? currentPage;
  final int? perPage;
  final int? total;
  final int? lastPage;
  final int? from;
  final int? to;

  Pagination({this.currentPage, this.perPage, this.total, this.lastPage, this.from, this.to});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(currentPage: json["current_page"], perPage: json["per_page"], total: json["total"], lastPage: json["last_page"], from: json["from"], to: json["to"]);
}

class Sections {
  final ValueOverview? valueOverview;
  final SellerProfile? sellerProfile;
  final MarketingBrief? marketingBrief;
  final TopSellers? topSellers;

  Sections({this.valueOverview, this.sellerProfile, this.marketingBrief, this.topSellers});

  factory Sections.fromJson(Map<String, dynamic> json) => Sections(
    valueOverview: json["value_overview"] == null ? null : ValueOverview.fromJson(json["value_overview"]),
    sellerProfile: json["seller_profile"] == null ? null : SellerProfile.fromJson(json["seller_profile"]),
    marketingBrief: json["marketing_brief"] == null ? null : MarketingBrief.fromJson(json["marketing_brief"]),
    topSellers: json["top_sellers"] == null ? null : TopSellers.fromJson(json["top_sellers"]),
  );
}

class MarketingBrief {
  final String? title;
  final String? description;
  final int? insightCount;
  final String? insightLabel;
  final String? status;
  final List<Card>? cards;
  final MarketingBriefAction? action;

  MarketingBrief({this.title, this.description, this.insightCount, this.insightLabel, this.status, this.cards, this.action});

  factory MarketingBrief.fromJson(Map<String, dynamic> json) => MarketingBrief(
    title: json["title"],
    description: json["description"],
    insightCount: json["insight_count"],
    insightLabel: json["insight_label"],
    status: json["status"],
    cards: json["cards"] == null ? [] : List<Card>.from(json["cards"]!.map((x) => Card.fromJson(x))),
    action: json["action"] == null ? null : MarketingBriefAction.fromJson(json["action"]),
  );
}

class MarketingBriefAction {
  final String? label;
  final String? title;
  final String? description;
  final String? body;

  MarketingBriefAction({this.label, this.title, this.description, this.body});

  factory MarketingBriefAction.fromJson(Map<String, dynamic> json) => MarketingBriefAction(label: json["label"], title: json["title"], description: json["description"], body: json["body"]);
}

class Card {
  final String? key;
  final String? title;
  final String? description;
  final String? icon;
  final String? tone;
  final List<dynamic>? items;
  final int? count;
  final String? emptyMessage;
  final CardAction? action;

  Card({this.key, this.title, this.description, this.icon, this.tone, this.items, this.count, this.emptyMessage, this.action});

  factory Card.fromJson(Map<String, dynamic> json) =>
      Card(key: json["key"], title: json["title"], description: json["description"], icon: json["icon"], tone: json["tone"], items: json["items"] == null ? [] : List<dynamic>.from(json["items"]!.map((x) => x)), count: json["count"], emptyMessage: json["empty_message"], action: json["action"] == null ? null : CardAction.fromJson(json["action"]));
}

class CardAction {
  final String? label;
  final String? target;

  CardAction({this.label, this.target});

  factory CardAction.fromJson(Map<String, dynamic> json) => CardAction(label: json["label"], target: json["target"]);
}

class SellerProfile {
  final String? title;
  final String? name;
  final String? imageUrl;
  final String? location;
  final String? salesLabel;
  final String? activityLabel;
  final List<String>? details;
  final String? callout;
  final MarketingBriefAction? action;

  SellerProfile({this.title, this.name, this.imageUrl, this.location, this.salesLabel, this.activityLabel, this.details, this.callout, this.action});

  factory SellerProfile.fromJson(Map<String, dynamic> json) => SellerProfile(
    title: json["title"],
    name: json["name"],
    imageUrl: json["image_url"],
    location: json["location"],
    salesLabel: json["sales_label"],
    activityLabel: json["activity_label"],
    details: json["details"] == null ? [] : List<String>.from(json["details"]!.map((x) => x)),
    callout: json["callout"],
    action: json["action"] == null ? null : MarketingBriefAction.fromJson(json["action"]),
  );
}

class TopSellers {
  final String? title;
  final int? cityId;
  final String? defaultSort;
  final int? limit;
  final List<Filter>? filters;
  final Rankings? rankings;
  final String? emptyMessage;
  final String? description;
  final String? ratingNote;

  TopSellers({this.title, this.cityId, this.defaultSort, this.limit, this.filters, this.rankings, this.emptyMessage, this.description, this.ratingNote});

  factory TopSellers.fromJson(Map<String, dynamic> json) => TopSellers(
    title: json["title"],
    cityId: json["city_id"],
    defaultSort: json["default_sort"],
    limit: json["limit"],
    filters: json["filters"] == null ? [] : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
    rankings: json["rankings"] == null ? null : Rankings.fromJson(json["rankings"]),
    emptyMessage: json["empty_message"],
    description: json["description"],
    ratingNote: json["rating_note"],
  );
}

class Filter {
  final String? key;
  final String? label;
  final bool? enabled;

  Filter({this.key, this.label, this.enabled});

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(key: json["key"], label: json["label"], enabled: json["enabled"]);
}

class Rankings {
  final List<Sale>? sales;
  final List<Sale>? speed;

  Rankings({this.sales, this.speed});

  factory Rankings.fromJson(Map<String, dynamic> json) => Rankings(sales: json["sales"] == null ? [] : List<Sale>.from(json["sales"]!.map((x) => Sale.fromJson(x))), speed: json["speed"] == null ? [] : List<Sale>.from(json["speed"]!.map((x) => Sale.fromJson(x))));
}

class Sale {
  final int? userId;
  final int? rank;
  final String? label;
  final bool? isCurrentUser;
  final String? imageUrl;
  final String? initials;
  final int? salesCount;
  final String? salesLabel;
  final double? averageDaysToSell;
  final String? speedLabel;
  final String? scoreLabel;
  final dynamic rating;
  final String? ratingLabel;

  Sale({this.userId, this.rank, this.label, this.isCurrentUser, this.imageUrl, this.initials, this.salesCount, this.salesLabel, this.averageDaysToSell, this.speedLabel, this.scoreLabel, this.rating, this.ratingLabel});

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
    userId: json["user_id"],
    rank: json["rank"],
    label: json["label"],
    isCurrentUser: json["is_current_user"],
    imageUrl: json["image_url"],
    initials: json["initials"],
    salesCount: json["sales_count"],
    salesLabel: json["sales_label"],
    averageDaysToSell: json["average_days_to_sell"]?.toDouble(),
    speedLabel: json["speed_label"],
    scoreLabel: json["score_label"],
    rating: json["rating"],
    ratingLabel: json["rating_label"],
  );
}

class ValueOverview {
  final String? currency;
  final CashOpportunity? cashOpportunity;
  final CashOpportunity? listingReview;
  final GarageValue? garageValue;

  ValueOverview({this.currency, this.cashOpportunity, this.listingReview, this.garageValue});

  factory ValueOverview.fromJson(Map<String, dynamic> json) => ValueOverview(
    currency: json["currency"],
    cashOpportunity: json["cash_opportunity"] == null ? null : CashOpportunity.fromJson(json["cash_opportunity"]),
    listingReview: json["listing_review"] == null ? null : CashOpportunity.fromJson(json["listing_review"]),
    garageValue: json["garage_value"] == null ? null : GarageValue.fromJson(json["garage_value"]),
  );
}

class CashOpportunity {
  final String? title;
  final String? description;
  final int? value;
  final String? formattedValue;
  final List<Metric>? metrics;
  final List<BarSegment>? barSegments;
  final CardAction? action;

  CashOpportunity({this.title, this.description, this.value, this.formattedValue, this.metrics, this.barSegments, this.action});

  factory CashOpportunity.fromJson(Map<String, dynamic> json) => CashOpportunity(
    title: json["title"],
    description: json["description"],
    value: json["value"],
    formattedValue: json["formatted_value"],
    metrics: json["metrics"] == null ? [] : List<Metric>.from(json["metrics"]!.map((x) => Metric.fromJson(x))),
    barSegments: json["bar_segments"] == null ? [] : List<BarSegment>.from(json["bar_segments"]!.map((x) => BarSegment.fromJson(x))),
    action: json["action"] == null ? null : CardAction.fromJson(json["action"]),
  );
}

class BarSegment {
  final String? key;
  final double? percentage;

  BarSegment({this.key, this.percentage});

  factory BarSegment.fromJson(Map<String, dynamic> json) => BarSegment(key: json["key"], percentage: json["percentage"]?.toDouble());
}

class Metric {
  final String? key;
  final String? label;
  final int? value;
  final String? description;
  final String? icon;
  final String? tone;
  final String? formattedValue;

  Metric({this.key, this.label, this.value, this.description, this.icon, this.tone, this.formattedValue});

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(key: json["key"], label: json["label"], value: json["value"], description: json["description"], icon: json["icon"], tone: json["tone"], formattedValue: json["formatted_value"]);
}

class GarageValue {
  final String? title;
  final List<Metric>? metrics;

  GarageValue({this.title, this.metrics});

  factory GarageValue.fromJson(Map<String, dynamic> json) => GarageValue(title: json["title"], metrics: json["metrics"] == null ? [] : List<Metric>.from(json["metrics"]!.map((x) => Metric.fromJson(x))));
}
