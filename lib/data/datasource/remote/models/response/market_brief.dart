import 'dart:convert';

MarketBriefResponse marketBriefResponseFromJson(String str) => MarketBriefResponse.fromJson(json.decode(str));

class MarketBriefResponse {
  final bool? success;
  final String? message;
  final MarketBriefData? data;

  MarketBriefResponse({
    this.success,
    this.message,
    this.data,
  });

  factory MarketBriefResponse.fromJson(Map<String, dynamic> json) => MarketBriefResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : MarketBriefData.fromJson(json["data"]),
  );
}

class MarketBriefData {
  final String? updatedAt;
  final Stats? stats;
  final List<Category>? categories;
  final List<Holiday>? holidays;
  final List<dynamic>? sales;
  final Town? town;
  final List<QuickLink>? quickLinks;
  final List<SellingTip>? sellingTips;
  final Eco? eco;
  final List<Seasonality>? seasonality;

  MarketBriefData({
    this.updatedAt,
    this.stats,
    this.categories,
    this.holidays,
    this.sales,
    this.town,
    this.quickLinks,
    this.sellingTips,
    this.eco,
    this.seasonality,
  });

  factory MarketBriefData.fromJson(Map<String, dynamic> json) => MarketBriefData(
    updatedAt: json["updated_at"],
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    holidays: json["holidays"] == null ? [] : List<Holiday>.from(json["holidays"]!.map((x) => Holiday.fromJson(x))),
    sales: json["sales"] == null ? [] : List<dynamic>.from(json["sales"]!.map((x) => x)),
    town: json["town"] == null ? null : Town.fromJson(json["town"]),
    quickLinks: json["quick_links"] == null ? [] : List<QuickLink>.from(json["quick_links"]!.map((x) => QuickLink.fromJson(x))),
    sellingTips: json["selling_tips"] == null ? [] : List<SellingTip>.from(json["selling_tips"]!.map((x) => SellingTip.fromJson(x))),
    eco: json["eco"] == null ? null : Eco.fromJson(json["eco"]),
    seasonality: json["seasonality"] == null ? [] : List<Seasonality>.from(json["seasonality"]!.map((x) => Seasonality.fromJson(x))),
  );
}

class Category {
  final int? id;
  final String? title;
  final int? active;
  final dynamic growthPercent;
  final int? currentPrice;
  final dynamic previousPrice;

  Category({
    this.id,
    this.title,
    this.active,
    this.growthPercent,
    this.currentPrice,
    this.previousPrice,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    active: json["active"],
    growthPercent: json["growth_percent"],
    currentPrice: json["current_price"],
    previousPrice: json["previous_price"],
  );
}

class Eco {
  final String? title;
  final String? description;
  final String? icon;
  final String? linkLabel;
  final String? href;

  Eco({
    this.title,
    this.description,
    this.icon,
    this.linkLabel,
    this.href,
  });

  factory Eco.fromJson(Map<String, dynamic> json) => Eco(
    title: json["title"],
    description: json["description"],
    icon: json["icon"],
    linkLabel: json["link_label"],
    href: json["href"],
  );

}

class Holiday {
  final int? id;
  final String? title;
  final String? date;
  final String? suggestions;
  final String? demandLabel;
  final String? demandIcon;
  final String? demandTone;
  final String? demandNote;

  Holiday({
    this.id,
    this.title,
    this.date,
    this.suggestions,
    this.demandLabel,
    this.demandIcon,
    this.demandTone,
    this.demandNote,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    suggestions: json["suggestions"],
    demandLabel: json["demand_label"],
    demandIcon: json["demand_icon"],
    demandTone: json["demand_tone"],
    demandNote: json["demand_note"],
  );

}

class QuickLink {
  final String? label;
  final String? icon;
  final String? href;

  QuickLink({
    this.label,
    this.icon,
    this.href,
  });

  factory QuickLink.fromJson(Map<String, dynamic> json) => QuickLink(
    label: json["label"],
    icon: json["icon"],
    href: json["href"],
  );

}

class Seasonality {
  final String? key;
  final String? title;
  final String? period;
  final String? icon;
  final String? image;
  final String? imageAlt;
  final List<String>? points;
  final String? status;
  final String? statusIcon;

  Seasonality({
    this.key,
    this.title,
    this.period,
    this.icon,
    this.image,
    this.imageAlt,
    this.points,
    this.status,
    this.statusIcon,
  });

  factory Seasonality.fromJson(Map<String, dynamic> json) => Seasonality(
    key: json["key"],
    title: json["title"],
    period: json["period"],
    icon: json["icon"],
    image: json["image"],
    imageAlt: json["image_alt"],
    points: json["points"] == null ? [] : List<String>.from(json["points"]!.map((x) => x)),
    status: json["status"],
    statusIcon: json["status_icon"],
  );

}

class SellingTip {
  final String? icon;
  final String? title;
  final String? description;

  SellingTip({
    this.icon,
    this.title,
    this.description,
  });

  factory SellingTip.fromJson(Map<String, dynamic> json) => SellingTip(
    icon: json["icon"],
    title: json["title"],
    description: json["description"],
  );
}

class Stats {
  final int? active;
  final double? averagePrice;
  final int? soldWeek;
  final int? newMonth;
  final int? newPreviousMonth;
  final dynamic priceDrops;

  Stats({
    this.active,
    this.averagePrice,
    this.soldWeek,
    this.newMonth,
    this.newPreviousMonth,
    this.priceDrops,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    active: json["active"],
    averagePrice: json["average_price"]?.toDouble(),
    soldWeek: json["sold_week"],
    newMonth: json["new_month"],
    newPreviousMonth: json["new_previous_month"],
    priceDrops: json["price_drops"],
  );
}

class Town {
  final int? id;
  final String? name;

  Town({
    this.id,
    this.name,
  });

  factory Town.fromJson(Map<String, dynamic> json) => Town(
    id: json["id"],
    name: json["name"]);

}
