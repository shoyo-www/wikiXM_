import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/widgets/common_blur_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/cache_image.dart';
import '../widgets/common_shimmer.dart';
import '../../data/datasource/remote/models/response/public_profile.dart' as pp;
import '../../data/datasource/remote/models/response/public_profile_feed.dart';
import '../widgets/entrance_animation.dart';

class PublicProfile extends StatelessWidget {
  const PublicProfile({super.key});

  GroupController get controller => Get.put(GroupController());

  static final shadow = [
    BoxShadow(color: AppColor.black.withValues(alpha: 0.05), blurRadius: 2, offset: const Offset(0, 1)),
    BoxShadow(color: AppColor.black.withValues(alpha: 0.05), blurRadius: 24, offset: const Offset(0, 8)),
  ];

  @override
  Widget build(BuildContext context) {
    return CommonBlurScaffold(
      showBack: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      collapsedColor: AppColor.ink(context),
      child: GetBuilder<GroupController>(
        init: controller,
        id: ControllerBuilders.publicProfile,
        initState: (_) => controller.getPublicProfile(),
        builder: (c) {
          if (c.publicProfile == null) return c.publicProfileLoading ? pageShimmer(context) : loadError(context, c);
          final profile = c.publicProfile!;
          final feed = c.publicProfileFeed;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: staggered([
              buildHero(context, c),
              SizedBox(height: Dimensions.h_15),
              buildActions(context, c),
              SizedBox(height: Dimensions.h_15),
              buildStats(context, c),
              SizedBox(height: Dimensions.h_15),
              if (c.publicProfileTab != 'overview')
                buildTabContent(context, c)
              else
                KeyedSubtree(
                  key: const ValueKey('overview'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: staggered([
                      if (profile.activities?.isNotEmpty == true) ...[sectionHeader(context, 'Recent activity'), buildRecent(context, c)],
                      if (profile.groups?.isNotEmpty == true) ...[sectionHeader(context, 'Groups  (${profile.statistics?.groups ?? profile.groups!.length})'), buildGroups(context, c)],
                      if (feed?.upcomingActivities?.isNotEmpty == true) ...[sectionHeader(context, 'Upcoming activities'), buildActivities(context, c)],
                      if (profile.interests?.isNotEmpty == true) ...[
                        sectionHeader(context, 'Interests', seeAll: false),
                        buildInterests(context, c.publicProfile!.interests!),
                        SizedBox(height: Dimensions.h_15),
                      ],
                      if (feed?.photos?.isNotEmpty == true) ...[sectionHeader(context, 'Photos'), buildPhotos(context, c)],
                    ]),
                  ),
                ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + Dimensions.h_10),
            ]),
          );
        },
      ),
    );
  }

  Widget sectionHeader(BuildContext context, String title, {String? count, bool seeAll = true}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Dimensions.w_10, 0, Dimensions.w_10, Dimensions.h_12),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w900, letterSpacing: -0.5),
          ),
          if (count != null)
            Text(
              ' · $count',
              style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_14, fontWeight: FontWeight.w600, letterSpacing: -0.5),
            ),
          const Spacer(),
          if (seeAll)
            Text(
              'See all',
              style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
            ),
        ],
      ),
    );
  }

  Widget pageShimmer(BuildContext context) {
    final avatar = Dimensions.h_90;
    Widget header() => Padding(
      padding: EdgeInsets.fromLTRB(Dimensions.w_10, Dimensions.h_15, Dimensions.w_10, Dimensions.h_12),
      child: Row(children: [ShimmerBox(Dimensions.w_120, Dimensions.h_15), const Spacer(), ShimmerBox(Dimensions.w_40, Dimensions.h_10)]),
    );
    Widget cards(double width, double height) => SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
        itemCount: 3,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_12),
        itemBuilder: (_, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBox(width, height * 0.6, radius: Dimensions.h_8),
            SizedBox(height: Dimensions.h_10),
            ShimmerBox(width * 0.8, Dimensions.h_13),
            SizedBox(height: Dimensions.h_6),
            ShimmerBox(width * 0.5, Dimensions.h_10),
          ],
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ShimmerBox(Get.width, Dimensions.h_210, radius: 0),
            // Mirrors buildHero: avatar on the left, name / location / role chips beside it.
            Padding(
              padding: EdgeInsets.only(top: Dimensions.h_190 - avatar * 0.75, left: Dimensions.w_10, right: Dimensions.w_10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_20)),
                    padding: const EdgeInsets.all(4),
                    child: ShimmerBox(avatar, avatar, radius: Dimensions.h_18),
                  ),
                  SizedBox(width: Dimensions.w_12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.h_8),
                        ShimmerBox(Dimensions.w_160, Dimensions.h_22),
                        SizedBox(height: Dimensions.h_8),
                        ShimmerBox(Dimensions.w_120, Dimensions.h_12),
                        SizedBox(height: Dimensions.h_10),
                        Wrap(
                          spacing: Dimensions.w_4,
                          runSpacing: Dimensions.h_8,
                          children: [
                            for (final w in [Dimensions.w_70, Dimensions.w_90]) ShimmerBox(w, Dimensions.h_22, radius: 99),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
          child: Column(
            children: [
              SizedBox(height: Dimensions.h_12),
              ShimmerBox(double.infinity, Dimensions.h_10),
              SizedBox(height: Dimensions.h_5),
              ShimmerBox(Dimensions.w_220, Dimensions.h_10),
              SizedBox(height: Dimensions.h_15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                child: Row(
                  children: [
                    Expanded(child: ShimmerBox(double.infinity, Dimensions.h_30, radius: Dimensions.h_16)),
                    SizedBox(width: Dimensions.w_20),
                    Expanded(child: ShimmerBox(double.infinity, Dimensions.h_30, radius: Dimensions.h_16)),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                children: [
                  for (var i = 0; i < 4; i++)
                    Expanded(
                      child: Column(
                        children: [
                          ShimmerBox(Dimensions.w_30, Dimensions.h_15),
                          SizedBox(height: Dimensions.h_4),
                          ShimmerBox(Dimensions.w_45, Dimensions.h_8),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        header(),
        cards(Dimensions.w_160, Dimensions.h_270),
        header(),
        cards(Dimensions.w_150, Dimensions.h_180),
        header(),
        cards(Dimensions.w_200, Dimensions.h_220),
      ],
    );
  }

  Widget loadError(BuildContext context, GroupController c) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + Dimensions.h_150),
      child: Center(
        child: Column(
          children: [
            Text(
              "Couldn't load this profile",
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w700),
            ),
            TextButton(
              onPressed: c.getPublicProfile,
              child: Text(
                'Try again',
                style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHero(BuildContext context, GroupController c) {
    final profile = c.publicProfile!;
    final avatar = Dimensions.h_90;
    return Stack(
      children: [
        SizedBox(
          height: Dimensions.h_210,
          width: Get.width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppCacheImage(imageUrl: profile.cover ?? '', size: Dimensions.h_260, widthSize: Get.width, isShadow: false),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.black.withValues(alpha: 0.15),
                      Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.1),
                      Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                    stops: const [0.0, 0.4, 0.78, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimensions.h_190 - avatar * 0.75, left: Dimensions.w_10, right: Dimensions.w_10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.h_20),
                      border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 4),
                      boxShadow: shadow,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.h_20),
                      child: AppCacheImage(imageUrl: profile.avatar ?? '', size: avatar, widthSize: avatar, isShadow: false),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.h_5),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                profile.name ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_26, fontWeight: FontWeight.w900, letterSpacing: -0.6),
                              ),
                            ),
                            if (profile.verified == true) ...[SizedBox(width: Dimensions.w_6), Icon(Icons.verified_rounded, color: AppColor.blue(context), size: Dimensions.h_20)],
                          ],
                        ),
                        SizedBox(height: Dimensions.h_3),
                        Row(
                          children: [
                            Icon(Icons.location_on_sharp, size: Dimensions.h_13, color: Theme.of(context).highlightColor),
                            SizedBox(width: Dimensions.w_4),
                            Flexible(
                              child: Text(
                                profile.location ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_8),
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: Dimensions.w_4,
                          runSpacing: Dimensions.h_8,
                          children: [
                            for (final role in profile.roles ?? <String>[])
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_5),
                                decoration: BoxDecoration(
                                  color: AppColor.surface(context),
                                  borderRadius: BorderRadius.circular(99),
                                  border: Border.all(color: AppColor.border(context)),
                                ),
                                child: Text(
                                  role,
                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (profile.bio?.isNotEmpty == true) ...[
                SizedBox(height: Dimensions.h_12),
                Text(
                  profile.bio!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).highlightColor.withValues(alpha: 0.85), fontSize: FontSize.sp_12, height: 1.55),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget buildStats(BuildContext context, GroupController c) {
    final st = c.publicProfile?.statistics;
    final stats = [(st?.groups, 'Groups'), (st?.activities, 'Activities'), (st?.discussions, 'Discussions'), (st?.organized, 'Organized')];
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (final (i, (value, label)) in stats.indexed) ...[
              if (i > 0) VerticalDivider(width: 1, thickness: 1, color: AppColor.border(context)),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${value ?? 0}',
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                    ),
                    SizedBox(height: Dimensions.h_2),
                    Text(
                      label,
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildActions(BuildContext context, GroupController c) {
    final following = c.isFollowingProfile;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_20),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: c.toggleFollowProfile,
              child: Container(
                height: Dimensions.h_30,
                decoration: BoxDecoration(
                  color: following ? AppColor.surface(context) : AppColor.blue(context),
                  borderRadius: BorderRadius.circular(Dimensions.h_16),
                  border: Border.all(color: AppColor.blue(context), width: 1.4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(following ? CupertinoIcons.checkmark_alt : CupertinoIcons.add, size: Dimensions.h_13, color: following ? AppColor.blue(context) : AppColor.white),
                    SizedBox(width: Dimensions.w_5),
                    Text(
                      following ? (c.publicProfileFollowAction?.activeLabel ?? 'Following') : (c.publicProfileFollowAction?.label ?? 'Follow'),
                      style: TextStyle(color: following ? AppColor.blue(context) : AppColor.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_20),
          Expanded(
            child: Container(
              height: Dimensions.h_30,
              decoration: BoxDecoration(
                color: AppColor.surface(context),
                borderRadius: BorderRadius.circular(Dimensions.h_16),
                border: Border.all(color: AppColor.border(context)),
                boxShadow: shadow,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.chat_bubble, size: Dimensions.h_12, color: AppColor.ink(context)),
                  SizedBox(width: Dimensions.w_4),
                  Text(
                    'Message',
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // A non-overview tab: its /items pages as a list, a photo grid or interest chips, plus Show more while pages remain.
  Widget buildTabContent(BuildContext context, GroupController c) {
    final items = c.publicProfileTabItems[c.publicProfileTab];
    if (items == null) {
      return c.publicProfileTabLoading ? tabShimmer(context, c.publicProfileTab) : tabMessage(context, "Couldn't load this tab", onRetry: c.loadPublicProfileTabItems);
    }
    if (items.isEmpty) return tabMessage(context, 'Nothing here yet');
    final Widget content = switch (items.first) {
      FeedPhoto() => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
        crossAxisSpacing: Dimensions.w_8,
        mainAxisSpacing: Dimensions.w_8,
        children: entranceList([
          for (final p in items.cast<FeedPhoto>()) AppCacheImage(imageUrl: p.image ?? '', size: double.infinity, widthSize: double.infinity, radius: Dimensions.h_8, isShadow: false),
        ]),
      ),
      // same cards as the Overview rows, two per line; heights match the Overview lists minus their bottom padding
      pp.GroupElement() => cardGrid(Dimensions.h_190, [for (final g in items.cast<pp.GroupElement>()) groupCard(context, g)]),
      pp.Activity() => cardGrid(Dimensions.h_230, [for (final (i, a) in items.cast<pp.Activity>().indexed) activityCard(context, c, a, i)]),
      FeedDiscussion() => Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
        child: Column(
          children: entranceList([
            for (final (i, d) in items.cast<FeedDiscussion>().indexed) ...[if (i > 0) Divider(height: Dimensions.h_25, color: AppColor.border(context)), discussionRow(context, c, d)],
          ]),
        ),
      ),
      _ => const SizedBox.shrink(),
    };
    // keyed by tab so switching tabs plays the entrance again instead of reusing the previous tab's animations
    return KeyedSubtree(
      key: ValueKey(c.publicProfileTab),
      child: Column(
        children: [
          content,
          if (c.publicProfileTabHasMore)
            c.publicProfileTabLoading
                ? Padding(padding: EdgeInsets.all(Dimensions.h_12), child: const CupertinoActivityIndicator())
                : TextButton(
                    onPressed: c.loadPublicProfileTabItems,
                    child: Text(
                      'Show more',
                      style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                    ),
                  ),
        ],
      ),
    );
  }

  // loading placeholder shaped like the tab's real layout: card grid, thread rows or photo grid
  Widget tabShimmer(BuildContext context, String tab) {
    Widget lines(List<double> widths) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (i, w) in widths.indexed) ...[if (i > 0) SizedBox(height: Dimensions.h_6), ShimmerBox(w, Dimensions.h_10)],
      ],
    );
    Widget card(double imageHeight) => Container(
      padding: EdgeInsets.all(Dimensions.w_6),
      decoration: BoxDecoration(color: AppColor.surface(context), borderRadius: BorderRadius.circular(Dimensions.h_8), boxShadow: shadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(double.infinity, imageHeight, radius: Dimensions.h_8),
          SizedBox(height: Dimensions.h_10),
          lines([Dimensions.w_120, Dimensions.w_80]),
          const Spacer(),
          ShimmerBox(Dimensions.w_60, Dimensions.h_10),
        ],
      ),
    );
    final padded = EdgeInsets.symmetric(horizontal: Dimensions.w_10);
    return switch (tab) {
      'groups' => cardGrid(Dimensions.h_190, [for (var i = 0; i < 4; i++) card(Dimensions.h_110)]),
      'activities' => cardGrid(Dimensions.h_230, [for (var i = 0; i < 4; i++) card(Dimensions.h_100)]),
      'photos' => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: padded,
        crossAxisSpacing: Dimensions.w_8,
        mainAxisSpacing: Dimensions.w_8,
        children: [for (var i = 0; i < 4; i++) ShimmerBox(double.infinity, double.infinity, radius: Dimensions.h_8)],
      ),
      'discussions' => Padding(
        padding: padded,
        child: Column(
          children: [
            for (var i = 0; i < 3; i++) ...[
              if (i > 0) Divider(height: Dimensions.h_25, color: AppColor.border(context)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(Dimensions.h_30, Dimensions.h_30, isCircle: true),
                  SizedBox(width: Dimensions.w_10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        lines([Dimensions.w_150, Dimensions.w_100]),
                        SizedBox(height: Dimensions.h_10),
                        ShimmerBox(Dimensions.w_220, Dimensions.h_15),
                        SizedBox(height: Dimensions.h_8),
                        lines([double.infinity, double.infinity, Dimensions.w_160]),
                        SizedBox(height: Dimensions.h_10),
                        ShimmerBox(Dimensions.w_80, Dimensions.h_10),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }

  Widget cardGrid(double height, List<Widget> cards) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(Dimensions.w_10, 0, Dimensions.w_10, Dimensions.h_12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: height, crossAxisSpacing: Dimensions.w_12, mainAxisSpacing: Dimensions.h_12),
      children: entranceList(cards),
    );
  }

  Widget tabMessage(BuildContext context, String text, {VoidCallback? onRetry}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_30),
      child: Center(
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_12, fontWeight: FontWeight.w600),
            ),
            if (onRetry != null)
              TextButton(
                onPressed: onRetry,
                child: Text(
                  'Try again',
                  style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// A discussion as a boxless thread row: the author's avatar, who posted where and when, the post, and its replies.
  Widget discussionRow(BuildContext context, GroupController c, FeedDiscussion d) {
    final profile = c.publicProfile!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCacheImage(imageUrl: profile.avatar ?? '', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true, isShadow: false),
        SizedBox(width: Dimensions.w_10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: profile.name ?? '',
                      style: TextStyle(color: Theme.of(context).highlightColor, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(text: '  ·  ${d.dateLabel ?? ''}'),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
              ),
              if (d.group?.isNotEmpty == true) ...[
                SizedBox(height: Dimensions.h_3),
                Row(
                  children: [
                    Icon(CupertinoIcons.person_2_fill, size: Dimensions.h_10, color: AppColor.blue(context)),
                    SizedBox(width: Dimensions.w_4),
                    Flexible(
                      child: Text(
                        d.group!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: Dimensions.h_8),
              Text(
                d.title ?? '',
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800, height: 1.3, letterSpacing: -0.3),
              ),
              if (d.description?.trim().isNotEmpty == true) ...[
                SizedBox(height: Dimensions.h_5),
                Text(
                  // posts come with blank lines between paragraphs; one line break reads tighter in a preview
                  d.description!.trim().replaceAll(RegExp(r'(\r?\n)+'), '\n'),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Theme.of(context).highlightColor.withValues(alpha: 0.75), fontSize: FontSize.sp_11, height: 1.5),
                ),
              ],
              SizedBox(height: Dimensions.h_10),
              Row(
                children: [
                  Icon(CupertinoIcons.chat_bubble_2, size: Dimensions.h_15, color: AppColor.muted(context)),
                  SizedBox(width: Dimensions.w_5),
                  Text(
                    (d.replies ?? 0) == 0 ? 'No replies yet' : '${d.replies} ${d.replies == 1 ? 'reply' : 'replies'}',
                    style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTabs(BuildContext context, GroupController c) {
    return SizedBox(
      height: Dimensions.h_28,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
        itemCount: c.publicProfileTabs.length,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_8),
        itemBuilder: (context, i) {
          final tab = c.publicProfileTabs[i];
          final selected = c.publicProfileTab == tab.id;
          return GestureDetector(
            onTap: () => c.selectPublicProfileTab(tab.id ?? 'overview'),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
              decoration: BoxDecoration(
                color: selected ? AppColor.blue(context) : AppColor.surface(context),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: selected ? AppColor.blue(context) : AppColor.border(context)),
              ),
              child: Text(
                tab.label ?? '',
                style: TextStyle(color: selected ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildActivities(BuildContext context, GroupController c) {
    return SizedBox(
      height: Dimensions.h_250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(Dimensions.w_10, 0, Dimensions.w_10, Dimensions.h_20),
        itemCount: c.publicProfileFeed!.upcomingActivities!.length,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_12),
        itemBuilder: (context, i) {
          final a = c.publicProfileFeed!.upcomingActivities![i];
          final id = a.id ?? '$i';
          final liked = c.likedProfileActivities.contains(id);
          final joined = c.joinedProfileActivities.contains(id);
          return Container(
            width: Dimensions.w_200,
            padding: EdgeInsets.all(Dimensions.w_8),
            decoration: BoxDecoration(color: AppColor.surface(context), borderRadius: BorderRadius.circular(Dimensions.h_8), boxShadow: shadow),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AppCacheImage(imageUrl: a.image ?? '', size: Dimensions.h_120, widthSize: Get.width, radius: Dimensions.h_8, isShadow: false),
                    Positioned(
                      left: Dimensions.w_8,
                      top: Dimensions.h_8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_4),
                        decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                        child: Column(
                          children: [
                            Text(
                              a.monthLabel ?? '',
                              style: TextStyle(color: AppColor.orange(context), fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, letterSpacing: 0.5, height: 1.1),
                            ),
                            Text(
                              a.dayLabel ?? '',
                              style: TextStyle(color: AppColor.textPrimary, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1.1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: Dimensions.w_8,
                      top: Dimensions.h_8,
                      child: Semantics(
                        button: true,
                        label: liked ? 'Unlike' : 'Like',
                        child: GestureDetector(
                          onTap: () => c.toggleLikeProfileActivity(id),
                          child: Container(
                            width: Dimensions.h_20,
                            height: Dimensions.h_20,
                            decoration: const BoxDecoration(color: AppColor.white, shape: BoxShape.circle),
                            child: Icon(liked ? CupertinoIcons.heart_fill : CupertinoIcons.heart, size: Dimensions.h_13, color: liked ? AppColor.error : AppColor.textPrimary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.w_6, Dimensions.h_5, Dimensions.w_6, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        a.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, letterSpacing: -0.3),
                      ),
                      SizedBox(height: Dimensions.h_4),
                      Text(
                        a.group ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_10),
                      ),
                      SizedBox(height: Dimensions.h_2),
                      Text(
                        [a.shortDateLabel, a.timeLabel].whereType<String>().join(' · '),
                        style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_10),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.w_6, 0, 0, Dimensions.h_2),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          a.location ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_9),
                        ),
                      ),
                      SizedBox(width: Dimensions.w_8),
                      GestureDetector(
                        onTap: () => c.toggleJoinProfileActivity(id),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
                          decoration: BoxDecoration(color: joined ? AppColor.blue(context) : AppColor.blueSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_12)),
                          child: Text(
                            joined ? 'Joined' : 'Join',
                            style: TextStyle(color: joined ? AppColor.white : AppColor.blue(context), fontSize: FontSize.sp_13, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget groupCard(BuildContext context, pp.GroupElement g) {
    return Container(
      padding: EdgeInsets.all(Dimensions.w_6),
      decoration: BoxDecoration(color: AppColor.surface(context), borderRadius: BorderRadius.circular(Dimensions.h_8), boxShadow: shadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCacheImage(imageUrl: g.image ?? '', size: Dimensions.h_110, widthSize: Get.width, radius: Dimensions.h_8, isShadow: false),
          Padding(
            padding: EdgeInsets.fromLTRB(Dimensions.w_4, Dimensions.h_10, Dimensions.w_4, 0),
            child: Text(
              g.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1.25, letterSpacing: -0.2),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.fromLTRB(Dimensions.w_4, 0, 0, Dimensions.h_2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    g.memberCountLabel ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700),
                  ),
                ),
                if (g.status?.isNotEmpty == true)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_3),
                    decoration: BoxDecoration(color: AppColor.blueSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                    child: Text(
                      g.status!,
                      style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGroups(BuildContext context, GroupController c) {
    return SizedBox(
      height: Dimensions.h_210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(Dimensions.w_10, 0, Dimensions.w_10, Dimensions.h_20),
        itemCount: c.publicProfile!.groups!.length,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_12),
        itemBuilder: (context, i) {
          return SizedBox(width: Dimensions.w_150, child: groupCard(context, c.publicProfile!.groups![i]));
        },
      ),
    );
  }

  Widget activityCard(BuildContext context, GroupController c, pp.Activity r, int i) {
    final id = r.id ?? '$i';
    final liked = c.likedProfileActivities.contains(id);
    return Container(
      padding: EdgeInsets.all(Dimensions.w_6),
      decoration: BoxDecoration(color: AppColor.surface(context), borderRadius: BorderRadius.circular(Dimensions.h_8), boxShadow: shadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppCacheImage(imageUrl: r.image ?? '', size: Dimensions.h_100, widthSize: Get.width, radius: Dimensions.h_8, isShadow: false),
              if (r.status?.isNotEmpty == true)
                Positioned(
                  left: Dimensions.w_6,
                  top: Dimensions.h_6,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_4),
                    decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(99)),
                    child: Text(
                      r.status!,
                      style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_9, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(Dimensions.w_4, Dimensions.h_8, Dimensions.w_4, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  [r.shortDateLabel ?? r.dateLabel, r.group?.name].whereType<String>().join(' · '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: Dimensions.h_4),
                Text(
                  r.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, letterSpacing: -0.3),
                ),
                SizedBox(height: Dimensions.h_4),
                Text(
                  r.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_10, height: 1.4),
                ),
              ],
            ),
          ),
          const Spacer(),
          Divider(height: 1, color: AppColor.border(context)),
          SizedBox(height: Dimensions.h_8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => c.toggleLikeProfileActivity(id),
                  child: Row(
                    children: [
                      Icon(liked ? CupertinoIcons.heart_fill : CupertinoIcons.heart, size: Dimensions.h_13, color: liked ? AppColor.error : AppColor.ink(context)),
                      SizedBox(width: Dimensions.w_4),
                      Text(
                        '${(r.likes ?? 0) + (liked ? 1 : 0)}',
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Dimensions.w_15),
                Icon(CupertinoIcons.chat_bubble, size: Dimensions.h_13, color: AppColor.ink(context)),
                SizedBox(width: Dimensions.w_4),
                Text(
                  '${r.comments ?? 0}',
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h_4),
        ],
      ),
    );
  }

  Widget buildRecent(BuildContext context, GroupController c) {
    final activities = c.publicProfile!.activities!;
    final cardWidth = (Get.width - Dimensions.w_10 * 2 - Dimensions.w_12) / 2;
    return SizedBox(
      height: Dimensions.h_250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(Dimensions.w_10, 0, Dimensions.w_10, Dimensions.h_20),
        itemCount: activities.length,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_12),
        itemBuilder: (context, i) {
          return SizedBox(width: cardWidth, child: activityCard(context, c, activities[i], i));
        },
      ),
    );
  }

  Widget buildInterests(BuildContext context, List<pp.Interest> interests) {
    // the API sends no interest colors, so cycle through these
    final colors = [AppColor.blue(context), AppColor.orange(context), AppColor.green(context), AppColor.violet(context)];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
      child: Wrap(
        spacing: Dimensions.w_5,
        runSpacing: Dimensions.h_5,
        children: [
          for (final (i, it) in interests.indexed)
            Container(
              padding: EdgeInsets.fromLTRB(Dimensions.w_4, Dimensions.h_4, Dimensions.w_8, Dimensions.h_4),
              decoration: BoxDecoration(
                color: AppColor.surface(context),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: AppColor.border(context)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: Dimensions.h_18,
                    height: Dimensions.h_18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: colors[i % colors.length].withValues(alpha: 0.12), shape: BoxShape.circle),
                    child: Icon(Icons.circle, size: Dimensions.h_8, color: colors[i % colors.length]),
                  ),
                  SizedBox(width: Dimensions.w_8),
                  Text(
                    it.name ?? '',
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildPhotos(BuildContext context, GroupController c) {
    final photos = [for (final p in c.publicProfileFeed!.photos!) p.image ?? ''];
    final more = photos.length - 3;
    final outer = Radius.circular(Dimensions.h_20);
    final inner = Radius.circular(Dimensions.h_8);
    Widget photo(String url, BorderRadius radius) => ClipRRect(
      borderRadius: radius,
      child: AppCacheImage(imageUrl: url, size: double.infinity, widthSize: double.infinity, isShadow: false),
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: SizedBox(
        height: photos.length < 3 ? Dimensions.h_150 : Dimensions.h_230,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: photos.length < 3
              ? [
                  for (final (i, url) in photos.indexed) ...[if (i > 0) SizedBox(width: Dimensions.w_8), Expanded(child: photo(url, BorderRadius.circular(Dimensions.h_20)))],
                ]
              : [
                  Expanded(
                    flex: 2,
                    child: photo(photos[0], BorderRadius.only(topLeft: outer, bottomLeft: outer, topRight: inner, bottomRight: inner)),
                  ),
                  SizedBox(width: Dimensions.w_8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: photo(photos[1], BorderRadius.only(topRight: outer, topLeft: inner, bottomLeft: inner, bottomRight: inner)),
                        ),
                        SizedBox(height: Dimensions.h_8),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(bottomRight: outer, topLeft: inner, topRight: inner, bottomLeft: inner),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AppCacheImage(imageUrl: photos[2], size: double.infinity, widthSize: double.infinity, isShadow: false),
                                if (more > 0)
                                  Container(
                                    color: AppColor.black.withValues(alpha: 0.5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '+$more',
                                      style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_20, fontWeight: FontWeight.w800),
                                    ),
                                  ),
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
    );
  }
}
