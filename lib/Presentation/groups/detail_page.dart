import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/activity_meta.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../approutes.dart';
import '../../constants/fontsize.dart';
import '../widgets/cache_image.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<String> tabs = ['OVERVIEW', 'DISCUSSION', 'RIDES & EVENTS', 'MEMBERS', 'PHOTOS'];

  int selectedIndex = 0;

  final List<Map<String, dynamic>> rideMetrics = [
    {'title': 'All skill levels', 'icon': Icons.hiking, 'value': '6 going', 'subtitle': '2 places left'},
    {'title': 'Group rides', 'icon': CupertinoIcons.person_2, 'value': 'Intermediate–Advanced', 'subtitle': 'Technical riding'},
    {'title': 'Trail care', 'icon': Icons.landscape_outlined, 'value': 'Singletrack', 'subtitle': 'Roots, climbs & views'},
    {'title': 'Gear talk', 'icon': CupertinoIcons.settings, 'value': 'Moderate / Fast', 'subtitle': 'Regroup together'},
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

  final List<Map<String, dynamic>> quickActions = [
    {'title': 'Plan Ride', 'icon': Icons.calendar_today_outlined, 'type': 'join', 'color': 'outline'},
    {'title': 'Invite a friend', 'icon': CupertinoIcons.person_2, 'type': 'interest', 'color': 'outline'},
    {'title': 'Share your group', 'icon': CupertinoIcons.share, 'type': 'invite', 'color': 'outline'},
    {'title': 'Your preference', 'icon': CupertinoIcons.settings, 'type': 'organizer', 'color': 'outline'},
  ];

  final List<String> imageList = [
    'https://preetis-html.vercel.app/assets/images/groups/mountain-biking/hero.webp',
    'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/hero.webp',
    'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/tire-detail.webp',
    'https://preetis-html.vercel.app/assets/images/groups/mountain-biking/ride-ridge.webp',
    'https://preetis-html.vercel.app/assets/images/groups/mountain-biking2/hero.webp'
  ];

  final List<Map<String, dynamic>> staticActivities = [
    {
      'id': 'saturday',
      'title': 'Saturday Mountain Ride',
      'image': 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/saturday-ride.webp',
      'badge': 'OCT 17',
      'badgeColor': const Color(0xFF16A34A),
      'date': 'Sat, Oct 17 · 8:00 AM',
      'trail': 'Tiger Mountain',
      'distance': '18 miles',
      'skill': 'Intermediate',
      'goingCount': 18,
      'spotsAvailable': 6,
      'isJoined': false,
      'buttonLabel': 'Join ride',
      'attendees': [
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-sara.webp',
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-mike.webp',
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-jennifer.webp',
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-david.webp',
      ],
    },
    {
      'id': 'womens',
      'title': 'Women’s Trail Ride',
      'image': 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/womens-ride.webp',
      'badge': 'OCT 20',
      'badgeColor': const Color(0xFF9333EA),
      'date': 'Tue, Oct 20 · 9:00 AM',
      'trail': 'River Park Trails',
      'distance': '12 miles',
      'skill': 'Intermediate',
      'goingCount': 8,
      'spotsAvailable': 4,
      'isJoined': false,
      'buttonLabel': 'Join ride',
      'attendees': [
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-sara.webp',
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-mike.webp',
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-jennifer.webp',
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-david.webp',
      ],
    },
    {
      'id': 'cleanup',
      'title': 'Trail Work Day',
      'image': 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/trail-work.webp',
      'badge': 'OCT 25',
      'badgeColor': const Color(0xFFEA580C),
      'date': 'Sun, Oct 25 · 7:30 AM',
      'trail': 'Community Park',
      'distance': 'Trail care',
      'skill': 'All levels',
      'goingCount': 14,
      'spotsAvailable': 10,
      'isJoined': false,
      'buttonLabel': 'I’m interested',
      'attendees': [
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-sara.webp',
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-mike.webp',
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-jennifer.webp',
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-david.webp',
      ],
    },
    {
      'id': 'womens',
      'title': 'Women’s Trail Ride',
      'image': 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/womens-ride.webp',
      'badge': 'OCT 20',
      'badgeColor': const Color(0xFF9333EA),
      'date': 'Tue, Oct 20 · 9:00 AM',
      'trail': 'River Park Trails',
      'distance': '12 miles',
      'skill': 'Intermediate',
      'goingCount': 8,
      'spotsAvailable': 4,
      'isJoined': false,
      'buttonLabel': 'Join ride',
      'attendees': [
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-sara.webp',
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-mike.webp',
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-jennifer.webp',
        'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-david.webp',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CommonScrollBlurScaffold(
        showBack: true,
        expandedHeight: Dimensions.h_200,
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
                        bottom: BorderSide(color: AppColor.micrositeGrey(context), width: isLight ? 0.6 : 0.6))),
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
                              'About this group',
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_4, top: Dimensions.h_2),
                              child: Text(
                                'A little about your new riding circle, Sean.',
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_4, top: Dimensions.h_8),
                              child: Text(
                                'A welcoming Pine Valley community for every riding level. Find riding buddies, share trail knowledge and gear advice, and help care for the trails we love.',
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: Dimensions.w_12),
                              itemCount: rideMetrics.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_8, mainAxisSpacing: Dimensions.h_8, mainAxisExtent: Dimensions.h_30),
                              itemBuilder: (context, index) {
                                final metric = rideMetrics[index];
                                return Row(
                                  children: [
                                    Container(
                                      height: Dimensions.h_25,
                                      width: Dimensions.h_25,
                                      decoration: BoxDecoration(color: AppColor.blueSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                                      child: Icon(metric['icon'] as IconData, size: Dimensions.h_13, color: AppColor.blue(context)),
                                    ),
                                    SizedBox(width: Dimensions.w_8),
                                    Expanded(
                                      child: Text(
                                        metric['title'] as String,
                                        style: TextStyle(fontSize: FontSize.sp_12, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: Dimensions.h_20),
                            Row(
                              children: [
                                Text(
                                  'Your next trail days',
                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_4),
                                  decoration: BoxDecoration(color: AppColor.blue(context), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                                  child: Text(
                                    '+ Plan ride',
                                    style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: isLight ? AppColor.white : AppColor.black),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_10),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: staticActivities.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, mainAxisExtent: Dimensions.h_270),
                              itemBuilder: (context, index) {
                                final activity = staticActivities[index];
                                final attendees = activity['attendees'] as List<String>;

                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Get.toNamed(AppRoutes.activityDetail);
                                  },
                                  child: CommonCard(
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_10), topRight: Radius.circular(Dimensions.h_10)),
                                              child: AppCacheImage(imageUrl: activity['image'] as String, size: Dimensions.h_120, widthSize: Get.width, fit: BoxFit.cover, radius: 0),
                                            ),
                                            Positioned(
                                              top: Dimensions.h_6,
                                              left: Dimensions.w_8,
                                              child: Container(
                                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_2),
                                                child: Text(
                                                  activity['badge'] as String,
                                                  style: TextStyle(color: AppColor.black, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Dimensions.h_8),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  activity['title'] as String,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor, height: 1),
                                                ),
                                                SizedBox(height: Dimensions.h_10),
                                                ActivityMeta(icon: CupertinoIcons.clock, text: activity['date'] as String),
                                                SizedBox(height: Dimensions.h_5),
                                                ActivityMeta(icon: CupertinoIcons.location_solid, text: activity['trail'] as String),
                                                SizedBox(height: Dimensions.h_5),
                                                ActivityMeta(icon: Icons.directions_bike, text: '${activity['distance']} · ${activity['skill']}'),
                                                SizedBox(height: Dimensions.h_10),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: Dimensions.w_50,
                                                      height: Dimensions.h_20,
                                                      child: Stack(
                                                        children: attendees
                                                            .take(3)
                                                            .toList()
                                                            .asMap()
                                                            .entries
                                                            .map(
                                                              (entry) => Positioned(
                                                                left: entry.key * Dimensions.w_15,
                                                                child: Container(
                                                                  width: Dimensions.h_20,
                                                                  height: Dimensions.h_20,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 1.5),
                                                                  ),
                                                                  child: ClipOval(
                                                                    child: AppCacheImage(imageUrl: entry.value, fit: BoxFit.cover),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                    ),
                                                    SizedBox(width: Dimensions.w_6),
                                                    Expanded(
                                                      child: Text(
                                                        '${activity['goingCount']} going · '
                                                        '${activity['spotsAvailable']} spots left',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(fontSize: FontSize.sp_8_5, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: Dimensions.h_28,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        activity['isJoined'] = !(activity['isJoined'] as bool);
                                                      });
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      elevation: 0,
                                                      backgroundColor: activity['isJoined'] == true ? AppColor.green(context) : AppColor.blue(context),
                                                      foregroundColor: Colors.white,
                                                      padding: EdgeInsets.zero,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                                                    ),
                                                    child: Text(
                                                      activity['isJoined'] == true ? 'Leave Activity' : activity['buttonLabel'] as String,
                                                      style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: isLight ? Colors.white : AppColor.black),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: Dimensions.h_8),
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
                            SizedBox(height: Dimensions.h_20),
                            Row(
                              children: [
                                Text(
                                  'The conversation starts here',
                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_4),
                                  decoration: BoxDecoration(color: AppColor.blue(context), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                                  child: Text(
                                    '+ New Post',
                                    style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: isLight ? AppColor.white : AppColor.black),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_6, top: Dimensions.h_5),
                              child: Text(
                                'Trail updates, good advice, and stories worth sharing. What’s on your mind, Sean?',
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.1),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            CommonCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_4),
                                    decoration: BoxDecoration(color: AppColor.greenSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(CupertinoIcons.pin, size: Dimensions.h_10, color: AppColor.green(context)),
                                        SizedBox(width: Dimensions.w_5),
                                        Text(
                                          'Pinned by your organizer',
                                          style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, color: AppColor.green(context)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.h_10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                                SizedBox(width: Dimensions.w_8),

                                                Text(
                                                  'Today · 9:15 AM',
                                                  style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                                ),
                                                const Spacer(),
                                                Icon(CupertinoIcons.bookmark, size: Dimensions.h_16, color: Theme.of(context).highlightColor),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Trail conditions update',
                                              style: TextStyle(fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor, height: 1.1),
                                            ),
                                            SizedBox(height: Dimensions.h_5),
                                            Padding(
                                              padding: EdgeInsets.only(left: Dimensions.w_6),
                                              child: Text(
                                                'A heads-up for your next ride, Sean: the upper Tiger Mountain trail is resting after heavy rain. Take the lower loop, give the trail time to dry, and check in with the crew before heading out.',
                                                style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.3),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.w_10),
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/trail-closure.webp', size: Dimensions.h_75, widthSize: Dimensions.w_120),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: Dimensions.w_6),
                                      Icon(CupertinoIcons.hand_thumbsup_fill, size: Dimensions.h_11, color: Theme.of(context).highlightColor),
                                      SizedBox(width: Dimensions.w_5),
                                      Text(
                                        '12 Likes',
                                        style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                      ),
                                      SizedBox(width: Dimensions.w_15),
                                      Icon(CupertinoIcons.chat_bubble_text, size: Dimensions.h_11, color: Theme.of(context).highlightColor),
                                      SizedBox(width: Dimensions.w_5),
                                      Text(
                                        '12 Comments',
                                        style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            CommonCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                                  'Today · 9:15 AM',
                                                  style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                                ),
                                                const Spacer(),
                                                Icon(CupertinoIcons.bookmark, size: Dimensions.h_16, color: Theme.of(context).highlightColor),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Trail conditions update',
                                              style: TextStyle(fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor, height: 1.1),
                                            ),
                                            SizedBox(height: Dimensions.h_5),
                                            Padding(
                                              padding: EdgeInsets.only(left: Dimensions.w_6),
                                              child: Text(
                                                'A heads-up for your next ride, Sean: the upper Tiger Mountain trail is resting after heavy rain. Take the lower loop, give the trail time to dry, and check in with the crew before heading out.',
                                                style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.3),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.w_10),
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/trail-closure.webp', size: Dimensions.h_75, widthSize: Dimensions.w_120),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: Dimensions.w_6),
                                      Icon(CupertinoIcons.hand_thumbsup_fill, size: Dimensions.h_11, color: Theme.of(context).highlightColor),
                                      SizedBox(width: Dimensions.w_5),
                                      Text(
                                        '12 Likes',
                                        style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                      ),
                                      SizedBox(width: Dimensions.w_15),
                                      Icon(CupertinoIcons.chat_bubble_text, size: Dimensions.h_11, color: Theme.of(context).highlightColor),
                                      SizedBox(width: Dimensions.w_5),
                                      Text(
                                        '12 Comments',
                                        style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.h_20),
                            Text(
                              'Make the next connection.',
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
                                return CommonCard(
                                  margin: EdgeInsets.zero,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(action['icon'] as IconData, size: Dimensions.h_15, color: AppColor.blue(context)),
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
                                        'Meet your crew (426)',
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
                                      'A few friendly faces to get you started, Sean.',
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: Dimensions.w_15),
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking6/participant-sarah.webp', size: Dimensions.h_50, widthSize: Dimensions.h_50, color: Theme.of(context).highlightColor),
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
                                              'Organizer · Advanced',
                                              style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_10),
                                  Text(
                                    'Here to help',
                                    style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                                  ),
                                  SizedBox(height: Dimensions.h_10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: Dimensions.w_15),
                                      AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/member-mike.webp', size: Dimensions.h_50, widthSize: Dimensions.h_50, color: Theme.of(context).highlightColor),
                                      SizedBox(width: Dimensions.w_8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Mike R.',
                                              style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                                            ),
                                            SizedBox(height: Dimensions.h_3),
                                            Text(
                                              'Moderator · Advanced',
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
                          ],
                        )
                      : selectedIndex == 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'The conversation starts here',
                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_4),
                                  decoration: BoxDecoration(color: AppColor.blue(context), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                                  child: Text(
                                    '+ New Post',
                                    style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: isLight ? AppColor.white : AppColor.black),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_6, top: Dimensions.h_6),
                              child: Text(
                                'rail updates, good advice, and stories worth sharing. What’s on your mind, Sean?',
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.1),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                              itemBuilder: (c, i) {
                                return CommonCard(
                                  margin: EdgeInsets.only(bottom: Dimensions.h_10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                                      'Today · 9:15 AM',
                                                      style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                                    ),
                                                    const Spacer(),
                                                    Icon(CupertinoIcons.bookmark, size: Dimensions.h_16, color: Theme.of(context).highlightColor),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.h_10),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Trail conditions update',
                                                  style: TextStyle(fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor, height: 1.1),
                                                ),
                                                SizedBox(height: Dimensions.h_5),
                                                Padding(
                                                  padding: EdgeInsets.only(left: Dimensions.w_6),
                                                  child: Text(
                                                    'A heads-up for your next ride, Sean: the upper Tiger Mountain trail is resting after heavy rain. Take the lower loop, give the trail time to dry, and check in with the crew before heading out.',
                                                    style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.3),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.w_10),
                                          AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/trail-closure.webp', size: Dimensions.h_75, widthSize: Dimensions.w_120),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.h_10),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(width: Dimensions.w_6),
                                          Icon(CupertinoIcons.hand_thumbsup_fill, size: Dimensions.h_11, color: Theme.of(context).highlightColor),
                                          SizedBox(width: Dimensions.w_5),
                                          Text(
                                            '12 Likes',
                                            style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                          ),
                                          SizedBox(width: Dimensions.w_15),
                                          Icon(CupertinoIcons.chat_bubble_text, size: Dimensions.h_11, color: Theme.of(context).highlightColor),
                                          SizedBox(width: Dimensions.w_5),
                                          Text(
                                            '12 Comments',
                                            style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : selectedIndex == 2
                      ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: staticActivities.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, mainAxisExtent: Dimensions.h_270),
                        itemBuilder: (context, index) {
                          final activity = staticActivities[index];
                          final attendees = activity['attendees'] as List<String>;

                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Get.toNamed(AppRoutes.activityDetail);
                            },
                            child: CommonCard(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_10), topRight: Radius.circular(Dimensions.h_10)),
                                        child: AppCacheImage(imageUrl: activity['image'] as String, size: Dimensions.h_120, widthSize: Get.width, fit: BoxFit.cover, radius: 0),
                                      ),
                                      Positioned(
                                        top: Dimensions.h_6,
                                        left: Dimensions.w_8,
                                        child: Container(
                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_2),
                                          child: Text(
                                            activity['badge'] as String,
                                            style: TextStyle(color: AppColor.black, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_8),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            activity['title'] as String,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor, height: 1),
                                          ),
                                          SizedBox(height: Dimensions.h_10),
                                          ActivityMeta(icon: CupertinoIcons.clock, text: activity['date'] as String),
                                          SizedBox(height: Dimensions.h_5),
                                          ActivityMeta(icon: CupertinoIcons.location_solid, text: activity['trail'] as String),
                                          SizedBox(height: Dimensions.h_5),
                                          ActivityMeta(icon: Icons.directions_bike, text: '${activity['distance']} · ${activity['skill']}'),
                                          SizedBox(height: Dimensions.h_10),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: Dimensions.w_50,
                                                height: Dimensions.h_20,
                                                child: Stack(
                                                  children: attendees
                                                      .take(3)
                                                      .toList()
                                                      .asMap()
                                                      .entries
                                                      .map(
                                                        (entry) => Positioned(
                                                          left: entry.key * Dimensions.w_15,
                                                          child: Container(
                                                            width: Dimensions.h_20,
                                                            height: Dimensions.h_20,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 1.5),
                                                            ),
                                                            child: ClipOval(
                                                              child: AppCacheImage(imageUrl: entry.value, fit: BoxFit.cover),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                              SizedBox(width: Dimensions.w_6),
                                              Expanded(
                                                child: Text(
                                                  '${activity['goingCount']} going · '
                                                  '${activity['spotsAvailable']} spots left',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(fontSize: FontSize.sp_8_5, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: double.infinity,
                                            height: Dimensions.h_28,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  activity['isJoined'] = !(activity['isJoined'] as bool);
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor: activity['isJoined'] == true ? AppColor.green(context) : AppColor.blue(context),
                                                foregroundColor: Colors.white,
                                                padding: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                                              ),
                                              child: Text(
                                                activity['isJoined'] == true ? 'Leave Activity' : activity['buttonLabel'] as String,
                                                style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: isLight ? Colors.white : AppColor.black),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.h_8),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      : selectedIndex == 3
                      ? ListView.builder(
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
                        )
                      : GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: imageList.length,
                          itemBuilder: (c, i) {
                            return AppCacheImage(imageUrl: imageList[i], widthSize: Get.width, size: Dimensions.h_117, isShadow: false, radius: Dimensions.h_10);
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, mainAxisExtent: Dimensions.h_120),
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

  Widget buildHeroHeader(bool isLight) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCacheImage(alignment: Alignment(0.5, 0), size: Dimensions.h_330, widthSize: Get.width, imageUrl: "https://preetis-html.vercel.app/assets/images/groups/mountain-biking4/hero.webp"),
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
                  "Pine Valley MTB Crew",
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
                  "Find your next trail with good company, Sean.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w500,
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
                        Icon(CupertinoIcons.globe, size: Dimensions.h_12, color: Colors.white),
                        SizedBox(width: Dimensions.w_5),
                        Text(
                          "Public Group",
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1.2),
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
                          "Pine Valley + 30 miles",
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
                          "Mountain biking",
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
                        Icon(Icons.person_2, size: Dimensions.h_12, color: Colors.white),
                        SizedBox(width: Dimensions.w_3),
                        Text(
                          "425 Members",
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, height: 1.2),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_15),
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
                                "Join Group",
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
                              Icon(CupertinoIcons.check_mark_circled, size: Dimensions.h_13, color: Theme.of(context).highlightColor),
                              SizedBox(width: Dimensions.w_5),
                              Text(
                                "Follow",
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
