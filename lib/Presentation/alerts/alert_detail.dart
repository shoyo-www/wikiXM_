import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/alerts/alerts_controller.dart';
import 'package:wikixm/Presentation/alerts/alerts_drawer.dart';
import 'package:wikixm/Presentation/alerts/alerts_home.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/common_empty_view.dart';
import 'package:wikixm/Presentation/widgets/common_error_view.dart';
import 'package:wikixm/Presentation/widgets/common_shimmer.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_tabs.dart';
import 'package:wikixm/Presentation/widgets/post_card.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/entrance_animation.dart';
import '../../data/datasource/remote/models/response/incident_detail.dart' show IncidentEntry;

class AlertDetail extends StatelessWidget with AlertsUi {
  const AlertDetail({super.key});

  AlertsController get controller => Get.find<AlertsController>();

  @override
  Widget build(BuildContext context) {
    return AlertsDrawer(
      builder: (openDrawer) => GetBuilder<AlertsController>(
        init: controller,
        id: ControllerBuilders.alertDetail,
        builder: (c) => c.incident == null
            ? Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: c.incidentLoading ? null : AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor, surfaceTintColor: AppColor.transparent),
                body: c.incidentLoading
                    ? detailShimmer()
                    : Center(
                        child: CommonErrorView(message: c.incidentError, onRetry: c.retryIncident),
                      ),
              )
            : Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: Column(
                  children: [
                    Expanded(
                      child: CommonScrollBlurScaffold(
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        collapsedColor: Theme.of(context).highlightColor,
                        showBack: true,
                        // menu goes after share instead of the app bar's drawer slot next to back
                        actions: [(c.bookmarked ? 'bookmark.fill' : 'bookmark', c.bookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark, c.toggleBookmark), ('square.and.arrow.up', CupertinoIcons.share, c.share), ('line.3.horizontal', CupertinoIcons.line_horizontal_3, openDrawer)],
                        expandedHeight: Dimensions.h_250,
                        hero: buildHero(context, c),
                        slivers: [
                          // SliverToBoxAdapter(child: buildVerified(context, c)),
                          SliverPadding(
                            padding: EdgeInsets.fromLTRB(Dimensions.w_10, Dimensions.h_10, Dimensions.w_10, MediaQuery.paddingOf(context).bottom + Dimensions.h_20),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate(
                                entranceList([
                                  for (final section in [
                                    PillTabs(tabs: c.detailTabs, selected: c.detailTab, onTap: c.selectDetailTab),
                                    SizedBox(height: Dimensions.h_5),
                                    ...switch (c.detailContentType) {
                                      null => [
                                        buildWhatHappened(context, c),
                                        if (c.incident!.timelinePreview?.isNotEmpty ?? false) buildUpdates(context, c, c.incident!.timelinePreview!),
                                        GetBuilder<AlertsController>(id: ControllerBuilders.alertDetailContent, builder: (c) => buildDiscussionPreview(context, c)),
                                        buildActions(context, c),
                                        buildSources(context, c),
                                        buildArticles(context, c),
                                        buildBusinesses(context, c),
                                      ],
                                      final type => [GetBuilder<AlertsController>(id: ControllerBuilders.alertDetailContent, builder: (c) => buildTab(context, c, type))],
                                    },
                                  ])
                                    Padding(
                                      padding: EdgeInsets.only(bottom: Dimensions.h_5),
                                      child: section,
                                    ),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (c.detailContentType == 'discussion') buildComposer(context, c),
                  ],
                ),
              ),
      ),
    );
  }

  Widget roundButton(BuildContext context, IconData icon, VoidCallback onTap) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Container(
      width: Dimensions.h_30,
      height: Dimensions.h_30,
      decoration: BoxDecoration(color: AppColor.surface(context), shape: BoxShape.circle),
      child: Icon(icon, color: Theme.of(context).highlightColor, size: Dimensions.h_15),
    ),
  );

  Widget card(BuildContext context, Widget child, {Color? color, EdgeInsetsGeometry? padding}) => Container(
    padding: padding ?? EdgeInsets.all(Dimensions.h_12),
    decoration: cardDecoration(context, color: color),
    child: child,
  );

  Widget buildHero(BuildContext context, AlertsController c) {
    final fade = Theme.of(context).brightness == Brightness.light ? AppColor.softBackground : AppColor.backgroundDark;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (c.heroPhotos.isNotEmpty)
          Positioned.fill(
            child: CarouselSlider.builder(
              controller: c.photoCarousel,
              itemCount: c.heroPhotos.length,
              itemBuilder: (context, i, _) => AppCacheImage(imageUrl: c.heroPhotos[i], widthSize: Get.width, size: Dimensions.h_330, fit: BoxFit.cover, isShadow: false, radius: 0),
              options: CarouselOptions(
                // fills the hero, which grows when the page is stretched
                height: double.infinity,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: (i, _) => c.onPhotoChanged(i),
              ),
            ),
          ),
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColor.transparent, AppColor.profileHeroDark.withValues(alpha: 0.55), AppColor.profileHeroDark.withValues(alpha: 0.9)], stops: const [0.3, 0.6, 1.0]),
              ),
            ),
          ),
        ),
        Positioned(
          left: Dimensions.w_12,
          right: Dimensions.w_12,
          bottom: Dimensions.h_20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IgnorePointer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        pill(context, c.incident!.categoryTitle ?? 'Incident', AppColor.white, AppColor.blue(context)),
                        if (c.incidentStatus.isNotEmpty) ...[SizedBox(width: Dimensions.w_6), pill(context, '● ${c.incidentStatus}', AppColor.white, AppColor.red(context))],
                      ],
                    ),
                    SizedBox(height: Dimensions.h_8),
                    Text(
                      c.incident!.title ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_30, fontWeight: FontWeight.w900, letterSpacing: -0.5, height: 1.1, shadows: AlertsHome.heroShadow),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                children: [
                  Expanded(
                    child: IgnorePointer(
                      child: Row(
                        children: [
                          AppCacheImage(imageUrl: c.incident!.author?.profileImage ?? '', widthSize: Dimensions.h_30, size: Dimensions.h_30, radius: Dimensions.h_30, isCircle: true, isShadow: false, borderColor: AppColor.white),
                          SizedBox(width: Dimensions.w_8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.incident!.author?.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  c.incidentUpdated,
                                  style: TextStyle(color: AppColor.white.withValues(alpha: 0.8), fontSize: FontSize.sp_10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GetBuilder<AlertsController>(
                    id: ControllerBuilders.alertDetailFollow,
                    builder: (c) => GestureDetector(
                      onTap: c.toggleFollow,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                        height: Dimensions.h_25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: c.following ? AppColor.white : AppColor.blue(context), borderRadius: BorderRadius.circular(Dimensions.h_6)),
                        child: Row(
                          children: [
                            Icon(c.following ? CupertinoIcons.bell_fill : CupertinoIcons.bell, color: c.following ? AppColor.blue(context) : AppColor.white, size: Dimensions.h_12),
                            SizedBox(width: Dimensions.w_4),
                            Text(
                              c.following ? 'Following' : 'Follow ',
                              style: TextStyle(color: c.following ? AppColor.blue(context) : AppColor.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_12),
              IgnorePointer(
                child: GetBuilder<AlertsController>(
                  id: ControllerBuilders.alertDetailPhotos,
                  builder: (c) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < c.heroPhotos.length; i++)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
                          width: i == c.photoIndex ? Dimensions.w_12 : Dimensions.w_4,
                          height: Dimensions.h_4,
                          decoration: BoxDecoration(
                            color: AppColor.white.withValues(alpha: i == c.photoIndex ? 1 : 0.5),
                            borderRadius: BorderRadius.circular(Dimensions.h_4),
                          ),
                        ),
                    ],
                  ),
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
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [fade.withValues(alpha: 0.0), fade.withValues(alpha: 0.15), fade.withValues(alpha: 0.35), fade.withValues(alpha: 0.78), fade], stops: const [0.08, 0.25, 0.45, 0.75, 1.0]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget grid(List<Widget> children, {double? height}) => GridView(
    shrinkWrap: true,
    padding: EdgeInsets.zero,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: Dimensions.h_8, crossAxisSpacing: Dimensions.w_8, childAspectRatio: 1.45, mainAxisExtent: height),
    children: children,
  );

  Widget buildGlance(BuildContext context, AlertsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.h_10),
        sectionHeader(context, 'Incident overview'),
        Text(
          'A strong windstorm moved through the Snoqualmie Valley in this example, causing widespread power outages, downed trees, and travel disruptions. Utility crews and local agencies are responding while residents share neighborhood observations. This incident hub brings official-source examples, related coverage, community reports, photos, and practical resources together.',
          style: mutedStyle(context, size: FontSize.sp_13),
        ),
        SizedBox(height: Dimensions.h_10),
        grid([
          for (final g in c.glance)
            Container(
              padding: EdgeInsets.all(Dimensions.h_8),
              decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.h_10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  iconBox(context, g['icon'], g['tone'], size: Dimensions.h_25),
                  const Spacer(),
                  Text(g['value'], style: titleStyle(context, FontSize.sp_15, weight: FontWeight.w800)),
                  Text(
                    g['label'],
                    style: mutedStyle(context, size: FontSize.sp_10),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
        ], height: Dimensions.h_90),
        SizedBox(height: Dimensions.h_12),
        Row(
          children: [
            Expanded(child: Text('Restoration progress', style: titleStyle(context, FontSize.sp_11))),
            Text(c.restorationEta, style: linkStyle(context)),
          ],
        ),
        SizedBox(height: Dimensions.h_6),
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.h_4),
          child: LinearProgressIndicator(value: c.restoration, minHeight: Dimensions.h_5, color: AppColor.blue(context), backgroundColor: AppColor.blueSoft(context)),
        ),
        SizedBox(height: Dimensions.h_6),
        Text(c.restorationNote, style: mutedStyle(context, size: FontSize.sp_10)),
      ],
    );
  }

  Widget buildVerified(BuildContext context, AlertsController c) => ClipRRect(borderRadius: BorderRadius.circular(Dimensions.h_8), child: tickerStrip(context, 'UPDATE', c.verifiedUpdates, 'green'));

  Widget buildWhatHappened(BuildContext context, AlertsController c) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(c.incident!.description ?? '', style: titleStyle(context, FontSize.sp_12, weight: FontWeight.w400).copyWith(height: 1.45)),
          SizedBox(height: Dimensions.h_12),
          Text('Key impacts of incident', style: titleStyle(context, FontSize.sp_14)),
          SizedBox(height: Dimensions.h_8),
          grid([
            for (final i in c.impacts)
              Container(
                padding: EdgeInsets.all(Dimensions.h_8),
                decoration: cardDecoration(context),
                child: Row(
                  children: [
                    iconBox(context, i['icon'], i['tone'], size: Dimensions.h_30),
                    SizedBox(width: Dimensions.w_8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(i['title'], style: titleStyle(context, FontSize.sp_11)),
                          Text(i['body'], style: mutedStyle(context, size: FontSize.sp_10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ], height: Dimensions.h_50),
        ],
      ),
    );
  }

  Widget buildUpdates(BuildContext context, AlertsController c, List<IncidentEntry> items, {bool all = false}) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => c.openDetailTab('timeline'),
          child: sectionHeader(context, all ? 'Timeline' : 'Latest updates', action: all ? null : 'Full timeline'),
        ),
        for (final (n, t) in items.indexed)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.h_4),
                      child: CircleAvatar(radius: Dimensions.h_4, backgroundColor: t.type == 'incident' ? AppColor.blue(context) : AppColor.green(context)),
                    ),
                    if (n < items.length - 1)
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
                            Text([t.displayTimestamp?.date, t.displayTimestamp?.time].nonNulls.join(', '), style: titleStyle(context, FontSize.sp_11)),
                            SizedBox(width: Dimensions.w_6),
                            t.type == 'incident' ? pill(context, 'Reported', AppColor.blue(context), AppColor.blueSoft(context)) : pill(context, AlertsController.titleCase(t.type ?? 'Update'), AppColor.green(context), AppColor.greenSoft(context)),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_2),
                        Text(t.title ?? '', style: titleStyle(context, FontSize.sp_12, weight: FontWeight.w600).copyWith(height: 1.35)),
                        if (t.description?.isNotEmpty ?? false) Text(t.description!, maxLines: all ? null : 3, overflow: all ? null : TextOverflow.ellipsis, style: mutedStyle(context)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
    return all ? content : card(context, content);
  }

  Widget buildActions(BuildContext context, AlertsController c) {
    return card(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeader(context, 'What you can do', action: 'Add a solution'),
          for (final a in c.actions)
            Padding(
              padding: EdgeInsets.only(bottom: Dimensions.h_8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(CupertinoIcons.checkmark_alt, color: AppColor.green(context), size: Dimensions.h_15),
                  SizedBox(width: Dimensions.w_8),
                  Expanded(
                    child: Text(a, style: titleStyle(context, FontSize.sp_12, weight: FontWeight.w400).copyWith(height: 1.35)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildSources(BuildContext context, AlertsController c) {
    return card(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeader(context, 'Official sources'),
          for (final s in c.sources) ...[
            if (s != c.sources.first) Divider(height: Dimensions.h_15, color: AppColor.border(context)),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => c.openSource(s),
              child: Row(
                children: [
                  iconBox(context, s['icon'], 'blue', size: Dimensions.h_30),
                  SizedBox(width: Dimensions.w_10),
                  Expanded(child: Text(s['title'], style: titleStyle(context, FontSize.sp_12))),
                  Icon(CupertinoIcons.arrow_up_right, color: AppColor.muted(context), size: Dimensions.h_12),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildArticles(BuildContext context, AlertsController c) {
    return card(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeader(context, 'Related articles'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final a in c.articles)
                  GestureDetector(
                    onTap: () => c.openArticle(a),
                    child: Container(
                      width: Dimensions.w_160,
                      margin: EdgeInsets.only(right: Dimensions.w_10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppCacheImage(imageUrl: a['image']!, widthSize: Dimensions.w_160, size: Dimensions.h_100, fit: BoxFit.cover, isShadow: false, radius: Dimensions.h_8),
                          SizedBox(height: Dimensions.h_6),
                          Text(a['title']!, style: titleStyle(context, FontSize.sp_12), maxLines: 2, overflow: TextOverflow.ellipsis),
                          Text(a['meta']!, style: mutedStyle(context, size: FontSize.sp_10)),
                        ],
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

  Widget buildDiscussionPreview(BuildContext context, AlertsController c) {
    final items = c.tabItems['discussion'] ?? [];
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.h_12),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => c.openDetailTab('discussion'),
          child: sectionHeader(context, 'Community discussion', action: 'See all'),
        ),
        for (final e in items.take(c.discussionPreviewCount)) PostCard(item: c.toPost(e), showSave: false, showCommentIcon: false, commentsLabel: 'Replies'),
      ],
    );
  }

  /// Timeline, discussion, questions or solutions tab, loaded from the incident content API.
  Widget buildTab(BuildContext context, AlertsController c, String type) {
    final items = c.tabItems[type];
    if (items == null) {
      return Padding(
        padding: EdgeInsets.only(top: Dimensions.h_40),
        child: c.tabErrors[type] == null ? CupertinoActivityIndicator(color: AppColor.blue(context)) : CommonErrorView(message: c.tabErrors[type], onRetry: () => c.loadTab(type)),
      );
    }
    if (type == 'timeline') {
      if (items.isNotEmpty) return buildUpdates(context, c, items, all: true);
      return CommonEmptyView(icon: CupertinoIcons.clock, title: 'No updates yet', message: 'New updates on this incident will show up here as they come in.', actions: [(title: 'Back to overview', icon: CupertinoIcons.info, onTap: () => c.selectDetailTab(0))]);
    }
    final joinDiscussion = (title: 'Join the discussion', icon: CupertinoIcons.chat_bubble_2, onTap: () => c.openDetailTab('discussion'));
    final (title, subtitle, empty) = switch (type) {
      'questions' => ('Questions from neighbors', 'Ask what you need to know about this incident.', (icon: CupertinoIcons.question_circle, title: 'No questions yet', message: 'Have something you need to know? Ask neighbors in the discussion.', action: joinDiscussion)),
      'solutions' => ('Community solutions', 'Ways neighbors are helping each other through this incident.', (icon: CupertinoIcons.lightbulb, title: 'No solutions yet', message: 'Know a way to help? Share it with neighbors in the discussion.', action: joinDiscussion)),
      _ => ('The conversation starts here', 'Updates, photos and tips from neighbors about this incident. What are you seeing?', (icon: CupertinoIcons.chat_bubble_2, title: 'No posts yet', message: 'Be the first to share what you see nearby.', action: null)),
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
        ),
        Padding(
          padding: EdgeInsets.only(left: Dimensions.w_6, top: Dimensions.h_6),
          child: Text(
            subtitle,
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.1),
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        if (items.isEmpty)
          Center(
            child: CommonEmptyView(icon: empty.icon, title: empty.title, message: empty.message, actions: [?empty.action]),
          ),
        for (final (i, e) in items.indexed)
          EntranceAnimation(
            index: i,
            child: Column(
              children: [PostCard(item: c.toPost(e), showSave: false, showCommentIcon: false, showFooter: type != 'solutions', commentsLabel: type == 'questions' ? 'Answers' : 'Replies', onComments: () => c.toggleThread(e), thread: c.openThreads.contains(e.id) ? buildThread(context, c, e) : null)],
            ),
          ),
      ],
    );
  }

  /// Replies or answers inside the parent card, indented under a thin line.
  Widget buildThread(BuildContext context, AlertsController c, IncidentEntry e) {
    final replies = c.threads[e.id];
    if (replies == null) return Center(child: CupertinoActivityIndicator(color: AppColor.blue(context)));
    return Container(
      margin: EdgeInsets.only(left: Dimensions.w_6),
      padding: EdgeInsets.only(left: Dimensions.w_10),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: AppColor.border(context), width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (i, r) in replies.indexed) ...[
            if (i > 0) SizedBox(height: Dimensions.h_10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCacheImage(imageUrl: r.author?.profileImage ?? '', size: Dimensions.h_22, widthSize: Dimensions.h_22, isCircle: true, color: Theme.of(context).highlightColor),
                SizedBox(width: Dimensions.w_8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(r.author?.name ?? r.authorName ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: titleStyle(context, FontSize.sp_11)),
                          ),
                          SizedBox(width: Dimensions.w_6),
                          Text(r.displayTimestamp?.label ?? r.createdAtLabel ?? '', style: mutedStyle(context, size: FontSize.sp_9)),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_2),
                      Text(r.body ?? r.description ?? '', style: titleStyle(context, FontSize.sp_10, weight: FontWeight.w500).copyWith(height: 1.3)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget buildBusinesses(BuildContext context, AlertsController c) {
    final s = c.sponsor;
    return Column(
      children: [
        sectionHeader(context, 'Local businesses', trailing: 'Sponsored'),
        card(
          context,
          Row(
            children: [
              iconBox(context, CupertinoIcons.tree, 'green', size: Dimensions.h_40),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s['title']!, style: titleStyle(context, FontSize.sp_13)),
                    Text(s['body']!, style: mutedStyle(context)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_6),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.blue(context)),
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                ),
                child: Text(s['link']!, style: linkStyle(context)),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_8),
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

  Widget buildComposer(BuildContext context, AlertsController c) {
    return Container(
      padding: EdgeInsets.fromLTRB(Dimensions.w_10, Dimensions.h_8, Dimensions.w_10, MediaQuery.paddingOf(context).bottom + Dimensions.h_8),
      decoration: BoxDecoration(
        color: AppColor.surface(context),
        border: Border(top: BorderSide(color: AppColor.border(context), width: 0.5)),
      ),
      child: Row(
        children: [
          roundButton(context, CupertinoIcons.camera, c.addPhoto),
          SizedBox(width: Dimensions.w_8),
          Expanded(
            child: TextField(
              controller: c.reportText,
              focusNode: c.reportFocus,
              onSubmitted: (_) => c.sendReport(),
              style: TextStyle(fontSize: FontSize.sp_12, color: Theme.of(context).highlightColor),
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Share what you\'re seeing...',
                hintStyle: TextStyle(fontSize: FontSize.sp_12, color: AppColor.muted(context)),
                contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_10),
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.h_20), borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_8),
          GestureDetector(
            onTap: c.sendReport,
            child: CircleAvatar(
              radius: Dimensions.h_16,
              backgroundColor: AppColor.blue(context),
              child: Icon(CupertinoIcons.arrow_up, color: AppColor.white, size: Dimensions.h_15),
            ),
          ),
        ],
      ),
    );
  }

  /// Placeholder in the shape of the detail page: hero, tabs, description, impacts and updates.
  Widget detailShimmer() {
    Widget line(double width, {double? height}) => Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h_6),
      child: ShimmerBox(width, height ?? Dimensions.h_11),
    );
    return CommonShimmer(
      heroHeight: Dimensions.h_250,
      hero: [
        ShimmerBox(Dimensions.w_35, Dimensions.h_33, radius: Dimensions.h_10),
        const Spacer(),
        Row(
          children: [
            ShimmerBox(Dimensions.w_80, Dimensions.h_20, radius: Dimensions.h_20),
            SizedBox(width: Dimensions.w_6),
            ShimmerBox(Dimensions.w_60, Dimensions.h_20, radius: Dimensions.h_20),
          ],
        ),
        SizedBox(height: Dimensions.h_8),
        line(Dimensions.w_260, height: Dimensions.h_25),
        line(Dimensions.w_175, height: Dimensions.h_25),
        line(double.infinity),
        line(Dimensions.w_220),
        SizedBox(height: Dimensions.h_8),
        Row(
          children: [
            ShimmerBox(Dimensions.h_30, Dimensions.h_30, isCircle: true),
            SizedBox(width: Dimensions.w_8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(Dimensions.w_100, Dimensions.h_10),
                SizedBox(height: Dimensions.h_4),
                ShimmerBox(Dimensions.w_150, Dimensions.h_8),
              ],
            ),
            const Spacer(),
            ShimmerBox(Dimensions.w_100, Dimensions.h_25, radius: Dimensions.h_6),
          ],
        ),
      ],
      body: [
        SizedBox(height: Dimensions.h_10),
        Row(
          children: [
            for (final w in [Dimensions.w_70, Dimensions.w_70, Dimensions.w_80, Dimensions.w_80]) ...[ShimmerBox(w, Dimensions.h_28, radius: Dimensions.h_20), SizedBox(width: Dimensions.w_6)],
          ],
        ),
        SizedBox(height: Dimensions.h_15),
        line(double.infinity),
        line(double.infinity),
        line(double.infinity),
        line(Dimensions.w_200),
        SizedBox(height: Dimensions.h_12),
        line(Dimensions.w_175, height: Dimensions.h_15),
        SizedBox(height: Dimensions.h_4),
        grid([
          for (var i = 0; i < 4; i++)
            ShimmerCard(
              Row(
                children: [
                  ShimmerBox(Dimensions.h_30, Dimensions.h_30, radius: Dimensions.h_8),
                  SizedBox(width: Dimensions.w_8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerBox(Dimensions.w_80, Dimensions.h_10),
                        SizedBox(height: Dimensions.h_4),
                        ShimmerBox(Dimensions.w_60, Dimensions.h_8),
                      ],
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(Dimensions.h_8),
            ),
        ], height: Dimensions.h_50),
        SizedBox(height: Dimensions.h_15),
        ShimmerCard(timelineShimmer()),
      ],
    );
  }

  /// Timeline rows: dot, time and label, then the update text.
  Widget timelineShimmer() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (var i = 0; i < 3; i++)
        Padding(
          padding: EdgeInsets.only(bottom: Dimensions.h_12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerBox(Dimensions.h_8, Dimensions.h_8, isCircle: true),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ShimmerBox(Dimensions.w_80, Dimensions.h_10),
                        SizedBox(width: Dimensions.w_6),
                        ShimmerBox(Dimensions.w_60, Dimensions.h_15, radius: Dimensions.h_20),
                      ],
                    ),
                    SizedBox(height: Dimensions.h_6),
                    ShimmerBox(Dimensions.w_220, Dimensions.h_11),
                    SizedBox(height: Dimensions.h_4),
                    ShimmerBox(double.infinity, Dimensions.h_8),
                  ],
                ),
              ),
            ],
          ),
        ),
    ],
  );
}
