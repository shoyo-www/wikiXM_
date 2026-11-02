import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/common_shimmer.dart';
import '../widgets/entrance_animation.dart';
import '../widgets/cache_image.dart';

class GroupUserProfile extends StatefulWidget {
  const GroupUserProfile({super.key});

  @override
  State<GroupUserProfile> createState() => _GroupUserProfileState();
}

class _GroupUserProfileState extends State<GroupUserProfile> {
  final GroupController groupController = Get.put(GroupController());

  @override
  void initState() {
    super.initState();
    groupController.getActivityProfile();
  }

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
        id: ControllerBuilders.groupProfilePage,
        builder: (controller) {
          return controller.activityProfile == null && controller.activityProfileLoading
              ? pageShimmer()
              : CommonScrollBlurScaffold(
                  showBack: true,
                  expandedHeight: Dimensions.h_210,
                  expandedColor: Colors.white,
                  collapsedColor: Theme.of(context).highlightColor,
                  hero: GetBuilder<GroupController>(id: ControllerBuilders.groupProfileSections, builder: (c) => buildHeroHeader(isLight, c)),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                        child: GetBuilder<GroupController>(
                          id: ControllerBuilders.groupProfileSections,
                          builder: (c) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Dimensions.h_10),
                              if (c.activityProfile == null)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: Dimensions.h_30),
                                  child: Center(child: Text("Couldn't load your activity profile.", style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_11))),
                                )
                              else ...[
                                EntranceAnimation(index: 0, child: buildInterestChips()),
                                SizedBox(height: Dimensions.h_10),
                                EntranceAnimation(index: 1, child: buildSkillCard()),
                                EntranceAnimation(index: 2, child: buildPreferencesCard()),
                                EntranceAnimation(index: 3, child: buildCommunityCard()),
                                EntranceAnimation(index: 4, child: buildInterestsCard()),
                                EntranceAnimation(index: 5, child: GetBuilder<GroupController>(id: ControllerBuilders.groupProfilePrivacy, builder: (_) => buildPrivacyCard())),
                              ],
                              SizedBox(height: Dimensions.h_30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  // mirrors the loaded page: header text + stats, interest chips, then the section cards
  Widget pageShimmer() {
    Widget cardHeader() => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBox(Dimensions.h_22, Dimensions.h_22, radius: Dimensions.h_5),
        SizedBox(width: Dimensions.w_8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ShimmerBox(Dimensions.w_120, Dimensions.h_13), SizedBox(height: Dimensions.h_5), ShimmerBox(Dimensions.w_150, Dimensions.h_8)],
          ),
        ),
        ShimmerBox(Dimensions.w_50, Dimensions.h_22, radius: 99),
      ],
    );
    Widget tiles(int count, int columns) => GridView.count(
      crossAxisCount: columns,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      crossAxisSpacing: Dimensions.w_6,
      mainAxisSpacing: Dimensions.h_6,
      childAspectRatio: columns == 2 ? 3.2 : 2.2,
      children: [for (var i = 0; i < count; i++) ShimmerBox(double.infinity, double.infinity, radius: Dimensions.h_10)],
    );
    Widget card(List<Widget> children) => ShimmerCard(
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [cardHeader(), SizedBox(height: Dimensions.h_12), ...children]),
      margin: EdgeInsets.only(bottom: Dimensions.h_10),
    );
    Widget meter() => Column(
      children: [
        Row(children: [ShimmerBox(Dimensions.w_80, Dimensions.h_10), const Spacer(), ShimmerBox(Dimensions.w_55, Dimensions.h_10)]),
        SizedBox(height: Dimensions.h_7),
        ShimmerBox(double.infinity, Dimensions.h_5, radius: 99),
        SizedBox(height: Dimensions.h_12),
      ],
    );

    return CommonShimmer(
      heroHeight: Dimensions.h_260,
      hero: [
        ShimmerBox(Dimensions.w_35, Dimensions.h_33, radius: Dimensions.h_10),
        const Spacer(),
        ShimmerBox(Dimensions.w_150, Dimensions.h_11),
        SizedBox(height: Dimensions.h_8),
        ShimmerBox(Dimensions.w_220, Dimensions.h_25, radius: Dimensions.h_8),
        SizedBox(height: Dimensions.h_8),
        ShimmerBox(Dimensions.w_220, Dimensions.h_10),
        SizedBox(height: Dimensions.h_15),
        Row(
          children: [
            for (var i = 0; i < 3; i++) ...[
              if (i > 0) SizedBox(width: Dimensions.w_15),
              ShimmerBox(Dimensions.h_15, Dimensions.h_15, isCircle: true),
              SizedBox(width: Dimensions.w_8),
              ShimmerBox(Dimensions.w_55, Dimensions.h_22, radius: Dimensions.h_5),
            ],
          ],
        ),
        const Spacer(),
        ShimmerBox(Dimensions.w_97, Dimensions.h_28, radius: Dimensions.h_4),
      ],
      body: [
        SizedBox(height: Dimensions.h_10),
        Row(
          children: [
            for (final w in [Dimensions.w_65, Dimensions.w_80, Dimensions.w_60, Dimensions.w_97]) ...[ShimmerBox(w, Dimensions.h_25, radius: 99), SizedBox(width: Dimensions.w_6)],
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        card([meter(), tiles(2, 2)]),
        card([ShimmerBox(double.infinity, Dimensions.h_90, radius: Dimensions.h_10)]),
        card([tiles(3, 3)]),
        card([tiles(4, 2)]),
      ],
    );
  }

  Widget buildInterestChips() {
    final blue = AppColor.blue(context);
    final activities = groupController.profileActivities;
    return SizedBox(
      height: Dimensions.h_25,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: activities.length,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_6),
        itemBuilder: (_, i) {
          final selected = i == groupController.selectedProfileInterest;
          return GestureDetector(
            onTap: () => groupController.selectProfileInterest(i),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
              decoration: BoxDecoration(
                color: selected ? blue : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: selected ? blue : AppColor.border(context), width: 0.6),
              ),
              child: Center(
                child: Text(
                  activities[i].name ?? '',
                  style: TextStyle(color: selected ? Colors.white : Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget sectionCard({required IconData icon, required String title, required String subtitle, bool edit = true, required List<Widget> children}) {
    final blue = AppColor.blue(context);
    return CommonCard(
      margin: EdgeInsets.only(bottom: Dimensions.h_10),
      // interests have very different numbers of fields; grow/shrink smoothly instead of jumping
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        alignment: Alignment.topCenter,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: Dimensions.h_22, color: blue),
              SizedBox(width: Dimensions.w_8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800)),
                    SizedBox(height: Dimensions.h_2),
                    Text(subtitle, style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10)),
                  ],
                ),
              ),
              if (edit && groupController.canEditProfile)
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_5),
                    decoration: BoxDecoration(color: blue.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(99)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_outlined, size: Dimensions.h_12, color: blue),
                        SizedBox(width: Dimensions.w_4),
                        Text('Edit', style: TextStyle(color: blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: Dimensions.h_12),
          ...children,
        ],
        ),
      ),
    );
  }

  BoxDecoration softPanel([Color? color]) => BoxDecoration(color: (color ?? AppColor.blue(context)).withValues(alpha: 0.06), borderRadius: BorderRadius.circular(Dimensions.h_10));

  IconData profileIcon(String? icon) {
    switch (icon) {
      case 'calendar-check':
        return CupertinoIcons.calendar_badge_plus;
      case 'bike':
        return Icons.directions_bike;
      case 'mountains':
        return Icons.landscape_outlined;
      case 'chart-bars':
        return Icons.bar_chart_rounded;
      case 'groups-golf':
        return Icons.sports_golf;
      case 'groups-hiking':
        return Icons.hiking;
      case 'calendar':
      default:
        return CupertinoIcons.calendar;
    }
  }

  Widget buildSkillCard() {
    final c = groupController;
    final blue = AppColor.blue(context);
    final textColor = Theme.of(context).highlightColor;
    final hint = Theme.of(context).hintColor;
    final rows = c.profileSkillRows;
    final tiles = c.profileSkillTiles;
    return sectionCard(
      icon: Icons.bar_chart_rounded,
      title: c.profileTabLabel('skills', 'Skill & Experience'),
      subtitle: c.profileSchema(c.selectedProfileActivity?.sections?.skills)?.intro ?? 'Tell us about your current level',
      children: [
        for (final s in rows) ...[
          Row(
            children: [
              Text(s.label ?? '', style: TextStyle(color: textColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700)),
              const Spacer(),
              s.kind == 'badge'
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_3),
                      decoration: BoxDecoration(color: blue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(99)),
                      child: Text(c.summaryText(s), style: TextStyle(color: blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800)),
                    )
                  : Text(c.summaryText(s), style: TextStyle(color: hint, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700)),
            ],
          ),
          if (s.kind == 'meter') ...[
            SizedBox(height: Dimensions.h_7),
            LinearProgressIndicator(color: blue, value: c.summaryProgress(s), minHeight: Dimensions.h_5, backgroundColor: blue.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(99)),
          ],
          SizedBox(height: Dimensions.h_12),
        ],
        if (tiles.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: tiles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, mainAxisExtent: Dimensions.h_50),
            itemBuilder: (_, i) => Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
              decoration: softPanel(),
              child: Row(
                children: [
                  Icon(profileIcon(tiles[i].icon), size: Dimensions.h_18, color: blue),
                  SizedBox(width: Dimensions.w_8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tiles[i].label ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: hint, fontSize: FontSize.sp_9_5)),
                        Text(c.summaryText(tiles[i]), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: textColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget buildPreferencesCard() {
    final c = groupController;
    final textColor = Theme.of(context).highlightColor;
    final summaries = c.profilePreferenceSummaries;
    final schema = c.profileSchema(c.selectedProfileActivity?.sections?.preferences);
    return sectionCard(
      icon: CupertinoIcons.compass,
      title: c.profileTabLabel('preferences', 'Activity Preferences'),
      subtitle: schema?.intro ?? 'What are you looking for?',
      children: [
        if ((schema?.detailsHeading ?? '').isNotEmpty) ...[
          Text(schema!.detailsHeading!, style: TextStyle(color: textColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800)),
          SizedBox(height: Dimensions.h_8),
        ],
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Dimensions.h_12),
          decoration: softPanel(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final (i, s) in summaries.indexed) ...[
                if (i > 0) Divider(height: Dimensions.h_20, thickness: 0.5, color: AppColor.border(context)),
                Text(s.label ?? '', style: TextStyle(color: textColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700)),
                SizedBox(height: Dimensions.h_2),
                Text(c.summaryText(s), style: TextStyle(color: textColor, fontSize: FontSize.sp_11)),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCommunityCard() {
    final c = groupController;
    final green = AppColor.green(context);
    final items = c.activityProfile?.community?.items ?? [];
    return sectionCard(
      icon: CupertinoIcons.person_3_fill,
      title: c.profileTabLabel('community', 'Community'),
      subtitle: '${c.activityProfile?.community?.total ?? items.length} community groups • Groups visible to you',
      edit: false,
      children: [
        if (items.isEmpty)
          Text('No community groups yet.', style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10))
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: Dimensions.w_5, mainAxisSpacing: Dimensions.h_5, mainAxisExtent: Dimensions.h_45),
            itemBuilder: (_, i) => Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
              decoration: softPanel(green),
              child: Row(
                children: [
                  Icon(CupertinoIcons.person_2_fill, size: Dimensions.h_15, color: green),
                  SizedBox(width: Dimensions.w_4),
                  Expanded(
                    child: Text(items[i].name ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget buildPrivacyCard() {
    final c = groupController;
    final blue = AppColor.blue(context);
    final textColor = Theme.of(context).highlightColor;
    final hint = Theme.of(context).hintColor;
    final options = c.activityProfile?.privacy?.options ?? [];
    IconData privacyIcon(String? value) => value == 'everyone' ? CupertinoIcons.person_2_fill : value == 'members' ? CupertinoIcons.person_3_fill : CupertinoIcons.person_fill;
    return sectionCard(
      icon: CupertinoIcons.lock_fill,
      title: c.profileTabLabel('privacy', 'Privacy'),
      subtitle: 'Control who can see your activity profile',
      children: [
        Text('Who can see this Activity Profile?', style: TextStyle(color: textColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800)),
        SizedBox(height: Dimensions.h_8),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.border(context), width: 0.6),
            borderRadius: BorderRadius.circular(Dimensions.h_10),
          ),
          child: Column(
            children: [
              for (final (i, option) in options.indexed) ...[
                if (i > 0) Divider(height: 0.6, thickness: 0.6, color: AppColor.border(context)),
                Builder(
                  builder: (context) {
                    final selected = option.value == c.selectedProfilePrivacy;
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => c.selectProfilePrivacy(option.value),
                      child: Container(
                        color: selected ? blue.withValues(alpha: 0.06) : null,
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                        child: Row(
                          children: [
                            Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, size: Dimensions.h_15, color: selected ? blue : hint),
                            SizedBox(width: Dimensions.w_10),
                            Icon(privacyIcon(option.value), size: Dimensions.h_15, color: selected ? blue : hint),
                            SizedBox(width: Dimensions.w_10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(option.label ?? '', style: TextStyle(color: textColor, fontSize: FontSize.sp_10, fontWeight: selected ? FontWeight.w800 : FontWeight.w600)),
                                  Text(c.profilePrivacyHint(option.value), style: TextStyle(color: hint, fontSize: FontSize.sp_9_5)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        Container(
          padding: EdgeInsets.all(Dimensions.h_10),
          decoration: softPanel(),
          child: Row(
            children: [
              CircleAvatar(radius: Dimensions.h_15, backgroundColor: blue.withValues(alpha: 0.12), child: Icon(CupertinoIcons.eye_fill, size: Dimensions.h_15, color: blue)),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.profilePrivacyLabel, style: TextStyle(color: textColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800)),
                    Text('This setting controls access to your activity profile.', style: TextStyle(color: hint, fontSize: FontSize.sp_9_5)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildInterestsCard() {
    final c = groupController;
    final textColor = Theme.of(context).highlightColor;
    final activities = c.profileActivities;
    final palette = [AppColor.blue(context), AppColor.orange(context), AppColor.green(context), AppColor.violet(context)];
    return sectionCard(
      icon: CupertinoIcons.star_fill,
      title: c.profileTabLabel('interests', 'Activity Interests'),
      subtitle: 'Your interest levels in different activities',
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: activities.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, mainAxisExtent: Dimensions.h_50),
          itemBuilder: (_, i) {
            final activity = activities[i];
            final color = palette[i % palette.length];
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => c.selectProfileInterest(i),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
                decoration: softPanel(),
                child: Row(
                  children: [
                    CircleAvatar(radius: Dimensions.h_15, backgroundColor: color.withValues(alpha: 0.12), child: Icon(groupInterestIcon(activity.icon), size: Dimensions.h_15, color: color)),
                    SizedBox(width: Dimensions.w_6),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(activity.name ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: textColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800)),
                          Text(c.profileSkillText(activity), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_9_5)),
                        ],
                      ),
                    ),
                    Icon(CupertinoIcons.chevron_right, size: Dimensions.h_12, color: textColor),
                  ],
                ),
              ),
            );
          },
        ),
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
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: controller.profileHeroImage == null
              ? Container(height: Dimensions.h_330, width: Get.width, color: const Color(0xFF020B15))
              : AppCacheImage(key: ValueKey(controller.profileHeroImage), alignment: Alignment(0.5, 0), size: Dimensions.h_330, widthSize: Get.width, imageUrl: controller.profileHeroImage!),
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
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_80),
                child: Text(
                  'YOUR ACTIVITY STORY, ${controller.profileFirstName}'.toUpperCase(),
                  style: TextStyle(color: const Color(0xFFFFE47A), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_5),
                child: Text(
                  "My Activity Profile",
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
                  'Your skills, your kind of activity, and the people you’d like to meet.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w500,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8, right: Dimensions.w_8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final (i, (value, label)) in controller.profileHeroStats.indexed) ...[
                      if (i > 0) SizedBox(width: Dimensions.w_8),
                      Expanded(child: communityStatItem(icon: const [CupertinoIcons.person_3_fill, CupertinoIcons.calendar, CupertinoIcons.star_fill][i], value: value, label: label, iconSize: Dimensions.h_15)),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: groupController.openCreateGroup,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: iconSize ?? Dimensions.h_18, fontWeight: FontWeight.bold, color: Colors.white),
        SizedBox(width: Dimensions.w_6),
        // a third of the header is narrow: long labels ("activities organized") wrap to a second line
        Expanded(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900, color: AppColor.white, height: 1),
            ),
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: FontSize.sp_10,
                height: 1.15,
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
        ),
      ],
    );
  }
}
