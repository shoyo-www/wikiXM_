import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/activity_meta.dart';
import '../widgets/common_shimmer.dart';
import 'package:intl/intl.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/data/datasource/remote/models/response/my_group_attention.dart';
import 'package:wikixm/data/datasource/remote/models/response/my_group_list.dart';
import 'package:wikixm/data/datasource/remote/models/response/my_group_invitations.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/entrance_animation.dart';
import '../widgets/cache_image.dart';
import 'package:wikixm/Presentation/groups/groups_drawer.dart';

class MyGroupsScreen extends StatefulWidget {
  const MyGroupsScreen({super.key});

  @override
  State<MyGroupsScreen> createState() => _MyGroupsScreenState();
}

class _MyGroupsScreenState extends State<MyGroupsScreen> {
  final GroupController groupController = Get.put(GroupController());
  final List<String> tabs = ['My groups', 'My activities','My Profile','Settings'];

  @override
  void initState() {
    super.initState();
    groupController.getMyGroups();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return GroupsDrawer(
      builder: (openDrawer) => AppScaffold(
          top: false,
          bottom: false,
          bodyPadding: EdgeInsets.zero,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: GetBuilder(
            init: groupController,
            id: ControllerBuilders.myGroups,
            builder: (controller) {
              return controller.myGroupsLoading && controller.mySummary == null
                  ? pageShimmer()
                  : NotificationListener<ScrollNotification>(
                      onNotification: (n) {
                        if (n.metrics.axis == Axis.vertical && controller.myGroupsTab == 0 && n.metrics.pixels >= n.metrics.maxScrollExtent - 300) controller.loadMoreMyGroups();
                        return false;
                      },
                      child: CommonScrollBlurScaffold(
                        showBack: true,
                        isDrawer: true,
                        onTap: openDrawer,
                        expandedHeight: Dimensions.h_270,
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
                                  Container(
                                    height: Dimensions.h_25,
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: AppColor.micrositeGrey(context), width: 0.6)),
                                    ),
                                    child: GetBuilder<GroupController>(
                                      id: ControllerBuilders.myGroupsTabs,
                                      builder: (controller) => ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: tabs.length,
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        itemBuilder: (c, index) {
                                          final tab = tabs[index];
                                          final isSelected = controller.myGroupsTab == index;
                                          return GestureDetector(
                                            onTap: () => controller.openMyGroupsTab(index),
                                            child: Container(
                                              margin: EdgeInsets.only(right: Dimensions.w_8),
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                                              decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(color: isSelected ? AppColor.blue(context) : Colors.transparent, width: 3)),
                                              ),
                                              child: Text(
                                                tab.toUpperCase(),
                                                style: TextStyle(color: isSelected ? AppColor.blue(context) : Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700, height: 1),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  GetBuilder<GroupController>(
                                    id: ControllerBuilders.myGroupsTabs,
                                    builder: (controller) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (controller.myGroupsTab == 0) GetBuilder<GroupController>(id: ControllerBuilders.myGroupsList, builder: (_) => buildManagedGroups()),
                                        if (controller.myGroupsTab == 3)
                                          GetBuilder<GroupController>(
                                            id: ControllerBuilders.myGroupsSettings,
                                            builder: (controller) => Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: Dimensions.h_10),
                                                EntranceAnimation(
                                                  child: Text(
                                                  'Account settings',
                                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
                                                  ),
                                                ),
                                                EntranceAnimation(
                                                  child: Text(
                                                    'Choose what appears on your My Groups dashboard.',
                                                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(height: Dimensions.h_10),
                                                EntranceAnimation(
                                                  index: 1,
                                                  child: CommonCard(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'Group recommendations',
                                                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                                                                ),
                                                                Text(
                                                                  'Show recommended groups on your My Groups dashboard.',
                                                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(width: Dimensions.w_20),
                                                          GestureDetector(
                                                            onTap: controller.groupRecommendations == null ? null : controller.toggleRecommendations,
                                                            child: Icon(controller.groupRecommendations == true ? Icons.check_box : Icons.check_box_outline_blank, color: AppColor.blue(context), size: Dimensions.h_20),
                                                          ),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        behavior: HitTestBehavior.opaque,
                                                        onTap: controller.saveMySettings,
                                                        child: Container(
                                                          width: Dimensions.w_135,
                                                          margin: EdgeInsets.only(top: Dimensions.h_15),
                                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_10),
                                                          decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                                                          child: Center(
                                                            child: Text(
                                                              controller.savingSettings ? "Saving..." : "Save Preference",
                                                              style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (controller.myGroupsTab == 1)
                                          GetBuilder<GroupController>(
                                            id: ControllerBuilders.myGroupsActivities,
                                            builder: (controller) => Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: Dimensions.h_10),
                                                EntranceAnimation(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'My upcoming activities (${controller.myActivities?.length ?? 0})',
                                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
                                                      ),
                                                      Text(
                                                        'A little time together',
                                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: Dimensions.h_10),
                                                if (controller.myActivitiesLoading && controller.myActivities == null)
                                                  activityGridShimmer()
                                                else if ((controller.myActivities ?? []).isEmpty)
                                                  EntranceAnimation(index: 1, child: emptyState(Icons.calendar_today_outlined, 'No upcoming activities', 'Activities you organize or join will appear here.'))
                                                else
                                                  GridView.builder(
                                                    shrinkWrap: true,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    itemCount: controller.myActivities!.length,
                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, mainAxisExtent: Dimensions.h_230),
                                                    itemBuilder: (context, index) {
                                                      final a = controller.myActivities![index];
                                                      final textColor = Theme.of(context).highlightColor;
                                                      final start = DateTime.tryParse(a.startsAt ?? '')?.toLocal();
                                                      return EntranceAnimation(
                                                        key: ValueKey('activity${a.activityId}'),
                                                        index: 1 + index,
                                                        child: GestureDetector(
                                                        behavior: HitTestBehavior.opaque,
                                                        onTap: () => controller.openMyActivity(a),
                                                        child: CommonCard(
                                                          padding: EdgeInsets.zero,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.h_10)),
                                                                    child: AppCacheImage(imageUrl: a.image?.url ?? '', size: Dimensions.h_110, widthSize: Get.width, fit: BoxFit.cover, radius: 0),
                                                                  ),
                                                                  Positioned(
                                                                    top: Dimensions.h_6,
                                                                    left: Dimensions.w_6,
                                                                    child: Container(
                                                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_3),
                                                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                                                                      child: Column(
                                                                        children: [
                                                                          Text(
                                                                            start == null ? '' : DateFormat('MMM').format(start).toUpperCase(),
                                                                            style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_8, fontWeight: FontWeight.w800, height: 1.1),
                                                                          ),
                                                                          Text(
                                                                            start == null ? '' : DateFormat('dd').format(start),
                                                                            style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_14, fontWeight: FontWeight.w900, height: 1.1),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(Dimensions.w_8),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        a.title ?? '',
                                                                        maxLines: 2,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, color: textColor, height: 1.1),
                                                                      ),
                                                                      SizedBox(height: Dimensions.h_6),
                                                                      ActivityMeta(icon: CupertinoIcons.clock, text: start == null ? '' : DateFormat('EEE, MMM d, h:mm a').format(start)),
                                                                      SizedBox(height: Dimensions.h_4),
                                                                      ActivityMeta(icon: Icons.location_on_sharp, text: [a.location, a.town].whereType<String>().where((t) => t.isNotEmpty).join(', ')),
                                                                      const Spacer(),
                                                                      Row(
                                                                        children: [
                                                                          if (a.isOrganizer == true)
                                                                            Container(
                                                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_4),
                                                                              decoration: BoxDecoration(
                                                                                color: AppColor.blue(context).withValues(alpha: 0.06),
                                                                                border: Border.all(color: AppColor.border(context), width: 0.8),
                                                                                borderRadius: BorderRadius.circular(Dimensions.h_5),
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Icon(CupertinoIcons.star, size: Dimensions.h_10, color: textColor),
                                                                                  SizedBox(width: Dimensions.w_3),
                                                                                  Text(
                                                                                    'Organizing',
                                                                                    style: TextStyle(color: textColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          SizedBox(width: Dimensions.w_5),
                                                                          Expanded(
                                                                            child: ActivityMeta(icon: CupertinoIcons.person_2, text: '${a.goingCount ?? 0} going'),
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
                                                      );
                                                    },
                                                  ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.h_30),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
    );
  }

  String sentence(String? s) {
    final t = (s ?? '').replaceAll('_', ' ');
    return t.isEmpty ? '' : t[0].toUpperCase() + t.substring(1);
  }

  List<Widget> joinRequest(AttentionItem item) {
    final requestOpen = groupController.toggledSections.contains('r${item.id}');
    final questionsOpen = !groupController.toggledSections.contains('q${item.id}');
    final historyOpen = !groupController.toggledSections.contains('h${item.id}');
    final history = item.history ?? [];
    final questions = history.where((h) => h.action == 'asked').lastOrNull?.questions ?? [];
    final requested = DateTime.tryParse(item.createdAt ?? '')?.toLocal();
    final name = item.name ?? '';
    final textColor = Theme.of(context).highlightColor;
    final grey = AppColor.micrositeGrey(context);
    final blue = AppColor.blue(context);
    final small = TextStyle(color: textColor, fontSize: FontSize.sp_10, height: 1.4);
    final divider = Divider(height: Dimensions.h_20, thickness: 0.5, color: AppColor.border(context));

    Widget toggle(bool open, String title, String trailing, VoidCallback onTap) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          Icon(open ? CupertinoIcons.chevron_down : CupertinoIcons.chevron_right, size: Dimensions.h_12, color: textColor),
          SizedBox(width: Dimensions.w_5),
          Text(
            title,
            style: TextStyle(color: textColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          Text(
            trailing,
            style: TextStyle(color: grey, fontSize: FontSize.sp_9_5),
          ),
        ],
      ),
    );

    Widget button(String text, {Color? fill, Color? color}) => GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_7),
        decoration: BoxDecoration(
          color: fill,
          border: Border.all(color: fill ?? color ?? blue, width: 0.8),
          borderRadius: BorderRadius.circular(Dimensions.h_6),
        ),
        child: Text(
          text,
          style: TextStyle(color: fill != null ? Colors.white : color ?? blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
        ),
      ),
    );

    return [
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => groupController.toggleSection('r${item.id}'),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: Dimensions.h_20,
              backgroundColor: blue.withValues(alpha: 0.12),
              child: Text(
                name.isEmpty ? '?' : name[0].toUpperCase(),
                style: TextStyle(color: blue, fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(width: Dimensions.w_8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(color: textColor, fontSize: FontSize.sp_13, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: Dimensions.h_2),
                  Text([if (requested != null) 'Requested ${DateFormat('dd/MM/yyyy').format(requested)}', if ((item.subject ?? '').isNotEmpty) 'Group: ${item.subject}'].join('\n'), style: small),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_3),
              decoration: BoxDecoration(color: const Color(0xFFFDEBD3), borderRadius: BorderRadius.circular(99)),
              child: Text(
                sentence(item.status),
                style: TextStyle(color: const Color(0xFF9A5B13), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(width: Dimensions.w_4),
            Icon(requestOpen ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down, size: Dimensions.h_13, color: textColor),
          ],
        ),
      ),
      if (requestOpen) ...[
        divider,
        if (questions.isNotEmpty) ...[
          toggle(questionsOpen, 'Waiting for the applicant', '${questions.length} question${questions.length == 1 ? '' : 's'}', () => groupController.toggleSection('q${item.id}')),
          if (questionsOpen)
            Padding(
              padding: EdgeInsets.only(top: Dimensions.h_8),
              child: Text([for (final (i, q) in questions.indexed) '${i + 1}. ${q.question ?? ''}'].join('\n'), style: small),
            ),
          divider,
        ],
        if (history.isNotEmpty) ...[
          toggle(historyOpen, 'Request history', '${history.length} update${history.length == 1 ? '' : 's'}', () => groupController.toggleSection('h${item.id}')),
          if (historyOpen)
            for (final h in history)
              Container(
                margin: EdgeInsets.only(top: Dimensions.h_8, left: Dimensions.w_5),
                padding: EdgeInsets.only(left: Dimensions.w_8),
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: AppColor.border(context), width: 1.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            h.action == 'asked' ? 'Additional questions sent' : sentence(h.action),
                            style: TextStyle(color: textColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Text(
                          DateTime.tryParse(h.createdAt ?? '') == null ? '' : DateFormat('dd/MM/yyyy, HH:mm:ss').format(DateTime.parse(h.createdAt!).toLocal()),
                          style: TextStyle(color: grey, fontSize: FontSize.sp_9_5),
                        ),
                      ],
                    ),
                    for (final q in h.questions ?? []) ...[SizedBox(height: Dimensions.h_4), Text(q.question ?? '', style: small)],
                  ],
                ),
              ),
          divider,
        ],
        Row(
          children: [
            button('Accept', fill: blue),
            SizedBox(width: Dimensions.w_4),
            button('Reject'),
            SizedBox(width: Dimensions.w_4),
            button('Ask for more info'),
            const Spacer(),
            button('Ban Applicant', color: Colors.red),
          ],
        ),
      ],
    ];
  }

  Widget emptyState(IconData icon, String title, String body, {String? button}) {
    return CommonCard(
      width: Get.width,
      child: Column(
        children: [
          SizedBox(height: Dimensions.h_10),
          Container(
            height: Dimensions.h_45,
            width: Dimensions.h_45,
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_8)),
            child: Icon(icon, size: Dimensions.h_20, color: AppColor.blue(context)),
          ),
          SizedBox(height: Dimensions.h_10),
          Text(title, style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700)),
          SizedBox(height: Dimensions.h_10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15),
            child: Text(body, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500)),
          ),
          if (button != null) ...[
            SizedBox(height: Dimensions.h_20),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: groupController.openCreateGroup,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
                decoration: BoxDecoration(color: const Color(0xff1d5fef), borderRadius: BorderRadius.circular(99)),
                child: Text(button, style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2)),
              ),
            ),
          ],
          SizedBox(height: Dimensions.h_15),
        ],
      ),
    );
  }

  Widget buildManagedGroups() {
    final c = groupController;
    final stats = c.mySummary?.stats;
    final invites = c.myInvitesCount;
    final segments = [('Managing', stats?.managedGroups ?? 0), ('Joined', stats?.memberGroups ?? 0), ('Invites', invites)];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.h_10),
        EntranceAnimation(
          child: Text(
          'My group stats',
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        EntranceAnimation(
          child: CommonCard(
          padding: EdgeInsets.symmetric(vertical: Dimensions.h_12),
          child: IntrinsicHeight(
            child: Row(
              children: [
                for (final (i, s) in [('${stats?.totalGroups ?? 0}', 'Total groups'), ('${stats?.managedGroups ?? 0}', 'My Groups'), ('${stats?.memberGroups ?? 0}', 'Joined'), ('$invites', 'Invites')].indexed) ...[
                  if (i > 0) VerticalDivider(width: 0.5, thickness: 0.4, color: Theme.of(context).highlightColor),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          s.$1,
                          style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_20, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: Dimensions.h_4),
                        Text(
                          s.$2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        EntranceAnimation(
          index: 1,
          child: Row(
          children: [
            for (final (i, s) in segments.indexed) ...[
              if (i > 0) SizedBox(width: Dimensions.w_4),
              Expanded(
                child: GestureDetector(
                  onTap: () => c.changeMyGroupTab(i),
                  child: CommonCard(
                    color: c.myGroupTab == i ? AppColor.blue(context) : null,
                    isBorder: c.myGroupTab != i,
                    radius: Dimensions.h_6,
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            s.$1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: c.myGroupTab == i ? Colors.white : Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(width: Dimensions.w_4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_1),
                          decoration: BoxDecoration(color: c.myGroupTab == i ? Colors.white : AppColor.micrositeGrey(context).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(99)),
                          child: Text(
                            '${s.$2}',
                            style: TextStyle(color: c.myGroupTab == i ? AppColor.blue(context) : Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        EntranceAnimation(
          index: 2,
          child: Text(
            '${segments[c.myGroupTab].$1} (${segments[c.myGroupTab].$2})',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        if (c.myGroupTab == 2) ...[
          if (c.myInvitations == null)
            ...[groupCardShimmer(), groupCardShimmer()]
          else if (c.myInvitations!.isEmpty)
            emptyState(CupertinoIcons.envelope, 'No pending invitations', 'New invitations will appear here.', button: 'Create group')
          else
            for (final (n, i) in c.myInvitations!.indexed) EntranceAnimation(key: ValueKey('invite${i.invitationId}'), index: 3 + n, child: invitationCard(i)),
        ] else ...[
          if (c.myGroupItems == null)
            ...[groupCardShimmer(), groupCardShimmer()]
          else if (c.myGroupItems!.isEmpty)
            emptyState(CupertinoIcons.person_2, 'No groups yet', c.myGroupTab == 0 ? 'Groups you create will appear here.' : 'Groups you join will appear here.', button: 'Create group')
          else
            for (final (n, g) in c.myGroupItems!.indexed) EntranceAnimation(key: ValueKey('group${c.myGroupTab}-${g.id}'), index: 3 + n, child: managedGroupCard(g)),
          if (c.myGroupLoadingMore[c.myGroupTab]) const Center(child: CupertinoActivityIndicator()),
        ],
      ],
    );
  }

  Widget invitationCard(InvitationItem item) {
    final blue = AppColor.blue(context);
    final textColor = Theme.of(context).highlightColor;
    final busy = groupController.respondingInvitations.contains(item.invitationId);
    final invited = DateTime.tryParse(item.invitedAt ?? '');

    Widget button(String text, {required bool filled, required VoidCallback onTap}) => Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: busy ? null : onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Dimensions.h_7),
          decoration: BoxDecoration(
            color: filled ? blue : Colors.transparent,
            border: Border.all(color: blue, width: 1),
            borderRadius: BorderRadius.circular(Dimensions.h_6),
          ),
          child: Center(
            child: Text(text, style: TextStyle(color: filled ? Colors.white : blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, height: 1.2)),
          ),
        ),
      ),
    );

    return CommonCard(
      margin: EdgeInsets.only(bottom: Dimensions.h_10),
      padding: EdgeInsets.all(Dimensions.h_6),
      child: Opacity(
        opacity: busy ? 0.5 : 1,
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: Get.width * 0.36,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.h_8),
                      child: AppCacheImage(imageUrl: item.imageUrl ?? '', size: double.infinity, widthSize: double.infinity, radius: Dimensions.h_8),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          invited == null ? 'INVITED' : 'INVITED ${DateFormat('MMM d, yyyy').format(invited).toUpperCase()}',
                          style: TextStyle(color: blue, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                        ),
                        SizedBox(height: Dimensions.h_4),
                        Text(item.name ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: textColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w900)),
                        SizedBox(height: Dimensions.h_6),
                        Text(item.description ?? '', maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: textColor, fontSize: FontSize.sp_10, height: 1.3)),
                        SizedBox(height: Dimensions.h_20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.h_10),
            Row(
              children: [
                button('Accept invitation', filled: true, onTap: () => groupController.respondInvitation(item, true)),
                SizedBox(width: Dimensions.w_5),
                button('Decline', filled: false, onTap: () => groupController.respondInvitation(item, false)),
              ],
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: item.groupId == null ? null : () => groupController.openGroup(item.groupId!),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.h_10),
                child: Center(child: Text('Group details', style: TextStyle(color: blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget managedGroupCard(MyGroupItem g) {
    final location = [g.town?.name ?? '', if ((g.radiusMiles ?? 0) > 0) '${g.radiusMiles} mi'].where((t) => t.isNotEmpty).join(' · ');
    final blue = AppColor.blue(context);
    final textColor = Theme.of(context).highlightColor;
    final requests = groupController.joinRequestsFor(g.id);

    Widget chip(IconData? icon, String text, {Color? color}) => Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_2),
      decoration: BoxDecoration(
        color: color?.withValues(alpha: 0.12),
        border: color == null ? Border.all(color: AppColor.border(context), width: 0.6) : null,
        borderRadius: BorderRadius.circular(Dimensions.h_5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: Dimensions.h_10, color: textColor), SizedBox(width: Dimensions.w_3)],
          Text(
            text,
            style: TextStyle(color: color ?? textColor, fontSize: FontSize.sp_9_5, fontWeight: color == null ? FontWeight.w500 : FontWeight.w700),
          ),
        ],
      ),
    );

    Widget stat(int count, String label) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$count',
            style: TextStyle(color: textColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900, height: 1),
          ),
          SizedBox(height: Dimensions.h_2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5),
          ),
        ],
      ),
    );

    Widget button(String text, {required bool filled, IconData? icon}) => Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Dimensions.h_7),
          decoration: BoxDecoration(
            color: filled ? blue : Colors.transparent,
            border: Border.all(color: blue, width: 0.5),
            borderRadius: BorderRadius.circular(Dimensions.h_6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(color: filled ? Colors.white : blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, height: 1.2),
              ),
              if (icon != null) ...[SizedBox(width: Dimensions.w_4), Icon(icon, size: Dimensions.h_12, color: blue)],
            ],
          ),
        ),
      ),
    );

    return CommonCard(
      margin: EdgeInsets.only(bottom: Dimensions.h_10),
      padding: EdgeInsets.all(Dimensions.h_6),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: Get.width * 0.36,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.h_8),
                          child: AppCacheImage(imageUrl: g.image?.url ?? '', size: double.infinity, widthSize: double.infinity, radius: Dimensions.h_8),
                        ),
                      ),
                      if (g.role == 'owner')
                        Positioned(
                          left: Dimensions.w_5,
                          top: Dimensions.h_6,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_3),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.workspace_premium, size: Dimensions.h_11, color: const Color(0xFFF5A623)),
                                SizedBox(width: Dimensions.w_3),
                                Text(
                                  'Organizer',
                                  style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: Dimensions.w_8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              g.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: textColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_8),
                      Wrap(
                        spacing: Dimensions.w_4,
                        runSpacing: Dimensions.h_4,
                        children: [
                          if ((g.interest?.name ?? '').isNotEmpty) chip(null, g.interest!.name!, color: blue),
                          if ((g.privacy?.label ?? '').isNotEmpty) chip(g.privacy?.code == 1 ? CupertinoIcons.globe : CupertinoIcons.lock, g.privacy!.label!),
                          if (location.isNotEmpty) chip(CupertinoIcons.location_solid, location),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_6),
                      Text(
                        g.description ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textColor, fontSize: FontSize.sp_10, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Row(
            children: [
              stat(g.memberCount ?? 0, 'Members'),
              stat(g.postCount ?? 0, 'Posts'),
              stat(g.upcomingActivityCount ?? 0, 'Upcoming plans'),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          Row(
            children: [
              button('Manage group', filled: true),
              SizedBox(width: Dimensions.w_5),
              button('View group', filled: false, icon: CupertinoIcons.arrow_right),
              if (requests.isNotEmpty) ...[
                SizedBox(width: Dimensions.w_5),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => showJoinRequests(g),
                  child: Container(
                    padding: EdgeInsets.only(left: Dimensions.w_3, right: Dimensions.w_8, top: Dimensions.h_7, bottom: Dimensions.h_7),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.08),
                      border: Border.all(color: Colors.red, width: 0.5),
                      borderRadius: BorderRadius.circular(Dimensions.h_6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: Dimensions.w_3),
                        Text(
                          '${requests.length} Join request${requests.length == 1 ? '' : 's'}',
                          style: TextStyle(color: Colors.red, fontSize: FontSize.sp_10, fontWeight: FontWeight.w900, height: 1.2),
                        ),
                        SizedBox(width: Dimensions.w_3),
                        Icon(CupertinoIcons.chevron_right, size: Dimensions.h_11, color: Colors.red),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget groupCardShimmer() => ShimmerCard(
    Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBox(Get.width * 0.36, Dimensions.h_110, radius: Dimensions.h_8),
            SizedBox(width: Dimensions.w_8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(Dimensions.w_150, Dimensions.h_13),
                  SizedBox(height: Dimensions.h_8),
                  Row(children: [ShimmerBox(Dimensions.w_40, Dimensions.h_13), SizedBox(width: Dimensions.w_4), ShimmerBox(Dimensions.w_55, Dimensions.h_13), SizedBox(width: Dimensions.w_4), ShimmerBox(Dimensions.w_50, Dimensions.h_13)]),
                  SizedBox(height: Dimensions.h_8),
                  ShimmerBox(double.infinity, Dimensions.h_8),
                  SizedBox(height: Dimensions.h_5),
                  ShimmerBox(double.infinity, Dimensions.h_8),
                  SizedBox(height: Dimensions.h_5),
                  ShimmerBox(Dimensions.w_110, Dimensions.h_8),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        Row(
          children: [
            for (var i = 0; i < 3; i++)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ShimmerBox(Dimensions.w_35, Dimensions.h_12), SizedBox(height: Dimensions.h_4), ShimmerBox(Dimensions.w_60, Dimensions.h_8)],
                ),
              ),
          ],
        ),
        SizedBox(height: Dimensions.h_8),
        Row(
          children: [
            Expanded(child: ShimmerBox(double.infinity, Dimensions.h_28, radius: Dimensions.h_6)),
            SizedBox(width: Dimensions.w_5),
            Expanded(child: ShimmerBox(double.infinity, Dimensions.h_28, radius: Dimensions.h_6)),
          ],
        ),
      ],
    ),
    padding: EdgeInsets.all(Dimensions.h_6),
    margin: EdgeInsets.only(bottom: Dimensions.h_10),
  );

  void showJoinRequests(MyGroupItem g) {
    Get.bottomSheet(
      isScrollControlled: true,
      Container(
        height: Get.height * 0.7,
        padding: EdgeInsets.only(left: Dimensions.w_15, right: Dimensions.w_15, top: Dimensions.h_12, bottom: MediaQuery.of(context).padding.bottom + Dimensions.h_15),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_18), topRight: Radius.circular(Dimensions.h_18)),
        ),
        child: GetBuilder<GroupController>(
          id: ControllerBuilders.myGroupsRequests,
          builder: (controller) {
            final requests = controller.joinRequestsFor(g.id);
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: Dimensions.w_35,
                    height: Dimensions.h_4,
                    margin: EdgeInsets.only(bottom: Dimensions.h_12),
                    decoration: BoxDecoration(color: AppColor.micrositeGrey(context).withValues(alpha: 0.4), borderRadius: BorderRadius.circular(99)),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Join requests',
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_16, fontWeight: FontWeight.w900),
                              ),
                              SizedBox(width: Dimensions.w_5),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_1),
                                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(99)),
                                child: Text(
                                  '${requests.length}',
                                  style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, height: 1.2),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.h_2),
                          Text(
                            g.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        width: Dimensions.h_30,
                        height: Dimensions.h_30,
                        decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                        child: Icon(CupertinoIcons.xmark, size: Dimensions.h_13, color: Theme.of(context).highlightColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_15),
                if (requests.isEmpty)
                  emptyState(CupertinoIcons.person_badge_plus, 'No pending requests', 'Join requests for this group will appear here.')
                else
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        for (final item in requests)
                          CommonCard(
                            margin: EdgeInsets.only(bottom: Dimensions.h_10),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: joinRequest(item)),
                          ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget activityGridShimmer() => Row(
    children: [
      for (var i = 0; i < 2; i++) ...[
        if (i > 0) SizedBox(width: Dimensions.w_6),
        Expanded(
          child: ShimmerCard(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(double.infinity, Dimensions.h_110, radius: Dimensions.h_10),
                Padding(
                  padding: EdgeInsets.all(Dimensions.w_8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(double.infinity, Dimensions.h_12),
                      SizedBox(height: Dimensions.h_4),
                      ShimmerIconLine(Dimensions.w_97),
                      ShimmerIconLine(Dimensions.w_80),
                      SizedBox(height: Dimensions.h_20),
                      Row(children: [ShimmerBox(Dimensions.w_65, Dimensions.h_20, radius: Dimensions.h_5), SizedBox(width: Dimensions.w_5), ShimmerBox(Dimensions.w_40, Dimensions.h_8)]),
                    ],
                  ),
                ),
              ],
            ),
            height: Dimensions.h_230,
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    ],
  );

  Widget pageShimmer() {
    return CommonShimmer(
      heroHeight: Dimensions.h_270,
      hero: [
        ShimmerBox(Dimensions.w_35, Dimensions.h_33, radius: Dimensions.h_10),
        const Spacer(),
        ShimmerBox(Dimensions.w_65, Dimensions.h_11),
        SizedBox(height: Dimensions.h_8),
        ShimmerBox(Dimensions.w_150, Dimensions.h_25, radius: Dimensions.h_8),
        SizedBox(height: Dimensions.h_6),
        ShimmerBox(Dimensions.w_220, Dimensions.h_25, radius: Dimensions.h_8),
        SizedBox(height: Dimensions.h_10),
        ShimmerBox(Dimensions.w_220, Dimensions.h_10),
        SizedBox(height: Dimensions.h_5),
        ShimmerBox(Dimensions.w_150, Dimensions.h_10),
        SizedBox(height: Dimensions.h_12),
        Row(children: [ShimmerBox(Dimensions.w_120, Dimensions.h_28, radius: 99), SizedBox(width: Dimensions.w_8), ShimmerBox(Dimensions.w_97, Dimensions.h_28, radius: 99)]),
        const Spacer(),
        Row(
          children: [
            for (var i = 0; i < 3; i++) ...[
              if (i > 0) SizedBox(width: Dimensions.w_6),
              Expanded(child: ShimmerBox(double.infinity, Dimensions.h_60, radius: Dimensions.h_10)),
            ],
          ],
        ),
      ],
      body: [
        SizedBox(height: Dimensions.h_5),
        Row(
          children: [
            for (final w in [Dimensions.w_80, Dimensions.w_37, Dimensions.w_80, Dimensions.w_35]) ...[ShimmerBox(w, Dimensions.h_12), SizedBox(width: Dimensions.w_15)],
          ],
        ),
        SizedBox(height: Dimensions.h_15),
        ShimmerBox(Dimensions.w_120, Dimensions.h_13),
        SizedBox(height: Dimensions.h_10),
        ShimmerCard(
          Row(
            children: [
              for (var i = 0; i < 4; i++)
                Expanded(child: Column(children: [ShimmerBox(Dimensions.w_25, Dimensions.h_20), SizedBox(height: Dimensions.h_4), ShimmerBox(Dimensions.w_55, Dimensions.h_8)])),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: Dimensions.h_12),
        ),
        SizedBox(height: Dimensions.h_10),
        Row(
          children: [
            for (var i = 0; i < 3; i++) ...[
              if (i > 0) SizedBox(width: Dimensions.w_4),
              Expanded(child: ShimmerBox(double.infinity, Dimensions.h_30, radius: Dimensions.h_6)),
            ],
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        ShimmerBox(Dimensions.w_150, Dimensions.h_13),
        SizedBox(height: Dimensions.h_10),
        groupCardShimmer(),
        groupCardShimmer(),
      ],
    );
  }

  Widget buildHeroHeader(bool isLight, GroupController controller) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GetBuilder<GroupController>(
          id: ControllerBuilders.myGroupsHero,
          builder: (c) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            child: AppCacheImage(key: ValueKey(c.myGroupsHeroIndex), alignment: Alignment(0.5, 0), size: Dimensions.h_330, widthSize: Get.width, imageUrl: GroupController.myGroupsHeroImages[c.myGroupsHeroIndex]),
          ),
        ),
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
                padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_5),
                child: Text(
                  "My groups.",
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.3,
                    fontSize: FontSize.sp_30,
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_5),
                child: Text(
                  "Good days ahead.",
                  style: TextStyle(
                    height: 1.2,
                    color: const Color(0xFF9dcaff),
                    fontSize: FontSize.sp_30,
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_10, right: Dimensions.w_60),
                child: Text(
                  'Rides, conversations, and new connections. It’s all here for you.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w500,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_15),
              IntrinsicHeight(
                child: Row(
                  children: [
                    // GestureDetector(
                    //   behavior: HitTestBehavior.opaque,
                    //   onTap: () {
                    //   },
                    //   child: Container(
                    //     margin: EdgeInsets.only(left: Dimensions.w_8, bottom: Dimensions.h_8),
                    //     padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_7),
                    //     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(99)),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         SizedBox(width: Dimensions.w_8),
                    //         Text(
                    //           "See your next plan",
                    //           style: TextStyle(color: Color(0xff1d5fef), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, height: 1.2),
                    //         ),
                    //         SizedBox(width: Dimensions.w_8),
                    //         Padding(
                    //           padding: EdgeInsets.only(top: Dimensions.h_1),
                    //           child: Icon(Icons.arrow_forward, size: Dimensions.h_15, color: Color(0xff1d5fef)),
                    //         ),
                    //         SizedBox(width: Dimensions.w_5),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(width: Dimensions.w_8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.w_8, bottom: Dimensions.h_8),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border.all(color: const Color(0xFF9dcaff), width: 0.5),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: Dimensions.w_8),
                            Text(
                              "Find a group",
                              style: TextStyle(color: const Color(0xFF9dcaff), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, height: 1.2),
                            ),
                            SizedBox(width: Dimensions.w_8),
                            Padding(
                              padding: EdgeInsets.only(top: Dimensions.h_1),
                              child: Icon(CupertinoIcons.plus, size: Dimensions.h_12, color: const Color(0xFF9dcaff)),
                            ),
                            SizedBox(width: Dimensions.w_5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_80),
            ],
          ),
        ),
        Positioned(
          left: Dimensions.w_8,
          right: Dimensions.w_8,
          bottom: Dimensions.h_10,
          child: CarouselSlider.builder(
            itemCount: GroupController.myGroupsHeroImages.length,
            itemBuilder: (context, i, _) => Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.w_1),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.h_6),
                border: Border.all(color: Colors.white, width: 1),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.45), blurRadius: 18, offset: const Offset(0, 8))],
              ),
              child: AppCacheImage(radius: Dimensions.h_6, size: double.infinity, widthSize: Get.width, imageUrl: GroupController.myGroupsHeroImages[i]),
            ),
            options: CarouselOptions(
              height: Dimensions.h_70,
              viewportFraction: 0.45,
              enlargeCenterPage: true,
              enlargeFactor: 0.20,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (i, _) => controller.changeMyGroupsHero(i),
            ),
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
