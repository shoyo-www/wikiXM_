import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/town_search.dart';
import 'package:wikixm/approutes.dart';

import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../widgets/cache_image.dart';

class FirstVisit extends StatelessWidget {
  const FirstVisit({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      top: false,
      bodyPadding: EdgeInsets.zero,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AppCacheImage(
                  size: Dimensions.h_290,
                  imageUrl: Images.firstVisitSeattle,
                  isShadow: false,
                  fit: BoxFit.cover,
                  widthSize: Get.width,
                ),
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xE6020B15),
                          Color(0x99020B15),
                          Color(0x00000000),
                          Color(0x00000000),
                        ],
                        stops: [0, 0.4, 0.78, 1],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Dimensions.h_50,
                    left: Dimensions.w_10,
                    right: Dimensions.w_10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image.asset(Images.appLogoGif,height: Dimensions.h_50,width: Dimensions.h_50),
                      Text(
                        'Your town.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Your voice.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_3),
                      Text(
                        'News your way. Community first.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_8),
                      Row(
                        children: [
                          Icon(CupertinoIcons.book, size: Dimensions.h_10),
                          SizedBox(width: Dimensions.w_4),
                          Text(
                            'Stay informed about what matters.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.sp_9,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_3),
                      Row(
                        children: [
                          Icon(CupertinoIcons.chat_bubble, size: Dimensions.h_10),
                          SizedBox(width: Dimensions.w_4),
                          Text(
                            'Share your voice in Town Talk.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.sp_9,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_3),
                      Row(
                        children: [
                          Icon(CupertinoIcons.heart, size: Dimensions.h_10),
                          SizedBox(width: Dimensions.w_4),
                          Text(
                            'Help shape the future of your community.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.sp_9,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_15),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: ()=> TownSearch.show(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_30,
                            vertical: Dimensions.h_6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(Dimensions.h_4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                CupertinoIcons.location_solid,
                                size: Dimensions.h_12,
                              ),
                              SizedBox(width: Dimensions.w_2),
                              Text(
                                'Find My Town',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.h_8),
                      GestureDetector(
                        onTap: ()=> Get.toNamed(AppRoutes.dashboard),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_23,
                            vertical: Dimensions.h_6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(Dimensions.h_4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                CupertinoIcons.eye_fill,
                                size: Dimensions.h_12,
                                color: Colors.black87,
                              ),
                              SizedBox(width: Dimensions.w_5),
                              Text(
                                'Browse as Guest',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: FontSize.sp_10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.h_8),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: ()=> Get.toNamed(AppRoutes.signIn),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: Dimensions.w_15),
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize.sp_9,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(width: Dimensions.w_4),
                            Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: FontSize.sp_9,
                                fontWeight: FontWeight.w900,
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
                      height: Dimensions.h_30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -4,
                  child: IgnorePointer(
                    child: Container(
                      height: Dimensions.h_20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.w_6,right: Dimensions.w_6),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: Dimensions.w_5,
                crossAxisSpacing: Dimensions.w_5,
                childAspectRatio: 2.4,
                children: const [
                  _ExploreCard(
                    image: Images.firstVisitLocalNews,
                    title: 'LOCAL NEWS',
                    subtitle: 'Real stories.\nReal people.',
                    icon: Icons.article_rounded,
                    iconColor: Color(0xFF2563EB),
                  ),
                  _ExploreCard(
                    image: Images.firstVisitSeattle,
                    title: 'WEATHER',
                    subtitle: 'Live updates.\nPlan your day.',
                    icon: CupertinoIcons.cloud_sun_fill,
                    iconColor: Color(0xFF1D4ED8),
                  ),
                  _ExploreCard(
                    image: Images.firstVisitTownTalk,
                    title: 'TOWN TALK',
                    subtitle: 'Conversations\nthat matter.',
                    icon: CupertinoIcons.chat_bubble_fill,
                    iconColor: Color(0xFF16A34A),
                  ),
                  _ExploreCard(
                    image: Images.firstVisitTownHall,
                    title: 'TOWN HALL',
                    subtitle: 'Transparent.\nAccountable.',
                    icon: Icons.account_balance_rounded,
                    iconColor: Color(0xFF2563EB),
                  ),
                  _ExploreCard(
                    image: Images.firstVisitEvents,
                    title: 'EVENTS',
                    subtitle: "What's happening\nin your town.",
                    icon: Icons.calendar_month_rounded,
                    iconColor: Color(0xFF7E22CE),
                  ),
                  _ExploreCard(
                    image: Images.firstVisitTownMemory,
                    title: 'TOWN MEMORY',
                    subtitle: 'Discover the stories\nthat shaped us.',
                    icon: Icons.history_rounded,
                    iconColor: Color(0xFFF97316),
                    sepia: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_12,top: Dimensions.h_8),
              child: Row(
                children: [
                  Icon(CupertinoIcons.rocket_fill,size: Dimensions.h_15,color:  Colors.black87),
                  SizedBox(width: Dimensions.w_5),
                  Text(
                    "Join in minutes. It's free.",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: FontSize.sp_13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_6,top: Dimensions.h_12,right: Dimensions.w_6),
              child:IntrinsicHeight(
                child: Row(
                  children: [
                    buildStepCard(
                      step: 1,
                      icon: CupertinoIcons.location_solid,
                      title: "Find Your Town",
                      description: "Search by city, zip code, or use your location",
                      color: const Color(0xFF2563EB),
                    ),
                    SizedBox(width: Dimensions.w_4),
                    buildStepCard(
                      step: 2,
                      icon: CupertinoIcons.group_solid,
                      title: "Explore",
                      iconSize: Dimensions.h_22,
                      description: "Browse local news, weather and events",
                      color: const Color(0xFF16A34A),
                    ),
                    SizedBox(width: Dimensions.w_4),
                    buildStepCard(
                      step: 3,
                      icon: CupertinoIcons.chat_bubble,
                      title: "Join Conversation",
                      description: "Create a free account and join discussions",
                      color: const Color(0xFF9333EA),
                    ),
                    SizedBox(width: Dimensions.w_4),
                    buildStepCard(
                      step: 4,
                      icon: CupertinoIcons.star,
                      iconSize: Dimensions.h_16,
                      title: "Make an Impact",
                      description: "Share stories and strengthen your community",
                      color: const Color(0xFFF97316),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_6,top: Dimensions.h_8,right: Dimensions.w_6),
              child: buildCommunityPromise(),
            ),
            SizedBox(height: Dimensions.h_10),
            GestureDetector(
              onTap: ()=> Get.toNamed(AppRoutes.signUp),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                decoration: BoxDecoration(
                  color: Color(0xff01276b),
                  borderRadius: BorderRadius.circular(4)
                ),
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.h_6,
                  horizontal: Dimensions.w_8
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(Dimensions.h_3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff0354d6)
                      ),
                      child: Icon(CupertinoIcons.group_solid,color: Colors.white,size: Dimensions.h_18),
                    ),
                    SizedBox(width: Dimensions.w_10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Join WikiXM Today",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.sp_11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            "Create your free account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.sp_9_5,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,color: Colors.white,size: Dimensions.h_10)
                  ],
                ),
              ),
            ),
            SizedBox(height: Dimensions.h_20),
          ],
        ),
      ),
    );
  }

  Widget buildCommunityPromise() {
    final items = [
      {
        "icon": Icons.verified_user_outlined,
        "color": const Color(0xFF2563EB),
        "title": "Trusted",
        "subtitle": "by communities\nacross the country.",
        "desc": "Real people.\nReal impact."
      },
      {
        "icon": Icons.newspaper_outlined,
        "color": const Color(0xFF2563EB),
        "title": "Local Journalism",
        "subtitle": "Real reporting.",
        "desc": "Local impact."
      },
      {
        "icon": Icons.account_balance_outlined,
        "color": const Color(0xFF16A34A),
        "title": "Civic Transparency",
        "subtitle": "Open government.",
        "desc": "Stronger\ncommunities."
      },
      {
        "icon": Icons.groups_2_outlined,
        "color": const Color(0xFF9333EA),
        "title": "Community Voices",
        "subtitle": "Your voice.",
        "desc": "Your\nneighborhood."
      },
      {
        "icon": Icons.shield_outlined,
        "color": const Color(0xFFF97316),
        "title": "Safe & Respectful",
        "subtitle": "Moderated.",
        "desc": "Inclusive.\nCivil."
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_4),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(4),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: IntrinsicHeight(
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Row(
                children: [
                  SizedBox(
                    width: Dimensions.w_80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          item["icon"] as IconData,
                          color: item["color"] as Color,
                          size: Dimensions.h_20,
                        ),
                        SizedBox(height: Dimensions.h_2),
                        Text(
                          item["title"] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: FontSize.sp_9,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          item["subtitle"] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: FontSize.sp_8,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        // SizedBox(height: Dimensions.h_2),
                        // Text(
                        //   item["desc"] as String,
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     fontSize: FontSize.sp_7,
                        //     color: Colors.grey.shade700,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  if (index != items.length - 1)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                      width: 0.5,
                      color: Colors.grey.shade500,
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
  Widget buildStepCard({
    required int step,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    double? iconSize
  }) {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.w_3,
              right: Dimensions.w_3,
              top: Dimensions.h_8,
              bottom: Dimensions.h_3,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.h_4),
              border: Border.all(color: Colors.grey, width: 0.3)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: iconSize ?? Dimensions.h_18,
                  color: color
                ),
                SizedBox(height: Dimensions.h_2),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: FontSize.sp_9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: Dimensions.h_1),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: FontSize.sp_8_5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -Dimensions.h_8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: Dimensions.h_16,
                width: Dimensions.h_16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: Center(
                  child: Text(
                    '$step',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: FontSize.sp_12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreCard extends StatelessWidget {
  const _ExploreCard({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.sepia = false,
  });

  final String image;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool sepia;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.w_5),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            color: sepia ? const Color(0x99704A2A) : null,
            colorBlendMode: sepia ? BlendMode.color : null,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xE6000718),
                  Color(0x99000718),
                  Color(0x11000718),
                ],
                stops: [0, 0.55, 1],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.w_8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Dimensions.w_23,
                  height: Dimensions.w_23,
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(Dimensions.w_4),
                  ),
                  child: Icon(icon, color: Colors.white, size: Dimensions.w_15),
                ),
                SizedBox(width: Dimensions.w_6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_3),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_9,
                          height: 1.35,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: Dimensions.w_6,
            bottom: Dimensions.h_6,
            child: Container(
              width: Dimensions.w_20,
              height: Dimensions.w_20,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x66000000),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                CupertinoIcons.chevron_right,
                size: Dimensions.w_10,
                color: const Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
