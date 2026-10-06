import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/ai_brief.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/constants.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../dashboard/controller.dart';
import '../widgets/business_action_card.dart';
import '../widgets/business_metric_cards.dart';
import '../widgets/cache_image.dart';
import '../widgets/circular_percent.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  final DashboardController dashboardController = Get.find<DashboardController>();
  final List<Map<String, dynamic>> businessMetrics = [
    {'icon': Icons.trending_up_rounded, 'value': '92', 'title': 'Business Growth'},
    {'icon': Icons.group, 'value': '80', 'title': 'Job Growth'},
    {'icon': Icons.favorite_border, 'value': '92', 'title': 'Consumer Confidence'},
    {'icon': Icons.monetization_on_outlined, 'value': '76', 'title': 'Local Spending Strength'},
    {'icon': Icons.person, 'value': '90', 'title': 'Business Participation'},
  ];
  final List<Map<String, dynamic>> businessStats = [
    {'icon': Icons.card_giftcard, 'value': '842', 'title': 'Local Businesses', 'color': const Color(0xFF0b6030), 'size': Dimensions.h_22},
    {'icon': CupertinoIcons.calendar, 'value': '32', 'title': 'New this Month', 'color': const Color(0xFF0b6030), 'size': Dimensions.h_25},
    {'icon': FontAwesomeIcons.person, 'value': '514', 'title': 'Jobs Available', 'color': const Color(0xFFfe6711), 'size': Dimensions.h_18},
    {'icon': CupertinoIcons.calendar, 'value': '12', 'title': 'Events Today', 'color': Colors.red.shade900, 'size': Dimensions.h_22},
    {'icon': CupertinoIcons.money_dollar, 'value': '1,204', 'title': 'Offer & Deals', 'color': const Color(0xFF3c09e1), 'size': Dimensions.h_22},
  ];

  final List<Map<String, dynamic>> businessActions = [
    {'icon': Icons.edit, 'title': 'Write a review', 'color': const Color(0xFF0b6030), 'size': Dimensions.h_22, 'padding': Dimensions.h_10},
    {'icon': CupertinoIcons.share, 'title': 'Share an Update', 'color': const Color(0xFF0b6030), 'size': Dimensions.h_18, 'padding': Dimensions.h_10},
    {'icon': CupertinoIcons.chat_bubble, 'title': 'Recommend', 'color': const Color(0xFF0b6030), 'size': Dimensions.h_18, 'padding': Dimensions.h_10},
    {'icon': Icons.add_box_outlined, 'title': 'Add a business', 'color': const Color(0xFF0b6030), 'size': Dimensions.h_18, 'padding': Dimensions.h_2},
    {'icon': Icons.report_gmailerrorred, 'title': 'Report an issue', 'color': Colors.yellow.shade900, 'size': Dimensions.h_18, 'padding': Dimensions.h_10},
  ];

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.brightnessOf(context) == Brightness.light;
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      body: CommonScrollBlurScaffold(
        showBack: true,
        expandedHeight: Dimensions.h_210,
        expandedColor: Colors.white,
        collapsedColor: Theme.of(context).highlightColor,
        hero: buildHeroHeader(isLight),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff00111f), Color(0xff00111f).withValues(alpha: 0.7), Colors.white], stops: [0.0, 0.55, 0.7]),
              ),
              child: firstCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "BUSINESS HEALTH INDEX",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      Text(
                        "Learn more",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ArcGaugeIndicator(radius: Dimensions.h_50, lineWidth: 10, percent: .80, progressColor: const Color(0xFF0b6030), backgroundColor: Colors.grey, sweepAngle: 180, startAngle: 180),
                                Positioned(
                                  top: Dimensions.h_18,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '91',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_24, fontWeight: FontWeight.w700, height: 1.05),
                                      ),
                                      SizedBox(height: Dimensions.h_4),
                                      Text(
                                        'THRIVING',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, height: 1.05),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: Dimensions.h_10, left: Dimensions.w_20, right: Dimensions.w_20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: Dimensions.w_8),
                                      child: Text(
                                        'Our local economy is Strong and growing',
                                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1.05),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_5),
                                    Row(
                                      children: [
                                        Icon(Icons.arrow_drop_up, color: const Color(0xFF0b6030), size: Dimensions.h_20),
                                        Text(
                                          '7 pts from last month',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1.05),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: Dimensions.h_70,
                        child: IntrinsicHeight(
                          child: Row(
                            children: List.generate(businessMetrics.length, (index) {
                              final item = businessMetrics[index];

                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: index == businessMetrics.length - 1 ? 0 : Dimensions.w_6),
                                  child: BusinessMetricCard(icon: item['icon'], value: item['value'], title: item['title']),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TODAY'S BUSINESS SNAPSHOT",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      Text(
                        "See All",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  IntrinsicHeight(
                    child: Row(
                      children: List.generate(businessStats.length, (index) {
                        final item = businessStats[index];
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: index == businessStats.length - 1 ? 0 : Dimensions.w_6),
                            child: BusinessMetricCard(icon: item['icon'], value: item['value'], title: item['title'], iconColor: item['color'], iconSize: item['size']),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "FEATURED BUSINESS STORY",
                            style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                          ),
                          Spacer(),
                          Text(
                            "View All ",
                            style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_6),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppCacheImage(
                                size: Dimensions.h_110,
                                widthSize: Dimensions.w_185,
                                imageUrl:
                                    'https://imgs.search.brave.com/DDBeeF6T9gtaNV29Pd34Utkhy8qD28I7UXKPsAZguL8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90aHVt/YnMuZHJlYW1zdGlt/ZS5jb20vYi9idWls/ZGluZy1zaXRlLWNv/YXN0YWwtdG93bi1j/cmFuZS1jb25zdHJ1/Y3Rpb24td29ya2Vy/cy1taWRkYXktc3Vu/c2hpbmUtZmVhdHVy/ZXMtdGFsbC1vdmVy/c2VlaW5nLW5ldy1i/dWlsZGluZ3MtNDQ2/ODcyMjUzLmpwZw',
                                isShadow: false,
                                borderColor: Colors.grey.shade200,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(Dimensions.w_8, 0, Dimensions.w_8, 0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            maxLines: 3,
                                            'Cedar River Bakery Expands Into Second Location',
                                            style: TextStyle(height: 1.09, color: Colors.black, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
                                          ),
                                          SizedBox(height: Dimensions.h_8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Food & Dinning',
                                                style: TextStyle(color: Colors.black, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                                              ),
                                              SizedBox(width: Dimensions.w_8),
                                              Container(
                                                height: Dimensions.h_2,
                                                width: Dimensions.h_2,
                                                decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                                              ),
                                              SizedBox(width: Dimensions.w_8),
                                              Text(
                                                '3m read',
                                                style: TextStyle(color: Colors.black, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: Dimensions.h_6),
                                          Text(
                                            maxLines: 3,
                                            'The \$1.2B plan aims to create 2,000 new homes. public green spaces, and improved transit access.',
                                            style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1.25),
                                          ),
                                          SizedBox(height: Dimensions.h_6),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.h_3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.favorite, color: Colors.red, size: Dimensions.h_12),
                              SizedBox(width: Dimensions.w_5),
                              Text(
                                '248',
                                style: TextStyle(color: Colors.black, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                              ),
                              SizedBox(width: Dimensions.w_20),
                              Icon(CupertinoIcons.chat_bubble, color: Colors.black87, size: Dimensions.h_12),
                              SizedBox(width: Dimensions.w_5),
                              Text(
                                '42',
                                style: TextStyle(color: Colors.black, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                              ),
                              SizedBox(width: Dimensions.w_20),
                              Icon(CupertinoIcons.eye_fill, color: Colors.black87, size: Dimensions.h_12),
                              SizedBox(width: Dimensions.w_5),
                              Text(
                                '1.2k',
                                style: TextStyle(color: Colors.black, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                              ),
                              const Spacer(),
                              Container(
                                margin: EdgeInsets.only(right: Dimensions.w_8),
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Read Full Story",
                                      style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: Dimensions.w_5),
                                    Icon(Icons.arrow_forward, size: Dimensions.h_13, color: Colors.black87),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  Stack(
                    children: [
                      Positioned.fill(
                        child: AppCacheImage(imageUrl: "https://images.unsplash.com/photo-1511818966892-d7d671e672a2?w=1200", fit: BoxFit.cover, radius: Dimensions.h_8, size: Dimensions.h_100, isShadow: false),
                      ),
                      Positioned.fill(
                        child: Container(
                          height: Dimensions.h_100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.h_8),
                            gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [const Color(0xFF0B6030), const Color(0xF50B6030), const Color(0xEF0B6030), const Color(0xF50B6030), Colors.transparent], stops: const [0, .35, .50, .65, 1]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_6, right: Dimensions.w_55, top: Dimensions.h_5, bottom: Dimensions.h_15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: Dimensions.w_3),
                                    child: Text(
                                      "COMMUNITY BUSINESS PARTNER",
                                      style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.h_8),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          AppCacheImage(imageUrl: Images.bank, size: Dimensions.h_50, widthSize: Dimensions.h_90, fit: BoxFit.cover, isShadow: false),
                                          SizedBox(height: Dimensions.h_6),
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: Dimensions.h_5, horizontal: Dimensions.w_20),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              border: Border.all(color: Colors.white, width: 0.5),
                                            ),
                                            child: Text(
                                              'Learn More',
                                              style: TextStyle(color: Colors.white, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: Dimensions.w_10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Proudly investing in Pine Valley businesses and our community since 1996",
                                              style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(height: Dimensions.h_6),
                                            Text(
                                              "Together, we build a stronger local economy",
                                              style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_15),
                  buildTownChallenge(),
                  SizedBox(height: Dimensions.h_15),
                  Text(
                    "GET INVOLVED. MAKE AN IMPACT",
                    style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                  ),
                  SizedBox(height: Dimensions.h_10),
                  IntrinsicHeight(
                    child: Row(
                      children: List.generate(businessActions.length, (index) {
                        final item = businessActions[index];
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: index == businessActions.length - 1 ? 0 : Dimensions.w_6),
                            child: BusinessActionCard(icon: item['icon'], title: item['title'], iconColor: item['color'], iconSize: item['size'], verticalPadding: item['padding']),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "EXPLORE BUSINESSES",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      Spacer(),
                      Text(
                        "View All ",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  CategoriesGrid(),
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "FEATURED LOCAL BUSINESSES",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      Spacer(),
                      Text(
                        "View All ",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_1),
                  Column(
                    children: [
                      ...List.generate(businessList.length, (index) {
                        final business = businessList[index];
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppCacheImage(imageUrl: business.image, size: Dimensions.h_60, widthSize: Dimensions.w_110, radius: Dimensions.h_6, isShadow: false),
                                  SizedBox(width: Dimensions.w_8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          business.name,
                                          style: TextStyle(fontSize: FontSize.sp_13, fontWeight: FontWeight.w700, color: Colors.black87),
                                        ),
                                        SizedBox(height: Dimensions.h_2),
                                        Text(
                                          business.category,
                                          style: TextStyle(fontSize: FontSize.sp_11, color: Colors.black87, fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: Dimensions.h_6),
                                        Row(
                                          children: [
                                            ...List.generate(5, (index) {
                                              IconData icon;

                                              if (index < business.rating.floor()) {
                                                icon = Icons.star;
                                              } else if (index < business.rating && business.rating % 1 != 0) {
                                                icon = Icons.star_half;
                                              } else {
                                                icon = Icons.star_border;
                                              }

                                              return Icon(icon, size: Dimensions.h_12, color: icon == Icons.star || icon == Icons.star_half ? const Color(0xffF5A623) : Colors.grey.shade400);
                                            }),
                                            SizedBox(width: Dimensions.w_4),
                                            Text(
                                              "${business.rating}",
                                              style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w600, color: Colors.black87),
                                            ),
                                            SizedBox(width: Dimensions.w_3),
                                            Text(
                                              "(${business.reviews})",
                                              style: TextStyle(fontSize: FontSize.sp_10, color: Colors.black87),
                                            ),
                                            const Spacer(),
                                            Text(
                                              business.distance,
                                              style: TextStyle(fontSize: FontSize.sp_10, color: Colors.black87, fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index != businessList.length - 1) Container(color: Colors.grey.shade300, height: 0.5),
                          ],
                        );
                      }),
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.w_4, right: Dimensions.w_4, top: Dimensions.h_5),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "View All Businesses",
                              style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: Dimensions.w_5),
                            Padding(
                              padding: EdgeInsets.only(top: Dimensions.h_2),
                              child: Icon(Icons.arrow_forward, size: Dimensions.h_12, color: const Color(0xFF0b6030)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.h_10),
                    color: Colors.grey,
                    height: 0.3,
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "MEET THE OWNER",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      Spacer(),
                      Text(
                        "View All ",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppCacheImage(
                        imageUrl: 'https://imgs.search.brave.com/0A61qbNQfuOwLuIyFmNfIjogBM_B5pJFtr-NTg5kHbA/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2U2L2Mz/LzIxL2U2YzMyMTlk/NTFlM2RjMGEzZWVi/NDUyZDU3ODllMjg1/LmpwZw',
                        size: Dimensions.h_110,
                        widthSize: Dimensions.w_160,
                        radius: Dimensions.h_6,
                        isShadow: false,
                      ),
                      SizedBox(width: Dimensions.w_8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tom Rivera ",
                              style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Colors.black87),
                            ),
                            Text(
                              "Cedar & Sage Cafe",
                              style: TextStyle(fontSize: FontSize.sp_12, color: Colors.black87, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: Dimensions.h_8),
                            Padding(
                              padding: EdgeInsets.only(right: Dimensions.w_20),
                              child: Text(
                                "We believe good coffee brings people together.Our goal is to create a place that feels like home for everyone.",
                                style: TextStyle(fontSize: FontSize.sp_11, color: Colors.black87, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.w_4, right: Dimensions.w_4, top: Dimensions.h_5),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Read Tom's Story",
                          style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: Dimensions.w_5),
                        Padding(
                          padding: EdgeInsets.only(top: Dimensions.h_2),
                          child: Icon(Icons.arrow_forward, size: Dimensions.h_12, color: const Color(0xFF0b6030)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.h_10),
                    color: Colors.grey,
                    height: 0.3,
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "LOCAL JOBS & OPPORTUNITIES",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      Spacer(),
                      Text(
                        "View All ",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_1),
                  Column(
                    children: [
                      ...List.generate(jobList.length, (index) {
                        final job = jobList[index];

                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Dimensions.h_45,
                                    width: Dimensions.h_45,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.grey.shade100),
                                    clipBehavior: Clip.antiAlias,
                                    child: AppCacheImage(imageUrl: job.logo, radius: Dimensions.h_50, isShadow: false),
                                  ),
                                  SizedBox(width: Dimensions.w_12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          job.title,
                                          style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: const Color(0xff29304D)),
                                        ),
                                        Text(
                                          job.company,
                                          style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
                                        ),
                                        SizedBox(height: Dimensions.h_2),
                                        Text(
                                          job.type,
                                          style: TextStyle(fontSize: FontSize.sp_10, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    job.time,
                                    style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ),
                            if (index != jobList.length - 1) Container(height: 0.3, color: Colors.grey.shade500),
                          ],
                        );
                      }),
                      SizedBox(height: Dimensions.h_6),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: Dimensions.w_4),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade500, width: 0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View All Jobs",
                              style: TextStyle(color: const Color(0xFF0B6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: Dimensions.w_6),
                            Icon(Icons.arrow_forward, size: Dimensions.h_13, color: const Color(0xFF0B6030)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.h_10),
                    color: Colors.grey,
                    height: 0.3,
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "DEALS & SPECIAL OFFERS",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      const Spacer(),
                      Text(
                        "View All ",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_1),
                  Column(
                    children: [
                      ...List.generate(dealList.length, (index) {
                        final deal = dealList[index];
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppCacheImage(imageUrl: deal.image, size: Dimensions.h_55, widthSize: Dimensions.w_90, radius: Dimensions.h_8, isShadow: false),
                                  SizedBox(width: Dimensions.w_10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          deal.title,
                                          style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: Colors.black87),
                                        ),
                                        Text(
                                          deal.business,
                                          style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, color: const Color(0xff3F4A5A)),
                                        ),
                                        SizedBox(height: Dimensions.h_3),
                                        Text(
                                          deal.validTill,
                                          style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index != jobList.length - 1) Container(height: 0.3, color: Colors.grey.shade500),
                          ],
                        );
                      }),
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.w_4, right: Dimensions.w_4, top: Dimensions.h_5),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300, width: .8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View All Deals",
                              style: TextStyle(color: const Color(0xFF0B6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                            ),

                            SizedBox(width: Dimensions.w_6),

                            Icon(Icons.arrow_forward, color: const Color(0xFF0B6030), size: Dimensions.h_13),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.h_10),
                    color: Colors.grey,
                    height: 0.3,
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "FEATURED BUSINESSES NEAR YOU",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      const Spacer(),
                      Text(
                        "Sponsored",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w600, height: 1),
                      ),
                    ],
                  ),
                  trustedBusinesses(),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.w_4, right: Dimensions.w_4, top: Dimensions.h_10),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: .8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "See More",
                          style: TextStyle(color: const Color(0xFF0B6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: Dimensions.w_6),
                        Icon(Icons.arrow_forward, color: const Color(0xFF0B6030), size: Dimensions.h_13),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.h_10),
                    color: Colors.grey,
                    height: 0.3,
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "BUSINESS LEADERS",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      const Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  SizedBox(
                    height: Dimensions.h_155,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: topStoryList.length,
                      separatorBuilder: (context, index) => SizedBox(width: Dimensions.w_8),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: Dimensions.w_110,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade500, width: 0.3),
                              borderRadius: BorderRadius.circular(Dimensions.h_8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.only(topLeft: Radius.circular(Dimensions.h_8), topRight: Radius.circular(Dimensions.h_8)),
                                  child: AppCacheImage(
                                    imageUrl: 'https://imgs.search.brave.com/WusTPFySme9X3LkjRlNfx1l17yWS1wGm28_gQg7MIgM/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvZW4vdGh1bWIv/MC8wMy9XYWx0ZXJf/V2hpdGVfUzVCLnBu/Zy81MTJweC1XYWx0/ZXJfV2hpdGVfUzVC/LnBuZw',
                                    size: Dimensions.h_90,
                                    widthSize: Dimensions.w_110,
                                    radius: Dimensions.h_8,
                                    isShadow: false,
                                  ),
                                ),
                                SizedBox(height: Dimensions.h_4),
                                Padding(
                                  padding: EdgeInsets.only(left: Dimensions.w_5),
                                  child: Text(
                                    'Mike Anderson',
                                    style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(height: Dimensions.h_2),
                                Padding(
                                  padding: EdgeInsets.only(left: Dimensions.w_5),
                                  child: Text(
                                    'Chamber President',
                                    style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(height: Dimensions.h_8),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                                  padding: EdgeInsets.symmetric(vertical: Dimensions.h_4, horizontal: Dimensions.w_5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey, width: 0.3),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.mail, color: const Color(0xFF0b6030), size: Dimensions.h_10),
                                        SizedBox(width: Dimensions.w_4),
                                        Text(
                                          "Message",
                                          style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_9, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.h_10),
                    color: Colors.grey,
                    height: 0.3,
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "BUSINESS NEWS",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      const Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ...List.generate(dealList.length, (index) {
                        final deal = dealList[index];
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppCacheImage(imageUrl: deal.image, size: Dimensions.h_55, widthSize: Dimensions.w_90, radius: Dimensions.h_8, isShadow: false),
                                  SizedBox(width: Dimensions.w_10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pine Vally ranks among top small businesses',
                                          style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: Colors.black87),
                                        ),
                                        SizedBox(height: Dimensions.h_3),
                                        Text(
                                          '2d ago',
                                          style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index != jobList.length - 1) Container(height: 0.3, color: Colors.grey.shade500),
                          ],
                        );
                      }),
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.w_4, right: Dimensions.w_4, top: Dimensions.h_5),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300, width: .8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View All News",
                              style: TextStyle(color: const Color(0xFF0B6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                            ),

                            SizedBox(width: Dimensions.w_6),

                            Icon(Icons.arrow_forward, color: const Color(0xFF0B6030), size: Dimensions.h_13),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.h_10),
                    color: Colors.grey,
                    height: 0.3,
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "COMMUNITY RECOMMENDATIONS",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      const Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_8),
                  Column(
                    children: [
                      ...List.generate(dealList.length, (index) {
                        final deal = dealList[index];
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(Dimensions.h_5),
                                    decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
                                    child: AppCacheImage(imageUrl: deal.image, size: Dimensions.h_25, widthSize: Dimensions.h_25, radius: Dimensions.h_100, isShadow: false),
                                  ),
                                  SizedBox(width: Dimensions.w_10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Whats's the best coffee shop in pine valley?",
                                          style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: Colors.black87),
                                        ),
                                        SizedBox(height: Dimensions.h_3),
                                        Text(
                                          '32 recommendations',
                                          style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index != jobList.length - 1) Container(height: 0.3, color: Colors.grey.shade500),
                          ],
                        );
                      }),
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.w_4, right: Dimensions.w_4, top: Dimensions.h_5),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300, width: .8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View All Recommendations",
                              style: TextStyle(color: const Color(0xFF0B6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                            ),

                            SizedBox(width: Dimensions.w_6),

                            Icon(Icons.arrow_forward, color: const Color(0xFF0B6030), size: Dimensions.h_13),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.h_10),
                    color: Colors.grey,
                    height: 0.3,
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "BUSINESS MEMORIES",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      Spacer(),
                      Text(
                        "View All ",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.h_8),
                      border: Border.all(color: Colors.grey, width: 0.3),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppCacheImage(
                              imageUrl:
                                  'https://imgs.search.brave.com/uv8VuIRZJNktAdWLqP3baNfmj00KGAmotFg7BzyNYAU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy84/LzhhL0N1c3RvbWVy/c19zaG9wcGluZ19p/bnNpZGVfQ28tb3Bl/cmF0aXZlX0dyb2Nl/cnlfU3RvcmVfTm9f/MSxfU2VhdHRsZSxf/Y2lyY2FfMTkxOF8o/TU9IQUlfMTUzNTcp/LmpwZw',
                              size: Dimensions.h_90,
                              widthSize: Dimensions.w_160,
                              radius: Dimensions.h_6,
                              isShadow: false,
                            ),
                            SizedBox(width: Dimensions.w_8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "The Old Duval Hardware Store",
                                    style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Colors.black87),
                                  ),
                                  SizedBox(height: Dimensions.h_8),
                                  Padding(
                                    padding: EdgeInsets.only(right: Dimensions.w_20),
                                    child: Text(
                                      "A Pine Valley landmark for 94 years",
                                      style: TextStyle(fontSize: FontSize.sp_11, color: Colors.black87, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Share Memory",
                                style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: Dimensions.w_5),
                              Padding(
                                padding: EdgeInsets.only(top: Dimensions.h_2),
                                child: Icon(Icons.arrow_forward, size: Dimensions.h_12, color: const Color(0xFF0b6030)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "ECONOMIC DEVELOPMENT",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      const Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_8),
                  Column(
                    children: [
                      ...List.generate(dealList.length, (index) {
                        final deal = dealList[index];
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(Dimensions.h_5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade500, width: 0.5),
                                      borderRadius: BorderRadius.circular(Dimensions.h_8),
                                    ),
                                    child: AppCacheImage(imageUrl: deal.image, size: Dimensions.h_25, widthSize: Dimensions.h_25, radius: Dimensions.h_100, isShadow: false),
                                  ),
                                  SizedBox(width: Dimensions.w_10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Downtown Revitalization Project",
                                          style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: Colors.black87),
                                        ),
                                        SizedBox(height: Dimensions.h_3),
                                        Text(
                                          'Construction begins on 1 june',
                                          style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index != jobList.length - 1) Container(height: 0.3, color: Colors.grey.shade500),
                          ],
                        );
                      }),
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.w_4, right: Dimensions.w_4, top: Dimensions.h_5),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300, width: .8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View All Projects",
                              style: TextStyle(color: const Color(0xFF0B6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                            ),

                            SizedBox(width: Dimensions.w_6),

                            Icon(Icons.arrow_forward, color: const Color(0xFF0B6030), size: Dimensions.h_13),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.h_10),
                    color: Colors.grey,
                    height: 0.3,
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "UPCOMING BUSINESS EVENTS",
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                      const Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(color: AppColor.darkBlue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_8),
                  Column(
                    children: [
                      ...List.generate(dealList.length, (index) {
                        final deal = dealList[index];
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_2, horizontal: Dimensions.w_12),
                                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                                    child: Column(
                                      children: [
                                        Text(
                                          "MAY",
                                          style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700, color: Colors.red.shade700),
                                        ),
                                        Text(
                                          '16',
                                          style: TextStyle(fontSize: FontSize.sp_18, fontWeight: FontWeight.w800, color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.w_10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pine Vally Business Summit",
                                          style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w800, color: Colors.black87),
                                        ),
                                        Text(
                                          'May 16   •   8 AM',
                                          style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: Colors.black87),
                                        ),
                                        SizedBox(height: Dimensions.h_1),
                                        Text(
                                          'Community Center',
                                          style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(CupertinoIcons.star_fill, color: Colors.grey, size: Dimensions.h_12),
                                  SizedBox(width: Dimensions.w_10),
                                ],
                              ),
                            ),
                            if (index != jobList.length - 1) Container(height: 0.3, color: Colors.grey.shade500),
                          ],
                        );
                      }),
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.w_4, right: Dimensions.w_4, top: Dimensions.h_5),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300, width: .8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View All Events",
                              style: TextStyle(color: const Color(0xFF0B6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                            ),

                            SizedBox(width: Dimensions.w_6),

                            Icon(Icons.arrow_forward, color: const Color(0xFF0B6030), size: Dimensions.h_13),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_8, horizontal: Dimensions.w_8),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "FEATURED BUSINESS ADS",
                              style: TextStyle(color: const Color(0xFF0B6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1),
                            ),
                            const Spacer(),
                            Text(
                              "Sponsored",
                              style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1),
                            ),
                          ],
                        ),
                        trustedBusinesses(backGround: Colors.white),
                        Container(
                          margin: EdgeInsets.only(left: Dimensions.w_4, right: Dimensions.w_4, top: Dimensions.h_5),
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "See More Ads",
                                style: TextStyle(color: const Color(0xFF0B6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                              ),

                              SizedBox(width: Dimensions.w_6),

                              Icon(Icons.arrow_forward, color: const Color(0xFF0B6030), size: Dimensions.h_13),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.h_10),
                    padding: EdgeInsets.only(top: Dimensions.h_10, left: Dimensions.w_6, right: Dimensions.w_6, bottom: Dimensions.h_1),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FaIcon(FontAwesomeIcons.robot, size: Dimensions.h_25, color: Color(0xff05612b)),
                        SizedBox(width: Dimensions.w_15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Dimensions.h_2),
                              Text(
                                'ASK WIKIXM AI',
                                style: TextStyle(color: Color(0xff05612b), fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, letterSpacing: 0.1),
                              ),
                              Text(
                                "Ask anything about local businesses, jobs, permits, events or resources",
                                style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: Dimensions.h_6),
                              Container(
                                margin: EdgeInsets.only(right: Dimensions.w_4, top: Dimensions.h_5),
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_80, vertical: Dimensions.h_8),
                                decoration: BoxDecoration(color: const Color(0xFF0B6030), borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Ask AI",
                                  style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(height: Dimensions.h_6),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.w_50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.h_20)),
        ],
      ),
    );
  }

  Widget trustedBusinesses({Color? backGround}) {
    final List<Map<String, dynamic>> trustedBusinesses = [
      {"icon": Icons.home_work_outlined, "iconColor": const Color(0xFFC97A1D), "title": "Pine Valley\nRealty", "subtitle": "Your local experts"},
      {"icon": Icons.medical_services_outlined, "iconColor": const Color(0xFF2F6EDB), "title": "Evergreen\nDental", "subtitle": "Care for every smile"},
      {"icon": Icons.handyman_outlined, "iconColor": const Color(0xFF4C6EF5), "title": "Summit\nConstruction", "subtitle": "Built on trust"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.h_8),
        Row(
          children: List.generate(trustedBusinesses.length, (index) {
            final item = trustedBusinesses[index];
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: index == trustedBusinesses.length - 1 ? 0 : Dimensions.w_8),
                padding: EdgeInsets.symmetric(vertical: Dimensions.h_12, horizontal: Dimensions.w_6),
                decoration: BoxDecoration(color: backGround ?? Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      width: Dimensions.h_42,
                      height: Dimensions.h_42,
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: Icon(item["icon"], color: item["iconColor"], size: Dimensions.h_22),
                    ),
                    SizedBox(height: Dimensions.h_10),
                    Text(
                      item["title"],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: const Color(0xff2B2D42), height: 1.2),
                    ),
                    SizedBox(height: Dimensions.h_6),
                    Text(
                      item["subtitle"],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: FontSize.sp_8_5, color: Colors.black87, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget buildTownChallenge() {
    return Container(
      height: Dimensions.h_200,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.3),
        borderRadius: BorderRadius.circular(Dimensions.h_6),
      ),
      child: Column(
        children: [
          SizedBox(height: Dimensions.h_5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "SUPPORT PINE VALLEY CHALLENGE",
                style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
              ),
              Text(
                "This Month ->",
                style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_15),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ArcGaugeIndicator(radius: Dimensions.h_45, lineWidth: 10, percent: .80, progressColor: const Color(0xFF0b6030), backgroundColor: Colors.grey, sweepAngle: 260, startAngle: 140),
                        Positioned(
                          top: Dimensions.h_20,
                          left: 0,
                          right: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '347',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_22, fontWeight: FontWeight.w900, height: 1.05),
                              ),
                              SizedBox(height: Dimensions.h_4),
                              Text(
                                'of 500',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w800, height: 1.05),
                              ),
                              SizedBox(height: Dimensions.h_4),
                              Text(
                                'Residents',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, height: 1.05),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: Dimensions.h_5, left: Dimensions.w_20, right: Dimensions.w_20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_6),
                              child: Text(
                                '\$126,400',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_20, fontWeight: FontWeight.w700, height: 1.05),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.arrow_drop_up, color: Colors.black87, size: Dimensions.h_20),
                                Text(
                                  'Spent Locally',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1.05),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_2),
                            Row(
                              children: [
                                SizedBox(width: Dimensions.w_6),
                                Icon(Icons.home, color: Colors.black87, size: Dimensions.h_10),
                                Text(
                                  ' Participating Business',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1.05),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5),
                              child: Text(
                                '162',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, height: 1.05),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: Dimensions.h_90,
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3, vertical: Dimensions.h_6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade500, width: 0.3),
                                borderRadius: BorderRadius.circular(Dimensions.h_6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.content_paste_sharp, color: const Color(0xFF0b6030), size: Dimensions.h_15),
                                  SizedBox(width: Dimensions.w_6),
                                  Column(
                                    children: [
                                      Text(
                                        'Business',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1.05),
                                      ),
                                      Text(
                                        'Passport',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1.05),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.w_6),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3, vertical: Dimensions.h_8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade500, width: 0.3),
                                borderRadius: BorderRadius.circular(Dimensions.h_6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(FontAwesomeIcons.trophy, color: const Color(0xFFfe6711), size: Dimensions.h_15),
                                  SizedBox(width: Dimensions.w_6),
                                  Text(
                                    'Leaderboard',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1.05),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.w_6),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3, vertical: Dimensions.h_8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade500, width: 0.3),
                                borderRadius: BorderRadius.circular(Dimensions.h_6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.card_giftcard_outlined, color: Colors.red.shade900, size: Dimensions.h_15),
                                  SizedBox(width: Dimensions.w_6),
                                  Text(
                                    'Rewards',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1.05),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: Dimensions.w_8, top: Dimensions.h_10),
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_6),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF0b6030), width: 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Join the Challenge",
                            style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: Dimensions.w_5),
                          Icon(Icons.arrow_forward, size: Dimensions.h_13, color: const Color(0xFF0b6030)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget category() {
    final List<IntelligenceCategory> intelligenceList = [
      IntelligenceCategory(title: "Government", subTitle: "Intelligence", updates: "12 new updates", color: const Color(0xff1551E0), icon: CupertinoIcons.building_2_fill),
      IntelligenceCategory(title: "Sports", subTitle: "Intelligence", updates: "14 new updates", color: const Color(0xff15843D), icon: CupertinoIcons.sportscourt),
      IntelligenceCategory(title: "Business", subTitle: "Intelligence", updates: "9 new updates", color: const Color(0xff5A1FC8), icon: CupertinoIcons.briefcase_fill),
      IntelligenceCategory(title: "Education", subTitle: "Intelligence", updates: "8 new updates", color: const Color(0xffD83A2F), icon: CupertinoIcons.book_fill),
    ];
    return SizedBox(
      height: Dimensions.h_170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: intelligenceList.length,
        separatorBuilder: (_, __) => SizedBox(width: Dimensions.w_5),
        itemBuilder: (context, index) {
          final item = intelligenceList[index];

          return Container(
            width: Dimensions.w_100,
            decoration: BoxDecoration(color: item.color, borderRadius: BorderRadius.circular(Dimensions.h_8)),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(item.icon, color: Colors.white, size: Dimensions.h_30),
                      SizedBox(height: Dimensions.h_8),
                      Text(
                        item.title,
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_13, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        item.subTitle,
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_13, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: Dimensions.h_6),
                      Text(
                        item.updates,
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_9, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: Dimensions.h_5),
                      Icon(Icons.trending_up, color: const Color(0xff35E35B), size: Dimensions.h_35),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_60, Dimensions.w_8, Dimensions.h_10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.h_8), bottomRight: Radius.circular(Dimensions.h_8)),
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black.withValues(alpha: 0.0), Colors.black.withValues(alpha: .25), Colors.black.withValues(alpha: .45), Colors.black.withValues(alpha: .80)]),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white, width: .6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Explore",
                            style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: Dimensions.w_3),
                          Icon(Icons.arrow_forward, color: Colors.white, size: Dimensions.h_12),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget secondCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
      padding: EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_8, Dimensions.w_8, 0),
      decoration: BoxDecoration(
        color: Color(0xfff4faf6),
        border: Border.all(color: Color(0xff4e8b64), width: 0.2),
        borderRadius: BorderRadius.circular(Dimensions.h_10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.sun_max, color: const Color(0xFF0b6030), size: Dimensions.h_18),
              SizedBox(width: Dimensions.w_5),
              Text(
                'TODAY IN SEATTLE',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: const Color(0xFF0b6030), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: Dimensions.h_5, left: Dimensions.w_2, right: Dimensions.w_3),
                  child: Text(
                    'Busy day ahead! 6 government meetings, 18 community events, sunny with a high of 72°. Waterfront vote',
                    style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1.1),
                  ),
                ),
              ),
              Icon(CupertinoIcons.cloud_sun_fill, size: Dimensions.h_45, color: Colors.yellow.shade800),
            ],
          ),
        ],
      ),
    );
  }

  Widget firstCard() {
    return CommonAiBrief(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppCacheImage(imageUrl: 'https://staging.wikixm.com/web/assets/images/common/ai-guide.webp', size: Dimensions.h_25, widthSize: Dimensions.h_25, isCircle: true, isShadow: false),
                    SizedBox(width: Dimensions.w_5),
                    Expanded(
                      child: Text(
                        'AI BUSINESS BRIEF',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1),
                      ),
                    ),
                    Text(
                      'Updated 8:30 AM',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w500, height: 1),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_6),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.checkmark_circle_fill, color: const Color(0xFF0b6030), size: Dimensions.h_13),
                      SizedBox(width: Dimensions.w_4),
                      Expanded(
                        child: Text(
                          '5 new business opened this week',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1.1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.h_6),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.checkmark_circle_fill, color: const Color(0xFF0b6030), size: Dimensions.h_13),
                      SizedBox(width: Dimensions.w_4),
                      Expanded(
                        child: Text(
                          'Local jobs posted: 18 jobs opportunities',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1.1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.h_6),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.checkmark_circle_fill, color: const Color(0xFF0b6030), size: Dimensions.h_13),
                      SizedBox(width: Dimensions.w_4),
                      Expanded(
                        child: Text(
                          'Pine Valley business summit is next week',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1.1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.h_10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Ask Pine Valley Business AI',
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: Dimensions.w_4),
                    Icon(CupertinoIcons.sparkles, color: Theme.of(context).primaryColor, size: Dimensions.h_13),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: Dimensions.w_8),
        ],
      ),
    );
  }

  Widget buildHeroHeader(bool isLight) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCacheImage(imageUrl: isLight ? Images.cityImageMobileDay : Images.cityImageMobile, widthSize: Get.width, size: Dimensions.h_310, radius: 0),
        if (isLight)
          Positioned(
            child: Container(
              height: Dimensions.h_312,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xE6020B15).withValues(alpha: 0.75), Color(0x99020B15).withValues(alpha: 0.50), Color(0x99020B15).withValues(alpha: 0.15), Color(0x00000000), Color(0x00000000)],
                  stops: [0.15, 0.35, 0.55, 0.78, 1],
                ),
              ),
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.w_12),
              child: Text(
                'PINE VALLEY ',
                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.w_12, right: Dimensions.w_120),
              child: Text(
                'BUSINESS HUB',
                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_22, fontWeight: FontWeight.w900),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.w_12, right: Dimensions.w_120, top: Dimensions.h_8),
              child: Text(
                'Shop Local. Build Local. Grow Together',
                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.w_12, right: Dimensions.w_120, top: Dimensions.h_5),
              child: Text(
                'Support the local businesses that support our community.',
                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: Dimensions.h_10),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_6),
                      decoration: BoxDecoration(color: Color(0xff005f06), borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search, size: Dimensions.h_13, color: Colors.white),
                          SizedBox(width: Dimensions.w_5),
                          Text(
                            "Find Business",
                            style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_5),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        border: Border.all(color: Colors.white, width: 0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.favorite_border, size: Dimensions.h_13, color: Colors.white),
                          SizedBox(width: Dimensions.w_5),
                          Text(
                            "Support Local",
                            style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8, right: Dimensions.w_10),
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_5),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        border: Border.all(color: Colors.white, width: 0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit, size: Dimensions.h_13, color: Colors.white),
                          SizedBox(width: Dimensions.w_3),
                          Text(
                            "Share",
                            style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categories = [
      CategoryModel(icon: Icons.restaurant, color: const Color(0xff1CA6A6), title: "Dining"),
      CategoryModel(icon: CupertinoIcons.bag, color: const Color(0xff4A8F84), title: "Retail"),
      CategoryModel(icon: CupertinoIcons.person_2, color: const Color(0xff3F7FD5), title: "Services"),
      CategoryModel(icon: CupertinoIcons.heart, color: const Color(0xff2E6BE6), title: "Health"),
      CategoryModel(icon: CupertinoIcons.house, color: const Color(0xff6C7A89), title: "Home"),
      CategoryModel(icon: CupertinoIcons.car, color: const Color(0xff5D7088), title: "Auto"),
      CategoryModel(icon: CupertinoIcons.building_2_fill, color: const Color(0xffC68A1F), title: "Real Estate"),
      CategoryModel(icon: CupertinoIcons.money_dollar_circle, color: const Color(0xff8C7B63), title: "Finance"),
      CategoryModel(icon: CupertinoIcons.wand_stars, color: const Color(0xff8A58D4), title: "Beauty"),
      CategoryModel(icon: CupertinoIcons.sportscourt, color: const Color(0xff7555D9), title: "Fitness"),
      CategoryModel(icon: CupertinoIcons.person_crop_circle, color: const Color(0xff2A9DA1), title: "Professional"),
      CategoryModel(icon: CupertinoIcons.ellipsis, color: const Color(0xff6B6B8B), title: "More"),
    ];
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_5, childAspectRatio: 1.1),
      itemBuilder: (context, index) {
        final item = categories[index];
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.h_5),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border.all(color: Colors.grey.shade300, width: 0.1),
              borderRadius: BorderRadius.circular(Dimensions.h_4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(item.icon, color: item.color, size: Dimensions.h_22),
                SizedBox(height: Dimensions.h_6),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryModel {
  final IconData icon;
  final Color color;
  final String title;

  CategoryModel({required this.icon, required this.color, required this.title});
}
