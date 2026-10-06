import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/events/events_screen_shimmer.dart';
import 'package:wikixm/Presentation/garage/controller.dart';
import 'package:wikixm/Presentation/widgets/ai_brief.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import 'package:wikixm/data/datasource/remote/models/response/my_garage_dashboard.dart';
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
  final GarageController garageController = Get.put(GarageController());

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
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900, letterSpacing: 1, height: 1),
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
                        decoration: BoxDecoration(color: isLight ? Theme.of(context).highlightColor.withValues(alpha: 0.2) : Theme.of(context).highlightColor.withValues(alpha: 0.10), shape: BoxShape.circle),
                        child: Icon(Icons.close_rounded, color: Theme.of(context).primaryColor, size: Dimensions.h_10),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_20),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              menuItem(context, title: 'Overview', icon: CupertinoIcons.house, isSelected: true, onTap: () {}, isLight: isLight),
              menuItem(
                context,
                title: 'MarketPlace',
                icon: CupertinoIcons.gift_fill,
                isSelected: false,
                onTap: () {
                  Get.toNamed(AppRoutes.marketPlace);
                  sliderDrawerKey.currentState?.closeSlider();
                },
                isLight: isLight,
              ),
              menuItem(
                context,
                title: 'Market Brief',
                icon: CupertinoIcons.chart_bar_alt_fill,
                isSelected: false,
                onTap: () {
                  Get.toNamed(AppRoutes.marketBrief);
                  sliderDrawerKey.currentState?.closeSlider();
                },
                isLight: isLight,
              ),
              menuItem(context, title: 'My Inventory', icon: CupertinoIcons.cube_box, onTap: () {}, isLight: isLight, badge: '37'),
              menuItem(context, title: 'My Listings', icon: CupertinoIcons.tag, onTap: () {}, isLight: isLight, badge: '12'),
              menuItem(context, title: 'Messages', icon: CupertinoIcons.envelope, onTap: () {}, isLight: isLight, badge: '3', isBadgeRed: true),
              menuItem(context, title: 'Offers', icon: CupertinoIcons.search, onTap: () {}, isLight: isLight, badge: '1', isBadgeRed: true),
              menuItem(context, title: 'Saved Searches', icon: CupertinoIcons.bookmark, onTap: () {}, isLight: isLight),
              menuItem(context, title: 'My Favourites', icon: CupertinoIcons.heart_fill, onTap: () {}, isLight: isLight),
              menuItem(context, title: 'Selling Calendar', icon: CupertinoIcons.calendar, onTap: () {}, isLight: isLight),
              menuItem(context, title: 'Sales History', icon: CupertinoIcons.clock, onTap: () {}, isLight: isLight),
              menuItem(context, title: 'AI Assistant', icon: CupertinoIcons.sparkles, onTap: () {}, isLight: isLight),
              menuItem(context, title: 'Account Settings', icon: CupertinoIcons.gear, onTap: () {}, isLight: isLight),
              menuItem(
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
        body: GetBuilder(
          id: ControllerBuilders.myGarageController,
          init: garageController,
          builder: (controller) {
            return controller.isLoading
                ? EventsScreenShimmer()
                : CommonScrollBlurScaffold(
                    isDrawer: true,
                    onTap: () {
                      sliderDrawerKey.currentState?.openSlider();
                    },
                    expandedHeight: Dimensions.h_260,
                    expandedColor: Colors.white,
                    collapsedColor: Theme.of(context).highlightColor,
                    hero: buildHeroHeader(isLight, controller),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
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
                                    Icon(CupertinoIcons.sparkles, size: Dimensions.h_25, color: Theme.of(context).primaryColor),
                                    SizedBox(width: Dimensions.w_12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: Dimensions.h_2),
                                          Row(
                                            children: [
                                              Text(
                                                'ASK WIKIXM AI',
                                                style: TextStyle(color: Theme.of(Get.context!).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, letterSpacing: 0.1),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(left: Dimensions.w_4),
                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_3),
                                                decoration: BoxDecoration(color: !isLight ? const Color(0xffffc264) : const Color(0xFF97590a), borderRadius: BorderRadius.circular(999)),
                                                child: Text(
                                                  'COMING SOON',
                                                  style: TextStyle(color: !isLight ? AppColor.black : AppColor.white, fontSize: FontSize.sp_7, fontWeight: FontWeight.w800, letterSpacing: 0.5, height: 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: Dimensions.h_5),
                                          Text(
                                            "Ask anything about pine valley events, places, venues and more",
                                            style: TextStyle(color: Theme.of(Get.context!).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: Dimensions.h_6),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: Dimensions.w_20, right: Dimensions.w_10),
                                      padding: EdgeInsets.symmetric(vertical: Dimensions.h_5, horizontal: Dimensions.w_5),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.darkBlue),
                                      child: Icon(CupertinoIcons.chat_bubble, size: Dimensions.h_18, color: AppColor.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: Dimensions.h_70)),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget menuItem(BuildContext context, {required String title, required IconData icon, bool isSelected = false, VoidCallback? onTap, bool? isLight, String? badge, bool isBadgeRed = false}) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: Dimensions.h_2, right: Dimensions.w_20),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7, vertical: Dimensions.h_4),
        decoration: BoxDecoration(
          color: isSelected ? (isLight == true ? const Color(0xFFEDF3FB) : const Color(0xFF14223A)) : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.h_6),
          border: isSelected ? Border.all(color: theme.primaryColorDark.withValues(alpha: 0.50), width: 0.5) : null,
        ),
        child: Row(
          children: [
            Container(
              width: Dimensions.h_22,
              height: Dimensions.h_22,
              decoration: BoxDecoration(
                color: isSelected ? (isLight == true ? const Color(0xFFEDF3FB) : const Color(0xFF14223A)) : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? theme.primaryColorDark.withValues(alpha: 0.50) : theme.primaryColor.withValues(alpha: 0.30), width: 0.5),
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
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w700,
                  height: 1,
                ),
              ),
            ),
            if (badge != null)
              Container(
                constraints: BoxConstraints(minWidth: Dimensions.h_15, minHeight: Dimensions.h_15),
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: isBadgeRed ? const Color(0xFFE51B3E) : const Color(0xFF2775C9), shape: BoxShape.circle),
                child: Text(
                  badge,
                  style: TextStyle(color: Colors.white, fontSize: FontSize.sp_8, fontWeight: FontWeight.w900),
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

    final topSeller = garageController.dashboardData?.sections?.topSellers;

    final rankings = topSeller?.rankings;

    final sellers = rankings?.speed ?? [];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: Dimensions.h_25,
                height: Dimensions.h_25,
                decoration: BoxDecoration(color: orangeSoft, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                child: Icon(CupertinoIcons.person_solid, color: orange, size: Dimensions.h_15),
              ),
              SizedBox(width: Dimensions.w_5),
              Expanded(
                child: Text(
                  topSeller?.title ?? 'Top Sellers',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                'See All',
                style: TextStyle(color: blue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h_10),

          Container(
            height: Dimensions.h_28,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(Dimensions.h_5),
              border: Border.all(color: line, width: 0.6),
            ),
            child: Row(
              children: [
                ...?topSeller?.filters?.where((filter) => filter.enabled == true).map((filter) {
                  final isSelected = (topSeller?.defaultSort ?? 'speed') == filter.key;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // If you have a selected sort variable,
                        // update it here and call update().
                      },
                      child: Container(
                        margin: EdgeInsets.all(Dimensions.h_2),
                        decoration: BoxDecoration(color: isSelected ? blue : Colors.transparent, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                        alignment: Alignment.center,
                        child: Text(
                          filter.label ?? '',
                          style: TextStyle(color: isSelected ? Colors.white : copy, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: Dimensions.h_4),

          ...List.generate(sellers.length, (index) {
            final seller = sellers[index];

            final isYou = seller.isCurrentUser == true;

            final imageUrl = seller.imageUrl?.trim();

            return Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
              padding: EdgeInsets.symmetric(vertical: Dimensions.h_4, horizontal: Dimensions.w_2),
              decoration: BoxDecoration(
                color: isYou ? blueSoft.withValues(alpha: 0.65) : Colors.transparent,
                border: Border(
                  bottom: BorderSide(color: line, width: index == sellers.length - 1 ? 0 : 0.5),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: Dimensions.w_15,
                    child: Text(
                      '${seller.rank ?? index + 1}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: isYou ? ink : copy, fontSize: FontSize.sp_14, fontWeight: FontWeight.w700),
                    ),
                  ),

                  SizedBox(width: Dimensions.w_3),

                  Container(
                    width: Dimensions.h_30,
                    height: Dimensions.h_30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: blueSoft,
                      border: Border.all(color: line, width: 0.5),
                    ),
                    child: ClipOval(
                      child: imageUrl != null && imageUrl.isNotEmpty
                          ? AppCacheImage(imageUrl: imageUrl, widthSize: Dimensions.h_30, size: Dimensions.h_30, fit: BoxFit.cover)
                          : Center(
                              child: Text(
                                seller.initials ?? '',
                                style: TextStyle(color: blue, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                              ),
                            ),
                    ),
                  ),

                  SizedBox(width: Dimensions.w_5),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          seller.label ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: Dimensions.h_1),
                        Text(
                          seller.salesLabel ?? '',
                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        seller.speedLabel ?? '',
                        style: TextStyle(color: ink, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: Dimensions.h_1),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.star_fill, color: gold, size: Dimensions.h_10),
                          SizedBox(width: Dimensions.w_2),
                          Text(
                            seller.ratingLabel ?? 'Not rated',
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: Dimensions.h_10),

          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            width: double.infinity,
            padding: EdgeInsets.all(Dimensions.w_5),
            decoration: BoxDecoration(
              color: blueSoft,
              borderRadius: BorderRadius.circular(Dimensions.h_5),
              border: Border.all(color: blue.withValues(alpha: 0.45), width: 0.6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(CupertinoIcons.arrow_up, color: blue, size: Dimensions.h_15),
                SizedBox(width: Dimensions.w_4),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: copy, fontSize: FontSize.sp_9_5),
                      children: [
                        TextSpan(
                          text: 'Top sellers move items fast.\n',
                          style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                        ),
                        TextSpan(text: topSeller?.description ?? ''),
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
    final surface = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF0B2035);

    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);

    final copy = isLight ? const Color(0xFF344779) : const Color(0xFFC9D5E8);

    final muted = isLight ? const Color(0xFF63728F) : const Color(0xFFAAB8CF);

    final line = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);

    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);

    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);

    final green = isLight ? const Color(0xFF087C4B) : const Color(0xFF64D9A2);

    final greenSoft = isLight ? const Color(0xFFE8F7EF) : const Color(0xFF123D36);

    final red = isLight ? const Color(0xFFB4232D) : const Color(0xFFFF8E96);

    final redSoft = isLight ? const Color(0xFFFFF0F1) : const Color(0xFF48242B);

    final orange = isLight ? const Color(0xFFA14F00) : const Color(0xFFFFC36C);

    final orangeSoft = isLight ? const Color(0xFFFFF3E4) : const Color(0xFF49371F);

    final inventory =
        garageController.dashboardData?.inventory;

    final items = inventory?.items ?? [];

    final counts = inventory?.counts;

    final activeCount = counts?.activeCount ?? 0;
    final draftCount = counts?.draftCount ?? 0;
    final soldCount = counts?.soldCount ?? 0;
    final expiredCount = counts?.expiredCount ?? 0;

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
                      'My Listings ($activeCount)',
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
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w_1,
            ),
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
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w_1,
            ),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _listingFilter(
                  title: 'Active',
                  count: activeCount.toString(),
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
                  count: draftCount.toString(),
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
                  count: soldCount.toString(),
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
                  count: expiredCount.toString(),
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

          SizedBox(height: Dimensions.h_15),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w_1,
            ),
            separatorBuilder: (context, index) {
              return SizedBox(
                height: Dimensions.h_6,
              );
            },
            itemBuilder: (context, index) {
              final item = items[index];

              final price = item.price ?? 0;

              return _listingMobileCard(
                imageUrl: item.imageUrl ?? '',
                name: item.title?.trim().isNotEmpty == true
                    ? item.title!.trim()
                    : 'Untitled Listing',

                location: item.cityName?.trim().isNotEmpty == true
                    ? item.cityName!.trim()
                    : 'Unknown Location',

                status: item.isFeatured == true
                    ? 'Featured'
                    : item.isSold == true
                    ? 'Sold'
                    : 'Active',

                score: '${item.totalViews ?? 0}/100',

                price: formatCurrency(price),

                views: (item.totalViews ?? 0).toString(),

                saves: (item.totalSaves ?? 0).toString(),

                days: item.itemCondition.toString() ?? '',

                trend: '',

                trendText: item.categoryTitle ?? '',

                trendColor: muted,

                trendIcon: CupertinoIcons.minus,

                statusColor: item.isSold == true
                    ? green
                    : item.isFeatured == true
                    ? orange
                    : green,

                statusSoft: item.isSold == true
                    ? greenSoft
                    : item.isFeatured == true
                    ? orangeSoft
                    : greenSoft,

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
    required String imageUrl,
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
      isBorder: false,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCacheImage(imageUrl: imageUrl,size: Dimensions.h_90,widthSize: Dimensions.h_100,isShadow: false),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: Dimensions.h_5),
                    Text(
                      location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11),
                    ),
                    SizedBox(height: Dimensions.h_8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_2),
                      decoration: BoxDecoration(
                        color: statusSoft,
                        borderRadius: BorderRadius.circular(Dimensions.h_3),
                        border: Border.all(color: statusColor.withValues(alpha: 0.45), width: 0.5),
                      ),
                      child: Text(
                        '$status · $score',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: statusColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
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
                  child: _listingMetric(value: price, label: 'Price', ink: ink, muted: muted),
                ),
                _listingMetricDivider(line),
                Expanded(
                  child: _listingMetric(value: views, label: 'Views', ink: ink, muted: muted),
                ),

                _listingMetricDivider(line),

                Expanded(
                  child: _listingMetric(value: saves, label: 'Saves', ink: ink, muted: muted),
                ),

                _listingMetricDivider(line),

                Expanded(
                  child: _listingMetric(value: days, label: 'Condition', ink: ink, muted: muted),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Row(
            children: [
              Text(
                trendText,
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11,fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              SizedBox(
                height: Dimensions.h_22,
                width: Dimensions.w_75,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: blue,
                    side: BorderSide(color: blue.withValues(alpha: 0.5), width: 0.7),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_5)),
                  ),
                  child: Text(
                    'Manage',
                    style: TextStyle(color: blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listingMetric({required String value, required String label, required Color ink, required Color muted}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: ink, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800),
        ),
        Text(
          label,
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5),
        ),
      ],
    );
  }

  Widget _listingFilter({required String title, required String count, required bool selected, required Color blue, required Color blueSoft, required Color line, required Color ink, required Color muted}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_6),
      decoration: BoxDecoration(
        color: selected ? blue : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.h_5),
        border: Border.all(color: selected ? blue : line, width: 0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(color: selected ? Colors.white : ink, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: Dimensions.w_3),
          Text(
            "($count)",
            style: TextStyle(color: selected ? Colors.white : muted, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _listingMetricDivider(Color line) {
    return Container(width: 0.5, height: Dimensions.h_25, color: line);
  }

  Widget myInventory(bool isLight) {
    final surface = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF0B2035);

    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);

    final copy = isLight ? const Color(0xFF344779) : const Color(0xFFC9D5E8);

    final muted = isLight ? const Color(0xFF63728F) : const Color(0xFFAAB8CF);

    final line = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);

    final orange = isLight ? const Color(0xFFA14F00) : const Color(0xFFFFC36C);

    final orangeSoft = isLight ? const Color(0xFFFFF3E4) : const Color(0xFF49371F);

    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);

    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);

    final green = isLight ? const Color(0xFF087C4B) : const Color(0xFF64D9A2);

    final greenSoft = isLight ? const Color(0xFFE8F7EF) : const Color(0xFF123D36);

    final red = isLight ? const Color(0xFFB4232D) : const Color(0xFFFF8E96);

    final redSoft = isLight ? const Color(0xFFFFF0F1) : const Color(0xFF48242B);

    final counts = garageController.dashboardData?.counts;

    final totalItems = counts?.totalItems ?? 0;
    final activeCount = counts?.activeCount ?? 0;
    final draftCount = counts?.draftCount ?? 0;
    final soldCount = counts?.soldCount ?? 0;
    final expiredCount = counts?.expiredCount ?? 0;
    final estimatedValue = counts?.estimatedValue ?? 0;

    final inventoryStats = [
      {'value': '$activeCount', 'title': 'Listed for Sale', 'icon': CupertinoIcons.calendar, 'color': blue, 'softColor': blueSoft},
      {'value': '$draftCount', 'title': 'Not Listed Yet', 'icon': CupertinoIcons.cube_box, 'color': green, 'softColor': greenSoft},
      {'value': '$soldCount', 'title': 'Sold Items', 'icon': CupertinoIcons.checkmark_circle, 'color': green, 'softColor': greenSoft},
      {'value': '$expiredCount', 'title': 'Expired Items', 'icon': CupertinoIcons.clock, 'color': red, 'softColor': redSoft},
      {'value': formatCurrency(estimatedValue), 'title': 'Estimated Value (all items)', 'icon': CupertinoIcons.money_dollar, 'color': green, 'softColor': greenSoft},
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
                  borderRadius: BorderRadius.circular(Dimensions.h_6),
                  border: Border.all(color: orange, width: 0.8),
                ),
                child: Icon(CupertinoIcons.cube_box, color: orange, size: Dimensions.h_15),
              ),

              SizedBox(width: Dimensions.w_5),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Inventory ($totalItems items)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ink, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: Dimensions.h_1),
                    Text(
                      'Everything you own. Track value. Get recommendations.',
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9),
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
                      style: TextStyle(color: blue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800),
                    ),

                    SizedBox(width: Dimensions.w_2),

                    Icon(CupertinoIcons.arrow_right, color: blue, size: Dimensions.h_8),
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: Dimensions.w_5, mainAxisSpacing: Dimensions.h_5, mainAxisExtent: Dimensions.h_45),
            itemBuilder: (context, index) {
              final item = inventoryStats[index];

              return _inventoryStat(value: item['value'] as String, title: item['title'] as String, icon: item['icon'] as IconData, color: item['color'] as Color, softColor: item['softColor'] as Color, ink: ink, muted: muted, line: line, surface: surface);
            },
          ),
        ],
      ),
    );
  }

  Widget _inventoryStat({required String value, required String title, required IconData icon, required Color color, required Color softColor, required Color ink, required Color muted, required Color line, required Color surface}) {
    return CommonCard(
      padding: EdgeInsets.only(left: Dimensions.w_4),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          Container(
            width: Dimensions.h_22,
            height: Dimensions.h_22,
            decoration: BoxDecoration(color: softColor, borderRadius: BorderRadius.circular(Dimensions.h_5)),
            child: Icon(icon, color: color, size: Dimensions.h_15),
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
                  style: TextStyle(color: ink, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: Dimensions.h_1),
                Text(
                  title,
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5, height: 1.1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bestMovesToday(bool isLight) {
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
    final bestMoves = garageController.dashboardData?.bestMoves;
    final moves = <Map<String, dynamic>>[];
    if (bestMoves?.priceReview != null) {
      moves.add({'key': 'price_review', 'data': bestMoves!.priceReview});
    }

    if (bestMoves?.completeDraft != null) {
      moves.add({'key': 'complete_draft', 'data': bestMoves!.completeDraft});
    }

    if (bestMoves?.inventoryReview != null) {
      moves.add({'key': 'inventory_review', 'data': bestMoves!.inventoryReview});
    }

    return Column(
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
                borderRadius: BorderRadius.circular(Dimensions.h_6),
                border: Border.all(color: red, width: 0.7),
              ),
              child: Icon(CupertinoIcons.scope, color: red, size: Dimensions.h_15),
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
                    style: TextStyle(color: ink, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Small actions. Bigger results.',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.h_25,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(CupertinoIcons.add, size: Dimensions.h_13),
                label: Text(
                  'Do All 3 Actions',
                  style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w800),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_5)),
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
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_1),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_5, mainAxisSpacing: Dimensions.h_5, mainAxisExtent: Dimensions.h_130),
          itemBuilder: (context, index) {
            final move = moves[index];
            final data = move['data'];
            return _bestMoveCard(
              number: '${index + 1}',
              title: data.title ?? '',
              description: data.description ?? '',
              buttonText: data.action?.label ?? '',
              imageUrl: data.item?.imageUrl,
              icon: _bestMoveIcon(move['key']),
              color: _bestMoveColor(move['key'], isLight),
              softColor: _bestMoveSoftColor(move['key'], isLight),
              surface: surface,
              ink: ink,
              copy: copy,
              muted: muted,
              line: line,
              isLight: isLight,
              enabled: data.action?.enabled ?? false,
            );
          },
        ),
      ],
    );
  }

  Color _bestMoveSoftColor(String key, bool isLight) {
    switch (key) {
      case 'price_review':
        return isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);

      case 'complete_draft':
        return isLight ? const Color(0xFFFFF4E5) : const Color(0xFF493719);

      case 'inventory_review':
        return isLight ? const Color(0xFFE7F8F1) : const Color(0xFF163F35);

      default:
        return isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);
    }
  }

  FaIconData _bestMoveIcon(String key) {
    switch (key) {
      case 'price_review':
        return FontAwesomeIcons.tag;

      case 'complete_draft':
        return FontAwesomeIcons.filePen;

      case 'inventory_review':
        return FontAwesomeIcons.boxesStacked;

      default:
        return FontAwesomeIcons.lightbulb;
    }
  }

  Color _bestMoveColor(String key, bool isLight) {
    switch (key) {
      case 'price_review':
        return isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);

      case 'complete_draft':
        return isLight ? const Color(0xFFD97706) : const Color(0xFFFBBF24);

      case 'inventory_review':
        return isLight ? const Color(0xFF059669) : const Color(0xFF34D399);

      default:
        return isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    }
  }

  Widget _bestMoveCard({
    required String number,
    required String title,
    required String description,
    required String buttonText,
    required String? imageUrl,
    required FaIconData icon,
    required Color color,
    required Color softColor,
    required Color surface,
    required Color ink,
    required Color copy,
    required Color muted,
    required Color line,
    required bool isLight,
    required bool enabled,
  }) {
    final hasImage = imageUrl != null && imageUrl.trim().isNotEmpty;

    return CommonCard(
      color: Theme.of(context).cardColor,
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
                    width: Dimensions.h_50,
                    height: Dimensions.h_50,
                    decoration: BoxDecoration(color: softColor, borderRadius: BorderRadius.circular(Dimensions.h_5)),
                    child: hasImage
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.h_5),
                            child: AppCacheImage(imageUrl: imageUrl, radius: Dimensions.h_5, widthSize: Dimensions.h_100, size: Dimensions.h_100, fit: BoxFit.cover),
                          )
                        : Center(
                            child: FaIcon(icon, color: color, size: Dimensions.h_20),
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
                        border: Border.all(color: color.withValues(alpha: 0.35), width: 0.6),
                      ),
                      child: Text(
                        number,
                        style: TextStyle(color: color, fontSize: FontSize.sp_8, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: Dimensions.w_8),
              Expanded(
                child: Text(
                  title,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600, height: 1.15),
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h_8),

          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5, height: 1.25),
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            height: Dimensions.h_25,
            child: OutlinedButton(
              onPressed: enabled ? () {} : null,
              style: OutlinedButton.styleFrom(
                foregroundColor: isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68),
                side: BorderSide(color: isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF), width: 0.4),
                backgroundColor: isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_5)),
              ),
              child: Text(
                buttonText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget aiBrief() {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return CommonAiBrief(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppCacheImage(
                imageUrl:
                'https://preetis-html.vercel.app/assets/images/school/version2/ai-guide.webp',
                size: Dimensions.h_28,
                widthSize: Dimensions.h_28,
                isCircle: true,
                isShadow: false,
              ),
              SizedBox(width: Dimensions.w_10),
              Text(
                'AI Selling Brief'.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isLight
                      ? const Color(0xFF061C55)
                      : AppColor.white,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_8,
                  vertical: Dimensions.h_3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF6743E6),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  'BETA',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: FontSize.sp_9,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_12),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: isLight
                      ? const Color(0xFF061C55)
                      : AppColor.white,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
                children: [
                  TextSpan(
                    text:
                    'Hello, ${garageController.dashboardData?.sections?.sellerProfile?.name
                        ?.trim()
                        .split(' ')
                        .first ?? ''}.',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(text: ' You have '),
                  TextSpan(
                    text: formatCurrency(
                      garageController.dashboardData?.counts?.estimatedValue,
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(
                    text: ' in asking value ',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const TextSpan(text: 'across your Garage.'),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: Dimensions.w_8),
            shrinkWrap: true,
            itemCount: garageController.aiGarageData?.insights?.length ?? 0,
            itemBuilder: (c, i) {
              return Padding(
                padding: EdgeInsets.only(bottom: Dimensions.h_6),
                child: CommonBulletItem(
                  text: garageController.aiGarageData?.insights?[i] ?? '',
                  textFontWeight: FontWeight.w500,
                ),
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
                style: TextStyle(
                  color: isLight
                      ? const Color(0xFF061C55)
                      : AppColor.white,
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              SizedBox(width: Dimensions.w_4),
              Icon(
                Icons.arrow_forward,
                color: isLight
                    ? const Color(0xFF061C55)
                    : AppColor.white,
                size: Dimensions.h_13,
              ),
              SizedBox(width: Dimensions.w_15),
            ],
          ),
        ],
      ),
    );
  }

  Widget cash(bool isLight) {
    final surface = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF0B2035);
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final copy = isLight ? const Color(0xFF344779) : const Color(0xFFC9D5E8);
    final muted = isLight ? Colors.grey.shade800 : Colors.grey.shade200;
    final green = isLight ? const Color(0xFF087C4B) : const Color(0xFF64D9A2);
    final greenDeep = isLight ? const Color(0xFF05633B) : const Color(0xFF45BF86);
    final greenSoft = isLight ? const Color(0xFFE8F7EF) : const Color(0xFF123D36);
    final red = isLight ? const Color(0xFFB4232D) : const Color(0xFFFF8E96);
    final redSoft = isLight ? const Color(0xFFFFF0F1) : const Color(0xFF48242B);
    final line = isLight ? Colors.grey : Colors.white24;
    final greenGradient = Color.lerp(greenSoft, surface, 0.16)!;
    final redGradient = Color.lerp(redSoft, surface, 0.12)!;
    final valueOverview = garageController.dashboardData?.sections?.valueOverview;
    final cashOpportunity = valueOverview?.cashOpportunity;
    final listingReview = valueOverview?.listingReview;
    final cashMetrics = cashOpportunity?.metrics ?? [];
    final activeMetric = cashMetrics.firstWhere((item) => item.key == 'active', orElse: () => cashMetrics.isNotEmpty ? cashMetrics.first : Metric());
    final draftMetric = cashMetrics.firstWhere((item) => item.key == 'draft', orElse: () => cashMetrics.length > 1 ? cashMetrics[1] : Metric());
    final cashValue = formatCurrency(cashOpportunity?.value);
    final activeValue = formatCurrency(activeMetric.value);
    final draftValue = formatCurrency(draftMetric.value);
    final activeItems = activeMetric.description ?? '';
    final draftItems = draftMetric.description ?? '';
    final barSegments = cashOpportunity?.barSegments ?? [];
    final activePercentage = barSegments.firstWhere((item) => item.key == 'active', orElse: () => BarSegment()).percentage ?? 0;
    final progressValue = (activePercentage / 100).clamp(0.0, 1.0);
    final cashTitle = 'Estimated Cash ';
    final cashDescription = cashOpportunity?.description ?? 'The total value you could turn into cash.';
    final cashAction = cashOpportunity?.action?.label ?? 'Find My Hidden Cash';
    final reviewTitle = listingReview?.title ?? 'Cost of Waiting';
    final reviewDescription = listingReview?.description ?? 'Estimated resale value you could lose over the next 90 days.';
    final reviewValue = listingReview?.formattedValue ?? formatCurrency(listingReview?.value);
    final reviewAction = listingReview?.action?.label ?? 'Protect My Value';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: Dimensions.h_200,
            padding: EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_8, Dimensions.w_8, Dimensions.h_8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.h_10),
              border: Border.all(color: isLight ? Colors.grey : Colors.white24, width: 0.4),
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [greenGradient, surface], stops: const [0.0, 0.76]),
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
                        border: Border.all(color: green, width: 0.8),
                      ),
                      child: Icon(CupertinoIcons.money_dollar, color: green, size: Dimensions.h_11),
                    ),
                    SizedBox(width: Dimensions.w_5),
                    Expanded(
                      child: Text(
                        cashTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: ink, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Dimensions.h_8),

                Text(
                  cashValue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: green, fontSize: FontSize.sp_22, height: 1, fontWeight: FontWeight.w900),
                ),

                SizedBox(height: Dimensions.h_8),

                Text(
                  cashDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: muted, fontSize: FontSize.sp_9, height: 1.2),
                ),

                SizedBox(height: Dimensions.h_10),

                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: Dimensions.h_5,
                    child: LinearProgressIndicator(value: progressValue, backgroundColor: isLight ? const Color(0xFFD6EDE1) : const Color(0xFF234B40), valueColor: AlwaysStoppedAnimation<Color>(green)),
                  ),
                ),

                SizedBox(height: Dimensions.h_5),

                Row(
                  children: [
                    Expanded(
                      child: _cashInfo(value: activeValue, title: activeMetric.label ?? 'Current Listings', subtitle: activeMetric.description ?? '', items: activeItems, ink: ink, copy: copy, muted: muted),
                    ),

                    Container(width: 0.4, height: Dimensions.h_50, color: line),

                    SizedBox(width: Dimensions.w_10),

                    Expanded(
                      child: _cashInfo(value: draftValue, title: draftMetric.label ?? 'Unlisted Inventory', subtitle: draftMetric.description ?? '', items: draftItems, ink: ink, copy: copy, muted: muted),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cashAction,
                          style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(width: Dimensions.w_4),
                        Icon(CupertinoIcons.arrow_right, size: Dimensions.h_10),
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
            padding: EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_8, Dimensions.w_8, Dimensions.h_8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.h_10),
              border: Border.all(color: isLight ? Colors.grey : Colors.white24, width: 0.4),
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [redGradient, surface], stops: const [0.0, 0.78]),
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
                        borderRadius: BorderRadius.circular(Dimensions.h_6),
                        border: Border.all(color: red, width: 0.8),
                      ),
                      child: Icon(CupertinoIcons.arrow_down_right, color: red, size: Dimensions.h_11),
                    ),
                    SizedBox(width: Dimensions.w_8),
                    Expanded(
                      child: Text(
                        reviewTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: ink, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_5),
                Text(
                  reviewValue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: red, fontSize: FontSize.sp_22, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: Dimensions.h_3),
                Text(
                  reviewDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: muted, fontSize: FontSize.sp_9_5, height: 1.2),
                ),
                SizedBox(height: Dimensions.h_10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.h_6),
                    border: Border.all(color: isLight ? const Color(0xFFE5C9CD) : const Color(0xFF66373D), width: 0.7),
                    color: isLight ? const Color(0xFFFFF8F8) : const Color(0xFF251A20),
                  ),
                  child: Column(
                    children: [
                      _lossRow('Active listings', listingReview?.metrics?.firstWhere((item) => item.key == 'active', orElse: () => Metric()).value?.toString() ?? '0', red, copy),
                      _lossRow('Saved drafts', listingReview?.metrics?.firstWhere((item) => item.key == 'draft', orElse: () => Metric()).value?.toString() ?? '0', red, copy),
                      _lossRow('Inactive listings', listingReview?.metrics?.firstWhere((item) => item.key == 'expired', orElse: () => Metric()).value?.toString() ?? '0', red, copy),
                      _lossRow('Value to review', formatCurrency(listingReview?.metrics?.firstWhere((item) => item.key == 'review', orElse: () => Metric()).value ?? 0), red, copy),
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
                      side: BorderSide(color: red, width: 0.8),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          reviewAction,
                          style: TextStyle(color: red, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(width: Dimensions.w_4),
                        Icon(CupertinoIcons.arrow_right, color: red, size: Dimensions.h_10),
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
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final copy = isLight ? const Color(0xFF344779) : const Color(0xFFC9D5E8);
    final muted = isLight ? Colors.grey.shade800 : Colors.grey.shade200;
    final line = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);
    final orange = isLight ? const Color(0xFFA14F00) : const Color(0xFFFFC36C);
    final orangeSoft = isLight ? const Color(0xFFFFF3E4) : const Color(0xFF49371F);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);
    final green = isLight ? const Color(0xFF087C4B) : const Color(0xFF64D9A2);
    final greenSoft = isLight ? const Color(0xFFE8F7EF) : const Color(0xFF123D36);
    final garageValueData = garageController.dashboardData?.sections?.valueOverview?.garageValue;
    final metrics = garageValueData?.metrics ?? [];

    final asking = metrics.firstWhere((item) => item.key == 'asking', orElse: () => Metric());

    final draft = metrics.firstWhere((item) => item.key == 'draft', orElse: () => Metric());

    final review = metrics.firstWhere((item) => item.key == 'review', orElse: () => Metric());

    final earned = metrics.firstWhere((item) => item.key == 'earned', orElse: () => Metric());

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
                  border: Border.all(color: orange, width: 0.8),
                ),
                child: Icon(CupertinoIcons.square_stack_3d_up, color: orange, size: Dimensions.h_15),
              ),
              SizedBox(width: Dimensions.w_5),
              Text(
                garageValueData?.title ?? 'Your Garage Value',
                style: TextStyle(color: ink, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_7),
          _garageValueRow(icon: CupertinoIcons.tag, iconColor: blue, iconBackground: blueSoft, value: formatCurrency(asking.value ?? 0), title: asking.label ?? 'Asking Value', subtitle: asking.description ?? '', ink: ink, copy: copy, muted: muted),
          _garageDivider(line, isLight),
          _garageValueRow(icon: CupertinoIcons.chart_bar, iconColor: blue, iconBackground: blueSoft, value: formatCurrency(draft.value ?? 0), title: draft.label ?? 'Draft Asking Value', subtitle: draft.description ?? '', ink: ink, copy: copy, muted: muted),
          _garageDivider(line, isLight),
          _garageValueRow(icon: CupertinoIcons.money_dollar_circle, iconColor: green, iconBackground: greenSoft, value: formatCurrency(review.value ?? 0), title: review.label ?? 'Review Value', subtitle: review.description ?? '', ink: ink, copy: copy, muted: muted),

          _garageDivider(line, isLight),

          _garageValueRow(icon: CupertinoIcons.money_dollar, iconColor: green, iconBackground: greenSoft, value: formatCurrency(earned.value ?? 0), title: earned.label ?? 'Lifetime Cash Earned', subtitle: earned.description ?? '', ink: ink, copy: copy, muted: muted),
        ],
      ),
    );
  }

  Widget _garageDivider(Color color, bool isLight) {
    return Container(height: 0.2, width: Get.width, color: isLight ? Colors.grey : Colors.white24);
  }

  Widget _garageValueRow({required IconData icon, required Color iconColor, required Color iconBackground, required String value, required String title, required String subtitle, required Color ink, required Color copy, required Color muted}) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.h_6, bottom: Dimensions.h_6, left: Dimensions.w_8),
      child: Row(
        children: [
          Container(
            width: Dimensions.h_25,
            height: Dimensions.h_25,
            decoration: BoxDecoration(color: iconBackground, borderRadius: BorderRadius.circular(Dimensions.h_5)),
            child: Icon(icon, color: iconColor, size: Dimensions.h_15),
          ),
          SizedBox(width: Dimensions.w_10),
          SizedBox(
            width: Dimensions.w_50,
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
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
                  style: TextStyle(color: copy, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: muted, fontSize: FontSize.sp_8_5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sellerProfile(bool isLight) {
    final surface = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF0B2035);
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final copy = isLight ? const Color(0xFF344779) : const Color(0xFFC9D5E8);
    final line = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);
    final green = isLight ? const Color(0xFF087C4B) : const Color(0xFF64D9A2);
    final gold = isLight ? const Color(0xFF9A6200) : const Color(0xFFFFD277);
    final goldSoft = isLight ? const Color(0xFFFFF6DD) : const Color(0xFF44391E);
    final seller = garageController.dashboardData?.sections?.sellerProfile;
    final name = seller?.name ?? '';
    final location = seller?.location ?? '';
    final imageUrl = seller?.imageUrl;
    final salesLabel = seller?.salesLabel ?? '';

    final details = seller?.details ?? [];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: Dimensions.h_25,
                height: Dimensions.h_25,
                decoration: BoxDecoration(color: blueSoft, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                child: Icon(CupertinoIcons.person, color: blue, size: Dimensions.h_15),
              ),
              SizedBox(width: Dimensions.w_5),
              Expanded(
                child: Text(
                  seller?.title ?? 'Your Seller Profile',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: ink, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  seller?.action?.label ?? 'View Profile',
                  style: TextStyle(color: blue, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w800),
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
              color: isLight ? const Color(0xFFF4F8FC) : const Color(0xFF112B44),
              borderRadius: BorderRadius.circular(Dimensions.h_7),
              border: Border.all(color: line, width: 0.6),
            ),
            child: Row(
              children: [
                Container(
                  width: Dimensions.h_38,
                  height: Dimensions.h_38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: surface, width: 2),
                    color: blueSoft,
                  ),
                  child: ClipOval(
                    child: imageUrl != null && imageUrl.isNotEmpty ? AppCacheImage(imageUrl: imageUrl, fit: BoxFit.cover) : Icon(CupertinoIcons.person_fill, color: blue, size: Dimensions.h_20),
                  ),
                ),

                SizedBox(width: Dimensions.w_7),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10),
                      ),
                      SizedBox(height: Dimensions.h_2),
                      Row(
                        children: [
                          Icon(CupertinoIcons.checkmark_seal_fill, color: green, size: Dimensions.h_8),
                          SizedBox(width: Dimensions.w_2),
                          Text(
                            salesLabel,
                            style: TextStyle(color: copy, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w600),
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

          ...details.map((detail) => _sellerProfileStat(icon: CupertinoIcons.checkmark_circle_fill, text: detail, color: green, copy: copy)),

          SizedBox(height: Dimensions.h_4),

          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_10),
            decoration: BoxDecoration(
              color: goldSoft,
              borderRadius: BorderRadius.circular(Dimensions.h_6),
              border: Border.all(color: gold.withValues(alpha: 0.55), width: 0.6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(CupertinoIcons.info_circle, color: gold, size: Dimensions.h_13),
                SizedBox(width: Dimensions.w_5),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: copy, fontSize: FontSize.sp_11, height: 1.2),
                      children: [
                        TextSpan(
                          text: seller?.callout ?? '',
                          style: const TextStyle(fontWeight: FontWeight.w700),
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

  Widget _sellerProfileStat({required IconData icon, required String text, required Color color, required Color copy}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h_5, left: Dimensions.w_8),
      child: Row(
        children: [
          Icon(icon, color: color, size: Dimensions.h_12),
          SizedBox(width: Dimensions.w_8),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: copy, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget aiSellingBrief(bool isLight) {
    final surface = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF0B2035);

    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);

    final copy = isLight ? const Color(0xFF344779) : const Color(0xFFC9D5E8);

    final muted = isLight ? const Color(0xFF63728F) : const Color(0xFFAAB8CF);

    final line = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);

    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);

    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);

    final red = isLight ? const Color(0xFFB4232D) : const Color(0xFFFF8E96);

    final redSoft = isLight ? const Color(0xFFFFF0F1) : const Color(0xFF48242B);

    final orange = isLight ? const Color(0xFFA14F00) : const Color(0xFFFFC36C);

    final orangeSoft = isLight ? const Color(0xFFFFF3E4) : const Color(0xFF49371F);

    final green = isLight ? const Color(0xFF087C4B) : const Color(0xFF64D9A2);

    final greenSoft = isLight ? const Color(0xFFE8F7EF) : const Color(0xFF123D36);

    final listingReview = garageController.dashboardData?.sections?.valueOverview?.listingReview;

    final metrics = listingReview?.metrics ?? [];

    final active = metrics.firstWhere((item) => item.key == 'active', orElse: () => Metric());

    final draft = metrics.firstWhere((item) => item.key == 'draft', orElse: () => Metric());

    final expired = metrics.firstWhere((item) => item.key == 'expired', orElse: () => Metric());

    final review = metrics.firstWhere((item) => item.key == 'review', orElse: () => Metric());

    final briefItems = [
      {
        'title': active.label ?? 'Active listings',
        'subtitle': 'Currently listed',
        'items': ['${active.value ?? 0} active listings', 'Review your current listings'],
        'count': '${active.value ?? 0}',
        'icon': CupertinoIcons.flame,
        'color': red,
        'soft': redSoft,
      },
      {
        'title': draft.label ?? 'Saved drafts',
        'subtitle': 'Waiting to be completed',
        'items': ['${draft.value ?? 0} saved drafts', 'Complete your pending listings'],
        'count': '${draft.value ?? 0}',
        'icon': CupertinoIcons.thermometer_snowflake,
        'color': blue,
        'soft': blueSoft,
      },
      {
        'title': expired.label ?? 'Inactive listings',
        'subtitle': 'Needs your attention',
        'items': ['${expired.value ?? 0} inactive listings', 'Review inactive inventory'],
        'count': '${expired.value ?? 0}',
        'icon': CupertinoIcons.tag,
        'color': orange,
        'soft': orangeSoft,
      },
      {
        'title': review.label ?? 'Value to review',
        'subtitle': 'Active and draft value',
        'items': [formatCurrency(review.value ?? 0), 'Review your current value'],
        'count': formatCurrency(review.value ?? 0),
        'icon': CupertinoIcons.gift,
        'color': green,
        'soft': greenSoft,
      },
    ];

    return Column(
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
                borderRadius: BorderRadius.circular(Dimensions.h_6),
                border: Border.all(color: orange, width: 0.8),
              ),
              child: Icon(CupertinoIcons.sparkles, color: orange, size: Dimensions.h_15),
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
                          style: TextStyle(color: ink, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700),
                        ),
                      ),

                      SizedBox(width: Dimensions.w_4),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_1),
                        decoration: BoxDecoration(
                          color: blueSoft,
                          borderRadius: BorderRadius.circular(Dimensions.h_3),
                          border: Border.all(color: blue, width: 0.5),
                        ),
                        child: Text(
                          'ISSAQUAH',
                          style: TextStyle(color: blue, fontSize: FontSize.sp_8, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    listingReview?.description ?? 'Items that may need a quick check before buyers see them.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: copy, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            Text(
              listingReview?.action?.label ?? 'View Full Brief',
              style: TextStyle(color: blue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800),
            ),
            SizedBox(width: Dimensions.w_3),
            Icon(CupertinoIcons.arrow_right, color: blue, size: Dimensions.h_12),
          ],
        ),
        SizedBox(height: Dimensions.h_8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: briefItems.length,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_1),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_5, mainAxisSpacing: Dimensions.h_5, mainAxisExtent: Dimensions.h_150),
          itemBuilder: (context, index) {
            final item = briefItems[index];
            return _sellingBriefCard(title: item['title'] as String, subtitle: item['subtitle'] as String, items: item['items'] as List<String>, count: item['count'] as String, icon: item['icon'] as IconData, color: item['color'] as Color, softColor: item['soft'] as Color, surface: surface, ink: ink, copy: copy, muted: muted, line: line);
          },
        ),
      ],
    );
  }

  Widget _sellingBriefCard({required String title, required String subtitle, required List<String> items, required String count, required IconData icon, required Color color, required Color softColor, required Color surface, required Color ink, required Color copy, required Color muted, required Color line}) {
    return CommonCard(
      color: Theme.of(context).cardColor,
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
                  border: Border.all(color: color.withValues(alpha: 0.45), width: 0.5),
                ),
                child: Icon(icon, color: color, size: Dimensions.h_12),
              ),
              SizedBox(width: Dimensions.w_5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: ink, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5),
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
                        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                      ),
                      SizedBox(width: Dimensions.w_4),
                      Expanded(
                        child: Text(
                          item,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View Items ($count)',
                    style: TextStyle(color: color, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: Dimensions.w_3),
                  Icon(CupertinoIcons.arrow_right, color: color, size: Dimensions.h_12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cashInfo({required String value, required String title, required String subtitle, required String items, required Color ink, required Color copy, required Color muted}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: ink, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: Dimensions.h_4),
        Text(
          '$title $subtitle',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: copy, fontSize: FontSize.sp_8, height: 1.15),
        ),
        SizedBox(height: Dimensions.h_1),
        Text(
          items,
          style: TextStyle(color: muted, fontSize: FontSize.sp_8),
        ),
      ],
    );
  }

  Widget _lossRow(String title, String value, Color red, Color copy, {String? suffix}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_1),
      child: Row(
        children: [
          Icon(CupertinoIcons.circle_fill, color: red, size: Dimensions.h_8),
          SizedBox(width: Dimensions.w_4),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: copy, fontSize: FontSize.sp_9),
                  ),
                ),
                if (suffix != null) ...[
                  SizedBox(width: Dimensions.w_2),
                  Text(
                    suffix,
                    style: TextStyle(color: copy, fontSize: FontSize.sp_9),
                  ),
                ],
              ],
            ),
          ),

          SizedBox(width: Dimensions.w_2),

          Text(
            value,
            style: TextStyle(color: red, fontSize: FontSize.sp_9, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget buildHeroHeader(bool isLight, GarageController controller) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedWeatherImage(height: Dimensions.h_330, image: "https://staging.wikixm.com/web/assets/images/garage/my-garage/garage-v1-hero.webp"),
        Positioned.fill(
          child: Container(
            height: Dimensions.h_330,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [const Color(0xFF020B15).withValues(alpha: 0.85), const Color(0xFF020B15).withValues(alpha: 0.65), const Color(0xFF020B15).withValues(alpha: 0.45), Colors.transparent], stops: const [0.0, 0.30, 0.58, 1.0]),
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
                  'WELCOME BACK ${garageController.dashboardData?.sections?.sellerProfile?.name?.trim().split(' ').first.toUpperCase() ?? ''}',
                  style: TextStyle(color: const Color(0xFFFFE47A), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_8, bottom: Dimensions.h_5),
                child: Text(
                  "My Garage".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_22,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, right: Dimensions.w_50),
                child: Text(
                  'A cleaner home is a freer tomorrow.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_13_5,
                    fontWeight: FontWeight.w500,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
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

  Widget communityStatsSection() {
    final counts = garageController.dashboardData?.counts;

    final stats = [
      {'icon': CupertinoIcons.cube_box, 'value': '${counts?.totalItems ?? 0}', 'label': 'Items Tracked'},
      {'icon': CupertinoIcons.tag, 'value': '${counts?.activeCount ?? 0}', 'label': 'Active Listings'},
      {'icon': CupertinoIcons.money_dollar_circle, 'value': formatCurrency(counts?.activeValue ?? 0), 'label': 'Active Value'},
      {'icon': CupertinoIcons.clock, 'value': '${counts?.soldCount ?? 0}', 'label': 'Successful Sales'},
      {'icon': CupertinoIcons.star, 'value': formatCurrency(counts?.lifetimeEarned ?? 0), 'label': 'Lifetime Earned'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_10),
      child: Column(
        children: List.generate((stats.length / 2).ceil(), (rowIndex) {
          final firstIndex = rowIndex * 2;
          final secondIndex = firstIndex + 1;

          final firstStat = stats[firstIndex];
          final secondStat = secondIndex < stats.length ? stats[secondIndex] : null;

          return Padding(
            padding: EdgeInsets.only(bottom: rowIndex != (stats.length / 2).ceil() - 1 ? Dimensions.h_12 : 0),
            child: Row(
              children: [
                Expanded(
                  child: _communityStatItem(icon: firstStat['icon'] as IconData, value: firstStat['value'] as String, label: firstStat['label'] as String),
                ),
                Expanded(
                  child: secondStat != null ? _communityStatItem(icon: secondStat['icon'] as IconData, value: secondStat['value'] as String, label: secondStat['label'] as String) : const SizedBox(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  String formatCurrency(dynamic value) {
    final amount = num.tryParse(value.toString()) ?? 0;
    if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    }
    if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(1)}K';
    }
    return '\$${amount.toStringAsFixed(0)}';
  }

  Widget _communityStatItem({required IconData icon, required String value, required String label}) {
    return Row(
      children: [
        Icon(icon, size: Dimensions.h_18, fontWeight: FontWeight.bold, color: const Color(0xFF8fd9ae)),
        SizedBox(width: Dimensions.w_8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(fontSize: FontSize.sp_15, fontWeight: FontWeight.w900, color: AppColor.white),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: FontSize.sp_11,
                  color: AppColor.white,
                  fontWeight: FontWeight.w700,
                  shadows: const [
                    Shadow(color: Colors.black, blurRadius: 30, offset: Offset(0, 2)),
                    Shadow(color: Colors.black, blurRadius: 30, offset: Offset(0, 0)),
                    Shadow(color: Colors.black, blurRadius: 30, offset: Offset(0, 4)),
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
