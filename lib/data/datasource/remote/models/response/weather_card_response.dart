import 'dart:convert';

WeatherCardsResponse weatherCardsResponseFromJson(String str) => WeatherCardsResponse.fromJson(json.decode(str));


class WeatherCardsResponse {
  final bool? success;
  final String? message;
  final WeatherCardData? data;

  WeatherCardsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory WeatherCardsResponse.fromJson(Map<String, dynamic> json) => WeatherCardsResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : WeatherCardData.fromJson(json["data"]),
  );

}

class WeatherCardData {
  final City? city;
  final DateTime? updatedAt;
  final Environment? environment;
  final CurrentConditions? currentConditions;
  final Cards? cards;
  final Source? source;

  WeatherCardData({
    this.city,
    this.updatedAt,
    this.environment,
    this.currentConditions,
    this.cards,
    this.source,
  });

  factory WeatherCardData.fromJson(Map<String, dynamic> json) => WeatherCardData(
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    environment: json["environment"] == null ? null : Environment.fromJson(json["environment"]),
    currentConditions: json["current_conditions"] == null ? null : CurrentConditions.fromJson(json["current_conditions"]),
    cards: json["cards"] == null ? null : Cards.fromJson(json["cards"]),
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
  );

}

class Cards {
  final List<HourlyForecast>? hourlyForecast;
  final List<SevenDayOutlook>? sevenDayOutlook;
  final SportsWeather? sportsWeather;
  final List<OutdoorSnapshot>? outdoorSnapshot;
  final CommuteSchool? commuteSchool;
  final List<OutdoorLifePlanner>? outdoorLifePlanner;
  final PollenForecast? pollenForecast;
  final AdventureGuide? aroundTheHouse;
  final AdventureGuide? adventureGuide;
  final WeatherAiGuide? weatherAiGuide;
  final LocalSpotlight? localSpotlight;
  final CommunityOutdoorFeed? communityOutdoorFeed;
  final WeatherDiscussions? weatherDiscussions;
  final WeatherImpactMap? weatherImpactMap;

  Cards({
    this.hourlyForecast,
    this.sevenDayOutlook,
    this.sportsWeather,
    this.outdoorSnapshot,
    this.commuteSchool,
    this.outdoorLifePlanner,
    this.pollenForecast,
    this.aroundTheHouse,
    this.adventureGuide,
    this.weatherAiGuide,
    this.localSpotlight,
    this.communityOutdoorFeed,
    this.weatherDiscussions,
    this.weatherImpactMap,
  });

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
    hourlyForecast: json["hourly_forecast"] == null ? [] : List<HourlyForecast>.from(json["hourly_forecast"]!.map((x) => HourlyForecast.fromJson(x))),
    sevenDayOutlook: json["seven_day_outlook"] == null ? [] : List<SevenDayOutlook>.from(json["seven_day_outlook"]!.map((x) => SevenDayOutlook.fromJson(x))),
    sportsWeather: json["sports_weather"] == null ? null : SportsWeather.fromJson(json["sports_weather"]),
    outdoorSnapshot: json["outdoor_snapshot"] == null ? [] : List<OutdoorSnapshot>.from(json["outdoor_snapshot"]!.map((x) => OutdoorSnapshot.fromJson(x))),
    commuteSchool: json["commute_school"] == null ? null : CommuteSchool.fromJson(json["commute_school"]),
    outdoorLifePlanner: json["outdoor_life_planner"] == null ? [] : List<OutdoorLifePlanner>.from(json["outdoor_life_planner"]!.map((x) => OutdoorLifePlanner.fromJson(x))),
    pollenForecast: json["pollen_forecast"] == null ? null : PollenForecast.fromJson(json["pollen_forecast"]),
    aroundTheHouse: json["around_the_house"] == null ? null : AdventureGuide.fromJson(json["around_the_house"]),
    adventureGuide: json["adventure_guide"] == null ? null : AdventureGuide.fromJson(json["adventure_guide"]),
    weatherAiGuide: json["weather_ai_guide"] == null ? null : WeatherAiGuide.fromJson(json["weather_ai_guide"]),
    localSpotlight: json["local_spotlight"] == null ? null : LocalSpotlight.fromJson(json["local_spotlight"]),
    communityOutdoorFeed: json["community_outdoor_feed"] == null ? null : CommunityOutdoorFeed.fromJson(json["community_outdoor_feed"]),
    weatherDiscussions: json["weather_discussions"] == null ? null : WeatherDiscussions.fromJson(json["weather_discussions"]),
    weatherImpactMap: json["weather_impact_map"] == null ? null : WeatherImpactMap.fromJson(json["weather_impact_map"]),
  );

}

class AdventureGuide {
  final String? title;
  final String? subtitle;
  final String? basis;
  final List<AdventureGuideItem>? items;
  final String? linkLabel;
  final String? linkUrl;

  AdventureGuide({
    this.title,
    this.subtitle,
    this.basis,
    this.items,
    this.linkLabel,
    this.linkUrl,
  });

  factory AdventureGuide.fromJson(Map<String, dynamic> json) => AdventureGuide(
    title: json["title"],
    subtitle: json["subtitle"],
    basis: json["basis"],
    items: json["items"] == null ? [] : List<AdventureGuideItem>.from(json["items"]!.map((x) => AdventureGuideItem.fromJson(x))),
    linkLabel: json["link_label"],
    linkUrl: json["link_url"],
  );

}

class AdventureGuideItem {
  final String? key;
  final String? label;
  final String? icon;
  final String? status;
  final String? statusKey;
  final bool? suitable;
  final double? score;
  final String? reason;
  final BestTime? bestTime;

  AdventureGuideItem({
    this.key,
    this.label,
    this.icon,
    this.status,
    this.statusKey,
    this.suitable,
    this.score,
    this.reason,
    this.bestTime,
  });

  factory AdventureGuideItem.fromJson(Map<String, dynamic> json) => AdventureGuideItem(
    key: json["key"],
    label: json["label"],
    icon: json["icon"],
    status: json["status"],
    statusKey: json["status_key"],
    suitable: json["suitable"],
    score: json["score"]?.toDouble(),
    reason: json["reason"],
    bestTime: json["best_time"] == null ? null : BestTime.fromJson(json["best_time"]),
  );

}

class BestTime {
  final String? startTime;
  final String? endTime;
  final int? durationMinutes;

  BestTime({
    this.startTime,
    this.endTime,
    this.durationMinutes,
  });

  factory BestTime.fromJson(Map<String, dynamic> json) => BestTime(
    startTime: json["start_time"],
    endTime: json["end_time"],
    durationMinutes: json["duration_minutes"],
  );

}


class CommunityOutdoorFeed {
  final String? title;
  final String? subtitle;
  final bool? isPlaceholderData;
  final int? categoryId;
  final int? itemType;
  final int? townId;
  final String? viewAllLabel;
  final String? viewAllUrl;
  final List<CommunityOutdoorFeedItem>? items;
  final String? emptyMessage;

  CommunityOutdoorFeed({
    this.title,
    this.subtitle,
    this.isPlaceholderData,
    this.categoryId,
    this.itemType,
    this.townId,
    this.viewAllLabel,
    this.viewAllUrl,
    this.items,
    this.emptyMessage,
  });

  factory CommunityOutdoorFeed.fromJson(Map<String, dynamic> json) => CommunityOutdoorFeed(
    title: json["title"],
    subtitle: json["subtitle"],
    isPlaceholderData: json["is_placeholder_data"],
    categoryId: json["category_id"],
    itemType: json["item_type"],
    townId: json["town_id"],
    viewAllLabel: json["view_all_label"],
    viewAllUrl: json["view_all_url"],
    items: json["items"] == null ? [] : List<CommunityOutdoorFeedItem>.from(json["items"]!.map((x) => CommunityOutdoorFeedItem.fromJson(x))),
    emptyMessage: json["empty_message"],
  );

}

class CommunityOutdoorFeedItem {
  final String? id;
  final int? conversationId;
  final String? image;
  final String? title;
  final String? userName;
  final String? postedLabel;
  final int? likesCount;
  final String? url;

  CommunityOutdoorFeedItem({
    this.id,
    this.conversationId,
    this.image,
    this.title,
    this.userName,
    this.postedLabel,
    this.likesCount,
    this.url,
  });

  factory CommunityOutdoorFeedItem.fromJson(Map<String, dynamic> json) => CommunityOutdoorFeedItem(
    id: json["id"],
    conversationId: json["conversation_id"],
    image: json["image"],
    title: json["title"],
    userName: json["user_name"],
    postedLabel: json["posted_label"],
    likesCount: json["likes_count"],
    url: json["url"],
  );

}

class CommuteSchool {
  final String? title;
  final String? subtitle;
  final String? basis;
  final int? schoolCount;
  final DateTime? schoolDate;
  final String? disclaimer;
  final List<CommuteSchoolItem>? items;
  final String? linkLabel;
  final String? linkUrl;

  CommuteSchool({
    this.title,
    this.subtitle,
    this.basis,
    this.schoolCount,
    this.schoolDate,
    this.disclaimer,
    this.items,
    this.linkLabel,
    this.linkUrl,
  });

  factory CommuteSchool.fromJson(Map<String, dynamic> json) => CommuteSchool(
    title: json["title"],
    subtitle: json["subtitle"],
    basis: json["basis"],
    schoolCount: json["school_count"],
    schoolDate: json["school_date"] == null ? null : DateTime.parse(json["school_date"]),
    disclaimer: json["disclaimer"],
    items: json["items"] == null ? [] : List<CommuteSchoolItem>.from(json["items"]!.map((x) => CommuteSchoolItem.fromJson(x))),
    linkLabel: json["link_label"],
    linkUrl: json["link_url"],
  );

}

class CommuteSchoolItem {
  final String? key;
  final String? label;
  final String? icon;
  final String? status;
  final String? statusKey;
  final String? reason;

  CommuteSchoolItem({
    this.key,
    this.label,
    this.icon,
    this.status,
    this.statusKey,
    this.reason,
  });

  factory CommuteSchoolItem.fromJson(Map<String, dynamic> json) => CommuteSchoolItem(
    key: json["key"],
    label: json["label"],
    icon: json["icon"],
    status: json["status"],
    statusKey: json["status_key"],
    reason: json["reason"],
  );

}

class HourlyForecast {
  final DateTime? startsAt;
  final String? time;
  final String? displayTime;
  final Visibility? temperature;
  final int? precipitationProbabilityPercent;
  final HourlyForecastCondition? condition;
  final bool? isDaytime;

  HourlyForecast({
    this.startsAt,
    this.time,
    this.displayTime,
    this.temperature,
    this.precipitationProbabilityPercent,
    this.condition,
    this.isDaytime,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) => HourlyForecast(
    startsAt: json["starts_at"] == null ? null : DateTime.parse(json["starts_at"]),
    time: json["time"],
    displayTime: json["display_time"],
    temperature: json["temperature"] == null ? null : Visibility.fromJson(json["temperature"]),
    precipitationProbabilityPercent: json["precipitation_probability_percent"],
    condition: json["condition"] == null ? null : HourlyForecastCondition.fromJson(json["condition"]),
    isDaytime: json["is_daytime"],
  );

}

class HourlyForecastCondition {
  final String? label;
  final dynamic code;
  final Icon? icon;

  HourlyForecastCondition({
    this.label,
    this.code,
    this.icon,
  });

  factory HourlyForecastCondition.fromJson(Map<String, dynamic> json) => HourlyForecastCondition(
    label: json["label"],
    code: json["code"],
    icon: json["icon"] == null ? null : Icon.fromJson(json["icon"]),
  );

}

class Icon {
  final String? format;
  final String? symbol;
  final String? path;

  Icon({
    this.format,
    this.symbol,
    this.path,
  });

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
    format: json["format"],
    symbol: json["symbol"],
    path: json["path"],
  );
}

class Visibility {
  final double? value;
  final String? unit;

  Visibility({
    this.value,
    this.unit,
  });

  factory Visibility.fromJson(Map<String, dynamic> json) => Visibility(
    value: json["value"]?.toDouble(),
    unit: json["unit"],
  );

}


class LocalSpotlight {
  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? url;

  LocalSpotlight({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.url,
  });

  factory LocalSpotlight.fromJson(Map<String, dynamic> json) => LocalSpotlight(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["image_url"],
    url: json["url"],
  );

}

class OutdoorLifePlanner {
  final String? activity;
  final String? name;
  final String? icon;
  final double? weatherScore;
  final double? displayScore;
  final bool? suitable;
  final String? status;
  final dynamic reason;
  final BestTime? bestTime;
  final OutdoorLifePlannerCondition? condition;
  final String? summary;

  OutdoorLifePlanner({
    this.activity,
    this.name,
    this.icon,
    this.weatherScore,
    this.displayScore,
    this.suitable,
    this.status,
    this.reason,
    this.bestTime,
    this.condition,
    this.summary,
  });

  factory OutdoorLifePlanner.fromJson(Map<String, dynamic> json) => OutdoorLifePlanner(
    activity: json["activity"],
    name: json["name"],
    icon: json["icon"],
    weatherScore: json["weather_score"]?.toDouble(),
    displayScore: json["display_score"]?.toDouble(),
    suitable: json["suitable"],
    status: json["status"],
    reason: json["reason"],
    bestTime: json["best_time"] == null ? null : BestTime.fromJson(json["best_time"]),
    condition: json["condition"] == null ? null : OutdoorLifePlannerCondition.fromJson(json["condition"]),
    summary: json["summary"],
  );

}

class OutdoorLifePlannerCondition {
  final String? label;
  final Icon? icon;

  OutdoorLifePlannerCondition({
    this.label,
    this.icon,
  });

  factory OutdoorLifePlannerCondition.fromJson(Map<String, dynamic> json) => OutdoorLifePlannerCondition(
    label: json["label"],
    icon: json["icon"] == null ? null : Icon.fromJson(json["icon"]),
  );

}


class OutdoorSnapshot {
  final String? period;
  final String? periodLabel;
  final Temperature? temperature;
  final int? maximumPrecipitationProbabilityPercent;
  final String? outdoorRating;
  final HourlyForecastCondition? condition;
  final bool? isDaytime;

  OutdoorSnapshot({
    this.period,
    this.periodLabel,
    this.temperature,
    this.maximumPrecipitationProbabilityPercent,
    this.outdoorRating,
    this.condition,
    this.isDaytime,
  });

  factory OutdoorSnapshot.fromJson(Map<String, dynamic> json) => OutdoorSnapshot(
    period: json["period"],
    periodLabel: json["period_label"],
    temperature: json["temperature"] == null ? null : Temperature.fromJson(json["temperature"]),
    maximumPrecipitationProbabilityPercent: json["maximum_precipitation_probability_percent"],
    outdoorRating: json["outdoor_rating"],
    condition: json["condition"] == null ? null : HourlyForecastCondition.fromJson(json["condition"]),
    isDaytime: json["is_daytime"],
  );

}

class Temperature {
  final int? minimum;
  final int? maximum;
  final String? unit;

  Temperature({
    this.minimum,
    this.maximum,
    this.unit,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
    minimum: json["minimum"],
    maximum: json["maximum"],
    unit: json["unit"],
  );

}

class PollenForecast {
  final String? title;
  final String? subtitle;
  final String? basis;
  final List<PollenForecastItem>? items;
  final String? linkLabel;
  final String? linkUrl;

  PollenForecast({
    this.title,
    this.subtitle,
    this.basis,
    this.items,
    this.linkLabel,
    this.linkUrl,
  });

  factory PollenForecast.fromJson(Map<String, dynamic> json) => PollenForecast(
    title: json["title"],
    subtitle: json["subtitle"],
    basis: json["basis"],
    items: json["items"] == null ? [] : List<PollenForecastItem>.from(json["items"]!.map((x) => PollenForecastItem.fromJson(x))),
    linkLabel: json["link_label"],
    linkUrl: json["link_url"],
  );

}

class PollenForecastItem {
  final String? type;
  final String? label;
  final String? icon;
  final String? level;
  final String? levelKey;

  PollenForecastItem({
    this.type,
    this.label,
    this.icon,
    this.level,
    this.levelKey,
  });

  factory PollenForecastItem.fromJson(Map<String, dynamic> json) => PollenForecastItem(
    type: json["type"],
    label: json["label"],
    icon: json["icon"],
    level: json["level"],
    levelKey: json["level_key"],
  );

}

class SevenDayOutlook {
  final DateTime? date;
  final String? day;
  final int? high;
  final int? low;
  final String? temperatureUnit;
  final OutdoorLifePlannerCondition? condition;
  final String? outdoorMessage;
  final String? displayDay;

  SevenDayOutlook({
    this.date,
    this.day,
    this.high,
    this.low,
    this.temperatureUnit,
    this.condition,
    this.outdoorMessage,
    this.displayDay,
  });

  factory SevenDayOutlook.fromJson(Map<String, dynamic> json) => SevenDayOutlook(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"],
    high: json["high"],
    low: json["low"],
    temperatureUnit: json["temperature_unit"],
    condition: json["condition"] == null ? null : OutdoorLifePlannerCondition.fromJson(json["condition"]),
    outdoorMessage: json["outdoor_message"],
    displayDay: json["display_day"],
  );
}

class SportsWeather {
  final String? status;
  final String? title;
  final String? subtitle;
  final String? iconPath;
  final Game? game;
  final Conditions? conditions;
  final String? linkLabel;
  final String? linkUrl;
  final dynamic emptyMessage;

  SportsWeather({
    this.status,
    this.title,
    this.subtitle,
    this.iconPath,
    this.game,
    this.conditions,
    this.linkLabel,
    this.linkUrl,
    this.emptyMessage,
  });

  factory SportsWeather.fromJson(Map<String, dynamic> json) => SportsWeather(
    status: json["status"],
    title: json["title"],
    subtitle: json["subtitle"],
    iconPath: json["icon_path"],
    game: json["game"] == null ? null : Game.fromJson(json["game"]),
    conditions: json["conditions"] == null ? null : Conditions.fromJson(json["conditions"]),
    linkLabel: json["link_label"],
    linkUrl: json["link_url"],
    emptyMessage: json["empty_message"],
  );

}

class Conditions {
  final String? rating;
  final String? label;
  final String? temperatureLabel;
  final String? windLabel;
  final String? precipitationLabel;
  final String? delayRisk;
  final bool? isIndoor;

  Conditions({
    this.rating,
    this.label,
    this.temperatureLabel,
    this.windLabel,
    this.precipitationLabel,
    this.delayRisk,
    this.isIndoor,
  });

  factory Conditions.fromJson(Map<String, dynamic> json) => Conditions(
    rating: json["rating"],
    label: json["label"],
    temperatureLabel: json["temperature_label"],
    windLabel: json["wind_label"],
    precipitationLabel: json["precipitation_label"],
    delayRisk: json["delay_risk"],
    isIndoor: json["is_indoor"],
  );

}

class Game {
  final int? id;
  final String? title;
  final String? sport;
  final DateTime? startsAt;
  final DateTime? date;
  final String? time;
  final String? venue;

  Game({
    this.id,
    this.title,
    this.sport,
    this.startsAt,
    this.date,
    this.time,
    this.venue,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    id: json["id"],
    title: json["title"],
    sport: json["sport"],
    startsAt: json["starts_at"] == null ? null : DateTime.parse(json["starts_at"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"],
    venue: json["venue"],
  );

}

class WeatherAiGuide {
  final String? title;
  final String? subtitle;
  final List<String>? suggestions;

  WeatherAiGuide({
    this.title,
    this.subtitle,
    this.suggestions,
  });

  factory WeatherAiGuide.fromJson(Map<String, dynamic> json) => WeatherAiGuide(
    title: json["title"],
    subtitle: json["subtitle"],
    suggestions: json["suggestions"] == null ? [] : List<String>.from(json["suggestions"]!.map((x) => x)),
  );

}

class WeatherDiscussions {
  final String? title;
  final String? subtitle;
  final int? categoryId;
  final int? itemType;
  final int? townId;
  final List<WeatherDiscussionsItem>? items;
  final String? emptyMessage;
  final String? joinLabel;
  final String? joinUrl;

  WeatherDiscussions({
    this.title,
    this.subtitle,
    this.categoryId,
    this.itemType,
    this.townId,
    this.items,
    this.emptyMessage,
    this.joinLabel,
    this.joinUrl,
  });

  factory WeatherDiscussions.fromJson(Map<String, dynamic> json) => WeatherDiscussions(
    title: json["title"],
    subtitle: json["subtitle"],
    categoryId: json["category_id"],
    itemType: json["item_type"],
    townId: json["town_id"],
    items: json["items"] == null ? [] : List<WeatherDiscussionsItem>.from(json["items"]!.map((x) => WeatherDiscussionsItem.fromJson(x))),
    emptyMessage: json["empty_message"],
    joinLabel: json["join_label"],
    joinUrl: json["join_url"],
  );

}

class WeatherDiscussionsItem {
  final int? id;
  final String? title;
  final String? authorName;
  final String? postedLabel;
  final String? url;
  final String? authorInitials;
  final int? repliesCount;

  WeatherDiscussionsItem({
    this.id,
    this.title,
    this.authorName,
    this.postedLabel,
    this.url,
    this.authorInitials,
    this.repliesCount,
  });

  factory WeatherDiscussionsItem.fromJson(Map<String, dynamic> json) => WeatherDiscussionsItem(
    id: json["id"],
    title: json["title"],
    authorName: json["author_name"],
    postedLabel: json["posted_label"],
    url: json["url"],
    authorInitials: json["author_initials"],
    repliesCount: json["replies_count"],
  );

}

class WeatherImpactMap {
  final bool? hasImpacts;
  final int? impactCount;
  final List<WeatherImpactMapItem>? items;

  WeatherImpactMap({
    this.hasImpacts,
    this.impactCount,
    this.items,
  });

  factory WeatherImpactMap.fromJson(Map<String, dynamic> json) => WeatherImpactMap(
    hasImpacts: json["has_impacts"],
    impactCount: json["impact_count"],
    items: json["items"] == null ? [] : List<WeatherImpactMapItem>.from(json["items"]!.map((x) => WeatherImpactMapItem.fromJson(x))),
  );

}

class WeatherImpactMapItem {
  final String? type;
  final String? severity;
  final String? label;
  final int? value;
  final dynamic unit;
  final String? icon;

  WeatherImpactMapItem({
    this.type,
    this.severity,
    this.label,
    this.value,
    this.unit,
    this.icon,
  });

  factory WeatherImpactMapItem.fromJson(Map<String, dynamic> json) => WeatherImpactMapItem(
    type: json["type"],
    severity: json["severity"],
    label: json["label"],
    value: json["value"],
    unit: json["unit"],
    icon: json["icon"],
  );

}

class City {
  final int? id;
  final String? name;
  final String? state;
  final String? label;
  final double? latitude;
  final double? longitude;
  final String? cityImage;

  City({
    this.id,
    this.name,
    this.state,
    this.label,
    this.latitude,
    this.longitude,
    this.cityImage,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    state: json["state"],
    label: json["label"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    cityImage: json["city_image"],
  );

}

class CurrentConditions {
  final Visibility? visibility;

  CurrentConditions({
    this.visibility,
  });

  factory CurrentConditions.fromJson(Map<String, dynamic> json) => CurrentConditions(
    visibility: json["visibility"] == null ? null : Visibility.fromJson(json["visibility"]),
  );

}

class Environment {
  final AirQuality? airQuality;
  final UvIndex? uvIndex;
  final SunMoon? sunMoon;

  Environment({
    this.airQuality,
    this.uvIndex,
    this.sunMoon,
  });

  factory Environment.fromJson(Map<String, dynamic> json) => Environment(
    airQuality: json["air_quality"] == null ? null : AirQuality.fromJson(json["air_quality"]),
    uvIndex: json["uv_index"] == null ? null : UvIndex.fromJson(json["uv_index"]),
    sunMoon: json["sun_moon"] == null ? null : SunMoon.fromJson(json["sun_moon"]),
  );

}

class AirQuality {
  final int? aqi;
  final String? category;
  final String? healthGuidance;
  final dynamic observedAt;
  final String? source;

  AirQuality({
    this.aqi,
    this.category,
    this.healthGuidance,
    this.observedAt,
    this.source,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) => AirQuality(
    aqi: json["aqi"],
    category: json["category"],
    healthGuidance: json["health_guidance"],
    observedAt: json["observed_at"],
    source: json["source"],
  );
}

class SunMoon {
  final DateTime? date;
  final String? sunrise;
  final String? sunset;
  final String? moonrise;
  final String? moonset;
  final String? moonPhase;
  final double? moonIllumination;

  SunMoon({
    this.date,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
  });

  factory SunMoon.fromJson(Map<String, dynamic> json) => SunMoon(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    moonrise: json["moonrise"],
    moonset: json["moonset"],
    moonPhase: json["moon_phase"],
    moonIllumination: json["moon_illumination"]?.toDouble(),
  );
}

class UvIndex {
  final int? value;
  final String? riskLevel;
  final DateTime? date;
  final String? source;

  UvIndex({
    this.value,
    this.riskLevel,
    this.date,
    this.source,
  });

  factory UvIndex.fromJson(Map<String, dynamic> json) => UvIndex(
    value: json["value"],
    riskLevel: json["risk_level"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    source: json["source"],
  );
}

class Source {
  final String? weatherProvider;
  final String? weatherOffice;
  final String? airQualityProvider;
  final String? uvProvider;

  Source({
    this.weatherProvider,
    this.weatherOffice,
    this.airQualityProvider,
    this.uvProvider,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    weatherProvider: json["weather_provider"],
    weatherOffice: json["weather_office"],
    airQualityProvider: json["air_quality_provider"],
    uvProvider: json["uv_provider"],
  );
}
