import 'dart:convert';

MarketPlaceResponse marketPlaceResponseFromJson(String str) => MarketPlaceResponse.fromJson(json.decode(str));


class MarketPlaceResponse {
  final bool? success;
  final String? message;
  final MarketPlaceData? data;

  MarketPlaceResponse({
    this.success,
    this.message,
    this.data,
  });

  factory MarketPlaceResponse.fromJson(Map<String, dynamic> json) => MarketPlaceResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : MarketPlaceData.fromJson(json["data"]),
  );
}

class MarketPlaceData {
  final List<MarketPlaceItem>? items;
  final Pagination? pagination;

  MarketPlaceData({
    this.items,
    this.pagination,
  });

  factory MarketPlaceData.fromJson(Map<String, dynamic> json) => MarketPlaceData(
    items: json["items"] == null ? [] : List<MarketPlaceItem>.from(json["items"]!.map((x) => MarketPlaceItem.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class MarketPlaceItem {
  final int? id;
  final String? title;
  final int? price;
  final int? previousPrice;
  final int? discountPercent;
  final int? categoryId;
  final int? conditionId;
  final String? imageUrl;
  final String? fallbackImageUrl;
  final String? url;
  final String? location;
  final dynamic distanceMiles;
  final String? createdAt;
  final String? timeLabel;
  final int? views;
  final int? saves;
  final bool? saved;

  MarketPlaceItem({
    this.id,
    this.title,
    this.previousPrice,
    this.discountPercent,
    this.price,
    this.categoryId,
    this.conditionId,
    this.imageUrl,
    this.fallbackImageUrl,
    this.url,
    this.location,
    this.distanceMiles,
    this.createdAt,
    this.timeLabel,
    this.views,
    this.saves,
    this.saved,
  });

  factory MarketPlaceItem.fromJson(Map<String, dynamic> json) => MarketPlaceItem(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    categoryId: json["category_id"],
    conditionId: json["condition_id"],
    imageUrl: json["image_url"] ?? '',
    fallbackImageUrl: json["fallback_image_url"],
    url: json["url"],
    location: json["location"],
    distanceMiles: json["distance_miles"],
    createdAt: json["created_at"],
    timeLabel: json["time_label"],
    views: json["views"],
    saves: json["saves"],
    saved: json["saved"],
    previousPrice: json['previous_price'],
    discountPercent: json['discount_percent'],
  );
}

class Pagination {
  final int? total;
  final int? currentPage;
  final int? perPage;
  final int? lastPage;
  final int? from;
  final int? to;

  Pagination({
    this.total,
    this.currentPage,
    this.perPage,
    this.lastPage,
    this.from,
    this.to,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    currentPage: json["current_page"],
    perPage: json["per_page"],
    lastPage: json["last_page"],
    from: json["from"],
    to: json["to"],
  );
}

