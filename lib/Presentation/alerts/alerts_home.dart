import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/alerts/alerts_controller.dart';
import 'package:wikixm/Presentation/alerts/alerts_drawer.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/common_error_view.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_shimmer.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_tabs.dart';
import 'package:wikixm/Presentation/widgets/marquee.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/entrance_animation.dart';
import '../../data/datasource/remote/models/response/alerts_home.dart' as home;

class AlertsHome extends StatelessWidget with AlertsUi {
  const AlertsHome({super.key});

  AlertsController get controller => Get.put(AlertsController());

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;
    return AlertsDrawer(
      builder: (openDrawer) => GetBuilder<AlertsController>(
        init: ctrl,
        id: ControllerBuilders.alertsHome,
        builder: (c) => c.sections == null && c.isLoading
            ? AppScaffold(top: false, bottom: false, bodyPadding: EdgeInsets.zero, backgroundColor: Theme.of(context).scaffoldBackgroundColor, body: pageShimmer())
            : CommonScrollBlurScaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                collapsedColor: Theme.of(context).highlightColor,
                showBack: true,
                isDrawer: true,
                onTap: openDrawer,
                expandedHeight: Dimensions.h_220,
                hero: buildHeroHeader(context, c),
                slivers: [
                  if (c.sections == null)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CommonErrorView(message: c.error, onRetry: c.getAlertsHome),
                      ),
                    )
                  else ...[
                    if (c.breaking.isNotEmpty)
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(Dimensions.w_10, Dimensions.h_10, Dimensions.w_10, MediaQuery.of(context).padding.bottom + Dimensions.h_20),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            entranceList([
                              for (final section in [buildSnapshot(context, c), buildIncident(context, c), buildSolutions(context, c), buildNews(context, c), buildJournal(context, c), buildMap(context, c), buildExplore(context, c), buildBusinesses(context, c)])
                                if (section != null)
                                  Padding(
                                    padding: EdgeInsets.only(bottom: Dimensions.h_20),
                                    child: section,
                                  ),
                            ]),
                          ),
                        ),
                      ),
                  ],
                ],
              ),
      ),
    );
  }

  Widget pageShimmer() {
    Widget header() => Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h_10),
      child: Row(children: [ShimmerBox(Dimensions.w_150, Dimensions.h_15), const Spacer(), ShimmerBox(Dimensions.w_60, Dimensions.h_10)]),
    );
    Widget row() => ShimmerCard(
      Row(
        children: [
          ShimmerBox(Dimensions.w_35, Dimensions.h_33, radius: Dimensions.h_10),
          SizedBox(width: Dimensions.w_10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(Dimensions.w_175, Dimensions.h_12),
                SizedBox(height: Dimensions.h_6),
                ShimmerBox(Dimensions.w_220, Dimensions.h_10),
              ],
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: Dimensions.h_8),
    );
    return CommonShimmer(
      heroHeight: Dimensions.h_220,
      hero: [
        ShimmerBox(Dimensions.w_35, Dimensions.h_33, radius: Dimensions.h_10),
        const Spacer(),
        ShimmerBox(Dimensions.w_200, Dimensions.h_30, radius: Dimensions.h_8),
        SizedBox(height: Dimensions.h_10),
        ShimmerBox(Dimensions.w_220, Dimensions.h_11),
        SizedBox(height: Dimensions.h_6),
        ShimmerBox(Dimensions.w_175, Dimensions.h_11),
        const Spacer(),
        Row(
          children: [
            ShimmerBox(Dimensions.w_97, Dimensions.h_28, radius: Dimensions.h_6),
            SizedBox(width: Dimensions.w_10),
            ShimmerBox(Dimensions.w_97, Dimensions.h_28, radius: Dimensions.h_6),
          ],
        ),
      ],
      body: [
        ShimmerBox(double.infinity, Dimensions.h_30, radius: Dimensions.h_8),
        SizedBox(height: Dimensions.h_20),
        header(),
        ShimmerBox(double.infinity, Dimensions.h_70, radius: Dimensions.h_10),
        SizedBox(height: Dimensions.h_20),
        header(),
        ShimmerCard(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerBox(double.infinity, Dimensions.h_160, radius: Dimensions.h_10),
              SizedBox(height: Dimensions.h_10),
              ShimmerBox(Dimensions.w_220, Dimensions.h_15),
              SizedBox(height: Dimensions.h_8),
              ShimmerBox(double.infinity, Dimensions.h_11),
              SizedBox(height: Dimensions.h_6),
              ShimmerBox(Dimensions.w_175, Dimensions.h_11),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_20),
        header(),
        for (var i = 0; i < 3; i++) row(),
      ],
    );
  }

  Widget buildHeroHeader(BuildContext context, AlertsController c) {
    final fade = Theme.of(context).brightness == Brightness.light ? AppColor.softBackground : AppColor.backgroundDark;
    final hero = c.sections?.hero;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCacheImage(alignment: Alignment(0.5, 0), size: Dimensions.h_330, widthSize: Get.width, imageUrl: c.headerImage),
        Positioned.fill(
          child: Container(
            height: Dimensions.h_330,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [AppColor.profileHeroDark.withValues(alpha: 0.85), AppColor.profileHeroDark.withValues(alpha: 0.65), AppColor.profileHeroDark.withValues(alpha: 0.35), AppColor.transparent], stops: const [0.0, 0.30, 0.58, 1.0]),
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
                padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_80),
                child: Text(
                  hero?.title ?? 'Alerts',
                  style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_30, fontWeight: FontWeight.w900, shadows: heroShadow, height: 1.2),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_10, right: Dimensions.w_60),
                child: Text(
                  hero?.description ?? '',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w500, shadows: heroShadow),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              const Spacer(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: c.reportAlert,
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_6),
                        decoration: BoxDecoration(color: AppColor.civicBlue, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: Dimensions.w_8),
                            Text(
                              "Report Alert",
                              style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, height: 1.2),
                            ),
                            SizedBox(width: Dimensions.w_8),
                            Padding(
                              padding: EdgeInsets.only(top: Dimensions.h_1),
                              child: Icon(Icons.add, size: Dimensions.h_15, color: AppColor.white),
                            ),
                            SizedBox(width: Dimensions.w_5),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: c.openMyAlerts,
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
                        decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: Dimensions.w_8),
                            Text(
                              "Ask alerts AI",
                              style: TextStyle(color: AppColor.textPrimary, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, height: 1.2),
                            ),
                            SizedBox(width: Dimensions.w_5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_15),
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

  static final heroShadow = [Shadow(color: AppColor.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))];

  Widget buildBreaking(BuildContext context, AlertsController c) => tickerStrip(context, 'BREAKING', c.breaking, 'red');

  Widget emptyText(BuildContext context, String? text) => Padding(
    padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
    child: Text(text ?? '', style: mutedStyle(context)),
  );

  Widget? buildSnapshot(BuildContext context, AlertsController c) {
    final s = c.sections?.snapshot;
    final metrics = c.snapshotMetrics;
    if (metrics.isEmpty) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, s?.title ?? '', action: s?.action?.label),
        Container(
          decoration: cardDecoration(context),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  for (final m in metrics)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
                        decoration: m == metrics.last
                            ? null
                            : BoxDecoration(
                                border: Border(right: BorderSide(color: AppColor.border(context))),
                              ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(AlertsController.icon(m.icon), color: tone(context, m.tone), size: Dimensions.h_15),
                                SizedBox(width: Dimensions.w_6),
                                Text(
                                  '${m.value ?? 0}',
                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_20, fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            Text(
                              m.label ?? '',
                              textAlign: TextAlign.center,
                              style: mutedStyle(context, size: FontSize.sp_10).copyWith(color: Theme.of(context).highlightColor, height: 1.3),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget? buildIncident(BuildContext context, AlertsController c) {
    final i = c.sections?.featuredIncident;
    if (i == null) return null;
    final timeline = i.timeline ?? <home.Timeline>[];
    final stats = i.stats ?? <home.Stat>[];
    final actions = (i.actions ?? <home.DetailActionElement>[]).skip(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, 'incident hub'.trim(), trailing: i.updatedLabel),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => c.openIncident(i.incidentId ?? i.id),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: cardDecoration(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AppCacheImage(imageUrl: i.imageUrl ?? '', widthSize: Get.width, size: Dimensions.h_160, fit: BoxFit.cover, isShadow: false, radius: 0),
                    Positioned(
                      left: Dimensions.w_10,
                      top: Dimensions.h_10,
                      right: Dimensions.w_10,
                      child: Wrap(
                        spacing: Dimensions.w_5,
                        runSpacing: Dimensions.h_4,
                        children: [
                          if (i.badge != null) pill(context, i.badge!, AppColor.white, tone(context, i.tone)),
                          if (i.statusLabel != null) pill(context, i.statusLabel!.toUpperCase(), Theme.of(context).highlightColor, AppColor.surface(context), fontWeight: FontWeight.w600, fontSize: FontSize.sp_9),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.h_6, horizontal: Dimensions.w_12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(i.title ?? '', style: titleStyle(context, FontSize.sp_18, weight: FontWeight.w800).copyWith(letterSpacing: -0.3, height: 1.2)),
                      SizedBox(height: Dimensions.h_4),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_5),
                        child: Text(
                          i.description ?? '',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: mutedStyle(context, size: FontSize.sp_12),
                        ),
                      ),
                      SizedBox(height: Dimensions.h_5),
                      Divider(height: Dimensions.h_20, color: AppColor.border(context)),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            for (final (n, s) in stats.indexed) ...[
                              if (n > 0) VerticalDivider(width: Dimensions.w_20, color: AppColor.border(context)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(s.label ?? '', style: mutedStyle(context, size: FontSize.sp_10)),
                                    SizedBox(height: Dimensions.h_2),
                                    Text(
                                      s.value ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: titleStyle(context, FontSize.sp_13, weight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Divider(height: Dimensions.h_20, color: AppColor.border(context)),
                      SizedBox(height: Dimensions.h_5),
                      if (c.incidentTabs.isNotEmpty) ...[PillTabs(tabs: c.incidentTabs, selected: c.incidentTab, onTap: c.selectIncidentTab), SizedBox(height: Dimensions.h_12)],
                      for (final (n, t) in timeline.indexed)
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: Dimensions.h_3),
                                    child: CircleAvatar(radius: Dimensions.h_4, backgroundColor: AppColor.green(context)),
                                  ),
                                  if (n < timeline.length - 1)
                                    Expanded(
                                      child: VerticalDivider(width: Dimensions.w_8, color: AppColor.border(context)),
                                    ),
                                ],
                              ),
                              SizedBox(width: Dimensions.w_10),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: Dimensions.h_12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(AlertsController.clock(t.occurredAt ?? t.createdAt), style: titleStyle(context, FontSize.sp_12)),
                                          SizedBox(width: Dimensions.w_6),
                                          if (t.type != null) pill(context, t.type!.capitalizeFirst!, AppColor.green(context), AppColor.greenSoft(context)),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.h_2),
                                      Text(t.title ?? '', style: titleStyle(context, FontSize.sp_12, weight: FontWeight.w500).copyWith(height: 1.35)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Center(child: Text(i.detailAction?.label ?? 'Open full incident page', style: linkStyle(context))),
                      SizedBox(height: Dimensions.h_12),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: c.toggleFollow,
                              child: Container(
                                height: Dimensions.h_35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: c.following ? AppColor.blueSoft(context) : AppColor.blue(context), borderRadius: BorderRadius.circular(Dimensions.h_8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(c.following ? CupertinoIcons.bell_fill : CupertinoIcons.bell, color: c.following ? AppColor.blue(context) : AppColor.white, size: Dimensions.h_15),
                                    SizedBox(width: Dimensions.w_6),
                                    Text(
                                      c.following ? 'Following' : 'Follow incident',
                                      style: TextStyle(color: c.following ? AppColor.blue(context) : AppColor.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          for (final a in actions)
                            Container(
                              margin: EdgeInsets.only(left: Dimensions.w_8),
                              width: Dimensions.h_35,
                              height: Dimensions.h_35,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.border(context)),
                                borderRadius: BorderRadius.circular(Dimensions.h_8),
                              ),
                              child: Icon(AlertsController.icon(a.icon), color: Theme.of(context).highlightColor, size: Dimensions.h_16),
                            ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_10),
                      if (i.note != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(CupertinoIcons.info, color: AppColor.muted(context), size: Dimensions.h_13),
                            SizedBox(width: Dimensions.w_5),
                            Expanded(
                              child: Text(i.note!, style: mutedStyle(context, size: FontSize.sp_10)),
                            ),
                          ],
                        ),
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

  Widget listRow(BuildContext context, IconData icon, String? t, String title, String body) => Container(
    margin: EdgeInsets.only(bottom: Dimensions.h_8),
    padding: EdgeInsets.all(Dimensions.h_10),
    decoration: cardDecoration(context),
    child: Row(
      children: [
        iconBox(context, icon, t),
        SizedBox(width: Dimensions.w_10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: titleStyle(context, FontSize.sp_13)),
              Text(body, style: mutedStyle(context)),
            ],
          ),
        ),
        Icon(CupertinoIcons.chevron_right, color: AppColor.muted(context), size: Dimensions.h_13),
      ],
    ),
  );

  Widget? buildSolutions(BuildContext context, AlertsController c) {
    final s = c.sections?.communitySolutions;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, s?.title ?? 'Community solutions', action: s?.action?.label ?? 'Add yours'),
        for (final i in c.solutions) listRow(context, i['icon'], i['tone'], i['title'], i['body']),
        Center(child: Text(s?.moreAction?.label ?? 'See all community solutions', style: linkStyle(context))),
      ],
    );
  }

  Widget? buildJournal(BuildContext context, AlertsController c) {
    final j = c.sections?.journal;
    if (j == null) return null;
    final items = c.journal;
    final total = j.items?.length ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, j.title ?? '', action: j.action?.label),
        if (total == 0)
          emptyText(context, j.emptyDescription ?? j.emptyTitle)
        else ...[
          PillTabs(tabs: c.journalTabs, selected: c.journalTab, onTap: c.selectJournalTab),
          SizedBox(height: Dimensions.h_10),
          for (final f in items)
            Container(
              margin: EdgeInsets.only(bottom: Dimensions.h_8),
              padding: EdgeInsets.all(Dimensions.h_10),
              decoration: cardDecoration(context),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  iconBox(context, AlertsController.icon(f.icon), f.tone),
                  SizedBox(width: Dimensions.w_10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(f.title ?? '', style: titleStyle(context, FontSize.sp_13)),
                        Text([f.badge, f.updatedLabel].whereType<String>().join('. '), style: mutedStyle(context)),
                        SizedBox(height: Dimensions.h_4),
                        Row(
                          children: [
                            Icon(CupertinoIcons.chat_bubble, color: AppColor.muted(context), size: Dimensions.h_11),
                            SizedBox(width: Dimensions.w_3),
                            Text('${f.replies ?? 0} replies', style: mutedStyle(context)),
                            SizedBox(width: Dimensions.w_12),
                            Icon(CupertinoIcons.lightbulb, color: AppColor.muted(context), size: Dimensions.h_11),
                            SizedBox(width: Dimensions.w_3),
                            Text('${f.solutions ?? 0} solutions', style: mutedStyle(context)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(CupertinoIcons.chevron_right, color: AppColor.muted(context), size: Dimensions.h_13),
                ],
              ),
            ),
          Center(child: Text('Showing ${items.length} of $total alerts', style: mutedStyle(context))),
        ],
      ],
    );
  }

  Widget? buildMap(BuildContext context, AlertsController c) {
    final m = c.sections?.impactMap;
    if (m == null) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, m.title ?? '', action: 'Open map'),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: cardDecoration(context),
          child: Column(
            children: [
              Container(
                height: Dimensions.h_160,
                color: AppColor.mapBlueSoft(context),
                child: Stack(
                  children: [
                    if (c.mapCenter != null)
                      FlutterMap(
                        options: MapOptions(
                          initialCenter: c.mapCenter!,
                          initialZoom: 12,
                          backgroundColor: AppColor.mapBlueSoft(context),
                          // no one-finger drag: it would fight the page scroll
                          interactionOptions: const InteractionOptions(flags: InteractiveFlag.pinchZoom | InteractiveFlag.pinchMove | InteractiveFlag.doubleTapZoom),
                        ),
                        children: [
                          TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.wikixm.app'),
                          MarkerLayer(
                            markers: [
                              for (final p in c.mapPins)
                                Marker(
                                  point: p['point'],
                                  width: Dimensions.h_25,
                                  height: Dimensions.h_25,
                                  child: Icon(p['icon'], color: tone(context, p['tone']), size: Dimensions.h_20),
                                ),
                            ],
                          ),
                        ],
                      ),
                    if ((m.pins ?? []).isEmpty && m.emptyLabel != null)
                      Positioned(
                        left: Dimensions.w_8,
                        right: Dimensions.w_8,
                        bottom: Dimensions.h_8,
                        child: pill(context, m.emptyLabel!, Theme.of(context).highlightColor, AppColor.surface(context), fontWeight: FontWeight.w600),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.h_8),
                child: Row(
                  children: [
                    for (final l in m.layers ?? <home.Layer>[])
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => c.toggleMapFilter(l.id ?? ''),
                        child: Padding(
                          padding: EdgeInsets.only(right: Dimensions.w_12, top: Dimensions.h_6, bottom: Dimensions.h_6),
                          child: Row(
                            children: [
                              Icon(c.activeMapFilters.contains(l.id) ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.square, color: AppColor.blue(context), size: Dimensions.h_15),
                              SizedBox(width: Dimensions.w_4),
                              Text(l.label ?? '', style: titleStyle(context, FontSize.sp_12)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (m.note != null) ...[SizedBox(height: Dimensions.h_4), Text(m.note!, style: mutedStyle(context, size: FontSize.sp_10))],
      ],
    );
  }

  Widget? buildNews(BuildContext context, AlertsController c) {
    final n = c.sections?.news;
    if (n == null) return null;
    final h = n.feature;
    final items = n.items ?? <home.Feature>[];
    final photos = c.sections?.gallery?.items ?? <home.GalleryItem>[];
    String meta(home.Feature f) => [f.updatedLabel, '${f.photos ?? 0} photos', '${f.replies ?? 0} replies'].whereType<String>().join(', ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, n.title ?? ''),
        if (n.description != null) ...[Text(n.description!, style: mutedStyle(context)), SizedBox(height: Dimensions.h_10)],
        if (h == null && items.isEmpty) emptyText(context, n.emptyLabel),
        if (h != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.h_12),
            child: Stack(
              children: [
                AppCacheImage(imageUrl: h.imageUrl ?? '', widthSize: Get.width, size: Dimensions.h_200, fit: BoxFit.cover, isShadow: false, radius: 0),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColor.transparent, AppColor.wikiXMNavy.withValues(alpha: 0.9)]),
                    ),
                  ),
                ),
                Positioned(
                  left: Dimensions.w_12,
                  right: Dimensions.w_12,
                  bottom: Dimensions.h_12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (h.badge != null) pill(context, h.badge!, AppColor.white, AppColor.blue(context)),
                      SizedBox(height: Dimensions.h_4),
                      Text(
                        h.title ?? '',
                        style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_17, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        meta(h),
                        style: TextStyle(color: AppColor.white.withValues(alpha: 0.8), fontSize: FontSize.sp_10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h_10),
        ],
        for (final f in items)
          Padding(
            padding: EdgeInsets.only(bottom: Dimensions.h_10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCacheImage(imageUrl: f.imageUrl ?? '', widthSize: Dimensions.w_80, size: Dimensions.h_60, fit: BoxFit.cover, isShadow: false, radius: Dimensions.h_8),
                SizedBox(width: Dimensions.w_10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (f.badge ?? '').toUpperCase(),
                        style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_9).copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: Dimensions.h_2),
                      Text(f.title ?? '', style: titleStyle(context, FontSize.sp_13_5)),
                      SizedBox(height: Dimensions.h_2),
                      Text(meta(f), style: mutedStyle(context, size: FontSize.sp_10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (photos.isNotEmpty)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: c.openCommunityPhotos,
            child: Row(
              children: [
                for (final p in photos.take(3))
                  Padding(
                    padding: EdgeInsets.only(right: Dimensions.w_6),
                    child: AppCacheImage(imageUrl: p.imageUrl ?? '', widthSize: Dimensions.w_70, size: Dimensions.h_50, fit: BoxFit.cover, isShadow: false, radius: Dimensions.h_8),
                  ),
                Expanded(
                  child: Text('${photos.length} community photo${photos.length == 1 ? '' : 's'}', textAlign: TextAlign.center, style: linkStyle(context)),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget? buildExplore(BuildContext context, AlertsController c) {
    final cat = c.sections?.categories;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, cat?.title ?? 'Explore alerts'),
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: Dimensions.h_8,
          crossAxisSpacing: Dimensions.w_8,
          children: [
            for (final e in cat?.items ?? <home.CategoriesItem>[])
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => c.openCategory(e.slug),
                child: Container(
                  decoration: cardDecoration(context),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(AlertsController.icon(e.icon), color: Theme.of(context).highlightColor, size: Dimensions.h_20),
                              SizedBox(height: Dimensions.h_3),
                              Text(
                                e.label ?? '',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: titleStyle(context, FontSize.sp_10, weight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (c.categoryCount(e.slug) > 0)
                        Positioned(
                          right: -Dimensions.w_3,
                          top: -Dimensions.h_3,
                          child: CircleAvatar(
                            radius: Dimensions.h_7,
                            backgroundColor: AppColor.red(context),
                            child: Text(
                              '${c.categoryCount(e.slug)}',
                              style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_9, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        for (final l in c.exploreLinks)
          Container(
            margin: EdgeInsets.only(bottom: Dimensions.h_8),
            padding: EdgeInsets.all(Dimensions.h_10),
            decoration: cardDecoration(context),
            child: Row(
              children: [
                iconBox(context, l['icon'], null),
                SizedBox(width: Dimensions.w_10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l['title'], style: titleStyle(context, FontSize.sp_13)),
                      Text(l['body'], style: mutedStyle(context)),
                      Text(l['link'], style: linkStyle(context).copyWith(fontSize: FontSize.sp_10)),
                    ],
                  ),
                ),
                Icon(CupertinoIcons.chevron_right, color: AppColor.muted(context), size: Dimensions.h_13),
              ],
            ),
          ),
      ],
    );
  }

  Widget buildBusinesses(BuildContext context, AlertsController c) {
    return Column(
      children: [
        sectionHeader(context, 'Local businesses', trailing: 'Sponsored'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: [
              for (final b in c.businesses)
                Container(
                  width: Dimensions.w_260,
                  margin: EdgeInsets.only(right: Dimensions.w_10),
                  padding: EdgeInsets.all(Dimensions.h_8),
                  decoration: cardDecoration(context),
                  child: Row(
                    children: [
                      AppCacheImage(imageUrl: b['image']!, widthSize: Dimensions.w_70, size: Dimensions.h_55, fit: BoxFit.cover, isShadow: false, radius: Dimensions.h_8),
                      SizedBox(width: Dimensions.w_10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(b['title']!, style: titleStyle(context, FontSize.sp_13)),
                            Text(b['body']!, style: mutedStyle(context)),
                            Text(b['link']!, style: linkStyle(context).copyWith(fontSize: FontSize.sp_10)),
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
}

/// Shared look for the alerts pages.
mixin AlertsUi {
  Color tone(BuildContext context, String? t) => switch (t) {
    'red' || 'power' || 'risk' || 'safety' => AppColor.red(context),
    'orange' || 'warning' || 'earthquake' || 'travel' || 'pass' => AppColor.orange(context),
    'blue' || 'internet' || 'weather' || 'flood' || 'calm' => AppColor.blue(context),
    'violet' || 'community' => AppColor.violet(context),
    _ => AppColor.green(context),
  };

  Color toneSoft(BuildContext context, String? t) => switch (t) {
    'red' || 'power' || 'risk' || 'safety' => AppColor.redSoft(context),
    'orange' || 'warning' || 'earthquake' || 'travel' || 'pass' => AppColor.orangeSoft(context),
    'blue' || 'internet' || 'weather' || 'flood' || 'calm' => AppColor.blueSoft(context),
    'violet' || 'community' => AppColor.violetSoft(context),
    _ => AppColor.greenSoft(context),
  };

  TextStyle titleStyle(BuildContext context, double size, {FontWeight weight = FontWeight.w700, double? height}) => TextStyle(color: Theme.of(context).highlightColor, fontSize: size, fontWeight: weight, height: height);

  TextStyle mutedStyle(BuildContext context, {double? size}) => TextStyle(color: AppColor.muted(context), fontSize: size ?? FontSize.sp_11, height: 1.35);

  TextStyle linkStyle(BuildContext context) => TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_11, fontWeight: FontWeight.w700);

  BoxDecoration cardDecoration(BuildContext context, {Color? color}) => BoxDecoration(
    color: color ?? AppColor.surface(context),
    borderRadius: BorderRadius.circular(Dimensions.h_10),
    border: Border.all(color: AppColor.border(context), width: 0.5),
  );

  Widget sectionHeader(BuildContext context, String title, {String? action, String? trailing}) => Padding(
    padding: EdgeInsets.only(bottom: Dimensions.h_13),
    child: Row(
      children: [
        Expanded(
          child: Text(AlertsController.titleCase(title), style: titleStyle(context, FontSize.sp_16, weight: FontWeight.w800).copyWith(letterSpacing: -0.3)),
        ),
        if (action != null) Text(action, style: linkStyle(context)),
        if (trailing != null) Text(trailing, style: mutedStyle(context, size: FontSize.sp_10)),
      ],
    ),
  );

  Widget pill(BuildContext context, String text, Color color, Color bg, {IconData? icon, FontWeight? fontWeight, double? fontSize}) => Container(
    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_3),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(Dimensions.h_4)),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon, color: color, size: Dimensions.h_11), SizedBox(width: Dimensions.w_3)],
        Text(
          text,
          style: TextStyle(color: color, fontSize: fontSize ?? FontSize.sp_10, fontWeight: fontWeight ?? FontWeight.w700, height: 1.2, leadingDistribution: TextLeadingDistribution.even),
        ),
      ],
    ),
  );

  Widget iconBox(BuildContext context, IconData icon, String? t, {double? size}) => Container(
    width: size ?? Dimensions.h_35,
    height: size ?? Dimensions.h_35,
    decoration: BoxDecoration(color: t == null ? AppColor.closeBackground(context) : toneSoft(context, t), borderRadius: BorderRadius.circular(Dimensions.h_8)),
    child: Icon(icon, color: t == null ? Theme.of(context).highlightColor : tone(context, t), size: Dimensions.h_16),
  );

  /// Coloured strip with a [label] pill and a [Marquee] of items (each needs icon, tone, title, body and time).
  Widget tickerStrip(BuildContext context, String label, List<Map<String, dynamic>> items, String t) {
    return Container(
      height: Dimensions.h_32,
      padding: EdgeInsets.only(left: Dimensions.w_5),
      color: toneSoft(context, t),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3, vertical: Dimensions.h_3),
            decoration: BoxDecoration(color: tone(context, t), borderRadius: BorderRadius.circular(99)),
            child: Row(
              children: [
                CircleAvatar(radius: Dimensions.h_2, backgroundColor: AppColor.white),
                SizedBox(width: Dimensions.w_5),
                Text(
                  label,
                  style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_9, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          SizedBox(width: Dimensions.w_8),
          Expanded(
            child: Marquee(
              items: [
                for (final b in items)
                  Row(
                    children: [
                      Icon(b['icon'], color: tone(context, b['tone']), size: Dimensions.h_13),
                      SizedBox(width: Dimensions.w_5),
                      Text(
                        '${b['title']}: ${b['body']} (${b['time']})',
                        style: TextStyle(color: tone(context, t), fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
