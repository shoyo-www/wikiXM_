import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/widgets/activity_meta.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_shimmer.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/cache_image.dart';
import '../widgets/entrance_animation.dart';
import '../../data/datasource/remote/models/response/group_detail.dart' as model;

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GroupController groupController = Get.put(GroupController());

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetBuilder(
        init: groupController,
        id: ControllerBuilders.groupDetailPage,
        builder: (controller) {
          if (controller.groupDetailLoading) return pageShimmer();
          return CommonScrollBlurScaffold(
            showBack: true,
            expandedHeight: Dimensions.h_230,
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
                      SizedBox(height: Dimensions.h_5),
                      EntranceAnimation(child: GetBuilder<GroupController>(id: ControllerBuilders.groupDetailTabs, builder: buildTabs)),
                      SizedBox(height: Dimensions.h_10),
                      GetBuilder<GroupController>(
                        id: ControllerBuilders.groupDetailContent,
                        builder: (c) {
                          final tab = c.selectedGroupDetailTab;
                          final members = c.groupDetailData?.members ?? <model.Member>[];
                          final leaders = members.where((m) => (m.role ?? 3) < 3).toList();
                          if (c.groupTabLoading) {
                            return Padding(
                              padding: EdgeInsets.only(top: Dimensions.h_150),
                              child: Center(child: CupertinoActivityIndicator(color: AppColor.blue(context))),
                            );
                          }
                          // keyed by tab so switching tabs replays the entrance animation instead of reusing the old one
                          return KeyedSubtree(
                            key: ValueKey(tab),
                            child: tab == 'overview'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: staggered([
                                    Text(
                                      'About this group',
                                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: Dimensions.w_4, top: Dimensions.h_2),
                                      child: Text(
                                        'A little about your ${controller.groupDetailData?.group?.interest?.name ?? ''} community.',
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: Dimensions.w_4, top: Dimensions.h_8),
                                      child: Text(
                                        controller.groupDetailData?.about?.description ?? '',
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_10),
                                    Padding(
                                      padding: EdgeInsets.only(left: Dimensions.w_12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: Dimensions.h_25,
                                                  width: Dimensions.h_25,
                                                  decoration: BoxDecoration(color: AppColor.blueSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                                                  child: Icon(CupertinoIcons.person_2, size: Dimensions.h_13, color: AppColor.blue(context)),
                                                ),
                                                SizedBox(width: Dimensions.w_8),
                                                Expanded(
                                                  child: Text(
                                                    controller.groupDetailData?.group?.interest?.name ?? '',
                                                    style: TextStyle(fontSize: FontSize.sp_12, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.w_10),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: Dimensions.h_25,
                                                  width: Dimensions.h_25,
                                                  decoration: BoxDecoration(color: AppColor.blueSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                                                  child: Icon(CupertinoIcons.person_2, size: Dimensions.h_13, color: AppColor.blue(context)),
                                                ),
                                                SizedBox(width: Dimensions.w_8),
                                                Expanded(
                                                  child: Text(
                                                    'All Skills Levels',
                                                    style: TextStyle(fontSize: FontSize.sp_12, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_15),
                                    Padding(
                                      padding: EdgeInsets.only(left: Dimensions.w_12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: Dimensions.h_25,
                                                  width: Dimensions.h_25,
                                                  decoration: BoxDecoration(color: AppColor.blueSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                                                  child: Icon(Icons.calendar_month, size: Dimensions.h_13, color: AppColor.blue(context)),
                                                ),
                                                SizedBox(width: Dimensions.w_8),
                                                Expanded(
                                                  child: Text(
                                                    controller.groupDetailData?.profile?.activityLabel ?? '',
                                                    style: TextStyle(fontSize: FontSize.sp_12, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.w_10),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: Dimensions.h_25,
                                                  width: Dimensions.h_25,
                                                  decoration: BoxDecoration(color: AppColor.blueSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                                                  child: Icon(Icons.location_on_sharp, size: Dimensions.h_13, color: AppColor.blue(context)),
                                                ),
                                                SizedBox(width: Dimensions.w_8),
                                                Expanded(
                                                  child: Text(
                                                    controller.groupDetailData?.group?.town ?? '',
                                                    style: TextStyle(fontSize: FontSize.sp_12, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (c.hasGroupDetailTab('activities')) ...[
                                      SizedBox(height: Dimensions.h_20),
                                      Row(
                                        children: [
                                          Text(
                                            controller.groupDetailData?.profile?.activityLabel ?? '',
                                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_4),
                                            decoration: BoxDecoration(color: AppColor.blue(context), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                                            child: Text(
                                              '+ ${controller.groupDetailData?.profile?.activityAction ?? ''}',
                                              style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: isLight ? AppColor.white : AppColor.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.h_10),
                                      activitiesGrid(c, c.groupDetailData?.activities ?? [], isLight),
                                    ],
                                    if (c.hasGroupDetailTab('discussion')) ...[
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
                                        padding: EdgeInsets.only(left: Dimensions.w_6, top: Dimensions.h_6),
                                        child: Text(
                                          'Community Updates, good advice, and stories worth sharing. What’s on your mind, Sean?',
                                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.1),
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.h_10),
                                      if (c.groupDetailData?.posts?.isEmpty ?? true) postEmpty(c) else for (final post in c.groupDetailData!.posts!.take(2)) postCard(post),
                                    ],
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
                                      itemCount: controller.quickActions.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, mainAxisExtent: Dimensions.h_35),
                                      itemBuilder: (context, index) {
                                        final action = controller.quickActions[index];
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
                                    if (c.hasGroupDetailTab('members')) ...[
                                      SizedBox(height: Dimensions.h_20),
                                      CommonCard(
                                        margin: EdgeInsets.zero,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Meet your crew (${controller.groupDetailData?.group?.membersCount ?? members.length})',
                                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                                                ),
                                                const Spacer(),
                                                GestureDetector(
                                                  onTap: () => c.changeGroupDetailTab('members'),
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
                                                for (final (i, member) in members.take(7).indexed) ...[if (i > 0) SizedBox(width: Dimensions.w_8), AppCacheImage(imageUrl: member.avatar ?? '', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true)],
                                              ],
                                            ),
                                            if (leaders.isNotEmpty) ...[
                                              Container(
                                                margin: EdgeInsets.only(bottom: Dimensions.h_10, top: Dimensions.h_10),
                                                height: 0.2,
                                                width: Get.width,
                                                color: Theme.of(context).highlightColor,
                                              ),
                                              crewRow(leaders.first),
                                              if (leaders.length > 1) ...[
                                                SizedBox(height: Dimensions.h_10),
                                                Text(
                                                  'Here to help',
                                                  style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                                                ),
                                                for (final member in leaders.skip(1)) ...[SizedBox(height: Dimensions.h_10), crewRow(member)],
                                              ],
                                            ],
                                          ],
                                        ),
                                      ),
                                    ],
                                  ]),
                                )
                              : tab == 'discussion'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: staggered([
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
                                        ' Community Updates, good advice, and stories worth sharing. What’s on your mind, Sean?',
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.1),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_10),
                                    if (c.groupTabData?.posts?.isEmpty ?? true)
                                      postEmpty(c)
                                    else
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.groupTabData?.posts?.length ?? 0,
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                                        itemBuilder: (c, i) {
                                          return EntranceAnimation(index: i, child: postCard(controller.groupTabData!.posts![i]));
                                        },
                                      ),
                                  ]),
                                )
                              : tab == 'activities'
                              ? activitiesGrid(c, c.groupTabData?.activities ?? [], isLight)
                              : tab == 'members'
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: c.groupTabData?.members?.length ?? 0,
                                  itemBuilder: (_, i) {
                                    final member = c.groupTabData?.members?[i];
                                    return EntranceAnimation(index: i, child: CommonCard(
                                      margin: EdgeInsets.only(bottom: Dimensions.h_10),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AppCacheImage(imageUrl: member?.avatar ?? '', size: Dimensions.h_60, widthSize: Dimensions.h_60, isShadow: false, radius: Dimensions.h_6),
                                              SizedBox(width: Dimensions.w_8),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${member?.firstName ?? ''} ${member?.lastName ?? ''}',
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
                                                          member?.town ?? '',
                                                          style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: Dimensions.h_3),
                                                    Row(
                                                      children: [
                                                        SizedBox(width: Dimensions.w_2),
                                                        Icon(Icons.person_2, color: Theme.of(context).hintColor, size: Dimensions.h_11),
                                                        SizedBox(width: Dimensions.w_4),
                                                        Text(
                                                          member?.roleLabel ?? '',
                                                          style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                                                        ),
                                                      ],
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
                                    ));
                                  },
                                )
                              : tab == 'photos' && (c.groupTabData?.gallery?.isEmpty ?? true)
                              ? EntranceAnimation(child: photosEmpty(c))
                              : tab == 'photos'
                              ? GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: c.groupTabData?.gallery?.length ?? 0,
                                  itemBuilder: (_, i) {
                                    return EntranceAnimation(index: i, child: AppCacheImage(imageUrl: c.groupTabData!.gallery![i].url ?? '', widthSize: Get.width, size: Dimensions.h_117, isShadow: false, radius: Dimensions.h_10));
                                  },
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, mainAxisExtent: Dimensions.h_120),
                                )
                              : const SizedBox.shrink(),
                          );
                        },
                      ),
                      SizedBox(height: Dimensions.h_30),
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

  Widget crewRow(model.Member member) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: Dimensions.w_15),
        AppCacheImage(imageUrl: member.avatar ?? '', size: Dimensions.h_50, widthSize: Dimensions.h_50, color: Theme.of(context).highlightColor),
        SizedBox(width: Dimensions.w_8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${member.firstName ?? ''} ${member.lastName ?? ''}',
                style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
              ),
              SizedBox(height: Dimensions.h_3),
              Text(
                [member.roleLabel, member.town].where((v) => v?.isNotEmpty ?? false).join(' · '),
                style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget postCard(model.Post item) {
    return CommonCard(
      margin: EdgeInsets.only(bottom: Dimensions.h_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.isPinned == 1) ...[
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
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppCacheImage(imageUrl: item.avatar ?? '', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true, color: Theme.of(context).highlightColor),
              SizedBox(width: Dimensions.w_8),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      '${item.firstName ?? ''} ${item.lastName ?? ''}',
                      style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                    ),
                    if (item.authorRoleLabel?.isNotEmpty ?? false) ...[
                      SizedBox(width: Dimensions.w_8),
                      Text(
                        item.authorRoleLabel!,
                        style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w700, color: AppColor.blue(context)),
                      ),
                    ],
                    SizedBox(width: Dimensions.w_8),
                    Text(
                      item.createdAtLabel ?? '',
                      style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                    ),
                    const Spacer(),
                    Icon(item.isSaved == 1 ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark, size: Dimensions.h_16, color: Theme.of(context).highlightColor),
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
                      item.title ?? '',
                      style: TextStyle(fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor, height: 1.1),
                    ),
                    SizedBox(height: Dimensions.h_5),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.w_6),
                      child: Text(
                        item.body ?? '',
                        style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.3),
                      ),
                    ),
                  ],
                ),
              ),
              if (item.image?.isNotEmpty ?? false) ...[SizedBox(width: Dimensions.w_10), AppCacheImage(imageUrl: item.image!, size: Dimensions.h_75, widthSize: Dimensions.w_120)],
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: Dimensions.w_6),
              Icon(item.isLiked == 1 ? CupertinoIcons.hand_thumbsup_fill : CupertinoIcons.hand_thumbsup, size: Dimensions.h_11, color: Theme.of(context).highlightColor),
              SizedBox(width: Dimensions.w_5),
              Text(
                '${item.likesCount ?? 0} Likes',
                style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
              ),
              SizedBox(width: Dimensions.w_15),
              Icon(CupertinoIcons.chat_bubble_text, size: Dimensions.h_11, color: Theme.of(context).highlightColor),
              SizedBox(width: Dimensions.w_5),
              Text(
                '${item.commentsCount ?? 0} Comments',
                style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget activitiesGrid(GroupController controller, List<model.Activity> activities, bool isLight) {
    if (activities.isEmpty) return EntranceAnimation(child: activitiesEmpty(controller));
    const detailIcons = [CupertinoIcons.clock, CupertinoIcons.location_solid, Icons.directions_bike];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: activities.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, mainAxisExtent: Dimensions.h_270),
      itemBuilder: (context, index) {
        final activity = activities[index];
        final attendees = activity.attendees ?? [];
        final details = activity.details ?? [];
        final badge = activity.badge?.label ?? '';
        return EntranceAnimation(index: index, child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => controller.openGroupActivity(activity),
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
                      child: AppCacheImage(imageUrl: activity.image?.url ?? '', size: Dimensions.h_120, widthSize: Get.width, fit: BoxFit.cover, radius: 0),
                    ),
                    if (badge.isNotEmpty)
                      Positioned(
                        top: Dimensions.h_6,
                        left: Dimensions.w_8,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_2),
                          child: Text(
                            badge,
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
                          activity.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor, height: 1),
                        ),
                        SizedBox(height: Dimensions.h_10),
                        for (var i = 0; i < details.length && i < detailIcons.length; i++) ...[if (i > 0) SizedBox(height: Dimensions.h_5), ActivityMeta(icon: detailIcons[i], text: details[i].text ?? '')],
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
                                            child: AppCacheImage(imageUrl: entry.value.url ?? '', fit: BoxFit.cover),
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
                                '${activity.goingCount ?? 0} going · ${activity.spotsAvailable ?? 0} spots left',
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
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: activity.isJoined == true ? AppColor.green(context) : AppColor.blue(context),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                            ),
                            child: Text(
                              activity.isJoined == true
                                  ? 'Leave Activity'
                                  : activity.canInterest == true
                                  ? 'I’m interested'
                                  : 'Join',
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
        ));
      },
    );
  }

  Widget activitiesEmpty(GroupController controller) {
    return CommonCard(
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
            child: Icon(Icons.calendar_today_outlined, size: Dimensions.h_20, color: AppColor.blue(context)),
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            "Plan your group's first game",
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: Dimensions.h_10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15),
            child: Text(
              textAlign: TextAlign.center,
              'No upcoming activities yet. Add a game and invite your group to take part.',
              style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: Dimensions.h_20),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
              decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(99)),
              child: Text(
                controller.groupDetailData?.profile?.activityAction ?? 'Add an Event',
                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_15),
        ],
      ),
    );
  }

  Widget postEmpty(GroupController controller) {
    return CommonCard(
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
            child: Icon(Icons.calendar_today_outlined, size: Dimensions.h_20, color: AppColor.blue(context)),
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            "No conversations here yet",
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: Dimensions.h_10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15),
            child: Text(
              textAlign: TextAlign.center,
              'Try another topic or start the first conversation.',
              style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: Dimensions.h_20),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
              decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(99)),
              child: Text(
                'Start a post ',
                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_15),
        ],
      ),
    );
  }

  Widget photosEmpty(GroupController controller) {
    return CommonCard(
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
            child: Icon(Icons.calendar_today_outlined, size: Dimensions.h_20, color: AppColor.blue(context)),
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            "No Phots here yet",
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: Dimensions.h_10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15),
            child: Text(
              textAlign: TextAlign.center,
                'No photos available. Add photos to see them here.',
              style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: Dimensions.h_20),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
              decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(99)),
              child: Text(
                'Add Photos',
                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_15),
        ],
      ),
    );
  }

  Widget buildTabs(GroupController controller) {
    final tabs = controller.groupDetailData?.profile?.tabs ?? [];
    final selectedTab = controller.selectedGroupDetailTab;
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
          final isSelected = selectedTab == tab.id;
          return GestureDetector(
            onTap: () => controller.changeGroupDetailTab(tab.id),
            child: Container(
              margin: EdgeInsets.only(right: Dimensions.w_8),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: isSelected ? AppColor.blue(context) : Colors.transparent, width: 3)),
              ),
              child: Text(
                tab.label?.toUpperCase() ?? '',
                style: TextStyle(color: isSelected ? AppColor.blue(context) : Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700, height: 1),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget pageShimmer() {
    return CommonShimmer(
      heroHeight: Dimensions.h_230,
      hero: [
        ShimmerBox(Dimensions.w_35, Dimensions.h_33, radius: Dimensions.h_10),
        const Spacer(),
        ShimmerBox(Dimensions.w_185, Dimensions.h_25, radius: Dimensions.h_8),
        SizedBox(height: Dimensions.h_10),
        ShimmerBox(Dimensions.w_220, Dimensions.h_11),
        SizedBox(height: Dimensions.h_10),
        Row(
          children: [
            for (var i = 0; i < 3; i++) ...[ShimmerBox(Dimensions.w_70, Dimensions.h_10), SizedBox(width: Dimensions.w_15)],
          ],
        ),
        SizedBox(height: Dimensions.h_15),
        Row(
          children: [
            Expanded(child: ShimmerBox(double.infinity, Dimensions.h_30, radius: Dimensions.h_8)),
            SizedBox(width: Dimensions.w_10),
            Expanded(child: ShimmerBox(double.infinity, Dimensions.h_30, radius: Dimensions.h_8)),
          ],
        ),
      ],
      body: [
        SizedBox(height: Dimensions.h_10),
        Row(
          children: [
            for (var i = 0; i < 4; i++) ...[ShimmerBox(Dimensions.w_60, Dimensions.h_12), SizedBox(width: Dimensions.w_15)],
          ],
        ),
        SizedBox(height: Dimensions.h_15),
        ShimmerBox(Dimensions.w_140, Dimensions.h_15),
        SizedBox(height: Dimensions.h_8),
        ShimmerBox(Dimensions.w_220, Dimensions.h_10),
        SizedBox(height: Dimensions.h_8),
        ShimmerBox(double.infinity, Dimensions.h_10),
        SizedBox(height: Dimensions.h_5),
        ShimmerBox(Dimensions.w_175, Dimensions.h_10),
        SizedBox(height: Dimensions.h_15),
        for (var r = 0; r < 2; r++)
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_12, bottom: Dimensions.h_8),
            child: Row(
              children: [
                for (var c = 0; c < 2; c++)
                  Expanded(
                    child: Row(
                      children: [
                        ShimmerBox(Dimensions.h_25, Dimensions.h_25, radius: Dimensions.h_4),
                        SizedBox(width: Dimensions.w_8),
                        ShimmerBox(Dimensions.w_80, Dimensions.h_11),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        SizedBox(height: Dimensions.h_15),
        Row(
          children: [
            ShimmerBox(Dimensions.w_150, Dimensions.h_15),
            const Spacer(),
            ShimmerBox(Dimensions.w_60, Dimensions.h_20, radius: Dimensions.h_4),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        Row(
          children: [
            for (var i = 0; i < 2; i++) ...[
              if (i > 0) SizedBox(width: Dimensions.w_6),
              Expanded(
                child: ShimmerCard(
                  padding: EdgeInsets.zero,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(double.infinity, Dimensions.h_120, radius: Dimensions.h_10),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.w_8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerBox(double.infinity, Dimensions.h_12),
                            SizedBox(height: Dimensions.h_6),
                            ShimmerIconLine(Dimensions.w_90),
                            ShimmerIconLine(Dimensions.w_80),
                            ShimmerIconLine(Dimensions.w_90),
                            SizedBox(height: Dimensions.h_10),
                            ShimmerBox(double.infinity, Dimensions.h_28, radius: Dimensions.h_6),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget buildHeroHeader(bool isLight, GroupController controller) {
    final isOwner = controller.groupDetailData?.group?.isOwner ?? false;
    final canLeave = !isOwner && (controller.groupDetailData?.group?.canLeave ?? false);
    final joinBg = isOwner ? const Color(0xFFb9dcc6) : canLeave ? const Color(0xFFFDE2E2) : const Color(0xff1d5fef);
    final joinFg = isOwner ? const Color(0xFF16462f) : canLeave ? const Color(0xFFB91C1C) : Colors.white;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (controller.groupDetailData?.group?.cover?.url?.isNotEmpty ?? false)
          AppCacheImage(alignment: Alignment(0.5, 0), size: Dimensions.h_330, widthSize: Get.width, imageUrl: controller.groupDetailData?.group?.cover?.url ?? '')
        else
          Positioned.fill(
            child: Container(
              height: Dimensions.h_330,
              decoration: BoxDecoration(color: Color(0xFF176e4c)),
            ),
          ),
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
                  controller.groupDetailData?.group?.name ?? '',
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
                  maxLines: 4,
                  controller.groupDetailData?.group?.description ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w500,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_10, right: Dimensions.w_10),
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
                          controller.groupDetailData?.group?.privacy ?? '',
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
                          "${controller.groupDetailData?.group?.town ?? ''} + ${controller.groupDetailData?.group?.radiusMiles.toString() ?? ''} miles",
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
                        Icon(CupertinoIcons.person_2, size: Dimensions.h_12, color: Colors.white),
                        SizedBox(width: Dimensions.w_5),
                        Text(
                          controller.groupDetailData?.group?.interest?.name ?? '',
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
                        Icon(CupertinoIcons.person_2, size: Dimensions.h_12, color: Colors.white),
                        SizedBox(width: Dimensions.w_3),
                        Text(
                          "${controller.groupDetailData?.group?.membersCount ?? ''} Members",
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
                          decoration: BoxDecoration(color: joinBg, borderRadius: BorderRadius.circular(Dimensions.h_8)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(isOwner ? CupertinoIcons.check_mark_circled : canLeave ? CupertinoIcons.minus_circle_fill : CupertinoIcons.plus_circle_fill, size: Dimensions.h_15, color: joinFg),
                              SizedBox(width: Dimensions.w_8),
                              Text(
                               isOwner ? "Group Owner" : canLeave ? "Leave Group" : "Join Group",
                                style: TextStyle(color: joinFg, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
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
                              Icon(CupertinoIcons.share, size: Dimensions.h_13, color: Theme.of(context).highlightColor),
                              SizedBox(width: Dimensions.w_5),
                              Text(
                                "Invite",
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
