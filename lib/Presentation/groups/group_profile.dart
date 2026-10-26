import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wikixm/Presentation/events/events_screen_shimmer.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/cache_image.dart';
import '../widgets/map.dart';

class GroupUserProfile extends StatefulWidget {
  const GroupUserProfile({super.key});

  @override
  State<GroupUserProfile> createState() => _GroupUserProfileState();
}

class _GroupUserProfileState extends State<GroupUserProfile> {
  final GroupController groupController = Get.put(GroupController());
  final List<Map<String, dynamic>> skillStats = [
    {'title': 'Years Riding', 'value': '12 years', 'icon': Icons.calendar_today_outlined},
    {'title': 'Typical Ride', 'value': '15–25 miles', 'icon': Icons.directions_bike},
    {'title': 'Typical Elevation', 'value': '1,500–3,000 ft', 'icon': Icons.landscape_outlined},
    {'title': 'Frequency', 'value': '1–3 rides per week', 'icon': Icons.calendar_month_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetBuilder(
        init: groupController,
        id: ControllerBuilders.groupController,
        builder: (controller) {
          return controller.isLoading
              ? EventsScreenShimmer()
              : CommonScrollBlurScaffold(
                  showBack: true,
                  expandedHeight: Dimensions.h_240,
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
                            SizedBox(height: Dimensions.h_15),
                            Row(
                              children: [
                                Text(
                                  'Skill & Experience',
                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_10),
                            CommonCard(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Technical Terran',
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                                      ),
                                      const Spacer(),
                                      Text(
                                        'Advanced',
                                        style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_7),
                                  LinearProgressIndicator(color: AppColor.blue(context), value: 0.7, minHeight: Dimensions.h_5, backgroundColor: isLight ? Colors.grey.shade400 : Colors.grey.shade200, borderRadius: BorderRadius.circular(99)),
                                  SizedBox(height: Dimensions.h_15),
                                  Row(
                                    children: [
                                      Text(
                                        'Climbing/Endurance',
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                                      ),
                                      const Spacer(),
                                      Text(
                                        'Strong',
                                        style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_7),
                                  LinearProgressIndicator(color: AppColor.blue(context), value: 0.7, minHeight: Dimensions.h_5, backgroundColor: isLight ? Colors.grey.shade400 : Colors.grey.shade200, borderRadius: BorderRadius.circular(99)),
                                  SizedBox(height: Dimensions.h_15),
                                  Row(
                                    children: [
                                      Text(
                                        'Descending',
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                                      ),
                                      const Spacer(),
                                      Text(
                                        'Advanced',
                                        style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_7),
                                  LinearProgressIndicator(color: AppColor.blue(context), value: 0.7, minHeight: Dimensions.h_5, backgroundColor: isLight ? Colors.grey.shade400 : Colors.grey.shade200, borderRadius: BorderRadius.circular(99)),
                                  Container(
                                    margin: EdgeInsets.only(top: Dimensions.h_10, bottom: Dimensions.h_10),
                                    height: 0.2,
                                    width: Get.width,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: skillStats.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_10, mainAxisSpacing: Dimensions.h_10, mainAxisExtent: Dimensions.h_60),
                                    itemBuilder: (context, index) {
                                      final item = skillStats[index];

                                      return CommonCard(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        isBorder: false,
                                        margin: EdgeInsets.zero,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: Dimensions.h_25,
                                              height: Dimensions.h_25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(color: AppColor.blueSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_6)),
                                              child: Icon(item['icon'] as IconData, size: Dimensions.h_15, color: AppColor.blue(context)),
                                            ),
                                            SizedBox(width: Dimensions.w_8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item['title'] as String,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w400, color: Theme.of(context).highlightColor),
                                                  ),
                                                  SizedBox(height: Dimensions.h_2),
                                                  Text(
                                                    item['value'] as String,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
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
                              ),
                            ),
                            SizedBox(height: Dimensions.h_15),
                            Row(
                              children: [
                                Text(
                                  'Riding Preference',
                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_10),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget buildPeopleSection(Color blue, bool isLight, GroupController controller) {
    final peopleData = controller.groupSectionData?.people;
    final people = peopleData?.items ?? [];
    final blue = AppColor.blue(context);
    final green = AppColor.green(context);
    final greenSoft = AppColor.greenSoft(context);
    final orange = AppColor.orange(context);
    final violet = AppColor.violet(context);

    IconData getPersonIcon(String? icon) {
      switch (icon) {
        case 'bike':
          return Icons.directions_bike_outlined;
        case 'groups-pickleball':
          return CupertinoIcons.sportscourt;
        case 'groups-skiing':
          return CupertinoIcons.snow;
        case 'groups-hiking':
          return CupertinoIcons.person_2_fill;
        default:
          return CupertinoIcons.person_fill;
      }
    }

    Color getPersonColor(String? color, Color defaultColor) {
      switch (color) {
        case 'green':
          return green;
        case 'orange':
          return orange;
        case 'blue':
          return defaultColor;
        case 'violet':
          return violet;
        default:
          return defaultColor;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                peopleData?.title ?? 'People Looking for Others',
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
              ),
            ),
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
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: people.isEmpty
              ? SizedBox(
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_30),
                    child: Text(
                      peopleData?.emptyMessage ?? 'No people are available yet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: FontSize.sp_13_5, color: Theme.of(context).highlightColor),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    final person = people[index];
                    final personColor = getPersonColor(person.color, blue);
                    final personIcon = getPersonIcon(person.icon);
                    final imageUrl = person.image?.url ?? '';
                    final canConnect = person.canConnect == true;
                    final connectionStatus = person.connectionStatus ?? 'none';
                    final buttonLabel = connectionStatus == 'connected'
                        ? 'Connected'
                        : connectionStatus == 'pending'
                        ? 'Pending'
                        : 'Connect';

                    return Padding(
                      padding: EdgeInsets.only(bottom: index == people.length - 1 ? 0 : Dimensions.h_12),
                      child: Row(
                        children: [
                          AppCacheImage(imageUrl: imageUrl, widthSize: Dimensions.h_35, size: Dimensions.h_35, fit: BoxFit.cover, isCircle: true, isShadow: false),
                          SizedBox(width: Dimensions.w_8),
                          Container(
                            height: Dimensions.h_22,
                            width: Dimensions.h_22,
                            decoration: BoxDecoration(color: personColor.withValues(alpha: 0.12), shape: BoxShape.circle),
                            child: Icon(personIcon, size: Dimensions.h_13, color: personColor),
                          ),
                          SizedBox(width: Dimensions.w_8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  person.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                                ),
                                SizedBox(height: Dimensions.h_2),
                                Text(
                                  person.description ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: FontSize.sp_9_5, color: Theme.of(context).highlightColor),
                                ),
                                SizedBox(height: Dimensions.h_2),
                                Text(
                                  person.details ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: FontSize.sp_9, color: Theme.of(context).highlightColor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: Dimensions.w_6),
                          !canConnect
                              ? SizedBox.shrink()
                              : GestureDetector(
                                  onTap: !canConnect || connectionStatus == 'connected' || connectionStatus == 'pending' ? null : () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: !canConnect
                                          ? Theme.of(context).disabledColor.withValues(alpha: 0.12)
                                          : connectionStatus == 'connected'
                                          ? greenSoft
                                          : blue,
                                      borderRadius: BorderRadius.circular(99),
                                    ),
                                    child: Text(
                                      !canConnect ? 'Unavailable' : buttonLabel,
                                      style: TextStyle(
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w700,
                                        color: !canConnect
                                            ? Theme.of(context).hintColor
                                            : connectionStatus == 'connected'
                                            ? green
                                            : AppColor.groupsWhite(context),
                                      ),
                                    ),
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

  Widget activityMeta(BuildContext context, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: Dimensions.w_3),
        Icon(icon, size: Dimensions.h_11, color: Theme.of(context).highlightColor),
        SizedBox(width: Dimensions.w_4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: FontSize.sp_9_5, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  String formatGroupActivityDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('EEE, MMM d · h:mm a').format(date.toLocal());
  }

  Color groupActivityBadgeColor(String? color, bool isLight) {
    final value = color?.trim();
    if (value == null || value.isEmpty) return groupInterestColor(null, isLight);
    final hex = value.startsWith('#') ? value.substring(1) : value;
    if (RegExp(r'^[0-9a-fA-F]{6}$').hasMatch(hex)) return Color(int.parse('FF$hex', radix: 16));
    return groupInterestColor(value, isLight);
  }

  IconData groupActivityDetailIcon(String? icon) {
    switch (icon) {
      case 'clock':
      case 'calendar':
        return CupertinoIcons.clock;
      case 'location':
      case 'map-pin':
        return CupertinoIcons.location_solid;
      case 'route':
      case 'distance':
        return CupertinoIcons.triangle;
      case 'level':
      case 'users':
        return CupertinoIcons.person_2_fill;
      default:
        return CupertinoIcons.info_circle;
    }
  }

  Widget avatar(String image, int index) {
    return Positioned(
      left: index * Dimensions.w_15,
      child: Container(
        width: Dimensions.h_20,
        height: Dimensions.h_20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 1.5),
        ),
        child: ClipOval(
          child: AppCacheImage(imageUrl: image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildHeroHeader(bool isLight, GroupController controller) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCacheImage(alignment: Alignment(0.5, 0), size: Dimensions.h_330, widthSize: Get.width, imageUrl: 'https://preetis-html.vercel.app/assets/images/groups/mountain-biking5/hero.webp'),
        Positioned.fill(
          child: Container(
            height: Dimensions.h_330,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [const Color(0xFF020B15).withValues(alpha: 0.85), const Color(0xFF020B15).withValues(alpha: 0.65), const Color(0xFF020B15).withValues(alpha: 0.35), Colors.transparent], stops: const [0.0, 0.30, 0.58, 1.0]),
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
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_80),
                child: Text(
                  'YOUR TRAIL STORY, SEAN',
                  style: TextStyle(color: const Color(0xFFFFE47A), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_5),
                child: Text(
                  "My Mountain Biking Activity Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_22,
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, right: Dimensions.w_60),
                child: Text(
                  'Your skills, your kind of ride, and the people you’d like to meet. Make your next trail day feel like you.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w500,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_5),
                    decoration: BoxDecoration(color: AppColor.green(context), borderRadius: BorderRadius.circular(99)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.w_5),
                          child: Icon(Icons.check_circle_outlined, size: Dimensions.h_10, color: Colors.white),
                        ),
                        Text(
                          "Advanced",
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w600, height: 1.2),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_5),
                    decoration: BoxDecoration(color: AppColor.green(context), borderRadius: BorderRadius.circular(99)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.w_5),
                          child: Icon(CupertinoIcons.checkmark_shield, size: Dimensions.h_10, color: Colors.white),
                        ),
                        Text(
                          "Community confirmed",
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w600, height: 1.2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.toNamed(AppRoutes.createGroup);
                },
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_8),
                  decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: Dimensions.w_8),
                      Padding(
                        padding: EdgeInsets.only(top: Dimensions.h_1),
                        child: Icon(Icons.edit, size: Dimensions.h_12, color: Colors.white),
                      ),
                      SizedBox(width: Dimensions.w_5),
                      Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, height: 1.2),
                      ),

                      SizedBox(width: Dimensions.w_5),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
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

  IconData getCommunityStatIcon(String? icon) {
    switch (icon) {
      case 'users':
        return CupertinoIcons.group;
      case 'calendar':
        return CupertinoIcons.calendar;
      case 'heart-fill':
        return CupertinoIcons.heart_fill;
      default:
        return CupertinoIcons.chart_bar;
    }
  }

  Color groupInterestColor(String? color, bool isLight) {
    switch (color) {
      case 'blue':
        return AppColor.blue(context);
      case 'orange':
        return AppColor.orange(context);
      case 'violet':
        return AppColor.violet(context);
      case 'green':
      default:
        return AppColor.green(context);
    }
  }

  Color groupInterestSoftColor(String? color, bool isLight) {
    switch (color) {
      case 'blue':
        return AppColor.blueSoft(context);
      case 'orange':
        return AppColor.orangeSoft(context);
      case 'violet':
        return AppColor.violetSoft(context);
      case 'green':
      default:
        return AppColor.greenSoft(context);
    }
  }

  IconData groupInterestIcon(String? icon) {
    switch (icon) {
      case 'bike':
        return Icons.directions_bike_outlined;
      case 'camera':
        return CupertinoIcons.camera_fill;
      case 'leaf':
        return Icons.energy_savings_leaf;
      case 'groups-skiing':
        return CupertinoIcons.snow;
      case 'groups-golf':
        return CupertinoIcons.person_2;
      case 'groups-pickleball':
        return CupertinoIcons.sportscourt;
      case 'groups-running':
        return CupertinoIcons.flame_fill;
      case 'groups-hiking':
      case 'users':
      default:
        return CupertinoIcons.person_2_fill;
    }
  }

  Widget communityStatItem({required IconData icon, required String value, required String label, double? iconSize}) {
    return Row(
      children: [
        Icon(icon, size: iconSize ?? Dimensions.h_18, fontWeight: FontWeight.bold, color: Colors.white),
        SizedBox(width: Dimensions.w_8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900, color: AppColor.white, height: 1),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: FontSize.sp_10,
                color: AppColor.white,
                shadows: [
                  Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2)),
                  Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2)),
                  Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
