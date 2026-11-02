import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/activity_meta.dart';
import '../widgets/common_shimmer.dart';
import 'package:intl/intl.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import 'package:wikixm/Presentation/groups/groups_drawer.dart';
import '../widgets/cache_image.dart';
import '../widgets/entrance_animation.dart';
import '../widgets/map.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final GroupController groupController = Get.put(GroupController());

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final blue = AppColor.blue(context);
    final green = AppColor.green(context);

    return GroupsDrawer(
      builder: (openDrawer) => AppScaffold(
          top: false,
          bottom: false,
          bodyPadding: EdgeInsets.zero,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: GetBuilder(
            init: groupController,
            id: ControllerBuilders.groupController,
            builder: (controller) {
              return controller.isLoading
                  ? pageShimmer()
                  : CommonScrollBlurScaffold(
                      showBack: true,
                      isDrawer: true,
                      onTap: openDrawer,
                      expandedHeight: Dimensions.h_256,
                      expandedColor: Colors.white,
                      collapsedColor: Theme.of(context).highlightColor,
                      hero: buildHeroHeader(isLight, controller),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: staggered([
                                SizedBox(height: Dimensions.h_15),
                                Row(
                                  children: [
                                    Text(
                                      controller.groupData?.interests?.title ?? '',
                                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'View All ',
                                            style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                                          ),
                                          Icon(CupertinoIcons.arrow_right, color: Theme.of(context).primaryColorDark, size: Dimensions.h_12),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: Dimensions.w_6, top: Dimensions.h_2),
                                  child: Text(
                                    controller.groupData?.interests?.description ?? '',
                                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.1),
                                  ),
                                ),
                                SizedBox(height: Dimensions.h_10),
                                SizedBox(
                                  height: Dimensions.h_135,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.groupData?.interests?.items?.length ?? 0,
                                    itemBuilder: (context, i) {
                                      final community = controller.groupData?.interests?.items?[i];
                                      final color = groupInterestColor(community?.color, isLight);
                                      final softColor = groupInterestSoftColor(community?.color, isLight);
                                      return GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () => groupController.openInterest(community?.id ?? ''),
                                        child: CommonCard(
                                          width: Dimensions.h_115,
                                          padding: EdgeInsets.zero,
                                          margin: EdgeInsets.only(right: Dimensions.w_8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.h_10), topLeft: Radius.circular(Dimensions.h_10)),
                                                child: AppCacheImage(radius: 0, imageUrl: community?.image?.url ?? '', size: Dimensions.h_80, widthSize: Dimensions.h_115, isShadow: false),
                                              ),
                                              SizedBox(height: Dimensions.h_10),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      height: Dimensions.h_20,
                                                      width: Dimensions.h_20,
                                                      decoration: BoxDecoration(color: softColor, shape: BoxShape.circle),
                                                      child: Icon(groupInterestIcon(community?.icon), size: Dimensions.h_12, color: color),
                                                    ),
                                                    SizedBox(width: Dimensions.w_10),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            community?.name ?? '',
                                                            style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor, height: 1.1),
                                                          ),
                                                          Text(
                                                            community?.groupsLabel ?? '',
                                                            style: TextStyle(fontSize: FontSize.sp_10, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: Dimensions.h_5),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: Dimensions.h_20),
                                Row(
                                  children: [
                                    Text(
                                      controller.groupSectionData?.activities?.title ?? '',
                                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'View Calender ',
                                            style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                                          ),
                                          Icon(CupertinoIcons.arrow_right, color: Theme.of(context).primaryColorDark, size: Dimensions.h_12),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: Dimensions.w_6, top: Dimensions.h_2),
                                  child: Text(
                                    controller.groupSectionData?.activities?.description ?? '',
                                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(height: Dimensions.h_10),
                                (controller.groupSectionData?.activities?.items?.isEmpty ?? false)
                                    ? CommonCard(
                                        width: Get.width,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: Dimensions.h_30),
                                          child: Text(
                                            controller.groupSectionData?.activities?.emptyMessage ?? '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: FontSize.sp_13_5, color: Theme.of(context).highlightColor),
                                          ),
                                        ),
                                      )
                                    : GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: controller.groupSectionData?.activities?.items?.length ?? 0,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: Dimensions.w_6,
                                          mainAxisSpacing: Dimensions.h_6,
                                          mainAxisExtent: Dimensions.h_300,
                                        ),
                                        itemBuilder: (context, index) {
                                          final activity = controller.groupSectionData?.activities?.items?[index];
                                          final details = activity?.details ?? [];
                                          final attendees = activity?.attendees ?? [];
                                          final badgeLabel = activity?.badge?.label ?? '';

                                          return GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () => controller.openGroupsHomeActivity(activity),
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
                                                        child: AppCacheImage(imageUrl: activity?.image?.url ?? '', size: Dimensions.h_120, widthSize: Get.width, fit: BoxFit.cover, radius: 0),
                                                      ),
                                                      if (badgeLabel.isNotEmpty)
                                                        Positioned(
                                                          top: Dimensions.h_6,
                                                          left: Dimensions.w_8,
                                                          child: Container(
                                                            decoration: BoxDecoration(color: groupActivityBadgeColor(activity?.badge?.color, isLight), borderRadius: BorderRadius.circular(Dimensions.h_3)),
                                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_2),
                                                            child: Text(
                                                              badgeLabel,
                                                              style: TextStyle(color: AppColor.micrositeWhite(context), fontSize: FontSize.sp_8, fontWeight: FontWeight.w800),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),

                                                  SizedBox(height: Dimensions.h_8),

                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          activity?.title ?? '',
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor, height: 1),
                                                        ),
                                                        SizedBox(height: Dimensions.h_10),
                                                        activityMeta(
                                                          context,
                                                          details.isNotEmpty ? groupActivityDetailIcon(details[0].icon) : CupertinoIcons.clock,
                                                          details.isNotEmpty ? details[0].text ?? '' : formatGroupActivityDate(activity?.startsAt),
                                                        ),
                                                        SizedBox(height: Dimensions.h_5),
                                                        activityMeta(
                                                          context,
                                                          details.length > 1 ? groupActivityDetailIcon(details[1].icon) : CupertinoIcons.location_solid,
                                                          details.length > 1 ? details[1].text ?? '' : '',
                                                        ),
                                                        SizedBox(height: Dimensions.h_5),
                                                        activityMeta(
                                                          context,
                                                          details.length > 2 ? groupActivityDetailIcon(details[2].icon) : CupertinoIcons.triangle,
                                                          details.length > 2 ? details[2].text ?? '' : '',
                                                        ),
                                                        SizedBox(height: Dimensions.h_5),
                                                        activityMeta(
                                                          context,
                                                          details.length > 3 ? groupActivityDetailIcon(details[3].icon) : CupertinoIcons.person_2_fill,
                                                          details.length > 3 ? details[3].text ?? '' : '',
                                                        ),
                                                        SizedBox(height: Dimensions.h_12),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: Dimensions.w_50,
                                                              height: Dimensions.h_20,
                                                              child: Stack(children: attendees.take(3).toList().asMap().entries.map((entry) => avatar(entry.value.url ?? '', entry.key)).toList()),
                                                            ),
                                                            SizedBox(width: Dimensions.w_8),
                                                            Expanded(
                                                              child: Text(
                                                                '${activity?.goingCount ?? 0} going · ${activity?.spotsAvailable ?? 0} spots left',
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(fontSize: FontSize.sp_8_5, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: Dimensions.h_10),
                                                        SizedBox(
                                                          width: double.infinity,
                                                          height: Dimensions.h_28,
                                                          child: ElevatedButton(
                                                            onPressed: () {},
                                                            style: ElevatedButton.styleFrom(
                                                              elevation: 0,
                                                              backgroundColor: activity?.isJoined == true ? green : blue,
                                                              foregroundColor: AppColor.groupsWhite(context),
                                                              padding: EdgeInsets.zero,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                                                            ),
                                                            child: Text(
                                                              activity?.isJoined == true ? 'Leave Activity' : 'Join Activity',
                                                              style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: Colors.white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
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
                                      controller.groupSectionData?.featuredGroups?.title ?? '',
                                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'View All Groups ',
                                            style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                                          ),
                                          Icon(CupertinoIcons.arrow_right, color: Theme.of(context).primaryColorDark, size: Dimensions.h_12),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: Dimensions.w_6, top: Dimensions.h_2),
                                  child: Text(
                                    controller.groupSectionData?.featuredGroups?.description ?? '',
                                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.1),
                                  ),
                                ),
                                SizedBox(height: Dimensions.h_10),
                                if ((controller.groupSectionData?.featuredGroups?.items?.isEmpty ?? true))
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_20),
                                    child: Text(
                                      controller.groupSectionData?.featuredGroups?.emptyMessage ?? '',
                                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                                    ),
                                  )
                                else
                                  GetBuilder<GroupController>(
                                    id: ControllerBuilders.groupFeatured,
                                    builder: (controller) {
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: controller.groupSectionData?.featuredGroups?.items?.length ?? 0,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: Dimensions.w_6,
                                          mainAxisSpacing: Dimensions.h_6,
                                          mainAxisExtent: Dimensions.h_240,
                                        ),
                                        itemBuilder: (context, index) {
                                          final featured = controller.groupSectionData?.featuredGroups?.items?[index];
                                          final groupId = controller.groupIdOf(featured);
                                          final isJoined = featured?.isJoined == true;
                                          final isProcessing = controller.processingGroupIds.contains(groupId);
                                          return GestureDetector(
                                            onTap: () => controller.openFeaturedGroup(featured),
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
                                                        child: AppCacheImage(imageUrl: featured?.image?.url ?? '', size: Dimensions.h_120, widthSize: Get.width, fit: BoxFit.cover, radius: 0),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: Dimensions.h_6),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            featured?.title ?? '',
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor, height: 1.1),
                                                          ),
                                                          SizedBox(height: Dimensions.h_10),
                                                          ActivityMeta(icon:CupertinoIcons.person, text: featured?.membersLabel ?? ''),
                                                          SizedBox(height: Dimensions.h_5),
                                                          ActivityMeta(icon:  CupertinoIcons.person_2, text :featured?.description ?? ''),
                                                          SizedBox(height: Dimensions.h_3),
                                                          const Spacer(),
                                                          GestureDetector(
                                                            behavior: HitTestBehavior.opaque,
                                                            onTap: featured?.isOwner == true ? null : isProcessing ? null : () => controller.joinGroup(isJoined, groupId),
                                                            child: Container(
                                                              width: Get.width,
                                                              height: Dimensions.h_28,
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                color: featured?.isOwner == true ? green :isProcessing
                                                                    ? Colors.transparent
                                                                    : isJoined
                                                                    ? green
                                                                    : Colors.transparent,
                                                                border: Border.all(
                                                                  color: isProcessing
                                                                      ? blue
                                                                      : isJoined
                                                                      ? Colors.transparent
                                                                      : blue,
                                                                  width: 0.5,
                                                                ),
                                                                borderRadius: BorderRadius.circular(99),
                                                              ),
                                                              child: isProcessing
                                                                  ? SizedBox(height: Dimensions.h_13, width: Dimensions.h_13, child: const CircularProgressIndicator(strokeWidth: 2))
                                                                  : Text(
                                                                featured?.isOwner == true ?  'Group Owner': isJoined ? 'Leave group' : 'Join Group',
                                                                      style: TextStyle(
                                                                        fontSize: FontSize.sp_11,
                                                                        fontWeight: FontWeight.w700,
                                                                        color: isJoined ? (isLight ? AppColor.white : Colors.black87) : blue,
                                                                      ),
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
                                      );
                                    },
                                  ),
                                SizedBox(height: Dimensions.h_20),
                                NearbyMap(nearby: controller.groupSectionData?.nearby),
                                SizedBox(height: Dimensions.h_20),
                                buildPeopleSection(blue, isLight, controller),
                                SizedBox(height: Dimensions.h_30),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
      ),
    );
  }

  Widget pageShimmer() {
    Widget header() => Padding(
      padding: EdgeInsets.only(top: Dimensions.h_20, bottom: Dimensions.h_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [ShimmerBox(Dimensions.w_150, Dimensions.h_13), const Spacer(), ShimmerBox(Dimensions.w_65, Dimensions.h_10)]),
          SizedBox(height: Dimensions.h_6),
          ShimmerBox(Dimensions.w_220, Dimensions.h_10),
        ],
      ),
    );
    Widget gridCard(double height, int lines) => ShimmerCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(double.infinity, Dimensions.h_120, radius: Dimensions.h_10),
          Padding(
            padding: EdgeInsets.all(Dimensions.h_8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(double.infinity, Dimensions.h_12),
                SizedBox(height: Dimensions.h_4),
                for (final w in [Dimensions.w_97, Dimensions.w_120, Dimensions.w_80].take(lines)) ShimmerIconLine(w),
              ],
            ),
          ),
          const Spacer(),
          Padding(padding: EdgeInsets.fromLTRB(Dimensions.w_8, 0, Dimensions.w_8, Dimensions.h_8), child: ShimmerBox(double.infinity, Dimensions.h_28, radius: 99)),
        ],
      ),
      height: height,
      padding: EdgeInsets.zero,
    );
    Widget grid(double height, int lines) => Row(
      children: [
        Expanded(child: gridCard(height, lines)),
        SizedBox(width: Dimensions.w_6),
        Expanded(child: gridCard(height, lines)),
      ],
    );

    return CommonShimmer(
      heroHeight: Dimensions.h_256,
      hero: [
        ShimmerBox(Dimensions.w_35, Dimensions.h_33, radius: Dimensions.h_10),
        const Spacer(),
        ShimmerBox(Dimensions.w_97, Dimensions.h_11, radius: Dimensions.h_20),
        SizedBox(height: Dimensions.h_10),
        ShimmerBox(Dimensions.w_150, Dimensions.h_23, radius: Dimensions.h_8),
        SizedBox(height: Dimensions.h_6),
        ShimmerBox(Dimensions.w_200, Dimensions.h_23, radius: Dimensions.h_8),
        SizedBox(height: Dimensions.h_10),
        ShimmerBox(Dimensions.w_220, Dimensions.h_11),
        SizedBox(height: Dimensions.h_6),
        ShimmerBox(Dimensions.w_175, Dimensions.h_11),
        const Spacer(),
        Row(
          children: [
            for (var i = 0; i < 3; i++) ...[
              ShimmerBox(Dimensions.h_18, Dimensions.h_18, isCircle: true),
              SizedBox(width: Dimensions.w_6),
              ShimmerBox(Dimensions.w_60, Dimensions.h_10),
              SizedBox(width: Dimensions.w_15),
            ],
          ],
        ),
      ],
      body: [
        header(),
        SizedBox(
          height: Dimensions.h_135,
          child: Row(
            children: [
              for (var i = 0; i < 2; i++)
                ShimmerCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(Dimensions.h_115, Dimensions.h_80, radius: Dimensions.h_10),
                      SizedBox(height: Dimensions.h_10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                        child: Row(
                          children: [
                            ShimmerBox(Dimensions.h_20, Dimensions.h_20, isCircle: true),
                            SizedBox(width: Dimensions.w_8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerBox(Dimensions.w_55, Dimensions.h_10),
                                SizedBox(height: Dimensions.h_5),
                                ShimmerBox(Dimensions.w_40, Dimensions.h_8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  width: Dimensions.h_115,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(right: Dimensions.w_8),
                ),
            ],
          ),
        ),
        header(),
        grid(Dimensions.h_300, 3),
        header(),
        grid(Dimensions.h_240, 2),
        header(),
        ShimmerCard(
          ShimmerBox(double.infinity, double.infinity, radius: Dimensions.h_10),
          height: Dimensions.h_230,
          padding: EdgeInsets.zero,
        ),
        header(),
        ShimmerCard(
          Column(
            children: [
              for (var i = 0; i < 3; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: i == 2 ? 0 : Dimensions.h_12),
                  child: Row(
                    children: [
                      ShimmerBox(Dimensions.h_35, Dimensions.h_35, isCircle: true),
                      SizedBox(width: Dimensions.w_8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerBox(Dimensions.w_110, Dimensions.h_11),
                            SizedBox(height: Dimensions.h_6),
                            ShimmerBox(double.infinity, Dimensions.h_8),
                            SizedBox(height: Dimensions.h_5),
                            ShimmerBox(Dimensions.w_150, Dimensions.h_8),
                          ],
                        ),
                      ),
                      SizedBox(width: Dimensions.w_10),
                      ShimmerBox(Dimensions.w_65, Dimensions.h_25, radius: 99),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_30),
      ],
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
        AppCacheImage(alignment: Alignment(0.5, 0), size: Dimensions.h_330, widthSize: Get.width, imageUrl: controller.groupData?.hero?.image?.url ?? ''),
        Positioned.fill(
          child: Container(
            height: Dimensions.h_330,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [const Color(0xFF020B15).withValues(alpha: 0.85), const Color(0xFF020B15).withValues(alpha: 0.65), const Color(0xFF020B15).withValues(alpha: 0.35), Colors.transparent],
                stops: const [0.0, 0.30, 0.58, 1.0],
              ),
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
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_70),
                child: Text(
                  controller.groupData?.hero?.eyebrow?.toUpperCase() ?? '',
                  style: TextStyle(color: const Color(0xFFFFE47A), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_2),
                child: Text(
                  "Hey! ${controller.groupData?.hero?.titlePrefix ?? ''} \n${controller.groupData?.hero?.title ?? ''}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_22,
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_10, right: Dimensions.w_60),
                child: Text(
                  controller.groupData?.hero?.description ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w500,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              SizedBox(
                height: Dimensions.h_25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: Dimensions.w_8),
                  itemCount: controller.groupData?.hero?.stats?.length ?? 0,
                  itemBuilder: (context, index) {
                    final stat = controller.groupData?.hero?.stats?[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        communityStatItem(
                          value: stat?.displayValue.toString() ?? stat?.value.toString() ?? '',
                          label: stat?.label ?? '',
                          icon: getCommunityStatIcon(stat?.icon),
                          iconSize: Dimensions.h_15,
                        ),
                        if (index != (controller.groupData?.hero?.stats?.length ?? 0) - 1)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                            height: Dimensions.h_30,
                            width: 0.7,
                            color: Colors.white,
                          ),
                      ],
                    );
                  },
                ),
              ),
              const Spacer(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: controller.openCreateGroup,
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_7),
                        decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(99)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: Dimensions.w_8),
                            Text(
                              "Create Group",
                              style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, height: 1.2),
                            ),
                            SizedBox(width: Dimensions.w_8),
                            Padding(
                              padding: EdgeInsets.only(top: Dimensions.h_1),
                              child: Icon(Icons.add, size: Dimensions.h_15, color: Colors.white),
                            ),
                            SizedBox(width: Dimensions.w_5),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: controller.openMyGroups,
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(99)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: Dimensions.w_8),
                            Text(
                              "My Groups",
                              style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, height: 1.2),
                            ),
                            SizedBox(width: Dimensions.w_8),
                            Padding(
                              padding: EdgeInsets.only(top: Dimensions.h_1),
                              child: Icon(CupertinoIcons.person_2, size: Dimensions.h_12, color: Colors.black87),
                            ),
                            SizedBox(width: Dimensions.w_5),
                          ],
                        ),
                      ),
                    ),
                  ],
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
