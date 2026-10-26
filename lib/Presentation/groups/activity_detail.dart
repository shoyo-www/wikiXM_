import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/fontsize.dart';
import '../widgets/cache_image.dart';

class ActivityDetail extends StatefulWidget {
  const ActivityDetail({super.key});

  @override
  State<ActivityDetail> createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  final List<String> tabs = ['OVERVIEW', 'DISCUSSION', 'PARTICIPANTS (6)', 'ROUTE & MAP'];
  int selectedIndex = 0;
  final List<Map<String, dynamic>> rideMetrics = [
    {'title': 'YOUR CREW', 'icon': CupertinoIcons.person_2, 'value': '6 going', 'subtitle': '2 places left'},
    {'title': 'SKILL LEVEL', 'icon': Icons.bar_chart, 'value': 'Intermediate–Advanced', 'subtitle': 'Technical riding'},
    {'title': 'TERRAIN', 'icon': Icons.landscape_outlined, 'value': 'Singletrack', 'subtitle': 'Roots, climbs & views'},
    {'title': 'PACE', 'icon': CupertinoIcons.speedometer, 'value': 'Moderate / Fast', 'subtitle': 'Regroup together'},
  ];
  final List<Map<String, dynamic>> mockRiders = [
    {
      'id': 'mike',
      'name': 'Mike R.',
      'image': 'rider-mike.webp',
      'distance': 2,
      'skill': 'Advanced',
      'styles': 'Trail · Enduro',
      'match': 'Strong Match',
      'rides': 25,
      'mutual': 3,
      'tags': ['Reliable', 'Welcoming', 'Good communicator'],
      'availability': 'Available this weekend',
      'bio': 'Looking for riding buddies for longer trail rides, technical terrain and big climbs.',
      'saved': false,
    },
    {
      'id': 'emily',
      'name': 'Emily K.',
      'image': 'rider-emily.webp',
      'distance': 4,
      'skill': 'Advanced',
      'styles': 'Trail · XC',
      'match': 'Strong Match',
      'rides': 18,
      'mutual': 2,
      'tags': ['Skilled', 'Friendly', 'Women’s rides'],
      'availability': 'Available this weekend',
      'bio': 'Enjoys flowing trails, steady climbs and exploring new places.',
      'saved': false,
    },
    {
      'id': 'david',
      'name': 'David L.',
      'image': 'rider-david.webp',
      'distance': 6,
      'skill': 'Advanced',
      'styles': 'Enduro · Trail',
      'match': 'Good Match',
      'rides': 32,
      'mutual': 4,
      'tags': ['Reliable', 'Knowledgeable', 'Fast pace'],
      'availability': 'Available next week',
      'bio': 'Enjoys technical trails, big climbs and routes around 15–25 miles.',
      'saved': false,
    },
    {
      'id': 'jennifer',
      'name': 'Jennifer S.',
      'image': 'rider-jennifer.webp',
      'distance': 8,
      'skill': 'Intermediate',
      'styles': 'Trail · All-mountain',
      'match': 'Good Match',
      'rides': 12,
      'mutual': 1,
      'tags': ['Friendly', 'Encouraging', 'Women’s rides'],
      'availability': 'Available this weekend',
      'bio': 'Looking for intermediate trails, a social pace and scenic rides.',
      'saved': false,
    },
    {
      'id': 'alex',
      'name': 'Alex T.',
      'image': 'rider-alex.webp',
      'distance': 10,
      'skill': 'Advanced',
      'styles': 'Trail · Enduro',
      'match': 'Good Match',
      'rides': 20,
      'mutual': 2,
      'tags': ['Technical', 'Big climbs', 'Adventure'],
      'availability': 'Flexible availability',
      'bio': 'Loves exploring new trails and joining group rides.',
      'saved': false,
    },
    {
      'id': 'rachel',
      'name': 'Rachel M.',
      'image': 'rider-rachel.webp',
      'distance': 12,
      'skill': 'Intermediate',
      'styles': 'Trail',
      'match': 'Possible Match',
      'rides': 8,
      'mutual': 2,
      'tags': ['Beginner friendly', 'Social', 'Learning'],
      'availability': 'Available this weekend',
      'bio': 'Building trail skills and looking for a welcoming riding group.',
      'saved': false,
    },
  ];
  final List<Map<String, dynamic>> rideDetails = [
    {'title': 'When', 'icon': CupertinoIcons.calendar, 'value': 'Sat, Oct 17, 2026', 'subtitle': '8–11:30 AM local'},
    {'title': 'Meeting point', 'icon': CupertinoIcons.location, 'value': 'Pine Valley Trailhead', 'subtitle': 'Arrive at 7:45 AM'},
    {'title': 'Distance', 'icon': Icons.directions_bike, 'value': '18 miles', 'subtitle': 'Loop route'},
    {'title': 'Elevation gain', 'icon': Icons.landscape_outlined, 'value': '2,400 feet', 'subtitle': 'Climbs & descents'},
    {'title': 'Skill level', 'icon': CupertinoIcons.chart_bar, 'value': 'Intermediate–Advanced', 'subtitle': 'Technical experience'},
    {'title': 'Group size', 'icon': CupertinoIcons.person_2, 'value': '2–8 riders', 'subtitle': 'Small, friendly crew'},
  ];
  final List<Map<String, dynamic>> quickActions = [
    {'title': 'Join ride', 'icon': CupertinoIcons.add, 'type': 'join', 'color': 'primary'},
    {'title': 'I’m interested', 'icon': CupertinoIcons.star, 'type': 'interest', 'color': 'soft'},
    {'title': 'Invite a friend', 'icon': CupertinoIcons.person_2, 'type': 'invite', 'color': 'outline'},
    {'title': 'Message organizer', 'icon': CupertinoIcons.mail, 'type': 'organizer', 'color': 'outline'},
  ];
  double mapScale = 1.0;
  void zoomMap(double scale) {
    setState(() {
      mapScale = scale.clamp(1.0, 3.0);
    });
  }
  void resetMap() {
    setState(() {
      mapScale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: selectedIndex == 1
          ? Padding(
              padding: EdgeInsets.only(left: Dimensions.w_15, bottom: Dimensions.h_20, right: Dimensions.w_15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/home/user-home1/profile-sean.jpg', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true, color: Theme.of(context).highlightColor),
                  SizedBox(width: Dimensions.w_8),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_10),
                      height: Dimensions.h_33,
                      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(99)),
                      child: Text(
                        "Whats's on your mind, Sean ?",
                        style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: Theme.of(context).hintColor, height: 1.1),
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_5),
                  Container(
                    height: Dimensions.h_30,
                    width: Dimensions.h_30,
                    decoration: BoxDecoration(color: AppColor.blue(context), shape: BoxShape.circle),
                    child: Icon(CupertinoIcons.location_fill, size: Dimensions.h_13, color: Colors.white),
                  ),
                ],
              ),
            )
          : SizedBox.shrink(),
      body: CommonScrollBlurScaffold(
        showBack: true,
        expandedHeight: Dimensions.h_240,
        expandedColor: Colors.white,
        collapsedColor: Theme.of(context).highlightColor,
        hero: buildHeroHeader(isLight),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h_5),
                  Container(
                    height: Dimensions.h_25,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColor.micrositeGrey(context), width: isLight ? 0.6 : 0.6),
                      ),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tabs.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (c, index) {
                        final isSelected = selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: Dimensions.w_8),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                            decoration: BoxDecoration(
                              border: isSelected ? Border(bottom: BorderSide(color: AppColor.blue(context), width: 3)) : Border(bottom: BorderSide(color: Colors.transparent, width: 3)),
                            ),
                            child: Text(
                              tabs[index],
                              style: TextStyle(color: isSelected ? AppColor.blue(context) : Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700, height: 1),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: Dimensions.h_10),
                  selectedIndex == 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ride overview',
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_4, top: Dimensions.h_2),
                              child: Text(
                                'Join your Pine Valley crew for a scenic Saturday loop: forest singletrack, steady climbs, and a well-earned ridge view.',
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_4, top: Dimensions.h_8),
                              child: Text(
                                'Your kind of technical trail, Sean. We’ll regroup along the way.',
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: rideMetrics.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_8, mainAxisSpacing: Dimensions.h_8, mainAxisExtent: Dimensions.h_80),
                              itemBuilder: (context, index) {
                                final metric = rideMetrics[index];
                                return CommonCard(
                                  margin: EdgeInsets.zero,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(metric['icon'] as IconData, size: Dimensions.h_13, color: AppColor.blue(context)),
                                          SizedBox(width: Dimensions.w_3),
                                          Expanded(
                                            child: Text(
                                              metric['title'] as String,
                                              style: TextStyle(fontSize: FontSize.sp_9_5, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.h_10),
                                      Text(
                                        metric['value'] as String,
                                        style: TextStyle(fontSize: FontSize.sp_13, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                                      ),
                                      Text(
                                        metric['subtitle'] as String,
                                        style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: Dimensions.h_20),
                            Text(
                              'Ride details',
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            CommonCard(
                              child: Column(
                                children: [
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_5),
                                    itemCount: rideDetails.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_8, mainAxisSpacing: Dimensions.h_8, mainAxisExtent: Dimensions.h_60),
                                    itemBuilder: (context, index) {
                                      final detail = rideDetails[index];
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(detail['icon'] as IconData, size: Dimensions.h_13, color: AppColor.blue(context)),
                                              SizedBox(width: Dimensions.w_6),
                                              Expanded(
                                                child: Text(
                                                  detail['title'] as String,
                                                  style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: Dimensions.h_4),
                                          Text(
                                            detail['value'] as String,
                                            style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                                          ),
                                          SizedBox(height: Dimensions.h_3),
                                          Text(
                                            detail['subtitle'] as String,
                                            style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w400, color: Theme.of(context).hintColor),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.h_10),
                                    height: 0.2,
                                    width: Get.width,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                  Row(
                                    children: [
                                      Icon(CupertinoIcons.check_mark_circled, size: Dimensions.h_13, color: AppColor.green(context)),
                                      SizedBox(width: Dimensions.w_6),
                                      Expanded(
                                        child: Text(
                                          'Helmet, water, and a trail-ready bike.',
                                          style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.h_20),
                            Row(
                              children: [
                                Text(
                                  'The ride conversation',
                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                                ),
                                const Spacer(),
                                Text(
                                  'Join Conversation',
                                  style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, color: AppColor.blue(context)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_6, top: Dimensions.h_2),
                              child: Text(
                                'Ask a question, share a tip, or say hello to your crew, Sean.',
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.1),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            CommonCard(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/participant-sarah.webp', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true, color: Theme.of(context).highlightColor),
                                      SizedBox(width: Dimensions.w_8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Sarah M.',
                                                  style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                                                ),
                                                SizedBox(width: Dimensions.w_8),
                                                Text(
                                                  'Organizer',
                                                  style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w700, color: AppColor.blue(context)),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  'Today · 9:15 AM',
                                                  style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Dimensions.h_3),
                                            Text(
                                              'Looking forward to a great ride. The lower loop looks good, and we’ll regroup at the ridge viewpoint.',
                                              style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.h_10, top: Dimensions.h_10, left: Dimensions.w_40),
                                    height: 0.2,
                                    width: Get.width,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/participant-sarah.webp', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true, color: Theme.of(context).highlightColor),
                                      SizedBox(width: Dimensions.w_8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Sarah M.',
                                                  style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  'Today · 9:15 AM',
                                                  style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Dimensions.h_3),
                                            Text(
                                              'Looking forward to a great ride. The lower loop looks good, and we’ll regroup at the ridge viewpoint.',
                                              style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.h_10, top: Dimensions.h_10, left: Dimensions.w_40),
                                    height: 0.2,
                                    width: Get.width,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/participant-sarah.webp', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true, color: Theme.of(context).highlightColor),
                                      SizedBox(width: Dimensions.w_8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Sarah M.',
                                                  style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  'Today · 9:15 AM',
                                                  style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Dimensions.h_3),
                                            Text(
                                              'Looking forward to a great ride. The lower loop looks good, and we’ll regroup at the ridge viewpoint.',
                                              style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.h_20),
                            Text(
                              'Make it your next ride.',
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: Dimensions.w_8, right: Dimensions.w_8),
                              itemCount: quickActions.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, mainAxisExtent: Dimensions.h_35),
                              itemBuilder: (context, index) {
                                final action = quickActions[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.h_8),
                                    color: action['color'] == 'primary'
                                        ? AppColor.blue(context)
                                        : action['color'] == 'soft'
                                        ? AppColor.blueSoft(context)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: action['color'] == 'primary'
                                          ? Colors.transparent
                                          : action['color'] == 'soft'
                                          ? AppColor.blue(context)
                                          : Theme.of(context).highlightColor,
                                      width: 0.2,
                                    ),
                                  ),
                                  margin: EdgeInsets.zero,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          action['icon'] as IconData,
                                          size: Dimensions.h_15,
                                          color: action['color'] == 'primary'
                                              ? Colors.white
                                              : action['color'] == 'soft'
                                              ? AppColor.blue(context)
                                              : Theme.of(context).highlightColor,
                                        ),
                                        SizedBox(width: Dimensions.w_8),
                                        Text(
                                          action['title'] as String,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: FontSize.sp_11,
                                            fontWeight: FontWeight.w700,
                                            color: action['color'] == 'primary'
                                                ? Colors.white
                                                : action['color'] == 'soft'
                                                ? AppColor.blue(context)
                                                : Theme.of(context).highlightColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: Dimensions.h_20),
                            CommonCard(
                              margin: EdgeInsets.zero,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Your riding crew',
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'See All',
                                              style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                                            ),
                                            Icon(CupertinoIcons.arrow_right, color: Theme.of(context).primaryColorDark, size: Dimensions.h_12),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_5),
                                  Padding(
                                    padding: EdgeInsets.only(left: Dimensions.w_6),
                                    child: Text(
                                      '6 going. There’s room for you.',
                                      style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.h_15),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: Dimensions.w_15),
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/participant-sarah.webp', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true),
                                      SizedBox(width: Dimensions.w_8),
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/participant-sarah.webp', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true),
                                      SizedBox(width: Dimensions.w_8),
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/participant-sarah.webp', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true),
                                      SizedBox(width: Dimensions.w_8),
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/participant-sarah.webp', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true),
                                      SizedBox(width: Dimensions.w_8),
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/participant-sarah.webp', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true),
                                      SizedBox(width: Dimensions.w_8),
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/participant-sarah.webp', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.h_10, top: Dimensions.h_10),
                                    height: 0.2,
                                    width: Get.width,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: Dimensions.w_15),
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/participant-sarah.webp', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true, color: Theme.of(context).highlightColor),
                                      SizedBox(width: Dimensions.w_8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Sarah M.',
                                              style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                                            ),
                                            SizedBox(height: Dimensions.h_3),
                                            Text(
                                              'Your organizer · Knows the local trails',
                                              style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.1),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(CupertinoIcons.chat_bubble_text, size: Dimensions.h_16, color: AppColor.blue(context)),
                                      SizedBox(width: Dimensions.w_8),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : selectedIndex == 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'The ride conversation',
                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                                ),
                                const Spacer(),
                                Text(
                                  '3 comments',
                                  style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_6, top: Dimensions.h_2),
                              child: Text(
                                'Ask a question, share a tip, or say hello to your crew, Sean.',
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.1),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_20),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: 3,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                                itemBuilder: (c,i) {
                                  return Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/participant-sarah.webp', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true, color: Theme.of(context).highlightColor),
                                          SizedBox(width: Dimensions.w_8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Sarah M.',
                                                      style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                                                    ),
                                                    SizedBox(width: Dimensions.w_8),
                                                    const Spacer(),
                                                    Text(
                                                      'Today · 9:15 AM',
                                                      style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: Dimensions.h_3),
                                                Text(
                                                  'Looking forward to a great ride. The lower loop looks good, and we’ll regroup at the ridge viewpoint.',
                                                  style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.1),
                                                ),
                                                SizedBox(height: Dimensions.h_10),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(CupertinoIcons.hand_thumbsup_fill,size: Dimensions.h_11,color: Theme.of(context).highlightColor),
                                                    SizedBox(width: Dimensions.w_5),
                                                    Text(
                                                      '12 Likes',
                                                      style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                                    ),                                          SizedBox(width: Dimensions.w_15),

                                                    Icon(CupertinoIcons.chat_bubble_text,size: Dimensions.h_11,color: Theme.of(context).highlightColor),
                                                    SizedBox(width: Dimensions.w_5),
                                                    Text(
                                                      '12 Comments',
                                                      style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                                    ),
                                                  ],),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if(i != 2)
                                        Container(
                                          margin: EdgeInsets.only(bottom: Dimensions.h_10, top: Dimensions.h_10, left: Dimensions.w_40),
                                          height: 0.2,
                                          width: Get.width,
                                          color: Theme.of(context).highlightColor,
                                        ),
                                    ],
                                  );})
                          ],
                        )
                      : selectedIndex == 2
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Your riding crew',
                            //   style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                            // ),
                            // SizedBox(height: Dimensions.h_10),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: mockRiders.length,
                              itemBuilder: (c, i) {
                                final rider = mockRiders[i];
                                return CommonCard(
                                  margin: EdgeInsets.only(bottom: Dimensions.h_10),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking3/${rider['image']}', size: Dimensions.h_90, widthSize: Dimensions.h_80, isShadow: false, radius: Dimensions.h_6),
                                          SizedBox(width: Dimensions.w_8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      rider['name'],
                                                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
                                                    ),
                                                    Icon(Icons.verified_sharp, color: AppColor.blue(context), size: Dimensions.h_12),
                                                  ],
                                                ),
                                                SizedBox(height: Dimensions.h_5),
                                                Row(
                                                  children: [
                                                    SizedBox(width: Dimensions.w_2),
                                                    Icon(Icons.location_on_sharp, color: Theme.of(context).hintColor, size: Dimensions.h_11),
                                                    SizedBox(width: Dimensions.w_4),
                                                    Text(
                                                      'Pine Valley · ${rider['distance']} miles away',
                                                      style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: Dimensions.h_3),
                                                Row(
                                                  children: [
                                                    SizedBox(width: Dimensions.w_2),
                                                    Icon(Icons.pedal_bike_rounded, color: Theme.of(context).hintColor, size: Dimensions.h_11),
                                                    SizedBox(width: Dimensions.w_4),
                                                    Text(
                                                      "${rider['skill']} and ${rider['styles']}",
                                                      style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: Dimensions.h_3),
                                                Row(
                                                  children: [
                                                    SizedBox(width: Dimensions.w_2),
                                                    Icon(Icons.pedal_bike_rounded, color: Theme.of(context).hintColor, size: Dimensions.h_11),
                                                    SizedBox(width: Dimensions.w_4),
                                                    Text(
                                                      "${rider['rides'].toString()} Community rides",
                                                      style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: Dimensions.h_8),
                                                Wrap(
                                                  spacing: Dimensions.w_4,
                                                  runSpacing: Dimensions.h_4,
                                                  children: (rider['tags'] as List<String>).map((tag) {
                                                    return Container(
                                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_3),
                                                      decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                                                      child: Text(
                                                        tag,
                                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(Icons.favorite_border, color: AppColor.blue(context), size: Dimensions.h_18),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.h_10),
                                      IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
                                                  decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_8)),
                                                  child: Center(
                                                    child: Text(
                                                      "View Profile",
                                                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.2),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.w_10),
                                            Expanded(
                                              child: GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
                                                  decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(Dimensions.h_8)),
                                                  child: Center(
                                                    child: Text(
                                                      "Connect",
                                                      style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Trail Route',
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            CommonCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Dimensions.h_230,
                                    width: Get.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.h_10),
                                      child: Stack(
                                        children: [
                                          Transform.scale(
                                            scale: mapScale,
                                            child: SizedBox.expand(
                                              child: AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/tiger-loop-map.svg', fit: BoxFit.cover),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: Dimensions.h_12,
                                            right: Dimensions.w_12,
                                            child: Column(
                                              children: [
                                                mapControl(context, CupertinoIcons.plus, () {}),
                                                SizedBox(height: Dimensions.h_4),
                                                mapControl(context, CupertinoIcons.minus, () {}),
                                                SizedBox(height: Dimensions.h_4),
                                                mapControl(context, CupertinoIcons.fullscreen, () {}),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.h_10),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: Dimensions.w_8, right: Dimensions.w_6),
                                        height: Dimensions.h_2,
                                        width: Dimensions.w_20,
                                        color: AppColor.blue(context),
                                      ),
                                      Text(
                                        'Ride loop',
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(width: Dimensions.w_15),
                                      Icon(Icons.location_on_sharp, size: Dimensions.h_12, color: AppColor.green(context)),
                                      SizedBox(width: Dimensions.w_5),
                                      Text(
                                        'Start & finish',
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_8),
                                  Padding(
                                    padding: EdgeInsets.only(left: Dimensions.w_8),
                                    child: Text(
                                      'Meet at Pine Valley Trailhead. Regroup at Tiger Ridge.',
                                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                  SizedBox(height: Dimensions.h_30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mapControl(BuildContext context, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Dimensions.h_28,
        width: Dimensions.h_28,
        decoration: BoxDecoration(
          color: AppColor.activityDetailWhiteTranslucent(context),
          borderRadius: BorderRadius.circular(Dimensions.h_6),
          border: Border.all(color: AppColor.activityDetailBlueSoft(context)),
        ),
        child: Icon(icon, size: Dimensions.h_13, color: Theme.of(context).highlightColor),
      ),
    );
  }

  Widget buildHeroHeader(bool isLight) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCacheImage(alignment: Alignment(0.5, 0), size: Dimensions.h_330, widthSize: Get.width, imageUrl: "https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/hero.webp"),
        Positioned.fill(
          child: Container(
            height: Dimensions.h_330,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [const Color(0xFF020B15).withValues(alpha: 0.85), const Color(0xFF020B15).withValues(alpha: 0.65), const Color(0xFF020B15).withValues(alpha: 0.35), Colors.transparent], stops: const [0.10, 0.50, 0.68, 1.0]),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.h_330,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_70),
                child: Text(
                  'YOUR NEXT TRAIL DAY, SEAN',
                  style: TextStyle(color: const Color(0xFFFFE47A), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_4),
                child: Text(
                  "Tiger Mountain Loop",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_22,
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_10),
                child: Text(
                  "A good climb. A great view. Even better company.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_10, right: Dimensions.w_60),
                child: Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today_outlined, size: Dimensions.h_12, color: Colors.white),
                        SizedBox(width: Dimensions.w_5),
                        Text(
                          "Sat, Oct 17 · 8:00 AM",
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, height: 1.2),
                        ),
                      ],
                    ),
                    SizedBox(width: Dimensions.w_20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on_sharp, size: Dimensions.h_12, color: Colors.white),
                        SizedBox(width: Dimensions.w_3),
                        Text(
                          "Pine Valley Trails",
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, height: 1.2),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_8, right: Dimensions.w_60),
                child: Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.pedal_bike, size: Dimensions.h_12, color: Colors.white),
                        SizedBox(width: Dimensions.w_5),
                        Text(
                          "18 Miles",
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, height: 1.2),
                        ),
                      ],
                    ),
                    SizedBox(width: Dimensions.w_20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.landscape_outlined, size: Dimensions.h_12, color: Colors.white),
                        SizedBox(width: Dimensions.w_3),
                        Text(
                          "2400 ft",
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, height: 1.2),
                        ),
                      ],
                    ),
                    SizedBox(width: Dimensions.w_20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bar_chart, size: Dimensions.h_12, color: Colors.white),
                        SizedBox(width: Dimensions.w_3),
                        Text(
                          "Intermediate–Advanced",
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, height: 1.2),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_15),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_4),
                    decoration: BoxDecoration(
                      border: Border.all(color: isLight ? AppColor.sportsLightBorder : Colors.white, width: 0.8),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.person_2, size: Dimensions.h_13, color: Colors.white),
                        SizedBox(width: Dimensions.w_5),
                        Text(
                          "6 going · 2 places left",
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800, height: 1.2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
                          decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(Dimensions.h_8)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(CupertinoIcons.plus_circle_fill, size: Dimensions.h_15, color: Colors.white),
                              SizedBox(width: Dimensions.w_8),
                              Text(
                                "Join Ride",
                                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_5),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_1, vertical: Dimensions.h_8),
                          decoration: BoxDecoration(
                            color: AppColor.groupDetailWhite(context),
                            border: Border.all(color: isLight ? AppColor.sportsLightBorder : Colors.white, width: 0.5),
                            borderRadius: BorderRadius.circular(Dimensions.h_8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(CupertinoIcons.star_fill, size: Dimensions.h_13, color: Theme.of(context).highlightColor),
                              SizedBox(width: Dimensions.w_5),
                              Text(
                                "i'm Interested",
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1.2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_10),
                  ],
                ),
              ),
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
}
