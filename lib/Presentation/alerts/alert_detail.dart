import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/alerts/alerts_controller.dart';
import 'package:wikixm/Presentation/alerts/alerts_home.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/Presentation/widgets/post_card.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/entrance_animation.dart';

class AlertDetail extends StatelessWidget with AlertsUi {
  const AlertDetail({super.key});

  AlertsController get controller => Get.find<AlertsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlertsController>(
      init: controller,
      id: ControllerBuilders.alertDetail,
      builder: (c) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            Expanded(
              child: CommonScrollBlurScaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                collapsedColor: Theme.of(context).highlightColor,
                showBack: true,
                actions: [(c.bookmarked ? 'bookmark.fill' : 'bookmark', c.bookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark, c.toggleBookmark), ('square.and.arrow.up', CupertinoIcons.share, c.share)],
                expandedHeight: Dimensions.h_250,
                hero: buildHero(context, c),
                slivers: [
                  SliverToBoxAdapter(child: buildVerified(context, c)),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(Dimensions.w_10, Dimensions.h_10, Dimensions.w_10, MediaQuery.paddingOf(context).bottom + Dimensions.h_20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        entranceList([
                          for (final section in [
                            tabs(context, c.detailTabs, c.detailTab, c.selectDetailTab),
                            SizedBox(height: Dimensions.h_5),
                            ...switch (c.detailTab) {
                              1 => [buildDiscussion(context, c)],
                              2 => [buildUpdates(context, c, all: true)],
                              3 => [buildArticles(context, c, vertical: true)],
                              4 => [buildPhotos(context, c)],
                              _ => [buildWhatHappened(context, c), buildUpdates(context, c), buildDiscussionPreview(context, c), buildActions(context, c), buildSources(context, c), buildArticles(context, c), buildBusinesses(context, c)],
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
            // the posting box sticks to the bottom, but only on the Discussion tab
            if (c.detailTab == 1) buildComposer(context, c),
          ],
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
        Positioned.fill(
          child: CarouselSlider.builder(
            controller: c.photoCarousel,
            itemCount: c.photos.length,
            itemBuilder: (context, i, _) => AppCacheImage(imageUrl: c.photos[i]['image']!, widthSize: Get.width, size: Dimensions.h_330, fit: BoxFit.cover, isShadow: false, radius: 0),
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
              // text ignores touches so swipes over it still move the carousel
              IgnorePointer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        pill(context, c.detailTags[0], AppColor.white, AppColor.blue(context)),
                        SizedBox(width: Dimensions.w_6),
                        pill(context, '● ${c.detailTags[1]}', AppColor.white, AppColor.red(context)),
                      ],
                    ),
                    SizedBox(height: Dimensions.h_8),
                    Text(
                      c.detailTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_30, fontWeight: FontWeight.w900, letterSpacing: -0.5, height: 1.1, shadows: AlertsHome.heroShadow),
                    ),
                    SizedBox(height: Dimensions.h_6),
                    Text(
                      c.detailIntro,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w500, shadows: AlertsHome.heroShadow),
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
                          AppCacheImage(imageUrl: c.editorImage, widthSize: Dimensions.h_30, size: Dimensions.h_30, radius: Dimensions.h_30, isCircle: true, isShadow: false, borderColor: AppColor.white),
                          SizedBox(width: Dimensions.w_8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.editorName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  c.editorUpdated,
                                  style: TextStyle(color: AppColor.white.withValues(alpha: 0.8), fontSize: FontSize.sp_10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
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
                            c.following ? 'Following' : 'Follow incident',
                            style: TextStyle(color: c.following ? AppColor.blue(context) : AppColor.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_12),
              IgnorePointer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < c.photos.length; i++)
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
          sectionHeader(context, 'Incident overview'),
          Text(c.whatHappened, style: titleStyle(context, FontSize.sp_12, weight: FontWeight.w400).copyWith(height: 1.45)),
          SizedBox(height: Dimensions.h_12),
          Text('Key impacts', style: titleStyle(context, FontSize.sp_12)),
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

  Widget buildUpdates(BuildContext context, AlertsController c, {bool all = false}) {
    final items = all ? c.detailTimeline : c.detailTimeline.take(c.latestCount).toList();
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => c.selectDetailTab(2),
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
                      child: CircleAvatar(radius: Dimensions.h_4, backgroundColor: t['source'] == 'Neighbor' ? AppColor.blue(context) : AppColor.green(context)),
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
                            Text(t['time']!, style: titleStyle(context, FontSize.sp_11)),
                            SizedBox(width: Dimensions.w_6),
                            t['source'] == 'Neighbor' ? pill(context, 'Neighbor', AppColor.blue(context), AppColor.blueSoft(context)) : pill(context, t['source']!, AppColor.green(context), AppColor.greenSoft(context)),
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
      ],
    );
    // the Timeline tab shows it straight on the page, Overview keeps the card
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

  Widget buildArticles(BuildContext context, AlertsController c, {bool vertical = false}) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => c.selectDetailTab(3),
          child: sectionHeader(context, 'Related articles', action: vertical ? null : 'See all ${c.articles.length}'),
        ),
        // the Articles tab lists them full width, Overview keeps the compact horizontal strip
        if (!vertical)
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
          )
        else
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: c.articles.length,
            itemBuilder: (context, i) {
              final a = c.articles[i];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => c.openArticle(a),
                child: Container(
                  margin: EdgeInsets.only(bottom: Dimensions.h_10),
                  padding: EdgeInsets.all(Dimensions.h_8),
                  decoration: cardDecoration(context),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppCacheImage(imageUrl: a['image']!, widthSize: Dimensions.w_100, size: Dimensions.h_70, fit: BoxFit.cover, isShadow: false, radius: Dimensions.h_8),
                      SizedBox(width: Dimensions.w_10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(a['title']!, style: titleStyle(context, FontSize.sp_13), maxLines: 2, overflow: TextOverflow.ellipsis),
                            SizedBox(height: Dimensions.h_3),
                            Text(a['meta']!, style: mutedStyle(context, size: FontSize.sp_10)),
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
    );
    // the Articles tab shows them straight on the page, Overview keeps the card
    return vertical ? content : card(context, content);
  }

  Widget buildPhotos(BuildContext context, AlertsController c) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: Dimensions.h_6,
      crossAxisSpacing: Dimensions.w_6,
      children: [
        for (final (i, p) in c.detailPhotos.indexed)
          GestureDetector(
            onTap: () => c.openPhoto(i),
            child: AppCacheImage(imageUrl: p, widthSize: Get.width / 3, size: Get.width / 3, fit: BoxFit.cover, isShadow: false, radius: Dimensions.h_8),
          ),
      ],
    );
  }

  Widget buildDiscussionPreview(BuildContext context, AlertsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => c.selectDetailTab(1),
          child: sectionHeader(context, 'Community discussion', action: 'See all ${c.discussion.length}'),
        ),
        for (final p in c.discussion.take(c.discussionPreviewCount)) PostCard(item: p, showSave: false, showCommentIcon: false, commentsLabel: 'Replies'),
      ],
    );
  }

  Widget buildDiscussion(BuildContext context, AlertsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'The conversation starts here',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: Dimensions.w_6, top: Dimensions.h_6),
          child: Text(
            'Updates, photos and tips from neighbors about this incident. What are you seeing?',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.1),
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        for (final (i, p) in c.discussion.indexed)
          EntranceAnimation(
            index: i,
            child: PostCard(item: p, showSave: false, showCommentIcon: false, commentsLabel: 'Replies'),
          ),
      ],
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
}
