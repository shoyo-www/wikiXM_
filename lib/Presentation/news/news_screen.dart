import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/events/events_screen_shimmer.dart';
import 'package:wikixm/Presentation/widgets/circular_percent.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/extensions.dart';
import 'package:wikixm/data/datasource/local/local_storage.dart';
import '../../constants/constants.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../dashboard/controller.dart';
import '../widgets/cache_image.dart';
import '../widgets/common_bullet.dart';
import '../widgets/common_header.dart';
import '../widgets/common_metric.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  void initState() {
    if(mounted) {
      dashboardController.getCommunityData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetBuilder(
        id: ControllerBuilders.communityIntelligence,
        init: dashboardController,
        builder: (controller) {
          return controller.isLoading ? EventsScreenShimmer() : CommonScrollBlurScaffold(
            expandedHeight: Dimensions.h_280,
            expandedColor: Colors.white,
            collapsedColor: Theme.of(context).highlightColor,
            hero: buildHeroHeader(isLight),
            slivers: [
            SliverToBoxAdapter(child: firstCard(controller)),
            SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.h_15),
                      CommonSectionHeader(title: "TODAY'S SNAPSHOT", onActionTap: () {}),
                      SizedBox(height: Dimensions.h_10),
                      SizedBox(
                        height: Dimensions.h_80,
                        child: ListView.builder(
                          itemCount: controller.communityOverview?.today?.length ?? 0,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (c,i) {
                          var item = controller.communityOverview?.today?[i];
                          return  Padding(
                            padding:  EdgeInsets.only(right: Dimensions.w_5),
                            child: SizedBox(
                              width: Dimensions.w_70,
                              child: CommonMetricCard(
                                icon: AppCacheImage(
                                  imageUrl: '',
                                  isShadow: false,
                                  size: Dimensions.h_25,
                                  widthSize: Dimensions.h_25),
                                value: item?.value.toString() ?? '',
                                label: item?.label ?? '',
                                valueColor: Theme.of(context).highlightColor,
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: Dimensions.h_10),
                      CommonCard(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_4,
                            vertical: Dimensions.h_8
                        ),
                        child: Column(
                          children: [
                            CommonSectionHeader(
                              title: 'TOP STORY',
                              actionText: 'View All Stories',
                              icon: Icon(
                                Icons.star,
                                color: context.sports.primaryText,
                                size: Dimensions.h_12,
                              ),
                              onActionTap: () {
                              },
                            ),
                            SizedBox(height: Dimensions.h_6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    AppCacheImage(
                                      size: Dimensions.h_140,
                                      widthSize: Get.width,
                                      imageUrl:  controller.feedData?.conversations?.topStory?.image ?? "",
                                      isShadow: false,
                                      radius: Dimensions.h_6,
                                      borderColor: Colors.grey.shade200,
                                    ),
                                    if(controller.feedData?.conversations?.topStory?.category?.name?.isNotEmpty ?? false)
                                    Positioned(
                                      top: Dimensions.h_8,
                                      left: Dimensions.w_5,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.w_3,
                                          vertical: Dimensions.h_2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColor.intelligencePurple,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              controller.feedData?.conversations?.topStory?.category?.name?.toUpperCase() ?? '',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: FontSize.sp_8,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    Dimensions.w_8,
                                    0,
                                    Dimensions.w_8,
                                    0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: Dimensions.h_8),
                                      Text(
                                        maxLines: 2,
                                        controller.feedData?.conversations?.topStory?.title ?? '',
                                        style: TextStyle(
                                          color: Theme.of(context).highlightColor,
                                          fontSize: FontSize.sp_14,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.h_6),
                                      Padding(
                                        padding:  EdgeInsets.only(left: Dimensions.w_8),
                                        child: Text(
                                          maxLines: 3,
                                          controller.feedData?.conversations?.topStory?.excerpt ?? '',
                                          style: TextStyle(
                                            color: Theme.of(context).highlightColor,
                                            fontSize: FontSize.sp_10,
                                            fontWeight: FontWeight.w500,
                                            height: 1.25,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.h_6),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.feedData?.conversations?.topStory?.publishedLabel ?? '',
                                            style: TextStyle(
                                              color: Theme.of(context).highlightColor,
                                              fontSize: FontSize.sp_8_5,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.w_15),
                                          Container(
                                            height: Dimensions.h_2,
                                            width: Dimensions.h_2,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).highlightColor,
                                                shape: BoxShape.circle
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.w_15),
                                          Text(
                                            '${controller.feedData?.conversations?.topStory?.commentsCount} Comment',
                                            style: TextStyle(
                                              color: Theme.of(context).highlightColor,
                                              fontSize: FontSize.sp_8_5,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.w_15),
                                          Container(
                                            height: Dimensions.h_2,
                                            width: Dimensions.h_2,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).highlightColor,
                                                shape: BoxShape.circle
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.w_15),
                                          Text(
                                            '${controller.feedData?.conversations?.topStory?.sharesCount} Shares',
                                            style: TextStyle(
                                              color: Theme.of(context).highlightColor,
                                              fontSize: FontSize.sp_8_5,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(CupertinoIcons.bookmark,size: Dimensions.h_13,color: Theme.of(context).highlightColor)
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.h_2),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_15),
                      CommonSectionHeader(title: 'YOUR REPRESENTATIVES'),
                      SizedBox(height: Dimensions.h_10),
                      SizedBox(
                        height: Dimensions.h_140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: controller.feedData?.engagement?.representatives?.length ?? 0,
                          itemBuilder: (context, index) {
                            var item = controller.feedData?.engagement?.representatives?[index];
                            return Padding(
                              padding: EdgeInsets.only(right: Dimensions.w_6),
                              child: SizedBox(
                                width: Dimensions.w_110,
                                child: CommonCard(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.w_3,
                                    vertical: Dimensions.h_6,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppCacheImage(
                                            imageUrl: item?.image ?? '',
                                            widthSize: Dimensions.h_35,
                                            size: Dimensions.h_35,
                                            isShadow: false,
                                            radius: 50,
                                          ),
                                          SizedBox(width: Dimensions.w_8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (item?.role == 'Mayor') ...[
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: Dimensions.w_2,
                                                      vertical: Dimensions.h_1,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: isLight ? const Color(0xffbae7c4) : AppColor.darkGreenSportsSecondaryText,
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                    child: Text(
                                                      'MAYOR',
                                                      style: TextStyle(
                                                        color: isLight ? AppColor.darkGreenSportsSecondaryText : AppColor.white,
                                                        fontSize: FontSize.sp_8,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: Dimensions.h_4),
                                                ],
                                                Text(
                                                  item?.name ?? '',
                                                  style: TextStyle(
                                                    color: Theme.of(context).highlightColor,
                                                    fontSize: FontSize.sp_11,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.2
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.h_15),
                                      Text(
                                        '${item?.role} of ${item?.district ?? 'Seattle'}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).highlightColor,
                                          fontSize: FontSize.sp_9,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.h_8),
                                      const Spacer(),
                                      Text(
                                        'Tagged in ${item?.taggedTopicCount} Topics',
                                        style: TextStyle(
                                          color: Theme.of(context).highlightColor,
                                          fontSize: FontSize.sp_8_5,
                                          fontWeight: FontWeight.w700,
                                          height: 1.1,
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.h_8),
                                      Container(
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
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons.chat_bubble_text,
                                              color: Theme.of(context).highlightColor,
                                              size: Dimensions.h_11,
                                            ),
                                            SizedBox(width: Dimensions.w_4),
                                            Text(
                                              'Contact',
                                              style: TextStyle(
                                                color: Theme.of(context).highlightColor,
                                                fontSize: FontSize.sp_9,
                                                fontWeight: FontWeight.w700,
                                                height: 1.1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Dimensions.h_10),
                        padding: EdgeInsets.only(
                            top: Dimensions.h_5,
                            left: Dimensions.w_10,
                            bottom: Dimensions.h_10
                        ),
                        decoration: BoxDecoration(
                            color: isLight ? const Color(0xffefebfc) : const Color(0xFF211841),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("TODAY'S COMMUNITY QUESTION", style: TextStyle(
                                color: isLight ? AppColor.intelligencePurple : const Color(0xffbfa7ff),
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w700
                            )),
                            SizedBox(height: Dimensions.h_5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(CupertinoIcons.question_circle_fill, color: isLight ? AppColor.intelligencePurple : const Color(0xff5326cf), size: Dimensions.h_35),
                                SizedBox(width: Dimensions.w_10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.feedData?.rightRail?.communityQuestion?.question ?? '', style: TextStyle(
                                          color: Theme.of(context).highlightColor,
                                          fontSize: FontSize.sp_14,
                                          fontWeight: FontWeight.w800
                                      )),
                                      SizedBox(height: Dimensions.h_6),
                                      Text(
                                        '${controller.feedData?.rightRail?.communityQuestion?.totalVotes } votes',
                                        style: TextStyle(
                                          color: Theme.of(context).highlightColor,
                                          fontSize: FontSize.sp_9_5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_6),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: Dimensions.h_6),
                              margin: EdgeInsets.only(left: Dimensions.w_30,right: Dimensions.w_20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: isLight ? AppColor.intelligencePurple : const Color(0xFF5326cf)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Vote Now', style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_11,
                                      fontWeight: FontWeight.w800
                                  )),
                                  SizedBox(width: Dimensions.w_5),
                                  Icon(CupertinoIcons.chart_bar_alt_fill,size: Dimensions.h_12,color: Colors.white),
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.h_5),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: Dimensions.h_6),
                              margin: EdgeInsets.only(left: Dimensions.w_30,right: Dimensions.w_20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: isLight ? AppColor.intelligencePurple : AppColor.white,
                                      width: 0.5
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.chat_bubble_text,size: Dimensions.h_12,color: isLight ? AppColor.intelligencePurple : AppColor.white),
                                  SizedBox(width: Dimensions.w_5),
                                  Text('Join Discussion', style: TextStyle(
                                      color: isLight ? AppColor.intelligencePurple : AppColor.white,
                                      fontSize: FontSize.sp_11,
                                      fontWeight: FontWeight.w700
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      meetings(controller, context),
                      SizedBox(height: Dimensions.h_15),
                      CommonSectionHeader(title: "EXPLORE BY TOPIC",actionText: 'Swipe to explore'),
                      SizedBox(height: Dimensions.h_8),
                      category(),
                      SizedBox(height: Dimensions.h_15),
                      CommonSectionHeader(title: "MORE LOCAL INTELLIGENCE",actionText: 'View All'),
                      CommonCard(
                        margin: EdgeInsets.only(top: Dimensions.h_10),
                        padding: EdgeInsets.only(top: Dimensions.h_4, bottom: Dimensions.h_4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.feedData?.localIntelligence?.items?.length ?? 0,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemBuilder: (c,i) {
                                var item = controller.feedData?.localIntelligence?.items?[i];
                                  return Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(width: Dimensions.w_10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item?.category?.name?.toUpperCase() ?? '',
                                                  style: TextStyle(
                                                    color: Theme.of(context).canvasColor,
                                                    fontSize: FontSize.sp_9,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(height: Dimensions.h_6),
                                                Text(
                                                  item?.title ?? '',
                                                  style: TextStyle(
                                                    color: Theme.of(context).highlightColor,
                                                    fontSize: FontSize.sp_12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(height: Dimensions.h_2),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item?.publishedLabel ?? '',
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Theme.of(context).highlightColor,
                                                        fontSize: FontSize.sp_9,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.1,
                                                      ),
                                                    ),
                                                    SizedBox(width: Dimensions.w_8),
                                                    Container(
                                                      height: Dimensions.h_2,
                                                      width: Dimensions.h_2,
                                                      decoration: BoxDecoration(
                                                          color: Theme.of(context).highlightColor,
                                                          shape: BoxShape.circle
                                                      ),
                                                    ),
                                                    SizedBox(width: Dimensions.w_8),
                                                    Text(
                                                      '${item?.commentsCount} comments',
                                                      style: TextStyle(
                                                        color: Theme.of(context).highlightColor,
                                                        fontSize: FontSize.sp_9,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.w_10),
                                          AppCacheImage(imageUrl: item?.image ?? '',
                                              size: Dimensions.h_70,
                                              widthSize: Dimensions.h_70,
                                              radius: Dimensions.h_6,
                                              isShadow: false),
                                          SizedBox(width: Dimensions.w_5),
                                          Icon(Icons.arrow_forward_ios_rounded, color: Theme.of(context).highlightColor, size: Dimensions.h_12),
                                          SizedBox(width: Dimensions.w_5),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: Dimensions.h_4),
                                        color: Theme.of(context).focusColor,
                                        height: 0.5,
                                      ),
                                    ],
                                  );
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "View All Local Stories",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_8),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Theme.of(context).primaryColorDark,
                                  size: Dimensions.h_12,
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_3)
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_15),
                      CommonSectionHeader(title: 'AROUND YOUR REGION',actionText: 'Swipe to explore'),
                      SizedBox(height: Dimensions.h_8),
                      Builder(
                        builder: (c) {
                          final levelList = controller.feedData?.levelIntelligence?.levels ?? [];
                          final levelsWithItems = levelList.where((level) => (level.items ?? []).isNotEmpty).toList();
                          return SizedBox(
                            height: Dimensions.h_140,
                            child: levelsWithItems.isEmpty
                                ? const SizedBox()
                                : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: levelsWithItems.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: Dimensions.w_8),
                              itemBuilder: (context, index) {
                                final level = levelsWithItems[index];
                                final item = level.items!.first;
                                return SizedBox(
                                  width: Dimensions.w_110,
                                  child: CommonCard(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.w_5,
                                      vertical: Dimensions.h_4,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${level.name?.toUpperCase()}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                            Theme.of(context).canvasColor,
                                            fontSize: FontSize.sp_8_5,
                                            fontWeight: FontWeight.w900),
                                        ),
                                        SizedBox(height: Dimensions.h_3),
                                        Text(
                                          item.title ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            color: Theme.of(context).highlightColor,
                                            fontSize: FontSize.sp_9_5,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.h_6),
                                        Expanded(
                                          child: AppCacheImage(
                                            imageUrl: item.image ?? '',
                                            size: double.infinity,
                                            widthSize: Dimensions.w_100,
                                            radius: Dimensions.h_6,
                                            isShadow: false,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.h_5),
                                        Row(
                                          children: [
                                            Text(
                                              "View",
                                              style: TextStyle(
                                                color:
                                                Theme.of(context).primaryColorDark,
                                                fontSize: FontSize.sp_10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.w_3),
                                            Icon(
                                              Icons.arrow_forward,
                                              color:
                                              Theme.of(context).primaryColorDark,
                                              size: Dimensions.h_11,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: Dimensions.h_15),
                      CommonSectionHeader(title: 'COMMUNITY LIFE',actionText: 'View All'),
                      SizedBox(height: Dimensions.h_8),
                      SizedBox(
                        height: Dimensions.h_130,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: quickActionList.length,
                          separatorBuilder: (_, __) => SizedBox(width: Dimensions.w_3),
                          itemBuilder: (context, index) {
                            final item = quickActionList[index];
                            return SizedBox(
                              width: Dimensions.w_85,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppCacheImage(
                                    imageUrl: item.image,
                                    size: Dimensions.h_70,
                                    widthSize: Dimensions.h_70,
                                    radius: Dimensions.h_8,
                                    isShadow: false,
                                  ),
                                  SizedBox(height: Dimensions.h_6),
                                  Text(
                                    item.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontSize: FontSize.sp_10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (item.subTitle.isNotEmpty)
                                    Text(
                                      item.subTitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontSize: FontSize.sp_10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  SizedBox(height: Dimensions.h_4),
                                  Text(
                                    item.count,
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
                            );
                          },
                        ),
                      ),
                      sponsor(controller,isLight),
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
                                    "Ask anything about community",
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
                    ],
                  ),
                )
            ),
            SliverToBoxAdapter(child: SizedBox(height: Dimensions.h_65))]);
        }
      ));
  }

  Widget meetings(DashboardController controller, BuildContext context) {
    return (controller.feedData?.rightRail?.meetings?.items?.isEmpty ?? false)
        ? SizedBox.shrink()
        : Column(
      children: [
        SizedBox(height: Dimensions.h_15),
        CommonSectionHeader(title: "TODAY'S MEETINGS & EVENTS", actionText: 'View Calendar'),
        CommonCard(
          margin: EdgeInsets.only(top: Dimensions.h_10),
          padding: EdgeInsets.only(top: Dimensions.h_4, bottom: Dimensions.h_4),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: controller.feedData?.rightRail?.meetings?.items?.length ?? 0,
              itemBuilder: (c, i) {
                var item = controller.feedData?.rightRail?.meetings?.items?[i];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: Dimensions.w_10),
                    Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).canvasColor,
                      size: Dimensions.h_22),
                    SizedBox(width: Dimensions.w_10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                item?.title ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .highlightColor,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w600,
                                  height: 1.1,
                                ),
                              ),
                              SizedBox(width: Dimensions.w_5),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.w_5,
                                  vertical: Dimensions.h_1,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.darkGreenSportsSecondaryText,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'LIVE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_8,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.h_2),
                          Text(
                            item?.startsLabel ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .highlightColor,
                              fontSize: FontSize.sp_9,
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.h_3, horizontal: Dimensions.w_5),
                      margin: EdgeInsets.only(
                          left: Dimensions.w_30, right: Dimensions.w_5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: AppColor.darkGreenSportsSecondaryText,
                              width: 0.5
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.play_arrow_solid,
                              size: Dimensions.h_12,
                              color: AppColor.darkGreenSportsSecondaryText),
                          SizedBox(width: Dimensions.w_3),
                          Text('Watch Live', style: TextStyle(
                              color: AppColor.darkGreenSportsSecondaryText,
                              fontSize: FontSize.sp_9,
                              fontWeight: FontWeight.w900
                          )),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      ],
    );
  }

  Widget sponsor(DashboardController controller,bool isLight) {
    final sponsorData = controller.feedData?.rightRail?.sponsor;
    final sponsorConfig = controller.feedData?.rightRail?.config?.sponsor;
    return Container(
      padding: EdgeInsets.only(
        top: Dimensions.h_5,
        left: Dimensions.w_6,
        right: Dimensions.w_6,
        bottom: Dimensions.h_4),
      decoration: BoxDecoration(
        color: isLight ?  const Color(0xfffdf5e9) : const Color(0xff271f17),
        border: Border.all(
          color: isLight ? const Color(0xfff9bfa5) : const Color(0xff271f17),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sponsorConfig?.title ??
                      "TODAY'S COMMUNITY PARTNER",
                  style: TextStyle(
                    color: isLight ? AppColor.alertRed : const Color(0xFFe1ad77),
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: Dimensions.h_5),
                Text(
                  sponsorData?.name ?? 'SEATTLE CREDIT UNION',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.sp_14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: Dimensions.h_4),
                Text(
                  sponsorData?.description ??
                      "Proudly supporting Seattle's journalism, civic engagement, and community programs",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.sp_9_5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: Dimensions.h_15),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.h_5,
                    horizontal: Dimensions.w_10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isLight ? AppColor.alertRed : const Color(0xFFe1ad77),
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    sponsorData?.impact?.label ??
                        sponsorConfig?.impactLabel ??
                        'Learn More',
                    style: TextStyle(
                      color: isLight ? AppColor.alertRed : const Color(0xFFe1ad77),
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppCacheImage(
            imageUrl: sponsorData?.logo ??
                'https://imgs.search.brave.com/yXH1zrX8YGjSNlripriq_5AbxgAxtZ2P01OEKFPNqeY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTM3/MTk0MDEyOC9waG90/by9tdWx0aXJhY2lh/bC1mcmllbmRzLXRh/a2luZy1iaWctZ3Jv/dXAtc2VsZmllLXNo/b3Qtc21pbGluZy1h/dC1jYW1lcmEtbGF1/Z2hpbmcteW91bmct/cGVvcGxlLmpwZz9z/PTYxMng2MTImdz0w/Jms9MjAmYz1GUHMt/QzkyemJONlJrSG5Q/RzRGbDl6eVAyLUha/V0d5OVByZHQ0Nllu/LUlZPQ',
            widthSize: Dimensions.w_150,
            size: Dimensions.h_110,
            isShadow: false,
          ),
        ],
      ),
    );
  }

  Widget category() {
    final List<IntelligenceCategory> intelligenceList = [
      IntelligenceCategory(
        title: "Government",
        subTitle: "Intelligence",
        updates: "12 new updates",
        color: const Color(0xff1551E0),
        icon: CupertinoIcons.building_2_fill,
      ),
      IntelligenceCategory(
        title: "Sports",
        subTitle: "Intelligence",
        updates: "14 new updates",
        color: const Color(0xff15843D),
        icon: CupertinoIcons.sportscourt,
      ),
      IntelligenceCategory(
        title: "Business",
        subTitle: "Intelligence",
        updates: "9 new updates",
        color: const Color(0xff5A1FC8),
        icon: CupertinoIcons.briefcase_fill,
      ),
      IntelligenceCategory(
        title: "Education",
        subTitle: "Intelligence",
        updates: "8 new updates",
        color: const Color(0xffD83A2F),
        icon: CupertinoIcons.book_fill,
      ),
    ];
    return SizedBox(
      height: Dimensions.h_170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: intelligenceList.length,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_5),
        itemBuilder: (context, index) {
          final item = intelligenceList[index];

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: ()=> index == 1 ? Get.toNamed(AppRoutes.sports) : index == 2 ? Get.toNamed(AppRoutes.business) : index == 3 ? Get.toNamed(AppRoutes.school) : Get.toNamed(AppRoutes.politics),
            child: Container(
              width: Dimensions.w_100,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: BorderRadius.circular(Dimensions.h_8),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_8,
                      vertical: Dimensions.h_5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          item.icon,
                          color: Colors.white,
                          size: Dimensions.h_30,
                        ),
                        SizedBox(height: Dimensions.h_8),
                        Text(
                          item.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          item.subTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: Dimensions.h_6),
                        Text(
                          item.updates,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: Dimensions.h_5),
                        Icon(
                          Icons.trending_up,
                          color: const Color(0xff35E35B),
                          size: Dimensions.h_35,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.w_8,
                        Dimensions.h_60,
                        Dimensions.w_8,
                        Dimensions.h_10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.h_8),
                          bottomRight: Radius.circular(Dimensions.h_8),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.0),
                            Colors.black.withValues(alpha: .25),
                            Colors.black.withValues(alpha: .45),
                            Colors.black.withValues(alpha: .80),
                          ],
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_8,
                          vertical: Dimensions.h_6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white,
                            width: .6,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Explore",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: Dimensions.w_3),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: Dimensions.h_12,
                            ),
                          ],
                        ),
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

  Widget secondCard() {
    return CommonCard(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_8,
        Dimensions.h_8,
        Dimensions.w_8,
        0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.sun_max,
                color: context.sports.primaryText,
                size: Dimensions.h_18,
              ),
              SizedBox(width: Dimensions.w_5),
              Text(
                'TODAY IN ${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.sports.primaryText,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Dimensions.h_3,
                      left: Dimensions.w_8,
                      right: Dimensions.w_3),
                  child: Text(
                    'Busy day ahead! 6 government meetings, 18 community events, sunny with a high of 72°. Waterfront vote',
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
             AppCacheImage(imageUrl: Images.sunny,size: Dimensions.h_40,widthSize: Dimensions.h_70,isShadow: false)
            ],
          ),
        ],
      ),
    );
  }

  Widget firstCard(DashboardController controller) {
    return CommonCard(
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
                    Icon(
                      CupertinoIcons.sun_max_fill,
                      color: Theme.of(context).canvasColor,
                      size: Dimensions.h_18,
                    ),
                    SizedBox(width: Dimensions.w_5),
                    Expanded(
                      child: Text(
                        'AI MORNING BRIEF',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                    ),
                    Text(
                      controller.feedData?.rightRail?.morningBrief?.updatedLabel ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_9,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    )
                  ],
                ),
                SizedBox(height: Dimensions.h_6),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: Dimensions.w_8),
                    shrinkWrap: true,
                    itemCount: controller.feedData?.rightRail?.morningBrief?.items?.length ?? 0,
                    itemBuilder: (c,i) {
                    var item = controller.feedData?.rightRail?.morningBrief?.items?[i];
                  return Padding(
                    padding:  EdgeInsets.only(bottom: Dimensions.h_6),
                    child: CommonBulletItem(text: item?.title ?? ''),
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Read Full Brief',
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
          ),
          SizedBox(width: Dimensions.w_8),
        ],
      ),
    );
  }

  Widget buildHeroHeader(bool isLight) {
    return GetBuilder(
      id: ControllerBuilders.homeController,
      init: dashboardController,
      builder: (c) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            AppCacheImage(imageUrl: c.communityOverview?.location?.image ?? '',
            widthSize: Get.width,
            errorImage: isLight ? Images.cityImageMobileDay:Images.cityImageMobile,
            size: Dimensions.h_310,
            radius: 0),
            Positioned(
              child: Container(
                height: Dimensions.h_312,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xE6020B15).withValues(alpha: 0.60),
                      Color(0x99020B15).withValues(alpha: 0.40),
                      Color(0x99020B15).withValues(alpha: 0.20),
                      Color(0x00000000),
                      Color(0x00000000),
                    ],
                    stops: [0.20, 0.45,0.65, 0.78, 1],
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
                    "${c.communityOverview?.location?.name?.toUpperCase() ?? ''} , ${c.communityOverview?.location?.abbreviation ?? ''}",
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
                  padding:  EdgeInsets.only(left: Dimensions.w_8,top: Dimensions.h_10),
                  child: Text(
                    "Here's your 60-second community briefing.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.sp_11,
                      fontWeight: FontWeight.w600,
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
                SizedBox(height: Dimensions.h_18),
                CommunityIntelligenceCard(controller: dashboardController),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    Dimensions.w_5,
                    Dimensions.h_18,
                    Dimensions.w_5,
                    Dimensions.h_5,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: isLight ? null :[
                      BoxShadow(
                        color: Color(0xE6020B15),
                        offset: Offset(0, 150),
                        spreadRadius: 70,
                        blurRadius: 1,
                      ),
                    ],
                      gradient: isLight ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x00FFFFFF),
                          Color(0x33FFFFFF),
                          Color(0xCCFFFFFF),
                          Color(0xFFFFFFFF),
                          AppColor.background
                        ],
                        stops: [
                          0.08,
                          0.25,
                          0.45,
                          0.75,
                          1.0,
                        ],
                      ) :LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x00000000),
                          Color(0x00000000),
                          Color(0xE6020B15).withValues(alpha: 0.78),
                          Color(0xE6020B15),
                          Color(0x99020B15),
                        ],
                        stops: [0.08,0.20, 0.35, 0.78, 1],
                      ),
                   ),
                  child: Column(
                    children: [
                      Builder(
                        builder: (context) {
                          final snapshotList =
                          (c.communityOverview?.snapshot ?? []).take(4).toList();

                          return IntrinsicHeight(
                            child: Row(
                              children: List.generate(snapshotList.length, (index) {
                                final item = snapshotList[index];

                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: index != snapshotList.length - 1
                                          ? Dimensions.w_4
                                          : 0,
                                    ),
                                    child: _commonStatusCard(
                                      title: item.label ?? '',
                                      value: '${item.value ?? 0}',
                                      valueColor: _getSnapshotColor(
                                        item.variant,
                                      ),
                                      icon: _getSnapshotIcon(
                                        item.key ?? '',
                                        item.variant ?? '',
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: Dimensions.h_8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.clock,
                                color: Theme.of(context).highlightColor,
                                size: Dimensions.h_15,
                              ),
                              SizedBox(width: Dimensions.w_4),
                              Text(
                                c.feedData?.rightRail?.morningBrief?.updatedLabel ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).highlightColor,
                                  fontSize: FontSize.sp_9_5,
                                  fontWeight: FontWeight.w600,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.w_10,
                                vertical: Dimensions.h_4
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0x00000000),
                                border: Border.all(
                                  color: Color(0xff585317),
                                  width: isLight ? 0.5:1
                                ),
                                borderRadius: BorderRadius.circular(Dimensions.h_8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.sparkles,
                                  color: AppColor.darkGreenSportsSecondaryText,
                                  size: Dimensions.h_15
                                ),
                                SizedBox(width: Dimensions.w_4),
                                Text(
                                  'Read Al Morning Brief',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_4),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: Dimensions.h_13,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _commonStatusCard({
    required String title,
    required String value,
    required Widget icon,
    Color valueColor = Colors.black87,
  }) {
    return CommonCard(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_2,
        vertical: Dimensions.h_3
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(width: Dimensions.w_8),
              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: FontSize.sp_15,
                  fontWeight: FontWeight.w900,
                  height: 1.05,
                ),
              )
            ],
          ),
          SizedBox(height: Dimensions.h_4),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: FontSize.sp_8_5,
                fontWeight: FontWeight.w500,
                height: 1.05,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _getSnapshotIcon(String key, String variant) {
    final color = _getSnapshotColor(variant);

    switch (key.toLowerCase()) {
      case 'local_updates_today':
        return Icon(
          CupertinoIcons.doc_text_fill,
          color: color,
          size: Dimensions.h_15,
        );

      case 'active_town_hall_topics':
        return Icon(
          Icons.calendar_today_outlined,
          color: color,
          size: Dimensions.h_13,
        );

      case 'community_contributions_today':
        return Icon(
          CupertinoIcons.ticket_fill,
          color: color,
          size: Dimensions.h_15,
        );

      case 'upcoming_events':
        return Icon(
          CupertinoIcons.doc_on_clipboard_fill,
          color: color,
          size: Dimensions.h_15,
        );

      case 'listed_businesses':
        return Icon(
          CupertinoIcons.bell_fill,
          color: color,
          size: Dimensions.h_18,
        );

      default:
        return Icon(
          CupertinoIcons.circle_grid_3x3_fill,
          color: color,
          size: Dimensions.h_18,
        );
    }
  }

  Color _getSnapshotColor(String? variant) {
    switch (variant?.toLowerCase()) {
      case 'blue':
        return const Color(0xFF4A90E2);

      case 'violet':
        return const Color(0xFF7B61FF);

      case 'orange':
        return const Color(0xFFFB7E25);

      case 'red':
        return const Color(0xFFF30E12);

      default:
        return Theme.of(Get.context!).highlightColor;
    }
  }

}


