import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupertino_native/components/button.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wikixm/Presentation/sports/sports_controller.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/Presentation/widgets/countdownWidget.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/data/datasource/local/local_storage.dart';
import '../../constants/constants.dart';
import '../../constants/extensions.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../dashboard/controller.dart';
import '../widgets/AnimatedImage.dart';
import '../widgets/cache_image.dart';
import '../widgets/circular_percent.dart';
import '../widgets/common_appbar.dart';
import '../widgets/sports_cards.dart';
import 'package:wikixm/data/datasource/remote/models/response/sports_response.dart';

import '../widgets/sports_community.dart';
import '../widgets/sports_event_item.dart';
import '../widgets/sports_item.dart';
import '../widgets/sports_screen_shimmer.dart';
import '../widgets/sports_stats.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({super.key});

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  final SportsController sportsController = Get.put(SportsController());
  bool isLight = LocalStorage.getBool(GetXStorageConstants.day);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        top: false,
        bottom: false,
        bodyPadding: EdgeInsets.zero,
        backgroundColor: context.sports.background,
        body:  GetBuilder(
          init: sportsController,
          id: ControllerBuilders.sportsController,
          builder: (controller) {
            return controller.isLoading ? SportsScreenShimmer(): CommonScrollBlurScaffold(
                expandedHeight: Dimensions.h_260,
                showBack: true,
                expandedColor: Colors.white,
                collapsedColor: Theme.of(context).highlightColor,
                hero: buildHeroHeader(isLight), slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: Dimensions.h_5),
                  ),
              SliverToBoxAdapter(child: firstCard()),
              SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.h_15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TODAY'S SPORTS SNAPSHOT",
                              style: TextStyle(
                                color: Theme.of(Get.context!).highlightColor,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            Text(
                              "See All",
                              style: TextStyle(
                                color: Theme.of(Get.context!).primaryColorDark,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_10),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              SportsStatCard(
                                icon: Icon(
                                  CupertinoIcons.photo,
                                  color: Theme.of(context).highlightColor,
                                  size: Dimensions.h_18,
                                ),
                                value: controller.getActivityCount('photos').toString(),
                                title: 'New Photos',
                              ),
                              SizedBox(width: Dimensions.w_6),
                              SportsStatCard(
                                icon: Icon(
                                  CupertinoIcons.chat_bubble_2,
                                  color: Theme.of(context).highlightColor,
                                  size: Dimensions.h_25,
                                ),
                                value: controller.getActivityCount('discussions').toString(),
                                title: 'New Discussions',
                              ),
                              SizedBox(width: Dimensions.w_6),
                              SportsStatCard(
                                icon: FaIcon(
                                  FontAwesomeIcons.trophy,
                                  color: Theme.of(context).highlightColor,
                                  size: Dimensions.h_16,
                                ),
                                value: controller.getActivityCount('nominations').toString(),
                                title: 'Athlete Nominations',
                              ),
                              SizedBox(width: Dimensions.w_6),
                              SportsStatCard(
                                icon: Icon(
                                  CupertinoIcons.chart_bar,
                                  color: Theme.of(context).highlightColor,
                                  size: Dimensions.h_18,
                                ),
                                value: controller.getActivityCount('predictions').toString(),
                                title: 'Fan Predictions',
                              ),
                            ],
                          ),
                        ),
                        GetBuilder(
                            init: sportsController,
                            id: ControllerBuilders.sportsController,
                            builder: (context) {
                              if(sportsController.sportsData?.upcomingGames?.games?.isEmpty ?? false || sportsController.isLoading) {
                                return SizedBox.shrink();
                              }
                              final game = sportsController.sportsData?.upcomingGames?.games?.first;
                              final targetDate = DateFormat('yyyy-MM-dd h:mm a').parse('${game?.date} ${game?.time}');
                              final remaining = targetDate.difference(DateTime.now());
                              final days = remaining.inDays;
                              final hours = remaining.inHours % 24;
                              final minutes = remaining.inMinutes % 60;
                              final seconds = remaining.inSeconds % 60;
                              return buildCountdown(days, hours, minutes, seconds, game, targetDate);
                            }
                        ),
                        SizedBox(height: Dimensions.h_15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SPOTLIGHT ATHLETES",
                              style: TextStyle(
                                color: Theme.of(Get.context!).highlightColor,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            Text(
                              "View All",
                              style: TextStyle(
                                color: Theme.of(Get.context!).primaryColorDark,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_8),
                        GetBuilder(
                            id: ControllerBuilders.sportsController,
                            init: sportsController,
                            builder: (context) {
                              return SizedBox(
                                height: Dimensions.h_180,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sportsController.sportsData?.communitySpotlight?.athletes?.length ?? 0,
                                  separatorBuilder: (_, __) => SizedBox(width: Dimensions.w_8),
                                  itemBuilder: (context, index) {
                                    final athlete = sportsController.sportsData?.communitySpotlight?.athletes?[index];
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
                                      width: Dimensions.w_135,
                                      decoration: BoxDecoration(
                                          color: index == 0 ? context.sports.cardActiveBackground : context.sports.card,
                                          borderRadius: BorderRadius.circular(Dimensions.h_6),
                                          border: Border.all(
                                              color:index == 0 ? context.sports.activeBorder : context.sports.border)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: Dimensions.h_4),
                                          Text(
                                            'Featured athlete'.toUpperCase(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: FontSize.sp_8,
                                                fontWeight: FontWeight.w900,
                                                color: AppColor.sportsActiveColor
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.h_6),
                                          AppCacheImage(
                                            imageUrl: athlete?.imageUrl ?? '',
                                            widthSize: Get.width,
                                            size: Dimensions.h_90,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                            radius: Dimensions.h_3,
                                            isShadow: false,
                                          ),
                                          SizedBox(height: Dimensions.h_4),
                                          Text(
                                            athlete?.name ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: FontSize.sp_12,
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context).highlightColor
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.h_4),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3),
                                            child: RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  color: Theme.of(context).highlightColor,
                                                  fontSize: FontSize.sp_9,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                children: [
                                                  TextSpan(text: athlete?.sport ?? ''),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.h_2),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3),
                                            child: Text(
                                              athlete?.schoolOrTeam ?? '',
                                              style: TextStyle(
                                                color: Theme.of(context).hintColor,
                                                fontSize: FontSize.sp_8_5,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            index == 4 ? '300 Votes': index == 3 ? '540 Votes':index == 2 ? '680 Votes':index == 1 ? '920 Votes':'1024 Votes',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: FontSize.sp_8_5,
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context).highlightColor
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.h_4),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                        ),
                        // SizedBox(height: Dimensions.h_15),
                        // Container(
                        //   padding: EdgeInsets.only(
                        //       top: Dimensions.h_10,
                        //       bottom: Dimensions.h_5
                        //   ),
                        //   decoration: BoxDecoration(
                        //     color: Get.context!.sports.card,
                        //       borderRadius: BorderRadius.circular(6),
                        //       border: Border.all(
                        //           color: Get.context!.sports.border,
                        //           width: 0.6
                        //       )
                        //   ),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Row(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         SizedBox(width: Dimensions.w_5),
                        //         Text(
                        //           "TODAY'S GAMES & EVENTS",
                        //           style: TextStyle(
                        //             color: Theme.of(Get.context!).highlightColor,
                        //             fontSize: FontSize.sp_11,
                        //             fontWeight: FontWeight.w600,
                        //             height: 1,
                        //           ),
                        //         ),
                        //         const Spacer(),
                        //         Text(
                        //           "View Full Schedule",
                        //           style: TextStyle(
                        //             color: Theme.of(Get.context!).primaryColorDark,
                        //             fontSize: FontSize.sp_9_5,
                        //             fontWeight: FontWeight.w500,
                        //             height: 1,
                        //           ),
                        //         ),
                        //         SizedBox(width: Dimensions.w_5),
                        //       ],
                        //     ),
                        //       SizedBox(height: Dimensions.h_3),
                        //       Container(
                        //         margin: EdgeInsets.symmetric(
                        //           vertical: Dimensions.h_7,
                        //         ),
                        //         color: Get.context!.sports.border,
                        //         height: 0.5,
                        //       ),
                        //       SportsEventItem(
                        //         time: '6:30 PM',
                        //         icon: Icons.sports_volleyball_sharp,
                        //         iconColor: const Color(0xff4f14d4),
                        //         title: 'Boys Basketball',
                        //         subtitle: 'vs. Memphis Tigers',
                        //         isLive: true,
                        //         showWatchLive: true,
                        //         onWatchLive: () {
                        //           // Watch live
                        //         },
                        //         onTap: () {
                        //           // Open game
                        //         },
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.symmetric(
                        //           vertical: Dimensions.h_7,
                        //         ),
                        //         color: Get.context!.sports.border,
                        //         height: 0.5,
                        //       ),
                        //       SportsEventItem(
                        //         time: '8:00 PM',
                        //         icon: Icons.sports_volleyball_sharp,
                        //         iconColor: const Color(0xff4f14d4),
                        //         title: 'Girls Soccer',
                        //         subtitle: 'vs. Oak Hills',
                        //         showWatchLive: true,
                        //         onWatchLive: () {
                        //           // Watch live
                        //         },
                        //         onTap: () {
                        //           // Open game
                        //         },
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.symmetric(
                        //           vertical: Dimensions.h_7,
                        //         ),
                        //         color: Get.context!.sports.border,
                        //         height: 0.5,
                        //       ),
                        //       SportsEventItem(
                        //         time: '8:00 PM',
                        //         icon: Icons.sports_volleyball_sharp,
                        //         iconColor: const Color(0xff4f14d4),
                        //         title: 'Swimming',
                        //         subtitle: 'vs. Riverdale',
                        //         onTap: () {
                        //           // Open event
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: Dimensions.h_15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TEAMS  HUBS",
                              style: TextStyle(
                                color: Theme.of(Get.context!).highlightColor,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            Text(
                              "View All Teams",
                              style: TextStyle(
                                color: Theme.of(Get.context!).primaryColorDark,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_8),
                        SizedBox(
                          height: Dimensions.h_290,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: (sportsController.sportsData?.teamHubs?.sports?.length ?? 0) > 5 ? 5: sportsController.sportsData?.teamHubs?.sports?.length ?? 0,
                            separatorBuilder: (_, __) =>
                                SizedBox(width: Dimensions.w_8),
                            itemBuilder: (context, index) {
                              final team = sportsController.sportsData?.teamHubs?.sports?[index];
                              final String teamName = team?.teamName ?? '';
                              Game? nextGame;
                              try {
                                nextGame = sportsController.sportsData?.upcomingGames?.games?.firstWhere((game) =>
                                game.sport?.toLowerCase() == team?.sport?.toLowerCase());
                              } catch (_) {
                                nextGame = null;
                              }
                              final bool hasNextGame = nextGame != null;
                              final String sportName = [
                                team?.level,
                                team?.sport,
                              ].where((value) {
                                return value != null && value.trim().isNotEmpty;
                              }).join(' ');
                              final String record =
                              (team?.record?.trim().isNotEmpty == true ?? false)
                                  ? (team?.record?? "") : '—';
                              return Container(
                                width: Dimensions.w_140,
                                padding: EdgeInsets.only(
                                  top: Dimensions.h_6,
                                  bottom: Dimensions.h_6,
                                  left: Dimensions.w_4,
                                  right: Dimensions.w_4,
                                ),
                                decoration: BoxDecoration(
                                  color: context.sports.card,
                                  border: Border.all(
                                    color: context.sports.border,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.h_6,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    AppCacheImage(
                                      imageUrl: team?.logoUrl ?? '',
                                      size: Dimensions.h_65,
                                      widthSize: Dimensions.w_70,
                                      radius: 0,
                                      fit: BoxFit.cover,
                                      isShadow: false,
                                    ),
                                    SizedBox(height: Dimensions.h_3),
                                    Text(
                                      sportName,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_2),
                                    Text(
                                      teamName,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontSize: FontSize.sp_13_5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_3),
                                    Text(
                                      record,
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontSize: FontSize.sp_14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_1),
                                    Text(
                                      'Record',
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontSize: FontSize.sp_10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_7),
                                    Divider(
                                      height: 1,
                                      thickness: 0.7,
                                      color: context.sports.border,
                                    ),
                                    SizedBox(height: Dimensions.h_6),
                                    Text(
                                      'NEXT GAME',
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontSize: FontSize.sp_7,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_2),
                                    if (hasNextGame) ...[
                                      Text(
                                        DateFormats.formatGameDate(nextGame.date ?? ''),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Theme.of(context).highlightColor,
                                          fontSize: FontSize.sp_8_5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.h_1),
                                      Text(
                                        'vs ${nextGame.opponent ?? ''}',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Theme.of(context).highlightColor,
                                          fontSize: FontSize.sp_8_5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ] else ...[
                                      Text(
                                        'Schedule unavailable',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Theme.of(context).highlightColor,
                                          fontSize: FontSize.sp_8_5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.h_1),
                                      Text(
                                        team?.organization ?? '',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Theme.of(context).highlightColor,
                                          fontSize: FontSize.sp_8_5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                    SizedBox(height: Dimensions.h_7),
                                    Divider(
                                      height: 1,
                                      thickness: 0.7,
                                      color: context.sports.border,
                                    ),
                                    SizedBox(height: Dimensions.h_6),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                '—',
                                                style: TextStyle(
                                                  color:
                                                  Theme.of(context).highlightColor,
                                                  fontSize: FontSize.sp_10,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),

                                              SizedBox(
                                                height: Dimensions.h_2,
                                              ),

                                              Text(
                                                'Followers',
                                                style: TextStyle(
                                                  color: Theme.of(context).highlightColor,
                                                  fontSize: FontSize.sp_8_5,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Container(
                                          height: Dimensions.h_25,
                                          width: 1,
                                          color: context.sports.border,
                                        ),

                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                '—',
                                                style: TextStyle(
                                                  color:
                                                  Theme.of(context).highlightColor,
                                                  fontSize: FontSize.sp_10,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),

                                              SizedBox(
                                                height: Dimensions.h_2,
                                              ),

                                              Text(
                                                'Discussions',
                                                style: TextStyle(
                                                  color: Theme.of(context).highlightColor,

                                                  fontSize: FontSize.sp_8_5,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Dimensions.h_6),
                                    Text(
                                      '—',
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),

                                    SizedBox(height: Dimensions.h_1),

                                    Text(
                                      'PHOTOS THIS WEEK',
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,

                                        fontSize: FontSize.sp_8_5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: Dimensions.h_5,horizontal: Dimensions.w_40),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: context.sports.secondaryText
                                      ),
                                      child: Text('Follow', style: TextStyle(
                                          color: Colors.white,
                                          fontSize: FontSize.sp_9_5,
                                          fontWeight: FontWeight.w800
                                      )),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: Dimensions.h_15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "COMMUNITY MEMORIES",
                              style: TextStyle(
                                color: Theme.of(Get.context!).highlightColor,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            Text(
                              "View All",
                              style: TextStyle(
                                color: Theme.of(Get.context!).primaryColorDark,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_8),
                        GetBuilder(
                            init: sportsController,
                            id: ControllerBuilders.sportsController,
                            builder: (c) {
                              final historyList = (sportsController.sportsData?.history?.timeline ?? [])
                                  .reversed
                                  .toList();
                              return
                                SizedBox(
                                  height: Dimensions.h_170,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: historyList.length,
                                    itemBuilder: (context, index) {
                                      final history = historyList[index];
                                      return Container(
                                        margin: EdgeInsets.only(
                                          right: Dimensions.w_5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: context.sports.card,
                                          border: Border.all(color: context.sports.border),
                                          borderRadius: BorderRadius.circular(Dimensions.h_8),
                                        ),
                                        width: Dimensions.w_145,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                AppCacheImage(
                                                  imageUrl: history.imageUrl ?? '',
                                                  size: Dimensions.h_90,
                                                  widthSize: Dimensions.w_145,
                                                  radius: Dimensions.h_6,
                                                  fit: BoxFit.cover,
                                                  isShadow: false,
                                                ),
                                                if (history.year != null)
                                                  Positioned(
                                                    top: Dimensions.h_8,
                                                    left: Dimensions.w_8,
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.h_3,
                                                        horizontal: Dimensions.w_5,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(4),
                                                          color: context.sports.secondaryText),
                                                      child: Text(
                                                        history.year.toString(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: FontSize.sp_9,
                                                          fontWeight: FontWeight.w800,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            SizedBox(height: Dimensions.h_5),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.w_5,
                                              ),
                                              child: Text(
                                                history.title ?? '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Theme.of(context).highlightColor,
                                                  fontSize: FontSize.sp_12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: Dimensions.h_2),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.w_5,
                                              ),
                                              child: Text(
                                                history.sport ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Theme.of(context).highlightColor,
                                                  fontSize: FontSize.sp_8_5,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: Dimensions.h_5),

                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.w_5,
                                              ),
                                              child: Text(
                                                history.description ?? '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Theme.of(context).highlightColor,
                                                  fontSize: FontSize.sp_8_5,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                            }),
                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              height: Dimensions.h_100,
                              margin: EdgeInsets.only(top: Dimensions.h_10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0B6030),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: Dimensions.h_10),
                              width: Dimensions.w_200,
                              height: Dimensions.h_100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xE6020B15).withValues(alpha: 0.60),
                                    Color(0x99020B15).withValues(alpha: 0.55),
                                    Color(0x99020B15).withValues(alpha: 0.45),
                                    Color(0x00000000),
                                    Color(0x00000000),
                                  ],
                                  stops: [0.08, 0.35,0.55, 0.99, 1],
                                ),
                              ),
                            ),
                            Positioned.fill(
                              top: Dimensions.h_10,
                              child: Padding(
                                padding: EdgeInsets.only(left: Dimensions.w_6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: Dimensions.h_5),
                                          Padding(
                                            padding:  EdgeInsets.only(left: Dimensions.w_5),
                                            child: Text("PRESENTING COMMUNITY PARTNER", style: TextStyle(
                                                color: Colors.white,
                                                fontSize: FontSize.sp_10,
                                                fontWeight: FontWeight.w600
                                            )),
                                          ),
                                          SizedBox(height: Dimensions.h_8),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AppCacheImage(imageUrl: 'assets/images/sports1.png',
                                                  size: Dimensions.h_60,
                                                  widthSize: Dimensions.h_60,
                                                  fit: BoxFit.contain,
                                                  isShadow: false),
                                              SizedBox(width: Dimensions.w_10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Proud to support Issaquah athletes , terms and our community since 1996",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: FontSize.sp_9,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(height: Dimensions.h_6),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: Dimensions.h_5,horizontal: Dimensions.w_30),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(6),
                                                          border: Border.all(
                                                              color: Colors.white,
                                                              width: 0.5
                                                          )
                                                      ),
                                                      child: Text('Learn More', style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: FontSize.sp_9_5,
                                                          fontWeight: FontWeight.w800
                                                      )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(6)
                                      ),
                                      child: AppCacheImage(imageUrl: 'https://imgs.search.brave.com/yXH1zrX8YGjSNlripriq_5AbxgAxtZ2P01OEKFPNqeY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTM3/MTk0MDEyOC9waG90/by9tdWx0aXJhY2lh/bC1mcmllbmRzLXRh/a2luZy1iaWctZ3Jv/dXAtc2VsZmllLXNo/b3Qtc21pbGluZy1h/dC1jYW1lcmEtbGF1/Z2hpbmcteW91bmct/cGVvcGxlLmpwZz9z/PTYxMng2MTImdz0w/Jms9MjAmYz1GUHMt/QzkyemJONlJrSG5Q/RzRGbDl6eVAyLUha/V0d5OVByZHQ0Nllu/LUlZPQ',
                                        widthSize: Dimensions.w_120,
                                        size: Dimensions.h_100,
                                        radius: 0,
                                        isShadow: false,),
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: Dimensions.h_10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "THIS WEEK IN SPORTS",
                              style: TextStyle(
                                color: Theme.of(Get.context!).highlightColor,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            Text(
                              "View All",
                              style: TextStyle(
                                color: Theme.of(Get.context!).primaryColorDark,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_10),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              SportsStatItem(
                                  value: '6',
                                  label: 'wins'),
                              SizedBox(width: Dimensions.w_6),
                              SportsStatItem(
                                  value: '2',
                                  label: 'Championships'),
                              SizedBox(width: Dimensions.w_6),
                              SportsStatItem(
                                  value: '18',
                                  label: 'athlete nominations'),
                              SizedBox(width: Dimensions.w_6),
                              SportsStatItem(
                                  value: '340',
                                  label: 'fan photos'),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.h_15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "UPCOMING EVENTS",
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            Text(
                              "View Full Schedule",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: FontSize.sp_9_5,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: Dimensions.h_10),
                          padding: EdgeInsets.symmetric(vertical: Dimensions.h_5),
                          decoration: BoxDecoration(
                            color: context.sports.card,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: context.sports.border),
                          ),
                          child: GetBuilder(
                              id: ControllerBuilders.sportsController,
                              init: sportsController,
                              builder: (context) {
                                final games = (sportsController.sportsData?.upcomingGames?.games ?? []);                                  return ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: games.length,
                                  separatorBuilder: (_, __) => Container(
                                    margin: EdgeInsets.symmetric(vertical: Dimensions.h_4),
                                    height: 0.3,
                                    color: Colors.grey,
                                  ),
                                  itemBuilder: (context, index) {
                                    final game = games[index];
                                    final date = DateTime.parse(game.date ?? '');

                                    return Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: Dimensions.w_10),
                                        Column(
                                          children: [
                                            Text(
                                              DateFormat('MMM').format(date).toUpperCase(),
                                              style: TextStyle(
                                                color: Theme.of(context).highlightColor,
                                                fontSize: FontSize.sp_9,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('dd').format(date),
                                              style: TextStyle(
                                                color: Theme.of(context).highlightColor,
                                                fontSize: FontSize.sp_15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: Dimensions.w_12),
                                        Container(
                                          height: Dimensions.h_35,
                                          width: 0.5,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: Dimensions.w_5),
                                        Icon(
                                          Icons.sports_football,
                                          color: Theme.of(context).highlightColor,
                                          size: Dimensions.h_18,
                                        ),
                                        SizedBox(width: Dimensions.w_10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                game.sport ?? '',
                                                style: TextStyle(
                                                  color: Theme.of(context).highlightColor,
                                                  fontSize: FontSize.sp_11,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(height: Dimensions.h_2),
                                              Text(
                                                "${game.school ?? ''} vs. ${game.opponent ?? ''}",
                                                style: TextStyle(
                                                  color: Theme.of(context).highlightColor,
                                                  fontSize: FontSize.sp_9,
                                                ),
                                              ),
                                              SizedBox(height: Dimensions.h_2),
                                              Row(
                                                children: [
                                                  Text(
                                                    game.time ?? '',
                                                    style: TextStyle(
                                                      color: Theme.of(context).highlightColor,
                                                      fontSize: FontSize.sp_8_5,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                                                    height: 3,
                                                    width: 3,
                                                    decoration:  BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context).highlightColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    game.homeAway ?? '',
                                                    style: TextStyle(
                                                      color: Theme.of(context).highlightColor,
                                                      fontSize: FontSize.sp_8_5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            final url = Uri.parse(game.sourceUrl ?? '');
                                            if (await canLaunchUrl(url)) {
                                              await launchUrl(url, mode: LaunchMode.externalApplication);
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: Dimensions.h_8),
                                            padding: EdgeInsets.symmetric(vertical: Dimensions.h_3,horizontal: Dimensions.w_6),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: Get.context!.sports.secondaryText),
                                            child: Text('Tickets', style: TextStyle(
                                                color: AppColor.white,
                                                fontSize: FontSize.sp_9_5,
                                                fontWeight: FontWeight.w700
                                            )),
                                          ),
                                        ),
                                        SizedBox(width: Dimensions.w_10),
                                      ],
                                    );
                                  },
                                );
                              }
                          ),
                        ),
                        SizedBox(height: Dimensions.h_15),
                        topContributors(),
                        SizedBox(height: Dimensions.h_15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "FEATURED LOCAL SPONSORS",
                              style: TextStyle(
                                color: Theme.of(Get.context!).highlightColor,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            Text(
                              "View All",
                              style: TextStyle(
                                color: Theme.of(Get.context!).primaryColorDark,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_10),
                        SizedBox(
                          height: Dimensions.h_100,
                          child: GetBuilder(
                            init: sportsController,
                            id: ControllerBuilders.sportsController,
                            builder: (context) {
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: sportsController
                                    .sportsData
                                    ?.supportingSportsBusinesses
                                    ?.businesses
                                    ?.length ??
                                    0,
                                separatorBuilder: (_, _) =>
                                    SizedBox(width: Dimensions.w_5),
                                itemBuilder: (context, index) {
                                  final item = sportsController
                                      .sportsData
                                      ?.supportingSportsBusinesses
                                      ?.businesses?[index];

                                  final businessName = item?.name?.trim() ?? '';

                                  final avatarText = businessName.isEmpty
                                      ? '?'
                                      : businessName
                                      .split(' ')
                                      .where((e) => e.isNotEmpty)
                                      .take(2)
                                      .map((e) => e[0])
                                      .join()
                                      .toUpperCase();

                                  return Container(
                                    width: Dimensions.w_100,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.w_1,
                                      vertical: Dimensions.h_5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: context.sports.card,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: context.sports.border,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Container(
                                              width: Dimensions.h_40,
                                              height: Dimensions.h_40,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: getAvatarColor(index),
                                                borderRadius: BorderRadius.circular(
                                                  Dimensions.h_6,
                                                ),
                                              ),
                                              child: Text(
                                                avatarText,
                                                style: TextStyle(
                                                  fontSize: FontSize.sp_15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.h_10),
                                        Text(
                                          item?.name ?? '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: FontSize.sp_9_5,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context).highlightColor,
                                            height: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: Dimensions.h_15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "FAN ZONE",
                              style: TextStyle(
                                color: Theme.of(Get.context!).highlightColor,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            Text(
                              "View All",
                              style: TextStyle(
                                color: Theme.of(Get.context!).primaryColorDark,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_10),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              SportsCommunityItem(
                                icon: CupertinoIcons.camera,
                                iconSize: Dimensions.h_22,
                                badge: '124',
                                title: 'Fan Photos',
                              ),
                              SizedBox(width: Dimensions.w_6),
                              SportsCommunityItem(
                                icon: CupertinoIcons.chat_bubble_2,
                                iconSize: Dimensions.h_22,
                                badge: '8',
                                title: 'Chat Rooms',
                              ),
                              SizedBox(width: Dimensions.w_6),
                              SportsCommunityItem(
                                icon: CupertinoIcons.chart_bar,
                                iconSize: Dimensions.h_22,
                                badge: '16',
                                title: 'Polls',
                              ),
                              SizedBox(width: Dimensions.w_6),
                              SportsCommunityItem(
                                icon: Icons.campaign,
                                iconSize: Dimensions.h_25,
                                badge: '32',
                                title: 'Shout Outs',
                              ),
                              SizedBox(width: Dimensions.w_6),
                              SportsCommunityItem(
                                icon: Icons.more_horiz,
                                iconSize: Dimensions.h_25,
                                badge: '',
                                title: 'More',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.h_15),
                        fanDiscussions(),
                        SizedBox(height: Dimensions.h_15),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "LOCAL SPORTS NEAR YOU",
                        //       style: TextStyle(
                        //         color: Theme.of(Get.context!).highlightColor,
                        //         fontSize: FontSize.sp_11,
                        //         fontWeight: FontWeight.w600,
                        //         height: 1,
                        //       ),
                        //     ),
                        //     Text(
                        //       "View All",
                        //       style: TextStyle(
                        //         color: Theme.of(Get.context!).primaryColorDark,
                        //         fontSize: FontSize.sp_10,
                        //         fontWeight: FontWeight.w500,
                        //         height: 1,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: Dimensions.h_15),
                        // ListView.builder(
                        //     shrinkWrap: true,
                        //     physics: NeverScrollableScrollPhysics(),
                        //     itemCount: 3,
                        //     padding: EdgeInsets.zero,
                        //     itemBuilder: (c,i) {
                        //   return Padding(
                        //     padding:  EdgeInsets.only(bottom: Dimensions.h_10),
                        //     child: Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         AppCacheImage(
                        //             imageUrl: 'https://imgs.search.brave.com/vlVMuz-R0fnuNbzZfidjpyZUAW7eeqr9tkNgO_949pM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wMDcv/Nzg4Lzc4NC9zbWFs/bC9ibHVlLXN1di1j/YXItd2l0aC1zcG9y/dC1hbmQtbW9kZXJu/LWRlc2lnbi1wYXJr/ZWQtb24tY29uY3Jl/dGUtcm9hZC1ieS10/aGUtc2VhLWF0LXN1/bnNldC1pbi10aGUt/ZXZlbmluZy1oeWJy/aWQtYW5kLWVsZWN0/cmljLWNhci10ZWNo/bm9sb2d5LWNvbmNl/cHQtYXV0b21vdGl2/ZS1pbmR1c3RyeS1o/ZWFkbGFtcC1hbmQt/Zm9nLWxhbXAtbGln/aHQtcGhvdG8uanBn',
                        //             size: Dimensions.h_45,
                        //             widthSize: Dimensions.h_80,
                        //             radius: Dimensions.h_6,
                        //             isShadow: false),
                        //         SizedBox(width: Dimensions.w_10),
                        //         Expanded(
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment
                        //                 .start,
                        //             children: [
                        //               Text(
                        //                 'Eagles advance to state semifinal behind big fourth quarter comeback',
                        //                 style: TextStyle(
                        //                   color: Theme.of(Get.context!).highlightColor,
                        //                   fontSize: FontSize.sp_11,
                        //                   fontWeight: FontWeight.w600,
                        //                 ),
                        //               ),
                        //               SizedBox(height: Dimensions.h_2),
                        //               Text(
                        //                 '4h ago',
                        //                 maxLines: 1,
                        //                 overflow: TextOverflow.ellipsis,
                        //                 style: TextStyle(
                        //                   color: Theme.of(Get.context!).highlightColor,
                        //                   fontSize: FontSize.sp_9,
                        //                   fontWeight: FontWeight.w500,
                        //                   height: 1.1,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         SizedBox(width: Dimensions.w_5),
                        //         Padding(
                        //           padding: EdgeInsets.only(top: Dimensions
                        //               .h_10),
                        //           child: Icon(Icons.arrow_forward_ios_rounded,
                        //               color: Theme.of(Get.context!).highlightColor,
                        //               size: Dimensions.h_12),
                        //         ),
                        //         SizedBox(width: Dimensions.w_5),
                        //       ],
                        //     ),
                        //   );
                        // }),
                        Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.h_5,
                              left: Dimensions.w_6,
                              right: Dimensions.w_6,
                              bottom: Dimensions.h_1
                          ),
                          decoration: BoxDecoration(
                              color: Get.context!.sports.card,
                              border: Border.all(
                                  color: Get.context!.sports.border),
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: Dimensions.w_10,right: Dimensions.w_10),
                                padding: EdgeInsets.symmetric(vertical: Dimensions.h_5,horizontal: Dimensions.w_5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Get.context!.sports.secondaryText,
                                ),
                                child: Icon(CupertinoIcons.sparkles,size: Dimensions.h_25,color: AppColor.white),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: Dimensions.h_2),
                                    Text('ASK WIKIXM AI', style: TextStyle(
                                        color: Theme.of(Get.context!).highlightColor,
                                        fontSize: FontSize.sp_12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.1
                                    )),
                                    Text(
                                      "Ask anything about pine valley sports, games, teams, stats and more",
                                      style: TextStyle(
                                        color: Theme.of(Get.context!).highlightColor,
                                        fontSize: FontSize.sp_9_5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_6),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: Dimensions.w_20,right: Dimensions.w_10),
                                padding: EdgeInsets.symmetric(vertical: Dimensions.h_5,horizontal: Dimensions.w_5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: AppColor.sportsLightSecondaryText),
                                child: Icon(CupertinoIcons.chat_bubble,size: Dimensions.h_18,color: AppColor.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SliverToBoxAdapter(child: SizedBox(height: Dimensions.h_20))
            ]);
          }
        ));
  }

  Widget fanDiscussions() {
    final discussionData = sportsController.sportsData?.fanDiscussions;
    final discussions = discussionData?.discussions ?? [];
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_5,horizontal: Dimensions.w_8),
      decoration: BoxDecoration(
        color: context.sports.card,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: context.sports.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'WHAT FANS ARE SAYING',
                style: TextStyle(
                  color: context.sports.primaryText,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: Dimensions.w_8),
              const Spacer(),
              Text(
                'All discussions',
                style: TextStyle(
                  color: context.sports.primaryText,
                  fontSize: FontSize.sp_9_5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_7),
          ...discussions.asMap().entries.map((entry) {
              final index = entry.key;
              final discussion = entry.value;
              return _discussionRow(
                discussion: discussion,
                isLast: index == discussions.length - 1,
              );
            },
          ),
          SizedBox(height: Dimensions.h_10),
          Center(
            child: GestureDetector(
              onTap: () {
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.chat_bubble,
                    color: context.sports.primaryText,
                    size: Dimensions.h_13,
                  ),
                  SizedBox(width: Dimensions.w_6),
                  Text(
                    'Start a discussion',
                    style: TextStyle(
                      color: context.sports.primaryText,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_5),
        ],
      ),
    );
  }

  Widget _discussionRow({
    required Discussion discussion,
    required bool isLast,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.h_7,
        horizontal: Dimensions.w_10),
      decoration: isLast
          ? null
          : BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.sports.border,
            width: 0.6,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.chat_bubble,
            color: context.sports.primaryText,
            size: Dimensions.h_18,
          ),
          SizedBox(width: Dimensions.w_8),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  discussion.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color:
                    Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: Dimensions.h_1),
                Text(
                  '${discussion.commentsCount ?? 0} comments • '
                      '${discussion.postedAt ?? ''}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: FontSize.sp_8_5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget topContributors() {
    final contributors = sportsController.sportsData?.topContributors?.items ?? [];
    final topContributorsData = sportsController.sportsData?.topContributors;
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_5,horizontal: Dimensions.w_8),
      decoration: BoxDecoration(
        color: context.sports.card,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: context.sports.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.h_5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOP CONTRIBUTORS",
                style: TextStyle(
                  color: Theme.of(Get.context!).highlightColor,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
              Text(
                "View All",
                style: TextStyle(
                  color: Theme.of(Get.context!).primaryColorDark,
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_2),
          Text(
            topContributorsData?.subtitle ?? '',
            style: TextStyle(
              color: Theme.of(Get.context!).highlightColor,
              fontSize: FontSize.sp_10,
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          ...contributors.asMap().entries.map((entry) {
            final index = entry.key;
            final contributor = entry.value;
            return _contributorRow(
              rank: '${index + 1}',
              name: contributor.name ?? '',
              image: contributor.profileImage ?? '',
              isLast: index == contributors.length - 1,
            );
          }),
          if (contributors.isNotEmpty)
            SizedBox(height: Dimensions.h_10),
          Center(
            child: GestureDetector(
              onTap: () {
                // Use topContributorsData?.viewAllUrl here
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'See All Contributors',
                    style: TextStyle(
                      color: context.sports.primaryText,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: Dimensions.w_5),
                  Icon(
                    CupertinoIcons.arrow_right,
                    color: context.sports.primaryText,
                    size: Dimensions.h_12,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_5),
        ],
      ),
    );
  }

  Widget _contributorRow({
    required String rank,
    required String name,
    required String image,
    bool isLast = false,
  }) {
    final initials = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .take(2)
        .map((e) => e[0])
        .join()
        .toUpperCase();

    final bool isFirst = rank == '1';

    return Container(
      margin: EdgeInsets.only(left: Dimensions.w_15),
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.h_6,
      ),
      decoration: isLast
          ? null
          : BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.sports.border,
            width: 0.6,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: Dimensions.h_20,
            height: Dimensions.h_20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFirst
                  ? const Color(0xFFD9A600)
                  : context.sports.cardActiveBackground,
              border: Border.all(
                color: isFirst
                    ? const Color(0xFFD9A600)
                    : context.sports.border,
                width: 0.6,
              ),
            ),
            child: Text(
              rank,
              style: TextStyle(
                color: isFirst
                    ? Colors.white
                    : Theme.of(context).highlightColor,
                fontSize: FontSize.sp_8_5,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_10),
          Container(
            width: Dimensions.h_30,
            height: Dimensions.h_30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF276B50),
                  Color(0xFF122922),
                ],
              ),
              border: Border.all(
                color: context.sports.border,
                width: 0.7,
              ),
            ),
            child: Text(
              initials,
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.sp_7,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_8),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCountdown(int days, int hours, int minutes, int seconds,
      Game? game, DateTime targetDate) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.h_10),
      padding: EdgeInsets.only(
          top: Dimensions.h_5,
          left: Dimensions.w_5,
          right: Dimensions.w_5,
          bottom: Dimensions.h_10
      ),
      decoration: BoxDecoration(
          color: context.sports.card,
          borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: context.sports.border
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_8),
            child: Text("COUNTDOWN TO NEXT GAME", style: TextStyle(
                color: context.sports.primaryText,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w600
            )),
          ),
          SizedBox(height: Dimensions.h_10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: Dimensions.h_60,
                  width: Dimensions.h_60,
                  child: Image.asset('assets/images/sports1.png')),
              Expanded(
                child: Column(
                  children: [
                    CountdownWidget(days: days,
                        hours: hours,
                        minutes: minutes,
                        seconds: seconds,
                        textColor: context.sports.primaryText),
                    SizedBox(height: Dimensions.h_8),
                    Text("${game?.school?.toLowerCase() ?? ''} \nvs. ${game
                        ?.opponent ?? ''}",
                        textAlign: TextAlign.center, style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: FontSize.sp_13,
                            fontWeight: FontWeight.w800
                        )),
                    SizedBox(height: Dimensions.h_4),
                    Text(
                        "${DateFormat('EEE, MMM d').format(targetDate)} • ${game
                            ?.time}", style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_9_5,
                        fontWeight: FontWeight.w600
                    )),
                    SizedBox(height: Dimensions.h_4),
                    Text(game?.venue ?? '', style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_9_5,
                        fontWeight: FontWeight.w600
                    )),
                  ],
                ),
              ),
              SizedBox(
                  height: Dimensions.h_60,
                  width: Dimensions.h_60,
                  child: Image.asset('assets/images/sports2.png')),
            ],
          ),
          SizedBox(height: Dimensions.h_15),
          Row(
            children: [
              SizedBox(width: Dimensions.w_10),
              SportsInfoItem(
                icon: CupertinoIcons.sun_max,
                iconSize: Dimensions.h_16,
                iconColor: context.sports.primaryText,
                title: 'Weather',
                subtitle: 'Thurs 17°C',
              ),
              SizedBox(width: Dimensions.w_5),
              SportsInfoItem(
                icon: CupertinoIcons.calendar,
                iconSize: Dimensions.h_16,
                iconColor: context.sports.primaryText,
                title: 'Tickets',
                subtitle: 'Available',
              ),
              SizedBox(width: Dimensions.w_5),
              SportsInfoItem(
                icon: CupertinoIcons.play,
                iconSize: Dimensions.h_13,
                iconColor: context.sports.primaryText,
                title: 'Watch Live',
                subtitle: 'On WikiXM',
                onTap: () async {
                  final url = Uri.parse(game!.sourceUrl!);

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    debugPrint("Failed: $url");
                  }
                },
              ),

              SizedBox(width: Dimensions.w_10),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
                  margin: EdgeInsets.only(
                      left: Dimensions.w_10, right: Dimensions.w_10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff119253),
                        Color(0xff08733f),
                      ],
                    ),
                    border: Border.all(
                      color: const Color(0xff0b7742),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff08733f).withValues(alpha: 0.18),
                        offset: const Offset(0, 7),
                        blurRadius: 16,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Get Tickets', style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w800
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_5),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    final url = Uri.parse(game!.sourceUrl!);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      debugPrint("Failed: $url");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_7),
                    margin: EdgeInsets.only(
                        left: Dimensions.w_5, right: Dimensions.w_10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.sports.card,
                        border: Border.all(color: context.sports.border)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.play, size: Dimensions.h_16,
                            color: context.sports.primaryText),
                        SizedBox(width: Dimensions.w_5),
                        Text('Watch Live', style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: FontSize.sp_11,
                            fontWeight: FontWeight.w800
                        )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )

        ],
      ),
    );
  }

  Widget firstCard() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Dimensions.w_6),
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_8,
        Dimensions.h_8,
        Dimensions.w_8,
        Dimensions.h_6,
      ),
      decoration: BoxDecoration(
        color: context.sports.card,
        border: Border.all(
          color: context.sports.border,
          width: isLight ? 0.5 : 0.8
        ),
        borderRadius: BorderRadius.circular(
            Dimensions.h_10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start,
              children: [
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.sparkles,
                      color: context.sports.primaryText,
                      size: Dimensions.h_18,
                    ),
                    SizedBox(width: Dimensions.w_5),
                    Expanded(
                      child: Text(
                        'AI SPORTS BRIEF',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: context.sports.primaryText,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_6),
                GetBuilder(
                  id: ControllerBuilders.sportsController,
                  init: sportsController,
                  builder: (context) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: sportsController.sportsData?.sportsBrief?.highlights?.length ?? 0,
                      itemBuilder: (c,i) {
                      var item = sportsController.sportsData?.sportsBrief?.highlights?[i];
                      return  Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.w_2,bottom: Dimensions.h_5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: [
                            Icon(
                              CupertinoIcons.checkmark_circle_fill,
                              color: AppColor.sportsLightSecondaryText,
                              size: Dimensions.h_13,
                            ),
                            SizedBox(width: Dimensions.w_4),
                            Expanded(
                              child: Text(
                                item ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(Get.context!).highlightColor,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w500,
                                  height: 1.1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  }
                ),
                SizedBox(height: Dimensions.h_3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Ask ${LocalStorage.getString(GetXStorageConstants.townName)} Sports AI',
                      style: TextStyle(
                        color: context.sports.primaryText,
                        fontSize: FontSize.sp_11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: Dimensions.w_4),
                    Icon(
                      CupertinoIcons.sparkles,
                      color: context.sports.secondaryText,
                      size: Dimensions.h_13,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: Dimensions.w_8),
        ],
      ),
    );
  }

  Widget buildHeroHeader(bool isLight) {
    return GetBuilder(
      id: ControllerBuilders.sportsController,
      init: sportsController,
      builder: (controller) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedWeatherImage(image: controller.sportsData?.topStory?.imageUrl ?? ''),
            Positioned(
              child: Container(
                height: Dimensions.h_312,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xE6020B15).withValues(alpha: 0.99),
                      Color(0x99020B15).withValues(alpha: 0.75),
                      Color(0x99020B15).withValues(alpha: 0.55),
                      Color(0x00000000),
                      Color(0x00000000),
                    ],
                    stops: [0.08, 0.35,0.55, 0.78, 1],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.h_312,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_8),
                    child: Text(
                      '${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()} SPORTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSize.sp_12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.w_8,top: Dimensions.h_5,bottom: Dimensions.h_8),
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_3, vertical: Dimensions.h_2),
                    decoration: BoxDecoration(
                      color: AppColor.sportsLightSecondaryText,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'TOP STORY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_8,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_8,right: Dimensions.w_120),
                    child: Text(
                      controller.sportsData?.topStory?.title?.toUpperCase() ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSize.sp_20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_8,right: Dimensions.w_120,top: Dimensions.h_8),
                    child: Text(
                      maxLines: 4,
                      controller.sportsData?.topStory?.summary ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSize.sp_11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.h_5),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: Dimensions.w_8,
                              top: Dimensions.h_5,
                              bottom: Dimensions.h_8,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w_6,
                              vertical: Dimensions.h_6,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff119253),
                                  Color(0xff08733f),
                                ],
                              ),
                              border: Border.all(
                                color: const Color(0xff0b7742),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xff08733f).withValues(alpha: 0.18),
                                  offset: const Offset(0, 7),
                                  blurRadius: 16,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Watch Full Game",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_2),
                                Icon(
                                  Icons.play_arrow_sharp,
                                  size: Dimensions.h_13,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: Dimensions.w_8,top: Dimensions.h_5,bottom: Dimensions.h_8),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_8,
                            vertical: Dimensions.h_6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            border: Border.all(color: Colors.white,width: 0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Game Recap",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(Icons.play_arrow_sharp,size: Dimensions.h_13,color: Colors.white)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: Dimensions.h_25,
                    margin: EdgeInsets.only(top: Dimensions.h_5),
                    padding:  EdgeInsets.only(left: Dimensions.w_8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Dimensions.w_90,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: List.generate(4, (index) {
                              return Positioned(
                                left: index * 24,
                                child: AppCacheImage(imageUrl: 'https://imgs.search.brave.com/pdr3rl_l2lsO04EzmMDYUzI6guNH-mQo_Ig_EXfAoOU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wMjYv/NTcwLzY0OS9zbWFs/bC9jbG9zZS11cC1w/cm9maWxlLXZpZXct/b2YtcGVuc2l2ZS11/cHNldC1hZnJpY2Fu/LWFtZXJpY2FuLW1h/bi1sb29rLWluLWRp/c3RhbmNlLXRoaW5r/aW5nLW9mLXBlcnNv/bmFsLXByb2JsZW1z/LXRob3VnaHRmdWwt/c2FkLWJpcmFjaWFs/LW1hbGUtZmVlbC1k/ZXByZXNzZWQtbG9z/dC1pbi10aG91Z2h0/cy1wb25kZXJpbmct/aGF2aW5nLWRpbGVt/bWEtcGhvdG8uanBn',
                                widthSize: Dimensions.h_22,
                                size: Dimensions.h_22,
                                borderColor: Colors.white,
                                isCircle: true)
                              );
                            }),
                          ),
                        ),
                         Padding(
                           padding:  EdgeInsets.only(top: Dimensions.h_3),
                           child: Text(
                             '1,342 fans cheering this victory!',
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: FontSize.sp_11,
                                 fontWeight: FontWeight.w900))),
                         SizedBox(width: Dimensions.w_8),
                        Padding(
                          padding:  EdgeInsets.only(top: Dimensions.h_5),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.h_8),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: Dimensions.h_15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      context.sports.background.withValues(alpha: 0.0),
                      context.sports.background.withValues(alpha: 0.15),
                      context.sports.background.withValues(alpha: 0.35),
                      context.sports.background.withValues(alpha: 0.78),
                      context.sports.background
                    ],
                    stops: const [
                      0.08,
                      0.25,
                      0.45,
                      0.75,
                      1.0,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


