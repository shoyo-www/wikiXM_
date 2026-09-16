import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/fontsize.dart';
import '../widgets/AnimatedImage.dart';
import '../widgets/cache_image.dart';
import '../widgets/common_bullet.dart';
import '../widgets/drawer/src/slider_drawer.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return SliderDrawer(
      key: sliderDrawerKey,
      sliderOpenSize: Dimensions.w_260,
      isDraggable: false,
      slider: Container(
        height: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.h_45),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_4),
                child: Row(
                  children: [
                    Text(
                      'MENU',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: FontSize.sp_12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                        height: 1,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        sliderDrawerKey.currentState?.closeSlider();
                      },
                      child: Container(
                        width: Dimensions.h_20,
                        height: Dimensions.h_20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isLight
                              ? Theme.of(context).highlightColor.withValues(alpha: 0.2)
                              : Theme.of(context).highlightColor.withValues(alpha: 0.10),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: Theme.of(context).primaryColor,
                          size: Dimensions.h_10,
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_20)
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              _menuItem(
                context,
                title: 'Overview',
                icon: CupertinoIcons.house,
                isSelected: true,
                onTap: () {},
                isLight: isLight,
              ),

              _menuItem(
                context,
                title: 'My Inventory',
                icon: CupertinoIcons.cube_box,
                onTap: () {},
                isLight: isLight,
                badge: '37',
              ),

              _menuItem(
                context,
                title: 'My Listings',
                icon: CupertinoIcons.tag,
                onTap: () {},
                isLight: isLight,
                badge: '12',
              ),

              _menuItem(
                context,
                title: 'Messages',
                icon: CupertinoIcons.envelope,
                onTap: () {},
                isLight: isLight,
                badge: '3',
                isBadgeRed: true,
              ),

              _menuItem(
                context,
                title: 'Offers',
                icon: CupertinoIcons.search,
                onTap: () {},
                isLight: isLight,
                badge: '1',
                isBadgeRed: true,
              ),

              _menuItem(
                context,
                title: 'Saved Searches',
                icon: CupertinoIcons.bookmark,
                onTap: () {},
                isLight: isLight,
              ),

              _menuItem(
                context,
                title: 'My Favourites',
                icon: CupertinoIcons.heart_fill,
                onTap: () {},
                isLight: isLight,
              ),

              _menuItem(
                context,
                title: 'Selling Calendar',
                icon: CupertinoIcons.calendar,
                onTap: () {},
                isLight: isLight,
              ),

              _menuItem(
                context,
                title: 'Sales History',
                icon: CupertinoIcons.clock,
                onTap: () {},
                isLight: isLight,
              ),

              _menuItem(
                context,
                title: 'AI Assistant',
                icon: CupertinoIcons.sparkles,
                onTap: () {},
                isLight: isLight,
              ),

              _menuItem(
                context,
                title: 'Account Settings',
                icon: CupertinoIcons.gear,
                onTap: () {},
                isLight: isLight,
              ),

              _menuItem(
                context,
                title: 'Scan My Stuff',
                icon: CupertinoIcons.camera,
                onTap: () {
                  Get.toNamed(AppRoutes.addItem);
                  sliderDrawerKey.currentState?.closeSlider();
                },
                isLight: isLight,
              ),
            ],
          ),
        ),
      ),
      child: AppScaffold(
        top: false,
        bottom: false,
        isNavbar: true,
        bodyPadding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: CommonScrollBlurScaffold(
          isDrawer: true,
          onTap: () {
            sliderDrawerKey.currentState?.openSlider();
          },
          expandedHeight: Dimensions.h_260,
          expandedColor:  Colors.white,
          collapsedColor: Theme.of(context).highlightColor,
          hero: buildHeroHeader(isLight),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    aiBrief(),
                    SizedBox(height: Dimensions.h_15),
                    cash(isLight),
                    SizedBox(height: Dimensions.h_15),
                    garageValue(isLight),
                    SizedBox(height: Dimensions.h_15),
                    aiSellingBrief(isLight),
                    SizedBox(height: Dimensions.h_15),
                    sellerProfile(isLight),
                    SizedBox(height: Dimensions.h_15),
                    bestMovesToday(isLight),
                    SizedBox(height: Dimensions.h_15),
                    myInventory(isLight),
                    SizedBox(height: Dimensions.h_15),
                    myListings(isLight),
                    SizedBox(height: Dimensions.h_15),
                    topSellers(isLight),
                    SizedBox(height: Dimensions.h_15),
                    CommonCard(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.sparkles,
                            size: Dimensions.h_25,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: Dimensions.w_12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Dimensions.h_2),
                                Row(
                                  children: [
                                    Text(
                                      'ASK WIKIXM AI',
                                      style: TextStyle(
                                        color: Theme.of(
                                          Get.context!,
                                        ).highlightColor,
                                        fontSize: FontSize.sp_12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.1,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: Dimensions.w_4,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.w_5,
                                        vertical: Dimensions.h_3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: !isLight
                                            ? const Color(0xffffc264)
                                            : const Color(0xFF97590a),
                                        borderRadius:
                                        BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                      child: Text(
                                        'COMING SOON',
                                        style: TextStyle(
                                          color: !isLight
                                              ? AppColor.black
                                              : AppColor.white,
                                          fontSize: FontSize.sp_7,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0.5,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.h_5),
                                Text(
                                  "Ask anything about pine valley events, places, venues and more",
                                  style: TextStyle(
                                    color: Theme.of(
                                      Get.context!,
                                    ).highlightColor,
                                    fontSize: FontSize.sp_9_5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: Dimensions.h_6),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: Dimensions.w_20,
                              right: Dimensions.w_10,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: Dimensions.h_5,
                              horizontal: Dimensions.w_5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColor.darkBlue,
                            ),
                            child: Icon(
                              CupertinoIcons.chat_bubble,
                              size: Dimensions.h_18,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: Dimensions.h_70),
            ),
          ],
        )
      ),
    );
  }

  Widget _menuItem(
      BuildContext context, {
        required String title,
        required IconData icon,
        bool isSelected = false,
        VoidCallback? onTap,
        bool? isLight,
        String? badge,
        bool isBadgeRed = false,
      }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: Dimensions.h_2,right: Dimensions.w_20),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w_7,
          vertical: Dimensions.h_4,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isLight == true
              ? const Color(0xFFEDF3FB)
              : const Color(0xFF14223A))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.h_6),
          border: isSelected
              ? Border.all(
            color: theme.primaryColorDark.withValues(alpha: 0.50),
            width: 0.5,
          )
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: Dimensions.h_22,
              height: Dimensions.h_22,
              decoration: BoxDecoration(
                color: isSelected
                    ? (isLight == true
                    ? const Color(0xFFEDF3FB)
                    : const Color(0xFF14223A))
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? theme.primaryColorDark.withValues(alpha: 0.50)
                      : theme.primaryColor.withValues(alpha: 0.30),
                  width: 0.5,
                ),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? isLight == true
                    ? AppColor.darkBlue
                    : const Color(0xFF4b8bff)
                    : theme.primaryColor,
                size: Dimensions.h_12,
              ),
            ),
            SizedBox(width: Dimensions.w_7),
            Expanded(
              child: Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: isSelected
                      ? isLight == true
                      ? AppColor.darkBlue
                      : const Color(0xFF4b8bff)
                      : theme.primaryColor,
                  fontSize: FontSize.sp_10,
                  fontWeight:
                  isSelected ? FontWeight.w700 : FontWeight.w700,
                  height: 1,
                ),
              ),
            ),
            if (badge != null)
              Container(
                constraints: BoxConstraints(
                  minWidth: Dimensions.h_15,
                  minHeight: Dimensions.h_15,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_3,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isBadgeRed
                      ? const Color(0xFFE51B3E)
                      : const Color(0xFF2775C9),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget topSellers(bool isLight) {
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final copy = isLight ? const Color(0xFF344779) : const Color(0xFFC9D5E8);
    final muted = isLight ? const Color(0xFF63728F) : const Color(0xFFAAB8CF);
    final line = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);

    final orange = isLight ? const Color(0xFFA14F00) : const Color(0xFFFFC36C);
    final orangeSoft = isLight ? const Color(0xFFFFF3E4) : const Color(0xFF49371F);

    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);

    final gold = isLight ? const Color(0xFF9A6200) : const Color(0xFFFFD277);

    final sellers = [
      ['Jennifer L.', '156 sold', '2.3 days', '4.9'],
      ['Mark T.', '98 sold', '3.1 days', '4.8'],
      ['Sarah K.', '112 sold', '3.4 days', '4.9'],
      ['You', '43 sold', '11 days', '4.9'],
      ['Brian M.', '37 sold', '12 days', '4.8'],
    ];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: Dimensions.h_25,
                height: Dimensions.h_25,
                decoration: BoxDecoration(
                  color: orangeSoft,
                  borderRadius: BorderRadius.circular(Dimensions.h_6),
                ),
                child: Icon(
                  CupertinoIcons.person_solid,
                  color: orange,
                  size: Dimensions.h_15,
                ),
              ),
              SizedBox(width: Dimensions.w_5),
              Expanded(
                child: Text(
                  'Top Sellers in Issaquah',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ink,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: blue,
                  fontSize: FontSize.sp_9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          Container(
            height: Dimensions.h_28,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(Dimensions.h_5),
              border: Border.all(color: line, width: 0.6)),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'By Sales',
                      style: TextStyle(
                        color: copy,
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(Dimensions.h_2),
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(Dimensions.h_4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'By Speed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'By Rating',
                      style: TextStyle(
                        color: copy,
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h_4),
          ...List.generate(
            sellers.length,
                (index) {
              final seller = sellers[index];
              final isYou = seller[0] == 'You';

              return Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.h_4,
                  horizontal: Dimensions.w_2,
                ),
                decoration: BoxDecoration(
                  color: isYou
                      ? blueSoft.withValues(alpha: 0.65)
                      : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: line,
                      width: index == sellers.length - 1 ? 0 : 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: Dimensions.w_15,
                      child: Text(
                        '${index + 1}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isYou ? ink : copy,
                          fontSize: FontSize.sp_14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_3),
                    Container(
                      width: Dimensions.h_30,
                      height: Dimensions.h_30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: blueSoft,
                        border: Border.all(
                          color: line,
                          width: 0.5,
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.person_fill,
                        color: blue,
                        size: Dimensions.h_13,
                      ),
                    ),
                    SizedBox(width: Dimensions.w_5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            seller[0],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ink,
                              fontSize: FontSize.sp_12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: Dimensions.h_1),
                          Text(
                            seller[1],
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: FontSize.sp_9_5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          seller[2],
                          style: TextStyle(
                            color: ink,
                            fontSize: FontSize.sp_9_5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: Dimensions.h_1),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              color: gold,
                              size: Dimensions.h_10,
                            ),
                            SizedBox(width: Dimensions.w_2),
                            Text(
                              seller[3],
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: FontSize.sp_9_5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: Dimensions.h_10),
          Container(
            margin:  EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            width: double.infinity,
            padding: EdgeInsets.all(Dimensions.w_5),
            decoration: BoxDecoration(
              color: blueSoft,
              borderRadius: BorderRadius.circular(Dimensions.h_5),
              border: Border.all(
                color: blue.withValues(alpha: 0.45),
                width: 0.6,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.arrow_up,
                  color: blue,
                  size: Dimensions.h_15,
                ),
                SizedBox(width: Dimensions.w_4),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: copy,
                        fontSize: FontSize.sp_9_5,
                      ),
                      children:  [
                        TextSpan(
                          text: 'Top sellers move items fast.\n',
                          style: TextStyle(
                            fontSize: FontSize.sp_11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                          'They average 9.4 days to sell versus the 24-day platform average.',
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
    );
  }

  Widget myListings(bool isLight) {
    final surface = isLight
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF0B2035);

    final ink = isLight
        ? const Color(0xFF08154F)
        : const Color(0xFFF4F7FF);

    final copy = isLight
        ? const Color(0xFF344779)
        : const Color(0xFFC9D5E8);

    final muted = isLight
        ? const Color(0xFF63728F)
        : const Color(0xFFAAB8CF);

    final line = isLight
        ? const Color(0xFFD6E3EE)
        : const Color(0xFF294762);

    final blue = isLight
        ? const Color(0xFF075DC9)
        : const Color(0xFF78ADFF);

    final blueSoft = isLight
        ? const Color(0xFFE8F2FF)
        : const Color(0xFF173D68);

    final green = isLight
        ? const Color(0xFF087C4B)
        : const Color(0xFF64D9A2);

    final greenSoft = isLight
        ? const Color(0xFFE8F7EF)
        : const Color(0xFF123D36);

    final red = isLight
        ? const Color(0xFFB4232D)
        : const Color(0xFFFF8E96);

    final redSoft = isLight
        ? const Color(0xFFFFF0F1)
        : const Color(0xFF48242B);

    final orange = isLight
        ? const Color(0xFFA14F00)
        : const Color(0xFFFFC36C);

    final orangeSoft = isLight
        ? const Color(0xFFFFF3E4)
        : const Color(0xFF49371F);

    final listings = [
      {
        'name': 'Trek Mountain Bike',
        'location': 'Issaquah Highlands',
        'image': '',
        'status': 'Well Priced',
        'score': '82/100',
        'statusColor': green,
        'statusSoft': greenSoft,
        'price': '\$450',
        'views': '118',
        'saves': '7',
        'days': '14–25',
        'trend': '-\$50',
        'trendText': 'in 90 days',
        'trendColor': red,
        'trendIcon': CupertinoIcons.arrow_down_right,
      },
      {
        'name': 'Leather Sofa',
        'location': 'Talus',
        'image': '',
        'status': 'Consider Reducing',
        'score': '58/100',
        'statusColor': orange,
        'statusSoft': orangeSoft,
        'price': '\$300',
        'views': '96',
        'saves': '4',
        'days': '7–14',
        'trend': '-\$75',
        'trendText': 'in 90 days',
        'trendColor': red,
        'trendIcon': CupertinoIcons.arrow_down_right,
      },
      {
        'name': 'Weber Gas Grill',
        'location': 'Olde Town',
        'image': '',
        'status': 'Losing Momentum',
        'score': '42/100',
        'statusColor': red,
        'statusSoft': redSoft,
        'price': '\$200',
        'views': '142',
        'saves': '10',
        'days': '3–7',
        'trend': '-\$60',
        'trendText': 'in 30 days',
        'trendColor': red,
        'trendIcon': CupertinoIcons.arrow_down_right,
      },
      {
        'name': 'Atomic Skis',
        'location': 'Sammamish Plateau',
        'image': '',
        'status': 'Strong Position',
        'score': '76/100',
        'statusColor': green,
        'statusSoft': greenSoft,
        'price': '\$350',
        'views': '87',
        'saves': '6',
        'days': '21–35',
        'trend': '+\$75',
        'trendText': 'in 90 days',
        'trendColor': green,
        'trendIcon': CupertinoIcons.arrow_up_right,
      },
    ];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ==================================================
          // HEADER
          // ==================================================

          Row(
            children: [

              Container(
                width: Dimensions.h_25,
                height: Dimensions.h_25,
                decoration: BoxDecoration(
                  color: blueSoft,
                  borderRadius: BorderRadius.circular(
                    Dimensions.h_6,
                  ),
                  border: Border.all(
                    color: blue,
                    width: 0.7,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.tag,
                  color: blue,
                  size: Dimensions.h_15,
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Listings (12)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ink,
                        fontSize: FontSize.sp_13_5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Pricing, interest, timing, and value trends at a glance.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_9,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_7),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: Dimensions.h_28,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.add,
                        size: Dimensions.h_12,
                      ),
                      label: Text(
                        'List an Item',
                        style: TextStyle(
                          fontSize: FontSize.sp_10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.h_5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.w_10),
                Expanded(
                  child: SizedBox(
                    height: Dimensions.h_28,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: blue,
                        side: BorderSide(
                          color: blue.withValues(alpha: 0.5),
                          width: 0.7,
                        ),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.h_5,
                          ),
                        ),
                      ),
                      child: Text(
                        'Manage Listings',
                        style: TextStyle(
                          color: blue,
                          fontSize: FontSize.sp_10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _listingFilter(
                  title: 'Active',
                  count: '12',
                  selected: true,
                  blue: blue,
                  blueSoft: blueSoft,
                  line: line,
                  ink: ink,
                  muted: muted,
                ),
                SizedBox(width: Dimensions.w_4),
                _listingFilter(
                  title: 'Pending',
                  count: '0',
                  selected: false,
                  blue: blue,
                  blueSoft: blueSoft,
                  line: line,
                  ink: ink,
                  muted: muted,
                ),

                SizedBox(width: Dimensions.w_4),

                _listingFilter(
                  title: 'Sold',
                  count: '43',
                  selected: false,
                  blue: blue,
                  blueSoft: blueSoft,
                  line: line,
                  ink: ink,
                  muted: muted,
                ),

                SizedBox(width: Dimensions.w_4),

                _listingFilter(
                  title: 'Expired',
                  count: '2',
                  selected: false,
                  blue: blue,
                  blueSoft: blueSoft,
                  line: line,
                  ink: ink,
                  muted: muted,
                ),
              ],
            ),
          ),
          // SizedBox(height: Dimensions.h_6),
          // Row(
          //   children: [
          //     Text(
          //       'Sort by',
          //       style: TextStyle(
          //         color: Theme.of(context).highlightColor,
          //         fontSize: FontSize.sp_10,
          //         fontWeight: FontWeight.w800,
          //       ),
          //     ),
          //     const Spacer(),
          //     Container(
          //       height: Dimensions.h_25,
          //       padding: EdgeInsets.symmetric(
          //         horizontal: Dimensions.w_6,
          //       ),
          //       decoration: BoxDecoration(
          //         color: surface,
          //         borderRadius: BorderRadius.circular(
          //           Dimensions.h_5,
          //         ),
          //         border: Border.all(
          //           color: line,
          //           width: 0.7,
          //         ),
          //       ),
          //       child: DropdownButtonHideUnderline(
          //         child: DropdownButton<String>(
          //           value: 'Newest First',
          //           isDense: true,
          //           icon: Icon(
          //             CupertinoIcons.chevron_down,
          //             color: ink,
          //             size: Dimensions.h_8,
          //           ),
          //           style: TextStyle(
          //             color: ink,
          //             fontSize: FontSize.sp_10,
          //             fontWeight: FontWeight.w600,
          //           ),
          //           items: const [
          //             DropdownMenuItem(
          //               value: 'Newest First',
          //               child: Text('Newest First'),
          //             ),
          //             DropdownMenuItem(
          //               value: 'Oldest First',
          //               child: Text('Oldest First'),
          //             ),
          //             DropdownMenuItem(
          //               value: 'Highest Value',
          //               child: Text('Highest Value'),
          //             ),
          //             DropdownMenuItem(
          //               value: 'Lowest Value',
          //               child: Text('Lowest Value'),
          //             ),
          //           ],
          //           onChanged: (value) {},
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: Dimensions.h_15),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listings.length,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            separatorBuilder: (context, index) {
              return SizedBox(height: Dimensions.h_6);
            },
            itemBuilder: (context, index) {
              final item = listings[index];
              return _listingMobileCard(
                name: item['name'] as String,
                location: item['location'] as String,
                status: item['status'] as String,
                score: item['score'] as String,
                price: item['price'] as String,
                views: item['views'] as String,
                saves: item['saves'] as String,
                days: item['days'] as String,
                trend: item['trend'] as String,
                trendText: item['trendText'] as String,
                trendColor: item['trendColor'] as Color,
                trendIcon: item['trendIcon'] as IconData,
                statusColor: item['statusColor'] as Color,
                statusSoft: item['statusSoft'] as Color,
                surface: surface,
                ink: ink,
                copy: copy,
                muted: muted,
                line: line,
                blue: blue,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _listingMobileCard({
    required String name,
    required String location,
    required String status,
    required String score,
    required String price,
    required String views,
    required String saves,
    required String days,
    required String trend,
    required String trendText,
    required Color trendColor,
    required IconData trendIcon,
    required Color statusColor,
    required Color statusSoft,
    required Color surface,
    required Color ink,
    required Color copy,
    required Color muted,
    required Color line,
    required Color blue,
  }) {
    return CommonCard(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.h_80,
                height: Dimensions.h_80,
                decoration: BoxDecoration(
                  color: statusSoft,
                  borderRadius: BorderRadius.circular(Dimensions.h_5),
                  border: Border.all(color: line, width: 0.5)),
                child: Icon(
                  CupertinoIcons.photo,
                  color: muted,
                  size: Dimensions.h_18)),
              SizedBox(width: Dimensions.w_6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ink,
                        fontSize: FontSize.sp_12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_1),
                    Text(
                      location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_9,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_5),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_4,
                        vertical: Dimensions.h_2,
                      ),
                      decoration: BoxDecoration(
                        color: statusSoft,
                        borderRadius: BorderRadius.circular(
                          Dimensions.h_3,
                        ),
                        border: Border.all(
                          color: statusColor.withValues(alpha: 0.45),
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        '$status · $score',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: FontSize.sp_9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                CupertinoIcons.ellipsis_vertical,
                color: muted,
                size: Dimensions.h_12,
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_7),
          CommonCard(
            isBorder: false,
            radius: Dimensions.h_3,
            child: Row(
              children: [
                Expanded(
                  child: _listingMetric(
                    value: price,
                    label: 'Price',
                    ink: ink,
                    muted: muted,
                  ),
                ),
                _listingMetricDivider(line),
                Expanded(
                  child: _listingMetric(
                    value: views,
                    label: 'Views',
                    ink: ink,
                    muted: muted,
                  ),
                ),

                _listingMetricDivider(line),

                Expanded(
                  child: _listingMetric(
                    value: saves,
                    label: 'Saves',
                    ink: ink,
                    muted: muted,
                  ),
                ),

                _listingMetricDivider(line),

                Expanded(
                  child: _listingMetric(
                    value: days,
                    label: 'Days',
                    ink: ink,
                    muted: muted,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Row(
            children: [
              Icon(
                trendIcon,
                color: trendColor,
                size: Dimensions.h_15,
              ),
              SizedBox(width: Dimensions.w_3),
              Text(
                trend,
                style: TextStyle(
                  color: trendColor,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(width: Dimensions.w_3),
              Text(
                trendText,
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: FontSize.sp_11,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: Dimensions.h_22,
                width: Dimensions.w_75,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: blue,
                    side: BorderSide(
                      color: blue.withValues(alpha: 0.5),
                      width: 0.7,
                    ),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Dimensions.h_5,
                      ),
                    ),
                  ),
                  child: Text(
                    'Manage',
                    style: TextStyle(
                      color: blue,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listingMetric({
    required String value,
    required String label,
    required Color ink,
    required Color muted,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: ink,
            fontSize: FontSize.sp_11,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontSize: FontSize.sp_9_5,
          ),
        ),
      ],
    );
  }

  Widget _listingFilter({
    required String title,
    required String count,
    required bool selected,
    required Color blue,
    required Color blueSoft,
    required Color line,
    required Color ink,
    required Color muted,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_8,
        vertical: Dimensions.h_6,
      ),
      decoration: BoxDecoration(
        color: selected ? blue : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(
          Dimensions.h_5,
        ),
        border: Border.all(
          color: selected ? blue : line,
          width: 0.6,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: selected ? Colors.white : ink,
              fontSize: FontSize.sp_9_5,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(width: Dimensions.w_3),

          Text(
            count,
            style: TextStyle(
              color: selected ? Colors.white : muted,
              fontSize: FontSize.sp_9_5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listingMetricDivider(Color line) {
    return Container(
      width: 0.5,
      height: Dimensions.h_25,
      color: line,
    );
  }

  Widget myInventory(bool isLight) {
    final surface = isLight
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF0B2035);

    final ink = isLight
        ? const Color(0xFF08154F)
        : const Color(0xFFF4F7FF);

    final copy = isLight
        ? const Color(0xFF344779)
        : const Color(0xFFC9D5E8);

    final muted = isLight
        ? const Color(0xFF63728F)
        : const Color(0xFFAAB8CF);

    final line = isLight
        ? const Color(0xFFD6E3EE)
        : const Color(0xFF294762);

    final orange = isLight
        ? const Color(0xFFA14F00)
        : const Color(0xFFFFC36C);

    final orangeSoft = isLight
        ? const Color(0xFFFFF3E4)
        : const Color(0xFF49371F);

    final blue = isLight
        ? const Color(0xFF075DC9)
        : const Color(0xFF78ADFF);

    final blueSoft = isLight
        ? const Color(0xFFE8F2FF)
        : const Color(0xFF173D68);

    final green = isLight
        ? const Color(0xFF087C4B)
        : const Color(0xFF64D9A2);

    final greenSoft = isLight
        ? const Color(0xFFE8F7EF)
        : const Color(0xFF123D36);

    final red = isLight
        ? const Color(0xFFB4232D)
        : const Color(0xFFFF8E96);

    final redSoft = isLight
        ? const Color(0xFFFFF0F1)
        : const Color(0xFF48242B);

    final inventoryStats = [
      {
        'value': '12',
        'title': 'Listed for Sale',
        'icon': CupertinoIcons.calendar,
        'color': blue,
        'softColor': blueSoft,
      },
      {
        'value': '18',
        'title': 'Not Listed Yet',
        'icon': CupertinoIcons.cube_box,
        'color': green,
        'softColor': greenSoft,
      },
      {
        'value': '4',
        'title': 'Recommended to Sell Now',
        'icon': CupertinoIcons.bolt_fill,
        'color': red,
        'softColor': redSoft,
      },
      {
        'value': '3',
        'title': 'Better to Hold',
        'icon': CupertinoIcons.clock,
        'color': blue,
        'softColor': blueSoft,
      },
      {
        'value': '\$8,450',
        'title': 'Estimated Value (all items)',
        'icon': CupertinoIcons.money_dollar,
        'color': green,
        'softColor': greenSoft,
      },
    ];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.h_25,
                height: Dimensions.h_25,
                decoration: BoxDecoration(
                  color: orangeSoft,
                  borderRadius: BorderRadius.circular(
                    Dimensions.h_6,
                  ),
                  border: Border.all(
                    color: orange,
                    width: 0.8,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.cube_box,
                  color: orange,
                  size: Dimensions.h_15,
                ),
              ),
              SizedBox(width: Dimensions.w_5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Inventory (37 items)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ink,
                        fontSize: FontSize.sp_13_5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_1),
                    Text(
                      'Everything you own. Track value. Get recommendations.',
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_9,
                      ),
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
                      'View All Inventory',
                      style: TextStyle(
                        color: blue,
                        fontSize: FontSize.sp_9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: Dimensions.w_2),
                    Icon(
                      CupertinoIcons.arrow_right,
                      color: blue,
                      size: Dimensions.h_8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_7),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: inventoryStats.length,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: Dimensions.w_5,
              mainAxisSpacing: Dimensions.h_5,
              mainAxisExtent: Dimensions.h_45,
            ),
            itemBuilder: (context, index) {
              final item = inventoryStats[index];
              return _inventoryStat(
                value: item['value'] as String,
                title: item['title'] as String,
                icon: item['icon'] as IconData,
                color: item['color'] as Color,
                softColor: item['softColor'] as Color,
                ink: ink,
                muted: muted,
                line: line,
                surface: surface,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _inventoryStat({
    required String value,
    required String title,
    required IconData icon,
    required Color color,
    required Color softColor,
    required Color ink,
    required Color muted,
    required Color line,
    required Color surface,
  }) {
    return CommonCard(
      padding: EdgeInsets.only(left: Dimensions.w_4),
     color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          Container(
            width: Dimensions.h_22,
            height: Dimensions.h_22,
            decoration: BoxDecoration(
              color: softColor,
              borderRadius: BorderRadius.circular(
                Dimensions.h_5,
              ),
            ),
            child: Icon(
              icon,
              color: color,
              size: Dimensions.h_15,
            ),
          ),
          SizedBox(width: Dimensions.w_5),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ink,
                    fontSize: FontSize.sp_15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: Dimensions.h_1),
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_8_5,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bestMovesToday(bool isLight) {
    final surface = isLight
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF0B2035);

    final ink = isLight
        ? const Color(0xFF08154F)
        : const Color(0xFFF4F7FF);

    final copy = isLight
        ? const Color(0xFF344779)
        : const Color(0xFFC9D5E8);

    final muted = isLight
        ? const Color(0xFF63728F)
        : const Color(0xFFAAB8CF);

    final line = isLight
        ? const Color(0xFFD6E3EE)
        : const Color(0xFF294762);

    final blue = isLight
        ? const Color(0xFF075DC9)
        : const Color(0xFF78ADFF);

    final blueSoft = isLight
        ? const Color(0xFFE8F2FF)
        : const Color(0xFF173D68);

    final red = isLight
        ? const Color(0xFFB4232D)
        : const Color(0xFFFF8E96);

    final redSoft = isLight
        ? const Color(0xFFFFF0F1)
        : const Color(0xFF48242B);

    final green = isLight
        ? const Color(0xFF087C4B)
        : const Color(0xFF64D9A2);

    final greenSoft = isLight
        ? const Color(0xFFE8F7EF)
        : const Color(0xFF123D36);

    final moves = [
      {
        'number': '1',
        'title': 'Drop the Weber Grill from \$200 → \$175',
        'description':
        'Buyer interest has slowed. A \$25 reduction could get new views within days.',
        'button': 'Update Price',
        'icon': CupertinoIcons.tag,
        'color': red,
        'softColor': redSoft,
      },
      {
        'number': '2',
        'title': 'List your ski equipment this week',
        'description':
        'Winter searches are up 31% in Issaquah. Get ahead of the competition.',
        'button': 'List Ski Gear',
        'icon': CupertinoIcons.thermometer_snowflake,
        'color': blue,
        'softColor': blueSoft,
      },
      {
        'number': '3',
        'title': 'Reply to Sarah about the Trek bike',
        'description':
        'Message waiting 43 minutes. A quick response keeps buyer interest warm.',
        'button': 'View Message',
        'icon': CupertinoIcons.chat_bubble,
        'color': green,
        'softColor': greenSoft,
      },
    ];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.h_25,
                height: Dimensions.h_25,
                decoration: BoxDecoration(
                  color: redSoft,
                  borderRadius: BorderRadius.circular(
                    Dimensions.h_6,
                  ),
                  border: Border.all(
                    color: red,
                    width: 0.7,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.scope,
                  color: red,
                  size: Dimensions.h_15,
                ),
              ),
              SizedBox(width: Dimensions.w_5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your 3 Best Moves Today',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ink,
                        fontSize: FontSize.sp_13_5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Small actions. Bigger results.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_9,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.h_25,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.add,
                    size: Dimensions.h_13,
                  ),
                  label: Text(
                    'Do All 3 Actions',
                    style: TextStyle(
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Dimensions.h_5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: moves.length,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: Dimensions.w_5,
              mainAxisSpacing: Dimensions.h_5,
              mainAxisExtent: Dimensions.h_130,
            ),
            itemBuilder: (context, index) {
              final move = moves[index];
              return _bestMoveCard(
                number: move['number'] as String,
                title: move['title'] as String,
                description: move['description'] as String,
                buttonText: move['button'] as String,
                icon: move['icon'] as IconData,
                color: move['color'] as Color,
                softColor: move['softColor'] as Color,
                surface: surface,
                ink: ink,
                copy: copy,
                muted: muted,
                line: line,
                isLight: isLight
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _bestMoveCard({
    required String number,
    required String title,
    required String description,
    required String buttonText,
    required IconData icon,
    required Color color,
    required Color softColor,
    required Color surface,
    required Color ink,
    required Color copy,
    required Color muted,
    required Color line,
    required bool isLight
  }) {
    return CommonCard(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: Dimensions.h_30,
                    height: Dimensions.h_30,
                    decoration: BoxDecoration(
                      color: softColor,
                      borderRadius: BorderRadius.circular(
                        Dimensions.h_5,
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: Dimensions.h_15,
                    ),
                  ),
                  Positioned(
                    top: -Dimensions.h_5,
                      left: -Dimensions.w_5,
                      child: Container(
                    width: Dimensions.h_16,
                    height: Dimensions.h_16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: color.withValues(alpha: 0.35),
                        width: 0.6,
                      ),
                    ),
                    child: Text(
                      number,
                      style: TextStyle(
                        color: color,
                        fontSize: FontSize.sp_8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ))
                ],
              ),
              SizedBox(width: Dimensions.w_5),
              Expanded(
                child: Text(
                  title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ink,
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: FontSize.sp_8_5,
              height: 1.25,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: Dimensions.h_25,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: isLight ? const Color(0xFFe8f2ff) : const Color(0xFF173d68),
                side: BorderSide(color: isLight ? Color(0xFF075dc9) : const Color(0xFF78adff), width: 0.4),
                backgroundColor: isLight ? const Color(0xFFe8f2ff) : const Color(0xFF173d68),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.h_5))),
              child: Text(
                buttonText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
              AppCacheImage(imageUrl: "https://preetis-html.vercel.app/assets/images/school/version2/ai-guide.webp",
                  size: Dimensions.h_28,
                  widthSize: Dimensions.h_28,
                  isCircle: true,
                  isShadow: false),
              SizedBox(width: Dimensions.w_10),
              Text(
                'AI Selling Brief'.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.sp_13_5,
                    fontWeight: FontWeight.w800,
                    height: 1),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8,vertical: Dimensions.h_3),
                decoration: BoxDecoration(
                  color: const Color(0xFF6743e6),
                  borderRadius: BorderRadius.circular(99)
                ),
                child:  Text(
                  'BETA'.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: FontSize.sp_9,
                      fontWeight: FontWeight.w800,
                      height: 1),
                ),
              )
            ],),
          SizedBox(height: Dimensions.h_8),
          Padding(
            padding:  EdgeInsets.only(left: Dimensions.w_12),
            child: Text(
              'Good morning, Sean. You have \$2,180 in potential cash across your Garage.',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
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
                  child: CommonBulletItem(text: 'Grill and sofa demand is strong this month.'));
              }),
          SizedBox(height: Dimensions.h_8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                  'Ask AI about Garage',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme
                          .of(context)
                          .primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w800,
                      height: 1)),
              SizedBox(width: Dimensions.w_4),
              Icon(
                  Icons.arrow_forward,
                  color: Theme
                      .of(context)
                      .primaryColorDark,
                  size: Dimensions.h_13),
              SizedBox(width: Dimensions.w_15),
            ],
          ),
        ],
      ),
    );
  }

  Widget cash(bool isLight) {
    final surface = isLight
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF0B2035);
    final ink = isLight
        ? const Color(0xFF08154F)
        : const Color(0xFFF4F7FF);
    final copy = isLight
        ? const Color(0xFF344779)
        : const Color(0xFFC9D5E8);
    final muted = isLight
        ? const Color(0xFF63728F)
        : const Color(0xFFAAB8CF);
    final green = isLight
        ? const Color(0xFF087C4B)
        : const Color(0xFF64D9A2);
    final greenDeep = isLight
        ? const Color(0xFF05633B)
        : const Color(0xFF45BF86);

    final greenSoft = isLight
        ? const Color(0xFFE8F7EF)
        : const Color(0xFF123D36);
    final red = isLight
        ? const Color(0xFFB4232D)
        : const Color(0xFFFF8E96);
    final redSoft = isLight
        ? const Color(0xFFFFF0F1)
        : const Color(0xFF48242B);

    final line = isLight
        ? const Color(0xFFD6E3EE)
        : const Color(0xFF294762);
    final greenGradient = Color.lerp(
      greenSoft,
      surface,
      0.16,
    )!;
    final redGradient = Color.lerp(
      redSoft,
      surface,
      0.12,
    )!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: Dimensions.h_200,
            padding: EdgeInsets.fromLTRB(
              Dimensions.w_8,
              Dimensions.h_8,
              Dimensions.w_8,
              Dimensions.h_8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.h_10),
              border: Border.all(
                  color: isLight ? Colors.grey : Colors.white24,
                  width: isLight ? 0.4: 0.4),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  greenGradient,
                  surface,
                ],
                stops: const [
                  0.0,
                  0.76,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: Dimensions.h_20,
                      height: Dimensions.h_20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: green,
                          width: 0.8,
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.money_dollar,
                        color: green,
                        size: Dimensions.h_11,
                      ),
                    ),
                    SizedBox(width: Dimensions.w_5),
                    Expanded(
                      child: Text(
                        'Estimated Cash Opportunity',
                        maxLines: 1,
                        style: TextStyle(
                          color: ink,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_8),
                Text(
                  '\$2,180',
                  maxLines: 1,
                  style: TextStyle(
                    color: green,
                    fontSize: FontSize.sp_22,
                    height: 1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: Dimensions.h_8),
                Text(
                  'The total value you could turn into cash.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: muted,
                    fontSize: FontSize.sp_9,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: Dimensions.h_10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: Dimensions.h_5,
                    child: LinearProgressIndicator(
                      value: 0.72,
                      backgroundColor: isLight
                          ? const Color(0xFFD6EDE1)
                          : const Color(0xFF234B40),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        green,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.h_5),
                Row(
                  children: [
                    Expanded(
                      child: _cashInfo(
                        value: '\$1,180',
                        title: 'Current Listings',
                        subtitle: 'Market Value',
                        items: '12 items',
                        ink: ink,
                        copy: copy,
                        muted: muted,
                      ),
                    ),
                    Container(
                      width: 0.7,
                      height: Dimensions.h_28,
                      color: line,
                    ),
                    SizedBox(width: Dimensions.w_6),
                    Expanded(
                      child: _cashInfo(
                        value: '+\$1,000',
                        title: 'Unlisted Inventory',
                        subtitle: 'Opportunity',
                        items: '18 items',
                        ink: ink,
                        copy: copy,
                        muted: muted,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: Dimensions.h_28,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenDeep,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Dimensions.h_6,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Find My Hidden Cash',
                          style: TextStyle(
                            fontSize: FontSize.sp_10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: Dimensions.w_4),
                        Icon(
                          CupertinoIcons.arrow_right,
                          size: Dimensions.h_10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: Dimensions.w_5),
        Expanded(
          child: Container(
            height: Dimensions.h_200,
            padding: EdgeInsets.fromLTRB(
              Dimensions.w_8,
              Dimensions.h_8,
              Dimensions.w_8,
              Dimensions.h_8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.h_10),
              border: Border.all(
                  color: isLight ? Colors.grey : Colors.white24,
                  width: isLight ? 0.4 : 0.4),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  redGradient,
                  surface,
                ],
                stops: const [
                  0.0,
                  0.78,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: Dimensions.w_20,
                      height: Dimensions.w_20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.h_6,
                        ),
                        border: Border.all(
                          color: red,
                          width: 0.8,
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.arrow_down_right,
                        color: red,
                        size: Dimensions.h_11,
                      ),
                    ),
                    SizedBox(width: Dimensions.w_8),
                    Expanded(
                      child: Text(
                        'Cost of Waiting',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ink,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_5),
                Text(
                  '-\$137',
                  maxLines: 1,
                  style: TextStyle(
                    color: red,
                    fontSize: FontSize.sp_22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: Dimensions.h_3),
                Text(
                  'Estimated resale value you could lose over the next 90 days.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: muted,
                    fontSize: FontSize.sp_9_5,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: Dimensions.h_10),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w_5,
                    vertical: Dimensions.h_4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.h_6,
                    ),
                    border: Border.all(
                      color: isLight
                          ? const Color(0xFFE5C9CD)
                          : const Color(0xFF66373D),
                      width: 0.7,
                    ),
                    color: isLight
                        ? const Color(0xFFFFF8F8)
                        : const Color(0xFF251A20),
                  ),
                  child: Column(
                    children: [
                      _lossRow(
                        'Leather Sofa',
                        '-\$45',
                        red,
                        copy,
                      ),
                      _lossRow(
                        'Weber Grill',
                        '-\$35',
                        red,
                        copy,
                      ),
                      _lossRow(
                        'Electronics',
                        '-\$32',
                        red,
                        copy,
                        suffix: '(3 items)',
                      ),
                      _lossRow(
                        'Other Items',
                        '-\$25',
                        red,
                        copy,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: Dimensions.h_28,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: red,
                      side: BorderSide(
                        color: red,
                        width: 0.8,
                      ),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Dimensions.h_6,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Protect My Value',
                          style: TextStyle(
                            color: red,
                            fontSize: FontSize.sp_10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: Dimensions.w_4),
                        Icon(
                          CupertinoIcons.arrow_right,
                          color: red,
                          size: Dimensions.h_10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget garageValue(bool isLight) {
    final surface = isLight
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF0B2035);

    final ink = isLight
        ? const Color(0xFF08154F)
        : const Color(0xFFF4F7FF);

    final copy = isLight
        ? const Color(0xFF344779)
        : const Color(0xFFC9D5E8);

    final muted = isLight
        ? const Color(0xFF63728F)
        : const Color(0xFFAAB8CF);

    final line = isLight
        ? const Color(0xFFD6E3EE)
        : const Color(0xFF294762);

    final orange = isLight
        ? const Color(0xFFA14F00)
        : const Color(0xFFFFC36C);

    final orangeSoft = isLight
        ? const Color(0xFFFFF3E4)
        : const Color(0xFF49371F);

    final blue = isLight
        ? const Color(0xFF075DC9)
        : const Color(0xFF78ADFF);

    final blueSoft = isLight
        ? const Color(0xFFE8F2FF)
        : const Color(0xFF173D68);

    final green = isLight
        ? const Color(0xFF087C4B)
        : const Color(0xFF64D9A2);

    final greenSoft = isLight
        ? const Color(0xFFE8F7EF)
        : const Color(0xFF123D36);

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: Dimensions.h_25,
                height: Dimensions.h_25,
                decoration: BoxDecoration(
                  color: orangeSoft,
                  borderRadius: BorderRadius.circular(
                    Dimensions.h_6,
                  ),
                  border: Border.all(
                    color: orange,
                    width: 0.8,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.square_stack_3d_up,
                  color: orange,
                  size: Dimensions.h_15,
                ),
              ),
              SizedBox(width: Dimensions.w_5),
              Text(
                'Your Garage Value',
                style: TextStyle(
                  color: ink,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_7),
          _garageValueRow(
            icon: CupertinoIcons.tag,
            iconColor: blue,
            iconBackground: blueSoft,
            value: '\$1,425',
            title: 'Asking Value',
            subtitle: 'What you are currently asking',
            ink: ink,
            copy: copy,
            muted: muted,
          ),
          _garageDivider(line,isLight),
          _garageValueRow(
            icon: CupertinoIcons.chart_bar,
            iconColor: blue,
            iconBackground: blueSoft,
            value: '\$1,180',
            title: 'Estimated Market Value',
            subtitle: 'What buyers are likely to pay',
            ink: ink,
            copy: copy,
            muted: muted,
          ),
          _garageDivider(line,isLight),
          _garageValueRow(
            icon: CupertinoIcons.money_dollar_circle,
            iconColor: green,
            iconBackground: greenSoft,
            value: '\$995',
            title: 'Quick-Sale Value',
            subtitle: 'If you want to sell fast',
            ink: ink,
            copy: copy,
            muted: muted,
          ),
          _garageDivider(line,isLight),
          _garageValueRow(
            icon: CupertinoIcons.money_dollar,
            iconColor: green,
            iconBackground: greenSoft,
            value: '\$8,740',
            title: 'Lifetime Cash Earned',
            subtitle: '43 items sold',
            ink: ink,
            copy: copy,
            muted: muted,
          ),
        ],
      ),
    );
  }

  Widget _garageDivider(Color color,bool isLight) {
    return Container(
      height: 0.2,
      width: Get.width,
      color: isLight ? Colors.grey : Colors.white24,
    );
  }

  Widget _garageValueRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String value,
    required String title,
    required String subtitle,
    required Color ink,
    required Color copy,
    required Color muted,
  }) {
    return Padding(
      padding:  EdgeInsets.only(top: Dimensions.h_6,bottom: Dimensions.h_6,left: Dimensions.w_8),
      child: Row(
        children: [
          Container(
            width: Dimensions.h_25,
            height: Dimensions.h_25,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(
                Dimensions.h_5,
              ),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: Dimensions.h_15,
            ),
          ),
          SizedBox(width: Dimensions.w_10),
          SizedBox(
            width: Dimensions.w_50,
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ink,
                fontSize: FontSize.sp_12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: copy,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: muted,
                    fontSize: FontSize.sp_8_5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sellerProfile(bool isLight) {
    final surface = isLight
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF0B2035);

    final ink = isLight
        ? const Color(0xFF08154F)
        : const Color(0xFFF4F7FF);

    final copy = isLight
        ? const Color(0xFF344779)
        : const Color(0xFFC9D5E8);

    final muted = isLight
        ? const Color(0xFF63728F)
        : const Color(0xFFAAB8CF);

    final line = isLight
        ? const Color(0xFFD6E3EE)
        : const Color(0xFF294762);

    final blue = isLight
        ? const Color(0xFF075DC9)
        : const Color(0xFF78ADFF);

    final blueSoft = isLight
        ? const Color(0xFFE8F2FF)
        : const Color(0xFF173D68);

    final green = isLight
        ? const Color(0xFF087C4B)
        : const Color(0xFF64D9A2);

    final gold = isLight
        ? const Color(0xFF9A6200)
        : const Color(0xFFFFD277);

    final goldSoft = isLight
        ? const Color(0xFFFFF6DD)
        : const Color(0xFF44391E);

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: Dimensions.h_25,
                height: Dimensions.h_25,
                decoration: BoxDecoration(
                  color: blueSoft,
                  borderRadius: BorderRadius.circular(
                    Dimensions.h_6,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.person,
                  color: blue,
                  size: Dimensions.h_15,
                ),
              ),

              SizedBox(width: Dimensions.w_5),

              Expanded(
                child: Text(
                  'Your Seller Profile',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ink,
                    fontSize: FontSize.sp_13_5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {},
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: blue,
                    fontSize: FontSize.sp_9_5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            width: double.infinity,
            padding: EdgeInsets.all(Dimensions.w_6),
            decoration: BoxDecoration(
              color: isLight
                  ? const Color(0xFFF4F8FC)
                  : const Color(0xFF112B44),
              borderRadius: BorderRadius.circular(
                Dimensions.h_7,
              ),
              border: Border.all(
                color: line,
                width: 0.6,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: Dimensions.h_38,
                  height: Dimensions.h_38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: surface,
                      width: 2,
                    ),
                    color: blueSoft,
                  ),
                  child: ClipOval(
                    child: Icon(
                      CupertinoIcons.person_fill,
                      color: blue,
                      size: Dimensions.h_20,
                    ),
                  ),
                ),

                SizedBox(width: Dimensions.w_7),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Sean Stewart',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ink,
                          fontSize: FontSize.sp_12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Issaquah, WA',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontSize: FontSize.sp_10,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_2),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.star_fill,
                            color: gold,
                            size: Dimensions.h_7,
                          ),
                          SizedBox(width: Dimensions.w_2),
                          Text(
                            '4.9',
                            style: TextStyle(
                              color: copy,
                              fontSize: FontSize.sp_8_5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' · 27 reviews',
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: FontSize.sp_8_5,
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
          SizedBox(height: Dimensions.h_10),
          _sellerProfileStat(
            icon: CupertinoIcons.checkmark_circle_fill,
            text: 'Identity verified',
            color: green,
            copy: copy,
          ),
          _sellerProfileStat(
            icon: CupertinoIcons.checkmark_circle_fill,
            text: 'Avg. response time: 18 minutes',
            color: green,
            copy: copy,
          ),
          _sellerProfileStat(
            icon: CupertinoIcons.checkmark_circle_fill,
            text: '43 successful sales',
            color: green,
            copy: copy,
          ),
          _sellerProfileStat(
            icon: CupertinoIcons.checkmark_circle_fill,
            text: 'Average time to sell: 11 days',
            color: green,
            copy: copy,
          ),
          _sellerProfileStat(
            icon: CupertinoIcons.checkmark_circle_fill,
            text: 'Top 10% fastest sellers',
            color: green,
            copy: copy,
          ),
          _sellerProfileStat(
            icon: CupertinoIcons.checkmark_circle_fill,
            text: 'Neighbor since 2025',
            color: green,
            copy: copy,
          ),
          SizedBox(height: Dimensions.h_4),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w_6,
              vertical: Dimensions.h_10,
            ),
            decoration: BoxDecoration(
              color: goldSoft,
              borderRadius: BorderRadius.circular(Dimensions.h_6),
              border: Border.all(
                color: gold.withValues(alpha: 0.55),
                width: 0.6,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.photo_camera,
                  color: gold,
                  size: Dimensions.h_13,
                ),
                SizedBox(width: Dimensions.w_5),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: copy,
                        fontSize: FontSize.sp_11,
                        height: 1.2,
                      ),
                      children: const [
                        TextSpan(
                          text: 'You’re 2 sales away from ',
                        ),
                        TextSpan(
                          text: 'Trusted Seller status!',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
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
    );
  }

  Widget _sellerProfileStat({
    required IconData icon,
    required String text,
    required Color color,
    required Color copy,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h_5,left: Dimensions.w_8),
      child: Row(
        children: [
          Icon(icon, color: color, size: Dimensions.h_12),
          SizedBox(width: Dimensions.w_8),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: copy,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget aiSellingBrief(bool isLight) {
    final surface = isLight
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF0B2035);

    final ink = isLight
        ? const Color(0xFF08154F)
        : const Color(0xFFF4F7FF);

    final copy = isLight
        ? const Color(0xFF344779)
        : const Color(0xFFC9D5E8);

    final muted = isLight
        ? const Color(0xFF63728F)
        : const Color(0xFFAAB8CF);

    final line = isLight
        ? const Color(0xFFD6E3EE)
        : const Color(0xFF294762);

    final blue = isLight
        ? const Color(0xFF075DC9)
        : const Color(0xFF78ADFF);

    final blueSoft = isLight
        ? const Color(0xFFE8F2FF)
        : const Color(0xFF173D68);

    final red = isLight
        ? const Color(0xFFB4232D)
        : const Color(0xFFFF8E96);

    final redSoft = isLight
        ? const Color(0xFFFFF0F1)
        : const Color(0xFF48242B);

    final orange = isLight
        ? const Color(0xFFA14F00)
        : const Color(0xFFFFC36C);

    final orangeSoft = isLight
        ? const Color(0xFFFFF3E4)
        : const Color(0xFF49371F);

    final green = isLight
        ? const Color(0xFF087C4B)
        : const Color(0xFF64D9A2);

    final greenSoft = isLight
        ? const Color(0xFFE8F7EF)
        : const Color(0xFF123D36);

    final briefItems = [
      {
        'title': 'SELL NOW',
        'subtitle': 'Next 2–4 weeks',
        'items': [
          'Weber Grill',
          'Leather Sofa',
          'Power Tools',
          'Kids’ Gear',
        ],
        'count': '4',
        'icon': CupertinoIcons.flame,
        'color': red,
        'soft': redSoft,
      },
      {
        'title': 'GET AHEAD',
        'subtitle': 'Next 1–2 months',
        'items': [
          'Skis & Snowboards',
          'Winter Clothing',
          'Bikes',
          'Roof Racks',
        ],
        'count': '6',
        'icon': CupertinoIcons.thermometer_snowflake,
        'color': blue,
        'soft': blueSoft,
      },
      {
        'title': 'TRENDING NOW',
        'subtitle': 'Rising demand',
        'items': [
          'Camping Gear',
          'Outdoor Furniture',
          'Lawn Equipment',
          'Golf Equipment',
        ],
        'count': '5',
        'icon': CupertinoIcons.tag,
        'color': orange,
        'soft': orangeSoft,
      },
      {
        'title': 'HOLD FOR HIGHER VALUE',
        'subtitle': 'Better to wait',
        'items': [
          'Atomic Skis',
          'High-end Electronics',
          'Collectibles',
          'Premium Bikes',
        ],
        'count': '3',
        'icon': CupertinoIcons.gift,
        'color': green,
        'soft': greenSoft,
      },
    ];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.h_25,
                height: Dimensions.h_25,
                decoration: BoxDecoration(
                  color: orangeSoft,
                  borderRadius: BorderRadius.circular(
                    Dimensions.h_6,
                  ),
                  border: Border.all(
                    color: orange,
                    width: 0.8,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.sparkles,
                  color: orange,
                  size: Dimensions.h_15,
                ),
              ),
              SizedBox(width: Dimensions.w_5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'AI Selling Brief',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ink,
                              fontSize: FontSize.sp_13_5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        SizedBox(width: Dimensions.w_4),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_4,
                            vertical: Dimensions.h_1,
                          ),
                          decoration: BoxDecoration(
                            color: blueSoft,
                            borderRadius: BorderRadius.circular(
                              Dimensions.h_3,
                            ),
                            border: Border.all(
                              color: blue,
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            'ISSAQUAH',
                            style: TextStyle(
                              color: blue,
                              fontSize: FontSize.sp_8,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '4 key insights for you this week',
                      style: TextStyle(
                        color: copy,
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'View Full Brief',
                style: TextStyle(
                  color: blue,
                  fontSize: FontSize.sp_9,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: Dimensions.w_3),
              Icon(
                CupertinoIcons.arrow_right,
                color: blue,
                size: Dimensions.h_12,
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: briefItems.length,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: Dimensions.w_5,
              mainAxisSpacing: Dimensions.h_5,
              mainAxisExtent: Dimensions.h_150,
            ),
            itemBuilder: (context, index) {
              final item = briefItems[index];
              return _sellingBriefCard(
                title: item['title'] as String,
                subtitle: item['subtitle'] as String,
                items: item['items'] as List<String>,
                count: item['count'] as String,
                icon: item['icon'] as IconData,
                color: item['color'] as Color,
                softColor: item['soft'] as Color,
                surface: surface,
                ink: ink,
                copy: copy,
                muted: muted,
                line: line,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sellingBriefCard({
    required String title,
    required String subtitle,
    required List<String> items,
    required String count,
    required IconData icon,
    required Color color,
    required Color softColor,
    required Color surface,
    required Color ink,
    required Color copy,
    required Color muted,
    required Color line,
  }) {
    return CommonCard(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.h_23,
                height: Dimensions.h_23,
                decoration: BoxDecoration(
                  color: softColor,
                  borderRadius: BorderRadius.circular(Dimensions.h_5),
                  border: Border.all(
                    color: color.withValues(alpha: 0.45),
                    width: 0.5)),
                child: Icon(
                  icon,
                  color: color,
                  size: Dimensions.h_12)),
              SizedBox(width: Dimensions.w_5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: ink,
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w700)),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_9_5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.h_2),
                    child: Row(
                      children: [
                        Container(
                          width: Dimensions.h_4,
                          height: Dimensions.h_4,
                          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                        SizedBox(width: Dimensions.w_4),
                        Expanded(
                          child: Text(
                            item,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: FontSize.sp_9_5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: Dimensions.h_25,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: softColor,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    Dimensions.h_5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    'View Items ($count)',
                    style: TextStyle(
                      color: color,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: Dimensions.w_3),
                  Icon(
                    CupertinoIcons.arrow_right,
                    color: color,
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

  Widget _cashInfo({
    required String value,
    required String title,
    required String subtitle,
    required String items,
    required Color ink,
    required Color copy,
    required Color muted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: ink,
            fontSize: FontSize.sp_11,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: Dimensions.h_4),
        Text(
          '$title $subtitle',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: copy,
            fontSize: FontSize.sp_8,
            height: 1.15,
          ),
        ),
        SizedBox(height: Dimensions.h_1),
        Text(
          items,
          style: TextStyle(
            color: muted,
            fontSize: FontSize.sp_8,
          ),
        ),
      ],
    );
  }

  Widget _lossRow(
      String title,
      String value,
      Color red,
      Color copy, {
        String? suffix,
      }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.h_1,
      ),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.circle_fill,
            color: red,
            size: Dimensions.h_8,
          ),
          SizedBox(width: Dimensions.w_4),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: copy,
                      fontSize: FontSize.sp_9,
                    ),
                  ),
                ),

                if (suffix != null) ...[
                  SizedBox(width: Dimensions.w_2),
                  Text(
                    suffix,
                    style: TextStyle(
                      color: copy,
                      fontSize: FontSize.sp_9,
                    ),
                  ),
                ],
              ],
            ),
          ),

          SizedBox(width: Dimensions.w_2),

          Text(
            value,
            style: TextStyle(
              color: red,
              fontSize: FontSize.sp_9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeroHeader(bool isLight) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedWeatherImage(
          height: Dimensions.h_330,
          image: "https://preetis-html.vercel.app/assets/images/garage/my-garage-version1/garage-v1-hero.webp"),
        Positioned.fill(
          child: Container(
            height: Dimensions.h_330,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFF020B15).withValues(alpha: 0.85),
                  const Color(0xFF020B15).withValues(alpha: 0.65),
                  const Color(0xFF020B15).withValues(alpha: 0.35),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.30, 0.58, 1.0],
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.h_330,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_10),
                  child: Text(
                    'WELCOME BACK SEAN',
                    style: TextStyle(
                      color: const Color(0xFFFFE47A),
                      fontSize: FontSize.sp_11,
                      fontWeight: FontWeight.w900))),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_5,top: Dimensions.h_8,bottom: Dimensions.h_5),
                child: Text(
                  "My Garage".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_22,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.9),
                        blurRadius: 30,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.w_8,
                    top: Dimensions.h_5,
                    right: Dimensions.w_50),
                child: Text(
                  'A cleaner home is a freer tomorrow.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_13_5,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.9),
                        blurRadius: 30,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              communityStatsSection(),
              SizedBox(height: Dimensions.h_5),
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
                    (isLight
                        ? AppColor.softBackground
                        : AppColor.backgroundDark)
                        .withValues(alpha: 0.0),

                    (isLight
                        ? AppColor.softBackground
                        : AppColor.backgroundDark)
                        .withValues(alpha: 0.15),

                    (isLight
                        ? AppColor.softBackground
                        : AppColor.backgroundDark)
                        .withValues(alpha: 0.35),

                    (isLight
                        ? AppColor.softBackground
                        : AppColor.backgroundDark)
                        .withValues(alpha: 0.78),

                    isLight
                        ? AppColor.softBackground
                        : AppColor.backgroundDark,
                  ],
                  stops: const [
                    0.08,
                    0.25,
                    0.45,
                    0.75,
                    1.0,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget communityStatsSection() {
    final stats = [
      {
        'icon': CupertinoIcons.cube_box,
        'value': '37',
        'label': 'Items Tracked',
      },
      {
        'icon': CupertinoIcons.tag,
        'value': '12',
        'label': 'Active Listings',
      },
      {
        'icon': CupertinoIcons.money_dollar_circle,
        'value': '\$2,180',
        'label': 'Cash Opportunity',
      },
      {
        'icon': CupertinoIcons.clock,
        'value': '43',
        'label': 'Successful Sales',
      },
      {
        'icon': CupertinoIcons.star,
        'value': '4.9',
        'label': 'Seller Rating',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_15,
        vertical: Dimensions.h_10,
      ),
      child: Column(
        children: List.generate(
          (stats.length / 2).ceil(),
              (rowIndex) {
            final firstIndex = rowIndex * 2;
            final secondIndex = firstIndex + 1;

            final firstStat = stats[firstIndex];
            final secondStat =
            secondIndex < stats.length ? stats[secondIndex] : null;
            return Padding(
              padding: EdgeInsets.only(
                bottom: rowIndex != (stats.length / 2).ceil() - 1
                    ? Dimensions.h_12
                    : 0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _communityStatItem(
                      icon: firstStat['icon'] as IconData,
                      value: firstStat['value'] as String,
                      label: firstStat['label'] as String,
                    ),
                  ),
                  Expanded(
                    child: secondStat != null
                        ? _communityStatItem(
                      icon: secondStat['icon'] as IconData,
                      value: secondStat['value'] as String,
                      label: secondStat['label'] as String,
                    )
                        : const SizedBox(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _communityStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: Dimensions.h_18,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF8fd9ae),
        ),
        SizedBox(width: Dimensions.w_8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  value,
                  style: TextStyle(
                      fontSize: FontSize.sp_15,
                      fontWeight: FontWeight.w900,
                      color: AppColor.white)),
              Text(
                label,
                style: TextStyle(
                  fontSize: FontSize.sp_10,
                  color: AppColor.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.9),
                      blurRadius: 30,
                      offset: const Offset(0, 2),
                    ),
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.9),
                      blurRadius: 30,
                      offset: const Offset(0, 2),
                    ),
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.9),
                      blurRadius: 30,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
