import 'dart:ui';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/weather/shimmer.dart';
import 'package:wikixm/Presentation/weather/weather_controller.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/Theme.dart';
import '../../constants/constants.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../../data/datasource/local/local_storage.dart';
import '../widgets/cache_image.dart';
import '../widgets/weather_animations.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherController weatherController = Get.put(WeatherController());
  int currentIndex = 0;
  bool _isDay = true;
  ThemeData get _pageTheme =>
      _isDay ? AppTheme.lightTheme : AppTheme.darkTheme;

  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
        id: ControllerBuilders.weatherController,
        init: weatherController,
        builder: (controller) {
          final String daypart = controller.weatherHeroData?.daypart?.toLowerCase() ?? 'day';
          final bool isDay = daypart == 'day';
          _isDay = isDay;
          return controller.isLoading ? WeatherShimmerScreen() : Theme(
            data: isDay
                ? AppTheme.lightTheme
                : AppTheme.darkTheme,
            child: Builder(
                builder: (_) {
                  return CommonScrollBlurScaffold(
                      expandedHeight: Dimensions.h_230,
                      expandedColor: _pageTheme.scaffoldBackgroundColor,
                      showBack: true,
                      backgroundColor: _pageTheme.scaffoldBackgroundColor,
                      collapsedColor: _pageTheme.scaffoldBackgroundColor,
                      hero: buildHeroHeader(), slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4),
                        child: controller.closeAlert ? secondCard(controller): Stack(
                          clipBehavior: Clip.none,
                          children: [
                            firstCard(),
                            Positioned(
                                bottom: -Dimensions.h_120,
                                left: 0,
                                right: 0,
                                child: secondCard(controller))
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                          color: _pageTheme.scaffoldBackgroundColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: controller.closeAlert ? Dimensions.h_10:Dimensions.h_130),
                              aiWeather(controller),
                              SizedBox(height: Dimensions.h_10),
                              todayAtAGlance(controller),
                              SizedBox(height: Dimensions.h_10),
                              CommonCard(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "HOW'S THE WEATHER NEAR YOU?",
                                    style: TextStyle(
                                      color: _pageTheme.primaryColor,
                                      fontSize: FontSize.sp_11,
                                      fontWeight: FontWeight.w800,
                                      height: 1,
                                    ),
                                  ),

                                  SizedBox(height: Dimensions.h_6),

                                  Text(
                                    "Share what you're seeing right now.",
                                    style: TextStyle(
                                      color: _pageTheme.primaryColor,
                                      fontSize: FontSize.sp_9,
                                      fontWeight: FontWeight.w500,
                                      height: 1.1,
                                    ),
                                  ),

                                  SizedBox(height: Dimensions.h_10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: weatherReportItem(
                                          icon: Icons.wb_sunny,
                                          iconColor: const Color(0xFFFFB000),
                                          label: "Sunny",
                                        ),
                                      ),

                                      Expanded(
                                        child: weatherReportItem(
                                          icon: Icons.cloud,
                                          iconColor: const Color(0xFFB8BCC5),
                                          label: "Partly\nCloudy",
                                        ),
                                      ),

                                      Expanded(
                                        child: weatherReportItem(
                                          icon: Icons.cloud,
                                          iconColor: const Color(0xFF9EA8C0),
                                          label: "Cloudy",
                                        ),
                                      ),

                                      Expanded(
                                        child: weatherReportItem(
                                          icon: Icons.cloudy_snowing,
                                          iconColor: const Color(0xFF9EA8C0),
                                          label: "Rain",
                                        ),
                                      ),

                                      Expanded(
                                        child: weatherReportItem(
                                          icon: Icons.air,
                                          iconColor: const Color(0xFF9EA8C0),
                                          label: "Windy",
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: Dimensions.h_10),

                                  Container(
                                    height: 0.5,
                                    color: _pageTheme.focusColor,
                                  ),

                                  SizedBox(height: Dimensions.h_7),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.groups,
                                        size: Dimensions.h_13,
                                        color: _pageTheme.primaryColor,
                                      ),

                                      SizedBox(width: Dimensions.w_3),

                                      Text(
                                        "148 residents agree",
                                        style: TextStyle(
                                          color: _pageTheme.primaryColor,
                                          fontSize: FontSize.sp_8_5,
                                          fontWeight: FontWeight.w600,
                                          height: 1,
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.w_10),
                                      Container(
                                        width: 3,
                                        height: 3,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFB8BFCC),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.w_10),
                                      Text(
                                        "Updated 4 min ago",
                                        style: TextStyle(
                                          color: _pageTheme.primaryColor,
                                          fontSize: FontSize.sp_8_5,
                                          fontWeight: FontWeight.w600,
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                              SizedBox(height: Dimensions.h_10),
                              CommonCard(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "WHAT DID YOU DO OUTSIDE TODAY?",
                                    style: TextStyle(
                                      color: _pageTheme.primaryColor,
                                      fontSize: FontSize.sp_11,
                                      fontWeight: FontWeight.w800,
                                      height: 1,
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.h_12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      outdoorActivityItem(
                                        icon: Icons.directions_walk,
                                        label: 'Hiking',
                                        iconColor: const Color(0xFF167B24),
                                      ),

                                      outdoorActivityItem(
                                        icon: Icons.directions_run,
                                        label: 'Running',
                                        iconColor: const Color(0xFF167B24),
                                      ),

                                      outdoorActivityItem(
                                        icon: Icons.directions_bike,
                                        label: 'Cycling',
                                        iconColor: const Color(0xFF167B24),
                                      ),

                                      outdoorActivityItem(
                                        icon: Icons.phishing,
                                        label: 'Fishing',
                                        iconColor: const Color(0xFF245BEA),
                                      ),

                                      outdoorActivityItem(
                                        icon: Icons.more_horiz,
                                        label: 'More',
                                        iconColor: AppColor.primaryNavyNew,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_12),
                                  Center(
                                    child: Text(
                                      '73 residents checked in today!',
                                      style: TextStyle(
                                        color: _pageTheme.primaryColor,
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w500,
                                        height: 1.05,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              SizedBox(height: Dimensions.h_10),
                              aroundMap(controller),
                              SizedBox(height: Dimensions.h_10),
                              aroundTheHouse(controller),
                              SizedBox(height: Dimensions.h_10),
                              CommonCard(
                                child: Builder(
                                  builder: (context) {
                                    final sportsWeather = controller.weatherCardData?.cards?.sportsWeather;
                                    final game = sportsWeather?.game;
                                    final conditions = sportsWeather?.conditions;
                                    if (sportsWeather == null ||
                                        sportsWeather.status != 'ready') {
                                      return const SizedBox.shrink();
                                    }
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                (sportsWeather.title ?? "TONIGHT'S SPORTS WEATHER").toUpperCase(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: _pageTheme.primaryColor,
                                                  fontSize: FontSize.sp_11,
                                                  fontWeight: FontWeight.w800,
                                                  height: 1,
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: Dimensions.w_8),

                                            GestureDetector(
                                              onTap: () {
                                                // Add navigation using:
                                                // sportsWeather.linkUrl
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    sportsWeather.linkLabel ??
                                                        'See Details',
                                                    style: TextStyle(
                                                      color: _pageTheme
                                                          .primaryColorDark,
                                                      fontSize: FontSize.sp_9_5,
                                                      fontWeight: FontWeight.w800,
                                                      height: 1,
                                                    ),
                                                  ),
                                                  SizedBox(width: Dimensions.w_3),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: _pageTheme
                                                        .primaryColorDark,
                                                    size: Dimensions.h_12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: Dimensions.h_10),

                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              _getSportIcon(game?.sport),
                                              color: _getSportIconColor(game?.sport),
                                              size: Dimensions.h_40,
                                            ),

                                            SizedBox(width: Dimensions.w_8),

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          game?.title ?? '',
                                                          maxLines: 2,
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: _pageTheme
                                                                .primaryColor,
                                                            fontSize: FontSize.sp_12,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            height: 1.2,
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(width: Dimensions.w_5),

                                                      Container(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                          Dimensions.w_7,
                                                          vertical:
                                                          Dimensions.h_4,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: _getRatingBackground(
                                                            conditions?.rating,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                            Dimensions.h_5,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          conditions?.rating ?? '',
                                                          style: TextStyle(
                                                            color: _getRatingColor(
                                                              conditions?.rating,
                                                            ),
                                                            fontSize: FontSize.sp_8,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            height: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(height: Dimensions.h_5),

                                                  Text(
                                                    game?.time ?? '',
                                                    style: TextStyle(
                                                      color:
                                                      _pageTheme.primaryColor,
                                                      fontSize: FontSize.sp_9,
                                                      fontWeight: FontWeight.w500,
                                                      height: 1,
                                                    ),
                                                  ),

                                                  SizedBox(height: Dimensions.h_8),

                                                  _buildTemperatureLabel(
                                                    conditions?.temperatureLabel ?? '',
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: Dimensions.h_12),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: sportsWeatherMetric(
                                                title: 'Wind',
                                                value:
                                                conditions?.windLabel ?? '--',
                                              ),
                                            ),

                                            Container(
                                              width: 0.5,
                                              height: Dimensions.h_30,
                                              color: _isDay !=
                                                  true
                                                  ? Colors.white.withValues(alpha: .15)
                                                  : const Color(0xFFE1E5EC),
                                            ),

                                            Expanded(
                                              child: sportsWeatherMetric(
                                                title: 'Rain',
                                                value: conditions
                                                    ?.precipitationLabel ??
                                                    '--',
                                              ),
                                            ),

                                            Container(
                                              width: 0.5,
                                              height: Dimensions.h_30,
                                              color: _isDay !=
                                                  true
                                                  ? Colors.white.withValues(alpha: .15)
                                                  : const Color(0xFFE1E5EC),
                                            ),

                                            Expanded(
                                              child: sportsWeatherMetric(
                                                title: 'Delay Risk',
                                                value:
                                                conditions?.delayRisk ?? '--',
                                                valueColor: _getDelayRiskColor(
                                                  conditions?.delayRisk,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: Dimensions.h_10),
                              Padding(
                                padding:  EdgeInsets.only(left: Dimensions.w_5),
                                child: Text(
                                  "ADVERTISEMENT",
                                  style: TextStyle(
                                    color: _pageTheme.primaryColor,
                                    fontSize: FontSize.sp_11,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.h_5),
                              Stack(
                                children: [
                                  AppCacheImage(imageUrl: Images.ads,size: Dimensions.h_125,widthSize: Get.width,isShadow: false,radius: Dimensions.h_12),
                                  Positioned(
                                      top: Dimensions.h_65,
                                      left: Dimensions.w_30,
                                      child: Column(
                                        children: [
                                          Text(
                                            "ISSAQUAH",
                                            style: TextStyle(
                                              color: AppColor.white,
                                              fontSize: FontSize.sp_22,
                                              fontWeight: FontWeight.w600,
                                              height: 1,
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.h_3),
                                          Text(
                                            "COMMUNITY BANK",
                                            style: TextStyle(
                                              color: AppColor.white,
                                              fontSize: FontSize.sp_11,
                                              fontWeight: FontWeight.w600,
                                              height: 1,
                                            ),
                                          )
                                        ],
                                      )),
                                  Positioned(
                                      top: Dimensions.h_25,
                                      right: Dimensions.w_20,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Local banking.",
                                            style: TextStyle(
                                              color: AppColor.white,
                                              fontSize: FontSize.sp_16,
                                              fontWeight: FontWeight.w600,
                                              height: 1,
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.h_3),
                                          Text(
                                            "Local people.",
                                            style: TextStyle(
                                              color: AppColor.white,
                                              fontSize: FontSize.sp_16,
                                              fontWeight: FontWeight.w600,
                                              height: 1,
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.h_15),
                                          GestureDetector(
                                            onTap: (){},
                                            child: Container(
                                              padding: EdgeInsets.only(left: Dimensions.w_25,right: Dimensions.w_30),
                                              height: Dimensions.h_25,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 0.6
                                                  ),
                                                  borderRadius: BorderRadius.circular(Dimensions.h_4)),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Learn More',
                                                style: TextStyle(
                                                  color: Colors.white ,
                                                  fontSize: FontSize.sp_12,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(height: Dimensions.h_10),
                              todaySection(controller),
                              SizedBox(height: Dimensions.h_10),
                              outdoorLifePlanner(controller),
                              SizedBox(height: Dimensions.h_10),
                              commuteSchool(controller),
                              SizedBox(height: Dimensions.h_10),
                              adventureGuide(controller),
                              SizedBox(height: Dimensions.h_10),
                              Padding(
                                padding:  EdgeInsets.only(left: Dimensions.w_5),
                                child: Text(
                                  "ADVERTISEMENT",
                                  style: TextStyle(
                                    color: _pageTheme.primaryColor,
                                    fontSize: FontSize.sp_11,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.h_5),
                              AppCacheImage(imageUrl: Images.adsShop,
                                  size: Dimensions.h_200,
                                  widthSize: Get.width,
                                  isShadow: false,
                                  fit: BoxFit.cover,
                                  radius: Dimensions.h_10),
                              SizedBox(height: Dimensions.h_10),
                              latestWeatherNews(),
                              SizedBox(height: Dimensions.h_10),
                              Padding(
                                padding:  EdgeInsets.only(left: Dimensions.w_5),
                                child: Text(
                                  "ADVERTISEMENT",
                                  style: TextStyle(
                                    color: _pageTheme.primaryColor,
                                    fontSize: FontSize.sp_11,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.h_5),
                              AppCacheImage(imageUrl: Images.ad,
                                  size: Dimensions.h_250,
                                  widthSize: Get.width,
                                  isShadow: false,
                                  fit: BoxFit.cover,
                                  radius: Dimensions.h_10),
                              SizedBox(height: Dimensions.h_10),
                              yourWeekAhead(controller),
                              SizedBox(height: Dimensions.h_15)
                            ],
                          ),
                        )
                    ),
                  ]);
                }
            ),
          );
        }
    );
  }

  Widget aroundMap(WeatherController controller) {
    final weatherImpactMap =
        controller.weatherCardData?.cards?.weatherImpactMap;

    final impactItems = weatherImpactMap?.items ?? [];

    return CommonCard(
      height: Dimensions.h_150,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: _isDay ==
                  true
                  ? 0.30
                  : 0.78,
              child: AppCacheImage(
                radius: Dimensions.h_8,
                imageUrl:
                'https://imgs.search.brave.com/sP5K4r7iTIv3GJTULuyoo-IZup2_FhPtv7VLNTPIsHw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzRkL2Fk/L2ZlLzRkYWRmZTBh/ZGY3OTNmZTgxZWEy/OGQ2YTE3ZTNiMmRi/LmpwZw',
              ),
            ),
          ),

          if (_isDay ==
              true)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(
                    Dimensions.h_8,
                  ),
                ),
              ),
            ),

          Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w_10,
              Dimensions.h_10,
              Dimensions.w_10,
              Dimensions.h_5,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Around ${LocalStorage.getString(
                      GetXStorageConstants.townName,
                    )} right now',
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: FontSize.sp_13,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h_15),
                if (weatherImpactMap?.hasImpacts == true &&
                    impactItems.isNotEmpty)
                  Row(children: [
                    SizedBox(width: Dimensions.w_20),
                    ...List.generate(
                      impactItems.length,
                          (index) {
                        final item = impactItems[index];

                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: index ==
                                  impactItems.length - 1
                                  ? 0
                                  : Dimensions.w_5,
                            ),
                            child: liveMapStatCard(
                              value: _getImpactValue(item),
                              label: item.label ?? '',
                              showArrow: true,
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(width: Dimensions.w_20),
                  ])
                else
                  Text(
                    'No weather impacts reported',
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: FontSize.sp_11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Open Live Map',
                        style: TextStyle(
                          color: AppColor.darkBlue,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w900,
                          height: 1,
                        ),
                      ),

                      SizedBox(width: Dimensions.w_4),

                      Icon(
                        Icons.arrow_forward,
                        color: AppColor.darkBlue,
                        size: Dimensions.h_13,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Dimensions.h_6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getImpactValue(dynamic item) {
    final value = item.value;
    final unit = item.unit;

    if (value == null) {
      return '';
    }

    if (unit != null && unit.toString().isNotEmpty) {
      return '$value $unit';
    }

    return value.toString();
  }
  Widget aiWeather(WeatherController controller) {
    final weatherAiGuide =
        controller.weatherCardData?.cards?.weatherAiGuide;

    final suggestions = weatherAiGuide?.suggestions ?? [];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.sparkles,
                size: Dimensions.h_15,
                color: _pageTheme.primaryColorDark,
              ),

              SizedBox(width: Dimensions.w_4),

              Expanded(
                child: Text(
                  (weatherAiGuide?.title ?? 'AI WEATHER GUIDE')
                      .toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _pageTheme.primaryColor,
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ),

              SizedBox(width: Dimensions.w_8),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_2,
                  vertical: Dimensions.h_2,
                ),
                decoration: BoxDecoration(
                  color: AppColor.darkBlue,
                  borderRadius: BorderRadius.circular(
                    Dimensions.h_2,
                  ),
                ),
                child: Text(
                  "BETA",
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: FontSize.sp_8_5,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h_6),

          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5),
            child: Text(
              weatherAiGuide?.subtitle ??
                  "Get answers grounded in today's local weather",
              style: TextStyle(
                color: _pageTheme.primaryColor,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(height: Dimensions.h_10),

          GestureDetector(
            onTap: () {
              // Open AI Weather Guide
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.w_10,
              ),
              height: Dimensions.h_30,
              decoration: BoxDecoration(
                color: AppColor.darkBlue,
                borderRadius: BorderRadius.circular(
                  Dimensions.h_4,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Ask Weather Guide',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.sp_12,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
            ),
          ),

          SizedBox(height: Dimensions.h_8),

          if (suggestions.isNotEmpty)
            LayoutBuilder(
              builder: (context, constraints) {
                final chipWidth =
                    (constraints.maxWidth - Dimensions.w_5) / 2;
                return Wrap(
                  spacing: Dimensions.w_5,
                  runSpacing: Dimensions.h_5,
                  children: List.generate(
                    suggestions.length,
                        (index) {
                      return SizedBox(
                        width: chipWidth,
                        child: weatherQuestionChip(
                          suggestions[index],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget todaySection(WeatherController controller) {
    final communityOutdoorFeed =
        controller.weatherCardData?.cards?.communityOutdoorFeed;

    final items = communityOutdoorFeed?.items ?? [];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  communityOutdoorFeed?.title?.toUpperCase() ??
                      "TODAY IN ${LocalStorage
                          .getString(GetXStorageConstants.townName)
                          .toUpperCase()}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _pageTheme.primaryColor,
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  // Use:
                  // communityOutdoorFeed?.viewAllUrl
                },
                child: Row(
                  children: [
                    Text(
                      communityOutdoorFeed?.viewAllLabel ??
                          'See All Photos',
                      style: TextStyle(
                        color: _pageTheme.primaryColorDark,
                        fontSize: FontSize.sp_9_5,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: Dimensions.w_3),
                    Icon(
                      Icons.arrow_forward,
                      color: _pageTheme.primaryColorDark,
                      size: Dimensions.h_12,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h_10),

          if (items.isEmpty)
            SizedBox(
              height: Dimensions.h_150,
              child: Center(
                child: Text(
                  communityOutdoorFeed?.emptyMessage ??
                      'No local weather photos have been shared yet.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _pageTheme.primaryColor,
                    fontSize: FontSize.sp_10,
                  ),
                ),
              ),
            )
          else
            SizedBox(
              height: Dimensions.h_150,
              child: CarouselSlider.builder(
                itemCount: items.length,
                options: CarouselOptions(
                  height: Dimensions.h_150,
                  viewportFraction: 1,
                  enableInfiniteScroll: items.length > 1,
                  autoPlay: items.length > 1,
                  enlargeCenterPage: true,
                  padEnds: false,
                  onPageChanged: (index, reason) {
                    if (!mounted) return;
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  final item = items[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Dimensions.h_8,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AppCacheImage(
                          imageUrl: item.image ?? 'Images.cityImageMobile',
                          fit: BoxFit.cover,
                          errorFit: BoxFit.contain,
                          errorImage: 'https://wikixm-staging.s3.us-west-2.amazonaws.com/images/no-article.svg',
                        ),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.75),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          left: Dimensions.w_8,
                          right: Dimensions.w_10,
                          bottom: Dimensions.h_12,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              // API TITLE
                              Text(
                                item.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),

                              SizedBox(height: Dimensions.h_4),

                              Row(
                                children: [
                                  // API USER NAME
                                  Expanded(
                                    child: Text(
                                      'by ${item.userName ?? ''}',
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_11,
                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.w_6),
                                  Text(
                                    item.postedLabel ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_11,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.h_7),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Colors.red,
                                    size: Dimensions.h_15,
                                  ),

                                  SizedBox(width: Dimensions.w_5),

                                  // API LIKES COUNT
                                  Text(
                                    '${item.likesCount ?? 0}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_11,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

          if (items.isNotEmpty) ...[
            SizedBox(height: Dimensions.h_6),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                items.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 3),
                  width: currentIndex == index
                      ? Dimensions.h_8
                      : Dimensions.h_4,
                  height: Dimensions.h_4,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? _isDay ==
                        false
                        ? Colors.white
                        : Colors.black
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
  Widget todayAtAGlance(WeatherController controller) {
    final weatherData = controller.weatherCardData;
    final outdoorSnapshot = weatherData?.cards?.outdoorSnapshot ?? [];
    final airQuality = weatherData?.environment?.airQuality;
    final uvIndex = weatherData?.environment?.uvIndex;
    final sunMoon = weatherData?.environment?.sunMoon;
    double? highTemp;
    double? lowTemp;
    num? rainProbability;

    for (final item in outdoorSnapshot) {
      final maxTemp = item.temperature?.maximum;
      final minTemp = item.temperature?.minimum;
      final rain =
          item.maximumPrecipitationProbabilityPercent;

      if (maxTemp != null) {
        final double value = maxTemp.toDouble();

        if (highTemp == null || value > highTemp!) {
          highTemp = value;
        }
      }

      if (minTemp != null) {
        final double value = minTemp.toDouble();

        if (lowTemp == null || value < lowTemp!) {
          lowTemp = value;
        }
      }

      if (rain != null) {
        if (rainProbability == null || rain > rainProbability!) {
          rainProbability = rain;
        }
      }
    }

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TODAY AT A GLANCE",
                style: TextStyle(
                  color: _pageTheme.primaryColor,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              Text(
                "See More →",
                style: TextStyle(
                  color: _pageTheme.primaryColorDark,
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h_10),

          GridView.count(
            crossAxisCount: 4,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: Dimensions.w_4,
            mainAxisSpacing: Dimensions.h_4,
            childAspectRatio: 1.10,
            children: [

              // HIGH
              glanceCard(
                value: highTemp != null
                    ? '${highTemp.round()}°'
                    : '',
                label: 'High',
              ),

              // LOW
              glanceCard(
                value: lowTemp != null
                    ? '${lowTemp.round()}°'
                    : '',
                label: 'Low',
              ),

              glanceCard(
                value: rainProbability != null
                    ? '${rainProbability.round()}%'
                    : '',
                label: 'Rain',
              ),

              glanceCard(
                value: '${airQuality?.aqi ?? ''}',
                label: airQuality?.category ?? 'Air Quality',
                secondaryLabel: 'Air Quality',
              ),

              glanceCard(
                value: '${uvIndex?.value ?? ''}',
                label: uvIndex?.riskLevel ?? 'UV Index',
                secondaryLabel: 'UV Index',
                icon: Icons.wb_sunny,
                iconColor: const Color(0xFFFFB800),
              ),

              glanceCard(
                value: _formatSunTime(
                  sunMoon?.sunrise,
                ),
                label: 'Sunrise',
                fontSize: Dimensions.h_12,
              ),

              glanceCard(
                value: _formatSunTime(
                  sunMoon?.sunset,
                ),
                fontSize: Dimensions.h_12,
                label: 'Sunset',
              ),
              if (outdoorSnapshot.isNotEmpty)
                glanceCard(
                  value: outdoorSnapshot.first
                      .outdoorRating ??
                      '',
                  fontSize: Dimensions.h_12,
                  label:
                  'Weather',
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatSunTime(String? time) {
    if (time == null || time.isEmpty) {
      return '';
    }

    try {
      final parts = time.split(' ');

      if (parts.length < 2) {
        return time;
      }

      final timeParts = parts[0].split(':');

      if (timeParts.length < 2) {
        return time;
      }

      return '${timeParts[0]}:${timeParts[1]} ${parts[1]}';
    } catch (_) {
      return time;
    }
  }

  Widget yourWeekAhead(WeatherController controller) {
    final weatherDiscussions =
        controller.weatherCardData?.cards?.weatherDiscussions;

    final discussions = weatherDiscussions?.items ?? [];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weatherDiscussions?.title?.toUpperCase() ??
                'WEATHER DISCUSSIONS',
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_12,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: Dimensions.h_3),

          Text(
            weatherDiscussions?.subtitle ??
                'What residents are talking about',
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_10,
            ),
          ),

          SizedBox(height: Dimensions.h_12),

          if (discussions.isEmpty)
            Text(
              weatherDiscussions?.emptyMessage ??
                  'No local weather discussions yet.',
              style: TextStyle(
                color: _pageTheme.primaryColor,
                fontSize: FontSize.sp_10,
              ),
            )
          else
            ...List.generate(discussions.length, (index) {
              final item = discussions[index];

              return Column(
                children: [
                  _weekAheadItem(
                    icon: _getDiscussionIcon(index),
                    iconColor: _getDiscussionIconColor(index),
                    title: item.title ?? '',
                    description:
                    '${item.authorName ?? ''} • '
                        '${item.postedLabel ?? ''}\n'
                        '${item.repliesCount ?? 0} '
                        '${(item.repliesCount ?? 0) == 1 ? 'reply' : 'replies'}',
                  ),

                  if (index != discussions.length - 1)
                    SizedBox(height: Dimensions.h_10),
                ],
              );
            }),

          SizedBox(height: Dimensions.h_10),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  weatherDiscussions?.joinLabel ??
                      'Join the Conversation',
                  style: TextStyle(
                    color: _pageTheme.primaryColorDark,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: Dimensions.w_5),
                Icon(
                  CupertinoIcons.arrow_right,
                  color: _pageTheme.primaryColorDark,
                  size: Dimensions.h_12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getDiscussionIcon(int index) {
    switch (index % 3) {
      case 0:
        return CupertinoIcons.chat_bubble_2_fill;

      case 1:
        return CupertinoIcons.exclamationmark_triangle_fill;

      default:
        return CupertinoIcons.chat_bubble_fill;
    }
  }

  Color _getDiscussionIconColor(int index) {
    switch (index % 3) {
      case 0:
        return Colors.orange;

      case 1:
        return Colors.blue;

      default:
        return Colors.orange;
    }
  }
  Widget _weekAheadItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Dimensions.w_35,
          child: Icon(
            icon,
            color: iconColor,
            size: Dimensions.h_30,
          ),
        ),

        SizedBox(width: Dimensions.w_8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: _pageTheme.primaryColor,
                  fontSize: FontSize.sp_12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: Dimensions.h_2),
              Text(
                description,
                style: TextStyle(
                  color: _pageTheme.primaryColor,
                  fontSize: FontSize.sp_9_5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget latestWeatherNews() {
    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LATEST WEATHER NEWS',
                style: TextStyle(
                  color: _pageTheme.primaryColor,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Text(
                    'View All',
                    style: TextStyle(
                      color: _pageTheme.primaryColorDark,
                      fontSize: FontSize.sp_9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: Dimensions.w_3),
                  Icon(
                    CupertinoIcons.arrow_right,
                    color: _pageTheme.primaryColorDark,
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          _weatherNewsRow(
            image: Images.cityImageMobile,
            title: 'Wind Advisory Issued',
            tag: 'ALERT',
            tagColor: const Color(0xFFE53935),
            tagBackground: const Color(0xFFFFE8E8),
            time: '2 hr ago',
          ),
          _weatherNewsRow(
            image: Images.cityImageMobile,
            title: 'County Crews Prepare for\nPossible Flooding Along Pine Creek',
            tag: 'LOCAL NEWS',
            tagColor: const Color(0xFF1555D9),
            tagBackground: const Color(0xFFEAF1FF),
            time: '3 hr ago',
          ),
          _weatherNewsRow(
            image: Images.cityImageMobile,
            title: 'Smoke From Idaho Wildfires\nCould Reach Valley',
            tag: 'AIR QUALITY',
            tagColor: const Color(0xFF5B35C9),
            tagBackground: const Color(0xFFF0EAFF),
            time: '5 hr ago',
          ),
          _weatherNewsRow(
            image: Images.cityImageMobile,
            title: 'Late Snowpack Could Keep\nTrails Muddy Into June',
            tag: 'OUTDOORS',
            tagColor: const Color(0xFF27834A),
            tagBackground: const Color(0xFFE8F5EC),
            time: '6 hr ago',
          ),
        ],
      ),
    );
  }

  IconData _getWeatherConditionIcon(
      String? symbol,
      bool? isDaytime,
      ) {
    final value = symbol?.toLowerCase() ?? '';

    if (value.contains('thunder')) {
      return Icons.thunderstorm;
    }

    if (value.contains('rain') ||
        value.contains('shower')) {
      return Icons.water_drop;
    }

    if (value.contains('snow')) {
      return Icons.ac_unit;
    }

    if (value.contains('clear-night') ||
        value.contains('night')) {
      return Icons.nightlight_round;
    }

    if (value.contains('cloudy') ||
        value.contains('cloud')) {
      return isDaytime == true
          ? Icons.wb_cloudy
          : Icons.cloud;
    }

    return isDaytime == true
        ? Icons.wb_sunny
        : Icons.nightlight_round;
  }

  Color _getWeatherConditionColor(
      String? symbol,
      bool? isDaytime,
      ) {
    final value = symbol?.toLowerCase() ?? '';

    if (value.contains('thunder')) {
      return Colors.deepPurple;
    }

    if (value.contains('rain') ||
        value.contains('shower')) {
      return Colors.blue;
    }

    if (value.contains('snow')) {
      return Colors.lightBlue;
    }

    if (value.contains('cloud')) {
      return Colors.grey;
    }

    if (isDaytime == false) {
      return Colors.blueGrey;
    }

    return const Color(0xFFFFB800);
  }

  Widget _weatherNewsRow({
    required String image,
    required String title,
    required String tag,
    required Color tagColor,
    required Color tagBackground,
    required String time,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.h_5),
            child: SizedBox(
              width: Dimensions.w_55,
              height: Dimensions.h_48,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _pageTheme.highlightColor,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: Dimensions.h_5),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_5,
                        vertical: Dimensions.h_2,
                      ),
                      decoration: BoxDecoration(
                        color: tagBackground,
                        borderRadius: BorderRadius.circular(
                          Dimensions.h_3,
                        ),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: tagColor,
                          fontSize: FontSize.sp_8_5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_6),
                    Text(
                      '•',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: FontSize.sp_10,
                      ),
                    ),

                    SizedBox(width: Dimensions.w_6),

                    Text(
                      time,
                      style: TextStyle(
                          color: _pageTheme.primaryColor,
                          fontSize: FontSize.sp_10,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget adventureGuide(WeatherController controller) {
    final adventureGuide =
        controller.weatherCardData?.cards?.adventureGuide;

    final outdoorActivities = adventureGuide?.items ?? [];

    if (outdoorActivities.isEmpty) {
      return const SizedBox.shrink();
    }

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (adventureGuide?.title ?? 'Adventure Guide').toUpperCase(),
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_12,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: Dimensions.h_4),

          Text(
            adventureGuide?.subtitle ??
                "Conditions based on today's weather",
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: Dimensions.h_10),

          ...outdoorActivities.map((item) {
            return _outdoorActivityRow(
              icon: _getOutdoorActivityIcon(item.key ?? ''),

              title: item.label ?? '',

              // API score: 98.33 -> 98.33%
              score: '${item.score?.toStringAsFixed(0) ?? 0}%',

              iconColor: _getOutdoorActivityColor(
                item.key ?? '',
              ),

              scoreColor: _getScoreColor(
                item.score,
                item.suitable,
              ),

              scoreBgColor: _getScoreBackgroundColor(
                item.score,
                item.suitable,
              ),
            );
          }),

          SizedBox(height: Dimensions.h_8),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  adventureGuide?.linkLabel ??
                      'Explore Outdoor Spots',
                  style: TextStyle(
                    color: _pageTheme.primaryColorDark,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                SizedBox(width: Dimensions.w_5),

                Icon(
                  CupertinoIcons.arrow_right,
                  color: _pageTheme.primaryColorDark,
                  size: Dimensions.h_12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget commuteSchool(WeatherController controller) {
    final commuteSchool = controller.weatherCardData?.cards?.commuteSchool;
    final commuteItems = commuteSchool?.items ?? [];
    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (commuteSchool?.title ?? 'Commute & School').toUpperCase(),
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_12,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: Dimensions.h_4),
          Text(
            commuteSchool?.subtitle ??
                'Weather-based commute information',
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: Dimensions.h_10),

          ...commuteItems.map((item) {
            final statusColor = _commuteStatusColor(
              item.statusKey,
            );

            return Padding(
              padding: EdgeInsets.only(
                left: Dimensions.w_8,
                bottom: Dimensions.h_8,
              ),
              child: Row(
                children: [
                  Container(
                    height: Dimensions.h_8,
                    width: Dimensions.h_8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: statusColor,
                    ),
                  ),

                  SizedBox(width: Dimensions.w_7),

                  Expanded(
                    child: Text(
                      item.label ?? '',
                      style: TextStyle(
                        color: _pageTheme.primaryColor,
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_6,
                      vertical: Dimensions.h_3,
                    ),
                    decoration: BoxDecoration(
                      color: !_isDay ? const Color(0xFF153928):const Color(0xFFE9F4E9),
                      borderRadius: BorderRadius.circular(
                        Dimensions.h_5,
                      ),
                    ),
                    child: Text(
                      item.status ?? '',
                      style: TextStyle(
                        color: !_isDay ? AppColor.darkGreenWeather : const Color(0xFF167B24),
                        fontSize: FontSize.sp_9_5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          if (commuteSchool?.disclaimer != null) ...[
            SizedBox(height: Dimensions.h_4),
            Text(
              commuteSchool?.disclaimer ?? '',
              style: TextStyle(
                color: _pageTheme.primaryColor,
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
          SizedBox(height: Dimensions.h_8),
          Center(
            child: GestureDetector(
              onTap: () {
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    commuteSchool?.linkLabel ??
                        'View Commute Details',
                    style: TextStyle(
                      color: _pageTheme.primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(width: Dimensions.w_5),

                  Icon(
                    CupertinoIcons.arrow_right,
                    color: _pageTheme.primaryColorDark,
                    size: Dimensions.h_12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _commuteStatusColor(String? statusKey) {
    switch (statusKey?.toLowerCase()) {
      case 'good':
        return LocalStorage.getBool(GetXStorageConstants.day) != true ? AppColor.darkGreenWeather : AppColor.darkGreenSportsSecondaryText;

      case 'moderate':
        return Colors.orange;

      case 'poor':
      case 'high':
        return Colors.red;

      default:
        return AppColor.darkGreenSportsSecondaryText;
    }
  }
  Widget _weatherStoryItem({
    required String image,
    required String title,
    required String readTime,
  }) {
    return SizedBox(
      height: Dimensions.h_55,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.h_5),
            child: SizedBox(
              width: Dimensions.w_65,
              height: Dimensions.h_50,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _pageTheme.primaryColor,
                    fontSize: FontSize.sp_12,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: Dimensions.h_5),
                Text(
                  readTime,
                  style: TextStyle(
                    color: _pageTheme.primaryColor,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget outdoorLifePlanner(WeatherController controller) {
    final outdoorActivities = controller.weatherCardData?.cards?.outdoorLifePlanner ?? [];
    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OUTDOOR LIFE PLANNER',
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_12,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: Dimensions.h_4),

          Text(
            'Great day to get outside!',
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: Dimensions.h_10),

          ...outdoorActivities.map((item) {
            return _outdoorActivityRow(
              icon: _getOutdoorActivityIcon(item.activity),
              title: item.name ?? '',
              score: '${item.displayScore ?? 0}/10',
              iconColor: _getOutdoorActivityColor(
                item.activity,
              ),
              scoreColor: _getScoreColor(
                item.displayScore,
                item.suitable,
              ),
              scoreBgColor: _getScoreBackgroundColor(
                item.displayScore,
                item.suitable,
              ),
            );
          }).toList(),

          SizedBox(height: Dimensions.h_8),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View Full Planner',
                  style: TextStyle(
                    color: _pageTheme.primaryColorDark,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: Dimensions.w_5),
                Icon(
                  CupertinoIcons.arrow_right,
                  color: _pageTheme.primaryColorDark,
                  size: Dimensions.h_12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget aroundTheHouse(WeatherController controller) {
    final aroundTheHouse =
        controller.weatherCardData?.cards?.aroundTheHouse;

    final houseItems = aroundTheHouse?.items ?? [];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (aroundTheHouse?.title ?? 'Around The House').toUpperCase(),
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_12,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: Dimensions.h_4),

          Text(
            aroundTheHouse?.subtitle ?? 'Weather-based home planning',
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: Dimensions.h_10),
          ...houseItems.map((item) {
            return Padding(
              padding: EdgeInsets.only(
                left: Dimensions.w_8,
                bottom: Dimensions.h_8,
              ),
              child: Row(
                children: [
                  Container(
                    height: Dimensions.h_8,
                    width: Dimensions.h_8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.darkGreenSportsSecondaryText,
                    ),
                  ),
                  SizedBox(width: Dimensions.w_7),
                  Expanded(
                    child: Text(
                      item.label ?? '',
                      style: TextStyle(
                        color: _pageTheme.primaryColor,
                        fontSize: FontSize.sp_11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: Dimensions.h_2),

          Center(
            child: GestureDetector(
              onTap: () {
                // Navigate using:
                // aroundTheHouse?.linkUrl
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    aroundTheHouse?.linkLabel ??
                        'View Home Weather Guide',
                    style: TextStyle(
                      color: _pageTheme.primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(width: Dimensions.w_5),

                  Icon(
                    CupertinoIcons.arrow_right,
                    color: _pageTheme.primaryColorDark,
                    size: Dimensions.h_12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getOutdoorActivityIcon(String? activity) {
    switch (activity?.toLowerCase().trim()) {
      case 'hiking':
      case 'hiking-trails':
        return CupertinoIcons.star_fill;
      case 'running':
        return Icons.running_with_errors;
      case 'cycling':
        return Icons.motorcycle_sharp;
      case 'fishing':
        return CupertinoIcons.drop;
      case 'baseball':
        return CupertinoIcons.sportscourt;
      case 'boating':
        return CupertinoIcons.dot_radiowaves_right;
      case 'golf':
        return CupertinoIcons.flag;
      case 'park_day':
      case 'park day':
        return CupertinoIcons.tree;
      case 'tennis':
        return Icons.sports_tennis;
      case 'pickleball':
        return Icons.sports_tennis;
      case 'kayaking':
        return Icons.kayaking;
      case 'photography':
        return Icons.camera_alt_outlined;
      case 'camping':
      case 'camping-conditions':
        return Icons.cabin_outlined;
      case 'lake-water-conditions':
      case 'lake':
      case 'water':
        return Icons.water_outlined;
      case 'river-conditions':
      case 'river':
        return Icons.waves_rounded;
      case 'beach-conditions':
      case 'beach':
        return CupertinoIcons.sun_max_fill;

      default:
        return CupertinoIcons.sun_max_fill;
    }
  }

  Color _getOutdoorActivityColor(String? activity) {
    switch (activity?.toLowerCase()) {
      case 'fishing':
      case 'kayaking':
        return Colors.blue;

      case 'photography':
        return Colors.purple;

      default:
        return Colors.green.shade700;
    }
  }

  Color _getScoreColor(
      dynamic score,
      bool? suitable,
      ) {
    final double value =
        double.tryParse(score?.toString() ?? '0') ?? 0;

    if (suitable == false || value < 5) {
      return const Color(0xFFEF4444);
    }

    if (value < 8) {
      return const Color(0xFFF59E0B);
    }

    return _isDay !=
        true
        ? AppColor.darkGreenWeather
        : const Color(0xFF25802B);
  }

  Color _getScoreBackgroundColor(
      dynamic score,
      bool? suitable,
      ) {
    final double value =
        double.tryParse(score?.toString() ?? '0') ?? 0;

    if (suitable == false || value < 5) {
      return const Color(0xFFFFE8E8);
    }

    if (value < 8) {
      return const Color(0xFFFFF4E5);
    }

    return _isDay !=
        true
        ? const Color(0xFF153928)
        : const Color(0xFFE8F4E8);
  }
  Widget _outdoorActivityRow({
    required IconData icon,
    required String title,
    required String score,
    required Color iconColor,
    Color? scoreColor,
    Color? scoreBgColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.h_3,
      ),
      child: Row(
        children: [
          SizedBox(
            width: Dimensions.w_25,
            child: Icon(
              icon,
              color: iconColor,
              size: Dimensions.h_16,
            ),
          ),
          SizedBox(width: Dimensions.w_5),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: _pageTheme.primaryColor,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          Container(
            width: Dimensions.w_40,
            padding: EdgeInsets.symmetric(vertical: Dimensions.h_3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:  !_isDay ? const Color(0xFF153928):const Color(0xFFE9F4E9),
              borderRadius: BorderRadius.circular(Dimensions.h_5),
            ),
            child: Text(
              score,
              style: TextStyle(
                  color: !_isDay ? AppColor.darkGreenWeather : const Color(0xFF167B24),
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget sportsWeatherMetric({
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _pageTheme.primaryColor,
            fontSize: FontSize.sp_11,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),

        SizedBox(height: Dimensions.h_6),

        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: valueColor ?? _pageTheme.highlightColor,
            fontSize: FontSize.sp_11,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget bestTimeCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
    required String description,
    required String score,
    required Color scoreColor,
    required Color scoreTextColor,
  }) {
    return Container(
      width: Dimensions.w_105,
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_7,
        Dimensions.h_7,
        Dimensions.w_1,
        Dimensions.h_7,
      ),
      decoration: BoxDecoration(
        color: _pageTheme.splashColor,
        border: Border.all(
            color: _pageTheme.focusColor, width: 0.5),
        borderRadius: BorderRadius.circular(Dimensions.h_7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: Dimensions.h_25,
          ),
          SizedBox(height: Dimensions.h_8),
          Text(
            title,
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_13_5,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            time,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: _pageTheme.primaryColorDark,
              fontSize: FontSize.sp_9_5,
              fontWeight: FontWeight.w500,
              height: 1.1,
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                color: _pageTheme.primaryColor,
                fontSize: FontSize.sp_10,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ),

          SizedBox(height: Dimensions.h_5),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w_8,
              vertical: Dimensions.h_5,
            ),
            decoration: BoxDecoration(
              color: scoreColor,
              borderRadius: BorderRadius.circular(Dimensions.h_5),
            ),
            child: Text(
              score,
              style: TextStyle(
                color: scoreTextColor,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget liveMapStatCard({
    required String value,
    required String label,
    bool showArrow = false,
  }) {
    return Container(
      height: Dimensions.h_55,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_2,
        vertical: Dimensions.h_5,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(Dimensions.h_6),
        border: Border.all(
          color: const Color(0xFFE1E5EC),
          width: 0.7,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: AppColor.primaryNavyNew,
                  fontSize: FontSize.sp_16,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),

              if (showArrow) ...[
                SizedBox(width: Dimensions.w_3),
                Icon(
                  Icons.arrow_forward,
                  color: const Color(0xFF607D72),
                  size: Dimensions.h_13,
                ),
              ],
            ],
          ),
          SizedBox(height: Dimensions.h_4),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.primaryNavyNew,
              fontSize: FontSize.sp_9,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget outdoorActivityItem({
    required IconData icon,
    required String label,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Dimensions.h_38,
            height: Dimensions.h_38,
            decoration: BoxDecoration(
              color: _pageTheme.cardColor,
              shape: BoxShape.circle,
              border: Border.all(
                  color: _pageTheme.focusColor,
                  width: 0.5),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: iconColor,
              size: Dimensions.h_20,
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_9,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget weatherReportItem({
    required IconData icon,
    required Color iconColor,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Dimensions.h_38,
          height: Dimensions.h_38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _pageTheme.splashColor,
            border: Border.all(
              color: _pageTheme.focusColor,
              width: 0.5,
            ),
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: iconColor,
            size: Dimensions.h_22,
          ),
        ),
        SizedBox(height: Dimensions.h_5),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: _pageTheme.primaryColor,
            fontSize: FontSize.sp_9,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
      ],
    );
  }

  Widget weatherQuestionChip(String text) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8,vertical: Dimensions.h_8),
        decoration: BoxDecoration(
          color: _pageTheme.scaffoldBackgroundColor,
          border: Border.all(
            color: _pageTheme.focusColor,
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(Dimensions.h_5),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _pageTheme.primaryColor,
            fontSize: FontSize.sp_9_5,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
      ),
    );
  }

  Widget glanceCard({
    String? value,
    String? suffix,
    String? label,
    String? secondaryLabel,
    IconData? icon,
    Color? iconColor,
    double? fontSize
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_1,
        vertical: Dimensions.h_2,
      ),
      decoration: BoxDecoration(
        color: _pageTheme.splashColor,
        border: Border.all(
            color: _pageTheme.focusColor,
            width: 0.5),
        borderRadius: BorderRadius.circular(Dimensions.h_6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: iconColor ?? AppColor.primaryNavyNew,
              size: Dimensions.h_25,
            )
          else
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value ?? '',
                    style: TextStyle(
                      color: _pageTheme.highlightColor,
                      fontSize: fontSize  ?? FontSize.sp_18,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                  if (suffix != null)
                    TextSpan(
                      text: suffix,
                      style: TextStyle(
                        color: _pageTheme.primaryColor,
                        fontSize: FontSize.sp_12,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                ],
              ),
            ),
          SizedBox(height: Dimensions.h_7),
          Text(
            label ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_9_5,
              fontWeight: FontWeight.w800,
              height: 1.05,
            ),
          ),

          if (secondaryLabel != null) ...[
            SizedBox(height: Dimensions.h_3),
            Text(
              secondaryLabel,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _pageTheme.primaryColor,
                fontSize: FontSize.sp_9_5,
                fontWeight: FontWeight.w800,
                height: 1.05,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget secondCard(WeatherController controller) {
    final hourlyForecast = controller.weatherCardData?.cards?.hourlyForecast ?? [];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_4,
      ),
      child: CommonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HOURLY FORECAST',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: _pageTheme.primaryColor,
                fontSize: FontSize.sp_12,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),

            SizedBox(height: Dimensions.h_12),

            if (hourlyForecast.isEmpty)
              const SizedBox.shrink()
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  hourlyForecast.length > 6
                      ? 6
                      : hourlyForecast.length,
                      (index) {
                    final item = hourlyForecast[index];

                    return Expanded(
                      child: _hourlyWeatherItem(
                        time: item.displayTime ?? '',
                        isFirst: index == 0,
                        icon: getWeatherIcon(
                          item.condition?.icon?.symbol,
                          item.isDaytime,
                        ),
                        iconColor: getWeatherIconColor(
                          item.condition?.icon?.symbol,
                          item.isDaytime,
                        ),
                        temperature:
                        '${item.temperature?.value?.round() ?? 0}°',
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: Dimensions.h_12),
            GestureDetector(
              onTap: () {
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Full Hourly Forecast',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _isDay ==
                          false
                          ? Colors.white
                          : AppColor.darkBlue,
                      fontSize: FontSize.sp_11,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: Dimensions.w_4),
                  Icon(
                    Icons.arrow_forward,
                    color: _isDay ==
                        false
                        ? Colors.white
                        : AppColor.darkBlue,
                    size: Dimensions.h_13,
                  ),
                  SizedBox(width: Dimensions.w_15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData getWeatherIcon(
      String? symbol,
      bool? isDaytime,
      ) {
    final weatherSymbol = symbol?.toLowerCase() ?? '';
    if (weatherSymbol.contains('rain') ||
        weatherSymbol.contains('shower')) {
      return Icons.water_drop;
    }

    if (weatherSymbol.contains('thunder') ||
        weatherSymbol.contains('storm')) {
      return Icons.thunderstorm;
    }

    if (weatherSymbol.contains('snow')) {
      return Icons.ac_unit;
    }

    // Cloudy
    if (weatherSymbol.contains('cloud')) {
      if (isDaytime == true &&
          weatherSymbol.contains('partly')) {
        return Icons.wb_cloudy;
      }

      return isDaytime == true
          ? Icons.cloud
          : Icons.cloud_queue;
    }

    // Clear night
    if (weatherSymbol.contains('night')) {
      return Icons.nightlight_round;
    }

    // Sunny
    if (weatherSymbol.contains('sun') ||
        weatherSymbol.contains('clear')) {
      return isDaytime == true
          ? Icons.wb_sunny
          : Icons.nightlight_round;
    }

    return isDaytime == true
        ? Icons.wb_sunny
        : Icons.nightlight_round;
  }

  Color getWeatherIconColor(
      String? symbol,
      bool? isDaytime,
      ) {
    final weatherSymbol = symbol?.toLowerCase() ?? '';

    if (weatherSymbol.contains('rain') ||
        weatherSymbol.contains('shower')) {
      return Colors.blue;
    }

    if (weatherSymbol.contains('thunder') ||
        weatherSymbol.contains('storm')) {
      return Colors.deepPurple;
    }

    if (weatherSymbol.contains('snow')) {
      return Colors.lightBlue;
    }

    if (weatherSymbol.contains('cloud')) {
      return Colors.grey;
    }

    if (isDaytime == false ||
        weatherSymbol.contains('night')) {
      return Colors.blueGrey;
    }

    return Colors.orange;
  }

  Widget _hourlyWeatherItem({
    required String time,
    required IconData icon,
    required Color iconColor,
    required String temperature,
    bool isFirst = false
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          time,
          style: TextStyle(
            color: _pageTheme.primaryColorDark,
            fontSize: FontSize.sp_9,
            fontWeight: FontWeight.w600,
            height: 1.1,
          ),
        ),
        SizedBox(height: Dimensions.h_6),
        Icon(
          icon,
          size: Dimensions.h_25,
          color: iconColor,
        ),
        SizedBox(height: Dimensions.h_6),
        Text(
          temperature,
          style: TextStyle(
            color: _pageTheme.highlightColor,
            fontSize: FontSize.sp_15,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
      ],
    );
  }

  Widget firstCard() {
    return GetBuilder(
        init: weatherController,
        id: ControllerBuilders.weatherController,
        builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
            padding: EdgeInsets.fromLTRB(
                Dimensions.w_8,
                Dimensions.h_8,
                Dimensions.w_8,
                Dimensions.h_15),
            decoration: BoxDecoration(
                color: AppColor.alertRed,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_10),topRight: Radius.circular(Dimensions.h_10))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning_amber,
                            color: AppColor.white,
                            size: Dimensions.h_18,
                          ),
                          SizedBox(width: Dimensions.w_5),
                          Expanded(
                            child: Text(
                              'WIND ADVISORY',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: FontSize.sp_14,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.closeAlert = true;
                              controller.update([ControllerBuilders.weatherController]);
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColor.white,
                              size: Dimensions.h_18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_6),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_25),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Gusts up to 30 mph possible until 8 PM.',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_12),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'View Alert',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: FontSize.sp_12,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                            SizedBox(width: Dimensions.w_4),
                            Icon(
                              Icons.arrow_forward,
                              color: AppColor.white,
                              size: Dimensions.h_13,
                            ),
                            SizedBox(width: Dimensions.w_15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Dimensions.w_8),
              ],
            ),
          );
        }
    );
  }

  IconData _getSportIcon(String? sport) {
    switch (sport?.toLowerCase()) {
      case 'football':
        return Icons.sports_football;

      case 'baseball':
        return Icons.sports_baseball;

      case 'basketball':
        return Icons.sports_basketball;

      case 'soccer':
        return Icons.sports_soccer;

      case 'tennis':
        return Icons.sports_tennis;

      default:
        return Icons.sports;
    }
  }

  Color _getSportIconColor(String? sport) {
    switch (sport?.toLowerCase()) {
      case 'football':
        return const Color(0xFF795548);

      case 'baseball':
        return const Color(0xFFE53935);

      case 'basketball':
        return Colors.orange;

      case 'soccer':
        return Colors.green;

      default:
        return _pageTheme.highlightColor;
    }
  }

  Widget _buildTemperatureLabel(String temperatureLabel) {
    final parts = temperatureLabel.split(' ');

    final temperature =
    parts.isNotEmpty ? parts.first : '';

    final remainingText = parts.length > 1
        ? ' ${parts.sublist(1).join(' ')}'
        : '';

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: temperature,
            style: TextStyle(
              color: _pageTheme.highlightColor,
              fontSize: FontSize.sp_20,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          TextSpan(
            text: remainingText,
            style: TextStyle(
              color: _pageTheme.primaryColor,
              fontSize: FontSize.sp_8_5,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingBackground(String? rating) {
    switch (rating?.toLowerCase()) {
      case 'excellent':
        return _isDay !=
            true
            ? const Color(0xFF153928)
            : const Color(0xFFE8F4E8);

      case 'good':
        return const Color(0xFFFFF3CD);

      case 'fair':
        return const Color(0xFFFFE0B2);

      default:
        return const Color(0xFFFFE5E5);
    }
  }

  Color _getRatingColor(String? rating) {
    switch (rating?.toLowerCase()) {
      case 'excellent':
        return _isDay !=
            true
            ? AppColor.darkGreenWeather
            : const Color(0xFF27752D);

      case 'good':
        return const Color(0xFFB77900);

      case 'fair':
        return Colors.deepOrange;

      default:
        return Colors.red;
    }
  }

  Color _getDelayRiskColor(String? delayRisk) {
    switch (delayRisk?.toLowerCase()) {
      case 'very low':
      case 'low':
        return _isDay !=
            true
            ? AppColor.darkGreenWeather
            : const Color(0xFF25802B);

      case 'moderate':
        return Colors.orange;

      case 'high':
      case 'very high':
        return Colors.red;

      default:
        return _pageTheme.primaryColor;
    }
  }


  Widget buildHeroHeader() {
    return GetBuilder(
      id: ControllerBuilders.weatherController,
      init: weatherController,
      builder: (controller) {
        final bool isNight = controller.weatherHeroData?.sceneId.toString().toLowerCase().contains('night') ?? false;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            AppCacheImage(imageUrl: controller.weatherHeroData?.city?.cityImage ?? '',
                widthSize: Get.width,
                fit: BoxFit.cover,
                isShadow: false,
                size: Dimensions.h_310,
                radius: 0),
            if (isNight)
              Positioned.fill(child: Container(color: Colors.black.withValues(alpha: 0.50))),
            Positioned.fill(child: IgnorePointer(child: WeatherAnimationOverlay(type: getWeatherAnimationType(controller.weatherHeroData?.sceneId)))),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_12,top: Dimensions.h_85),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_5,bottom: Dimensions.h_20),
                    child: Text(
                      controller.weatherHeroData?.greeting ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSize.sp_18,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 25,
                              offset: const Offset(0, 2)),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text:  TextSpan(
                                children: [
                                  TextSpan(
                                    text: controller.weatherHeroData?.currentWeather?.temperature?.value.toString() ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_60,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withValues(alpha: 0.4),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextSpan(
                                    text: "°${controller.weatherHeroData?.currentWeather?.temperature?.unit ?? ''}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_22,
                                      fontWeight: FontWeight.w600,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black.withValues(alpha: 0.3),
                                            blurRadius: 10,
                                            offset: const Offset(0, 2)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.h_5),
                            Padding(
                              padding:  EdgeInsets.only(left: Dimensions.w_5),
                              child: Text(
                                controller.weatherHeroData?.weatherType ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_16,
                                  fontWeight: FontWeight.w800,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_5),
                            Padding(
                              padding:  EdgeInsets.only(left: Dimensions.w_5),
                              child: Text(
                                'Feels like ${controller.weatherHeroData?.currentWeather?.feelsLike?.value.toString() ?? ''}°${controller.weatherHeroData?.currentWeather?.feelsLike?.unit.toString() ?? ''}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_12,
                                  fontWeight: FontWeight.w800,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_5),
                            Padding(
                              padding:  EdgeInsets.only(left: Dimensions.w_5),
                              child: Row(
                                children: [
                                  Text(
                                    'H: 68°',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_13_5,
                                      fontWeight: FontWeight.w800,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withValues(alpha: 0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                        Shadow(
                                          color: Colors.black.withValues(alpha: 0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                        Shadow(
                                          color: Colors.black.withValues(alpha: 0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.w_20),
                                  Text(
                                    'L: 49°',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_13_5,
                                      fontWeight: FontWeight.w800,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withValues(alpha: 0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                        Shadow(
                                          color: Colors.black.withValues(alpha: 0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                        Shadow(
                                          color: Colors.black.withValues(alpha: 0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.h_5),
                            Padding(
                              padding:  EdgeInsets.only(left: Dimensions.w_5),
                              child: Text(
                                controller.weatherHeroData?.updatedLabel ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w800,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: Dimensions.w_30)
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

}
