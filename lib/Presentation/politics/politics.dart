import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/events/events_screen_shimmer.dart';
import 'package:wikixm/Presentation/politics/controller.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/AnimatedImage.dart';
import '../widgets/cache_image.dart';
import '../widgets/circular_percent.dart';
import '../widgets/common_bullet.dart';
import '../widgets/common_header.dart';
import '../widgets/svg_widget.dart';

class PoliticsScreen extends StatefulWidget {
  const PoliticsScreen({super.key});

  @override
  State<PoliticsScreen> createState() => _PoliticsScreenState();
}

class _PoliticsScreenState extends State<PoliticsScreen> {
  final PoliticsController controller = Get.put(PoliticsController());

  List<String> filters = ['All', "City", "County", "State", "Federal"];

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme
        .of(context)
        .brightness == Brightness.light;
    return AppScaffold(
        top: false,
        bottom: false,
        bodyPadding: EdgeInsets.zero,
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        body: GetBuilder(
            init: controller,
            id: ControllerBuilders.politicsController,
            builder: (controller) {
              return controller.isLoading
                  ? EventsScreenShimmer()
                  : CommonScrollBlurScaffold(
                  showBack: true,
                  expandedHeight: Dimensions.h_270,
                  expandedColor: Colors.white,
                  collapsedColor: Theme
                      .of(context)
                      .highlightColor,
                  hero: buildHeroHeader(isLight),
                  slivers: [
                    SliverToBoxAdapter(
                        child: Column(
                            children: [
                              SizedBox(height: Dimensions.h_5),
                              aiBrief()
                            ])),
                    SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w_8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Dimensions.h_15),
                              representatives(isLight),
                              SizedBox(height: Dimensions.h_15),
                              representativeScore(isLight),
                              SizedBox(height: Dimensions.h_15),
                              whatsHappeningNow(isLight),
                              SizedBox(height: Dimensions.h_15),
                              topCommunityDiscussions(isLight),
                              SizedBox(height: Dimensions.h_15),
                              CommonSectionHeader(
                                title: ('Bills & Decisions Tracker')
                                    .toUpperCase(),
                                actionText: 'View all bills & decisions',
                                secondActionText: "",
                                onActionTap: () {},
                              ),
                              SizedBox(height: Dimensions.h_10),
                              billsSection(isLight),
                              SizedBox(height: Dimensions.h_15),
                              commonArticleGrid(),
                              SizedBox(height: Dimensions.h_15),
                              Text(
                                'Community Voices & Contributor Stories'.toUpperCase(),
                                style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .highlightColor,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_10),
                              communityOpinionsGrid(isLight),
                              SizedBox(height: Dimensions.h_15),
                              Text(
                                'Ask Your Representatives'.toUpperCase(),
                                style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .highlightColor,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_4),
                              Text(
                                'Get answers. Make your voice heard.',
                                style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .highlightColor,
                                  fontSize: FontSize.sp_10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_10),
                              askYourRepresentatives(isLight),
                              SizedBox(height: Dimensions.h_15),
                              Text(
                                'Town Hall Center'.toUpperCase(),
                                style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .highlightColor,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_4),
                              Text(
                                'Join upcoming events and have your say.',
                                style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .highlightColor,
                                  fontSize: FontSize.sp_10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_10),
                              townHallCenter(isLight),
                              SizedBox(height: Dimensions.h_15),
                              Text(
                                'Civic Activity'.toUpperCase(),
                                style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .highlightColor,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_4),
                              Padding(
                                padding: EdgeInsets.only(left: Dimensions.w_6),
                                child: Text(
                                  'See how Pine Valley is engaging.',
                                  style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .highlightColor,
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.h_10),
                              civicActivity(isLight),
                              SizedBox(height: Dimensions.h_10),
                              democracyStartsAtHome(isLight),
                              SizedBox(height: Dimensions.h_20)
                            ],
                          ),
                        )
                    )
                  ]);
            }
        ));
  }

  Widget billsSection(bool isLight) {
    final billsData = controller.politicsData?.bills;

    final bills = billsData?.bills ?? [];
    final tabs = billsData?.tabs ?? [];

    return CommonCard(
      padding: EdgeInsets.only(
        top: Dimensions.h_8,
        left: Dimensions.w_8,
        right: Dimensions.w_8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// FILTERS
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                tabs.length,
                    (index) {
                  final tab = tabs[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == tabs.length - 1
                          ? 0
                          : Dimensions.w_4,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Handle tab selection here
                      },
                      child: _scoreFilter(
                        title: tab.label ?? '',
                        isSelected: tab.active ?? false,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: Dimensions.h_10),

          /// BILLS
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: bills.length,
            itemBuilder: (context, index) {
              final item = bills[index];
              Color _billLevelColor(
                  String? level,
                  bool isLight,
                  ) {
                switch (level?.toLowerCase()) {
                  case 'town':
                    return isLight
                        ? AppColor.townHallGreen
                        : const Color(0xFF70C995);

                  case 'county':
                    return isLight
                        ? const Color(0xFF4566A8)
                        : const Color(0xFF82A5E8);

                  case 'state':
                    return isLight
                        ? const Color(0xFF654CB0)
                        : const Color(0xFFA58BE8);

                  case 'federal':
                    return isLight
                        ? const Color(0xFFB14A4A)
                        : const Color(0xFFE07878);

                  default:
                    return isLight
                        ? Theme.of(context).primaryColor
                        : Colors.white70;
                }
              }
              final levelColor = _billLevelColor(item.level?.value, isLight);
              return Container(
                margin: EdgeInsets.only(
                  bottom: Dimensions.h_10,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_2,
                  vertical: Dimensions.h_2,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(
                    Dimensions.h_8,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    Dimensions.w_7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// TITLE + LEVEL
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryColor,
                                    fontSize: FontSize.sp_12,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2,
                                  ),
                                ),

                                SizedBox(
                                  height: Dimensions.h_2,
                                ),

                                Text(
                                  item.code ?? item.id ?? '',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryColor,
                                    fontSize: FontSize.sp_9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: Dimensions.w_5,
                          ),

                          /// LEVEL
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w_5,
                              vertical: Dimensions.h_2,
                            ),
                            decoration: BoxDecoration(
                              color: levelColor.withValues(
                                alpha: isLight ? 0.10 : 0.18,
                              ),
                              borderRadius:
                              BorderRadius.circular(
                                Dimensions.h_4,
                              ),
                              border: Border.all(
                                color: levelColor.withValues(
                                  alpha: isLight ? 0.45 : 0.60,
                                ),
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              (item.level?.label ?? '')
                                  .toUpperCase(),
                              style: TextStyle(
                                color: levelColor,
                                fontSize: FontSize.sp_8,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: Dimensions.h_6,
                      ),

                      /// DESCRIPTION
                      Text(
                        item.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context)
                              .highlightColor,
                          fontSize: FontSize.sp_9_5,
                          fontWeight: FontWeight.w500,
                          height: 1.35,
                        ),
                      ),

                      SizedBox(
                        height: Dimensions.h_8,
                      ),

                      /// PROGRESS
                      _billProgress(
                        progress: item.progress ?? [],
                        isLight: isLight,
                      ),

                      SizedBox(
                        height: Dimensions.h_8,
                      ),

                      /// DIVIDER
                      Container(
                        height: 0.2,
                        width: double.infinity,
                        color: Theme.of(context)
                            .highlightColor,
                      ),

                      SizedBox(
                        height: Dimensions.h_6,
                      ),

                      /// STATUS + SOURCE + FOLLOW
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.status?.label ?? '',
                                  style: TextStyle(
                                    color: isLight
                                        ? AppColor.townHallGreen
                                        : AppColor.townHallGreenDark,
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),

                                SizedBox(
                                  height: Dimensions.h_2,
                                ),

                                Text(
                                  item.source?.label ?? '',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryColorDark,
                                    fontSize: FontSize.sp_8_5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// FOLLOW
                          GestureDetector(
                            onTap: () {
                              // Handle follow
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.w_10,
                                vertical: Dimensions.h_5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(
                                  Dimensions.h_5,
                                ),
                                border: Border.all(
                                  color: Theme.of(context)
                                      .highlightColor,
                                  width: 0.3,
                                ),
                              ),
                              child: Text(
                                item.follow?.text ?? 'Follow',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryColor,
                                  fontSize: FontSize.sp_9,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _billProgress({
    required List<dynamic> progress,
    required bool isLight,
  }) {
    if (progress.isEmpty) {
      return const SizedBox();
    }

    final activeColor = isLight
        ? AppColor.townHallGreen
        : AppColor.townHallGreenDark;

    final inactiveColor = Theme.of(context)
        .highlightColor
        .withValues(alpha: 0.50);

    return Column(
      children: [
        Row(
          children: List.generate(
            progress.length * 2 - 1,
                (itemIndex) {
              if (itemIndex.isEven) {
                final index = itemIndex ~/ 2;

                final status = progress[index].status;

                final isDone = status == 'done';
                final isCurrent = status == 'current';

                return Container(
                  width: Dimensions.h_8,
                  height: Dimensions.h_8,
                  decoration: BoxDecoration(
                    color: isDone || isCurrent
                        ? activeColor
                        : inactiveColor,
                    shape: BoxShape.circle,
                  ),
                );
              }

              final lineIndex = itemIndex ~/ 2;

              final currentStatus =
                  progress[lineIndex].status;

              final lineCompleted =
                  currentStatus == 'done';

              return Expanded(
                child: Container(
                  height: 1,
                  color: lineCompleted
                      ? activeColor
                      : inactiveColor,
                ),
              );
            },
          ),
        ),

        SizedBox(
          height: Dimensions.h_3,
        ),
        Row(
          children: List.generate(
            progress.length,
                (index) {
              final step = progress[index];
              final isCurrent =
                  step.status == 'current';
              return Expanded(
                child: Text(
                  step.label ?? '',
                  textAlign: index == 0
                      ? TextAlign.left
                      : index == progress.length - 1
                      ? TextAlign.right
                      : TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isCurrent
                        ? activeColor
                        : Theme.of(context)
                        .primaryColor
                        .withValues(alpha: 0.85),
                    fontSize: FontSize.sp_9,
                    fontWeight: isCurrent
                        ? FontWeight.w800
                        : FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget democracyStartsAtHome(bool isLight) {
    return Stack(
      children: [
        AppCacheImage(
          imageUrl:
          'https://preetis-html.vercel.app/assets/images/politics/politics2/capitol-hero-sm.webp',
          size: Dimensions.h_180,
          widthSize: Get.width,
          isShadow: false,
          radius: Dimensions.h_8,
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColor.primaryNavyNew.withValues(alpha: 1),
                  AppColor.primaryNavyNew.withValues(alpha: 0.98),
                  AppColor.primaryNavyNew.withValues(alpha: 0.90),
                  AppColor.primaryNavyNew.withValues(alpha: 0.85),
                ],
                stops: const [0.0, 0.35, 0.65, 1.0],
              ),
            ),
          ),
        ),
        Container(
          height: Dimensions.h_180,
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w_10, vertical: Dimensions.h_8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Democracy starts at home.',
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: FontSize.sp_18,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              SizedBox(height: Dimensions.h_8),
              Text(
                'Stay informed. Ask questions. Participate.',
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Help shape the future of Pine Valley.',
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: _democracyActionButton(
                      title: 'Join Town Hall',
                      subtitle: 'See upcoming events',
                      color: const Color(0xFF23704F),
                      onTap: () {},
                    ),
                  ),

                  SizedBox(width: Dimensions.w_5),

                  Expanded(
                    child: _democracyActionButton(
                      title: 'Ask a Question',
                      subtitle: 'Voice your concerns',
                      color: const Color(0xFF345BB2),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_5),
              Row(
                children: [
                  Expanded(
                    child: _democracyActionButton(
                      title: 'Follow Officials',
                      subtitle: 'Stay connected',
                      color: const Color(0xFF5737B8),
                      onTap: () {},
                    ),
                  ),

                  SizedBox(width: Dimensions.w_5),

                  Expanded(
                    child: _democracyActionButton(
                      title: 'Track Bills',
                      subtitle: 'Stay informed',
                      color: Colors.transparent,
                      isOutlined: true,
                      onTap: () {},
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

  Widget _democracyActionButton({
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    bool isOutlined = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Dimensions.h_45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Dimensions.h_7),
          border: isOutlined
              ? Border.all(
            color: AppColor.white.withValues(alpha: 0.55),
            width: 1,
          )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.white,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: Dimensions.h_3),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.white,
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget communityOpinionsGrid(bool isLight) {
    final voices = controller.politicsData?.communityVoices?.voices ?? [];

    String getFullImageUrl(String? image) {
      if (image == null || image.isEmpty) return '';
      if (image.startsWith('http')) return image;
      return 'https://staging.wikixm.com$image';
    }

    Color getVoiceColor(String? type) {
      switch (type?.toLowerCase()) {
        case 'opinion':
          return isLight
              ? AppColor.townHallGreen
              : AppColor.townHallGreenDark;
        case 'analysis':
          return isLight
              ? const Color(0xff3459A6)
              : const Color(0xff6F91D1);
        case 'letter':
          return isLight
              ? const Color(0xff32665F)
              : const Color(0xff6FA49C);
        case 'guest':
          return isLight
              ? const Color(0xffA85A0A)
              : const Color(0xffD58A45);
        default:
          return isLight
              ? AppColor.townHallGreen
              : AppColor.townHallGreenDark;
      }
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: voices.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Get.width > 700 ? 4 : 2,
        crossAxisSpacing: Dimensions.w_8,
        mainAxisSpacing: Dimensions.h_8,
        childAspectRatio: Get.width > 700 ? 1.85 : 1,
      ),
      itemBuilder: (context, index) {
        final item = voices[index];
        final itemColor = getVoiceColor(item.type);

        return Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                Dimensions.w_8,
                Dimensions.h_8,
                Dimensions.w_8,
                Dimensions.h_8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(
                  Dimensions.h_8,
                ),
                border: Border(
                  right: BorderSide(
                    color: isLight ? Colors.grey : Colors.white24,
                    width: 0.4,
                  ),
                  left: BorderSide(
                    color: isLight ? Colors.grey : Colors.white24,
                    width: 0.4,
                  ),
                  bottom: BorderSide(
                    color: isLight ? Colors.grey : Colors.white24,
                    width: 0.4,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_4,
                      vertical: Dimensions.h_2,
                    ),
                    decoration: BoxDecoration(
                      color: itemColor,
                      borderRadius: BorderRadius.circular(
                        Dimensions.h_3,
                      ),
                    ),
                    child: Text(
                      item.tag ?? '',
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: FontSize.sp_7,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.h_5),
                  Row(
                    children: [
                      AppCacheImage(
                        imageUrl: getFullImageUrl(item.author?.image?.src),
                        size: Dimensions.h_35,
                        widthSize: Dimensions.h_35,
                        isShadow: false,
                        isCircle: true,
                      ),
                      SizedBox(width: Dimensions.w_4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.author?.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_1),
                            Text(
                              item.author?.role ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: FontSize.sp_9,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_8),
                  Text(
                    item.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: FontSize.sp_11,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: Dimensions.h_5),
                  Text(
                    item.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: FontSize.sp_9,
                      fontWeight: FontWeight.w500,
                      height: 1.25,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    item.dateText ??  '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: FontSize.sp_8_5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: Dimensions.h_1,
              left: Dimensions.w_1,
              right: Dimensions.w_1,
              child: Container(
                height: Dimensions.h_3,
                decoration: BoxDecoration(
                  color: itemColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.h_20),
                    topRight: Radius.circular(Dimensions.h_20),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget askYourRepresentatives(bool isLight) {
    final data = controller.politicsData?.askRepresentatives;
    final questions = data?.items ?? [];

    String getFullImageUrl(String? image) {
      if (image == null || image.isEmpty) return '';
      if (image.startsWith('http')) return image;
      return 'https://staging.wikixm.com$image';
    }

    Color getStatusColor(String? status) {
      switch (status?.toLowerCase()) {
        case 'pending':
          return isLight
              ? const Color(0xffA86A2A)
              : const Color(0xffD99A5A);
        case 'answered':
          return isLight
              ? const Color(0xff397A5D)
              : const Color(0xff72B894);
        default:
          return isLight
              ? Theme.of(context).primaryColor
              : Colors.white70;
      }
    }

    Color getStatusBackground(String? status) {
      switch (status?.toLowerCase()) {
        case 'pending':
          return isLight
              ? const Color(0xffF8EEE0)
              : const Color(0xff3D2E20);
        case 'answered':
          return isLight
              ? const Color(0xffE5F1EB)
              : const Color(0xff20382D);
        default:
          return isLight
              ? Colors.grey.shade200
              : Colors.white.withValues(alpha: 0.10);
      }
    }

    return CommonCard(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final item = questions[index];
                final statusColor = getStatusColor(item.status);
                final statusBg = getStatusBackground(item.status);

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_3,
                        vertical: Dimensions.h_6,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppCacheImage(
                            imageUrl: getFullImageUrl(
                              item.resident?.image?.src,
                            ),
                            size: Dimensions.h_35,
                            widthSize: Dimensions.h_35,
                            isShadow: false,
                            isCircle: true,
                          ),
                          SizedBox(width: Dimensions.w_5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.question ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: FontSize.sp_11,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(height: Dimensions.h_2),
                                Text(
                                  'Asked ${item.askedAt ?? ''} by ${item.askedBy ?? ''}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: FontSize.sp_9,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: Dimensions.w_8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w_6,
                              vertical: Dimensions.h_4,
                            ),
                            decoration: BoxDecoration(
                              color: statusBg,
                              borderRadius: BorderRadius.circular(
                                Dimensions.h_10,
                              ),
                            ),
                            child: Text(
                              (item.status ?? '').toUpperCase(),
                              style: TextStyle(
                                color: statusColor,
                                fontSize: FontSize.sp_8_5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index != questions.length - 1)
                      Container(
                        height: 0.1,
                        width: Get.width,
                        color: Theme.of(context).highlightColor,
                      ),
                  ],
                );
              },
            ),
            SizedBox(height: Dimensions.h_10),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.w_5,
              ),
              width: Get.width,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w_3,
                vertical: Dimensions.h_10,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: Colors.grey.shade500,
                  width: 0.3,
                ),
                borderRadius: BorderRadius.circular(
                  Dimensions.h_6,
                ),
              ),
              child: Center(
                child: Text(
                  data?.button?.text ?? 'Ask a Question',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget commonArticleGrid() {
    final localNews = controller.politicsData?.localNews;
    final stories = localNews?.stories ?? [];

    final featuredStory = stories.cast<dynamic?>().firstWhere(
          (story) => story?.featured == true,
      orElse: () => null,
    );

    final gridStories = stories
        .where((story) => story.featured != true)
        .toList();

    String getFullImageUrl(String? image) {
      if (image == null || image.isEmpty) return '';
      if (image.startsWith('http')) return image;
      return 'https://staging.wikixm.com$image';
    }

    return Column(
      children: [
        CommonSectionHeader(
          title: (localNews?.title ?? 'Local Government News').toUpperCase(),
          actionText: 'View all news',
          secondActionText: "",
          onActionTap: () {},
        ),
        SizedBox(height: Dimensions.h_10),

        if (featuredStory != null)
          Stack(
            children: [
              AppCacheImage(
                imageUrl: getFullImageUrl(
                  featuredStory.image?.src,
                ),
                size: Dimensions.h_200,
                widthSize: Get.width,
                isShadow: false,
                radius: Dimensions.h_8,
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.h_8,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color(0xFF020B15).withValues(alpha: 0.95),
                        const Color(0xFF020B15).withValues(alpha: 0.55),
                        const Color(0xFF020B15).withValues(alpha: 0.35),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.35, 0.65, 1.0],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: Dimensions.h_10,
                left: Dimensions.w_10,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w_5,
                    vertical: Dimensions.h_2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.darkGreenSportsSecondaryText,
                    borderRadius: BorderRadius.circular(
                      Dimensions.h_4,
                    ),
                  ),
                  child: Text(
                    'FEATURED',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: FontSize.sp_8_5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: Dimensions.w_8,
                right: Dimensions.w_10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      featuredStory.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: FontSize.sp_18,
                        fontWeight: FontWeight.w900,
                        height: 1.15,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_7),
                    Text(
                      featuredStory.description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: FontSize.sp_9_5,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_3),
                    Row(
                      children: [
                        SizedBox(width: Dimensions.w_8),
                        Text(
                          'By ${featuredStory.author ?? ''}',
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: FontSize.sp_9_5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: Dimensions.w_8),
                        Text(
                          featuredStory.publishedText ??
                              featuredStory.publishedAt ??
                              '',
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: FontSize.sp_9_5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.h_7),
                  ],
                ),
              ),
            ],
          ),

        if (gridStories.isNotEmpty)
          SizedBox(height: Dimensions.h_10),
        if (gridStories.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: gridStories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Get.width > 700 ? 4 : 2,
              crossAxisSpacing: Dimensions.w_8,
              mainAxisSpacing: Dimensions.h_8,
              childAspectRatio: Get.width > 700 ? 0.82 : 0.76,
            ),
            itemBuilder: (context, index) {
              final article = gridStories[index];
              return CommonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: AppCacheImage(
                        imageUrl: getFullImageUrl(
                          article.image?.src,
                        ),
                        widthSize: Get.width,
                        size: Dimensions.h_95,
                        isShadow: false,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_6),
                    Text(
                      article.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: FontSize.sp_11,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_7),
                    const Spacer(),
                    if(article.description?.isNotEmpty ?? false)
                    Text(
                      article.description ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: FontSize.sp_9,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_3),
                    Row(
                      children: [
                        SizedBox(width: Dimensions.w_6),
                        Text(
                          'By ${article.author ?? ''}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: FontSize.sp_8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: Dimensions.w_12),
                        Text(
                          article.publishedText ?? article.publishedAt ?? '',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: FontSize.sp_8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.h_4),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget topCommunityDiscussions(bool isLight) {
    final data = controller.politicsData?.topDiscussions;

    final discussions = data?.discussions ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonSectionHeader(
          title: (data?.title ?? 'Top Community Discussions').toUpperCase(),
          actionText: data?.viewAllText ?? 'View all discussions',
          secondActionText: "",
          onActionTap: () {
          },
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w_12,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: discussions.length,
            itemBuilder: (context, index) {
              final item = discussions[index];
              Color discussionColor(String? iconClass, bool isLight) {
                switch (iconClass) {
                  case 'is-red':
                    return isLight
                        ? const Color(0xFFB83232)
                        : const Color(0xFFE06A6A);

                  case 'is-green':
                    return isLight
                        ? const Color(0xFF397A5D)
                        : const Color(0xFF72B894);

                  case 'is-orange':
                    return isLight
                        ? const Color(0xFFB86718)
                        : const Color(0xFFE09A55);

                  case 'is-blue':
                    return isLight
                        ? const Color(0xFF3D73C9)
                        : const Color(0xFF78A6E8);

                  default:
                    return isLight
                        ? const Color(0xFF397A5D)
                        : const Color(0xFF72B894);
                }
              }
              final itemColor = discussionColor(item.iconClass, isLight);
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_3,
                      vertical: Dimensions.h_8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.chat_bubble_text,
                          size: Dimensions.h_15,
                          color: itemColor,
                        ),
                        SizedBox(width: Dimensions.w_5),
                        Expanded(
                          child: Text(
                            item.title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: FontSize.sp_10,
                              fontWeight: FontWeight.w600,
                              height: 1.25,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.w_4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${item.comments ?? 0}',
                              style: TextStyle(
                                color: itemColor,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),

                            SizedBox(height: Dimensions.h_2),

                            Text(
                              item.commentsText ?? 'comments',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: FontSize.sp_8_5,
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (index != discussions.length - 1)
                    Container(
                      height: 0.1,
                      width: Get.width,
                      color: Theme.of(context).highlightColor,
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
  Widget whatsHappeningNow(bool isLight) {
    final events = controller.politicsData?.happeningNow?.events ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonSectionHeader(
          title: ('What’s Happening Now').toUpperCase(),
          actionText: 'View All',
          secondActionText: "",
          onActionTap: () {},
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: Dimensions.w_5,
              children: [
                _eventFilterChip(
                  icon: Icons.how_to_vote_outlined,
                  label: 'Upcoming Votes',
                  isLight: isLight,
                ),
                _eventFilterChip(
                  icon: Icons.people_outline,
                  label: 'Meetings',
                  isLight: isLight,
                ),
                _eventFilterChip(
                  icon: Icons.assignment_outlined,
                  label: 'Deadlines',
                  isLight: isLight,
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_5),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                DateTime? eventDate = DateTime.tryParse(event.date ?? '');
                String getMonthName(int month) {
                  const months = [
                    'JAN',
                    'FEB',
                    'MAR',
                    'APR',
                    'MAY',
                    'JUN',
                    'JUL',
                    'AUG',
                    'SEP',
                    'OCT',
                    'NOV',
                    'DEC',
                  ];
                  return month >= 1 && month <= 12 ? months[month - 1] : '';
                }

                final month = eventDate != null
                    ? getMonthName(eventDate.month)
                    : '';

                final day = eventDate != null
                    ? eventDate.day.toString()
                    : '';
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_6,
                        vertical: Dimensions.h_6,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: Dimensions.h_30,
                            height: Dimensions.h_30,
                            decoration: BoxDecoration(
                              color: isLight
                                  ? const Color(0xFFFFEAEC)
                                  : const Color(0xFF3A1F23),
                              borderRadius: BorderRadius.circular(
                                Dimensions.h_5,
                              ),
                              border: Border.all(
                                color: isLight
                                    ? const Color(0xFFBD252D)
                                    : const Color(0xFF7F3038),
                                width: 0.5,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  month,
                                  style: TextStyle(
                                    color: isLight
                                        ? const Color(0xFFBD252D)
                                        : const Color(0xFFE06A70),
                                    fontSize: FontSize.sp_7,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(height: Dimensions.h_1),
                                Text(
                                  day,
                                  style: TextStyle(
                                    color: isLight
                                        ? Theme.of(context).primaryColor
                                        : AppColor.white,
                                    fontSize: FontSize.sp_11,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
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
                                  event.title ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: FontSize.sp_11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                SizedBox(height: Dimensions.h_1),

                                Padding(
                                  padding: EdgeInsets.only(
                                    left: Dimensions.w_6,
                                  ),
                                  child: Text(
                                    event.description ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: FontSize.sp_8_5,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),

                                SizedBox(height: Dimensions.h_5),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(width: Dimensions.w_6),

                                    Text(
                                      event.when?.day ?? '',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),

                                    SizedBox(width: Dimensions.w_15),

                                    Text(
                                      event.when?.time ?? '',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),

                                    SizedBox(width: Dimensions.w_15),

                                    Expanded(
                                      child: Text(
                                        event.when?.location ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: FontSize.sp_9,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: Dimensions.w_5),
                        ],
                      ),
                    ),

                    if (index != events.length - 1)
                      Container(
                        height: 0.1,
                        width: Get.width,
                        color: Theme.of(context).highlightColor,
                      ),
                  ],
                );
              },
            ),
          ],
        ))

      ],
    );
  }

  Widget townHallCenter(bool isLight) {
    final data = controller.politicsData?.townHall;
    final events = data?.events ?? [];

    String getMonthName(String? date) {
      if (date == null || date.isEmpty) return '';

      final parsedDate = DateTime.tryParse(date);
      if (parsedDate == null) return '';

      const months = [
        'JAN',
        'FEB',
        'MAR',
        'APR',
        'MAY',
        'JUN',
        'JUL',
        'AUG',
        'SEP',
        'OCT',
        'NOV',
        'DEC',
      ];

      return months[parsedDate.month - 1];
    }

    String getDay(String? date) {
      if (date == null || date.isEmpty) return '';

      final parsedDate = DateTime.tryParse(date);
      if (parsedDate == null) return '';

      return parsedDate.day.toString();
    }

    final eventAccentColor = isLight
        ? const Color(0xFFBD252D)
        : const Color(0xFFE06A70);

    final eventBackgroundColor = isLight
        ? const Color(0xFFFFEAEC)
        : const Color(0xFF3A1F23);

    return CommonCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (c, index) {
              final event = events[index];

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_6,
                      vertical: Dimensions.h_5,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: Dimensions.h_30,
                          height: Dimensions.h_30,
                          decoration: BoxDecoration(
                            color: eventBackgroundColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.h_5,
                            ),
                            border: Border.all(
                              color: eventAccentColor.withValues(
                                alpha: 0.45,
                              ),
                              width: 0.6,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                getMonthName(event.date),
                                style: TextStyle(
                                  color: eventAccentColor,
                                  fontSize: FontSize.sp_7,
                                  fontWeight: FontWeight.w800,
                                  height: 1,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_1),
                              Text(
                                getDay(event.date),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w800,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.w_6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_1),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Dimensions.w_5,
                                ),
                                child: Text(
                                  '${event.time ?? ''} · ${event.location ?? ''}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withValues(alpha: 0.65),
                                    fontSize: FontSize.sp_9_5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.w_5),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_8,
                            vertical: Dimensions.h_4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .highlightColor
                                .withValues(
                              alpha: isLight ? 0.05 : 0.12,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.h_4,
                            ),
                            border: Border.all(
                              color: Theme.of(context)
                                  .focusColor
                                  .withValues(alpha: 0.7),
                              width: 0.7,
                            ),
                          ),
                          child: Text(
                            event.rsvpText ?? 'RSVP',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: FontSize.sp_8_5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index != events.length - 1)
                    Container(
                      height: 0.1,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_6,
                      ),
                      color: Theme.of(context).highlightColor,
                    ),
                ],
              );
            },
          ),
          SizedBox(height: Dimensions.h_5),
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data?.viewAll?.text ?? 'View all events',
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
          ),
          SizedBox(height: Dimensions.h_8),
        ],
      ),
    );
  }

  Widget civicActivity(bool isLight) {
    final data = controller.politicsData?.civicActivity;
    final activities = data?.items ?? [];

    final icons = [
      Icons.help_outline,
      CupertinoIcons.chat_bubble_text,
      Icons.account_balance_outlined,
      Icons.send_outlined,
    ];

    final iconColor = isLight
        ? const Color(0xff2454B8)
        : const Color(0xff7EA5F0);

    String getDeltaText(dynamic delta) {
      final prefix = delta?.prefix ?? '';
      final value = delta?.value ?? 0;
      return '$prefix$value';
    }

    return CommonCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Dimensions.h_2),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final item = activities[index];

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_10,
                      vertical: Dimensions.h_6,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Dimensions.w_18,
                          child: Icon(
                            icons[index % icons.length],
                            size: Dimensions.h_15,
                            color: iconColor,
                          ),
                        ),
                        SizedBox(width: Dimensions.w_5),
                        SizedBox(
                          width: Dimensions.w_25,
                          child: Text(
                            '${item.value ?? 0}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: FontSize.sp_12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.w_3),
                        Expanded(
                          child: Text(
                            item.label ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: FontSize.sp_10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.w_4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              getDeltaText(item.delta),
                              style: TextStyle(
                                color: isLight
                                    ? AppColor.townHallGreen
                                    : AppColor.townHallGreenDark,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_2),
                            Text(
                              item.delta?.label ?? '',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: FontSize.sp_9,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (index != activities.length - 1)
                    Container(
                      height: 0.1,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_6,
                      ),
                      color: Theme.of(context).highlightColor,
                    ),
                ],
              );
            },
          ),
          SizedBox(height: Dimensions.h_6),
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w_10,
                vertical: Dimensions.h_3,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data?.viewAll?.text ?? 'View full activity feed',
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
            ),
          ),
          SizedBox(height: Dimensions.h_7),
        ],
      ),
    );
  }

  Widget _eventFilterChip({
    required IconData icon,
    required String label,
    required bool isLight,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_6,
        vertical: Dimensions.h_5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          width: 0.2,
          color: Theme
              .of(context)
              .highlightColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: Dimensions.h_15,
            color: isLight
                ? AppColor.townHallGreen
                : AppColor.townHallGreenDark,
          ),
          SizedBox(width: Dimensions.w_2),
          Text(
            label,
            style: TextStyle(
              color: Theme
                  .of(context)
                  .primaryColor,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget representatives(bool isLight) {
    final tabs = controller.politicsData?.representation?.tabs ?? [];
    final representatives = controller.politicsData?.representation
        ?.representatives ?? [];
    return Column(
      children: [
        CommonSectionHeader(
          title: ('Your Representation').toUpperCase(),
          actionText: 'View all officials',
          secondActionText: "",
          onActionTap: () {},
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(tabs.length, (index) {
                    final tab = tabs[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          right: index == tabs.length - 1 ? 0 : Dimensions.w_4),
                      child: GestureDetector(
                        onTap: () {},
                        child: _scoreFilter(
                            title: tab.label ?? '',
                            isSelected: tab.active ?? false
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              SizedBox(
                height: Dimensions.h_200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemCount: representatives.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: Dimensions.w_8),
                  itemBuilder: (context, index) {
                    final representative = representatives[index];
                    final imageUrl = representative.image?.src;
                    return SizedBox(
                      width: Dimensions.w_120,
                      child: CommonCard(
                        padding: EdgeInsets.zero,
                        color: Theme
                            .of(context)
                            .scaffoldBackgroundColor,
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
                                      topLeft: Radius.circular(Dimensions.h_8),
                                      topRight: Radius.circular(Dimensions.h_8),
                                    ),
                                    child: imageUrl != null &&
                                        imageUrl.isNotEmpty
                                        ? AppCacheImage(
                                      imageUrl: imageUrl.startsWith('http')
                                          ? imageUrl
                                          : 'https://staging.wikixm.com$imageUrl',
                                      size: Dimensions.h_70,
                                      widthSize: Dimensions.w_120,
                                      radius: 0,
                                      isShadow: false,
                                    ) : Center(
                                      child: Icon(
                                        CupertinoIcons.person_2_alt,
                                        size: Dimensions.h_30,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: Dimensions.w_5,
                                    top: Dimensions.h_4,
                                    child: Container(
                                      width: Dimensions.h_20,
                                      height: Dimensions.h_20,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF177a42),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          representative.grade ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: FontSize.sp_11,
                                            fontWeight: FontWeight.w800,
                                            height: 1.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.h_4,
                                  horizontal: Dimensions.w_5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: Dimensions.h_5),
                                    Text(
                                      representative.name?.toUpperCase() ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        fontSize: FontSize.sp_11,
                                        fontWeight: FontWeight.w800,
                                        height: 1.2,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_3),
                                    Text(
                                      representative.detail ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        fontSize: FontSize.sp_10,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_5),
                                    Text(
                                      representative.email ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: isLight
                                            ? Theme
                                            .of(context)
                                            .highlightColor
                                            : const Color(0xFF9DABC0),
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_3),
                                    Text(
                                      representative.phone ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: isLight
                                            ? Theme
                                            .of(context)
                                            .highlightColor
                                            : const Color(0xFF9DABC0),
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: Get.width,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.w_3,
                                        vertical: Dimensions.h_6,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade500,
                                          width: 0.3,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          Dimensions.h_6,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          representative.followText ?? 'Follow',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Theme
                                                .of(context)
                                                .highlightColor,
                                            fontSize: FontSize.sp_9,
                                            fontWeight: FontWeight.w700,
                                            height: 1.1,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: Dimensions.h_6),

                                    Text(
                                      representative.askText ??
                                          'Ask a Question',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .primaryColorDark,
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w800,
                                        height: 1.2,
                                      ),
                                    ),

                                    SizedBox(height: Dimensions.h_2),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget representativeScore(bool isLight) {
    final scoreData = controller.politicsData?.score;

    final tabs = scoreData?.tabs ?? [];
    final overall = scoreData?.overall;
    final breakdown = scoreData?.breakdown ?? [];

    return Column(
      children: [
        CommonSectionHeader(
          title: (scoreData?.title ?? '').toUpperCase(),
          actionText: '',
          secondActionText: "",
          onActionTap: () {},
        ),

        SizedBox(height: Dimensions.h_10),

        CommonCard(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    tabs.length,
                        (index) {
                      final tab = tabs[index];

                      return Padding(
                        padding: EdgeInsets.only(
                          right: index == tabs.length - 1
                              ? 0
                              : Dimensions.w_4,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // Handle tab selection here
                          },
                          child: _scoreFilter(
                            title: tab.label ?? '',
                            isSelected: tab.active ?? false,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: Dimensions.h_20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: Dimensions.w_6),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          (overall?.label ?? 'Overall Score').toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isLight
                                ? AppColor.townHallGreen
                                : AppColor.townHallGreenDark,
                            fontSize: FontSize.sp_12,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                      ),

                      SizedBox(height: Dimensions.h_8),

                      SizedBox(
                        width: Dimensions.h_90,
                        height: Dimensions.h_90,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ArcGaugeIndicator(
                              radius: Dimensions.h_40,
                              lineWidth: Dimensions.w_5,
                              percent: _gradeToPercentage(overall?.score ?? ''),
                              progressColor: isLight
                                  ? AppColor.townHallGreen
                                  : AppColor.townHallGreenDark,
                              backgroundColor: Theme
                                  .of(context)
                                  .highlightColor
                                  .withValues(alpha: 0.18),
                              sweepAngle: 360,
                              startAngle: 0,
                            ),

                            Text(
                              overall?.score ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isLight
                                    ? AppColor.townHallGreen
                                    : AppColor.townHallGreenDark,
                                fontSize: FontSize.sp_30,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: Dimensions.w_40),
                  Expanded(
                    child: Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              if (overall != null && overall.averages!.isNotEmpty)
                                Expanded(
                                  child: buildAvg(
                                    'City Avg.',
                                    overall.averages?[0].value ?? '',
                                  ),
                                ),
                          
                              if (overall != null && (overall.averages?.length ?? 0) > 1) ...[
                                SizedBox(width: Dimensions.w_8),
                                Expanded(
                                  child: buildAvg(
                                    overall.averages?[0].label ?? '',
                                    overall.averages?[1].value ?? '',
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.h_6),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: buildAvg(
                                    overall?.averages?[1].label ?? '',
                                    overall?.averages?[1].value ?? '',
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_8),
                                Expanded(
                                  child: buildAvg(
                                    'Federal Avg.',
                                    overall?.averages?[1].value ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: Dimensions.h_10),
                        Text(
                          overall?.updatedText ?? '',
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: FontSize.sp_9,
                            fontWeight: FontWeight.w500,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: Dimensions.w_10),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: Dimensions.h_20,
                  bottom: Dimensions.h_10,
                ),
                height: 0.1,
                width: Get.width,
                color: Theme
                    .of(context)
                    .highlightColor,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.w_6,
                ),
                child: Text(
                  'Score Breakdown'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .highlightColor,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ),

              SizedBox(height: Dimensions.h_10),

              ...List.generate(
                breakdown.length,
                    (index) {
                  final item = breakdown[index];

                  return Column(
                    children: [
                      _transparencyItem(
                        title: item.name ?? '',
                        percentage: (item.fill ?? 0).toDouble(),
                        grade: item.grade ?? '',
                        isLight: isLight,
                      ),

                      if (index != breakdown.length - 1)
                        SizedBox(height: Dimensions.h_7),
                    ],
                  );
                },
              ),

              Container(
                margin: EdgeInsets.only(
                  top: Dimensions.h_20,
                  bottom: Dimensions.h_10,
                ),
                height: 0.1,
                width: Get.width,
                color: Theme
                    .of(context)
                    .highlightColor,
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.w_6,
                ),
                child: Text(
                  'Top Representative'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .highlightColor,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ),
              representativesScoreSection(isLight),
            ],
          ),
        ),
      ],
    );
  }

  Widget representativesScoreSection(bool isLight) {
    final members = controller.politicsData?.score?.topRepresentatives ?? [];
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.w_8,
      ),
      child: Column(
        children: [
          SizedBox(height: Dimensions.h_8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: Dimensions.w_40,
                child: Text(
                  'SCORE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    fontSize: FontSize.sp_8,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),

              SizedBox(width: Dimensions.w_20),

              SizedBox(
                width: Dimensions.w_40,
                child: Text(
                  'GRADE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    fontSize: FontSize.sp_8,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),

          ...List.generate(
            members.length,
                (index) {
              final member = members[index];

              String imageUrl = '';

              if (member.image?.src != null &&
                  member.image!.src!.isNotEmpty) {
                imageUrl = member.image!.src!.startsWith('http')
                    ? member.image!.src!
                    : 'https://staging.wikixm.com${member.image!.src}';
              }

              return Column(
                children: [
                  _representativeScoreItem(
                    name: member.name ?? '',
                    role: member.role ?? '',
                    score: '${member.score ?? 0}',
                    grade: member.grade ?? '',
                    trend: member.trend ?? '',
                    image: imageUrl,
                    isLight: isLight,
                  ),

                  if (index != members.length - 1)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.h_6,
                      ),
                      child: Container(
                        height: 0.1,
                        color: Theme
                            .of(context)
                            .highlightColor,
                      ),
                    ),
                ],
              );
            },
          ),

          SizedBox(height: Dimensions.h_10),

          GestureDetector(
            onTap: () {
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View Full Rankings',
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .primaryColorDark,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),

                SizedBox(width: Dimensions.w_3),

                Icon(
                  Icons.arrow_forward,
                  color: Theme
                      .of(context)
                      .primaryColorDark,
                  size: Dimensions.h_11,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _gradeToPercentage(String grade) {
    switch (grade.toUpperCase()) {
      case 'A+':
        return 100;
      case 'A':
        return 95;
      case 'A-':
        return 90;
      case 'B+':
        return 87;
      case 'B':
        return 83;
      case 'B-':
        return 80;
      case 'C+':
        return 77;
      case 'C':
        return 73;
      case 'C-':
        return 70;
      case 'D+':
        return 67;
      case 'D':
        return 63;
      case 'D-':
        return 60;
      case 'F':
        return 40;
      default:
        return 0;
    }
  }

  Widget _representativeScoreItem({
    required String name,
    required String role,
    required String score,
    required String grade,
    required String trend,
    required String image,
    required bool isLight,
  }) {
    final gradeColor = isLight ? AppColor.townHallGreen : AppColor
        .townHallGreenDark;
    return Row(
      children: [
        AppCacheImage(
            imageUrl: image,
            size: Dimensions.h_30,
            widthSize: Dimensions.h_30,
            fit: BoxFit.cover,
            isShadow: false,
            isCircle: true),
        SizedBox(width: Dimensions.w_5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      fontSize: FontSize.sp_11,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: Dimensions.h_1),
              Text(
                role,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  fontSize: FontSize.sp_9,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: Dimensions.w_5),
        SizedBox(
          width: Dimensions.w_20,
          child: Text(
            score,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme
                  .of(context)
                  .primaryColor,
              fontSize: FontSize.sp_11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: Dimensions.w_30),
        SizedBox(
          width: Dimensions.w_40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                grade,
                style: TextStyle(
                  color: gradeColor,
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: Dimensions.w_3),
              Icon(
                trend == 'up' ? Icons.trending_up
                    : Icons.remove,
                color: gradeColor,
                size: Dimensions.h_13,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _transparencyItem({
    required String title,
    required double percentage,
    required String grade,
    required bool isLight,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.w_12),
      child: Row(
        children: [
          SizedBox(
            width: Dimensions.w_100,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: FontSize.sp_10,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_15),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: Dimensions.h_3,
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .highlightColor
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: constraints.maxWidth *
                          (percentage.clamp(0, 100) / 100),
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
          SizedBox(width: Dimensions.w_15),
          SizedBox(
            width: Dimensions.w_15,
            child: Text(
              grade,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: isLight
                    ? AppColor.townHallGreen
                    : AppColor.townHallGreenDark,
                fontSize: FontSize.sp_10,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAvg(String title, String avg) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_3,
        vertical: Dimensions.h_3,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade500,
          width: 0.3,
        ),
        borderRadius: BorderRadius.circular(
          Dimensions.h_6,
        ),
      ),
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            title,
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: FontSize.sp_9,
              fontWeight: FontWeight.w500,
              height: 1.1,
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          Text(
            avg,
            style: TextStyle(
              color: Theme
                  .of(context)
                  .highlightColor,
              fontSize: FontSize.sp_16,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
        ],
      ),
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
            : Theme
            .of(context)
            .scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: isSelected ? null : Border.all(
          color: Theme
              .of(context)
              .focusColor,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? Colors.white
              : Theme
              .of(context)
              .primaryColor,
          fontSize: FontSize.sp_9_5,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
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
              Icon(CupertinoIcons.sparkles, size: Dimensions.h_15, color: Theme
                  .of(context)
                  .primaryColor),
              SizedBox(width: Dimensions.w_10),
              Text(
                'AI GOVERNMENT BRIEF',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  fontSize: FontSize.sp_12,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ],),
          SizedBox(height: Dimensions.h_8),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: Dimensions.w_8),
              shrinkWrap: true,
              itemCount: controller.politicsData?.hero?.aiBrief?.items
                  ?.length ?? 0,
              itemBuilder: (c, i) {
                return Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.h_6),
                  child: CommonBulletItem(
                      text: controller.politicsData?.hero?.aiBrief?.items?[i] ?? ''),
                );
              }),
          SizedBox(height: Dimensions.h_5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                  'Ask AI About Your Government',
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

  Widget buildHeroHeader(bool isLight) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedWeatherImage(
          height: Dimensions.h_350,
          image: "https://staging.wikixm.com${controller.politicsData?.hero
              ?.background?.mobile?.src}",
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
                    left: Dimensions.w_8, top: Dimensions.h_10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: controller.politicsData?.hero?.greeting?.text
                            ?.toUpperCase() ?? '',
                        style: TextStyle(
                          color: const Color(0xFFFFE47A),
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Text(
                          ' ${controller.politicsData?.hero?.greeting?.wave ??
                              ''}',
                          style: TextStyle(
                            color: const Color(0xFFFFE47A),
                            fontSize: FontSize.sp_18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_5),
                child: Text(
                  "${controller.politicsData?.hero?.eyebrow ?? ''} \n"
                      "${controller.politicsData?.hero?.title ?? ''}"
                      .toUpperCase(),
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
                  top: Dimensions.h_10,
                  right: Dimensions.w_60,
                ),
                child: Text(
                  controller.politicsData?.hero?.subtitle ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_12,
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
              communityStatsSection(),
              SizedBox(height: Dimensions.h_5),
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
    final stats = controller.politicsData?.hero?.stats ?? [];

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
                      icon: firstStat.icon ?? '',
                      value: '${firstStat.value ?? 0}',
                      label: firstStat.label ?? '',
                    ),
                  ),
                  Expanded(
                    child: secondStat != null
                        ? _communityStatItem(
                      icon: secondStat.icon ?? '',
                      value: '${secondStat.value ?? 0}',
                      label: secondStat.label ?? '',
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
    required String icon,
    required String value,
    required String label,
  }) {
    return Row(
      children: [
        SpriteSvgIcon(
          url: icon,
          width: Dimensions.h_16,
          height: Dimensions.h_16,
          color: Color(0xFf8fd9ae),
        ),
        SizedBox(width: Dimensions.w_8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: FontSize.sp_16,
                  fontWeight: FontWeight.w800,
                  color: AppColor.white
                ),
              ),
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
                    ]
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}