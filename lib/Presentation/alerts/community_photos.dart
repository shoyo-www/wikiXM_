import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/alerts/alerts_controller.dart';
import 'package:wikixm/Presentation/alerts/alerts_home.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_dropdown.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_tabs.dart';
import 'package:wikixm/Presentation/widgets/entrance_animation.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';

class CommunityPhotos extends StatelessWidget with AlertsUi {
  const CommunityPhotos({super.key});

  AlertsController get controller => Get.find<AlertsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlertsController>(
      init: controller,
      id: ControllerBuilders.communityPhotos,
      builder: (c) => CommonScrollBlurScaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        collapsedColor: Theme.of(context).highlightColor,
        showBack: true,
        actions: [(c.communityBookmarked ? 'bookmark.fill' : 'bookmark', c.communityBookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark, c.toggleCommunityBookmark), ('square.and.arrow.up', CupertinoIcons.share, c.share)],
        expandedHeight: Dimensions.h_250,
        hero: buildHero(context, c),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_8, Dimensions.w_8, Dimensions.h_10),
              child: Column(
                children: [
                  EntranceAnimation(
                    child: CategoryTabs(tabs: [for (final t in AlertsController.photoTabs) (title: t.title, subtitle: '${c.photoCount(t.title)} photos', icon: t.icon, color: AppColor.blue(context))], selected: c.photoTab, onTap: c.selectPhotoTab),
                  ),
                  SizedBox(height: Dimensions.h_6),
                  EntranceAnimation(index: 1, child: sortDropdown(context, c)),
                ],
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.fromLTRB(Dimensions.w_8, 0, Dimensions.w_8, MediaQuery.paddingOf(context).bottom + Dimensions.h_20), sliver: photoGrid(context, c)),
        ],
      ),
    );
  }

  Widget sortDropdown(BuildContext context, AlertsController c) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            c.galleryPhotosLabel,
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          width: Dimensions.w_110,
          child: CommonDropdown<String>(items: AlertsController.photoSorts, value: c.photoSort, height: Dimensions.h_28, fontSize: FontSize.sp_10, radius: Dimensions.h_6, onChanged: c.selectPhotoSort),
        ),
      ],
    );
  }

  Widget photoGrid(BuildContext context, AlertsController c) {
    final photos = c.visiblePhotos;
    return SliverGrid.builder(
      itemCount: photos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_8, mainAxisSpacing: Dimensions.h_10, mainAxisExtent: Dimensions.h_240),
      itemBuilder: (context, i) => i < 4 ? EntranceAnimation(index: i + 1, child: photoCard(context, c, photos[i], i)) : photoCard(context, c, photos[i], i),
    );
  }

  Color badgeColor(String? tone) => switch (tone) {
    'blue' => AppColor.civicBlue,
    'violet' => AppColor.intelligencePurple,
    _ => AppColor.darkGreen,
  };

  IconData badgeIcon(String? badge) => switch (badge) {
    'Editorial' => CupertinoIcons.pencil,
    'Community' => CupertinoIcons.person_2_fill,
    _ => CupertinoIcons.checkmark_seal_fill,
  };

  Widget photoCard(BuildContext context, AlertsController c, Map<String, dynamic> p, int i) {
    final blue = AppColor.blue(context);
    final ink = Theme.of(context).highlightColor;
    final muted = AppColor.muted(context);
    Widget stat(IconData icon, int n) => Row(
      children: [
        Icon(icon, size: Dimensions.h_13, color: blue),
        SizedBox(width: Dimensions.w_4),
        Text(
          '$n',
          style: TextStyle(color: blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
        ),
      ],
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => c.openCommunityPhoto(i),
      child: CommonCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.h_8)),
                  child: AppCacheImage(imageUrl: p['image'], radius: 0, widthSize: Get.width, size: Dimensions.h_120, fit: BoxFit.cover),
                ),
                Positioned(
                  left: Dimensions.w_6,
                  top: Dimensions.h_6,
                  child: pill(context, p['badge'], AppColor.white, badgeColor(p['badgeTone']), icon: badgeIcon(p['badge']), fontSize: FontSize.sp_8_5),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(Dimensions.w_5, Dimensions.h_8, Dimensions.w_5, Dimensions.h_6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ink, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1.2, letterSpacing: -0.2),
                    ),
                    SizedBox(height: Dimensions.h_4),
                    Text(
                      p['body'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ink, fontSize: FontSize.sp_9_5, height: 1.35),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(CupertinoIcons.person, size: Dimensions.h_12, color: muted),
                        SizedBox(width: Dimensions.w_3),
                        Expanded(
                          child: Text(
                            '${p['author']} · ${p['time']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: muted, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: Dimensions.h_12, thickness: 0.5, color: AppColor.border(context)),
                    Row(children: [stat(CupertinoIcons.chat_bubble_2, p['comments']), const Spacer(), stat(CupertinoIcons.hand_thumbsup, p['likes'])]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHero(BuildContext context, AlertsController c) {
    final fade = Theme.of(context).brightness == Brightness.light ? AppColor.softBackground : AppColor.backgroundDark;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: CarouselSlider.builder(
            controller: c.communityCarousel,
            itemCount: c.photos.length,
            itemBuilder: (context, i, _) => AppCacheImage(imageUrl: c.photos[i]['image']!, widthSize: Get.width, size: Dimensions.h_330, fit: BoxFit.cover, isShadow: false, radius: 0),
            options: CarouselOptions(height: double.infinity, viewportFraction: 1, autoPlay: true, autoPlayInterval: const Duration(seconds: 5), onPageChanged: (i, _) => c.onCommunityPhotoChanged(i)),
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
                    SizedBox(height: Dimensions.h_8),
                    Text(
                      'Community photo\nGallery',
                      style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_30, fontWeight: FontWeight.w900, letterSpacing: -0.5, height: 1.1, shadows: AlertsHome.heroShadow),
                    ),
                    SizedBox(height: Dimensions.h_10),
                    Text(
                      'Photos from local residents, editorial coverage, and official-source examples. Explore the valley and share what you see.',
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
                    onTap: c.toggleCommunityFollow,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                      height: Dimensions.h_25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: c.communityFollowing ? AppColor.white : AppColor.blue(context), borderRadius: BorderRadius.circular(Dimensions.h_6)),
                      child: Row(
                        children: [
                          Icon(c.communityFollowing ? CupertinoIcons.bell_fill : CupertinoIcons.bell, color: c.communityFollowing ? AppColor.blue(context) : AppColor.white, size: Dimensions.h_12),
                          SizedBox(width: Dimensions.w_4),
                          Text(
                            c.communityFollowing ? 'Following' : 'Follow gallery',
                            style: TextStyle(color: c.communityFollowing ? AppColor.blue(context) : AppColor.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
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
                        width: i == c.communityPhotoIndex ? Dimensions.w_12 : Dimensions.w_4,
                        height: Dimensions.h_4,
                        decoration: BoxDecoration(
                          color: AppColor.white.withValues(alpha: i == c.communityPhotoIndex ? 1 : 0.5),
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
}
