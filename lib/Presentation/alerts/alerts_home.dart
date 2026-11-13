import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/alerts/alerts_controller.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/Presentation/widgets/marquee.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/entrance_animation.dart';

class AlertsHome extends StatelessWidget with AlertsUi {
  const AlertsHome({super.key});

  AlertsController get controller => Get.put(AlertsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlertsController>(
      init: controller,
      id: ControllerBuilders.alertsHome,
      builder: (c) => CommonScrollBlurScaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        collapsedColor: Theme.of(context).highlightColor,
        showBack: true,
        expandedHeight: Dimensions.h_220,
        hero: buildHeroHeader(context, c),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: Dimensions.h_10),
              child: buildBreaking(context, c),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(Dimensions.w_10, Dimensions.h_1, Dimensions.w_10, MediaQuery.of(context).padding.bottom + Dimensions.h_20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                entranceList([
                  for (final section in [
                    // buildAffecting(context, c),
                    buildSnapshot(context, c),
                    buildIncident(context, c),
                    buildHelps(context, c),
                    buildSolutions(context, c),
                    buildNews(context, c),
                    buildRoutes(context, c),
                    buildJournal(context, c),
                    buildMap(context, c),
                    buildExplore(context, c),
                    buildBusinesses(context, c),
                  ])
                    Padding(
                      padding: EdgeInsets.only(bottom: Dimensions.h_20),
                      child: section,
                    ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeroHeader(BuildContext context, AlertsController c) {
    final fade = Theme.of(context).brightness == Brightness.light ? AppColor.softBackground : AppColor.backgroundDark;
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
                  c.greeting,
                  style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_30, fontWeight: FontWeight.w900, shadows: heroShadow, height: 1.2),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_10, right: Dimensions.w_60),
                child: Text.rich(
                  TextSpan(
                    text: c.intro,
                    style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w500, shadows: heroShadow),
                    children: [
                      TextSpan(
                        text: c.introSource,
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
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

  Widget heroStatItem({required IconData icon, required String value, required String label}) {
    return Row(
      children: [
        Icon(icon, size: Dimensions.h_15, color: AppColor.white),
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
              style: TextStyle(fontSize: FontSize.sp_10, color: AppColor.white, shadows: heroShadow),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildAffecting(BuildContext context, AlertsController c) {
    return Container(
      padding: EdgeInsets.all(Dimensions.h_12),
      decoration: cardDecoration(context),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text('${c.affecting.length} things affecting you', style: titleStyle(context, FontSize.sp_14, weight: FontWeight.w800)),
              ),
              pill(context, '✦ AI brief', AppColor.blue(context), AppColor.blueSoft(context)),
            ],
          ),
          for (final a in c.affecting) ...[
            Divider(height: Dimensions.h_20, color: AppColor.border(context)),
            Row(
              children: [
                iconBox(context, a['icon'], a['tone']),
                SizedBox(width: Dimensions.w_10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(a['title'], style: titleStyle(context, FontSize.sp_12)),
                          SizedBox(width: Dimensions.w_6),
                          pill(context, a['tag'], tone(context, a['tone']), toneSoft(context, a['tone'])),
                        ],
                      ),
                      Text(a['body'], style: mutedStyle(context)),
                    ],
                  ),
                ),
                Icon(CupertinoIcons.chevron_right, color: AppColor.muted(context), size: Dimensions.h_13),
              ],
            ),
          ],
          Divider(height: Dimensions.h_20, color: AppColor.border(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Read full brief', style: linkStyle(context)),
              Text('✦ Ask about alerts', style: linkStyle(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBreaking(BuildContext context, AlertsController c) => tickerStrip(context, 'BREAKING', c.breaking, 'red');

  Widget buildSnapshot(BuildContext context, AlertsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, 'Fall city alert snapshot', action: 'View details'),
        Container(
          decoration: cardDecoration(context),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  for (final s in c.snapshot)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
                        decoration: s == c.snapshot.last
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
                                Icon(s['icon'], color: tone(context, s['tone']), size: Dimensions.h_15),
                                SizedBox(width: Dimensions.w_6),
                                Text(
                                  s['value'],
                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_20, fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            Text(
                              s['label'],
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

  Widget buildIncident(BuildContext context, AlertsController c) {
    final i = c.incident;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, 'Incident hub', trailing: i['updated']),
        // inner taps (tabs, follow) win the gesture arena, the rest of the card opens the detail
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: c.openIncident,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: cardDecoration(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AppCacheImage(imageUrl: i['image'], widthSize: Get.width, size: Dimensions.h_160, fit: BoxFit.cover, isShadow: false, radius: 0),
                    Positioned(
                      left: Dimensions.w_10,
                      top: Dimensions.h_10,
                      child: Row(
                        children: [
                          pill(context, i['tags'][0], AppColor.white, AppColor.red(context)),
                          SizedBox(width: Dimensions.w_5),
                          pill(context, i['tags'][1].toString().toUpperCase(), Theme.of(context).highlightColor, AppColor.surface(context), fontWeight: FontWeight.w600, fontSize: FontSize.sp_9),
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
                      Text(i['title'], style: titleStyle(context, FontSize.sp_18, weight: FontWeight.w800).copyWith(letterSpacing: -0.3, height: 1.2)),
                      SizedBox(height: Dimensions.h_4),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_5),
                        child: Text(i['body'], style: mutedStyle(context, size: FontSize.sp_12)),
                      ),
                      SizedBox(height: Dimensions.h_5),
                      Divider(height: Dimensions.h_20, color: AppColor.border(context)),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            for (final (n, s) in (i['stats'] as List).indexed) ...[
                              if (n > 0) VerticalDivider(width: Dimensions.w_20, color: AppColor.border(context)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(s['label'], style: mutedStyle(context, size: FontSize.sp_10)),
                                    SizedBox(height: Dimensions.h_2),
                                    Text(s['value'], style: titleStyle(context, FontSize.sp_15, weight: FontWeight.w800)),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Divider(height: Dimensions.h_20, color: AppColor.border(context)),
                      SizedBox(height: Dimensions.h_5),
                      tabs(context, c.incidentTabs, c.incidentTab, c.selectIncidentTab),
                      SizedBox(height: Dimensions.h_12),
                      for (final (n, t) in c.timeline.indexed)
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
                                  if (n < c.timeline.length - 1)
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
                                          Text(t['time']!, style: titleStyle(context, FontSize.sp_12)),
                                          SizedBox(width: Dimensions.w_6),
                                          t['source'] == 'Official' ? pill(context, 'Official', AppColor.green(context), AppColor.greenSoft(context)) : pill(context, 'Neighbor', AppColor.blue(context), AppColor.blueSoft(context)),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.h_2),
                                      Text(t['body']!, style: titleStyle(context, FontSize.sp_12, weight: FontWeight.w500).copyWith(height: 1.35)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Center(child: Text('Open full incident page', style: linkStyle(context))),
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
                          for (final icon in [CupertinoIcons.chat_bubble_text, CupertinoIcons.camera, CupertinoIcons.pencil])
                            Container(
                              margin: EdgeInsets.only(left: Dimensions.w_8),
                              width: Dimensions.h_35,
                              height: Dimensions.h_35,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.border(context)),
                                borderRadius: BorderRadius.circular(Dimensions.h_8),
                              ),
                              child: Icon(icon, color: Theme.of(context).highlightColor, size: Dimensions.h_16),
                            ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(CupertinoIcons.info, color: AppColor.muted(context), size: Dimensions.h_13),
                          SizedBox(width: Dimensions.w_5),
                          Expanded(
                            child: Text(i['note'], style: mutedStyle(context, size: FontSize.sp_10)),
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

  Widget buildHelps(BuildContext context, AlertsController c) {
    return Column(
      children: [
        sectionHeader(context, 'Solutions for this incident', action: 'Add a tip'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: [
              for (final h in c.helps)
                Container(
                  width: Dimensions.w_200,
                  margin: EdgeInsets.only(right: Dimensions.w_10),
                  padding: EdgeInsets.only(top: Dimensions.h_6, bottom: Dimensions.h_10, left: Dimensions.w_8),
                  decoration: cardDecoration(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pill(context, 'Verified', AppColor.green(context), AppColor.greenSoft(context)),
                      SizedBox(height: Dimensions.h_6),
                      Text(h['title']!, style: titleStyle(context, FontSize.sp_13)),
                      Text(h['body']!, style: mutedStyle(context, size: FontSize.sp_10), maxLines: 2),
                    ],
                  ),
                ),
            ],
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

  Widget buildSolutions(BuildContext context, AlertsController c) {
    return Column(
      children: [
        sectionHeader(context, 'Community solutions', action: 'Add yours'),
        for (final s in c.solutions) listRow(context, s['icon'], s['tone'], s['title'], s['body']),
        Center(child: Text('See all community solutions', style: linkStyle(context))),
      ],
    );
  }

  Widget buildRoutes(BuildContext context, AlertsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, 'My followed routes', action: 'Manage routes'),
        Container(
          padding: EdgeInsets.all(Dimensions.h_10),
          decoration: cardDecoration(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Routes you follow', style: mutedStyle(context)),
              SizedBox(height: Dimensions.h_6),
              Wrap(
                spacing: Dimensions.w_6,
                runSpacing: Dimensions.h_6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  for (final r in c.followedRoutes) pill(context, r, AppColor.blue(context), AppColor.blueSoft(context), icon: CupertinoIcons.checkmark),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.add, color: AppColor.blue(context), size: Dimensions.h_13),
                      SizedBox(width: Dimensions.w_3),
                      Text('Add route', style: linkStyle(context)),
                    ],
                  ),
                ],
              ),
              Divider(height: Dimensions.h_20, color: AppColor.border(context)),
              Row(
                children: [
                  Icon(CupertinoIcons.bell, color: Theme.of(context).highlightColor, size: Dimensions.h_13),
                  SizedBox(width: Dimensions.w_6),
                  Text('Notify me about', style: titleStyle(context, FontSize.sp_11)),
                  const Spacer(),
                  Text(c.notifyLevel, style: linkStyle(context).copyWith(fontSize: FontSize.sp_10)),
                  Icon(CupertinoIcons.chevron_down, color: AppColor.blue(context), size: Dimensions.h_10),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        for (final r in c.routes)
          Container(
            margin: EdgeInsets.only(bottom: Dimensions.h_8),
            padding: EdgeInsets.all(Dimensions.h_8),
            decoration: cardDecoration(context),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCacheImage(imageUrl: r['image']!, widthSize: Dimensions.w_90, size: Dimensions.h_70, fit: BoxFit.cover, isShadow: false, radius: Dimensions.h_8),
                SizedBox(width: Dimensions.w_10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(r['title']!, style: titleStyle(context, FontSize.sp_13))),
                          pill(context, r['tag']!, tone(context, r['tone']), toneSoft(context, r['tone'])),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_2),
                      Text(r['body']!, style: mutedStyle(context)),
                      SizedBox(height: Dimensions.h_2),
                      Text(r['source']!, style: mutedStyle(context, size: FontSize.sp_10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget buildJournal(BuildContext context, AlertsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, 'Fall City Alert journal', action: 'View all alerts'),
        tabs(context, c.journalTabs, c.journalTab, c.selectJournalTab),
        SizedBox(height: Dimensions.h_10),
        for (final j in c.journal)
          Container(
            margin: EdgeInsets.only(bottom: Dimensions.h_8),
            padding: EdgeInsets.all(Dimensions.h_10),
            decoration: cardDecoration(context),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                iconBox(context, j['icon'], j['tone']),
                SizedBox(width: Dimensions.w_10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(j['title'], style: titleStyle(context, FontSize.sp_13)),
                      Text(j['meta'], style: mutedStyle(context)),
                      SizedBox(height: Dimensions.h_4),
                      Row(
                        children: [
                          Icon(CupertinoIcons.chat_bubble, color: AppColor.muted(context), size: Dimensions.h_11),
                          SizedBox(width: Dimensions.w_3),
                          Text('${j['replies']} replies', style: mutedStyle(context)),
                          SizedBox(width: Dimensions.w_12),
                          Icon(CupertinoIcons.lightbulb, color: AppColor.muted(context), size: Dimensions.h_11),
                          SizedBox(width: Dimensions.w_3),
                          Text('${j['solutions']} solutions', style: mutedStyle(context)),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(CupertinoIcons.chevron_right, color: AppColor.muted(context), size: Dimensions.h_13),
              ],
            ),
          ),
        Center(child: Text(c.journalFooter, style: mutedStyle(context))),
      ],
    );
  }

  Widget buildMap(BuildContext context, AlertsController c) {
    Widget pin(double left, double top, IconData icon, Color color) => Positioned(
      left: left,
      top: top,
      child: CircleAvatar(
        radius: Dimensions.h_12,
        backgroundColor: color,
        child: Icon(icon, color: AppColor.white, size: Dimensions.h_12),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, 'Local impact map', action: 'Open map'),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: cardDecoration(context),
          child: Column(
            children: [
              // shortcut: illustrative map with fixed pins, swap for MapWidget once alerts have coordinates
              Container(
                height: Dimensions.h_160,
                color: AppColor.mapBlueSoft(context),
                child: Stack(
                  children: [
                    // the svg already draws the Fall City and river labels
                    Positioned.fill(
                      child: AppCacheImage(imageUrl: c.mapImage, widthSize: Get.width, size: Dimensions.h_160, fit: BoxFit.cover, isShadow: false, radius: 0),
                    ),
                    pin(Dimensions.w_175, Dimensions.h_15, CupertinoIcons.wifi, AppColor.blue(context)),
                    pin(Dimensions.w_80, Dimensions.h_65, CupertinoIcons.bolt_fill, AppColor.orange(context)),
                    pin(Dimensions.w_260, Dimensions.h_85, CupertinoIcons.car_detailed, AppColor.red(context)),
                    Positioned(
                      left: Dimensions.w_8,
                      bottom: Dimensions.h_8,
                      child: Text('I-90', style: mutedStyle(context, size: FontSize.sp_9)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.h_8),
                child: Row(
                  children: [
                    for (final f in c.mapFilters)
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => c.toggleMapFilter(f),
                        child: Padding(
                          padding: EdgeInsets.only(right: Dimensions.w_12, top: Dimensions.h_6, bottom: Dimensions.h_6),
                          child: Row(
                            children: [
                              Icon(c.activeMapFilters.contains(f) ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.square, color: AppColor.blue(context), size: Dimensions.h_15),
                              SizedBox(width: Dimensions.w_4),
                              Text(f, style: titleStyle(context, FontSize.sp_12)),
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
        SizedBox(height: Dimensions.h_4),
        Text('Illustrative map. Locations are approximate.', style: mutedStyle(context, size: FontSize.sp_10)),
      ],
    );
  }

  Widget buildNews(BuildContext context, AlertsController c) {
    final h = c.newsHero;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, 'Local news and reports'),
        tabs(context, c.newsTabs, c.newsTab, c.selectNewsTab),
        SizedBox(height: Dimensions.h_10),
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.h_12),
          child: Stack(
            children: [
              AppCacheImage(imageUrl: h['image']!, widthSize: Get.width, size: Dimensions.h_200, fit: BoxFit.cover, isShadow: false, radius: 0),
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
                    pill(context, h['tag']!, AppColor.white, AppColor.blue(context)),
                    SizedBox(height: Dimensions.h_4),
                    Text(
                      h['title']!,
                      style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_17, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      h['meta']!,
                      style: TextStyle(color: AppColor.white.withValues(alpha: 0.8), fontSize: FontSize.sp_10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        for (final n in c.news)
          Padding(
            padding: EdgeInsets.only(bottom: Dimensions.h_10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCacheImage(imageUrl: n['image']!, widthSize: Dimensions.w_80, size: Dimensions.h_60, fit: BoxFit.cover, isShadow: false, radius: Dimensions.h_8),
                SizedBox(width: Dimensions.w_10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        n['tag'].toString().toUpperCase(),
                        style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_9).copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: Dimensions.h_2),
                      Text(n['title']!, style: titleStyle(context, FontSize.sp_13_5)),
                      SizedBox(height: Dimensions.h_2),
                      Text(n['meta']!, style: mutedStyle(context, size: FontSize.sp_10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Row(
          children: [
            for (final p in c.neighborPhotos)
              Padding(
                padding: EdgeInsets.only(right: Dimensions.w_6),
                child: AppCacheImage(imageUrl: p, widthSize: Dimensions.w_70, size: Dimensions.h_50, fit: BoxFit.cover, isShadow: false, radius: Dimensions.h_8),
              ),
            Expanded(
              child: Text(c.neighborPhotosLabel, textAlign: TextAlign.center, style: linkStyle(context)),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildExplore(BuildContext context, AlertsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(context, 'Explore alerts'),
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: Dimensions.h_8,
          crossAxisSpacing: Dimensions.w_8,
          children: [
            for (final e in c.explore)
              Container(
                decoration: cardDecoration(context),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(e['icon'], color: Theme.of(context).highlightColor, size: Dimensions.h_20),
                          SizedBox(height: Dimensions.h_3),
                          Text(e['title'], style: titleStyle(context, FontSize.sp_12, weight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    if (e['count'] > 0)
                      Positioned(
                        right: -Dimensions.w_3,
                        top: -Dimensions.h_3,
                        child: CircleAvatar(
                          radius: Dimensions.h_7,
                          backgroundColor: AppColor.red(context),
                          child: Text(
                            '${e['count']}',
                            style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_9, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                  ],
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
    'red' => AppColor.red(context),
    'orange' => AppColor.orange(context),
    'blue' => AppColor.blue(context),
    'violet' => AppColor.violet(context),
    _ => AppColor.green(context),
  };

  Color toneSoft(BuildContext context, String? t) => switch (t) {
    'red' => AppColor.redSoft(context),
    'orange' => AppColor.orangeSoft(context),
    'blue' => AppColor.blueSoft(context),
    'violet' => AppColor.violetSoft(context),
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
    padding: EdgeInsets.only(bottom: Dimensions.h_8),
    child: Row(
      children: [
        Expanded(
          child: Text(title, style: titleStyle(context, FontSize.sp_16, weight: FontWeight.w800).copyWith(letterSpacing: -0.3)),
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

  Widget tabs(BuildContext context, List<String> items, int selected, ValueChanged<int> onTap) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (final (i, t) in items.indexed)
          GestureDetector(
            onTap: () => onTap(i),
            child: Container(
              margin: EdgeInsets.only(right: Dimensions.w_6),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_5),
              // the selected tab gets a matching border so tabs keep the same size when switching
              decoration: BoxDecoration(
                color: i == selected ? AppColor.blue(context) : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.h_6),
                border: Border.all(color: i == selected ? AppColor.blue(context) : AppColor.border(context), width: 0.5),
              ),
              child: Text(
                t,
                style: TextStyle(color: i == selected ? AppColor.surface(context) : Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
              ),
            ),
          ),
      ],
    ),
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
