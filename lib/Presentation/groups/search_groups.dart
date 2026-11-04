import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/groups/groups_drawer.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_dropdown.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_shimmer.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../../data/datasource/remote/models/response/search_group.dart' as discover;
import '../widgets/cache_image.dart';
import '../widgets/drawer/src/slider_direction.dart';
import '../widgets/drawer/src/slider_drawer.dart';
import '../widgets/entrance_animation.dart';

class SearchGroups extends StatefulWidget {
  const SearchGroups({super.key});

  @override
  State<SearchGroups> createState() => _SearchGroupsState();
}

class _SearchGroupsState extends State<SearchGroups> {
  final GroupController controller = Get.put(GroupController());
  final GlobalKey<SliderDrawerState> filterDrawerKey = GlobalKey<SliderDrawerState>();
  static const _heroFallback = 'https://preetis-html.vercel.app/assets/images/groups/discover-groups/hero.webp';

  @override
  void initState() {
    super.initState();
    controller.loadDiscover();
  }

  @override
  Widget build(BuildContext context) {
    return GroupsDrawer(
      builder: (openDrawer) => SliderDrawer(
        key: filterDrawerKey,
        sliderOpenSize: Dimensions.w_260,
        isDraggable: false,
        slideDirection: SlideDirection.rightToLeft,
        slider: Container(
          height: double.infinity,
          color: Theme.of(context).cardColor,
          child: GetBuilder<GroupController>(id: ControllerBuilders.discoverFilters, builder: (c) => filtersWidget(c)),
        ),
        child: AppScaffold(
          top: false,
          bottom: false,
          bodyPadding: EdgeInsets.zero,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: GetBuilder<GroupController>(
            id: ControllerBuilders.discoverGroups,
            builder: (c) => c.discoverOverviewLoading && c.discoverOverview == null
                ? pageShimmer()
                : NotificationListener<ScrollNotification>(
                    onNotification: (n) {
                      if (n.metrics.axis == Axis.vertical && n.metrics.pixels >= n.metrics.maxScrollExtent - 300) controller.loadMoreDiscoverGroups();
                      return false;
                    },
                    child: CommonScrollBlurScaffold(
                      showBack: true,
                      isDrawer: true,
                      onTap: openDrawer,
                      expandedHeight: Dimensions.h_210,
                      expandedColor: Colors.white,
                      collapsedColor: Theme.of(context).highlightColor,
                      hero: buildHero(context, c),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Dimensions.h_8),
                                EntranceAnimation(child: buildSearch(context)),
                                SizedBox(height: Dimensions.h_12),
                                EntranceAnimation(index: 1, child: categoryChips(context)),
                                SizedBox(height: Dimensions.h_12),
                              ],
                            ),
                          ),
                        ),
                        GetBuilder<GroupController>(
                          id: ControllerBuilders.discoverGroupsList,
                          builder: (c) => SliverPadding(padding: EdgeInsets.fromLTRB(Dimensions.w_8, 0, Dimensions.w_8, Dimensions.h_20), sliver: groupsGrid(context, c)),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget pageShimmer() {
    return CommonShimmer(
      heroHeight: Dimensions.h_210,
      hero: [
        ShimmerBox(Dimensions.w_35, Dimensions.h_33, radius: Dimensions.h_10),
        const Spacer(),
        ShimmerBox(Dimensions.w_97, Dimensions.h_10),
        SizedBox(height: Dimensions.h_6),
        ShimmerBox(Dimensions.w_150, Dimensions.h_25, radius: Dimensions.h_8),
        SizedBox(height: Dimensions.h_6),
        ShimmerBox(Dimensions.w_220, Dimensions.h_25, radius: Dimensions.h_8),
        SizedBox(height: Dimensions.h_10),
        ShimmerBox(Dimensions.w_220, Dimensions.h_10),
        SizedBox(height: Dimensions.h_12),
        Row(
          children: [
            for (var i = 0; i < 3; i++) ...[if (i > 0) SizedBox(width: Dimensions.w_8), Expanded(child: ShimmerBox(double.infinity, Dimensions.h_28, radius: 99))],
          ],
        ),
      ],
      body: [
        SizedBox(height: Dimensions.h_8),
        ShimmerBox(double.infinity, Dimensions.h_35, radius: 99),
        SizedBox(height: Dimensions.h_12),
        chipsShimmer(),
        SizedBox(height: Dimensions.h_12),
        Row(
          children: [
            Expanded(child: cardShimmer()),
            SizedBox(width: Dimensions.w_8),
            Expanded(child: cardShimmer()),
          ],
        ),
      ],
    );
  }

  Widget chipsShimmer() {
    return SizedBox(
      height: Dimensions.h_30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 4,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_10),
        itemBuilder: (_, _) => ShimmerBox(Dimensions.w_100, Dimensions.h_30, radius: 99),
      ),
    );
  }

  // same shape as a group card: cover, title, description, meta row, button
  Widget cardShimmer() {
    return ShimmerCard(
      height: Dimensions.h_270,
      padding: EdgeInsets.zero,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(double.infinity, Dimensions.h_130, radius: Dimensions.h_8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.h_8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(Dimensions.w_120, Dimensions.h_12),
                  SizedBox(height: Dimensions.h_8),
                  ShimmerBox(double.infinity, Dimensions.h_8),
                  SizedBox(height: Dimensions.h_5),
                  ShimmerBox(Dimensions.w_97, Dimensions.h_8),
                  const Spacer(),
                  ShimmerIconLine(Dimensions.w_80),
                  SizedBox(height: Dimensions.h_12),
                  ShimmerBox(double.infinity, Dimensions.h_25, radius: Dimensions.h_10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHero(BuildContext context, GroupController c) {
    final overview = c.discoverOverview;
    final stats = overview?.statistics;
    final number = NumberFormat.decimalPattern();
    String value(int? v) => v == null ? '–' : number.format(v);
    final statItems = [
      (value: value(stats?.totalGroups), label: 'Groups', icon: CupertinoIcons.person_3_fill, color: const Color(0xFF1D5FEF)),
      (value: value(stats?.totalMembers), label: 'Members', icon: CupertinoIcons.person_2_fill, color: const Color(0xFF0F9F8F)),
      (value: value(stats?.activeGroupsThisWeek), label: 'Active this week', icon: CupertinoIcons.calendar, color: const Color(0xFFC8962E)),
    ];
    final shadow = [Shadow(color: Colors.black.withValues(alpha: 0.6), blurRadius: 20, offset: const Offset(0, 2))];
    final titleStyle = TextStyle(fontSize: FontSize.sp_30, fontWeight: FontWeight.w900, height: 1.05, letterSpacing: -1, shadows: shadow);
    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppCacheImage(alignment: Alignment(0.5, 0), size: Dimensions.h_330, widthSize: Get.width, imageUrl: overview?.town?.image ?? _heroFallback),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xFF020B15).withValues(alpha: 0.35), const Color(0xFF020B15).withValues(alpha: 0.5), const Color(0xFF020B15).withValues(alpha: 0.75)],
                stops: const [0.0, 0.35, 1.0],
              ),
            ),
          ),
          Positioned(
            left: Dimensions.w_15,
            right: Dimensions.w_15,
            bottom: Dimensions.h_20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DISCOVER GROUPS',
                  style: TextStyle(color: const Color(0xFFFFE47A), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, letterSpacing: 0.6),
                ),
                SizedBox(height: Dimensions.h_4),
                Text.rich(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Groups in\n',
                        style: titleStyle.copyWith(color: Colors.white),
                      ),
                      TextSpan(
                        text: overview?.town?.displayName ?? '',
                        style: titleStyle.copyWith(color: const Color(0xFF9CC7FF)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.h_6),
                Text(
                  'Meet people who share your interests and get involved in your community.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.92), fontSize: FontSize.sp_12, fontWeight: FontWeight.w500, height: 1.35, shadows: shadow),
                ),
                SizedBox(height: Dimensions.h_15),
                BackdropGroup(
                  child: Row(
                    children: [
                      for (final (i, st) in statItems.indexed) ...[
                        if (i > 0) SizedBox(width: Dimensions.w_8),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(99),
                            child: BackdropFilter.grouped(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7, vertical: Dimensions.h_4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(99),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.28), width: 0.8),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(Dimensions.h_3),
                                      decoration: BoxDecoration(color: st.color.withValues(alpha: 0.9), shape: BoxShape.circle),
                                      child: Icon(st.icon, size: Dimensions.h_13, color: Colors.white),
                                    ),
                                    SizedBox(width: Dimensions.w_6),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            st.value,
                                            maxLines: 1,
                                            style: TextStyle(color: Colors.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900, height: 1.1),
                                          ),
                                          Text(
                                            st.label,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
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
                      (Theme.of(context).brightness == Brightness.light ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.0),
                      (Theme.of(context).brightness == Brightness.light ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.15),
                      (Theme.of(context).brightness == Brightness.light ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.35),
                      (Theme.of(context).brightness == Brightness.light ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.78),
                      Theme.of(context).brightness == Brightness.light ? AppColor.softBackground : AppColor.backgroundDark,
                    ],
                    stops: const [0.08, 0.25, 0.45, 0.75, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch(BuildContext context) {
    final blue = AppColor.blue(context);
    return SizedBox(
      height: Dimensions.h_35,
      child: GetBuilder<GroupController>(
        id: ControllerBuilders.discoverGroupsList,
        builder: (c) => Row(
          children: [
            Expanded(
              child: TextField(
                controller: c.discoverSearchController,
                onChanged: c.searchDiscoverGroups,
                textInputAction: TextInputAction.search,
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: SizedBox(
                    width: Dimensions.w_20,
                    height: Dimensions.h_20,
                    child: Icon(CupertinoIcons.search, size: Dimensions.h_15, color: blue),
                  ),
                  suffixIcon: c.discoverSearchController.text.isEmpty
                      ? const SizedBox.shrink()
                      : SizedBox(
                          width: Dimensions.w_20,
                          height: Dimensions.h_20,
                          child: GestureDetector(
                            onTap: c.clearDiscoverSearch,
                            child: Center(
                              child: Icon(CupertinoIcons.clear_circled_solid, size: Dimensions.h_18, color: Theme.of(context).hintColor),
                            ),
                          ),
                        ),
                  fillColor: Theme.of(context).cardColor,
                  hintText: 'Search groups, activities, interests…',
                  hintStyle: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_11),
                  contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.h_50),
                    borderSide: BorderSide(color: AppColor.border(context), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.h_50),
                    borderSide: BorderSide(color: blue, width: 1.2),
                  ),
                ),
              ),
            ),
            SizedBox(width: Dimensions.w_8),
            Semantics(
              button: true,
              label: 'Filters',
              child: GestureDetector(
                onTap: () => filterDrawerKey.currentState?.openSlider(),
                child: Container(
                  width: Dimensions.h_33,
                  height: Dimensions.h_33,
                  decoration: BoxDecoration(
                    color: c.discoverFiltersActive ? AppColor.blueSoft(context) : Theme.of(context).cardColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: c.discoverFiltersActive ? blue : AppColor.border(context), width: 1),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.filter_list_alt, size: Dimensions.h_20, color: blue),
                      if (c.discoverFiltersActive)
                        Positioned(
                          top: Dimensions.h_7,
                          right: Dimensions.h_7,
                          child: Container(
                            width: Dimensions.h_7,
                            height: Dimensions.h_7,
                            decoration: BoxDecoration(color: AppColor.red(context), shape: BoxShape.circle),
                          ),
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
  }

  Widget filtersWidget(GroupController c) {
    final ink = AppColor.ink(context);
    final muted = AppColor.muted(context);
    final blue = AppColor.blue(context);
    final border = AppColor.border(context);
    final red = AppColor.red(context);
    final filters = c.discoverOverview?.filters;
    final town = c.discoverOverview?.town?.displayName;

    Widget sectionTitle(String title) {
      return Padding(
        padding: EdgeInsets.only(bottom: Dimensions.h_7),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(color: ink, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
        ),
      );
    }

    Widget checkItem({required String title, required bool selected, required VoidCallback onTap}) {
      return Padding(
        padding: EdgeInsets.only(bottom: Dimensions.h_8),
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Container(
                width: Dimensions.h_13,
                height: Dimensions.h_13,
                decoration: BoxDecoration(
                  color: selected ? blue : Colors.transparent,
                  border: Border.all(color: selected ? blue : muted, width: 0.8),
                  borderRadius: BorderRadius.circular(Dimensions.h_1),
                ),
                child: selected ? Icon(CupertinoIcons.checkmark, size: Dimensions.h_12, color: Colors.white) : null,
              ),
              SizedBox(width: Dimensions.w_7),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget dropdown({required String? value, required IconData icon, required List<({String value, String label, IconData? icon, Color? color})> options, required ValueChanged<String> onChanged}) {
      return CommonDropdown(
        items: options,
        value: options.where((o) => o.value == value).firstOrNull,
        icon: icon,
        itemLabel: (o) => o.label,
        itemIcon: (o) => o.icon,
        itemColor: (o) => o.color,
        onChanged: (o) => onChanged(o.value),
      );
    }

    Widget divider() => Container(
      height: 0.4,
      width: double.infinity,
      color: border,
      margin: EdgeInsets.symmetric(vertical: Dimensions.h_10),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.h_40),
          Row(
            children: [
              Text(
                'Filter Groups'.toUpperCase(),
                style: TextStyle(color: ink, fontSize: FontSize.sp_14, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => filterDrawerKey.currentState?.closeSlider(),
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
                  sectionTitle(town == null ? 'Distance' : 'Distance from $town'),
                  dropdown(
                    value: c.discoverDistance,
                    icon: CupertinoIcons.location_solid,
                    options: [for (final d in filters?.distanceOptions ?? <int>[]) (value: '$d', label: 'Within $d miles', icon: null, color: null)],
                    onChanged: c.setDiscoverDistance,
                  ),
                  SizedBox(height: Dimensions.h_13),
                  sectionTitle('Group category'),
                  dropdown(
                    value: c.discoverCategory,
                    icon: CupertinoIcons.square_grid_2x2_fill,
                    options: [for (final cat in c.discoverOverview?.categories ?? []) (value: cat.id ?? '', label: cat.name ?? '', icon: categoryIcon(cat.icon), color: categoryColor(cat.color))],
                    onChanged: c.setDiscoverFilterCategory,
                  ),
                  divider(),
                  sectionTitle('Group type'),
                  SizedBox(height: Dimensions.h_5),
                  for (final t in filters?.groupTypes ?? []) checkItem(title: t.label ?? '', selected: c.discoverTypes.contains(t.value), onTap: () => c.toggleDiscoverType(t.value ?? 'all')),
                  divider(),
                  sectionTitle('Activity level'),
                  SizedBox(height: Dimensions.h_5),
                  for (final l in filters?.activityLevels ?? []) checkItem(title: l.label ?? '', selected: c.discoverLevels.contains(l.value), onTap: () => c.toggleDiscoverLevel(l.value ?? 'all')),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: Dimensions.h_28,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      c.clearDiscoverFilters();
                      filterDrawerKey.currentState?.closeSlider();
                    },
                    icon: Icon(Icons.refresh_rounded, size: Dimensions.h_13, color: red),
                    label: Text(
                      'Clear filters',
                      style: TextStyle(color: red, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: red,
                      side: BorderSide(color: red, width: 0.8),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: SizedBox(
                  height: Dimensions.h_28,
                  child: ElevatedButton(
                    onPressed: () {
                      c.applyDiscoverFilters();
                      filterDrawerKey.currentState?.closeSlider();
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

  Widget categoryChips(BuildContext context) {
    return SizedBox(
      height: Dimensions.h_30,
      child: GetBuilder<GroupController>(
        id: ControllerBuilders.discoverGroupsList,
        builder: (c) {
          final categories = c.discoverOverview?.categories;
          if (categories == null) return chipsShimmer();
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: categories.length,
            separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_10),
            itemBuilder: (context, i) {
              final cat = categories[i];
              final selected = c.discoverCategory == cat.id;
              final color = categoryColor(cat.color);
              return Semantics(
                button: true,
                selected: selected,
                child: GestureDetector(
                  onTap: () => c.selectDiscoverCategory(cat.id ?? 'all'),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(Dimensions.w_5, 0, Dimensions.w_12, 0),
                    decoration: BoxDecoration(
                      color: selected ? AppColor.blue(context) : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.h_8),
                      border: Border.all(color: selected ? AppColor.blue(context) : AppColor.border(context)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(Dimensions.h_3),
                          decoration: BoxDecoration(color: selected ? Colors.white.withValues(alpha: 0.2) : color.withValues(alpha: 0.12), shape: BoxShape.circle),
                          child: Icon(categoryIcon(cat.icon), size: Dimensions.h_12, color: selected ? Colors.white : color),
                        ),
                        SizedBox(width: Dimensions.w_8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cat.name ?? '',
                              style: TextStyle(color: selected ? Colors.white : Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '${cat.groupCount ?? 0} groups',
                              style: TextStyle(color: selected ? Colors.white : Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget groupsGrid(BuildContext context, GroupController c) {
    final groups = c.discoverItems;
    final blue = AppColor.blue(context);
    final ink = Theme.of(context).highlightColor;
    final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_8, mainAxisSpacing: Dimensions.h_10, mainAxisExtent: Dimensions.h_260);
    if (groups == null) {
      return SliverGrid.builder(itemCount: 4, gridDelegate: gridDelegate, itemBuilder: (_, _) => cardShimmer());
    }
    if (groups.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.h_20),
          child: Center(
            child: Column(
              children: [
                Text(
                  'No groups match your search',
                  style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                ),
                TextButton(
                  onPressed: c.clearDiscoverFilters,
                  child: Text(
                    'Clear filters',
                    style: TextStyle(color: blue, fontSize: FontSize.sp_11),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return SliverMainAxisGroup(
      slivers: [
        SliverGrid.builder(
          itemCount: groups.length,
          gridDelegate: gridDelegate,
          itemBuilder: (context, index) => EntranceAnimation(index: index < 4 ? index + 2 : 0, child: groupCard(context, c, groups[index])),
        ),
        if (c.discoverLoadingMore)
          SliverPadding(
            padding: EdgeInsets.only(top: Dimensions.h_10),
            sliver: SliverGrid.builder(itemCount: 2, gridDelegate: gridDelegate, itemBuilder: (_, _) => cardShimmer()),
          ),
      ],
    );
  }

  Widget groupCard(BuildContext context, GroupController c, discover.Item g) {
    final blue = AppColor.blue(context);
    final ink = Theme.of(context).highlightColor;
    final saved = c.savedDiscoverGroups.contains(g.id);
    final isOwner = g.isOwner == true;
    final isMember = isOwner || c.discoverJoined(g);
    final joined = isMember || c.discoverRequested(g);
    final doneColor = isMember ? AppColor.green(context) : blue;
    // owner: solid green with white text in both themes, like the solid blue join button (theme green turns pale in dark mode)
    // bookmark and join button keep their own taps; anywhere else on the card opens the group
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => c.openDiscoverGroup(g),
      child: CommonCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.h_8)),
                  child: AppCacheImage(imageUrl: g.image?.url ?? c.discoverOverview?.defaultGroupImage ?? '', radius: 0, widthSize: Get.width, size: Dimensions.h_130, fit: BoxFit.cover),
                ),
                Positioned(
                  right: Dimensions.w_6,
                  top: Dimensions.h_6,
                  child: GestureDetector(
                    onTap: () => c.toggleSaveDiscoverGroup(g.id ?? ''),
                    child: Container(
                      width: Dimensions.h_20,
                      height: Dimensions.h_20,
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: Icon(saved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark, color: AppColor.blue(context), size: Dimensions.h_10),
                    ),
                  ),
                ),
                if (g.interests?.firstOrNull?.name case final interest?)
                  Positioned(
                    left: Dimensions.w_6,
                    right: Dimensions.w_6,
                    top: Dimensions.h_8,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(Dimensions.w_4, Dimensions.h_2, Dimensions.w_7, Dimensions.h_2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Dimensions.h_4),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 6, offset: const Offset(0, 2))],
                        ),
                        child: Text(
                          interest.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(Dimensions.w_5, Dimensions.h_8, Dimensions.w_5, Dimensions.h_8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      g.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ink, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1.2, letterSpacing: -0.2),
                    ),
                    SizedBox(height: Dimensions.h_4),
                    Text(
                      g.description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ink, fontSize: FontSize.sp_9_5, height: 1.35),
                    ),
                    SizedBox(height: Dimensions.h_12),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.person_2, size: Dimensions.h_12, color: blue),
                              SizedBox(width: Dimensions.w_3),
                              Text(
                                c.discoverMembers(g),
                                style: TextStyle(color: ink, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.location_on_sharp, size: Dimensions.h_12, color: blue),
                              Expanded(
                                child: Text(
                                  g.location ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: ink, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => c.tapDiscoverAction(g),
                      child: Container(
                        height: Dimensions.h_25,
                        decoration: BoxDecoration(
                          color: isOwner
                              ? const Color(0xFF087C4B)
                              : joined
                              ? (isMember ? AppColor.greenSoft(context) : AppColor.blueSoft(context))
                              : const Color(0xFF1D5FEF),
                          borderRadius: BorderRadius.circular(Dimensions.h_10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              c.discoverActionLabel(g),
                              style: TextStyle(color: joined && !isOwner ? doneColor : Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800),
                            ),
                            if (!isOwner) ...[
                              SizedBox(width: Dimensions.w_5),
                              Icon(joined ? CupertinoIcons.checkmark_alt : CupertinoIcons.arrow_right, size: Dimensions.h_13, color: joined ? doneColor : Colors.white),
                            ],
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
      ),
    );
  }

  Color categoryColor(String? color) {
    switch (color) {
      case 'green':
        return const Color(0xFF16A34A);
      case 'teal':
        return const Color(0xFF0E7490);
      case 'orange':
        return const Color(0xFFEA580C);
      case 'red':
        return const Color(0xFFDC2626);
      case 'pink':
        return const Color(0xFFDB2777);
      case 'violet':
      case 'purple':
        return const Color(0xFF7C3AED);
      case 'blue':
      default:
        return const Color(0xFF2563EB);
    }
  }

  IconData categoryIcon(String? icon) {
    switch (icon) {
      case 'people-fill':
        return CupertinoIcons.square_grid_2x2_fill;
      case 'groups-running':
        return Icons.directions_run_rounded;
      case 'heart-hand':
        return Icons.volunteer_activism_rounded;
      case 'briefcase':
        return CupertinoIcons.briefcase_fill;
      case 'globe':
        return CupertinoIcons.globe;
      case 'groups-skiing':
        return Icons.downhill_skiing_rounded;
      case 'groups-pickleball':
        return Icons.sports_tennis_rounded;
      case 'groups-golf':
        return Icons.sports_golf_rounded;
      case 'groups-hiking':
        return Icons.hiking_rounded;
      case 'bike':
        return Icons.directions_bike_rounded;
      case 'camera':
        return CupertinoIcons.camera_fill;
      case 'leaf':
        return Icons.eco_rounded;
      case 'users':
      default:
        return CupertinoIcons.person_2_fill;
    }
  }
}
