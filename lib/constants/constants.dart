
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'images.dart';

class Constants {
  static const responseError = 'ERROR';
  static const responseSuccess = 'SUCCESS';
  static const someThingWentWrong = 'Something went wrong.';
  static const reCaptchaSiteKey = '6LdpybgmAAAAAISLIzZ5Orj6922divJgT3_EeYJh';
}

class GetXStorageConstants {
  static const authToken = "Authorization";
  static const darkTheme = "DarkTheme";
  static const townName = "TownName";
  static const day = "day";
  static const String themeMode = 'themeMode';

}

class ControllerBuilders {
  static String homeController = 'HomeController';
  static String homeSectionsController = 'HomeSectionsController';
  static String searchTownController = 'SearchTownController';
  static String sportsController = 'SportsController';
  static String weatherController = 'WeatherController';
  static String communityIntelligence = 'CommunityIntelligence';
  static String educationController = 'EducationController';
  static String entertainmentController = 'EntertainmentController';
  static String politicsController = 'PoliticsController';
  static String commandCenterController = 'CommandCenterController';
  static String townHallController = 'TownHallController';
  static String addGarageItemController = 'AddGarageItemController';
  static String marketBriefController = 'MarketBriefController';
  static String marketPlaceController = 'MarketPlaceController';
  static String filterController = 'FilterController';
  static String myGarageController = 'MyGarageController';
}

class ActivityModel {
  final String profileImage;
  final String userName;
  final String action;
  final String time;
  final String? trailingImage;
  final IconData? trailingIcon;
  final String? count;
  final Color? countColor;

  ActivityModel({
    required this.profileImage,
    required this.userName,
    required this.action,
    required this.time,
    this.trailingImage,
    this.trailingIcon,
    this.count,
    this.countColor,
  });
}

class IntelligenceCategory {
  final String title;
  final String subTitle;
  final String updates;
  final Color color;
  final IconData icon;

  IntelligenceCategory({
    required this.title,
    required this.subTitle,
    required this.updates,
    required this.color,
    required this.icon,
  });
}

class QuickActionModel {
  final String image;
  final String title;
  final String subTitle;
  final String count;

  QuickActionModel({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.count,
  });
}

final List<QuickActionModel> quickActionList = [
  QuickActionModel(
    image: "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?w=400", // Festival
    title: "Upcoming",
    subTitle: "Events",
    count: "18 this weekend",
  ),
  QuickActionModel(
    image: "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=400", // Volunteers
    title: "Volunteer",
    subTitle: "Opportunities",
    count: "24 ways to help",
  ),
  QuickActionModel(
    image: "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400", // Coffee
    title: "Local Deals",
    subTitle: "",
    count: "32 new offers",
  ),
  QuickActionModel(
    image: "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400", // Shop/Open
    title: "New",
    subTitle: "Businesses",
    count: "6 this week",
  ),
];


class TopStoryModel {
  final String title;
  final String subTitle;
  final String image;

  TopStoryModel({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}

final List<TopStoryModel> topStoryList = [
  TopStoryModel(
    title: "King County",
    subTitle: "Top Story",
    image: Images.county,
  ),
  TopStoryModel(
    title: "Washington State",
    subTitle: "Top Story",
    image: Images.state,
  ),
  TopStoryModel(
    title: "United States",
    subTitle: "Top Story",
    image: Images.country,
  ),
  TopStoryModel(
    title: "World",
    subTitle: "Top Story",
    image: Images.world,
  ),
];


class BusinessModel {
  final String image;
  final String name;
  final String category;
  final double rating;
  final int reviews;
  final String distance;

  BusinessModel({
    required this.image,
    required this.name,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.distance,
  });
}

class JobModel {
  final String logo;
  final String title;
  final String company;
  final String type;
  final String time;

  JobModel({
    required this.logo,
    required this.title,
    required this.company,
    required this.type,
    required this.time,
  });
}


final List<JobModel> jobList = [
  JobModel(
    logo: "https://logo.clearbit.com/starbucks.com",
    title: "Barista",
    company: "Cedar & Sage Cafe",
    type: "Full-time • Part-time",
    time: "2h ago",
  ),
  JobModel(
    logo: "https://logo.clearbit.com/slack.com",
    title: "Marketing Assistant",
    company: "Pine Valley Co.",
    type: "Full-time",
    time: "5h ago",
  ),
  JobModel(
    logo: "https://logo.clearbit.com/mayoclinic.org",
    title: "Physical Therapist",
    company: "High Country PT",
    type: "Full-time",
    time: "1d ago",
  ),
];

class DealModel {
  final String image;
  final String title;
  final String business;
  final String validTill;

  DealModel({
    required this.image,
    required this.title,
    required this.business,
    required this.validTill,
  });
}

final List<DealModel> dealList = [
  DealModel(
    image:
    "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=500",
    title: "20% Off Any Coffee",
    business: "Cedar & Sage Cafe",
    validTill: "Valid through May 20",
  ),
  DealModel(
    image:
    "https://images.unsplash.com/photo-1521791136064-7986c2920216?w=500",
    title: "\$25 Off Your First Visit",
    business: "Summit Fitness",
    validTill: "Valid through May 31",
  ),
  DealModel(
    image:
    "https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=500",
    title: "Free Consultation",
    business: "High Country Physical Therapy",
    validTill: "Valid through May 25",
  ),
];

final List<BusinessModel> businessList = [
  BusinessModel(
    image: "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500",
    name: "Cedar & Sage Cafe",
    category: "Coffee Shop",
    rating: 4.9,
    reviews: 96,
    distance: "0.3 mi",
  ),
  BusinessModel(
    image: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500",
    name: "Pine Valley Hardware",
    category: "Home Improvement",
    rating: 4.8,
    reviews: 128,
    distance: "1.1 mi",
  ),
  BusinessModel(
    image: "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=500",
    name: "Summit Fitness",
    category: "Gym / Fitness",
    rating: 4.7,
    reviews: 85,
    distance: "1.8 mi",
  ),
  BusinessModel(
    image: "https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=500",
    name: "Mountain View Dental Care",
    category: "Dental",
    rating: 4.9,
    reviews: 112,
    distance: "1.2 mi",
  ),
];

class ApiStatus {
  static const success = "1";
  static const failed = "Failed";
}

class FontFamily {
  static const poppins = 'Poppins';
}

class MenuItem {
  final String name;
  final String image;
  
  MenuItem({required this.name,required this.image});
}

class DateFormats {
  static String yyyyMMddWithDash = 'yyyy-MM-dd';
  static String ddMMMWithSpace = 'dd MMM';
  static String eeeDdMMMyyyy = 'EEEE dd MMM yyyy';
  static String ddMMMyyyy = 'dd MMM yyyy';
  static String eDDMMM = 'E, dd MMM';
  static String hhmma = 'hh:mm a';
  static String month = 'MMMM';
  static String eeeee = 'EEEEE';

  static String formatTime(String? time) {
    if (time == null || time.isEmpty) return '';

    try {
      final dateTime = DateFormat('HH:mm:ss').parse(time);
      return DateFormat(hhmma).format(dateTime);
    } catch (_) {
      return time;
    }
  }

  static String formatGameDate(String? date) {
    if (date == null || date.isEmpty) return '';

    try {
      final dateTime = DateTime.parse(date);
      return DateFormat(eDDMMM).format(dateTime);
    } catch (_) {
      return date;
    }
  }
}

class ChartData {
  final String x;
  final double y;
  final Color color;

  ChartData({
    required this.x,
    required this.y,
    required this.color,
  });
}

final List<ExploreCardModel> exploreCards = [
  ExploreCardModel(
    image: Images.firstVisitLocalNews,
    title: 'LOCAL NEWS',
    subtitle: 'Real stories.\nReal people.',
    icon: Icons.article_rounded,
    iconColor: const Color(0xFF2563EB),
    actionTitle: 'Post News',
  ),
  ExploreCardModel(
    image: Images.firstVisitSeattle,
    title: 'WEATHER',
    subtitle: 'Live updates.\nPlan your day.',
    icon: CupertinoIcons.cloud_sun_fill,
    iconColor: const Color(0xFF1D4ED8),
    actionTitle: 'Report Weather',
  ),
  ExploreCardModel(
    image: Images.firstVisitTownTalk,
    title: 'TOWN TALK',
    subtitle: 'Conversations\nthat matter.',
    icon: CupertinoIcons.chat_bubble_fill,
    iconColor: const Color(0xFF16A34A),
    actionTitle: 'Start Discussion',
  ),
  ExploreCardModel(
    image: Images.firstVisitTownHall,
    title: 'TOWN HALL',
    subtitle: 'Transparent.\nAccountable.',
    icon: Icons.account_balance_rounded,
    iconColor: const Color(0xFF2563EB),
    actionTitle: 'Share Update',
  ),
  ExploreCardModel(
    image: Images.firstVisitEvents,
    title: 'EVENTS',
    subtitle: "What's happening\nin your town.",
    icon: Icons.calendar_month_rounded,
    iconColor: const Color(0xFF7E22CE),
    actionTitle: 'Add Event',
  ),
  ExploreCardModel(
    image: Images.firstVisitTownMemory,
    title: 'TOWN MEMORY',
    subtitle: 'Discover the stories\nthat shaped us.',
    icon: Icons.history_rounded,
    iconColor: const Color(0xFFF97316),
    actionTitle: 'Share Memory',
    sepia: true,
  ),
];

final List<ExploreCardModel> exploreCard = [
  ExploreCardModel(
    image: Images.news,
    title: 'NEWS',
    subtitle: '26 Stories',
    icon: Icons.article_rounded,
    iconColor: const Color(0xFF2563EB),
    actionTitle: 'Post News',
  ),
  ExploreCardModel(
    image: Images.weather,
    title: 'WEATHER',
    subtitle: "72°F Sunny",
    icon: CupertinoIcons.cloud_sun_fill,
    iconColor: const Color(0xFF1D4ED8),
    actionTitle: 'Report Weather',
  ),
  ExploreCardModel(
    image: Images.sports,
    title: 'SPORTS',
    subtitle: "Tonight's game at 7PM",
    icon: CupertinoIcons.chat_bubble_fill,
    iconColor: const Color(0xFF16A34A),
    actionTitle: 'Share Match',
  ),
  ExploreCardModel(
    image: Images.townHall,
    title: 'TOWN HALL',
    subtitle: 'City updates & meetings',
    icon: Icons.account_balance_rounded,
    iconColor: const Color(0xFF2563EB),
    actionTitle: 'Share Update',
  ),
  ExploreCardModel(
    image: Images.business,
    title: 'BUSINESS',
    subtitle: "Support local",
    icon: Icons.calendar_month_rounded,
    iconColor: const Color(0xFF7E22CE),
    actionTitle: 'Add Business',
  ),
  ExploreCardModel(
    image: Images.entertainment,
    title: 'ENTERTAINMENT',
    subtitle: 'Discover the stories\nthat shaped us.',
    icon: Icons.history_rounded,
    iconColor: const Color(0xFFF97316),
    actionTitle: 'Share Music',
  ),
  ExploreCardModel(
    image: Images.directory,
    title: 'DIRECTORY',
    subtitle: 'Find local services',
    icon: Icons.history_rounded,
    iconColor: const Color(0xFFF97316),
    actionTitle: 'Share Directions',
  ),
  ExploreCardModel(
    image: Images.townMemory,
    title: 'TOWN MEMORY',
    subtitle: 'Stories from our past',
    icon: Icons.history_rounded,
    iconColor: const Color(0xFFF97316),
    actionTitle: 'Share Memory',
  ),
];

String formatTitle(String text) {
  final words = text.trim().split(RegExp(r'\s+'));

  if (words.length <= 3) return text;

  return '${words.take(3).join(' ')}\n${words.skip(3).join(' ')}';
}

class ExploreCardModel {
  final String image;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool sepia;
  final bool isCommunity;
  final String actionTitle;

  const ExploreCardModel({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.actionTitle,
    this.sepia = false,
    this.isCommunity = false,
  });
}

