import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/events/events_screen_shimmer.dart';
import 'package:wikixm/Presentation/school/controller.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/AnimatedImage.dart';
import '../widgets/cache_image.dart';
import '../widgets/circular_percent.dart';
import '../widgets/common_bullet.dart';
import '../widgets/common_header.dart';

class SchoolScreen extends StatefulWidget {
  const SchoolScreen({super.key});

  @override
  State<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  final SchoolController schoolController = Get.put(SchoolController());

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
        top: false,
        bottom: false,
        bodyPadding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: GetBuilder(
          init: schoolController,
          id: ControllerBuilders.educationController,
          builder: (controller) {
            return controller.isLoading ? EventsScreenShimmer():CommonScrollBlurScaffold(
              showBack: true,
              expandedHeight: Dimensions.h_290,
              expandedColor: Colors.white,
              collapsedColor: Theme.of(context).highlightColor,
              hero: buildHeroHeader(isLight,controller),
              slivers: [
              SliverToBoxAdapter(
              child: Column(
              children: [
                SizedBox(height: Dimensions.h_5),
                firstCard(isLight),
                SizedBox(height: Dimensions.h_10),
                aiBrief()
              ])),
              SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.h_15),
                        CommonSectionHeader(
                          title: "What Matters Most".toUpperCase(),
                          actionText: "View All",
                          secondActionText: "",
                          onActionTap: () {
                          },
                        ),
                        SizedBox(height: Dimensions.h_10),
                        upcomingEventsGrid(isLight),
                        SizedBox(height: Dimensions.h_15),
                        whatToday(context, isLight),
                        SizedBox(height: Dimensions.h_15),
                        educationCommunityPulse(isLight),
                        SizedBox(height: Dimensions.h_15),
                        browseSchool(isLight),
                        SizedBox(height: Dimensions.h_15),
                        activeEducationTopics(isLight),
                        SizedBox(height: Dimensions.h_15),
                        schoolBoardDistrictSection(isLight),
                        SizedBox(height: Dimensions.h_15),
                        studentSpotlight(context),
                        SizedBox(height: Dimensions.h_15),
                        upcomingEvents(isLight, context),
                        SizedBox(height: Dimensions.h_15),
                        schoolMemories(context),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Dimensions.h_10),
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0044f3),
                                borderRadius: BorderRadius.circular(Dimensions.h_8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  Dimensions.w_8,
                                  Dimensions.h_10,
                                  Dimensions.w_8,
                                  Dimensions.h_5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Stay Informed'.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: FontSize.sp_12,
                                            fontWeight: FontWeight.w800,
                                            height: 1.12,
                                          ),
                                        ),
                                        Icon(CupertinoIcons.mail,size: Dimensions.h_13,color: AppColor.white)
                                      ],
                                    ),
                                    SizedBox(height: Dimensions.h_5),
                                    Padding(
                                      padding:  EdgeInsets.only(left: Dimensions.w_8),
                                      child: Text(
                                        'Get the latest education news delivered to your inbox.',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: FontSize.sp_10,
                                          fontWeight: FontWeight.w500,
                                          height: 1.12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_12),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: Dimensions.h_28,
                                              child: TextFormField(
                                                  decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(vertical: Dimensions.h_1,horizontal: Dimensions.w_5),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      hintText: 'Enter your email',
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: FontSize.sp_10,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(4),
                                                        borderSide: BorderSide(
                                                            color: Colors.white,
                                                            width: 0.1
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(4),
                                                        borderSide: BorderSide(
                                                            color: Colors.white,
                                                            width: 0.1
                                                        ),
                                                      )
                                                  )),
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.w_8),
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: Dimensions.h_8,horizontal: Dimensions.w_15),
                                            decoration: BoxDecoration(
                                              color: Color(0xff1b5afc),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('Subscribe', style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: FontSize.sp_10,
                                                    fontWeight: FontWeight.w900
                                                )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_5),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_10),
                        CommonCard(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.sparkles,size: Dimensions.h_25,color: Theme.of(context).primaryColor),
                              SizedBox(width: Dimensions.w_12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: Dimensions.h_2),
                                    Row(
                                      children: [
                                        Text('ASK WIKIXM AI', style: TextStyle(
                                            color: Theme.of(Get.context!).highlightColor,
                                            fontSize: FontSize.sp_12,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.1
                                        )),
                                        Container(
                                          margin: EdgeInsets.only(left: Dimensions.w_4),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.w_5,
                                            vertical: Dimensions.h_3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: !isLight
                                                ? const Color(0xffffc264)
                                                : const Color(0xFF97590a),
                                            borderRadius: BorderRadius.circular(999),
                                          ),
                                          child: Text(
                                            'COMING SOON',
                                            style: TextStyle(
                                              color: !isLight ? AppColor.black : AppColor.white,
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
                                      "Ask anything about pine valley school, education, PTA meetings and more",
                                      style: TextStyle(
                                        color: Theme.of(Get.context!).highlightColor,
                                        fontSize: FontSize.sp_9_5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_6),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: Dimensions.w_20,right: Dimensions.w_10),
                                padding: EdgeInsets.symmetric(vertical: Dimensions.h_5,horizontal: Dimensions.w_5),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.darkBlue),
                                child: Icon(CupertinoIcons.chat_bubble,size: Dimensions.h_18,color: AppColor.white),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.h_20),
                      ],
                    ),
                  )
              )]);
          }
        ));
  }

  Widget schoolMemories(BuildContext context) {
    final memories =
        schoolController.educationData?.storyGrid?.memories;

    String getFullImageUrl(String? image) {
      if (image == null || image.isEmpty) return '';

      if (image.startsWith('http')) return image;

      return 'https://staging.wikixm.com$image';
    }

    IconData getMetaIcon(String? iconUrl) {
      final iconName =
          iconUrl?.split('#').last.toLowerCase() ?? '';

      switch (iconName) {
        case 'eye':
          return CupertinoIcons.eye;

        case 'comments':
        case 'comment':
          return CupertinoIcons.chat_bubble_text;

        default:
          return CupertinoIcons.circle;
      }
    }

    final metaItems = memories?.meta ?? [];

    return Column(
      children: [
        CommonSectionHeader(
          title: (memories?.title ?? 'School Memories').toUpperCase(),
          actionText: memories?.link?.text ?? 'View All',
          onActionTap: () {},
        ),

        SizedBox(height: Dimensions.h_10),

        CommonCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.h_8),
                  topRight: Radius.circular(Dimensions.h_8),
                ),
                child: AppCacheImage(
                  size: Dimensions.h_140,
                  widthSize: Get.width,
                  imageUrl: getFullImageUrl(memories?.image),
                  isShadow: false,
                  radius: 0,
                  borderColor: Colors.grey.shade200,
                ),
              ),
              SizedBox(height: Dimensions.h_8),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8),
                child: Text(
                  memories?.headline ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_6),
              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.w_12,
                  right: Dimensions.w_12,
                ),
                child: Text(
                  memories?.description ?? '',
                  maxLines: 3,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_6),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_8,
                ),
                child: Row(
                  children: List.generate(metaItems.length, (index) {
                    final item = metaItems[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == metaItems.length - 1
                            ? 0
                            : Dimensions.w_25,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            getMetaIcon(item.icon),
                            size: Dimensions.h_10,
                            color: Theme.of(context).highlightColor,
                          ),
                          SizedBox(width: Dimensions.w_3),
                          Flexible(
                            child: Text(
                              item.text ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: FontSize.sp_8_5,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: Dimensions.h_10),
            ],
          ),
        ),
      ],
    );
  }
  Widget upcomingEvents(bool isLight, BuildContext context) {
    final eventsData =
        schoolController.educationData?.storyGrid?.events;

    final events = eventsData?.items ?? [];

    IconData getEventIcon(String? iconUrl) {
      final iconName =
          iconUrl?.split('#').last.toLowerCase() ?? '';

      switch (iconName) {
        case 'calendar':
          return CupertinoIcons.calendar;

        case 'calendar-check':
          return Icons.calendar_month_outlined;

        case 'school':
          return Icons.school_outlined;

        case 'medal':
          return Icons.workspace_premium_outlined;

        default:
          return CupertinoIcons.calendar;
      }
    }

    Color getEventIconColor() {
      return isLight
          ? AppColor.accentBlue
          : const Color(0xFF7C9AC5);
    }

    return Column(
      children: [
        CommonSectionHeader(
          title: (eventsData?.title ?? 'Upcoming Events').toUpperCase(),
          actionText: '',
          secondActionText: '',
          onActionTap: () {},
        ),

        SizedBox(height: Dimensions.h_10),

        CommonCard(
          padding: EdgeInsets.only(
            top: Dimensions.h_4,
            bottom: Dimensions.h_4,
          ),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: events.length,
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.w_20,
                  ),
                  child: Container(
                    height: 0.1,
                    color: isLight
                        ? Theme.of(context).highlightColor
                        : Theme.of(context)
                        .highlightColor
                        .withValues(alpha: 0.50),
                  ),
                ),
                itemBuilder: (context, index) {
                  final item = events[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_15,
                      vertical: Dimensions.h_5,
                    ),
                    child: _boardDistrictItem(
                      context: context,
                      icon: getEventIcon(item.icon),
                      title: item.title ?? '',
                      subtitle: '',
                      description: item.meta ?? '',
                      iconColor: getEventIconColor(),
                      isLight: isLight,
                    ),
                  );
                },
              ),

              if (events.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.w_20,
                    bottom: Dimensions.h_10,
                  ),
                  height: 0.1,
                  color: isLight
                      ? Theme.of(context).highlightColor
                      : Theme.of(context)
                      .highlightColor
                      .withValues(alpha: 0.50),
                ),

              if (eventsData?.bottomLink != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      eventsData?.bottomLink?.text ??
                          'View Full Calendar',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: Dimensions.w_3),
                    Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).primaryColorDark,
                      size: Dimensions.h_11,
                    ),
                  ],
                ),

              SizedBox(height: Dimensions.h_8),
            ],
          ),
        ),
      ],
    );
  }

  Widget studentSpotlight(BuildContext context) {
    final spotlight =
        schoolController.educationData?.storyGrid?.spotlight;

    String getFullImageUrl(String? image) {
      if (image == null || image.isEmpty) return '';

      if (image.startsWith('http')) return image;

      return 'https://staging.wikixm.com$image';
    }

    IconData getMetaIcon(String? iconUrl) {
      final iconName =
          iconUrl?.split('#').last.toLowerCase() ?? '';

      switch (iconName) {
        case 'heart-hand':
        case 'heart':
          return CupertinoIcons.heart;

        case 'comments':
        case 'comment':
          return CupertinoIcons.chat_bubble_text;

        default:
          return CupertinoIcons.circle;
      }
    }

    final metaItems = spotlight?.meta ?? [];

    return Column(
      children: [
        CommonSectionHeader(
          title: (spotlight?.title ?? 'Student Spotlight').toUpperCase(),
          actionText: spotlight?.link?.text ?? 'View All',
          onActionTap: () {},
        ),

        SizedBox(height: Dimensions.h_10),

        CommonCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.h_8),
                  topRight: Radius.circular(Dimensions.h_8),
                ),
                child: AppCacheImage(
                  size: Dimensions.h_140,
                  widthSize: Get.width,
                  imageUrl: getFullImageUrl(spotlight?.image),
                  isShadow: false,
                  radius: 0,
                  borderColor: Colors.grey.shade200,
                ),
              ),

              SizedBox(height: Dimensions.h_8),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_12,
                ),
                child: Text(
                  spotlight?.headline ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              SizedBox(height: Dimensions.h_6),

              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.w_12,
                  right: Dimensions.w_12,
                ),
                child: Text(
                  spotlight?.description ?? '',
                  maxLines: 3,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                  ),
                ),
              ),

              SizedBox(height: Dimensions.h_6),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_8,
                ),
                child: Row(
                  children: List.generate(metaItems.length, (index) {
                    final item = metaItems[index];

                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == metaItems.length - 1
                            ? 0
                            : Dimensions.w_25,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            getMetaIcon(item.icon),
                            size: Dimensions.h_10,
                            color: Theme.of(context).highlightColor,
                          ),
                          SizedBox(width: Dimensions.w_3),
                          Flexible(
                            child: Text(
                              item.text ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: FontSize.sp_8_5,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: Dimensions.h_10),
            ],
          ),
        ),
      ],
    );
  }

  Widget browseSchool(bool isLight) {
    final browse = schoolController.educationData?.midPanels?.browse;
    final filters = browse?.filters ?? [];
    return Column(
      children: [
        CommonSectionHeader(
          title: (browse?.title ?? 'Browse Schools').toUpperCase(),
          actionText: browse?.link?.text ?? '',
          secondActionText: "",
          onActionTap: () {},
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(filters.length, (index) {
                    final filter = filters[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == filters.length - 1
                            ? 0
                            : Dimensions.w_4,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          schoolController.changeSchoolFilter(filter.id ?? '');
                        },
                        child:  _scoreFilter(
                            title: filter.label ?? '',
                            isSelected: schoolController.selectedSchoolFilter == (filter.id ?? 'all')),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              schoolsHorizontalList(isLight),
            ],
          ),
        ),
      ],
    );
  }

  Widget whatToday(BuildContext context, bool isLight) {
    final items =
        schoolController.educationData?.topPanels?.today?.items ?? [];

    IconData getActionIcon(String? iconUrl) {
      final iconName = iconUrl?.split('#').last.toLowerCase() ?? '';

      switch (iconName) {
        case 'users':
          return CupertinoIcons.person_2;

        case 'vote':
          return CupertinoIcons.checkmark_seal;

        case 'camera':
          return CupertinoIcons.camera;

        case 'home':
          return CupertinoIcons.home;

        case 'chat':
          return CupertinoIcons.chat_bubble;

        default:
          return CupertinoIcons.circle;
      }
    }

    Color getIconColor(String? iconClass) {
      switch (iconClass?.toLowerCase()) {
        case 'meet-icon':
          return isLight
              ? const Color(0xFF0D6B3F)
              : const Color(0xFF4FC98A);

        case 'vote-icon':
          return isLight
              ? const Color(0xFFD81324)
              : const Color(0xFFFF7B84);

        case 'photo-icon':
          return isLight
              ? const Color(0xFF0D6B3F)
              : const Color(0xFF4FC98A);

        case 'welcome-icon':
          return isLight
              ? const Color(0xFF0F766E)
              : const Color(0xFF3FB8AB);

        case 'discuss-icon':
          return isLight
              ? const Color(0xFFB94705)
              : const Color(0xFFFF9D4D);

        default:
          return Theme.of(context).primaryColor;
      }
    }

    Color getIconBackground(String? iconClass) {
      switch (iconClass?.toLowerCase()) {
        case 'meet-icon':
        case 'photo-icon':
          return isLight
              ? const Color(0xFFE8F3EC)
              : const Color(0xFF102B1F);

        case 'vote-icon':
          return isLight
              ? const Color(0xFFFDE7E9)
              : const Color(0xFF3A1720);

        case 'welcome-icon':
          return isLight
              ? const Color(0xFFE5F3F4)
              : const Color(0xFF132B38);

        case 'discuss-icon':
          return isLight
              ? const Color(0xFFFDEADA)
              : const Color(0xFF3D2411);

        default:
          return Theme.of(context).focusColor;
      }
    }

    return Column(
      children: [
        CommonSectionHeader(
          title: "What Should I Do Today?".toUpperCase(),
          actionText: "View All",
          secondActionText: "",
          onActionTap: () {},
        ),

        SizedBox(height: Dimensions.h_10),

        CommonCard(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w_8,
            vertical: Dimensions.h_8,
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];

              return Column(
                children: [
                  _actionItem(
                    context: context,
                    isLight: isLight,
                    icon: getActionIcon(item.icon),
                    title: item.title ?? '',
                    subtitle: item.description ?? '',
                    points: '+${item.points ?? 0} pts',
                    iconColor: getIconColor(item.iconClass),
                    iconBackground: getIconBackground(item.iconClass),
                  ),

                  if (index != items.length - 1)
                    _divider(context, isLight),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget schoolBoardDistrictSection(bool isLight) {
    final boardData =
        schoolController.educationData?.storyGrid?.board;

    final items = boardData?.items ?? [];

    IconData getBoardIcon(String? iconUrl) {
      final iconName =
          iconUrl?.split('#').last.toLowerCase() ?? '';

      switch (iconName) {
        case 'clipboard':
          return CupertinoIcons.doc_on_clipboard;

        case 'calendar':
          return Icons.calendar_month_outlined;

        case 'scroll-document':
          return CupertinoIcons.doc_fill;

        default:
          return CupertinoIcons.doc_on_clipboard;
      }
    }

    Color getBoardIconColor() {
      return isLight
          ? AppColor.accentBlue
          : const Color(0xFF7C9AC5);
    }

    return Column(
      children: [
        CommonSectionHeader(
          title: (boardData?.title ?? 'School Board & District')
              .toUpperCase(),
          actionText: "",
          secondActionText: "",
          onActionTap: () {},
        ),

        SizedBox(height: Dimensions.h_10),

        CommonCard(
          padding: EdgeInsets.only(
            top: Dimensions.h_4,
            bottom: Dimensions.h_4,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: items.length,

            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: Dimensions.w_20,
              ),
              child: Container(
                height: 0.1,
                color: isLight
                    ? Theme.of(context).highlightColor
                    : Theme.of(context)
                    .highlightColor
                    .withValues(alpha: 0.50),
              ),
            ),

            itemBuilder: (context, index) {
              final item = items[index];

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_15,
                  vertical: Dimensions.h_5,
                ),
                child: _boardDistrictItem(
                  context: context,
                  icon: getBoardIcon(item.icon),
                  title: item.title ?? '',
                  subtitle: item.status ?? '',
                  description: item.meta ?? '',
                  iconColor: getBoardIconColor(),
                  isLight: isLight,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _boardDistrictItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required Color iconColor,
    required bool isLight,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: Dimensions.h_3),
          child: Icon(
            icon,
            color: iconColor,
            size: Dimensions.h_15,
          ),
        ),
        SizedBox(width: Dimensions.w_10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: Dimensions.h_3),
              if(subtitle.isNotEmpty)
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isLight
                      ? AppColor.primaryNavyNew
                      : const Color(0xFFB6C3D5),
                  fontSize: FontSize.sp_9_5,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
              if(subtitle.isNotEmpty)
                SizedBox(height: Dimensions.h_5),
              Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: FontSize.sp_8,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget activeEducationTopics(bool isLight) {
    final topicsData =
        schoolController.educationData?.midPanels?.topics;

    final topics = topicsData?.items ?? [];

    IconData getTopicIcon(String? iconUrl) {
      final iconName = iconUrl?.split('#').last.toLowerCase() ?? '';

      switch (iconName) {
        case 'wallet':
          return Icons.wallet_outlined;

        case 'school':
          return Icons.school_outlined;

        case 'bus':
          return Icons.directions_bus_outlined;

        case 'building':
          return Icons.account_balance_outlined;

        case 'book':
          return Icons.menu_book_outlined;

        default:
          return Icons.article_outlined;
      }
    }

    Color getIconColor(String? iconClass) {
      switch (iconClass?.toLowerCase()) {
        case 'budget':
          return isLight
              ? const Color(0xFFB47A2A)
              : const Color(0xFFD6A85D);

        case 'graduation':
          return isLight
              ? const Color(0xFF4B8278)
              : const Color(0xFF75B5A8);

        case 'transport':
          return isLight
              ? const Color(0xFF3F75A8)
              : const Color(0xFF74A9DD);

        case 'elementary':
          return isLight
              ? const Color(0xFFB56D3C)
              : const Color(0xFFD99A70);

        case 'reading':
          return isLight
              ? const Color(0xFF4A70AA)
              : const Color(0xFF7FA5E0);

        default:
          return isLight
              ? AppColor.primaryNavyNew
              : AppColor.white;
      }
    }

    Color getIconBackground(String? iconClass) {
      switch (iconClass?.toLowerCase()) {
        case 'budget':
          return isLight
              ? const Color(0xFFF7F1E7)
              : const Color(0xFF2D251A);

        case 'graduation':
          return isLight
              ? const Color(0xFFEAF4F1)
              : const Color(0xFF18332E);

        case 'transport':
          return isLight
              ? const Color(0xFFEAF2FA)
              : const Color(0xFF172B40);

        case 'elementary':
          return isLight
              ? const Color(0xFFFAF0E9)
              : const Color(0xFF39261D);

        case 'reading':
          return isLight
              ? const Color(0xFFEAF0FA)
              : const Color(0xFF1D2940);

        default:
          return isLight
              ? Theme.of(context).focusColor
              : const Color(0xFF1E2A3A);
      }
    }

    Color getPriorityColor(String? priorityClass) {
      switch (priorityClass?.toLowerCase()) {
        case 'high':
          return isLight
              ? const Color(0xFFC34B4B)
              : const Color(0xFFFF8585);

        case 'medium':
          return isLight
              ? const Color(0xFFB87520)
              : const Color(0xFFFFB85C);

        case 'low':
          return isLight
              ? const Color(0xFF4D8A72)
              : const Color(0xFF72C7A5);

        default:
          return isLight
              ? Theme.of(context).highlightColor
              : const Color(0xFFB8C4D6);
      }
    }

    Color getPriorityBackground(String? priorityClass) {
      switch (priorityClass?.toLowerCase()) {
        case 'high':
          return isLight
              ? const Color(0xFFFCEDED)
              : const Color(0xFF3D2025);

        case 'medium':
          return isLight
              ? const Color(0xFFFCF4E7)
              : const Color(0xFF3A2B17);

        case 'low':
          return isLight
              ? const Color(0xFFE8F4EE)
              : const Color(0xFF19352A);

        default:
          return isLight
              ? Theme.of(context).focusColor
              : const Color(0xFF202B3A);
      }
    }

    return Column(
      children: [
        CommonSectionHeader(
          title: (topicsData?.title ?? 'Active Education Topics')
              .toUpperCase(),
          actionText: topicsData?.link?.text ?? '',
          secondActionText: "",
          onActionTap: () {},
        ),

        SizedBox(height: Dimensions.h_10),

        CommonCard(
          padding: EdgeInsets.zero,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: topics.length,
            separatorBuilder: (context, index) => Container(
              height: 0.5,
              color: Theme.of(context).focusColor,
            ),
            itemBuilder: (context, index) {
              final item = topics[index];

              final subtitle =
                  '${item.discussions ?? 0} discussions · ${item.updated ?? ''}';

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_12,
                  vertical: Dimensions.h_8,
                ),
                child: _actionItem(
                  context: context,
                  icon: getTopicIcon(item.icon),
                  title: item.title ?? '',
                  subtitle: subtitle,
                  iconColor: getIconColor(item.iconClass),
                  iconBackground: getIconBackground(item.iconClass),
                  isLight: isLight,
                  trailing: _priorityBadge(
                    label: item.priority ?? '',
                    color: getPriorityColor(item.priorityClass),
                    backgroundColor:
                    getPriorityBackground(item.priorityClass),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _scoreFilter({
    required String title,
    bool isSelected = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15),
      height: Dimensions.h_20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColor.darkBlue
            : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: isSelected ? null :Border.all(
          color:Theme.of(context).focusColor,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? Colors.white
              : Theme.of(context).primaryColor,
          fontSize: FontSize.sp_9_5,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }

  Widget educationCommunityPulse(bool isLight) {
    final pulse =
        schoolController.educationData?.schoolRail?.pulse;

    final metrics = pulse?.metrics ?? [];

    IconData getMetricIcon(String? iconUrl) {
      final iconName = iconUrl?.split('#').last.toLowerCase() ?? '';

      switch (iconName) {
        case 'link':
          return Icons.link_rounded;

        case 'heart-hand':
          return CupertinoIcons.heart;

        case 'calendar-check':
          return CupertinoIcons.calendar;

        case 'medal':
          return Icons.workspace_premium_outlined;

        case 'community':
          return CupertinoIcons.group;

        default:
          return CupertinoIcons.circle;
      }
    }

    Color getMetricIconColor(String? iconUrl) {
      final iconName = iconUrl?.split('#').last.toLowerCase() ?? '';

      switch (iconName) {
        case 'medal':
        case 'community':
          return const Color(0xFFB94705);
        default:
          return isLight
              ? AppColor.primaryNavyNew
              : AppColor.white;
      }
    }

    bool isStable(dynamic metric) {
      return metric.valueClass?.toLowerCase() == 'stable' ||
          metric.value?.toLowerCase() == 'stable';
    }

    bool hasPositiveChange(dynamic metric) {
      final change = metric.change ?? '';
      return change.contains('↑') ||
          change.toLowerCase().contains('up');
    }

    return Column(
      children: [
        CommonSectionHeader(
          title: (pulse?.title ?? 'Education Community Pulse').toUpperCase(),
          actionText: pulse?.link?.text ?? '',
          secondActionText: "",
          onActionTap: () {},
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: Dimensions.w_12),

                  SizedBox(
                    width: Dimensions.h_90,
                    height: Dimensions.h_90,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ArcGaugeIndicator(
                          radius: Dimensions.h_40,
                          lineWidth: 10,
                          percent: ((pulse?.score ?? 0) / 100)
                              .clamp(0.0, 1.0)
                              .toDouble(),
                          progressColor: isLight
                              ? AppColor.townHallGreen
                              : AppColor.townHallGreenDark,
                          backgroundColor: Theme.of(context)
                              .highlightColor
                              .withValues(alpha: 0.18),
                          sweepAngle: 360,
                          startAngle: 0,
                        ),

                        Text(
                          '${pulse?.score ?? 0}%',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isLight
                                ? AppColor.townHallGreen
                                : AppColor.townHallGreenDark,
                            fontSize: FontSize.sp_20,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: Dimensions.w_12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pulse?.summary?.title ?? '',
                          style: TextStyle(
                            color: isLight
                                ? AppColor.townHallGreen
                                : AppColor.townHallGreenDark,
                            fontSize: FontSize.sp_16,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),

                        SizedBox(height: Dimensions.h_6),

                        Text(
                          pulse?.summary?.subtitle ?? '',
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: FontSize.sp_11,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_8),
              ...List.generate(metrics.length, (index) {
                final item = metrics[index];
                final stable = isStable(item);
                final positive = hasPositiveChange(item);
                return Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.w_10,
                    right: Dimensions.w_10,
                    bottom: index == metrics.length - 1
                        ? 0
                        : Dimensions.h_10,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimensions.w_20,
                        child: Icon(
                          getMetricIcon(item.icon),
                          color: getMetricIconColor(item.icon),
                          size: Dimensions.h_16,
                        ),
                      ),
                      SizedBox(width: Dimensions.w_5),
                      Expanded(
                        child: Text(
                          item.label ?? '',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: FontSize.sp_11,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.w_8),
                      SizedBox(
                        width: Dimensions.w_40,
                        child: Text(
                          (item.value ?? '').toUpperCase(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: stable
                                ? Theme.of(context).hintColor
                                : (isLight
                                ? AppColor.townHallGreen
                                : AppColor.townHallGreenDark),
                            fontSize: FontSize.sp_10,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),

                      SizedBox(width: Dimensions.w_15),

                      /// Arrow
                      if (!stable && positive)
                        Icon(
                          Icons.arrow_upward_outlined,
                          color: isLight
                              ? AppColor.townHallGreen
                              : AppColor.townHallGreenDark,
                          size: Dimensions.h_12,
                        ),

                      /// Change
                      SizedBox(
                        width: Dimensions.w_28,
                        child: Text(
                          (item.change ?? '')
                              .replaceAll('↑', '')
                              .trim(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: stable
                                ? Theme.of(context).hintColor
                                : (isLight
                                ? AppColor.townHallGreen
                                : AppColor.townHallGreenDark),
                            fontSize: FontSize.sp_11,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _divider(BuildContext context,bool isLight) {
    return Container(
      height: 0.5,
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.h_7,
      ),
      color: Theme.of(context)
          .primaryColor
          .withValues(alpha: isLight ? 0.12 : 0.18),
    );
  }

  Widget _actionItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color iconBackground,
    required bool isLight,

    String? points,
    Color? pointsColor,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Container(
          width: Dimensions.h_25,
          height: Dimensions.h_25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(Dimensions.h_7),
            border: Border.all(
              color: iconColor.withValues(alpha: 0.15),
            ),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: Dimensions.h_13,
          ),
        ),

        SizedBox(width: Dimensions.w_8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: Dimensions.h_3),

              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: FontSize.sp_8,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),

        if (trailing != null) ...[
          SizedBox(width: Dimensions.w_8),
          trailing,
        ] else if (points != null) ...[
          SizedBox(width: Dimensions.w_6),
          Text(
            points,
            style: TextStyle(
              color: pointsColor ??
                  (isLight
                      ? const Color(0xFF0D6B3F)
                      : const Color(0xFF4FC98A)),
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ],
      ],
    );
  }

  Widget _priorityBadge({
    required String label,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_8,
        vertical: Dimensions.h_4,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.h_6),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: FontSize.sp_8,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget firstCard(bool isLight) {
    final live = schoolController.educationData?.hero?.live;
    final items = live?.items ?? [];
    final link = live?.link;

    return CommonCard(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: Dimensions.w_4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        (live?.title ?? '').toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: Dimensions.h_5,
                          height: Dimensions.h_5,
                          decoration: BoxDecoration(
                            color: isLight
                                ? const Color(0xFF1FA85B)
                                : const Color(0xFF4FC98A),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: Dimensions.w_3),
                        Text(
                          live?.status?.toUpperCase() ?? '',
                          style: TextStyle(
                            color: isLight
                                ? const Color(0xFF1FA85B)
                                : const Color(0xFF4FC98A),
                            fontSize: FontSize.sp_10,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_10),
                ...List.generate(items.length, (index) {
                  final item = items[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.w_1,
                      bottom: index != items.length - 1 ? Dimensions.h_8 : 0),
                    child: CommonBulletItem(
                      text: item.text ?? '',
                      leadingIcon: _getLiveIcon(item.icon),
                      iconColor: Theme.of(context).primaryColorDark,
                      iconSize: Dimensions.h_15,
                    ),
                  );
                }),
                if (link != null) ...[
                  SizedBox(height: Dimensions.h_10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        link.text ?? '',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: FontSize.sp_9_5,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                      SizedBox(width: Dimensions.w_4),
                      Icon(
                        _getLinkIcon(link.icon),
                        color: Theme.of(context).primaryColorDark,
                        size: Dimensions.h_13,
                      ),
                      SizedBox(width: Dimensions.w_5),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: Dimensions.w_4),
        ],
      ),
    );
  }

  Widget aiBrief() {
    return CommonCard(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppCacheImage(imageUrl: "https://staging.wikixm.com${schoolController.educationData?.schoolRail?.aiBrief?.image ?? ''}",
              size: Dimensions.h_30,
              widthSize: Dimensions.h_30,
              isCircle: true,
              isShadow: false),
            SizedBox(width: Dimensions.w_5),
            Text(
              'AI EDUCATION BRIEF',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_12,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
            const Spacer(),
            Text(
              schoolController.educationData?.schoolRail?.aiBrief?.updated?.text  ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          ],),
          SizedBox(height: Dimensions.h_12),
          Padding(
            padding:  EdgeInsets.only(left: Dimensions.w_8),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: schoolController.educationData?.schoolRail?.aiBrief?.intro ?? '',
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                  TextSpan(
                    text: ' ${schoolController.educationData?.schoolRail?.aiBrief?.introHighlight ?? ''}',
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),
                  TextSpan(
                    text: ' across ${schoolController.educationData?.location?.name ?? ''}.',
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          Padding(
            padding:  EdgeInsets.only(left: Dimensions.w_8),
            child: Text(
              schoolController.educationData?.schoolRail?.aiBrief?.highlight ?? '',
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: FontSize.sp_10,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            )
          ),
          SizedBox(height: Dimensions.h_8),
          Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_8),
              child: Text(
                schoolController.educationData?.schoolRail?.aiBrief?.description ?? '',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              )
          ),
          SizedBox(height: Dimensions.h_10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                  'Ask AI About Our Schools',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w800,
                      height: 1)),
              SizedBox(width: Dimensions.w_4),
              Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColorDark,
                  size: Dimensions.h_13),
              SizedBox(width: Dimensions.w_15),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getLiveIcon(String? iconUrl) {
    final iconName = iconUrl?.split('#').last.toLowerCase() ?? '';

    switch (iconName) {
      case 'calendar':
        return CupertinoIcons.calendar;

      case 'clipboard':
        return CupertinoIcons.doc_on_clipboard;

      case 'user':
        return CupertinoIcons.person_2;

      case 'medal':
        return Icons.workspace_premium_outlined;

      case 'school':
        return CupertinoIcons.building_2_fill;

      case 'chat':
        return CupertinoIcons.chat_bubble_2;

      default:
        return CupertinoIcons.circle;
    }
  }

  IconData _getLinkIcon(String? iconName) {
    switch (iconName?.toLowerCase()) {
      case 'arrow':
        return Icons.arrow_forward;

      case 'chevron':
        return Icons.chevron_right;

      default:
        return Icons.arrow_forward;
    }
  }

  Widget buildHeroHeader(bool isLight, SchoolController controller) {
    final heroImage = controller.educationData?.hero?.image ?? '';
    final imageUrl = heroImage.isNotEmpty
        ? heroImage.startsWith('http')
        ? heroImage
        : 'https://staging.wikixm.com$heroImage'
        : 'https://preetis-html.vercel.app/assets/images/school/version2/pine-valley-school-campus-v3.webp';
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedWeatherImage(
          height: Dimensions.h_350,
          image: imageUrl,
        ),
        Positioned.fill(
          child: Container(
            height: Dimensions.h_350,
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
          height: Dimensions.h_350,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.w_8,
                ),
                child: Text(
                  controller.educationData?.hero?.greeting
                      ?.toUpperCase() ??
                      '',
                  style: TextStyle(
                    color: const Color(0xFFFFE47A),
                    fontSize: FontSize.sp_11,
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
                  left: Dimensions.w_5,
                  top: Dimensions.h_10,
                ),
                child: Text(
                  "${controller.educationData?.location?.name ?? ''}\n"
                      "Education Center",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_24,
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
                  top: Dimensions.h_10,
                  right: Dimensions.w_60,
                ),
                child: Text(
                  controller.educationData?.hero?.description ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w900,
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
              SizedBox(height: Dimensions.h_15),
              communityStatsSection(),
              SizedBox(height: Dimensions.h_10),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
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
    final stats = schoolController.educationData?.hero?.stats ?? [];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_5,
        vertical: Dimensions.h_5,
      ),
      child: Column(
        children: List.generate(
          (stats.length / 2).ceil(),
              (rowIndex) {
            final firstIndex = rowIndex * 2;
            final secondIndex = firstIndex + 1;

            return Padding(
              padding: EdgeInsets.only(
                bottom: rowIndex != (stats.length / 2).ceil() - 1
                    ? Dimensions.h_12
                    : 0,
              ),
              child: Row(
                children: [
                  _communityStatItem(
                    icon: _getCommunityStatIcon(
                      stats[firstIndex].icon,
                    ),
                    value: _formatStatValue(
                      stats[firstIndex].value,
                    ),
                    label: stats[firstIndex].label ?? '',
                  ),
                  if (secondIndex < stats.length) ...[
                    SizedBox(width: Dimensions.w_20),
                    Expanded(
                      child: _communityStatItem(
                        icon: _getCommunityStatIcon(
                          stats[secondIndex].icon,
                        ),
                        value: _formatStatValue(
                          stats[secondIndex].value,
                        ),
                        label: stats[secondIndex].label ?? '',
                      ),
                    ),
                  ] else
                    const Expanded(child: SizedBox()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatStatValue(dynamic value) {
    if (value == null) return '0';

    if (value is num) {
      final number = value.toInt();
      return number.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
            (match) => ',',
      );
    }

    return value.toString();
  }

  IconData _getCommunityStatIcon(String? iconUrl) {
    final iconName = iconUrl?.split('#').last.toLowerCase() ?? '';

    switch (iconName) {
      case 'school':
        return CupertinoIcons.building_2_fill;

      case 'users':
        return Icons.groups_outlined;

      case 'user':
        return CupertinoIcons.person_2;

      case 'chat':
        return CupertinoIcons.chat_bubble_2;

      case 'calendar':
        return CupertinoIcons.calendar;

      default:
        return CupertinoIcons.chart_bar;
    }
  }

  Widget _communityStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Color(0xFF8adfff),
          size: Dimensions.h_20,
        ),
        SizedBox(width: Dimensions.w_5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.sp_18,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
            SizedBox(height: Dimensions.h_2),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget upcomingEventsGrid(bool isLight) {
    final items = schoolController.educationData?.topPanels?.matters?.cards ?? [];

    Color getPriorityColor(String? className) {
      switch (className?.toLowerCase()) {
        case 'high':
          return const Color(0xFFD71945);

        case 'important':
          return const Color(0xFF0D6B3F);

        case 'medium':
          return const Color(0xFFB94705);

        default:
          return const Color(0xFF0754E8);
      }
    }

    String getFullImageUrl(String? image) {
      if (image == null || image.isEmpty) return '';
      if (image.startsWith('http')) {
        return image;
      }
      return 'https://staging.wikixm.com$image';
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Dimensions.w_8,
        mainAxisSpacing: Dimensions.h_8,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        final priorityColor = getPriorityColor(
          item.priority?.className,
        );

        return CommonCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.h_8),
                      topRight: Radius.circular(Dimensions.h_8),
                    ),
                    child: AppCacheImage(
                      imageUrl: getFullImageUrl(item.image),
                      size: Dimensions.h_115,
                      widthSize: Get.width,
                      radius: 0,
                      isShadow: false,
                    ),
                  ),
                  Positioned(
                    left: Dimensions.w_8,
                    top: Dimensions.h_5,
                    child: Container(
                      width: Dimensions.h_18,
                      height: Dimensions.h_18,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.primaryNavyNew,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${item.rank ?? ''}',
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w900,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                  if (item.priority != null)
                    Positioned(
                      right: Dimensions.w_7,
                      top: Dimensions.h_7,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_6,
                          vertical: Dimensions.h_3,
                        ),
                        decoration: BoxDecoration(
                          color: priorityColor,
                          border: Border.all(
                            color: priorityColor.withValues(alpha: 0.60),
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          (item.priority?.label ?? '').toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_7,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w_8,
                    vertical: Dimensions.h_7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: FontSize.sp_12,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_5),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_6,
                          vertical: Dimensions.h_4,
                        ),
                        decoration: BoxDecoration(
                          color: isLight
                              ? const Color(0xFFf2f6fd)
                              : const Color(0xFF102844),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item.topic ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isLight
                                ? const Color(0xFF0754e8)
                                : const Color(0xFF82b4ff),
                            fontSize: FontSize.sp_9,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding:  EdgeInsets.only(left: Dimensions.w_2),
                        child: Text(
                          '${item.comments ?? 0} comments · '
                              '${item.readTime ?? 0} min read',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isLight
                                ? Theme.of(context).highlightColor
                                : const Color(0xFFc0ccdd),
                            fontSize: FontSize.sp_9_5,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget schoolsHorizontalList(bool isLight) {
    final browse = schoolController.educationData?.midPanels?.browse;
    final schools = browse?.schools ?? [];

    String getFullImageUrl(String? image) {
      if (image == null || image.isEmpty) return '';

      if (image.startsWith('http')) return image;

      return 'https://staging.wikixm.com$image';
    }

    IconData getSchoolIcon(String? iconUrl) {
      final iconName =
          iconUrl?.split('#').last.toLowerCase() ?? '';

      switch (iconName) {
        case 'eagle-head':
          return Icons.rocket_launch_rounded;

        case 'school':
          return Icons.school_rounded;

        case 'paw':
          return Icons.group_rounded;

        case 'book':
          return Icons.menu_book_outlined;

        case 'landmark':
          return Icons.account_balance_outlined;

        default:
          return Icons.school_rounded;
      }
    }

    final selectedFilter = schoolController.selectedSchoolFilter;

    final filteredSchools = selectedFilter == 'all'
        ? schools
        : schools.where((school) {
      return school.type == selectedFilter;
    }).toList();
    final showViewAll = selectedFilter == 'all';

    return SizedBox(
      height: Dimensions.h_160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: filteredSchools.length + (showViewAll ? 1 : 0),
        separatorBuilder: (context, index) =>
            SizedBox(width: Dimensions.w_8),
        itemBuilder: (context, index) {
          if (showViewAll && index == filteredSchools.length) {
            return _buildViewAllSchoolsCard(isLight);
          }
          if (index >= filteredSchools.length) {
            return const SizedBox();
          }
          final item = filteredSchools[index];

          return SizedBox(
            width: Dimensions.w_120,
            child: CommonCard(
              padding: EdgeInsets.zero,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.h_70,
                    width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              Dimensions.h_8,
                            ),
                            topRight: Radius.circular(
                              Dimensions.h_8,
                            ),
                          ),
                          child: AppCacheImage(
                            imageUrl: getFullImageUrl(item.image),
                            size: Dimensions.h_70,
                            widthSize: Dimensions.w_120,
                            radius: 0,
                            isShadow: false,
                          ),
                        ),
                        Positioned(
                          left: Dimensions.w_10,
                          bottom: -Dimensions.h_12,
                          child: Container(
                            width: Dimensions.h_25,
                            height: Dimensions.h_25,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(
                                    alpha: 0.12,
                                  ),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Icon(
                              getSchoolIcon(item.icon),
                              size: Dimensions.h_13,
                              color: const Color(0xFF244D8D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.w_10,
                        Dimensions.h_20,
                        Dimensions.w_10,
                        Dimensions.h_8,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color:
                              Theme.of(context).primaryColor,
                              fontSize: FontSize.sp_12,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            item.grades ?? '',
                            style: TextStyle(
                              color: isLight
                                  ? Theme.of(context)
                                  .highlightColor
                                  : const Color(0xFF9DABC0),
                              fontSize: FontSize.sp_9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: Dimensions.h_3),
                          Text(
                            '${item.students ?? 0} students',
                            style: TextStyle(
                              color: isLight
                                  ? Theme.of(context)
                                  .highlightColor
                                  : const Color(0xFF9DABC0),
                              fontSize: FontSize.sp_9,
                              fontWeight: FontWeight.w500,
                            ),
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
    );
  }
  Widget _buildViewAllSchoolsCard(bool isLight) {
    return SizedBox(
      width: Dimensions.w_110,
      child: CommonCard(
        padding: EdgeInsets.zero,
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimensions.h_8),
          onTap: () {
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.grid_view_rounded,
                color: Theme.of(context).primaryColorDark,
                size: Dimensions.h_25,
              ),

              SizedBox(height: Dimensions.h_8),

              Text(
                'View All',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '14 Schools',
                style: TextStyle(
                  color: isLight
                      ? Theme.of(Get.context!).highlightColor
                      : const Color(0xFF9DABC0),
                  fontSize: FontSize.sp_9_5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


