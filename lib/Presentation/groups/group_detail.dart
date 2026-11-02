import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/common_shimmer.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../../data/datasource/remote/models/response/interest_detail.dart' as model;
import '../widgets/drawer/src/slider_direction.dart';
import '../widgets/drawer/src/slider_drawer.dart';
import 'controller.dart';
import '../widgets/cache_image.dart';
import '../widgets/entrance_animation.dart';

class GroupDetail extends StatefulWidget {
  const GroupDetail({super.key});

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey<SliderDrawerState>();
  final GroupController groupController = Get.put(GroupController());

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    // Page builder only flips shimmer <-> content on first load; each section below has its own
    // builder id so tab/filter changes rebuild just the parts that changed.
    return GetBuilder(
      init: groupController,
      id: ControllerBuilders.interestDetailController,
      builder: (controller) {
        return SliderDrawer(
          key: sliderDrawerKey,
          sliderOpenSize: Dimensions.w_260,
          isDraggable: false,
          slideDirection: SlideDirection.rightToLeft,
          slider: Container(
            height: double.infinity,
            color: Theme.of(context).cardColor,
            child: GetBuilder<GroupController>(id: ControllerBuilders.interestFilters, builder: (c) => filtersWidget(isLight, c)),
          ),
          child: AppScaffold(
            top: false,
            bottom: false,
            bodyPadding: EdgeInsets.zero,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: controller.interestData == null
                ? pageShimmer()
                : CommonScrollBlurScaffold(
                    showBack: true,
                    expandedHeight: Dimensions.h_210,
                    expandedColor: Colors.white,
                    collapsedColor: Theme.of(context).highlightColor,
                    hero: GetBuilder<GroupController>(id: ControllerBuilders.interestHero, builder: (c) => buildHeroHeader(isLight, c.interestData?.discovery)),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: staggered([
                              SizedBox(height: Dimensions.h_5),
                              GetBuilder<GroupController>(id: ControllerBuilders.interestTabs, builder: (c) => buildTabs(isLight, c, c.interestData?.discovery?.tabs ?? [])),
                              SizedBox(height: Dimensions.h_10),
                              GetBuilder<GroupController>(
                                id: ControllerBuilders.interestHeader,
                                builder: (c) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            c.interestData?.discovery?.heading ?? '',
                                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => sliderDrawerKey.currentState?.openSlider(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'FILTERS ',
                                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                                              ),
                                              Icon(Icons.filter_list_alt, color: Theme.of(context).highlightColor, size: Dimensions.h_12),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Dimensions.h_10),
                                    buildCategories(isLight, c, c.interestData?.discovery?.categories ?? []),
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.h_10),
                              GetBuilder<GroupController>(id: ControllerBuilders.interestItems, builder: buildItems),
                              SizedBox(height: Dimensions.h_30),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget pageShimmer() {
    return CommonShimmer(
      heroHeight: Dimensions.h_240,
      hero: [
        ShimmerBox(Dimensions.w_35, Dimensions.h_33, radius: Dimensions.h_10),
        const Spacer(),
        ShimmerBox(Dimensions.w_90, Dimensions.h_11, radius: Dimensions.h_20),
        SizedBox(height: Dimensions.h_8),
        ShimmerBox(Dimensions.w_185, Dimensions.h_25, radius: Dimensions.h_8),
        SizedBox(height: Dimensions.h_10),
        ShimmerBox(Dimensions.w_140, Dimensions.h_15),
        SizedBox(height: Dimensions.h_10),
        ShimmerBox(Dimensions.w_220, Dimensions.h_11),
        SizedBox(height: Dimensions.h_6),
        ShimmerBox(Dimensions.w_175, Dimensions.h_11),
        const Spacer(),
        Row(
          children: [
            ShimmerBox(Dimensions.w_120, Dimensions.h_30, radius: Dimensions.h_8),
            SizedBox(width: Dimensions.w_10),
            ShimmerBox(Dimensions.w_110, Dimensions.h_30, radius: Dimensions.h_8),
          ],
        ),
      ],
      body: [
        SizedBox(height: Dimensions.h_10),
        Row(
          children: [
            for (var i = 0; i < 3; i++) ...[ShimmerBox(Dimensions.w_80, Dimensions.h_12), SizedBox(width: Dimensions.w_15)],
          ],
        ),
        SizedBox(height: Dimensions.h_15),
        Row(children: [ShimmerBox(Dimensions.w_150, Dimensions.h_15), const Spacer(), ShimmerBox(Dimensions.w_60, Dimensions.h_10)]),
        SizedBox(height: Dimensions.h_10),
        Row(
          children: [
            for (var i = 0; i < 4; i++) ...[ShimmerBox(Dimensions.w_65, Dimensions.h_23, radius: 99), SizedBox(width: Dimensions.w_6)],
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        for (var i = 0; i < 3; i++)
          ShimmerCard(
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(Dimensions.h_110, Dimensions.h_95),
                    SizedBox(width: Dimensions.w_8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerBox(double.infinity, Dimensions.h_13),
                          SizedBox(height: Dimensions.h_6),
                          ShimmerBox(Dimensions.w_120, Dimensions.h_13),
                          SizedBox(height: Dimensions.h_4),
                          ShimmerIconLine(Dimensions.w_120),
                          ShimmerIconLine(Dimensions.w_90),
                          ShimmerIconLine(Dimensions.w_105),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_10),
                Row(
                  children: [
                    for (var j = 0; j < 3; j++) Align(widthFactor: 0.75, child: ShimmerBox(Dimensions.h_20, Dimensions.h_20, isCircle: true)),
                    SizedBox(width: Dimensions.w_6),
                    ShimmerBox(Dimensions.w_97, Dimensions.h_8),
                    const Spacer(),
                    ShimmerBox(Dimensions.w_100, Dimensions.h_30, radius: Dimensions.h_8),
                  ],
                ),
              ],
            ),
            margin: EdgeInsets.only(bottom: Dimensions.h_10),
          ),
      ],
    );
  }

  Widget buildTabs(bool isLight, GroupController controller, List<model.Tab> tabs) {
    return Container(
      height: Dimensions.h_25,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColor.micrositeGrey(context), width: 0.6)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (c, index) {
          final tab = tabs[index];
          final isSelected = controller.interestTab == tab.id;
          return GestureDetector(
            onTap: () => controller.changeInterestTab(tab.id),
            child: Container(
              margin: EdgeInsets.only(right: Dimensions.w_8),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: isSelected ? AppColor.blue(context) : Colors.transparent, width: 3)),
              ),
              child: Text(
                tab.label?.toUpperCase() ?? '',
                style: TextStyle(
                  color: isSelected ? AppColor.blue(context) : Theme.of(context).highlightColor,
                  fontSize: FontSize.sp_12,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                  height: 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCategories(bool isLight, GroupController controller, List<model.Category> categories) {
    return SizedBox(
      height: Dimensions.h_23,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = controller.interestCategory == category.value;
          final disabled = category.disabled == true;
          return Padding(
            padding: EdgeInsets.only(right: Dimensions.w_6),
            child: GestureDetector(
              onTap: disabled ? null : () => controller.changeInterestCategory(category.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColor.blue(context) : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(color: isSelected ? AppColor.blue(context) : Theme.of(context).highlightColor, width: isSelected ? 0.5 : 0.2),
                ),
                alignment: Alignment.center,
                child: Text(
                  category.label ?? '',
                  style: TextStyle(
                    fontSize: FontSize.sp_9_5,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                    color: disabled
                        ? Theme.of(context).hintColor
                        : !isLight && isSelected
                        ? Colors.black
                        : isSelected
                        ? Colors.white
                        : Theme.of(context).highlightColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildItems(GroupController controller) {
    if (controller.interestLoading) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: Dimensions.h_80),
          child: CupertinoActivityIndicator(color: AppColor.blue(context), radius: Dimensions.h_8),
        ),
      );
    }
    final items = controller.interestData?.items ?? [];
    if (items.isEmpty) {
      return EntranceAnimation(
        child: CommonCard(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Dimensions.h_10),
            Container(
              height: Dimensions.h_45,
              width: Dimensions.h_45,
              decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_8)),
              child: Icon(controller.interestData?.discovery?.type == 'people' ? CupertinoIcons.person_2 : Icons.calendar_today_outlined, size: Dimensions.h_20, color: AppColor.blue(context)),
            ),
            SizedBox(height: Dimensions.h_10),
            Text(
              controller.interestData?.discovery?.type == 'people' ? 'Find company for your next shared interest' : 'Make plans with your local community',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Dimensions.h_10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15),
              child: Text(
                textAlign: TextAlign.center,
                controller.interestData?.discovery?.type == 'people'
                    ? 'No partner requests here yet. Choose a local group to find people who share your interest.'
                    : 'There are no upcoming events & meetups here yet. Choose a local group to plan something together.',
                style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: Dimensions.h_20),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
                      decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(99)),
                      child: Text(
                        controller.interestData?.discovery?.type == 'people' ? "Find People" : "Add an Event",
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_20),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Explore Groups",
                      style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1.2),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_10),
                ],
              ),
            ),
            SizedBox(height: Dimensions.h_15),
          ],
        ),
        ),
      );
    }
    if (controller.interestData?.discovery?.type == 'groups') {
      return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, mainAxisExtent: Dimensions.h_250),
        itemBuilder: (c, i) => EntranceAnimation(key: ValueKey(items[i]), index: i, child: groupCard(controller, items[i])),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) {
        final item = items[i];
        return EntranceAnimation(key: ValueKey(item), index: i, child: controller.interestData?.discovery?.type == 'people' ? personCard(item) : eventCard(item));
      },
    );
  }

  Widget groupCard(GroupController controller, model.Item featured) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final blue = AppColor.blue(context);
    final green = AppColor.green(context);
    final avatars = (featured.attendees ?? []).map((a) => a.url).whereType<String>().take(4).toList();
    final groupId = featured.groupId ?? int.tryParse(featured.id ?? '') ?? 0;
    final isJoined = controller.interestJoined[groupId] ?? featured.isJoined == true;
    final isProcessing = controller.processingGroupIds.contains(groupId);
    return CommonCard(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_10), topRight: Radius.circular(Dimensions.h_10)),
                child: AppCacheImage(imageUrl: featured.image?.url ?? '', size: Dimensions.h_120, widthSize: Get.width, fit: BoxFit.cover, radius: 0),
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
                    featured.title ?? '',
                    maxLines: 2,
                    style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor, height: 1.1),
                  ),
                  SizedBox(height: Dimensions.h_10),
                  activityMeta(context, CupertinoIcons.person, featured.membersLabel ?? ''),
                  SizedBox(height: Dimensions.h_5),
                  activityMeta(context, CupertinoIcons.person_2, featured.description ?? ''),
                  SizedBox(height: Dimensions.h_12),
                  if (avatars.isNotEmpty) ...[
                    SizedBox(
                      height: Dimensions.h_20,
                      child: Stack(children: List.generate(avatars.length, (avatarIndex) => avatar(avatars[avatarIndex], avatarIndex))),
                    ),
                    SizedBox(height: Dimensions.h_7),
                  ],
                  const Spacer(),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: isProcessing ? null : () => controller.toggleInterestGroup(groupId, isJoined),
                    child: Container(
                      width: Get.width,
                      height: Dimensions.h_28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isProcessing
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
                              isJoined ? 'Leave group' : 'Join Group',
                              style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: isJoined ? (isLight ? AppColor.white : Colors.black87) : blue),
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: FontSize.sp_9_5, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget eventCard(model.Item item) {
    return CommonCard(
      margin: EdgeInsets.only(bottom: Dimensions.h_10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AppCacheImage(imageUrl: item.image?.url ?? '', size: Dimensions.h_95, widthSize: Dimensions.h_110, isShadow: false, radius: Dimensions.h_6),
                  Positioned(
                    left: Dimensions.w_4,
                    top: Dimensions.h_6,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_2),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                      child: Text(
                        item.badge?.label ?? '',
                        style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_8, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: Dimensions.w_8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.title ?? '',
                            maxLines: 2,
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800, height: 1.1),
                          ),
                        ),
                        Icon(Icons.favorite_border, color: AppColor.blue(context), size: Dimensions.h_18),
                      ],
                    ),
                    ...detailRows(item.details),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_5),
          IntrinsicHeight(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_4),
                  child: Row(
                    children: [
                      if (item.attendees?.isNotEmpty ?? false)
                        SizedBox(
                          width: Dimensions.w_70,
                          height: Dimensions.h_20,
                          child: Stack(children: [for (final (i, url) in (item.attendees ?? []).take(4).indexed) avatar(url.url ?? '', i, color: Theme.of(context).highlightColor, width: 0.5)]),
                        ),
                      SizedBox(width: Dimensions.w_3),
                      Text(
                        '${item.goingCount ?? 0} going · ${item.spotsAvailable ?? 0} spots left',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: FontSize.sp_9, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Container(
                    width: Dimensions.w_100,
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
                    decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(Dimensions.h_8)),
                    child: Center(
                      child: Text(
                        item.isJoined == true ? 'Joined' : 'Join',
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
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
  }

  Widget personCard(model.Item item) {
    return CommonCard(
      margin: EdgeInsets.only(bottom: Dimensions.h_10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCacheImage(imageUrl: item.image?.url ?? '', size: Dimensions.h_90, widthSize: Dimensions.h_80, isShadow: false, radius: Dimensions.h_6),
              SizedBox(width: Dimensions.w_8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            item.name ?? item.title ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800, height: 1.1),
                          ),
                        ),
                        Icon(Icons.verified_sharp, color: AppColor.blue(context), size: Dimensions.h_12),
                        SizedBox(width: Dimensions.w_8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_3),
                          decoration: BoxDecoration(color: AppColor.greenSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_3)),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_outlined, color: AppColor.green(context), size: Dimensions.h_10),
                              SizedBox(width: Dimensions.w_4),
                              Text(
                                item.badge?.label ?? 'Shared Interest',
                                style: TextStyle(color: AppColor.green(context), fontSize: FontSize.sp_8, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ...detailRows(item.details),
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
                    onTap: groupController.openGroupProfile,
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
  }

  List<Widget> detailRows(List<model.Detail>? details) {
    const icons = {'date': Icons.calendar_today_outlined, 'time': Icons.calendar_today_outlined, 'location': Icons.location_on_sharp, 'distance': Icons.pedal_bike_rounded, 'skill': Icons.landscape};
    return [
      for (final (i, detail) in (details ?? <model.Detail>[]).indexed) ...[
        SizedBox(height: i == 0 ? Dimensions.h_10 : Dimensions.h_3),
        Row(
          children: [
            SizedBox(width: Dimensions.w_2),
            Icon(icons[detail.id] ?? Icons.landscape_outlined, color: Theme.of(context).hintColor, size: Dimensions.h_11),
            SizedBox(width: Dimensions.w_4),
            Expanded(
              child: Text(
                detail.text ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ],
    ];
  }

  Widget avatar(String image, int index, {Color? color, double? width}) {
    return Positioned(
      left: index * Dimensions.w_15,
      child: Container(
        width: Dimensions.h_20,
        height: Dimensions.h_20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color ?? Theme.of(context).scaffoldBackgroundColor, width: width ?? 1.5),
        ),
        child: ClipOval(
          child: AppCacheImage(imageUrl: image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget filtersWidget(bool isLight, GroupController controller) {
    final ink = AppColor.ink(context);
    final muted = AppColor.muted(context);
    final surface = AppColor.surface(context);
    final blue = AppColor.blue(context);
    final border = AppColor.border(context);
    final red = AppColor.red(context);
    final discovery = controller.interestData?.discovery;

    Widget sectionTitle(String title) {
      return Padding(
        padding: EdgeInsets.only(bottom: Dimensions.h_7),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(color: ink, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
        ),
      );
    }

    Widget radioItem({required String title, required bool selected, required bool disabled, required VoidCallback onTap}) {
      return Padding(
        padding: EdgeInsets.only(bottom: Dimensions.h_8),
        child: GestureDetector(
          onTap: disabled ? null : onTap,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Container(
                width: Dimensions.h_13,
                height: Dimensions.h_13,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: disabled
                        ? muted.withValues(alpha: 0.35)
                        : selected
                        ? blue
                        : muted,
                    width: 1,
                  ),
                ),
                child: selected && !disabled
                    ? Center(
                        child: Container(
                          width: Dimensions.h_7,
                          height: Dimensions.h_7,
                          decoration: BoxDecoration(color: blue, shape: BoxShape.circle),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: Dimensions.w_7),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: disabled ? muted.withValues(alpha: 0.5) : Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget checkItem({required String title, required bool selected, required bool disabled, required VoidCallback onTap}) {
      return Padding(
        padding: EdgeInsets.only(bottom: Dimensions.h_8),
        child: GestureDetector(
          onTap: disabled ? null : onTap,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Container(
                width: Dimensions.h_13,
                height: Dimensions.h_13,
                decoration: BoxDecoration(
                  color: selected ? blue : Colors.transparent,
                  border: Border.all(
                    color: disabled
                        ? muted.withValues(alpha: 0.35)
                        : selected
                        ? blue
                        : muted,
                    width: 0.8,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.h_1),
                ),
                child: selected ? Icon(CupertinoIcons.checkmark, size: Dimensions.h_12, color: Colors.white) : null,
              ),
              SizedBox(width: Dimensions.w_7),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: disabled ? muted.withValues(alpha: 0.5) : Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget divider() {
      return Container(
        height: 0.4,
        width: double.infinity,
        color: border,
        margin: EdgeInsets.only(top: Dimensions.h_10, bottom: Dimensions.h_10),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.h_40),
          Row(
            children: [
              Text(
                'Filters'.toUpperCase(),
                style: TextStyle(color: ink, fontSize: FontSize.sp_14, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => sliderDrawerKey.currentState?.closeSlider(),
                child: Icon(CupertinoIcons.clear_circled_solid, size: Dimensions.h_20, color: ink),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_13),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle(discovery?.searchLabel ?? 'Search'),
                  Container(
                    height: Dimensions.h_30,
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7),
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: BorderRadius.circular(Dimensions.h_5),
                      border: Border.all(color: border, width: 0.4),
                    ),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.search, size: Dimensions.h_12, color: blue),
                        SizedBox(width: Dimensions.w_4),
                        Expanded(
                          child: TextField(
                            controller: controller.interestSearchController,
                            maxLength: 150,
                            style: TextStyle(color: ink, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(color: muted, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                              counterText: '',
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (final filter in discovery?.filters ?? <model.Filter>[]) ...[
                    divider(),
                    sectionTitle(filter.label ?? ''),
                    SizedBox(height: Dimensions.h_5),
                    for (final option in filter.options ?? <model.Sort>[])
                      (filter.kind == 'checkbox' ? checkItem : radioItem)(
                        title: option.label ?? '',
                        selected: controller.interestFilters[filter.name]?.contains(option.value) == true,
                        disabled: filter.disabled == true,
                        onTap: () => controller.toggleInterestFilter(filter, option.value ?? ''),
                      ),
                  ],
                  if (discovery?.sorts?.isNotEmpty == true) ...[
                    divider(),
                    sectionTitle('Sort By'),
                    SizedBox(height: Dimensions.h_5),
                    for (final sort in discovery!.sorts!)
                      radioItem(
                        title: sort.label ?? '',
                        selected: (controller.interestSort ?? discovery.sorts!.first.value) == sort.value,
                        disabled: false,
                        onTap: () => controller.changeInterestSort(sort.value),
                      ),
                  ],
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: Dimensions.h_28,
                  child: OutlinedButton(
                    onPressed: () {
                      controller.resetInterestFilters();
                      controller.getInterestDetail(controller.interestSlug);
                      sliderDrawerKey.currentState?.closeSlider();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: red,
                      side: BorderSide(color: red, width: 0.8),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                    ),
                    child: Text(
                      'Clear All',
                      style: TextStyle(color: red, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: Dimensions.h_28,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.getInterestDetail(controller.interestSlug);
                      sliderDrawerKey.currentState?.closeSlider();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_13),
        ],
      ),
    );
  }

  Widget buildHeroHeader(bool isLight, model.Discovery? discovery) {
    final shadow = [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))];
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCacheImage(alignment: Alignment(0.5, 0), size: Dimensions.h_330, widthSize: Get.width, imageUrl: discovery?.image?.url ?? ''),
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
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_80),
                child: Text(
                  'WELCOME , ALWIN',
                  style: TextStyle(color: const Color(0xFFFFE47A), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_4),
                child: Text(
                  discovery?.interestName ?? '',
                  style: TextStyle(color: Colors.white, fontSize: FontSize.sp_26, fontWeight: FontWeight.w900, shadows: shadow),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_10),
                child: Text(
                  discovery?.heading ?? '',
                  style: TextStyle(color: Colors.white, fontSize: FontSize.sp_16, fontWeight: FontWeight.w900, shadows: shadow),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_10, right: Dimensions.w_60),
                child: Text(
                  discovery?.intro ?? '',
                  style: TextStyle(color: Colors.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w500, shadows: shadow),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              const Spacer(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
                        decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(Dimensions.h_8)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(CupertinoIcons.plus_circle_fill, size: Dimensions.h_15, color: Colors.white),
                            SizedBox(width: Dimensions.w_8),
                            Text(
                              "Join Interest",
                              style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_5),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_35, vertical: Dimensions.h_8),
                        decoration: BoxDecoration(
                          color: AppColor.groupDetailWhite(context),
                          border: Border.all(color: isLight ? AppColor.sportsLightBorder : Colors.white, width: 0.5),
                          borderRadius: BorderRadius.circular(Dimensions.h_8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(CupertinoIcons.bell, size: Dimensions.h_13, color: Theme.of(context).highlightColor),
                            SizedBox(width: Dimensions.w_5),
                            Text(
                              "Follow",
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1.2),
                            ),
                          ],
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
