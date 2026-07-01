import 'dart:convert';

HomeLocalResponse homeLocalResponseFromJson(String str) => HomeLocalResponse.fromJson(json.decode(str));


class HomeLocalResponse {
  final bool? success;
  final dynamic message;
  final HomeLocalData? data;

  HomeLocalResponse({
    this.success,
    this.message,
    this.data,
  });

  factory HomeLocalResponse.fromJson(Map<String, dynamic> json) => HomeLocalResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : HomeLocalData.fromJson(json["data"]),
  );

}

class HomeLocalData {
  final String? sectionGroup;
  final GarageAndMarketplace? garageAndMarketplace;
  final ExploreMore? exploreMore;
  final TownHistoryProject? townHistoryProject;

  HomeLocalData({
    this.sectionGroup,
    this.garageAndMarketplace,
    this.exploreMore,
    this.townHistoryProject,
  });

  factory HomeLocalData.fromJson(Map<String, dynamic> json) => HomeLocalData(
    sectionGroup: json["section_group"],
    garageAndMarketplace: json["garage_and_marketplace"] == null ? null : GarageAndMarketplace.fromJson(json["garage_and_marketplace"]),
    exploreMore: json["explore_more"] == null ? null : ExploreMore.fromJson(json["explore_more"]),
    townHistoryProject: json["town_history_project"] == null ? null : TownHistoryProject.fromJson(json["town_history_project"]),
  );

}

class ExploreMore {
  final String? title;
  final List<Item>? items;

  ExploreMore({
    this.title,
    this.items,
  });

  factory ExploreMore.fromJson(Map<String, dynamic> json) => ExploreMore(
    title: json["title"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

}

class Item {
  final String? label;
  final String? slug;

  Item({
    this.label,
    this.slug,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    label: json["label"],
    slug: json["slug"],
  );

}

class GarageAndMarketplace {
  final String? title;
  final List<dynamic>? featuredItems;
  final List<PopularItem>? popularItems;
  final NextGarageSale? nextGarageSale;

  GarageAndMarketplace({
    this.title,
    this.featuredItems,
    this.popularItems,
    this.nextGarageSale,
  });

  factory GarageAndMarketplace.fromJson(Map<String, dynamic> json) => GarageAndMarketplace(
    title: json["title"],
    featuredItems: json["featured_items"] == null ? [] : List<dynamic>.from(json["featured_items"]!.map((x) => x)),
    popularItems: json["popular_items"] == null ? [] : List<PopularItem>.from(json["popular_items"]!.map((x) => PopularItem.fromJson(x))),
    nextGarageSale: json["next_garage_sale"] == null ? null : NextGarageSale.fromJson(json["next_garage_sale"]),
  );

}

class NextGarageSale {
  final int? id;
  final String? description;
  final String? location;
  final DateTime? saleDate;
  final String? startTime;
  final String? endTime;

  NextGarageSale({
    this.id,
    this.description,
    this.location,
    this.saleDate,
    this.startTime,
    this.endTime,
  });

  factory NextGarageSale.fromJson(Map<String, dynamic> json) => NextGarageSale(
    id: json["id"],
    description: json["description"],
    location: json["location"],
    saleDate: json["sale_date"] == null ? null : DateTime.parse(json["sale_date"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
  );

}

class PopularItem {
  final int? id;
  final String? title;
  final String? description;
  final int? price;
  final String? priceLabel;
  final String? image;
  final bool? isFeatured;

  PopularItem({
    this.id,
    this.title,
    this.description,
    this.price,
    this.priceLabel,
    this.image,
    this.isFeatured,
  });

  factory PopularItem.fromJson(Map<String, dynamic> json) => PopularItem(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    priceLabel: json["price_label"],
    image: json["image"],
    isFeatured: json["is_featured"],
  );

}

class TownHistoryProject {
  final String? title;
  final Project? project;

  TownHistoryProject({
    this.title,
    this.project,
  });

  factory TownHistoryProject.fromJson(Map<String, dynamic> json) => TownHistoryProject(
    title: json["title"],
    project: json["project"] == null ? null : Project.fromJson(json["project"]),
  );

}

class Project {
  final int? historyId;
  final int? verifiedMemories;
  final int? sharedMemories;
  final int? contributors;
  final LatestMemory? latestMemory;

  Project({
    this.historyId,
    this.verifiedMemories,
    this.sharedMemories,
    this.contributors,
    this.latestMemory,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    historyId: json["history_id"],
    verifiedMemories: json["verified_memories"],
    sharedMemories: json["shared_memories"],
    contributors: json["contributors"],
    latestMemory: json["latest_memory"] == null ? null : LatestMemory.fromJson(json["latest_memory"]),
  );

}

class LatestMemory {
  final int? id;
  final String? image;
  final String? caption;
  final int? historyYear;

  LatestMemory({
    this.id,
    this.image,
    this.caption,
    this.historyYear,
  });

  factory LatestMemory.fromJson(Map<String, dynamic> json) => LatestMemory(
    id: json["id"],
    image: json["image"],
    caption: json["caption"],
    historyYear: json["history_year"],
  );

}
