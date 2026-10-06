import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wikixm/Presentation/events/events_screen_shimmer.dart';
import 'package:wikixm/Presentation/garage/controller.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import 'package:wikixm/constants/images.dart';
import '../../constants/fontsize.dart';
import '../../data/datasource/remote/models/response/market_brief_charts.dart';
import '../widgets/AnimatedImage.dart';
import '../widgets/cache_image.dart';
import '../widgets/common_bullet.dart';
import '../widgets/drawer/src/slider_drawer.dart';

class MarketBrief extends StatefulWidget {
  const MarketBrief({super.key});

  @override
  State<MarketBrief> createState() => _MarketBriefState();
}

class _MarketBriefState extends State<MarketBrief> {
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey<SliderDrawerState>();
  final GarageController garageController = Get.put(GarageController());

  @override
  void initState() {
    super.initState();
    garageController.getMarketBriefData();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
      top: false,
      bottom: false,
      isNavbar: false,
      bodyPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetBuilder(
        init: garageController,
        id: ControllerBuilders.marketBriefController,
        builder: (controller) {
          return controller.isLoading
              ? EventsScreenShimmer()
              : CommonScrollBlurScaffold(
                  expandedHeight: Dimensions.h_330,
                  expandedColor: Colors.white,
                  collapsedColor: Theme.of(context).highlightColor,
                  hero: buildHeroHeader(isLight, controller),
                  showBack: true,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            marketStats(isLight, controller),
                            SizedBox(height: Dimensions.h_15),
                            garageListing(isLight),
                            SizedBox(height: Dimensions.h_15),
                            averageListing(isLight),
                            SizedBox(height: Dimensions.h_15),
                            trending(isLight),
                            SizedBox(height: Dimensions.h_15),
                            priceTrends(isLight),
                            SizedBox(height: Dimensions.h_15),
                            marketForecast(isLight),
                            SizedBox(height: Dimensions.h_15),
                            upcomingSales(isLight),
                            SizedBox(height: Dimensions.h_15),
                            keyDates(isLight),
                            SizedBox(height: Dimensions.h_15),
                            quickLinks(isLight),
                            SizedBox(height: Dimensions.h_15),
                            Stack(
                              children: [
                                AppCacheImage(
                                  imageUrl: 'https://preetis-html.vercel.app/assets/images/garage/my-garage-version2/neighbor-market.webp',
                                  widthSize: Get.width,
                                  size: Dimensions.h_150,
                                  borderColor: isLight ? AppColor.transparent : AppColor.white,
                                  alignment: Alignment(0, -1),
                                  radius: Dimensions.h_8,
                                  borderWidth: isLight ? 0.5 : 2,
                                  isShadow: true,
                                ),
                                Positioned.fill(
                                  child: Container(
                                    height: Dimensions.h_150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.h_8),
                                      gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [const Color(0xFF020B15).withValues(alpha: 0.85), const Color(0xFF020B15).withValues(alpha: 0.65), const Color(0xFF020B15).withValues(alpha: 0.35), Colors.transparent], stops: const [0.0, 0.30, 0.58, 1.0]),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: Dimensions.h_10,
                                  left: Dimensions.w_8,
                                  right: Dimensions.w_8,
                                  child: Text(
                                    'Great deals\nbring great neighbors.',
                                    style: TextStyle(color: Colors.white, fontSize: FontSize.sp_22, fontWeight: FontWeight.w900, height: 1.1),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_15),
                            tips(isLight),
                            // SizedBox(height: Dimensions.h_15),
                            // CommonCard(
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Icon(CupertinoIcons.sparkles, size: Dimensions.h_25, color: Theme.of(context).primaryColor),
                            //       SizedBox(width: Dimensions.w_12),
                            //       Expanded(
                            //         child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             SizedBox(height: Dimensions.h_2),
                            //             Row(
                            //               children: [
                            //                 Text(
                            //                   'ASK WIKIXM AI',
                            //                   style: TextStyle(color: Theme.of(Get.context!).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, letterSpacing: 0.1),
                            //                 ),
                            //                 Container(
                            //                   margin: EdgeInsets.only(left: Dimensions.w_4),
                            //                   padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_3),
                            //                   decoration: BoxDecoration(color: !isLight ? const Color(0xffffc264) : const Color(0xFF97590a), borderRadius: BorderRadius.circular(999)),
                            //                   child: Text(
                            //                     'COMING SOON',
                            //                     style: TextStyle(color: !isLight ? AppColor.black : AppColor.white, fontSize: FontSize.sp_7, fontWeight: FontWeight.w800, letterSpacing: 0.5, height: 1),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //             SizedBox(height: Dimensions.h_5),
                            //             Text(
                            //               "Ask anything about pine valley events, places, venues and more",
                            //               style: TextStyle(color: Theme.of(Get.context!).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
                            //             ),
                            //             SizedBox(height: Dimensions.h_6),
                            //           ],
                            //         ),
                            //       ),
                            //       Container(
                            //         margin: EdgeInsets.only(left: Dimensions.w_20, right: Dimensions.w_10),
                            //         padding: EdgeInsets.symmetric(vertical: Dimensions.h_5, horizontal: Dimensions.w_5),
                            //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.darkBlue),
                            //         child: Icon(CupertinoIcons.chat_bubble, size: Dimensions.h_18, color: AppColor.white),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: Dimensions.h_20)),
                  ],
                );
        },
      ),
    );
  }

  Widget marketForecast(bool isLight) {
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final orange = isLight ? const Color(0xFFA14F00) : const Color(0xFFFFC36C);
    final orangeSoft = isLight ? const Color(0xFFFFF3E4) : const Color(0xFF49371F);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);
    final green = isLight ? const Color(0xFF087C4B) : const Color(0xFF64D9A2);
    final greenSoft = isLight ? const Color(0xFFE8F7EF) : const Color(0xFF123D36);
    final seasonality = garageController.marketBriefData?.seasonality ?? [];

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Seasonality & Market Forecast'.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View Full Forecast',
                    style: TextStyle(color: blue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(CupertinoIcons.arrow_right, color: blue, size: Dimensions.h_8),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: seasonality.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, childAspectRatio: 0.72),
          itemBuilder: (context, index) {
            final item = seasonality[index];
            final key = item.key?.toLowerCase() ?? '';
            Color color;
            Color softColor;
            switch (key) {
              case 'fall':
                color = orange;
                softColor = orangeSoft;
                break;
              case 'winter':
                color = blue;
                softColor = blueSoft;
                break;
              case 'summer':
              case 'spring':
              default:
                color = green;
                softColor = greenSoft;
                break;
            }

            final points = item.points ?? [];

            return Container(
              padding: EdgeInsets.all(Dimensions.w_5),
              decoration: BoxDecoration(
                color: softColor.withValues(alpha: isLight ? 0.65 : 0.55),
                borderRadius: BorderRadius.circular(Dimensions.h_8),
                border: Border.all(color: color.withValues(alpha: 0.35), width: 0.7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.h_6),
                        child: AppCacheImage(imageUrl: "https://staging.wikixm.com${item.image ?? ''}", widthSize: Get.width, size: Dimensions.h_120, fit: BoxFit.cover),
                      ),
                      Positioned(
                        left: Dimensions.w_5,
                        top: Dimensions.h_5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.h_6),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_4),
                              decoration: BoxDecoration(
                                color: isLight ? Colors.white.withValues(alpha: 0.68) : const Color(0xFF0B2035).withValues(alpha: 0.62),
                                borderRadius: BorderRadius.circular(Dimensions.h_6),
                                border: Border.all(color: isLight ? Colors.white.withValues(alpha: 0.75) : Colors.white.withValues(alpha: 0.16), width: 0.7),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: isLight ? 0.08 : 0.18),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(seasonIcon(item.icon), color: color, size: Dimensions.h_15),
                                  SizedBox(width: Dimensions.w_3),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title ?? 'Uncategorized',
                                        style: TextStyle(color: ink, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w800, height: 1),
                                      ),
                                      SizedBox(height: Dimensions.h_2),
                                      Text(
                                        item.period ?? '',
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5, height: 1),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final point in points.take(3)) ...[forecastPoint(text: point, color: color, ink: Theme.of(context).highlightColor), if (point != points.take(3).last) SizedBox(height: Dimensions.h_4)],
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.h_5),
                  Container(height: 0.4, color: isLight ? Colors.grey : Colors.white24),
                  SizedBox(height: Dimensions.h_5),
                  Row(
                    children: [
                      Icon(CupertinoIcons.circle_fill, color: color, size: Dimensions.h_7),
                      SizedBox(width: Dimensions.w_4),
                      Expanded(
                        child: Text(
                          item.status ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: color, fontSize: FontSize.sp_9, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  IconData seasonIcon(String? icon) {
    switch (icon?.toLowerCase()) {
      case 'sun':
        return CupertinoIcons.sun_max;

      case 'leaves':
        return CupertinoIcons.leaf_arrow_circlepath;

      case 'snowflake':
        return CupertinoIcons.snow;

      case 'leaf':
        return CupertinoIcons.arrow_up_right;

      default:
        return Icons.energy_savings_leaf_outlined;
    }
  }

  Widget forecastPoint({required String text, required Color color, required Color ink}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: Dimensions.h_3),
          child: Icon(CupertinoIcons.circle_fill, color: color, size: Dimensions.h_4),
        ),
        SizedBox(width: Dimensions.w_4),
        Expanded(
          child: Text(
            text,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: ink, fontSize: FontSize.sp_9, fontWeight: FontWeight.w400, height: 1.2),
          ),
        ),
      ],
    );
  }

  Widget upcomingSales(bool isLight) {
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final copy = isLight ? const Color(0xFF344779) : const Color(0xFFC9D5E8);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);
    final muted = isLight ? const Color(0xFF63728F) : const Color(0xFFAAB8CF);
    final line = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);

    final sales = garageController.marketBriefData?.sales ?? [];

    final garageEvents = [
      {'image': 'https://preetis-html.vercel.app/assets/images/garage/my-garage-version2/sale-talus.webp', 'month': 'JUN', 'date': '29', 'title': 'Talus Neighborhood Community Sale', 'location': 'Talus Dr, Issaquah, WA', 'dateText': 'Sat., Jun 29', 'time': '8:00 AM – 4:00 PM', 'items': '20+ homes', 'category': 'Multi-family event'},
      {'image': 'https://preetis-html.vercel.app/assets/images/garage/my-garage-version2/sale-highlands.webp', 'month': 'JUL', 'date': '6', 'title': 'Issaquah Highlands Garage Sale', 'location': 'Highlands Dr, Issaquah, WA', 'dateText': 'Sat., Jul 6', 'time': '8:00 AM – 3:00 PM', 'items': '15+ homes', 'category': 'Household, kids, outdoor'},
      {'image': 'https://preetis-html.vercel.app/assets/images/garage/my-garage-version2/sale-community.webp', 'month': 'JUL', 'date': '13', 'title': 'Issaquah Community Garage Sale Day', 'location': 'Various Locations', 'dateText': 'Sat., Jul 13', 'time': '8:00 AM – 4:00 PM', 'items': 'City-wide event', 'category': 'Multiple categories'},
      {
        'image': 'https://preetis-html.vercel.app/assets/images/garage/my-garage-version2/sale-providence.webp',
        'month': 'AUG',
        'date': '3',
        'title': 'Providence Point Neighborhood Sale',
        'location': 'Providence Point, Issaquah, WA',
        'dateText': 'Sat., Aug 3',
        'time': '8:00 AM – 2:00 PM',
        'items': '10+ homes',
        'category': 'Furniture, décor, tools',
      },
    ];

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppCacheImage(imageUrl: Images.garageSale, size: Dimensions.h_45, widthSize: Dimensions.h_45, radius: Dimensions.h_8, isShadow: false, fit: BoxFit.contain),
            SizedBox(width: Dimensions.w_10),
            Expanded(
              child: Text(
                'Upcoming Garage Sales in Issaquah'.toUpperCase(),
                maxLines: 2,
                style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Dimensions.h_18),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(color: blue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(width: Dimensions.w_2),
                    Icon(CupertinoIcons.arrow_right, color: blue, size: Dimensions.h_8),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_5),

        if (sales.isEmpty)
          CommonCard(
            height: Dimensions.h_100,
            child: Center(
              child: Text(
                'No upcoming garage sales have been posted for this town.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700),
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: garageEvents.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, childAspectRatio: 0.60),
            itemBuilder: (context, index) {
              final item = garageEvents[index];

              return garageEventCard(item: item, isLight: isLight, surface: Theme.of(context).scaffoldBackgroundColor, ink: ink, copy: copy, muted: muted, line: line, blue: blue, blueSoft: blueSoft);
            },
          ),
      ],
    );
  }

  Widget keyDates(bool isLight) {
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);
    final line = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);
    final green = isLight ? const Color(0xFF087C4B) : const Color(0xFF64D9A2);
    final holidays = garageController.marketBriefData?.holidays ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.h_5),
              decoration: BoxDecoration(color: blueSoft, borderRadius: BorderRadius.circular(Dimensions.h_8)),
              child: Icon(Icons.calendar_month, size: Dimensions.h_18, color: blue),
            ),
            SizedBox(width: Dimensions.w_10),
            Expanded(
              child: Text(
                'Key Dates & Holidays'.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View Full Seasonal Guide',
                    style: TextStyle(color: blue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(CupertinoIcons.arrow_right, color: blue, size: Dimensions.h_8),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: ListView.builder(
            itemCount: holidays.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (c, i) {
              final holiday = holidays[i];

              final date = DateTime.tryParse(holiday.date ?? '');

              final month = date != null ? DateFormat('MMM').format(date).toUpperCase() : '';

              final day = date != null ? DateFormat('d').format(date) : '';

              return CommonCard(
                margin: EdgeInsets.only(bottom: i != holidays.length - 1 ? Dimensions.h_10 : 0),
                color: Theme.of(context).scaffoldBackgroundColor,
                isBorder: false,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Dimensions.h_40,
                      height: Dimensions.h_40,
                      decoration: BoxDecoration(
                        color: isLight ? Colors.white : AppColor.darkCardColor,
                        borderRadius: BorderRadius.circular(Dimensions.h_8),
                        border: Border.all(color: line, width: 0.8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            month,
                            style: TextStyle(color: isLight ? const Color(0xFFB4232D) : const Color(0xFFFF8E96), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(height: Dimensions.h_3),
                          Text(
                            day,
                            style: TextStyle(color: isLight ? const Color(0xFFB4232D) : const Color(0xFFFF8E96), fontSize: FontSize.sp_15, height: 0.9, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Dimensions.w_7),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (holiday.title ?? 'Uncategorized').toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: ink, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(height: Dimensions.h_4),
                          Text(
                            holiday.suggestions ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, height: 1.15, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: Dimensions.h_2),
                          Row(
                            children: [
                              Icon(holidayDemandIcon(holiday.demandIcon), size: Dimensions.h_15, color: green),
                              SizedBox(width: Dimensions.w_2),
                              Expanded(
                                child: Text(
                                  holiday.demandLabel ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: green, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w800),
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
      ],
    );
  }

  IconData holidayDemandIcon(String? icon) {
    switch (icon?.toLowerCase()) {
      case 'trending-up':
        return Icons.trending_up;

      default:
        return Icons.trending_up;
    }
  }

  Widget quickLinks(bool isLight) {
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);

    final links = garageController.marketBriefData?.quickLinks ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.h_5),
              decoration: BoxDecoration(color: blueSoft, borderRadius: BorderRadius.circular(Dimensions.h_8)),
              child: Icon(CupertinoIcons.link, size: Dimensions.h_18, color: blue),
            ),
            SizedBox(width: Dimensions.w_10),
            Expanded(
              child: Text(
                'Quick Links'.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        GridView.builder(
          itemCount: links.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, childAspectRatio: 1.3),
          itemBuilder: (context, index) {
            final link = links[index];

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // Use link.href here when navigation is implemented.
              },
              child: CommonCard(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      width: Dimensions.h_30,
                      height: Dimensions.h_30,
                      decoration: BoxDecoration(color: blueSoft, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                      child: Icon(quickLinkIcon(link.icon), size: Dimensions.h_20, color: blue),
                    ),
                    const Spacer(),
                    Text(
                      link.label ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ink, fontSize: FontSize.sp_10, height: 1.15, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  IconData quickLinkIcon(String? icon) {
    switch (icon?.toLowerCase()) {
      case 'garage':
        return CupertinoIcons.home;

      case 'plus':
        return CupertinoIcons.add;

      case 'calendar':
        return CupertinoIcons.calendar;

      case 'trending-up':
        return Icons.trending_up;

      default:
        return CupertinoIcons.link;
    }
  }

  Widget tips(bool isLight) {
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);

    final sellingTips = garageController.marketBriefData?.sellingTips ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.h_5),
              decoration: BoxDecoration(color: blueSoft, borderRadius: BorderRadius.circular(Dimensions.h_8)),
              child: Icon(CupertinoIcons.lightbulb, size: Dimensions.h_18, color: blue),
            ),
            SizedBox(width: Dimensions.w_10),
            Expanded(
              child: Text(
                'Tips for Buyers & Sellers'.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: ListView.builder(
            itemCount: sellingTips.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final tip = sellingTips[index];

              final IconData icon;

              switch (tip.icon?.toLowerCase()) {
                case 'camera':
                  icon = CupertinoIcons.camera;
                  break;

                case 'tag':
                  icon = CupertinoIcons.tag;
                  break;

                case 'garage':
                  icon = CupertinoIcons.home;
                  break;

                default:
                  icon = CupertinoIcons.lightbulb;
              }

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: CommonCard(
                  isBorder: false,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  margin: EdgeInsets.only(bottom: index != sellingTips.length - 1 ? Dimensions.h_8 : 0),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7, vertical: Dimensions.h_6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: Dimensions.h_35,
                        height: Dimensions.h_35,
                        decoration: BoxDecoration(color: blueSoft, borderRadius: BorderRadius.circular(Dimensions.h_8)),
                        child: Icon(icon, size: Dimensions.h_20, color: blue),
                      ),
                      SizedBox(width: Dimensions.w_8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tip.title ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: Dimensions.h_2),
                            Text(
                              tip.description ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, height: 1.2, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget garageEventCard({required Map<String, dynamic> item, required bool isLight, required Color surface, required Color ink, required Color copy, required Color muted, required Color line, required Color blue, required Color blueSoft}) {
    return CommonCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_8), topRight: Radius.circular(Dimensions.h_8)),
                child: AppCacheImage(imageUrl: item['image'] as String, radius: 0, widthSize: Get.width, size: Dimensions.h_100, fit: BoxFit.cover),
              ),
              Positioned(
                left: Dimensions.w_6,
                bottom: Dimensions.h_6,
                child: Container(
                  width: Dimensions.w_32,
                  padding: EdgeInsets.symmetric(vertical: Dimensions.h_4),
                  decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                  child: Column(
                    children: [
                      Text(
                        item['month'] as String,
                        style: TextStyle(color: blue, fontSize: FontSize.sp_8, fontWeight: FontWeight.w900, height: 1),
                      ),
                      SizedBox(height: Dimensions.h_2),
                      Text(
                        item['date'] as String,
                        style: TextStyle(color: ink, fontSize: FontSize.sp_13, fontWeight: FontWeight.w900, height: 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(Dimensions.w_5, Dimensions.h_6, Dimensions.w_7, Dimensions.h_6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1.15),
                ),
                SizedBox(height: Dimensions.h_5),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_4),
                  child: Text(
                    item['location'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w400, height: 1),
                  ),
                ),
                SizedBox(height: Dimensions.h_7),
                eventDetailRow(icon: CupertinoIcons.calendar, text: item['dateText'] as String, color: Theme.of(context).highlightColor),
                SizedBox(height: Dimensions.h_4),
                eventDetailRow(icon: CupertinoIcons.clock, text: item['time'] as String, color: Theme.of(context).highlightColor),
                SizedBox(height: Dimensions.h_4),
                eventDetailRow(icon: CupertinoIcons.tag, text: item['items'] as String, color: Theme.of(context).highlightColor),
                SizedBox(height: Dimensions.h_4),
                eventDetailRow(icon: CupertinoIcons.tag_fill, text: item['category'] as String, color: Theme.of(context).highlightColor),
                SizedBox(height: Dimensions.h_10),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: Dimensions.h_25,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                            foregroundColor: AppColor.white,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                          ),
                          child: Text(
                            'View Details',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_4),
                    Expanded(
                      child: SizedBox(
                        height: Dimensions.h_25,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: blue,
                            side: BorderSide(color: blue, width: 0.5),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                          ),
                          child: Text(
                            'Get Directions',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: blue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w700),
                          ),
                        ),
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

  Widget eventDetailRow({required IconData icon, required String text, required Color color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: Dimensions.w_8),
        Icon(icon, color: color, size: Dimensions.h_12),
        SizedBox(width: Dimensions.w_4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: color, fontSize: FontSize.sp_9, fontWeight: FontWeight.w400, height: 1),
          ),
        ),
      ],
    );
  }

  Widget trending(bool isLight) {
    final surface = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF0B2035);
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final muted = isLight ? const Color(0xFF63728F) : const Color(0xFFAAB8CF);
    final line = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);
    final green = isLight ? const Color(0xFF087C4B) : const Color(0xFF64D9A2);

    final categories = (garageController.marketBriefData?.categories ?? []).where((item) => (item.active ?? 0) > 0).take(5).toList();

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trending Categories'.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View All Categories',
                    style: TextStyle(color: blue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(CupertinoIcons.arrow_right, color: blue, size: Dimensions.h_8),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_7),
        CommonCard(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final item = categories[index];
              final title = item.title?.trim().isNotEmpty == true ? item.title!.trim() : 'Uncategorized';
              final active = item.active?.toString() ?? '0';
              final growth = item.growthPercent != null ? '${item.growthPercent}%' : '—';
              final icon = categoryIcon(title);
              return inventoryStat(rank: '${index + 1}', title: title, active: '$active active', change: growth, icon: icon, color: blue, softColor: blueSoft, ink: ink, muted: muted, line: line, surface: surface, green: green);
            },
          ),
        ),
      ],
    );
  }

  IconData categoryIcon(String title) {
    switch (title.toLowerCase()) {
      case 'home & garden':
        return CupertinoIcons.house;

      case 'vehicles':
        return CupertinoIcons.car;

      case 'baby & kids':
        return CupertinoIcons.person_2;

      case 'health & beauty':
        return CupertinoIcons.heart;

      case 'electronics & media':
        return CupertinoIcons.tag;

      default:
        return CupertinoIcons.tag;
    }
  }

  Widget inventoryStat({required String rank, required String title, required String active, required String change, required IconData icon, required Color color, required Color softColor, required Color ink, required Color muted, required Color line, required Color surface, required Color green}) {
    return CommonCard(
      margin: EdgeInsets.only(bottom: Dimensions.h_4),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_5),
      color: Theme.of(context).scaffoldBackgroundColor,
      isBorder: false,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Dimensions.h_28,
            height: Dimensions.h_28,
            decoration: BoxDecoration(color: softColor, borderRadius: BorderRadius.circular(Dimensions.h_7)),
            child: Icon(icon, color: color, size: Dimensions.h_16),
          ),
          SizedBox(width: Dimensions.w_6),
          SizedBox(
            width: Dimensions.w_12,
            child: Text(
              rank,
              textAlign: TextAlign.center,
              style: TextStyle(color: muted, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, height: 1),
            ),
          ),
          SizedBox(width: Dimensions.w_4),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: ink, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1),
            ),
          ),

          SizedBox(width: Dimensions.w_5),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                change,
                style: TextStyle(color: green, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          SizedBox(width: Dimensions.w_5),
          Text(
            active,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: muted, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1),
          ),
        ],
      ),
    );
  }

  Widget priceTrends(bool isLight) {
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final muted = isLight ? const Color(0xFF63728F) : const Color(0xFFAAB8CF);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);
    final categories = garageController.marketBriefData?.categories ?? [];
    final prices = garageController.allPrices ? categories : categories.take(6).toList();
    final currentPrices = categories.map((category) => category.currentPrice).whereType<num>().map((price) => price.toDouble()).toList();
    final maxCurrentPrice = currentPrices.isEmpty ? 0.0 : currentPrices.reduce((a, b) => a > b ? a : b);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Price Trends by Category'.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
              ),
            ),
            if (categories.length > 6)
              GestureDetector(
                onTap: () {
                  garageController.allPrices = !garageController.allPrices;
                  garageController.update([ControllerBuilders.marketBriefController]);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      garageController.allPrices ? 'Show Less' : 'View All',
                      style: TextStyle(color: blue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(width: Dimensions.w_2),
                    Icon(garageController.allPrices ? CupertinoIcons.chevron_up : CupertinoIcons.arrow_right, color: blue, size: Dimensions.h_8),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: Dimensions.h_7),
        CommonCard(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: prices.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final category = prices[index];

              final currentPrice = category.currentPrice;
              final previousPrice = category.previousPrice;

              final currentProgress = currentPrice != null && maxCurrentPrice > 0 ? currentPrice.toDouble() / maxCurrentPrice : 0.0;

              final previousProgress = previousPrice != null && maxCurrentPrice > 0 ? previousPrice.toDouble() / maxCurrentPrice : 0.0;

              final title = category.title?.trim().isNotEmpty == true ? category.title!.trim() : 'Uncategorized';

              final currentValue = currentPrice != null ? '\$${NumberFormat('#,##0.##').format(currentPrice)}' : 'No data';

              final previousValue = previousPrice != null ? '\$${NumberFormat('#,##0.##').format(previousPrice)}' : 'No data';

              return price(title: title, value: currentValue, previousValue: previousValue, currentProgress: currentProgress, previousProgress: previousProgress, hasCurrentPrice: currentPrice != null, hasPreviousPrice: previousPrice != null, ink: ink, muted: muted, blue: blue, blueSoft: blueSoft, isLight: isLight);
            },
          ),
        ),
      ],
    );
  }

  Widget price({required String title, required String value, required String previousValue, required double currentProgress, required double previousProgress, required bool hasCurrentPrice, required bool hasPreviousPrice, required Color ink, required Color muted, required Color blue, required Color blueSoft, required bool isLight}) {
    return CommonCard(
      margin: EdgeInsets.only(bottom: Dimensions.h_4),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
      color: Theme.of(context).scaffoldBackgroundColor,
      isBorder: false,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: ink, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1),
          ),
          SizedBox(width: Dimensions.w_15),
          Expanded(
            flex: 5,
            child: SizedBox(
              height: Dimensions.h_18,
              child: Align(
                alignment: Alignment.centerLeft,
                child: hasCurrentPrice
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.h_10),
                        child: Container(
                          height: Dimensions.h_5,
                          width: double.infinity,
                          color: blueSoft,
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: currentProgress.clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [blue, isLight ? const Color(0xFF45B5D8) : const Color(0xFF56D8F3)]),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_8),
          SizedBox(
            width: Dimensions.w_48,
            height: Dimensions.h_25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: FontSize.sp_10,
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: hasCurrentPrice ? blue : blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w900, height: 1),
                  ),
                ),

                SizedBox(height: Dimensions.h_3),

                SizedBox(
                  height: FontSize.sp_9,
                  child: Text(
                    previousValue,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: muted, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, height: 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget aiBrief() {
    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppCacheImage(imageUrl: "https://preetis-html.vercel.app/assets/images/school/version2/ai-guide.webp", size: Dimensions.h_28, widthSize: Dimensions.h_28, isCircle: true, isShadow: false),
              SizedBox(width: Dimensions.w_10),
              Text(
                'AI Selling Brief'.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_3),
                decoration: BoxDecoration(color: const Color(0xFF6743e6), borderRadius: BorderRadius.circular(99)),
                child: Text(
                  'BETA'.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_12),
            child: Text(
              'Good morning, Sean. You have \$2,180 in potential cash across your Garage.',
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800, height: 1.2),
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: Dimensions.w_8),
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (c, i) {
              return Padding(
                padding: EdgeInsets.only(bottom: Dimensions.h_6),
                child: CommonBulletItem(text: 'Grill and sofa demand is strong this month.'),
              );
            },
          ),
          SizedBox(height: Dimensions.h_8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Ask AI about Garage',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, height: 1),
              ),
              SizedBox(width: Dimensions.w_4),
              Icon(Icons.arrow_forward, color: Theme.of(context).primaryColorDark, size: Dimensions.h_13),
              SizedBox(width: Dimensions.w_15),
            ],
          ),
        ],
      ),
    );
  }

  Widget marketStats(bool isLight, GarageController controller) {
    final surface = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF0B2035);
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final copy = isLight ? const Color(0xFF344779) : const Color(0xFFC9D5E8);
    final muted = isLight ? const Color(0xFF63728F) : const Color(0xFFAAB8CF);
    final line = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);
    final red = isLight ? const Color(0xFFB4232D) : const Color(0xFFFF8E96);
    final redSoft = isLight ? const Color(0xFFFFF0F1) : const Color(0xFF48242B);
    final green = isLight ? const Color(0xFF087C4B) : const Color(0xFF64D9A2);
    final greenSoft = isLight ? const Color(0xFFE8F7EF) : const Color(0xFF123D36);
    final purple = isLight ? const Color(0xFF7657FF) : const Color(0xFFAB98FF);
    final purpleSoft = isLight ? const Color(0xFFF1EDFF) : const Color(0xFF29244F);
    final stats = controller.marketBriefData?.stats;
    final activeListings = stats?.active?.toString() ?? '';
    final averagePrice = stats?.averagePrice != null ? '\$${NumberFormat('#,##0.00').format(stats!.averagePrice)}' : '';
    final soldWeek = stats?.soldWeek?.toString() ?? '';
    final priceDrops = stats?.priceDrops?.toString() ?? 'Not Tracked';

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: Dimensions.w_8,
      mainAxisSpacing: Dimensions.h_8,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: Dimensions.h_5),
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.2,
      children: [
        marketStatCard(value: activeListings, title: 'Active Listings', change: '', changeText: '5 new this month to date', icon: CupertinoIcons.cart, iconColor: blue, iconBackground: blueSoft, surface: surface, ink: ink, copy: copy, muted: muted, line: line, positiveColor: green, negativeColor: red, isPositive: true),
        marketStatCard(value: priceDrops, title: 'Price Drops', change: '', changeText: 'Price history is not available', icon: CupertinoIcons.tag, iconColor: red, iconBackground: redSoft, surface: surface, ink: ink, copy: copy, muted: muted, line: line, positiveColor: green, negativeColor: red, isPositive: true),
        marketStatCard(value: averagePrice, title: 'Avg. Listing Price', change: '', changeText: 'Current active asking prices', icon: CupertinoIcons.money_dollar_circle, iconColor: green, iconBackground: greenSoft, surface: surface, ink: ink, copy: copy, muted: muted, line: line, positiveColor: green, negativeColor: red, isPositive: true),
        marketStatCard(value: soldWeek, title: 'Items Sold This Week', change: '', changeText: 'Recorded sales since Monday', icon: CupertinoIcons.person_2, iconColor: purple, iconBackground: purpleSoft, surface: surface, ink: ink, copy: copy, muted: muted, line: line, positiveColor: green, negativeColor: red, isPositive: true),
      ],
    );
  }

  Widget marketStatCard({
    required String value,
    required String title,
    required String change,
    required String changeText,
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required Color surface,
    required Color ink,
    required Color copy,
    required Color muted,
    required Color line,
    required Color positiveColor,
    required Color negativeColor,
    required bool isPositive,
  }) {
    final changeColor = isPositive ? positiveColor : negativeColor;
    return Container(
      padding: EdgeInsets.all(Dimensions.h_6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.h_10),
        border: Border.all(color: Color.lerp(iconColor, line, 0.76)!, width: 0.7),
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color.lerp(iconBackground, surface, 0.20)!, iconBackground]),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Dimensions.h_25,
                height: Dimensions.h_25,
                decoration: BoxDecoration(color: iconBackground, borderRadius: BorderRadius.circular(Dimensions.h_7)),
                child: Icon(icon, color: iconColor, size: Dimensions.h_18),
              ),
              SizedBox(width: Dimensions.w_7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ink, fontSize: FontSize.sp_18, fontWeight: FontWeight.w900, height: 1),
                    ),
                    SizedBox(height: Dimensions.h_6),
                    Text(
                      title.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: copy, fontSize: FontSize.sp_9, fontWeight: FontWeight.w600, height: 1.1),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                change,
                style: TextStyle(color: changeColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
              ),
              SizedBox(width: Dimensions.w_5),
              Padding(
                padding: EdgeInsets.only(top: Dimensions.h_2),
                child: Text(
                  changeText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: muted, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1.1),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_5),
        ],
      ),
    );
  }

  Widget garageListing(bool isLight) {
    final surface = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF0B2035);
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final copy = isLight ? const Color(0xFF344779) : const Color(0xFFC9D5E8);
    final muted = isLight ? const Color(0xFF63728F) : const Color(0xFFAAB8CF);
    final line = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final green = isLight ? const Color(0xFF087C4B) : const Color(0xFF64D9A2);
    final allPoints = garageController.briefChartsData?.points ?? [];
    final selectedMonths = garageController.listingActivityRange == 'Last Year' ? 12 : garageController.listingActivityRange == 'Last 6 Months' ? 6 : 3;
    final points = allPoints.length > selectedMonths ? allPoints.sublist(allPoints.length - selectedMonths) : List<Point>.from(allPoints);
    final maxCount = points.fold<double>(0, (maxValue, point) {
      final newValue = (point.pointNew ?? 0).toDouble();
      final soldValue = (point.sold ?? 0).toDouble();
      final currentMax = newValue > soldValue ? newValue : soldValue;
      return currentMax > maxValue ? currentMax : maxValue;
    });

    final yInterval = maxCount <= 10 ? 10.0 : (maxCount / 4).ceil().toDouble();
    final yMaximum = yInterval <= 0 ? 10.0 : yInterval * 4;

    return CommonCard(
      padding: EdgeInsets.only(left: Dimensions.w_8, right: Dimensions.w_8, top: Dimensions.h_6, bottom: Dimensions.h_8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Listing Activity'.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
                ),
              ),
              Container(
                height: Dimensions.h_25,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: garageController.listingActivityRange,
                    icon: Icon(CupertinoIcons.chevron_down, color: copy, size: Dimensions.h_10),
                    dropdownColor: surface,
                    isDense: true,
                    style: TextStyle(color: copy, fontSize: FontSize.sp_9, fontWeight: FontWeight.w600),
                    items: const [
                      DropdownMenuItem(value: 'Last 3 Months', child: Text('Last 3 Months')),
                      DropdownMenuItem(value: 'Last 6 Months', child: Text('Last 6 Months')),
                      DropdownMenuItem(value: 'Last Year', child: Text('Last Year')),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      garageController.listingActivityRange = value;
                      garageController.update([ControllerBuilders.marketBriefController]);
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_6),
          Row(
            children: [
              Container(
                width: Dimensions.h_6,
                height: Dimensions.h_6,
                decoration: BoxDecoration(color: blue, shape: BoxShape.circle),
              ),
              SizedBox(width: Dimensions.w_4),
              Text(
                'New Listings',
                style: TextStyle(color: muted, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: Dimensions.w_12),
              Container(
                width: Dimensions.h_6,
                height: Dimensions.h_6,
                decoration: BoxDecoration(color: green, shape: BoxShape.circle),
              ),
              SizedBox(width: Dimensions.w_4),
              Text(
                'Sold Listings',
                style: TextStyle(color: muted, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_5),
          Container(
            height: Dimensions.h_165,
            width: double.infinity,
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_8)),
            padding: EdgeInsets.only(left: Dimensions.w_6, right: Dimensions.w_6, top: Dimensions.h_10, bottom: Dimensions.h_8),
            child: SfCartesianChart(
              margin: EdgeInsets.zero,
              plotAreaBorderWidth: 0,
              primaryXAxis: DateTimeCategoryAxis(
                dateFormat: DateFormat('MMM yy'),
                intervalType: DateTimeIntervalType.months,
                interval: points.length > 6 ? 2 : 1,
                labelStyle: TextStyle(color: muted, fontSize: FontSize.sp_8, fontWeight: FontWeight.w500),
                majorGridLines: const MajorGridLines(width: 0),
                axisLine: AxisLine(color: line, width: 0.7),
                majorTickLines: const MajorTickLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: yMaximum,
                interval: yInterval,
                labelStyle: TextStyle(color: muted, fontSize: FontSize.sp_8, fontWeight: FontWeight.w500),
                majorGridLines: MajorGridLines(color: line, width: 0.7),
                minorGridLines: const MinorGridLines(width: 0),
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(width: 0),
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: surface,
                textStyle: TextStyle(color: ink, fontSize: FontSize.sp_9),
              ),
              series: <CartesianSeries>[
                ColumnSeries<Point, DateTime>(
                  dataSource: points,
                  xValueMapper: (point, _) {
                    final date = DateTime.tryParse('${point.month}-01');
                    return date;
                  },
                  yValueMapper: (point, _) => (point.pointNew ?? 0).toDouble(),
                  name: 'New Listings',
                  color: blue,
                  width: 0.38,
                  spacing: 0.08,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_2), topRight: Radius.circular(Dimensions.h_2)),
                ),
                ColumnSeries<Point, DateTime>(
                  dataSource: points,
                  xValueMapper: (point, _) {
                    final date = DateTime.tryParse('${point.month}-01');
                    return date;
                  },
                  yValueMapper: (point, _) => (point.sold ?? 0).toDouble(),
                  name: 'Sold Listings',
                  color: green,
                  width: 0.38,
                  spacing: 0.08,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_2), topRight: Radius.circular(Dimensions.h_2)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget averageListing(bool isLight) {
    final surface = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF0B2035);
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final copy = isLight ? const Color(0xFF344779) : const Color(0xFFC9D5E8);
    final muted = isLight ? const Color(0xFF63728F) : const Color(0xFFAAB8CF);
    final line = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);
    final purple = isLight ? const Color(0xFF7657FF) : const Color(0xFFAB98FF);
    final purpleSoft = isLight ? const Color(0xFFF1EDFF) : const Color(0xFF29244F);
    final allPoints = garageController.briefChartsData?.points ?? [];
    final selectedMonths = garageController.averagePriceRange == 'Last Year' ? 12 : garageController.averagePriceRange == 'Last 6 Months' ? 6 : 3;
    final points = allPoints.length > selectedMonths ? allPoints.sublist(allPoints.length - selectedMonths) : List<Point>.from(allPoints);
    final prices = points.map((point) => point.averagePrice).whereType<double>().toList();
    final maxPrice = prices.isEmpty ? 0.0 : prices.reduce((a, b) => a > b ? a : b);
    double yInterval;
    if (maxPrice <= 1000) {
      yInterval = 200;
    } else if (maxPrice <= 5000) {
      yInterval = 1000;
    } else if (maxPrice <= 10000) {
      yInterval = 2000;
    } else if (maxPrice <= 50000) {
      yInterval = 10000;
    } else if (maxPrice <= 100000) {
      yInterval = 20000;
    } else if (maxPrice <= 500000) {
      yInterval = 100000;
    } else {
      yInterval = 200000;
    }

    final yMaximum = maxPrice <= 0 ? yInterval * 4 : ((maxPrice / yInterval).ceil() * yInterval).toDouble();
    return CommonCard(
      padding: EdgeInsets.only(left: Dimensions.w_8, right: Dimensions.w_8, top: Dimensions.h_6, bottom: Dimensions.h_8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Average Listing Price'.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
                ),
              ),
              Container(
                height: Dimensions.h_25,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: garageController.averagePriceRange,
                    icon: Icon(CupertinoIcons.chevron_down, color: copy, size: Dimensions.h_10),
                    dropdownColor: surface,
                    isDense: true,
                    style: TextStyle(color: copy, fontSize: FontSize.sp_9, fontWeight: FontWeight.w600),
                    items: const [
                      DropdownMenuItem(value: 'Last 3 Months', child: Text('Last 3 Months')),
                      DropdownMenuItem(value: 'Last 6 Months', child: Text('Last 6 Months')),
                      DropdownMenuItem(value: 'Last Year', child: Text('Last Year')),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      garageController.averagePriceRange = value;
                      garageController.update([ControllerBuilders.marketBriefController]);
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          Container(
            height: Dimensions.h_165,
            width: double.infinity,
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_8)),
            padding: EdgeInsets.only(left: Dimensions.w_6, right: Dimensions.w_6, top: Dimensions.h_10, bottom: Dimensions.h_8),
            child: SfCartesianChart(
              margin: EdgeInsets.zero,
              plotAreaBorderWidth: 0,
              primaryXAxis: DateTimeCategoryAxis(
                dateFormat: DateFormat('MMM yy'),
                intervalType: DateTimeIntervalType.months,
                interval: points.length > 6 ? 2 : 1,
                labelStyle: TextStyle(color: muted, fontSize: FontSize.sp_8, fontWeight: FontWeight.w500),
                majorGridLines: MajorGridLines(color: line.withValues(alpha: 0.55), width: 0.7),
                axisLine: AxisLine(color: line, width: 0.7),
                majorTickLines: const MajorTickLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: yMaximum,
                interval: yInterval,
                labelStyle: TextStyle(color: muted, fontSize: FontSize.sp_8, fontWeight: FontWeight.w500),
                numberFormat: NumberFormat.currency(symbol: '\$', decimalDigits: 0),
                majorGridLines: MajorGridLines(color: line, width: 0.7),
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(width: 0),
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: surface,
                textStyle: TextStyle(color: ink, fontSize: FontSize.sp_9),
              ),
              series: <CartesianSeries>[
                AreaSeries<Point, DateTime>(
                  dataSource: points,
                  xValueMapper: (point, _) {
                    final date = DateTime.tryParse('${point.month}-01');
                    return date;
                  },
                  yValueMapper: (point, _) => point.averagePrice,
                  name: 'Average Listing Price',
                  color: purpleSoft.withValues(alpha: isLight ? 0.9 : 0.55),
                  borderColor: purple,
                  borderWidth: 2,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      purple.withValues(alpha: isLight ? 0.28 : 0.32),
                      purple.withValues(alpha: isLight ? 0.04 : 0.08),
                    ],
                  ),
                  emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.gap),
                  markerSettings: MarkerSettings(isVisible: true, height: Dimensions.h_4, width: Dimensions.h_4, shape: DataMarkerType.circle, color: surface, borderColor: purple, borderWidth: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeroHeader(bool isLight, GarageController controller) {
    final townName = controller.marketBriefData?.town?.name?.trim().isNotEmpty == true ? controller.marketBriefData!.town!.name!.trim() : '';
    final updatedAt = controller.marketBriefData?.updatedAt;
    final formattedUpdatedAt = updatedAt != null ? DateFormat('MMM d, yyyy · h:mm a').format(DateTime.tryParse(updatedAt)?.toLocal() ?? DateTime.now()) : '';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedWeatherImage(height: Dimensions.h_380, image: "https://staging.wikixm.com/web/assets/images/garage/my-garage/garage-v1-hero.webp"),
        Positioned.fill(
          child: Container(
            height: Dimensions.h_380,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [const Color(0xFF020B15).withValues(alpha: 0.85), const Color(0xFF020B15).withValues(alpha: 0.65), const Color(0xFF020B15).withValues(alpha: 0.35), Colors.transparent], stops: const [0.0, 0.30, 0.58, 1.0]),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.h_360,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_50),
                child: Text(
                  townName.toUpperCase(),
                  style: TextStyle(color: const Color(0xFFFFE47A), fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_5, bottom: Dimensions.h_5),
                child: Text(
                  "AI Garage Summary".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_22,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.h_10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    width: Get.width,
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF12221B).withValues(alpha: 0.60),
                      border: Border.all(color: const Color(0xFFFFE8A6), width: 0.6),
                      borderRadius: BorderRadius.circular(Dimensions.h_10),
                      boxShadow: [
                        BoxShadow(color: Colors.white.withValues(alpha: 0.25), offset: const Offset(0, 1)),
                        BoxShadow(color: const Color(0xFFFFD681).withValues(alpha: 0.16), blurRadius: 13),
                        BoxShadow(color: const Color(0xFF000A06).withValues(alpha: 0.16), blurRadius: 22, offset: const Offset(0, 8)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(CupertinoIcons.home, size: Dimensions.h_16, color: const Color(0xFFFFD681)),
                            SizedBox(width: Dimensions.w_8),
                            Text(
                              '${townName.toUpperCase()} AI BRIEF',
                              style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Last updated',
                                  style: TextStyle(color: const Color(0xFFFFD681), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  formattedUpdatedAt,
                                  style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_8, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          'Local insights.',
                          style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_18, fontWeight: FontWeight.w900),
                        ),
                        Row(
                          children: [
                            Text(
                              'Real data.',
                              style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900),
                            ),
                            Text(
                              ' Smarter decisions.',
                              style: TextStyle(color: const Color(0xFFFFE8A6), fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_5),
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.w_4),
                          child: Text(
                            "See what’s selling, what’s trending, and what’s coming up in $townName.",
                            style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: Dimensions.h_5, left: Dimensions.w_4),
                          width: Get.width,
                          height: 0.3,
                          color: AppColor.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.w_4),
                          child: aiInsightList(isLight, controller.marketAiBrief?.insights?.take(4).toList() ?? []),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -2,
          child: IgnorePointer(
            child: Container(
              height: Dimensions.h_15,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    (isLight ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.0),
                    (isLight ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.15),
                    (isLight ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.35),
                    (isLight ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.78),
                    isLight ? AppColor.softBackground : AppColor.backgroundDark,
                  ],
                  stops: const [0.08, 0.25, 0.45, 0.75, 1.0],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget aiInsightList(bool isLight, List<String> insights) {
    final white = AppColor.white;
    return Column(
      children: List.generate(insights.length, (index) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.h_5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: Dimensions.h_18,
                    height: Dimensions.h_18,
                    decoration: BoxDecoration(
                      color: const Color(0xFF64D9A2).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF64D9A2).withValues(alpha: 0.55), width: 0.7),
                    ),
                    child: Icon(Icons.trending_up_rounded, color: const Color(0xFF64D9A2), size: Dimensions.h_12),
                  ),
                  SizedBox(width: Dimensions.w_7),
                  Expanded(
                    child: Text(
                      insights[index],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400, height: 1.15),
                    ),
                  ),
                ],
              ),
            ),
            if (index != insights.length - 1) Container(height: 0.3, color: AppColor.white),
          ],
        );
      }),
    );
  }
}
