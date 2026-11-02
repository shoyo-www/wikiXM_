import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/widgets/common_blur_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/cache_image.dart';
import '../widgets/entrance_animation.dart';

class PublicProfile extends StatelessWidget {
  const PublicProfile({super.key});

  GroupController get controller => Get.put(GroupController());

  static const dateAccent = Color(0xFFB4501F);
  static final shadow = [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 2, offset: const Offset(0, 1)), BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 24, offset: const Offset(0, 8))];

  ({Color bg, Color card, Color ink, Color muted, Color line, Color accent, Color tint}) palette(BuildContext context) {
    final light = Theme.of(context).brightness == Brightness.light;
    return (
      bg: light ? const Color(0xFFF3F4F1) : Theme.of(context).scaffoldBackgroundColor,
      card: light ? Colors.white : Theme.of(context).cardColor,
      ink: light ? const Color(0xFF111816) : Theme.of(context).highlightColor,
      muted: light ? const Color(0xFF5C6661) : Colors.white60,
      line: light ? const Color(0xFFE3E6E1) : Colors.white12,
      accent: AppColor.blue(context),
      tint: AppColor.blueSoft(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = palette(context);
    return CommonBlurScaffold(
      showBack: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      collapsedColor: p.ink,
      child: DefaultTextStyle.merge(
        style: GoogleFonts.plusJakartaSans(),
        child: GetBuilder<GroupController>(
          init: controller,
          id: ControllerBuilders.publicProfile,
          builder: (c) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: staggered([
              buildHero(context, c),
              SizedBox(height: Dimensions.h_15),
              buildActions(context, c),
              SizedBox(height: Dimensions.h_15),
              buildStats(context, c),
              SizedBox(height: Dimensions.h_15),
              buildTabs(context, c),
              SizedBox(height: Dimensions.h_15),
              sectionHeader(context, 'Recent activity'),
              buildRecent(context, c),
              SizedBox(height: Dimensions.h_15),
              sectionHeader(context, 'Groups', count: c.publicProfile['stats'][0]['value']),
              buildGroups(context, c),
              sectionHeader(context, 'Upcoming activities'),
              buildActivities(context, c),
              sectionHeader(context, 'Interests', seeAll: false),
              buildInterests(context, c),
              SizedBox(height: Dimensions.h_15),
              sectionHeader(context, 'Photos'),
              buildPhotos(context, c),
              SizedBox(height: MediaQuery.of(context).padding.bottom + Dimensions.h_40),
            ]),
          ),
        ),
      ),
    );
  }

  Widget sectionHeader(BuildContext context, String title, {String? count, bool seeAll = true}) {
    final p = palette(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(Dimensions.w_10, 0, Dimensions.w_10, Dimensions.h_12),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(color: p.ink, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800, letterSpacing: -0.5),
          ),
          if (count != null)
            Text(
              ' · $count',
              style: TextStyle(color: p.muted, fontSize: FontSize.sp_14, fontWeight: FontWeight.w600, letterSpacing: -0.5),
            ),
          const Spacer(),
          if (seeAll)
            Text(
              'See all',
              style: TextStyle(color: p.accent, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
            ),
        ],
      ),
    );
  }

  Widget stackedAvatars(BuildContext context, List urls, {String? more}) {
    final size = Dimensions.h_20;
    final count = urls.length + (more != null ? 1 : 0);
    return SizedBox(
      width: size + (count - 1) * size * 0.65,
      height: size,
      child: Stack(
        children: [
          for (final (i, url) in urls.indexed)
            Positioned(
              left: i * size * 0.65,
              child: AppCacheImage(imageUrl: url, size: size, widthSize: size, isCircle: true, borderColor: palette(context).card, borderWidth: 2, isShadow: false),
            ),
          if (more != null)
            Positioned(
              left: urls.length * size * 0.65,
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: palette(context).line,
                  shape: BoxShape.circle,
                  border: Border.all(color: palette(context).card, width: 2),
                ),
                child: Text(
                  more,
                  style: TextStyle(color: palette(context).ink, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildHero(BuildContext context, GroupController c) {
    final p = palette(context);
    final profile = c.publicProfile;
    final avatar = Dimensions.h_110;
    return Stack(
      children: [
        SizedBox(
          height: Dimensions.h_210,
          width: Get.width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppCacheImage(imageUrl: profile['cover'], size: Dimensions.h_260, widthSize: Get.width, isShadow: false),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black.withValues(alpha: 0.15), p.bg.withValues(alpha: 0.0), p.bg.withValues(alpha: 0.7), p.bg], stops: const [0.0, 0.4, 0.78, 1.0]),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimensions.h_180 - avatar * 0.75, left: Dimensions.w_10, right: Dimensions.w_10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.h_35),
                        border: Border.all(color: p.bg, width: 4),
                        boxShadow: shadow,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.h_32),
                        child: AppCacheImage(imageUrl: profile['avatar'], size: avatar, widthSize: avatar, isShadow: false),
                      ),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: Dimensions.h_20,
                        height: Dimensions.h_20,
                        decoration: BoxDecoration(
                          color: const Color(0xFF22A06B),
                          shape: BoxShape.circle,
                          border: Border.all(color: p.bg, width: 3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profile['name'],
                    style: TextStyle(color: p.ink, fontSize: FontSize.sp_26, fontWeight: FontWeight.w800, letterSpacing: -0.6),
                  ),
                  SizedBox(width: Dimensions.w_6),
                  Icon(Icons.verified_rounded, color: p.accent, size: Dimensions.h_20),
                ],
              ),
              SizedBox(height: Dimensions.h_6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_sharp, size: Dimensions.h_13, color: p.muted),
                  SizedBox(width: Dimensions.w_4),
                  Text(
                    profile['location'],
                    style: TextStyle(color: p.muted, fontSize: FontSize.sp_13, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                    child: Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(color: p.muted, shape: BoxShape.circle),
                    ),
                  ),
                  Icon(CupertinoIcons.globe, size: Dimensions.h_13, color: p.muted),
                  SizedBox(width: Dimensions.w_4),
                  Text(
                    'Public profile',
                    style: TextStyle(color: p.muted, fontSize: FontSize.sp_13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_12),
              Text(
                profile['bio'],
                textAlign: TextAlign.center,
                style: TextStyle(color: p.ink.withValues(alpha: 0.85), fontSize: FontSize.sp_12, height: 1.55),
              ),
              SizedBox(height: Dimensions.h_15),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: Dimensions.w_4,
                runSpacing: Dimensions.h_8,
                children: [
                  for (final (_, role) in (profile['roles'] as List).indexed)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_5),
                      decoration: BoxDecoration(
                        color:  p.card,
                        borderRadius: BorderRadius.circular(99),
                        border:  Border.all(color: p.line),
                      ),
                      child: Text(
                        role,
                        style: TextStyle(color: p.ink, fontSize: FontSize.sp_10, fontWeight:  FontWeight.w600),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildStats(BuildContext context, GroupController c) {
    final p = palette(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (final (i, st) in (c.publicProfile['stats'] as List).indexed) ...[
              if (i > 0) VerticalDivider(width: 1, thickness: 1, color: p.line),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      st['value'],
                      style: TextStyle(color: p.ink, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                    ),
                    SizedBox(height: Dimensions.h_2),
                    Text(
                      st['label'],
                      style: TextStyle(color: p.muted, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
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
    final p = palette(context);
    final following = c.isFollowingProfile;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: c.toggleFollowProfile,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                height: Dimensions.h_33,
                decoration: BoxDecoration(
                  color: following ? p.card : p.accent,
                  borderRadius: BorderRadius.circular(Dimensions.h_16),
                  border: Border.all(color: p.accent, width: 1.4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(following ? CupertinoIcons.checkmark_alt : CupertinoIcons.add, size: Dimensions.h_13, color: following ? p.accent : Colors.white),
                    SizedBox(width: Dimensions.w_5),
                    Text(
                      following ? 'Following' : 'Follow',
                      style: TextStyle(color: following ? p.accent : Colors.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_10),
          Expanded(
            child: Container(
              height: Dimensions.h_33,
              decoration: BoxDecoration(
                color: p.card,
                borderRadius: BorderRadius.circular(Dimensions.h_16),
                border: Border.all(color: p.line),
                boxShadow: shadow,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.chat_bubble, size: Dimensions.h_12, color: p.ink),
                  SizedBox(width: Dimensions.w_4),
                  Text(
                    'Message',
                    style: TextStyle(color: p.ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabs(BuildContext context, GroupController c) {
    final p = palette(context);
    return SizedBox(
      height: Dimensions.h_28,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
        itemCount: c.publicProfileTabs.length,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_8),
        itemBuilder: (context, i) {
          final selected = c.publicProfileTab == i;
          return GestureDetector(
            onTap: () => c.selectPublicProfileTab(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
              decoration: BoxDecoration(
                color: selected ? p.ink : p.card,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: selected ? p.ink : p.line),
              ),
              child: Text(
                c.publicProfileTabs[i],
                style: TextStyle(color: selected ? p.bg : p.ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildActivities(BuildContext context, GroupController c) {
    final p = palette(context);
    return SizedBox(
      height: Dimensions.h_250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(Dimensions.w_10, 0, Dimensions.w_10, Dimensions.h_20),
        itemCount: c.publicProfileActivities.length,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_12),
        itemBuilder: (context, i) {
          final a = c.publicProfileActivities[i];
          final liked = c.likedProfileActivities.contains(a['title']);
          final joined = c.joinedProfileActivities.contains(a['title']);
          return Container(
            width: Dimensions.w_200,
            padding: EdgeInsets.all(Dimensions.w_8),
            decoration: BoxDecoration(color: p.card, borderRadius: BorderRadius.circular(Dimensions.h_8), boxShadow: shadow),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AppCacheImage(imageUrl: a['image'], size: Dimensions.h_120, widthSize: Get.width, radius: Dimensions.h_8, isShadow: false),
                    Positioned(
                      left: Dimensions.w_8,
                      top: Dimensions.h_8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_4),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                        child: Column(
                          children: [
                            Text(
                              a['month'],
                              style: TextStyle(color: dateAccent, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800, letterSpacing: 0.5, height: 1.1),
                            ),
                            Text(
                              a['day'],
                              style: TextStyle(color: const Color(0xFF111816), fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1.1),
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
                          onTap: () => c.toggleLikeProfileActivity(a['title']),
                          child: Container(
                            width: Dimensions.h_20,
                            height: Dimensions.h_20,
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Icon(liked ? CupertinoIcons.heart_fill : CupertinoIcons.heart, size: Dimensions.h_13, color: liked ? const Color(0xFFDC2626) : const Color(0xFF111816)),
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
                        a['title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: p.ink, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, letterSpacing: -0.3),
                      ),
                      SizedBox(height: Dimensions.h_4),
                      Text(
                        a['group'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: p.muted, fontSize: FontSize.sp_10),
                      ),
                      SizedBox(height: Dimensions.h_2),
                      Text(
                        a['when'],
                        style: TextStyle(color: p.muted, fontSize: FontSize.sp_10),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.w_6, 0, 0, Dimensions.h_2),
                  child: Row(
                    children: [
                      stackedAvatars(context, c.publicProfile['attendees']),
                      SizedBox(width: Dimensions.w_8),
                      Text(
                        '${(a['going'] as int) + (joined ? 1 : 0)} going',
                        style: TextStyle(color: p.ink, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => c.toggleJoinProfileActivity(a['title']),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
                          decoration: BoxDecoration(color: joined ? p.accent : p.tint, borderRadius: BorderRadius.circular(Dimensions.h_12)),
                          child: Text(
                            joined ? 'Joined' : 'Join',
                            style: TextStyle(color: joined ? Colors.white : p.accent, fontSize: FontSize.sp_13, fontWeight: FontWeight.w800),
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

  Widget buildGroups(BuildContext context, GroupController c) {
    final p = palette(context);
    return SizedBox(
      height: Dimensions.h_210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(Dimensions.w_10, 0, Dimensions.w_10, Dimensions.h_20),
        itemCount: c.publicProfileGroups.length,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_12),
        itemBuilder: (context, i) {
          final g = c.publicProfileGroups[i];
          return Container(
            width: Dimensions.w_150,
            padding: EdgeInsets.all(Dimensions.w_6),
            decoration: BoxDecoration(color: p.card, borderRadius: BorderRadius.circular(Dimensions.h_8), boxShadow: shadow),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCacheImage(imageUrl: g['image'], size: Dimensions.h_110, widthSize: Get.width, radius: Dimensions.h_8, isShadow: false),
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.w_4, Dimensions.h_10, Dimensions.w_4, 0),
                  child: Text(
                    g['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: p.ink, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1.25, letterSpacing: -0.2),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.w_4, 0, 0, Dimensions.h_2),
                  child: Row(
                    children: [
                      Text(
                        g['members'],
                        style: TextStyle(color: p.muted, fontSize: FontSize.sp_12, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7, vertical: Dimensions.h_3),
                        decoration: BoxDecoration(color: p.tint, borderRadius: BorderRadius.circular(99)),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.checkmark_alt, size: Dimensions.h_10, color: p.accent),
                            SizedBox(width: Dimensions.w_2),
                            Text(
                              'Member',
                              style: TextStyle(color: p.accent, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                            ),
                          ],
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

  Widget buildRecent(BuildContext context, GroupController c) {
    final p = palette(context);
    final r = c.publicProfileRecent;
    final pill = BoxDecoration(color: p.line.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(99));
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      padding: EdgeInsets.all(Dimensions.w_8),
      decoration: BoxDecoration(color: p.card, borderRadius: BorderRadius.circular(Dimensions.h_8), boxShadow: shadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.h_8),
                child: AppCacheImage(imageUrl: r['image'], size: Dimensions.h_120, widthSize: Get.width, isShadow: false),
              ),
              Positioned(
                left: Dimensions.w_10,
                top: Dimensions.h_10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_5),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(99)),
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: Dimensions.h_7, color: const Color(0xFF22A06B)),
                      SizedBox(width: Dimensions.w_5),
                      Text(
                        'Attended',
                        style: TextStyle(color: p.accent, fontSize: FontSize.sp_9, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_12, Dimensions.w_8, Dimensions.h_6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r['meta'],
                  style: TextStyle(color: p.muted, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: Dimensions.h_4),
                Text(
                  r['title'],
                  style: TextStyle(color: p.ink, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800, letterSpacing: -0.4),
                ),
                SizedBox(height: Dimensions.h_4),
                Text(
                  r['caption'],
                  style: TextStyle(color: p.muted, fontSize: FontSize.sp_11, height: 1.5),
                ),
                SizedBox(height: Dimensions.h_12),
                Divider(height: 1, color: p.line),
                SizedBox(height: Dimensions.h_12),
                Row(
                  children: [
                    stackedAvatars(context, c.publicProfile['attendees'], more: '+${r['more']}'),
                    const Spacer(),
                    GestureDetector(
                      onTap: c.toggleLikeProfileRecent,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_7),
                        decoration: pill,
                        child: Row(
                          children: [
                            Icon(c.likedProfileRecent ? CupertinoIcons.heart_fill : CupertinoIcons.heart, size: Dimensions.h_15, color: c.likedProfileRecent ? const Color(0xFFDC2626) : p.ink),
                            SizedBox(width: Dimensions.w_5),
                            Text(
                              '${c.publicProfileLikes}',
                              style: TextStyle(color: p.ink, fontSize: FontSize.sp_13, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_7),
                      decoration: pill,
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.chat_bubble, size: Dimensions.h_15, color: p.ink),
                          SizedBox(width: Dimensions.w_5),
                          Text(
                            '${r['comments']}',
                            style: TextStyle(color: p.ink, fontSize: FontSize.sp_13, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
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

  Widget buildInterests(BuildContext context, GroupController c) {
    final p = palette(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
      child: Wrap(
        spacing: Dimensions.w_5,
        runSpacing: Dimensions.h_5,
        children: [
          for (final it in c.publicProfileInterests)
            Container(
              padding: EdgeInsets.fromLTRB(Dimensions.w_4, Dimensions.h_4, Dimensions.w_8, Dimensions.h_4),
              decoration: BoxDecoration(
                color: p.card,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: p.line),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: Dimensions.h_18,
                    height: Dimensions.h_18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Color(it['color'] as int).withValues(alpha: 0.12), shape: BoxShape.circle),
                    child: Icon(Icons.circle, size: Dimensions.h_8, color: Color(it['color'] as int)),
                  ),
                  SizedBox(width: Dimensions.w_8),
                  Text(
                    it['title'],
                    style: TextStyle(color: p.ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildPhotos(BuildContext context, GroupController c) {
    final photos = c.publicProfilePhotos;
    final outer = Radius.circular(Dimensions.h_20);
    final inner = Radius.circular(Dimensions.h_8);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: SizedBox(
        height: Dimensions.h_230,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: outer, bottomLeft: outer, topRight: inner, bottomRight: inner),
                child: AppCacheImage(imageUrl: photos[0], size: double.infinity, widthSize: double.infinity, isShadow: false),
              ),
            ),
            SizedBox(width: Dimensions.w_8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topRight: outer, topLeft: inner, bottomLeft: inner, bottomRight: inner),
                      child: AppCacheImage(imageUrl: photos[1], size: double.infinity, widthSize: double.infinity, isShadow: false),
                    ),
                  ),
                  SizedBox(height: Dimensions.h_8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomRight: outer, topLeft: inner, topRight: inner, bottomLeft: inner),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AppCacheImage(imageUrl: photos[2], size: double.infinity, widthSize: double.infinity, isShadow: false),
                          Container(
                            color: Colors.black.withValues(alpha: 0.5),
                            alignment: Alignment.center,
                            child: Text(
                              '+${c.publicProfileMorePhotos}',
                              style: TextStyle(color: Colors.white, fontSize: FontSize.sp_20, fontWeight: FontWeight.w800),
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
