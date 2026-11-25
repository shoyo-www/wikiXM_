import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/alerts/alerts_controller.dart';
import 'package:wikixm/Presentation/alerts/alerts_drawer.dart';
import 'package:wikixm/Presentation/alerts/alerts_home.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/common_tabs.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_dropdown.dart';
import 'package:wikixm/Presentation/widgets/common_empty_view.dart';
import 'package:wikixm/Presentation/widgets/common_error_view.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_shimmer.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/entrance_animation.dart';
import '../../data/datasource/remote/models/response/alert_categories.dart' show CategoryIncident;

class AllAlerts extends StatelessWidget with AlertsUi {
  const AllAlerts({super.key});

  AlertsController get controller => Get.find<AlertsController>();

  @override
  Widget build(BuildContext context) {
    return AlertsDrawer(
      builder: (openDrawer) => GetBuilder<AlertsController>(
        init: controller,
        id: ControllerBuilders.allAlerts,
        // first open: the whole page is a placeholder until the categories arrive
        builder: (c) => c.alertCategories.isEmpty && c.alertCategoriesLoading
            ? AppScaffold(top: false, bottom: false, bodyPadding: EdgeInsets.zero, backgroundColor: Theme.of(context).scaffoldBackgroundColor, body: alertsShimmer())
            : CommonScrollBlurScaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                collapsedColor: Theme.of(context).highlightColor,
                showBack: true,
                isDrawer: true,
                onTap: openDrawer,
                expandedHeight: Dimensions.h_170,
                hero: buildHero(context, c),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Dimensions.h_8),
                          EntranceAnimation(index: 1, child: categoryChips(context, c)),
                          SizedBox(height: Dimensions.h_6),
                          EntranceAnimation(index: 2, child: statusDropdown(context, c)),
                          SizedBox(height: Dimensions.h_20),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(Dimensions.w_8, 0, Dimensions.w_8, MediaQuery.paddingOf(context).bottom + Dimensions.h_20),
                    // paging and loading only rebuild the list, not the hero and filters
                    sliver: GetBuilder<AlertsController>(id: ControllerBuilders.allAlertsList, builder: (c) => alertsGrid(context, c)),
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildHero(BuildContext context, AlertsController c) {
    final fade = Theme.of(context).brightness == Brightness.light ? AppColor.softBackground : AppColor.backgroundDark;
    final shadow = [Shadow(color: AppColor.black.withValues(alpha: 0.6), blurRadius: 20, offset: const Offset(0, 2))];
    final titleStyle = TextStyle(fontSize: FontSize.sp_30, fontWeight: FontWeight.w900, height: 1.05, letterSpacing: -1, shadows: shadow);
    final town = c.alertsTownName ?? c.townName;
    return Stack(
      fit: StackFit.expand,
      children: [
        AppCacheImage(alignment: Alignment(0.5, 0), size: Dimensions.h_330, widthSize: Get.width, imageUrl: c.headerImage),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColor.profileHeroDark.withValues(alpha: 0.35), AppColor.profileHeroDark.withValues(alpha: 0.5), AppColor.profileHeroDark.withValues(alpha: 0.75)], stops: const [0.0, 0.35, 1.0]),
          ),
        ),
        Positioned(
          left: Dimensions.w_8,
          right: Dimensions.w_8,
          bottom: Dimensions.h_20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${town ?? 'Local'} alerts'.toUpperCase(),
                style: TextStyle(color: const Color(0xFFFFE47A), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, letterSpacing: 0.6),
              ),
              SizedBox(height: Dimensions.h_8),
              Text.rich(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Alert Categories",
                      style: titleStyle.copyWith(color: AppColor.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_20),
              Text(
                'Browse ${town ?? 'local'} alerts by topic, follow active incidents, and find useful information for your home, travel, and community.',
                style: TextStyle(color: AppColor.white.withValues(alpha: 0.92), fontSize: FontSize.sp_12, fontWeight: FontWeight.w500, height: 1.35, shadows: shadow),
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
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [fade.withValues(alpha: 0.0), fade.withValues(alpha: 0.15), fade.withValues(alpha: 0.35), fade.withValues(alpha: 0.78), fade], stops: const [0.08, 0.25, 0.45, 0.75, 1.0]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget categoryChips(BuildContext context, AlertsController c) {
    // categories failed to load: the list still works on 'All alerts'
    if (c.alertCategories.isEmpty) return const SizedBox.shrink();
    final chips = c.categoryChips;
    return CategoryTabs(tabs: [for (final t in chips) (title: t.title, subtitle: '${t.count} active', icon: c.categoryIcon(t.slug), color: AppColor.blue(context))], selected: chips.indexWhere((t) => t.slug == c.alertsCategory), onTap: (i) => c.selectAlertsCategory(chips[i].slug));
  }

  Widget statusDropdown(BuildContext context, AlertsController c) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            c.alertsStatusLabel,
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          width: Dimensions.w_110,
          child: CommonDropdown<int>(items: [for (var i = 0; i < AlertsController.alertStatuses.length; i++) i], value: c.alertsStatusTab, height: Dimensions.h_28, fontSize: FontSize.sp_10, radius: Dimensions.h_6, itemLabel: (i) => c.alertStatusTabs[i], onChanged: c.selectAlertsStatus),
        ),
      ],
    );
  }

  Widget alertsGrid(BuildContext context, AlertsController c) {
    if (c.alertsLoading) {
      return SliverList.separated(
        itemCount: 4,
        separatorBuilder: (_, _) => SizedBox(height: Dimensions.h_10),
        itemBuilder: (_, _) => alertCardShimmer(),
      );
    }
    final alerts = c.categoryAlerts;
    if (c.alertsError != null || alerts.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.h_20),
          child: Center(
            child: c.alertsError != null ? CommonErrorView(message: c.alertsError, onRetry: c.getCategoryAlerts) : CommonEmptyView(icon: CupertinoIcons.checkmark_shield, title: c.emptyAlertsTitle, message: c.emptyAlertsMessage, actions: [if (c.alertsFilteredByCategory) (title: 'All alerts', icon: null, onTap: c.showAllCategories)]),
          ),
        ),
      );
    }
    return SliverList.separated(
      itemCount: alerts.length + (c.alertsLoadingMore ? 1 : 0),
      separatorBuilder: (_, _) => SizedBox(height: Dimensions.h_10),
      itemBuilder: (context, index) {
        if (index == alerts.length) return alertCardShimmer();
        c.onAlertShown(index);
        return index < 4 ? EntranceAnimation(index: index + 2, child: alertCard(context, c, alerts[index])) : alertCard(context, c, alerts[index]);
      },
    );
  }

  /// Placeholder in the shape of the page: hero text, chips, status row and cards.
  Widget alertsShimmer() => CommonShimmer(
    heroHeight: Dimensions.h_170,
    hero: [
      ShimmerBox(Dimensions.w_35, Dimensions.h_33, radius: Dimensions.h_10),
      const Spacer(),
      ShimmerBox(Dimensions.w_120, Dimensions.h_10),
      SizedBox(height: Dimensions.h_8),
      ShimmerBox(Dimensions.w_220, Dimensions.h_30, radius: Dimensions.h_8),
      SizedBox(height: Dimensions.h_15),
      ShimmerBox(double.infinity, Dimensions.h_11),
      SizedBox(height: Dimensions.h_6),
      ShimmerBox(Dimensions.w_200, Dimensions.h_11),
    ],
    body: [
      SizedBox(height: Dimensions.h_8),
      Row(
        children: [
          for (var i = 0; i < 3; i++)
            Padding(
              padding: EdgeInsets.only(right: Dimensions.w_10),
              child: ShimmerBox(Dimensions.w_100, Dimensions.h_30, radius: Dimensions.h_20),
            ),
        ],
      ),
      SizedBox(height: Dimensions.h_10),
      Row(
        children: [
          ShimmerBox(Dimensions.w_120, Dimensions.h_15),
          const Spacer(),
          ShimmerBox(Dimensions.w_110, Dimensions.h_28, radius: Dimensions.h_6),
        ],
      ),
      SizedBox(height: Dimensions.h_20),
      for (var i = 0; i < 4; i++)
        Padding(
          padding: EdgeInsets.only(bottom: Dimensions.h_10),
          child: alertCardShimmer(),
        ),
    ],
  );

  Widget alertCardShimmer() => ShimmerCard(
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBox(Dimensions.h_80, Dimensions.h_80, radius: Dimensions.h_8),
        SizedBox(width: Dimensions.w_8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ShimmerBox(Dimensions.w_60, Dimensions.h_15, radius: Dimensions.h_20),
                  SizedBox(width: Dimensions.w_6),
                  ShimmerBox(Dimensions.w_100, Dimensions.h_8),
                ],
              ),
              SizedBox(height: Dimensions.h_8),
              ShimmerBox(double.infinity, Dimensions.h_12),
              SizedBox(height: Dimensions.h_5),
              ShimmerBox(Dimensions.w_175, Dimensions.h_10),
              SizedBox(height: Dimensions.h_8),
              ShimmerBox(Dimensions.w_100, Dimensions.h_8),
            ],
          ),
        ),
      ],
    ),
    padding: EdgeInsets.all(Dimensions.h_8),
  );

  Widget alertCard(BuildContext context, AlertsController c, CategoryIncident a) {
    final ink = Theme.of(context).highlightColor;
    final muted = AppColor.muted(context);
    final t = c.alertTone(a.incidentStatus);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => c.openIncident(a.id),
      child: CommonCard(
        padding: EdgeInsets.all(Dimensions.h_8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              child: AppCacheImage(imageUrl: a.imageUrl ?? '', radius: 0, widthSize: Dimensions.h_80, size: Dimensions.h_80, fit: BoxFit.cover),
            ),
            SizedBox(width: Dimensions.w_8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      pill(context, AlertsController.titleCase(a.incidentStatus ?? ''), tone(context, t), toneSoft(context, t), fontSize: FontSize.sp_9),
                      SizedBox(width: Dimensions.w_6),
                      Expanded(
                        child: Text(
                          a.locationName ?? a.categoryTitle ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: mutedStyle(context, size: FontSize.sp_10),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_5),
                  Text(
                    a.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: ink, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1.2, letterSpacing: -0.2),
                  ),
                  SizedBox(height: Dimensions.h_3),
                  Text(
                    a.summary ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: mutedStyle(context, size: FontSize.sp_11),
                  ),
                  SizedBox(height: Dimensions.h_6),
                  Row(
                    children: [
                      Icon(CupertinoIcons.chat_bubble, size: Dimensions.h_12, color: ink),
                      SizedBox(width: Dimensions.w_4),
                      Text(
                        '${a.commentsCount ?? 0} discussion${a.commentsCount == 1 ? '' : 's'}',
                        style: TextStyle(color: ink, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Icon(CupertinoIcons.chevron_right, size: Dimensions.h_13, color: muted),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
