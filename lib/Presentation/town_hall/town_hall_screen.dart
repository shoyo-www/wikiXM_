import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wikixm/Presentation/events/events_screen_shimmer.dart';
import 'package:wikixm/Presentation/town_hall/controller.dart';
import 'package:wikixm/Presentation/widgets/circular_percent.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/data/datasource/local/local_storage.dart';
import '../../constants/constants.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../../data/datasource/remote/models/response/town_hall_response.dart';
import '../widgets/bill_widget.dart';
import '../widgets/cache_image.dart';
import '../widgets/drawer/src/slider_drawer.dart';
import '../widgets/town_hall_drawer.dart';

class TownHallScreen extends StatefulWidget {
  const TownHallScreen({super.key});

  @override
  State<TownHallScreen> createState() => _TownHallScreenState();
}

class _TownHallScreenState extends State<TownHallScreen> {
  final GlobalKey<SliderDrawerState> sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  final TownHallController townHallController = Get.put(TownHallController());

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return SliderDrawer(
      key: sliderDrawerKey,
      sliderOpenSize: 300,
      isDraggable: false,
      slider: CommonSliderDrawer(
        isLight: isLight,
        onDashboard: () {},
        onProjects: () {},
        onDiscussions: () {},
        onRepresentatives: () {},
        onMeetings: () {},
        onTransparency: () {},
        onLearn: () {},
        onClose: () {
          sliderDrawerKey.currentState?.closeSlider();
        },
        onAllLevels: () {},
        onCity: () {},
        onCounty: () {},
        onState: () {},
        onFederal: () {},
      ),
      child: AppScaffold(
        top: false,
        bottom: false,
        isNavbar: true,
        bodyPadding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: GetBuilder(
          init: townHallController,
          id: ControllerBuilders.townHallController,
          builder: (controller) {
            return controller.isLoading
                ? EventsScreenShimmer()
                : CommonScrollBlurScaffold(
                    isDrawer: true,
                    onTap: () {
                      sliderDrawerKey.currentState?.openSlider();
                    },
                    expandedHeight: Dimensions.h_210,
                    expandedColor: isLight ? Colors.black : Colors.white,
                    collapsedColor: Theme.of(context).highlightColor,
                    hero: buildHeroHeader(isLight, controller),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              firstCard(isLight, controller),
                              SizedBox(height: Dimensions.h_8),
                              aiBriefCard(isLight),
                              SizedBox(height: Dimensions.h_10),
                              LegislativeBillsSection(
                                isLight: isLight,
                                bills: controller.townHallData?.bills,
                              ),
                              SizedBox(height: Dimensions.h_15),
                              nextTownHallMeeting(
                                context,
                                isLight,
                                controller.townHallData?.nextMeeting,
                              ),
                              SizedBox(height: Dimensions.h_10),
                              topPriorities(context, isLight),
                              SizedBox(height: Dimensions.h_15),
                              representativeScorecard(context),
                              SizedBox(height: Dimensions.h_15),
                              engagement(context, isLight),
                              SizedBox(height: Dimensions.h_15),
                              projects(context, isLight),
                              SizedBox(height: Dimensions.h_15),
                              transparency(isLight, context),
                              SizedBox(height: Dimensions.h_10),
                              communitySentimentWidget(isLight),
                              SizedBox(height: Dimensions.h_15),
                              communityPoll(context, isLight),
                              SizedBox(height: Dimensions.h_10),
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
                  );
          },
        ),
      ),
    );
  }

  Widget communityPoll(BuildContext context, bool isLight) {
    final pollData =
        townHallController.townHallData?.communityOverview?.stats?.poll;

    final options = pollData?.options ?? [];
    final footer = pollData?.footer;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                pollData?.title ?? '',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    pollData?.viewAll?.text ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_10,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pollData?.question ?? '',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == options.length - 1 ? 0 : Dimensions.h_5,
                    ),
                    child: _pollOption(
                      title: option.name ?? '',
                      percentage: option.percentage ?? 0,
                      isLight: isLight,
                    ),
                  );
                },
              ),
              SizedBox(height: Dimensions.h_10),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${footer?.votesCast ?? 0} ',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: FontSize.sp_10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: 'votes cast',
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: FontSize.sp_10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: Dimensions.h_25,
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_12,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.darkBlue,
                        borderRadius: BorderRadius.circular(Dimensions.h_6),
                      ),
                      child: Text(
                        footer?.voteAction?.text ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_10,
                          fontWeight: FontWeight.w800,
                          height: 1,
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
    );
  }

  Widget transparency(bool isLight, BuildContext context) {
    final transparencyData =
        townHallController.townHallData?.communityOverview?.stats?.transparency;
    final metrics = transparencyData?.metrics ?? [];
    final overall = transparencyData?.overall;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                transparencyData?.title ?? '',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    transparencyData?.viewDashboard?.text ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_10,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: metrics.length,
                itemBuilder: (context, index) {
                  final metric = metrics[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == metrics.length - 1 ? 0 : Dimensions.h_7,
                    ),
                    child: _transparencyItem(
                      title: metric.name ?? '',
                      percentage: metric.percentage ?? 0,
                      isLight: isLight,
                    ),
                  );
                },
              ),
              SizedBox(height: Dimensions.h_10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_8,
                  vertical: Dimensions.h_4,
                ),
                decoration: BoxDecoration(
                  color: AppColor.townHallGreen.withValues(
                    alpha: isLight ? 0.08 : 0.16,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.h_6),
                ),
                child: Row(
                  children: [
                    Container(
                      width: Dimensions.w_28,
                      height: Dimensions.h_28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isLight
                            ? AppColor.townHallGreen.withValues(alpha: 0.12)
                            : AppColor.townHallGreenDark.withValues(
                                alpha: 0.12,
                              ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        CupertinoIcons.shield_fill,
                        color: isLight
                            ? AppColor.townHallGreen
                            : AppColor.townHallGreenDark,
                        size: Dimensions.h_15,
                      ),
                    ),
                    SizedBox(width: Dimensions.w_6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overall?.label ?? '',
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: FontSize.sp_9_5,
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: Dimensions.h_5),
                          Text(
                            overall?.status ?? '',
                            style: TextStyle(
                              color: isLight
                                  ? AppColor.townHallGreen
                                  : AppColor.townHallGreenDark,
                              fontSize: FontSize.sp_10,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${overall?.percentage ?? 0}%',
                      style: TextStyle(
                        color: isLight
                            ? AppColor.townHallGreen
                            : AppColor.townHallGreenDark,
                        fontSize: FontSize.sp_18,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
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

  Widget projects(BuildContext context, bool isLight) {
    final projectsData =
        townHallController.townHallData?.communityOverview?.stats?.projects;
    final projectItems = projectsData?.projects ?? [];
    final totals = projectsData?.totals;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                projectsData?.title ?? '',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    projectsData?.viewAll?.text ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_10,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${totals?.activeProjects ?? 0}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: FontSize.sp_18,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: Dimensions.h_3),
                        Text(
                          'Active Projects',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: FontSize.sp_9_5,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${totals?.totalParticipants ?? 0}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: FontSize.sp_18,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: Dimensions.h_3),
                        Text(
                          'Total Participants',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: FontSize.sp_9_5,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    totals?.delta?.text ?? '',
                    style: TextStyle(
                      color: isLight
                          ? AppColor.townHallGreen
                          : AppColor.townHallGreenDark,
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: projectItems.length,
                itemBuilder: (context, index) {
                  final project = projectItems[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == projectItems.length - 1
                          ? 0
                          : Dimensions.h_6,
                    ),
                    child: _projectItem(
                      title: project.name ?? '',
                      percentage: project.percentage ?? 0,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget engagement(BuildContext context, bool isLight) {
    final engagementData =
        townHallController.townHallData?.communityOverview?.engagement;

    final items = engagementData?.items ?? [];

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                engagementData?.title ?? '',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    engagementData?.viewAll?.text ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_10,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final isLast = index == items.length - 1;

              Widget activity;

              if (item.image?.src != null && item.image!.src!.isNotEmpty) {
                activity = _activityItem(
                  avatar: AppCacheImage(
                    imageUrl: item.image!.src!,
                    size: Dimensions.h_25,
                    widthSize: Dimensions.h_25,
                    isShadow: false,
                    isCircle: true,
                  ),
                  avatarColor: AppColor.darkBlue,
                  name: item.name ?? '',
                  parts: item.parts ?? [],
                  time: item.time ?? '',
                );
              } else if (index == 2) {
                activity = _activityItem(
                  avatar: Icon(
                    CupertinoIcons.house_fill,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_15,
                  ),
                  avatarColor: isLight
                      ? Theme.of(
                          context,
                        ).primaryColorDark.withValues(alpha: 0.10)
                      : AppColor.darkBlue,
                  name: '',
                  parts: item.parts ?? [],
                  time: item.time ?? '',
                );
              } else {
                activity = _activityItem(
                  avatar: Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_15,
                  ),
                  avatarColor: isLight
                      ? Theme.of(
                          context,
                        ).primaryColorDark.withValues(alpha: 0.10)
                      : AppColor.darkBlue,
                  name: '',
                  parts: item.parts ?? [],
                  time: item.time ?? '',
                );
              }

              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : Dimensions.h_8),
                child: activity,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget representativeScorecard(BuildContext context) {
    final representativesData =
        townHallController.townHallData?.communityOverview?.representatives;
    final representatives = representativesData?.representatives ?? [];
    final filters = representativesData?.filters ?? [];

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                representativesData?.title ?? '',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    representativesData?.rankingsLink?.text ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(
                    CupertinoIcons.info_circle,
                    size: Dimensions.h_10,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.h_22,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == filters.length - 1 ? 0 : Dimensions.w_4,
                      ),
                      child: SizedBox(
                        width: Dimensions.w_65,
                        child: _scoreFilter(
                          title: filter.label ?? '',
                          isSelected: filter.active ?? false,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              Row(
                children: [
                  SizedBox(
                    width: Dimensions.w_28,
                    child: Text(
                      representativesData?.table?.rank ?? 'RANK',
                      style: _tableHeaderStyle(),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      representativesData?.table?.representative ??
                          'REPRESENTATIVE',
                      style: _tableHeaderStyle(),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.w_40,
                    child: Text(
                      representativesData?.table?.level ?? 'LEVEL',
                      style: _tableHeaderStyle(),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.w_32,
                    child: Text(
                      '${representativesData?.table?.score ?? 'SCORE'} '
                      '${representativesData?.table?.scoreSuffix ?? ''}',
                      style: _tableHeaderStyle(),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_5),
                  SizedBox(
                    width: Dimensions.w_60,
                    child: Text(
                      representativesData?.table?.confidence ?? 'CONFIDENCE',
                      style: _tableHeaderStyle(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_8),
              Container(
                height: 1,
                width: Get.width,
                color: Theme.of(context).focusColor,
              ),
              SizedBox(height: Dimensions.h_5),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: representatives.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return _representativeRow(
                    representative: representatives[index],
                  );
                },
              ),
              SizedBox(height: Dimensions.h_8),
              GestureDetector(
                onTap: () {},
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        representativesData?.footer?.text ?? '',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: FontSize.sp_9_5,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                      SizedBox(width: Dimensions.w_4),
                      Icon(
                        Icons.arrow_forward,
                        size: Dimensions.h_11,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget topPriorities(BuildContext context, bool isLight) {
    final priorities =
        townHallController.townHallData?.communityOverview?.priorities;

    final items = priorities?.items ?? [];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  priorities?.title ?? '',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: FontSize.sp_13_5,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      priorities?.viewAll?.text ?? '',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: FontSize.sp_9,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: Dimensions.w_2),
                    Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).primaryColorDark,
                      size: Dimensions.h_10,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          ...List.generate(items.length, (index) {
            final item = items[index];

            final colors = [
              const Color(0xFF157a4c),
              const Color(0xFF2563eb),
              const Color(0xFFb092ff),
              const Color(0xFFb8480a),
              const Color(0xFF3fb8ab),
            ];

            final color =
                colors[index < colors.length ? index : colors.length - 1];

            final percentage = item.percentage ?? 0;

            return Column(
              children: [
                _priorityItem(
                  rank: '${item.rank ?? index + 1}',
                  title: item.name ?? '',
                  percentage: '$percentage%',
                  label: 'Support',
                  progress: percentage / 100,
                  isLight: isLight,
                  color: color,
                ),
                if (index != items.length - 1) SizedBox(height: Dimensions.h_8),
              ],
            );
          }),
          SizedBox(height: Dimensions.h_15),
          Row(
            children: [
              Text(
                '${priorities?.participants?.count ?? 0}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              SizedBox(width: Dimensions.w_4),
              Text(
                priorities?.participants?.label ?? '',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: FontSize.sp_9_5,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget nextTownHallMeeting(
    BuildContext context,
    bool isLight,
    NextMeeting? nextMeeting,
  ) {
    final kicker = nextMeeting?.kicker;
    final date = nextMeeting?.date;
    final meta = nextMeeting?.meta ?? [];
    final glance = nextMeeting?.glance;
    final glanceItems = glance?.items ?? [];
    final qualification = nextMeeting?.qualification;
    final requirements = qualification?.requirements;
    final qualificationStatus = qualification?.status;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                kicker?.text ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isLight
                      ? AppColor.townHallGreen
                      : AppColor.townHallGreenDark,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ),
            if (kicker?.badge != null && kicker!.badge!.isNotEmpty) ...[
              SizedBox(width: Dimensions.w_5),
              Container(
                margin: EdgeInsets.only(left: Dimensions.w_4),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_5,
                  vertical: Dimensions.h_3,
                ),
                decoration: BoxDecoration(
                  color: isLight
                      ? AppColor.townHallGreen
                      : AppColor.townHallGreenDark,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  kicker.badge!,
                  style: TextStyle(
                    color: !isLight ? AppColor.black : AppColor.white,
                    fontSize: FontSize.sp_8,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    height: 1,
                  ),
                ),
              ),
            ],
          ],
        ),
        CommonCard(
          margin: EdgeInsets.only(top: Dimensions.h_10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: Dimensions.h_70,
                    height: Dimensions.h_80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.h_6),
                      border: Border.all(color: Theme.of(context).focusColor),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.h_5,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.h_6),
                          ),
                          child: Text(
                            date?.day ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: FontSize.sp_8,
                              fontWeight: FontWeight.w800,
                              height: 1,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.h_5,
                          ),
                          color: const Color(0xFFED1C24),
                          child: Text(
                            date?.month ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.sp_10,
                              fontWeight: FontWeight.w800,
                              height: 1,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              '${date?.number ?? ''}'.padLeft(2, '0'),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: FontSize.sp_26,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ),
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
                          nextMeeting?.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: FontSize.sp_14,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                          ),
                        ),
                        SizedBox(height: Dimensions.h_10),
                        if (meta.isNotEmpty)
                          _meetingMeta(
                            context,
                            icon: CupertinoIcons.clock,
                            text: meta[0].text ?? '',
                          ),
                        if (meta.length > 1) ...[
                          SizedBox(height: Dimensions.h_4),
                          _meetingMeta(
                            context,
                            icon: CupertinoIcons.chat_bubble,
                            text: meta[1].text ?? '',
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_10),
              Text(
                nextMeeting?.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: FontSize.sp_9_5,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              Row(
                children: [
                  if (nextMeeting?.actions?.agenda != null)
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: Dimensions.h_28,
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_20,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isLight
                              ? AppColor.townHallGreen
                              : AppColor.townHallGreenDark,
                          borderRadius: BorderRadius.circular(Dimensions.h_6),
                        ),
                        child: Text(
                          nextMeeting?.actions?.agenda?.text ?? '',
                          style: TextStyle(
                            color: isLight ? Colors.white : AppColor.black,
                            fontSize: FontSize.sp_9_5,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  if (nextMeeting?.actions?.attend != null) ...[
                    SizedBox(width: Dimensions.w_6),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: Dimensions.h_28,
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_20,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.h_6),
                          border: Border.all(
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                        child: Text(
                          nextMeeting?.actions?.attend?.text ?? '',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: FontSize.sp_9_5,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: Dimensions.h_10),
                height: 0.1,
                width: Get.width,
                color: Theme.of(context).highlightColor,
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            glance?.title ?? '',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: FontSize.sp_10,
                              fontWeight: FontWeight.w800,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: Dimensions.h_10),
                          ...List.generate(glanceItems.length, (index) {
                            final item = glanceItems[index];

                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index == glanceItems.length - 1
                                    ? 0
                                    : Dimensions.h_4,
                              ),
                              child: _glanceItem(
                                context,
                                icon: _glanceIcon(index),
                                text: item.text ?? '',
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: Dimensions.w_4),
                      height: Dimensions.h_100,
                      width: 0.1,
                      color: Theme.of(context).highlightColor,
                    ),
                    SizedBox(width: Dimensions.w_4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            qualification?.title ?? '',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: FontSize.sp_10,
                              fontWeight: FontWeight.w800,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: Dimensions.h_10),
                          Row(
                            children: [
                              Stack(
                                children: [
                                  ArcGaugeIndicator(
                                    radius: Dimensions.h_30,
                                    lineWidth: 10,
                                    percent:
                                        ((qualification?.progress ?? 0).clamp(
                                          0,
                                          100,
                                        )) /
                                        100,
                                    progressColor: isLight
                                        ? AppColor.townHallGreen
                                        : AppColor.townHallGreenDark,
                                    backgroundColor: Colors.grey,
                                    sweepAngle: 360,
                                    startAngle: 0,
                                  ),
                                  Positioned(
                                    top: Dimensions.h_25,
                                    left: 0,
                                    right: 0,
                                    child: Text(
                                      '${qualification?.progress ?? 0}%',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: isLight
                                            ? AppColor.townHallGreen
                                            : AppColor.townHallGreenDark,
                                        fontSize: FontSize.sp_12,
                                        fontWeight: FontWeight.w700,
                                        height: 1.05,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: Dimensions.w_8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${requirements?.completed ?? 0} of ${requirements?.total ?? 0}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: FontSize.sp_12,
                                      fontWeight: FontWeight.w800,
                                      height: 1,
                                    ),
                                  ),
                                  Text(
                                    'requirements met',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: FontSize.sp_9_5,
                                      fontWeight: FontWeight.w500,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          if (qualification?.closeText != null) ...[
                            SizedBox(height: Dimensions.h_5),
                            Text(
                              qualification!.closeText!,
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: FontSize.sp_8,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                          SizedBox(height: Dimensions.h_5),
                          if (qualificationStatus != null)
                            Container(
                              margin: EdgeInsets.only(left: Dimensions.w_2),
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.w_5,
                                vertical: Dimensions.h_3,
                              ),
                              decoration: BoxDecoration(
                                color: isLight
                                    ? const Color(0xFFeaf3ed)
                                    : const Color(0xFF12281d),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.check_mark_circled_solid,
                                    color: isLight
                                        ? AppColor.townHallGreen
                                        : AppColor.townHallGreenDark,
                                    size: Dimensions.h_10,
                                  ),
                                  SizedBox(width: Dimensions.w_8),
                                  Flexible(
                                    child: Text(
                                      qualificationStatus.text ?? '',
                                      style: TextStyle(
                                        color: isLight
                                            ? AppColor.townHallGreen
                                            : AppColor.townHallGreenDark,
                                        fontSize: FontSize.sp_8,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.5,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
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

  Widget _meetingMeta(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColorDark,
          size: Dimensions.h_13,
        ),
        SizedBox(width: Dimensions.w_4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: FontSize.sp_9_5,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _glanceItem(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: Dimensions.h_16,
          height: Dimensions.h_16,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColorDark.withValues(alpha: 0.15),
            ),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColorDark,
            size: Dimensions.h_10,
          ),
        ),
        SizedBox(width: Dimensions.w_4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: FontSize.sp_8_5,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }

  IconData _glanceIcon(int index) {
    switch (index) {
      case 0:
        return CupertinoIcons.search;
      case 1:
        return CupertinoIcons.person_add;
      case 2:
        return CupertinoIcons.person_2_fill;
      case 3:
        return CupertinoIcons.calendar;
      default:
        return CupertinoIcons.circle_fill;
    }
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
        sliderDrawerKey.currentState?.closeSlider();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w_10,
          vertical: Dimensions.h_10,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: Dimensions.h_18,
            ),

            SizedBox(width: Dimensions.w_8),

            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _tableHeaderStyle() {
    return TextStyle(
      color: Theme.of(context).hintColor,
      fontSize: FontSize.sp_8_5,
      fontWeight: FontWeight.w500,
      height: 1,
    );
  }

  Widget _scoreFilter({required String title, bool isSelected = false}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: Dimensions.h_22,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.darkBlue
              : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.h_5),
          border: isSelected
              ? null
              : Border.all(color: Theme.of(context).focusColor),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Theme.of(context).primaryColor,
            fontSize: FontSize.sp_9_5,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),
    );
  }

  Widget communitySentimentWidget(bool isLight) {
    final sentimentData =
        townHallController.townHallData?.communityOverview?.stats?.sentiment;

    final sentiments = sentimentData?.sentiments ?? [];
    final overall = sentimentData?.overall;

    Color getSentimentColor(String label) {
      switch (label.toLowerCase()) {
        case 'positive':
          return isLight ? const Color(0xFF0F7A44) : const Color(0xFF4FC98A);
        case 'neutral':
          return isLight ? const Color(0xFFf09708) : const Color(0xFFf5b13d);
        case 'negative':
          return isLight ? const Color(0xFFe5231f) : const Color(0xFFd93643);
        default:
          return Theme.of(context).primaryColor;
      }
    }

    final chartData = sentiments.map((sentiment) {
      final label = sentiment.label ?? '';

      return ChartData(
        x: label,
        y: sentiment.percentage?.toDouble() ?? 0,
        color: getSentimentColor(label),
      );
    }).toList();

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sentimentData?.title ?? '',
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: FontSize.sp_13_5,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          SizedBox(height: Dimensions.h_12),
          Row(
            children: [
              SizedBox(
                width: Dimensions.h_80,
                height: Dimensions.h_80,
                child: SfCircularChart(
                  margin: EdgeInsets.zero,
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData, String>(
                      dataSource: chartData,
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      innerRadius: '62%',
                      radius: '100%',
                      strokeWidth: 0,
                      animationDuration: 800,
                    ),
                  ],
                ),
              ),
              SizedBox(width: Dimensions.w_15),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: sentiments.length,
                  itemBuilder: (context, index) {
                    final sentiment = sentiments[index];

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == sentiments.length - 1
                            ? 0
                            : Dimensions.h_8,
                      ),
                      child: _sentimentLegend(
                        color: getSentimentColor(sentiment.label ?? ''),
                        title: sentiment.label ?? '',
                        value: '${sentiment.percentage ?? 0}%',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_15),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w_8,
              vertical: Dimensions.h_8,
            ),
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(Dimensions.h_8),
            ),
            child: Row(
              children: [
                Text(
                  overall?.label ?? '',
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_9_5,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: isLight
                      ? const Color(0xFF10783F)
                      : const Color(0xFF56CF90),
                  size: Dimensions.h_12,
                ),
                SizedBox(width: Dimensions.w_4),
                Text(
                  overall?.value ?? '',
                  style: TextStyle(
                    color: isLight
                        ? const Color(0xFF10783F)
                        : const Color(0xFF56CF90),
                    fontSize: FontSize.sp_9_5,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sentimentLegend({
    required Color color,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: Dimensions.w_12,
          height: Dimensions.w_12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: Dimensions.w_6),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: FontSize.sp_9_5,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontSize: FontSize.sp_9_5,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget _representativeRow({required Representative representative}) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;

    final rank = '${representative.rank ?? ''}';
    final name = representative.name ?? '';
    final role = representative.role ?? '';
    final level = representative.level ?? '';
    final score = '${representative.score ?? ''}';
    final confidence = representative.confidence ?? '';
    final imageUrl = representative.image?.src ?? '';

    Color levelTextColor;
    Color levelBgColor;

    switch (level) {
      case 'City':
        levelTextColor = isLight
            ? const Color(0xFF0F7A3D)
            : const Color(0xFF4CC98B);

        levelBgColor = isLight
            ? const Color(0xFFE8F3EC)
            : const Color(0xFF102B1F);
        break;

      case 'County':
        levelTextColor = isLight
            ? const Color(0xFF3341D8)
            : const Color(0xFF7F95FF);

        levelBgColor = isLight
            ? const Color(0xFFE5ECFE)
            : const Color(0xFF111D3A);
        break;

      case 'State':
        levelTextColor = isLight
            ? const Color(0xFF6D28E0)
            : const Color(0xFFB092FF);

        levelBgColor = isLight
            ? const Color(0xFFECE6FD)
            : const Color(0xFF241D47);
        break;

      case 'Federal':
        levelTextColor = isLight
            ? const Color(0xFF12246E)
            : const Color(0xFF9FBDFF);

        levelBgColor = isLight
            ? const Color(0xFFE5ECFE)
            : const Color(0xFF111D3A);
        break;

      default:
        levelTextColor = Theme.of(context).primaryColorDark;
        levelBgColor = Theme.of(context).highlightColor.withValues(alpha: 0.10);
    }

    Color confidenceTextColor;
    Color confidenceBgColor;

    switch (confidence) {
      case 'High':
        confidenceTextColor = isLight
            ? const Color(0xFF10783F)
            : const Color(0xFF56CF90);

        confidenceBgColor = isLight
            ? const Color(0xFFE8F3EC)
            : const Color(0xFF102B1F);
        break;

      case 'Medium':
        confidenceTextColor = isLight
            ? const Color(0xFFB94705)
            : const Color(0xFFFFA761);

        confidenceBgColor = isLight
            ? const Color(0xFFFDEADA)
            : const Color(0xFF3D2411);
        break;

      case 'Low':
        confidenceTextColor = isLight
            ? const Color(0xFFD81324)
            : const Color(0xFFFF8A92);

        confidenceBgColor = isLight
            ? const Color(0xFFFDE7E9)
            : const Color(0xFF3A1720);
        break;

      default:
        confidenceTextColor = Theme.of(context).highlightColor;
        confidenceBgColor = Theme.of(
          context,
        ).highlightColor.withValues(alpha: 0.10);
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Theme.of(context).focusColor),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: Dimensions.w_15,
            child: Center(
              child: Text(
                rank,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_10),
          AppCacheImage(
            imageUrl: imageUrl,
            size: Dimensions.h_25,
            widthSize: Dimensions.h_25,
            isShadow: false,
            isCircle: true,
          ),
          SizedBox(width: Dimensions.w_10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
                SizedBox(height: Dimensions.h_2),
                Text(
                  role,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: FontSize.sp_9,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: Dimensions.w_45,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_5,
                  vertical: Dimensions.h_3,
                ),
                decoration: BoxDecoration(
                  color: levelBgColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  level,
                  style: TextStyle(
                    color: levelTextColor,
                    fontSize: FontSize.sp_9_5,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_5),
          SizedBox(
            width: Dimensions.w_32,
            child: Text(
              score,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_15),
          SizedBox(
            width: Dimensions.w_45,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.h_3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: confidenceBgColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                confidence,
                style: TextStyle(
                  color: confidenceTextColor,
                  fontSize: FontSize.sp_9_5,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pollOption({
    required String title,
    required int percentage,
    required bool isLight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isLight ? AppColor.darkBlue : const Color(0xFF4B8BFF),
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
            SizedBox(width: Dimensions.w_4),
            Text(
              '$percentage%',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_9_5,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_3),
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: double.infinity,
              height: Dimensions.h_2,
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: constraints.maxWidth * (percentage / 100),
                  height: Dimensions.h_2,
                  decoration: BoxDecoration(
                    color: isLight
                        ? AppColor.darkBlue
                        : const Color(0xFF4B8BFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _transparencyItem({
    required String title,
    required int percentage,
    required bool isLight,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.w_6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_10,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_5),
          SizedBox(
            width: Dimensions.w_100,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: Dimensions.h_3,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).highlightColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: constraints.maxWidth * (percentage / 100),
                      height: Dimensions.h_3,
                      decoration: BoxDecoration(
                        color: isLight
                            ? AppColor.townHallGreen
                            : AppColor.townHallGreenDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: Dimensions.w_5),
          SizedBox(
            width: Dimensions.w_23,
            child: Text(
              '$percentage%',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _projectItem({required String title, required int percentage}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.sp_9_5,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_4),
              Text(
                '$percentage%',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_9_5,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: Get.width,
                height: Dimensions.h_3,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).highlightColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: constraints.maxWidth * (percentage / 100),
                    height: Dimensions.h_3,
                    decoration: BoxDecoration(
                      color: AppColor.darkBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _activityItem({
    required Widget avatar,
    required Color avatarColor,
    required String name,
    required List<Part> parts,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Dimensions.h_25,
          height: Dimensions.h_25,
          decoration: BoxDecoration(color: avatarColor, shape: BoxShape.circle),
          child: Center(child: avatar),
        ),
        SizedBox(width: Dimensions.w_7),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                if (name.isNotEmpty)
                  TextSpan(
                    text: '$name ',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ...parts.map(
                  (part) => TextSpan(
                    text: part.text ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_9_5,
                      fontWeight: part.bold == true
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: Dimensions.w_5),
        Text(
          time,
          style: TextStyle(
            color: Theme.of(context).primaryColorDark.withValues(alpha: 0.5),
            fontSize: FontSize.sp_8,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _priorityItem({
    required String rank,
    required String title,
    required String percentage,
    required String label,
    required double progress,
    required Color color,
    required bool isLight,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.w_8),
      child: Row(
        children: [
          Container(
            width: Dimensions.w_20,
            height: Dimensions.w_20,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Text(
              rank,
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_5),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_10,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_4),
          Text(
            percentage,
            style: TextStyle(
              color: isLight
                  ? AppColor.townHallGreen
                  : AppColor.townHallGreenDark,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          SizedBox(width: Dimensions.w_2),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: FontSize.sp_9,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
          SizedBox(width: Dimensions.w_8),
          SizedBox(
            width: Dimensions.w_40,
            height: Dimensions.h_4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: Theme.of(
                      context,
                    ).highlightColor.withValues(alpha: 0.12),
                  ),
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(color: color),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget firstCard(bool isLight, TownHallController controller) {
    final impact = controller.townHallData?.hero?.impact;
    final topItems = impact?.top ?? [];
    final bottomItems = impact?.bottom ?? [];

    String formatUpdatedAt(String? dateTime) {
      if (dateTime == null || dateTime.isEmpty) return '';

      final date = DateTime.tryParse(dateTime);
      if (date == null) return '';

      final hour = date.hour > 12
          ? date.hour - 12
          : (date.hour == 0 ? 12 : date.hour);
      final minute = date.minute.toString().padLeft(2, '0');
      final period = date.hour >= 12 ? 'PM' : 'AM';
      return 'Updated $hour:$minute $period';
    }

    return CommonCard(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_1,
        vertical: Dimensions.h_5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: Dimensions.w_4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.h_4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        impact?.title ?? 'COMMUNITY IMPACT AT A GLANCE',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: FontSize.sp_13_5,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                    ),
                    Text(
                      formatUpdatedAt(impact?.updatedAt),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_8_5,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_12),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(width: Dimensions.w_10),
                      if (topItems.isNotEmpty)
                        _impactItem(
                          icon: CupertinoIcons.heart_fill,
                          iconColor: isLight
                              ? AppColor.townHallGreen
                              : AppColor.townHallGreenDark,
                          value:
                              '${topItems[0].value}${topItems[0].suffix ?? ''}',
                          title: topItems[0].label ?? '',
                          subtitle: topItems[0].note ?? '',
                        ),

                      if (topItems.length > 1) ...[
                        _verticalDivider(),
                        SizedBox(width: Dimensions.w_10),
                        _impactItem(
                          icon: CupertinoIcons.person_2_fill,
                          iconColor: !isLight
                              ? const Color(0xffffc264)
                              : const Color(0xFF97590a),
                          value:
                              '${topItems[1].value}${topItems[1].suffix ?? ''}',
                          title: topItems[1].label ?? '',
                          subtitle: topItems[1].note ?? '',
                        ),
                      ],

                      if (topItems.length > 2) ...[
                        _verticalDivider(),
                        SizedBox(width: Dimensions.w_10),
                        _impactItem(
                          icon: CupertinoIcons.shield_fill,
                          iconColor: !isLight
                              ? const Color(0xffffc264)
                              : const Color(0xFF97590a),
                          value:
                              '${topItems[2].value}${topItems[2].suffix ?? ''}',
                          title: topItems[2].label ?? '',
                          subtitle: topItems[2].note ?? '',
                        ),
                      ],

                      if (topItems.length > 3) ...[
                        _verticalDivider(),
                        SizedBox(width: Dimensions.w_10),
                        _impactItem(
                          icon: CupertinoIcons.smiley_fill,
                          iconColor: isLight
                              ? AppColor.townHallGreen
                              : AppColor.townHallGreenDark,
                          value:
                              '${topItems[3].value}${topItems[3].suffix ?? ''}',
                          title: topItems[3].label ?? '',
                          subtitle: topItems[3].note ?? '',
                        ),
                      ],
                    ],
                  ),
                ),

                SizedBox(height: Dimensions.h_12),
                Container(
                  height: 0.5,
                  width: Get.width,
                  color: Theme.of(
                    context,
                  ).highlightColor.withValues(alpha: 0.15),
                ),

                SizedBox(height: Dimensions.h_10),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(width: Dimensions.w_10),

                      if (bottomItems.isNotEmpty)
                        _impactItem(
                          icon: CupertinoIcons.checkmark_rectangle,
                          iconColor: Theme.of(context).highlightColor,
                          value:
                              '${bottomItems[0].value}${bottomItems[0].suffix ?? ''}',
                          iconSize: Dimensions.h_13,
                          title: bottomItems[0].label ?? '',
                          subtitle: bottomItems[0].note ?? '',
                          subTitleColor: isLight
                              ? AppColor.townHallGreen
                              : AppColor.townHallGreenDark,
                        ),

                      if (bottomItems.length > 1) ...[
                        _verticalDivider(),
                        SizedBox(width: Dimensions.w_10),
                        _impactItem(
                          icon: Icons.calendar_today_outlined,
                          iconColor: Theme.of(context).highlightColor,
                          value:
                              '${bottomItems[1].value}${bottomItems[1].suffix ?? ''}',
                          title: bottomItems[1].label ?? '',
                          subtitle: bottomItems[1].note ?? '',
                          iconSize: Dimensions.h_13,
                        ),
                      ],

                      if (bottomItems.length > 2) ...[
                        _verticalDivider(),
                        SizedBox(width: Dimensions.w_10),
                        _impactItem(
                          icon: CupertinoIcons.person_3_fill,
                          iconColor: Theme.of(context).highlightColor,
                          value:
                              '${bottomItems[2].value}${bottomItems[2].suffix ?? ''}',
                          iconSize: Dimensions.h_16,
                          title: bottomItems[2].label ?? '',
                          subtitle: bottomItems[2].note ?? '',
                          subTitleColor: isLight
                              ? AppColor.townHallGreen
                              : AppColor.townHallGreenDark,
                        ),
                      ],

                      if (bottomItems.length > 3) ...[
                        _verticalDivider(),
                        SizedBox(width: Dimensions.w_10),
                        _impactItem(
                          icon: CupertinoIcons.lightbulb,
                          iconSize: Dimensions.h_13,
                          iconColor: Theme.of(context).highlightColor,
                          value:
                              '${bottomItems[3].value}${bottomItems[3].suffix ?? ''}',
                          title: bottomItems[3].label ?? '',
                          subtitle: bottomItems[3].note ?? '',
                          subTitleColor: isLight
                              ? AppColor.townHallGreen
                              : AppColor.townHallGreenDark,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.h_4),
              ],
            ),
          ),
          SizedBox(width: Dimensions.w_4),
        ],
      ),
    );
  }

  Widget aiBriefCard(bool isLight) {
    final brief = townHallController.townHallData?.aiBrief;
    final kicker = brief?.kicker;
    final columns = brief?.columns ?? [];
    final whyItMatters = brief?.whyItMatters;
    final actions = brief?.actions;
    final footer = brief?.footer;

    final localGreen = isLight
        ? AppColor.townHallGreen
        : AppColor.townHallGreenDark;

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.sparkles,
                color: isLight ? AppColor.darkBlue : AppColor.white,
                size: Dimensions.h_18,
              ),
              SizedBox(width: Dimensions.w_5),
              Expanded(
                child: Text(
                  kicker?.text ?? 'AI DAILY COMMUNITY BRIEF',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isLight ? AppColor.darkBlue : AppColor.white,
                    fontSize: FontSize.sp_13_5,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ),
              if (kicker?.badge != null && kicker!.badge!.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w_4,
                    vertical: Dimensions.h_2,
                  ),
                  decoration: BoxDecoration(
                    color: isLight
                        ? const Color(0xFFE8EDFF)
                        : const Color(0xFF19284D),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    kicker.badge!,
                    style: TextStyle(
                      color: isLight
                          ? AppColor.darkBlue
                          : const Color(0xFF73aaff),
                      fontSize: FontSize.sp_7,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: Dimensions.h_10),

          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_10),
            child: Text(
              brief?.title ?? '',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_13_5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                height: 1.1,
              ),
            ),
          ),

          SizedBox(height: Dimensions.h_6),

          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_10),
            child: Text(
              brief?.lede ?? '',
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: FontSize.sp_9_5,
                fontWeight: FontWeight.w500,
                height: 1.25,
              ),
            ),
          ),

          SizedBox(height: Dimensions.h_10),

          if (columns.isNotEmpty)
            _aiBriefColumn(
              icon: CupertinoIcons.briefcase_fill,
              iconColor: localGreen,
              iconBackground: isLight
                  ? const Color(0xFFE8F4EE)
                  : const Color(0xFF18352C),
              item: columns[0],
              isLight: isLight,
            ),

          if (columns.length > 1) ...[
            SizedBox(height: Dimensions.h_10),
            Container(height: 0.2, color: Theme.of(context).dividerColor),
            SizedBox(height: Dimensions.h_10),
            _aiBriefColumn(
              icon: CupertinoIcons.person_2_fill,
              iconColor: isLight ? const Color(0xFF365DEB) : const Color(0xFF73aaff),
              iconBackground: isLight
                  ? const Color(0xFFE8EDFF)
                  : const Color(0xFF19284D),
              item: columns[1],
              isLight: isLight,
            ),
          ],

          if (columns.length > 2) ...[
            SizedBox(height: Dimensions.h_10),
            Container(height: 0.2, color: Theme.of(context).dividerColor),
            SizedBox(height: Dimensions.h_10),
            _aiBriefColumn(
              icon: CupertinoIcons.shield_fill,
              iconColor: const Color(0xFFE83D4F),
              iconBackground: isLight
                  ? const Color(0xFFFFE8E8)
                  : const Color(0xFF432326),
              item: columns[2],
              isLight: isLight,
            ),
          ],

          if (whyItMatters != null) ...[
            SizedBox(height: Dimensions.h_12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Dimensions.w_8),
              decoration: BoxDecoration(
                color: isLight
                    ? const Color(0xFFF4F6FA)
                    : const Color(0xFF171B24),
                borderRadius: BorderRadius.circular(Dimensions.h_4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    whyItMatters.title ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: Dimensions.h_4),
                  Text(
                    whyItMatters.text ?? '',
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontSize: FontSize.sp_9,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (actions != null && (actions.items?.isNotEmpty ?? false)) ...[
            SizedBox(height: Dimensions.h_12),
            Text(
              actions.title ?? '',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_10,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: Dimensions.h_6),
            ...actions.items!.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: Dimensions.h_5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      CupertinoIcons.arrow_right_circle_fill,
                      color: localGreen,
                      size: Dimensions.h_12,
                    ),
                    SizedBox(width: Dimensions.w_5),
                    Expanded(
                      child: Text(
                        item.text ?? '',
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontSize: FontSize.sp_9,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          SizedBox(height: Dimensions.h_8),

          Row(
            children: [
              if (footer?.readFull != null)
                CommonCard(
                  radius: Dimensions.h_4,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w_8,
                    vertical: Dimensions.h_6,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        footer!.readFull!.text ?? '',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: FontSize.sp_9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: Dimensions.w_2),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColorDark,
                        size: Dimensions.h_10,
                      ),
                    ],
                  ),
                ),
              const Spacer(),
              if (footer?.share != null) ...[
                Text(
                  footer!.share!.text ?? '',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: FontSize.sp_9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: Dimensions.w_2),
                Icon(
                  Icons.share,
                  color: Theme.of(context).primaryColorDark,
                  size: Dimensions.h_10,
                ),
              ],
              SizedBox(width: Dimensions.w_4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aiBriefColumn({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required dynamic item,
    required bool isLight,
  }) {
    final toneColor = item.tone == 'red'
        ? const Color(0xFFE83D4F)
        : item.tone == 'blue'
        ? isLight ? const Color(0xFF365DEB) : const Color(0xFF73aaff)
        : isLight
        ? AppColor.townHallGreen
        : AppColor.townHallGreenDark;

    return Padding(
      padding: EdgeInsets.only(left: Dimensions.w_10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(Dimensions.w_3),
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(icon, color: iconColor, size: Dimensions.h_15),
          ),
          SizedBox(width: Dimensions.w_5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.value != null)
                  Row(
                    children: [
                      Text(
                        '${item.value}',
                        style: TextStyle(
                          color: toneColor,
                          fontSize: FontSize.sp_15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: Dimensions.w_4),
                      Expanded(
                        child: Text(
                          item.title ?? '',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: FontSize.sp_9_5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    item.title ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                    ),
                  ),
                SizedBox(height: Dimensions.h_5),
                Text(
                  item.text ?? '',
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_9,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
                if (item.link?.text != null) ...[
                  SizedBox(height: Dimensions.h_5),
                  Row(
                    children: [
                      Text(
                        item.link.text,
                        style: TextStyle(
                          color: isLight
                              ? AppColor.darkBlue
                              : const Color(0xFF73aaff),
                          fontSize: FontSize.sp_9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: Dimensions.w_3),
                      Icon(
                        Icons.arrow_forward,
                        color: isLight
                            ? AppColor.darkBlue
                            : const Color(0xFF73aaff),
                        size: Dimensions.h_11,
                      ),
                    ],
                  ),
                ],
                if (item.delta?.text != null) ...[
                  SizedBox(height: Dimensions.h_4),
                  Text(
                    item.delta.text,
                    style: TextStyle(
                      color: item.delta.tone == 'green'
                          ? (isLight
                                ? AppColor.townHallGreen
                                : AppColor.townHallGreenDark)
                          : Theme.of(context).highlightColor,
                      fontSize: FontSize.sp_9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _impactItem({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String title,
    double? iconSize,
    required String subtitle,
    Color? subTitleColor,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: iconSize ?? Dimensions.h_15),
                SizedBox(width: Dimensions.w_5),
                Text(
                  value,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_4),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
            SizedBox(height: Dimensions.h_2),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: subTitleColor ?? iconColor,
                fontSize: FontSize.sp_8_5,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(width: 0.5, color: Theme.of(context).focusColor);
  }

  Widget buildHeroHeader(bool isLight, TownHallController controller) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCacheImage(
          imageUrl:
              "https://staging.wikixm.com${controller.townHallData?.hero?.background?.src}",
          widthSize: Get.width,
          size: Dimensions.h_310,
          fit: BoxFit.cover,
          radius: 0,
        ),
        Positioned(
          child: Container(
            height: Dimensions.h_312,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: isLight
                    ? [
                        Colors.white.withValues(alpha: 0.70),
                        Colors.white.withValues(alpha: 0.70),
                        Colors.white.withValues(alpha: 0.60),
                        Colors.white.withValues(alpha: 0.30),
                        Colors.white.withValues(alpha: 0.0),
                      ]
                    : [
                        const Color(0xE6020B15).withValues(alpha: 0.60),
                        const Color(0x99020B15).withValues(alpha: 0.60),
                        const Color(0x99020B15).withValues(alpha: 0.50),
                        const Color(0x00000000),
                        const Color(0x00000000),
                      ],
                stops: const [0.08, 0.15, 0.35, 0.78, 1],
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.w_8),
              child: Text(
                controller.townHallData?.hero?.title ?? '',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_24,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Dimensions.w_8,
                top: Dimensions.h_8,
              ),
              child: Text(
                controller.townHallData?.hero?.subtitle ?? '',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: isLight ? FontWeight.w900 : FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Dimensions.w_8,
                top: Dimensions.h_15,
                right: Dimensions.w_120,
              ),
              child: Text(
                controller.townHallData?.hero?.description ?? '',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: Dimensions.h_20),
            Container(
              padding: EdgeInsets.fromLTRB(
                Dimensions.w_5,
                Dimensions.h_1,
                Dimensions.w_5,
                Dimensions.h_5,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: isLight ? Colors.white : Color(0xE6020B15),
                    offset: Offset(0, 150),
                    spreadRadius: 70,
                    blurRadius: 1,
                  ),
                ],
                gradient: isLight
                    ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x00FFFFFF),
                          Color(0x33FFFFFF),
                          Color(0xCCFFFFFF),
                          Color(0xFFFFFFFF),
                          AppColor.background,
                        ],
                        stops: [0.08, 0.25, 0.45, 0.75, 1.0],
                      )
                    : LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x00000000),
                          Color(0x00000000),
                          Color(0xE6020B15).withValues(alpha: 0.78),
                          Color(0xE6020B15),
                          Color(0x99020B15),
                        ],
                        stops: [0.08, 0.20, 0.35, 0.78, 1],
                      ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(
                          left: Dimensions.w_8,
                          top: Dimensions.h_5,
                          bottom: Dimensions.h_8,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_12,
                          vertical: Dimensions.h_4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff1d5fef),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.pencil_circle_fill,
                              size: Dimensions.h_13,
                              color: Colors.white,
                            ),
                            SizedBox(width: Dimensions.w_5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Raise an Issue or Idea",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                ),
                                Text(
                                  "Start a new project",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_8_5,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.school),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: Dimensions.w_8,
                          top: Dimensions.h_5,
                          bottom: Dimensions.h_8,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_15,
                          vertical: Dimensions.h_4,
                        ),
                        decoration: BoxDecoration(
                          color: isLight ? Colors.white : Colors.black45,
                          border: Border.all(
                            color: isLight
                                ? AppColor.sportsLightBorder
                                : Colors.white,
                            width: 0.7,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add,
                              size: Dimensions.h_13,
                              color: Theme.of(context).highlightColor,
                            ),
                            SizedBox(width: Dimensions.w_2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Join a Discussion",
                                  style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                ),
                                Text(
                                  "Contribute to Solutions",
                                  style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: FontSize.sp_8_5,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                  ),
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
            ),
          ],
        ),
      ],
    );
  }
}
