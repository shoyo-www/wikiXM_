import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wikixm/Presentation/dashboard/controller.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/constants.dart';
import 'package:wikixm/constants/images.dart';
import 'package:wikixm/data/datasource/local/local_storage.dart';
import '../../constants/appcolor.dart';
import '../../constants/fontsize.dart';
import '../first_visit/first_visit.dart';
import '../widgets/ad_widget.dart';
import '../widgets/common_scaffold.dart';
import '../widgets/countdownWidget.dart';
part 'home_widgets/home_widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      body: CommonScrollBlurScaffold(
          expandedHeight: Dimensions.h_230,
          expandedColor: Colors.white,
          collapsedColor: Theme.of(context).highlightColor,
          hero: buildHeroHeader(isLight: isLight), slivers: [
            SliverToBoxAdapter(child: Container(
          decoration:  BoxDecoration(
            gradient:LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isLight ? [
                AppColor.background,
                AppColor.background,
              ] :[
                Color(0xff00111f),
                Color(0xff00111f),
              ],
              stops: [
                0.0,
                0.90,
              ],
            ),
          ),
          child: Column(
            children: [
              CommonCard(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                padding: EdgeInsets.fromLTRB(
                  Dimensions.w_8,
                  Dimensions.h_6,
                  Dimensions.w_8,
                  Dimensions.h_6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR AI COMMUNITY UPDATE',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).hoverColor,
                        fontSize: FontSize.sp_11,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_6),
                    GetBuilder(
                      id: ControllerBuilders.homeSectionsController,
                      init: dashboardController,
                      builder: (context) {
                        final highlights = dashboardController.communityData?.guide?.highlights?.take(3).toList() ?? [];
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: highlights.length,
                          itemBuilder: (context, index) {
                            final text = highlights[index].text ?? '';
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: Dimensions.h_4,
                              ),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    CupertinoIcons.checkmark_circle_fill,
                                    color: Theme.of(context).hoverColor,
                                    size: Dimensions.h_10,
                                  ),
                                  SizedBox(width: Dimensions.w_4),
                                  Expanded(
                                    child: Text(
                                      text,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Theme.of(context).hoverColor,
                                        fontSize: FontSize.sp_10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: Dimensions.h_5),
                    Row(
                      children: [
                        Expanded(
                          child: _buildBriefButton(
                            icon: Icons.arrow_forward,
                            label: 'View Full Brief',
                            filled: true,
                            isback: true,
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: Dimensions.w_10),
                        Expanded(
                          child: _buildBriefButton(
                            icon: CupertinoIcons.sparkles,
                            label: 'Ask AI',
                            onTap: () =>
                                Get.toNamed(AppRoutes.askGuide),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_10)
            ],
          ),
        )),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTownBrief(),
              _HomeTownNeedsYou(state: this),
              CommunityJourneyCard(controller: dashboardController),
              communityStory(isLight),
              fastProgress(),
              matters(isLight),
              CommonCard(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                padding: EdgeInsets.fromLTRB(
                  Dimensions.w_8,
                  Dimensions.h_5,
                  Dimensions.w_8,
                  Dimensions.h_8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "FEATURED REPRESENTATIVE",
                      style: TextStyle(
                        color: Theme.of(context).hoverColor,
                        fontSize: FontSize.sp_11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_8),
                    GetBuilder(
                        id: ControllerBuilders.homeSectionsController,
                        init: dashboardController,
                        builder: (controller) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                            padding: EdgeInsets.fromLTRB(
                              Dimensions.w_1,
                              Dimensions.h_1,
                              Dimensions.w_1,
                              Dimensions.h_8,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppCacheImage(imageUrl: dashboardController.communityData?.representative?.image ?? '',
                                  size: Dimensions.h_60,
                                  widthSize: Dimensions.h_60,
                                  radius: 50,
                                  isShadow: false,
                                ),
                                SizedBox(width: Dimensions.w_10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rep. ${dashboardController.communityData?.representative?.name}",
                                      style: TextStyle(
                                        color: Theme.of(context).hoverColor,
                                        fontSize: FontSize.sp_12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if(dashboardController.communityData?.representative?.district?.isNotEmpty ?? false)
                                      Text(
                                        dashboardController.communityData?.representative?.district ?? '',
                                        style: TextStyle(
                                          color: Theme.of(context).hoverColor,
                                          fontSize: FontSize.sp_10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    Text(
                                      "Serving ${dashboardController.communityData?.representative?.serving ?? ''}",
                                      style: TextStyle(
                                        color: Theme.of(context).hoverColor,
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_5),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: Dimensions.h_4,horizontal: Dimensions.w_10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context).primaryColorDark, width: 0.3
                                          ),
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                                "Contact Rep",
                                                style: TextStyle(
                                                  color: Theme.of(context).primaryColorDark,
                                                  fontSize: FontSize.sp_9_5,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            SizedBox(width: Dimensions.w_8),
                                            Icon(CupertinoIcons.mail,
                                                color: Theme.of(context).primaryColorDark,
                                                size: Dimensions.h_12)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              userEvents(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
                height: Dimensions.h_110,
                decoration: BoxDecoration(
                  color: const Color(0xFF111A2D),
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                  border: isLight ? null : Border.all(
                    color: Colors.white,width: 0.5)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                  child: GetBuilder(
                      init: dashboardController,
                      id: ControllerBuilders.homeController,
                      builder: (context) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            AppCacheImage(imageUrl: dashboardController.homeData?.holiday?.image ?? ''),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.black,
                                    Color(0xF2111A2D),
                                    Color(0xD9111A2D),
                                    Color(0x66111A2D),
                                    Color(0x00111A2D),
                                  ],
                                  stops: [0, 0.35,0.56, 0.80, 1],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                Dimensions.w_8,
                                Dimensions.h_10,
                                Dimensions.w_8,
                                Dimensions.h_10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dashboardController.homeData?.holiday?.name?.toUpperCase() ?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: FontSize.sp_13,
                                            fontWeight: FontWeight.w900,
                                            height: 1.12,
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.h_10),
                                        CountdownWidget(
                                          days: dashboardController.homeData?.holiday?.countdown?.days ?? 0,
                                          hours: dashboardController.homeData?.holiday?.countdown?.hours ?? 0,
                                          minutes: dashboardController.homeData?.holiday?.countdown?.minutes ?? 0,
                                          seconds: dashboardController.homeData?.holiday?.countdown?.seconds ?? 0,
                                        ),
                                        SizedBox(height: Dimensions.h_10),
                                        Text(
                                          dashboardController.homeData?.holiday?.displayDate ?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: FontSize.sp_10,
                                            fontWeight: FontWeight.w700,
                                            height: 1.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  AppCacheImage(imageUrl: dashboardController.homeData?.holiday?.image ?? '',
                                      size: Dimensions.h_150,
                                      widthSize: Dimensions.h_120,
                                      radius: Dimensions.h_4,
                                      borderColor: Colors.black,
                                      isShadow: false),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                  ),
                ),
              ),
              _HomeMattersMost(state: this),
              sportsHighlights(),
              Padding(
                padding:  EdgeInsets.only(top: Dimensions.h_15,left: Dimensions.w_8,right: Dimensions.w_8),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.h_5,
                              left: Dimensions.w_5,
                              bottom: Dimensions.h_10
                          ),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Theme.of(context).focusColor)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('WEATHER SUMMARY', style: TextStyle(
                                  color: Theme.of(context).hoverColor,
                                  fontSize: FontSize.sp_10,
                                  fontWeight: FontWeight.w800
                              )),
                              SizedBox(height: Dimensions.h_5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: Dimensions.w_10),
                                  AppCacheImage(
                                    imageUrl: dashboardController.weatherData?.weather?.icon ?? '',
                                    size: Dimensions.h_40,
                                    widthSize: Dimensions.h_40,
                                    isShadow: false,
                                  ),
                                  SizedBox(width: Dimensions.w_15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dashboardController.weatherData?.weather?.temperatureText ?? '72° F',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Theme.of(context).hoverColor,
                                            fontFamily: 'Poppins',
                                            fontSize: FontSize.sp_24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          dashboardController.weatherData?.weather?.condition ?? 'Sunny',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Theme.of(context).hoverColor,
                                            fontSize: FontSize.sp_9,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: Dimensions.h_15),
                              Center(
                                child: Text(dashboardController.weatherData?.weather?.summary ?? '', style: TextStyle(
                                    color: Theme.of(context).hoverColor,
                                    fontSize: FontSize.sp_9_5,
                                    fontWeight: FontWeight.w500
                                )),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(top: Dimensions.h_8,left: Dimensions.w_8,
                                    right: Dimensions.w_8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('View full forecast', style: TextStyle(
                                        color: Theme.of(context).primaryColorDark,
                                        fontSize: FontSize.sp_9_5,
                                        fontWeight: FontWeight.w800
                                    )),
                                    Icon(Icons.arrow_forward,
                                        color: Theme.of(context).primaryColorDark,
                                        size: Dimensions.h_12)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.w_6),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.h_5,
                              left: Dimensions.w_5,
                              bottom: Dimensions.h_10
                          ),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Theme.of(context).focusColor)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                      'UPCOMING EVENTS', style: TextStyle(
                                      color: Theme.of(context).hoverColor,
                                      fontSize: FontSize.sp_10,
                                      fontWeight: FontWeight.w600
                                  )),
                                  Row(
                                    children: [
                                      Text(
                                        'See all',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColorDark,
                                          fontSize: FontSize.sp_9_5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Icon(
                                        CupertinoIcons.chevron_right,
                                        color: Theme.of(context).primaryColorDark,
                                        size: Dimensions.h_11,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.h_5),
                              Column(
                                children: List.generate(3, (index) {
                                  final event = dashboardController.communityData?.happeningWeek?.items?[index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: index == 3 - 1 ? 0 : Dimensions.h_5,
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              event?.date?.month ?? 'Jun',
                                              style: TextStyle(
                                                color: Theme.of(context).hoverColor,
                                                fontSize: FontSize.sp_9_5,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              event?.date?.day ?? '30',
                                              style: TextStyle(
                                                color: Theme.of(context).hoverColor,
                                                fontSize: FontSize.sp_16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: Dimensions.w_8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                event?.title ?? '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Theme.of(context).hoverColor,
                                                  fontSize: FontSize.sp_11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                DateFormats.formatTime(event?.time ?? '11:00:00') ,
                                                style: TextStyle(
                                                  color: Theme.of(context).hoverColor,
                                                  fontSize: FontSize.sp_9_5,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('YOUR COMMUNITY CENTRES',
                      style: TextStyle(
                        color: Theme.of(context).hoverColor,
                        fontSize: FontSize.sp_13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ' Everything you need. Right here.',
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: exploreCard.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: Dimensions.h_7,
                    crossAxisSpacing: Dimensions.h_7,
                    childAspectRatio: 1.4,
                  ),
                  itemBuilder: (context, index) {
                    final item = exploreCard[index];
                    return ExploreCard(
                      image: item.image,
                      title: item.title,
                      subtitle: item.subtitle,
                      icon: item.icon,
                      iconColor: item.iconColor,
                      sepia: item.sepia,
                      isCommunity: true,
                      actionTitle: item.actionTitle,
                    );
                  },
                ),
              ),
              gamesAndFun(),
              garage(isLight),
              business(isLight),
              topContributors(),
              communityWeek(),
              townMemory(isLight),
              stayInTouch(),
              localSponsors(),
              supportSection(),
              SizedBox(height: Dimensions.h_60),
            ],
          ),
        )]),
    );
  }

  Widget userEvents() {
    final DashboardController dashboardController = Get.find<DashboardController>();
    final items = (dashboardController.homeData?.liveFeed?.items ?? [])
        .where((item) => (item.userName ?? '').trim().isNotEmpty).take(5).toList();
    return items.isEmpty ? SizedBox.shrink():Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LIVE IN ${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()}',
                style: TextStyle(
                  color: Theme.of(context).hoverColor,
                  fontSize: FontSize.sp_13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  Text(
                    'See all activity',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          GetBuilder(
            id: ControllerBuilders.homeController,
            init: dashboardController,
            builder: (context) {
              final items = (dashboardController.homeData?.liveFeed?.items ?? [])
                  .where(
                    (item) => (item.userName ?? '').trim().isNotEmpty,
              )
                  .toList();

              return SizedBox(
                height: Dimensions.h_70,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: Dimensions.w_10),
                  scrollDirection: Axis.horizontal,
                  itemCount: math.min(items.length, 5),
                  itemBuilder: (context, i) {final item = items[i];
                    return Padding(
                      padding: EdgeInsets.only(right: Dimensions.w_15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(Dimensions.h_1),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFB46BFF),
                                width: 1.5,
                              ),
                            ),
                            child: AppCacheImage(
                              size: Dimensions.h_40,
                              widthSize: Dimensions.h_40,
                              isShadow: false,
                              radius: 50,
                              imageUrl: item.profileImage ?? '',
                              errorImage:
                              'https://wikixm-staging.s3.us-west-2.amazonaws.com/images/male.png',
                            ),
                          ),
                          SizedBox(height: Dimensions.h_4),
                          Text(
                            (item.userName ?? '')
                                .trim()
                                .split(RegExp(r'\s+'))
                                .first,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: FontSize.sp_11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
          ListView.separated(
            itemCount: items.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) =>
                Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.h_5,
                    bottom: Dimensions.h_5,
                    left: Dimensions.w_12,
                  ),
                  width: Get.width,
                  height: 0.1,
                  color: Colors.grey,
                ),
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_10,
                  vertical: Dimensions.h_1,
                ),
                child: Row(
                  children: [
                    AppCacheImage(
                      imageUrl: item.profileImage ?? '',
                      size: Dimensions.h_35,
                      widthSize: Dimensions.h_35,
                      radius: 50,
                      isShadow: false,
                      borderColor: Theme.of(context).hoverColor,
                      errorImage:
                      'https://wikixm-staging.s3.us-west-2.amazonaws.com/images/male.png',
                    ),

                    SizedBox(width: Dimensions.w_8),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: item.userName ?? '',
                                  style: TextStyle(
                                    color: Theme.of(context).hoverColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: FontSize.sp_11,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                  ' ${item.activity ?? ''} ${item.module ??
                                      ''}',
                                  style: TextStyle(
                                    color: Theme.of(context).hoverColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSize.sp_10,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: Dimensions.h_2),

                          Text(
                            item.postedAt ?? '',
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: FontSize.sp_9,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if ((item.image ?? '').isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: AppCacheImage(
                          imageUrl: item.image ?? '',
                          widthSize: Dimensions.h_60,
                          size: Dimensions.h_40,
                          radius: 4,
                          borderColor: Theme.of(context).highlightColor,
                          isShadow: false,
                        ),
                      )
                    else
                      Row(
                        children: [
                          SizedBox(width: Dimensions.w_10),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: Dimensions.h_10,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: Dimensions.h_15)
        ],
      ),
    );
  }

  Widget buildTownBrief() {
    return GetBuilder(
      init: dashboardController,
        id: ControllerBuilders.homeSectionsController,
        builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_1),
            padding: EdgeInsets.fromLTRB(
              Dimensions.w_8,
              Dimensions.h_8,
              Dimensions.w_8,
              Dimensions.h_8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TODAY'S BRIEF",
                  style: TextStyle(
                    color: Theme.of(context).hoverColor,
                    fontSize: FontSize.sp_13,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
                SizedBox(height: Dimensions.h_10),
                Row(
                  children: [
                    _buildTownNeedAction(
                        icon: CupertinoIcons.doc,
                        color: Theme.of(context).hoverColor,
                        label: 'Town Brief',
                        isBrief: true,
                        subtitle: DateFormat('MMM d, yyyy').format(DateTime.now()),
                        action: 'Read'

                    ),
                    SizedBox(width: Dimensions.w_6),
                    _buildTownNeedAction(
                        icon: Icons.pie_chart_rounded,
                        color: Colors.green,
                        label: 'Community Pulse',
                        isBrief: true,
                        subtitle: '78% Positive',
                        action: 'View'

                    ),
                    SizedBox(width: Dimensions.w_6),
                    _buildTownNeedAction(
                        icon: CupertinoIcons.calendar,
                        color: Theme.of(context).hoverColor,
                        label: 'Events Today',
                        isBrief: true,
                        subtitle: '5 Events',
                        action: 'See all'

                    ),
                    SizedBox(width: Dimensions.w_6),
                    _buildTownNeedAction(
                        onTap: ()=> Get.toNamed(AppRoutes.weather),
                        icon: CupertinoIcons.sun_min_fill,
                        color: Colors.yellow.shade800,
                        label: 'Weather',
                        isBrief: true,
                        subtitle: "${dashboardController.weatherData?.weather?.temperatureText ?? ''} ${dashboardController.weatherData?.weather?.condition ?? ''}",
                        action: 'Details'

                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }

  Widget communityWeek() {
    final List<Map<String, dynamic>> stats = [
      {
        "icon": Icons.groups,
        "iconColor": const Color(0xFF2525FF),
        "bgColor": const Color(0xFF2525FF),
        "value": "0",
        "title": "Neighbors Active",
        "subtitle": "▲ 10%",
      },
      {
        "icon": CupertinoIcons.chat_bubble_2_fill,
        "iconColor": Colors.orange,
        "bgColor": Colors.orange,
        "value": "23",
        "title": "Discussions Growing",
        "subtitle": "▲ +3",
      },
      {
        "icon": Icons.article,
        "iconColor": const Color(0xFF7B1FA2),
        "bgColor": const Color(0xFF7B1FA2),
        "value": "0",
        "title": "New Articles Today",
        "subtitle": "",
      },
      {
        "icon": Icons.account_balance,
        "iconColor": const Color(0xFFED1426),
        "bgColor": const Color(0xFFED1426),
        "value": "11",
        "title": "Rep Responses",
        "subtitle": "",
      },
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.h_15),
          Text('${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()} COMMUNITY THIS WEEK',
            style: TextStyle(
              color: Theme.of(context).hoverColor,
              fontSize: FontSize.sp_13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          CommonCard(
            padding: EdgeInsets.zero,
            height: Dimensions.h_130,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: stats.length,
                    separatorBuilder: (_, __) => Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_4,
                        vertical: Dimensions.h_12,
                      ),
                      width: 0.3,
                      color: Colors.grey.shade500,
                    ),
                    itemBuilder: (context, index) {
                      final item = stats[index];
                      return SizedBox(
                        width: Get.width / 4.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: Dimensions.h_10),
                            Container(
                              width: Dimensions.h_30,
                              height: Dimensions.h_30,
                              decoration: BoxDecoration(
                                color: item["bgColor"] as Color,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                item["icon"] as IconData,
                                color: Colors.white,
                                size: Dimensions.h_15,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_6),
                            Text(
                              item["value"] as String,
                              style: TextStyle(
                                color: Theme.of(context).hoverColor,
                                fontSize: FontSize.sp_18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_2),
                            Text(
                              item["title"] as String,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: FontSize.sp_8_5,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: Dimensions.h_3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Together, we make ${LocalStorage.getString(GetXStorageConstants.townName)} amazing!',
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(' ❤️',
                      style: TextStyle(
                        color: Color(0xfffb2413),
                        fontSize: FontSize.sp_13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sportsHighlights() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()} SPORTS HIGHLIGHTS',
                style: TextStyle(
                  color: Theme.of(context).hoverColor,
                  fontSize: FontSize.sp_13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_5),
          GetBuilder(
            init: dashboardController,
            id: ControllerBuilders.homeSectionsController,
            builder: (context) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4,vertical: Dimensions.h_4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xff172230)
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       AppCacheImage(
                           imageUrl: dashboardController.homeInsights?.sportsHighlights?[0].image ?? '',
                         widthSize: Dimensions.w_140,
                         size: Dimensions.h_80,
                         isShadow: false,
                       ),
                        SizedBox(width: Dimensions.w_15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dashboardController.homeInsights?.sportsHighlights?[0].title ?? '',style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: FontSize.sp_12
                              )),
                              SizedBox(height: Dimensions.h_7),
                              Text(dashboardController.homeInsights?.sportsHighlights?[0].description ?? '',style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize.sp_10
                              ),),
                              // SizedBox(height: Dimensions.h_6),
                              // Row(
                              //   children: [
                              //     Container(
                              //       height: Dimensions.h_8,
                              //       width: Dimensions.h_8,
                              //       decoration: BoxDecoration(
                              //         color: Colors.green,
                              //         shape: BoxShape.circle
                              //       ),
                              //     ),
                              //     SizedBox(width: Dimensions.w_3),
                              //     Text('High excitement',style: TextStyle(
                              //         color: Colors.white,
                              //         fontWeight: FontWeight.w500,
                              //         fontSize: FontSize.sp_9
                              //     ),),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.w_50),
                      ],
                    ),
                  ],
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  Widget gamesAndFun() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: Column(
        children: [
          SizedBox(height: Dimensions.h_15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('GAMES IN ${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()}',
                style: TextStyle(
                  color: Theme.of(context).hoverColor,
                  fontSize: FontSize.sp_13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    'More games',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_5),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: CommonCard(
                    padding: EdgeInsets.only(
                        top: Dimensions.h_10,
                        left: Dimensions.w_5,
                        bottom: Dimensions.h_10
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       AppCacheImage(imageUrl: 'https://imgs.search.brave.com/Pq7F-3IwuIc79ncvk6gH5A2eo3_526wYL1sIiURnR78/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9hcGku/bmV4dGdlbi5ndWFy/ZGlhbmFwcHMuY28u/dWsvY3Jvc3N3b3Jk/cy9xdWljay8xNzUy/NS5zdmc',
                       size: Dimensions.h_80,
                       widthSize: Dimensions.h_80,
                       isShadow: false),
                       SizedBox(height: Dimensions.h_6),
                        Text('Crossword',
                          style: TextStyle(
                            color: Theme.of(context).hoverColor,
                            fontSize: FontSize.sp_11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text('Daily puzzle',
                          style: TextStyle(
                            color: Theme.of(context).hoverColor,
                            fontSize: FontSize.sp_9_5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.w_10),
                Expanded(
                  child: CommonCard(
                    padding: EdgeInsets.only(
                        top: Dimensions.h_10,
                        left: Dimensions.w_5,
                        bottom: Dimensions.h_10
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppCacheImage(
                            imageUrl: 'https://imgs.search.brave.com/jaHudPPxF3vaotlTZ8nt3RjzQ3P481Fv8hLiSXaqV6w/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/MjQ3c3Vkb2t1LmNv/bS9pbWFnZXMvaG93/LXRvLXBsYXkvc3Vk/b2t1LW5vdGUucG5n',
                            size: Dimensions.h_80,
                            widthSize: Dimensions.h_80,
                            isShadow: false),
                        SizedBox(height: Dimensions.h_6),
                        Text('Sudoku',
                          style: TextStyle(
                            color: Theme.of(context).hoverColor,
                            fontSize: FontSize.sp_11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text('Train your brain',
                          style: TextStyle(
                            color: Theme.of(context).hoverColor,
                            fontSize: FontSize.sp_9_5,
                            fontWeight: FontWeight.w500,
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
    );
  }

  Widget garage(bool isLight) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.h_10,
        left: Dimensions.w_10,
        right: Dimensions.w_10
      ),
      padding: EdgeInsets.only(
          top: Dimensions.h_1,
          left: Dimensions.w_10,
          bottom: Dimensions.h_10
      ),
      decoration: BoxDecoration(
          color: isLight ? const Color(0xfff1f4f3) : AppColor.darkCardColor,
          borderRadius: BorderRadius.circular(6)

      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(Images.garage,height: Dimensions.h_60,width: Dimensions.h_60,color: isLight ? AppColor.darkGreen: const Color(0xff4AD492)),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()} GARAGE', style: TextStyle(
                        color: isLight ? AppColor.darkGreen: const Color(0xff4AD492),
                        fontSize: FontSize.sp_11,
                        fontWeight: FontWeight.w600
                    )),
                    SizedBox(height: Dimensions.h_2),
                    Text('Buy. Sell. Find great deals\nright here in town.', style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w600
                    )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.h_4),
            margin: EdgeInsets.only(left: Dimensions.w_5,right: Dimensions.w_20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: isLight ? AppColor.darkGreen: const Color(0xff4AD492),
                    width: 0.5
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Go to Garage', style: TextStyle(
                    color: isLight ? AppColor.darkGreen: const Color(0xff4AD492),
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w500
                )),
                SizedBox(width: Dimensions.w_15),
                Icon(Icons.arrow_forward,size: Dimensions.h_12,color: AppColor.darkGreen,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget business(bool isLight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.h_15),
          Text('${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()} BUSINESS SPOTLIGHT',
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: FontSize.sp_13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          GetBuilder(
            init: dashboardController,
            id: ControllerBuilders.homeController,
            builder: (_) {
              final spotlight =
                  dashboardController.homeMarketPlace?.businessSpotlight;

              final imageUrl = spotlight?.image ?? '';
              final businessName = spotlight?.name ?? '';
              final tagline = spotlight?.tagline ?? '';

              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_2,
                ),
                height: Dimensions.h_105,
                decoration: BoxDecoration(
                  color: const Color(0xFF111A2D),
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                  border: isLight ? null: Border.all(
                    color: AppColor.white,width: 0.3)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    Dimensions.h_8,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: 0.65,
                          heightFactor: 1,
                          child: AppCacheImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IgnorePointer(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                // Solid dark behind text
                                const Color(0xFF111A2D),

                                const Color(0xFF111A2D),

                                // Start revealing image
                                const Color(0xFF111A2D)
                                    .withValues(alpha: 0.92),

                                const Color(0xFF111A2D)
                                    .withValues(alpha: 0.20),

                                const Color(0xFF111A2D)
                                    .withValues(alpha: 0.02),

                                const Color(0xFF111A2D)
                                    .withValues(alpha: 0.01),

                                // Full image
                                Colors.transparent,
                              ],
                              stops: const [
                                0.00,
                                0.20,
                                0.35,
                                0.50,
                                0.65,
                                0.80,
                                1.00,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          Dimensions.w_8,
                          Dimensions.h_10,
                          Dimensions.w_8,
                          Dimensions.h_10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              businessName.toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize.sp_15,
                                fontWeight: FontWeight.w900,
                                height: 1.12,
                              ),
                            ),

                            SizedBox(
                              height: Dimensions.h_10,
                            ),
                            SizedBox(
                              width: Get.width * 0.48,
                              child: Text(
                                formatTitle(tagline),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w700,
                                  height: 1.12,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Dimensions.h_7,
                                horizontal: Dimensions.w_10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A623E),
                                borderRadius: BorderRadius.circular(
                                  Dimensions.h_8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Visit Business',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.w_15),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: Dimensions.h_12,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget townMemory(bool isLight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.h_15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TOWN MEMORY',
                style: TextStyle(
                  color: Theme.of(context).hoverColor,
                  fontSize: FontSize.sp_13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    'See all',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_5),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
            height: Dimensions.h_110,
            decoration: BoxDecoration(
              color: const Color(0xFF111A2D),
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              border: isLight ? null: Border.all(
                color: AppColor.white,width: 0.3)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              child: GetBuilder(
                id: ControllerBuilders.homeSectionsController,
                init: dashboardController,
                builder: (controller) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      AppCacheImage(imageUrl: dashboardController.homeInsights?.townMemory?.image ?? ''),
                       DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xF2111A2D),
                              Color(0xD9111A2D).withValues(alpha: 0.90),
                              Color(0x66111A2D).withValues(alpha: 0.50),
                              Color(0x66111A2D).withValues(alpha: 0.10),
                            ],
                            stops: [0, 0.32, 0.99, 1],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                Dimensions.w_8,
                                Dimensions.h_10,
                                Dimensions.w_8,
                                Dimensions.h_10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formatTitle(
                                      dashboardController.homeInsights?.townMemory?.title ?? '',
                                    ),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_7,horizontal: Dimensions.w_15),
                                    margin: EdgeInsets.only(right: Dimensions.w_20,top: Dimensions.h_10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Explore Memories', style: TextStyle(
                                            color: AppColor.headingColor,
                                            fontSize: FontSize.sp_11,
                                            fontWeight: FontWeight.w600
                                        )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.h_1),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: Dimensions.h_8),
                            child: AppCacheImage(imageUrl: dashboardController.homeInsights?.townMemory?.image ?? '',
                                size: Dimensions.h_120,
                                widthSize: Dimensions.h_120,
                                radius: Dimensions.h_8,
                                borderColor: Colors.grey,
                                isShadow: false),
                          ),
                          SizedBox(width: Dimensions.w_10)
                        ],
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget stayInTouch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.h_10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
            width: Get.width,
            decoration: BoxDecoration(
              color: const Color(0xFF0044f3),
              borderRadius: BorderRadius.circular(Dimensions.h_8),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                Dimensions.w_8,
                Dimensions.h_10,
                Dimensions.w_8,
                Dimensions.h_5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'STAY IN THE KNOW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_12,
                          fontWeight: FontWeight.w600,
                          height: 1.12,
                        ),
                      ),
                      Icon(CupertinoIcons.mail,size: Dimensions.h_13,color: AppColor.white)
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Text(
                          'Get the latest updates delivered to your inbox.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_11,
                            fontWeight: FontWeight.w500,
                            height: 1.12,
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.w_10),
                      Expanded(
                        flex: 8,
                        child: Column(
                          children: [
                            SizedBox(
                              height: Dimensions.h_30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: Dimensions.h_1,horizontal: Dimensions.w_5),
                                 fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter your email',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w500,
                              ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 0.1
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 0.1
                                    ),
                                  )
                                )),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: Dimensions.h_7,horizontal: Dimensions.w_15),
                              margin: EdgeInsets.only(top: Dimensions.h_5),
                              decoration: BoxDecoration(
                                color: Color(0xff1b5afc),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Subscribe', style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_11,
                                      fontWeight: FontWeight.w500
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget localSponsors() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.h_15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()} LOCAL SPONSORS',
                style: TextStyle(
                  color: Theme.of(context).hoverColor,
                  fontSize: FontSize.sp_13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    'See all',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_5),
          AdsWidget()
        ],
      ),
    );
  }

  Widget supportSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.h_15),
          Text('SUPPORT ${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()}',
            style: TextStyle(
              color: Theme.of(context).hoverColor,
              fontSize: FontSize.sp_13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          CommonCard(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5,vertical: Dimensions.h_6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               AppCacheImage(imageUrl: 'https://imgs.search.brave.com/EyDp7DzARJ2rZSAb4lumoIVJSlFcR49NOo9DuZfYCZs/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/bWFnbmlmaWMuY29t/L2ZyZWUtcGhvdG8v/Y2xvc2UtdXAtdmll/dy1zdHJpY3QteW91/bmctaGFuZHNvbWUt/Y2F1Y2FzaWFuLW1h/bi13ZWFyaW5nLWds/YXNzZXMtc3RhbmRp/bmctcHJvZmlsZS12/aWV3LWlzb2xhdGVk/LWNyaW1zb24td2Fs/bF8xNDE3OTMtNzk4/MTEuanBnP3NlbXQ9/YWlzX2h5YnJpZCZ3/PTc0MCZxPTgw',
               size: Dimensions.h_40,
               widthSize: Dimensions.h_40,
               isShadow: false,
               radius: 50),
                SizedBox(width: Dimensions.w_10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Advertise Your Business',
                        style: TextStyle(
                          color: Theme.of(context).hoverColor,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text('Reach thousands of local residents',
                        style: TextStyle(
                          color: Theme.of(context).hoverColor,
                          fontSize: FontSize.sp_9_5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_8),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: Dimensions.h_4),
                        margin: EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Theme.of(context).primaryColorDark,
                                width: 0.5
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Learn more', style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w700
                            )),
                            SizedBox(width: Dimensions.w_15),
                            Icon(Icons.arrow_forward,size: Dimensions.h_12,color: Theme.of(context).primaryColorDark)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget topContributors() {
    Color rankColor(int rank) {
      switch (rank) {
        case 1:
          return const Color(0xffFFC107);
        case 2:
          return const Color(0xffB0BEC5);
        case 3:
          return const Color(0xffFF9800);
        default:
          return Colors.transparent;
      }
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: Column(
        children: [
          SizedBox(height: Dimensions.h_15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()} TOP CONTRIBUTORS',
                style: TextStyle(
                  color: Theme.of(context).hoverColor,
                  fontSize: FontSize.sp_13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    'This week',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_5),
          CommonCard(
            padding: EdgeInsets.zero,
            child: GetBuilder(
              id: ControllerBuilders.homeSectionsController,
              init: dashboardController,
              builder: (controller) {
                return Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount:
                      dashboardController.homeInsights?.topContributors?.items?.length ?? 0,
                      separatorBuilder: (_, __) => Container(
                        margin: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                        height: 0.2,
                        color: Colors.grey.shade500,
                      ),
                      itemBuilder: (context, index) {
                        final item = dashboardController.homeInsights?.topContributors?.items?[index];
                        final int rank = index + 1;
                        return Padding(
                          padding: EdgeInsets.only(
                            left: Dimensions.w_4,
                            right: Dimensions.w_12,
                            top: Dimensions.h_6,
                            bottom: Dimensions.h_6,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Dimensions.w_28,
                                child: rank <= 3
                                    ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.star_fill,
                                      color: rankColor(rank),
                                      size: Dimensions.h_22,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: Dimensions.h_2,
                                      ),
                                      child: Text(
                                        "$rank",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: FontSize.sp_11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    : Text(
                                  "$rank",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).hoverColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: FontSize.sp_12,
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.w_10),
                              AppCacheImage(
                                imageUrl: item?.profileImage ?? "",
                                size: Dimensions.h_28,
                                widthSize: Dimensions.h_28,
                                radius: 50,
                                isShadow: false,
                              ),
                              SizedBox(width: Dimensions.w_10),
                              Expanded(
                                child: Text(
                                  item?.name ?? "",
                                  style: TextStyle(
                                    color: Theme.of(context).hoverColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.sp_11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.h_6),
                      margin: EdgeInsets.only(left: Dimensions.w_10,right: Dimensions.w_10,top: Dimensions.h_5,bottom: Dimensions.h_10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Theme.of(context).primaryColorDark,
                              width: 0.5
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('View Leaderboard', style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: FontSize.sp_11,
                              fontWeight: FontWeight.w600
                          )),
                        ],
                      ),
                    )
                  ],
                );
              }
            ),
          )

        ],
      ),
    );
  }

  Widget matters(bool isLight) {
    return (dashboardController.communityData?.whatMatters?.items?.isEmpty ?? false) ? SizedBox.shrink(): Padding(
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_6,
        Dimensions.h_1,
        Dimensions.w_6,
        Dimensions.h_8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "WHAT'S MATTER MOST",
                style: TextStyle(
                  color: Theme.of(context).hoverColor,
                  fontSize: FontSize.sp_13,
                  fontWeight: FontWeight.w800
                ),
              ),
              Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          GetBuilder(
            init: dashboardController,
            id: ControllerBuilders.homeSectionsController,
            builder: (controller) {
              final items = (dashboardController.communityData?.whatMatters?.items ?? []).take(3).toList();
              return CommonCard(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                padding: EdgeInsets.all(Dimensions.h_8),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.w_20,
                      top: Dimensions.h_5,
                      bottom: Dimensions.h_5,
                    ),
                    height: 0.3,
                    color: Colors.grey.shade300,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isPositive = item.badge?.text?.toLowerCase() == "positive";
                    return Row(
                      children: [
                        Container(
                          height: Dimensions.h_18,
                          width: Dimensions.h_18,
                          decoration: BoxDecoration(
                            color: Theme.of(context).hoverColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: isLight ? AppColor.white : AppColor.headingColor,
                                fontSize: FontSize.sp_14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.w_8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title ?? '',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Theme.of(context).hoverColor,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_1),
                              Text(
                                item.createdAt ?? '',
                                style: TextStyle(
                                  color: Theme.of(context).hoverColor,
                                  fontSize: FontSize.sp_9,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.w_5),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_5,
                            vertical: Dimensions.h_3,
                          ),
                          decoration: BoxDecoration(
                            color: isPositive
                                ? const Color(0xffE9F8EF)
                                : const Color(0xffFAECED),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            item.badge?.text ?? "",
                            style: TextStyle(
                              color: isPositive
                                  ? Colors.green.shade900
                                  : Colors.red.shade900,
                              fontSize: FontSize.sp_9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }
          ),

        ],
      ),
    );
  }

  Widget fastProgress() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_8,
        Dimensions.h_8,
        Dimensions.w_8,
        Dimensions.h_8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TODAY'S FASTEST WAY TO PROGRESS",
            style: TextStyle(
              color: Theme.of(context).hoverColor,
              fontSize: FontSize.sp_13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          CommonCard(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
            padding: EdgeInsets.fromLTRB(
              Dimensions.w_6,
              Dimensions.h_8,
              Dimensions.w_6,
              Dimensions.h_8,
            ),
            child: GetBuilder(
              id: ControllerBuilders.homeSectionsController,
              init: dashboardController,
              builder: (controller) {
                return Column(
                  children: List.generate(
                    dashboardController.communityData?.todo?.items?.length ?? 0,
                        (index) {
                      final item = dashboardController.communityData?.todo?.items?[index];

                      return Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle, size: Dimensions.h_15, color: Theme.of(context).hoverColor,
                              ),
                              SizedBox(width: Dimensions.w_5),
                              Expanded(
                                child: Text(
                                  item?.label ?? '',
                                  style: TextStyle(
                                    color: Theme.of(context).hoverColor,
                                    fontSize: FontSize.sp_11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                '+8 pts',
                                style: TextStyle(
                                  color: AppColor.darkGreenSportsSecondaryText,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          if (index != (dashboardController.communityData?.todo?.items?.length ?? 0) - 1)
                            Padding(
                              padding: EdgeInsets.only(
                                left: Dimensions.w_12,
                                top: Dimensions.h_5,
                                bottom: Dimensions.h_5,
                              ),
                              child: Divider(
                                height: 1,
                                thickness: .3,
                                color: Colors.grey.shade400,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                );
              }
            ),
          ),

        ],
      ),
    );
  }

  Widget communityStory(bool isLight) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_8,
        Dimensions.h_8,
        Dimensions.w_8,
        Dimensions.h_8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'YOUR COMMUNITY STORY',
                style: TextStyle(
                  color: Theme.of(context).hoverColor,
                  fontSize: FontSize.sp_13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    'See history',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          CommonCard(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w_5,
              Dimensions.h_5,
              Dimensions.w_5,
              Dimensions.h_5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.h_5,
                              left: Dimensions.w_5,
                              bottom: Dimensions.h_10
                          ),
                          decoration: BoxDecoration(
                              color: isLight? Color(0xfff1f4f3) : AppColor.backgroundDark,
                              borderRadius: BorderRadius.circular(6),
                            border: isLight ? null: Border.all(
                              color: AppColor.darkBorderColor
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('YESTERDAY', style: TextStyle(
                                  color: isLight ? Color(0xff1a623e) : Colors.white,
                                  fontSize: FontSize.sp_12,
                                  fontWeight: FontWeight.w600
                              )),
                              SizedBox(height: Dimensions.h_5),
                              Row(
                                children: [
                                  Icon(CupertinoIcons.check_mark_circled_solid,
                                      color: isLight ? Color(0xff1a623e) : Colors.white,
                                      size: Dimensions.h_12),
                                  SizedBox(width: Dimensions.w_3),
                                  Expanded(child: Text(
                                      'Helped 14 neighbors', style: TextStyle(
                                      color: isLight ? Color(0xff1a623e) : Colors.white,
                                      fontSize: FontSize.sp_9_5,
                                      fontWeight: FontWeight.w600
                                  )),)
                                ],
                              ),
                              SizedBox(height: Dimensions.h_5),
                              Row(
                                children: [
                                  Icon(CupertinoIcons.check_mark_circled_solid,
                                      color: isLight ? Color(0xff1a623e) : Colors.white,
                                      size: Dimensions.h_12),
                                  SizedBox(width: Dimensions.w_3),
                                  Expanded(child: Text(
                                      'Gained 22 points', style: TextStyle(
                                      color: isLight ? Color(0xff1a623e) : Colors.white,
                                      fontSize: FontSize.sp_9_5,
                                      fontWeight: FontWeight.w600
                                  )),)
                                ],
                              ),
                              SizedBox(height: Dimensions.h_5),
                              Row(
                                children: [
                                  Icon(CupertinoIcons.check_mark_circled_solid,
                                      color: isLight ? Color(0xff1a623e) : Colors.white,
                                      size: Dimensions.h_12),
                                  SizedBox(width: Dimensions.w_3),
                                  Expanded(child: Text(
                                      'Moved up 8 places', style: TextStyle(
                                      color: isLight ? Color(0xff1a623e) : Colors.white,
                                      fontSize: FontSize.sp_9_5,
                                      fontWeight: FontWeight.w600
                                  )),)
                                ],
                              ),
                              SizedBox(height: Dimensions.h_10),
                              Padding(
                                padding: EdgeInsets.only(left: Dimensions.w_8,
                                    right: Dimensions.w_8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('Great Work', style: TextStyle(
                                        color: isLight ? Color(0xff1a623e) : Colors.white,
                                        fontSize: FontSize.sp_9_5,
                                        fontWeight: FontWeight.w600
                                    )),
                                    Icon(Icons.celebration,
                                        color: Colors.yellow.shade900,
                                        size: Dimensions.h_16)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.w_6),
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: Dimensions.h_5,
                                  left: Dimensions.w_5,
                                  bottom: Dimensions.h_5,
                                  right: Dimensions.w_5
                              ),
                              decoration: BoxDecoration(
                                  color: isLight ? Color(0xfff3f0f9) : AppColor.backgroundDark,
                                  borderRadius: BorderRadius.circular(6),
                                border: isLight ? null: Border.all(color: AppColor.darkBorderColor),
                            
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('TODAY', style: TextStyle(
                                      color: isLight ? Color(0xff8662d5) : AppColor.white,
                                      fontSize: FontSize.sp_12,
                                      fontWeight: FontWeight.w600
                                  ),),
                                  SizedBox(height: Dimensions.h_5),
                                  Text('Your goal:', style: TextStyle(
                                      color: isLight ? AppColor.headingColor : AppColor.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize.sp_10),),
                                  Text(
                                    "Complete 2 more activities to earn 15 Community Points!",
                                    style: TextStyle(
                                        color: isLight ? AppColor.headingColor : AppColor.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: FontSize.sp_9_5),),
                                  SizedBox(height: Dimensions.h_5)
                                ],
                              ),
                            ),
                            Positioned(
                                bottom: isLight ? -Dimensions.h_22 : -Dimensions.h_20,
                                right : 0,child: Image.asset(Images.trophyClouds,scale: 10))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.h_8),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_5,
                      vertical: Dimensions.h_4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: isLight ? Colors.grey.shade50 : AppColor.backgroundDark),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TODAY'S GOAL",
                        style: TextStyle(
                          color: Theme.of(context).hoverColor,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(Images.trophy,scale: 20),
                          Expanded(
                            child: Text(
                              "Complete 2 more activities to earn 15 Community Points!",
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: Dimensions.h_12, color: Colors.black87),
                          SizedBox(width: Dimensions.w_5),
                        ],
                      )
                    ],
                  ),
                )

              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget buildHeroHeader({bool isLight = false}) {
    final hour = DateTime.now().hour;

    final greeting = hour < 12
        ? 'Morning'
        : hour < 17
        ? 'Afternoon'
        : 'Evening';

    return GetBuilder(
      id: ControllerBuilders.homeController,
      init: dashboardController,
      builder: (controller) {
        final liveFeedItems = controller.homeData?.liveFeed?.items;
        final hasLiveFeed = liveFeedItems != null && liveFeedItems.isNotEmpty;
        final liveFeed = hasLiveFeed ? liveFeedItems.first : null;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            AppCacheImage(
              imageUrl: isLight
                  ? Images.cityImageMobileDay
                  : Images.cityImageMobile,
              widthSize: Get.width,
              size: Dimensions.h_310,
              fit: BoxFit.fill,
              radius: 0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.h_65,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.w_8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good $greeting 👋",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_22,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(
                                alpha: 0.9,
                              ),
                              blurRadius: 30,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        controller
                            .homeData
                            ?.header
                            ?.user
                            ?.name ??
                            '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_26,
                          fontWeight: FontWeight.w900,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(
                                alpha: 0.9,
                              ),
                              blurRadius: 30,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               const Spacer(),
                Container(
                  width: Get.width,
                  padding: EdgeInsets.fromLTRB(
                    Dimensions.w_5,
                    Dimensions.h_8,
                    Dimensions.w_5,
                    Dimensions.h_3_9,
                  ),
                  decoration: BoxDecoration(
                    gradient: isLight
                        ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x00FFFFFF),
                        Color(0x33FFFFFF),
                        Color(0xCCFFFFFF),
                        Color(0xFFFFFFFF),
                        AppColor.background
                      ],
                      stops: [
                        0.08,
                        0.25,
                        0.45,
                        0.75,
                        1.0,
                      ],
                    )
                        : LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: const [
                        Color(0x00000000),
                        Color(0x00000000),
                        Color(0xE6020B15),
                        Color(0xE6020B15),
                        Color(0x99020B15),
                      ],
                      stops: const [
                        0.08,
                        0.20,
                        0.35,
                        0.78,
                        1.0,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildDynamicHeaderCard(
                                imageUrl: controller
                                    .weatherData
                                    ?.weather
                                    ?.icon ??
                                    '',
                                title: controller
                                    .weatherData
                                    ?.weather
                                    ?.temperatureText ??
                                    '',
                                value: controller
                                    .weatherData
                                    ?.weather
                                    ?.condition ??
                                    '',
                                isWeather: true,
                              ),
                            ),
                        
                            SizedBox(
                              width: Dimensions.w_4,
                            ),
                        
                            Expanded(
                              child: _buildDynamicHeaderCard(
                                imageUrl: controller
                                    .weatherData
                                    ?.weather
                                    ?.icon ??
                                    '',
                                title: '23',
                                value: 'Discussions',
                                isIcon: true,
                                isWeather: true,
                              ),
                            ),
                            SizedBox(width: Dimensions.w_4),
                            Expanded(
                              child: hasLiveFeed
                                  ? _buildDynamicHeaderCard(
                                imageUrl: liveFeed?.profileImage ??
                                    'https://wikixm-staging.s3.us-west-2.amazonaws.com/images/male.png',
                                title: liveFeed?.userName ?? '',
                                value:
                                '${liveFeed?.activity ?? ''} '
                                    '${liveFeed?.module ?? ''}',
                              )
                                  : _buildDynamicHeaderCard(
                                imageUrl: controller
                                    .weatherData
                                    ?.weather
                                    ?.icon ??
                                    '',
                                title: 'Naveen Sharma',
                                value: 'replied to comment',
                                isIcon: true,
                                isWeather: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_8),
                      Container(
                        width: Get.width,
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_4,
                          vertical: Dimensions.h_6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.h_12,
                          ),
                          border: Border.all(
                            color: const Color(0xFF0D8E9A)
                                .withValues(alpha: 0.8),
                          ),
                          gradient: const RadialGradient(
                            center: Alignment(0, 0),
                            radius: 13,
                            colors: [
                              Color(0xFF0C3A43),
                              Color(0xFF082530),
                              Color(0xFF061821),
                            ],
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: Dimensions.w_3),
                            Icon(
                              CupertinoIcons.star_fill,
                              color: Colors.yellow,
                              size: Dimensions.h_12,
                            ),
                            SizedBox(width: Dimensions.w_6),
                            Expanded(
                              child: GetBuilder(
                                init: dashboardController,
                                id: ControllerBuilders
                                    .homeSectionsController,
                                builder: (context) {
                                  return Text(
                                    "You're only "
                                        "${dashboardController.communityData?.journey?.message?.count ?? ''} "
                                        "activities away from Founder!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: FontSize.sp_11,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

Widget _buildDynamicHeaderCard({
  required String imageUrl,
  required String title,
  required String value,
  bool isWeather = false,
  bool isIcon = false
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(Dimensions.h_6),
    child: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2,
        sigmaY: 2,
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: Dimensions.w_5,
          top: Dimensions.h_2,
          bottom: Dimensions.h_2
        ),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.40),
          borderRadius: BorderRadius.circular(Dimensions.h_6),
          border: Border.all(
            color: Colors.grey,
            width: 0.5
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isIcon ? Container(
                height: Dimensions.h_22,
                width: Dimensions.h_22,
              decoration: BoxDecoration(
                color: Color(0xfff8a000),
                shape: BoxShape.circle
              ),
                child: Icon(CupertinoIcons.chat_bubble_2_fill,color: Colors.white,size: Dimensions.h_12)): AppCacheImage(
              imageUrl: imageUrl,
              size: Dimensions.h_20,
              widthSize: Dimensions.h_20,
              isShadow: false
            ),
            SizedBox(width: Dimensions.w_6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isWeather ? FontSize.sp_12 :FontSize.sp_9,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  SizedBox(height: Dimensions.h_1),
                  Text(
                    value,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.sp_8_5,
                      fontWeight: FontWeight.w500,
                      height: 1.2
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget homeInfoItem({
  required String imageUrl,
  required String title,
  required String subtitle,
  double? fontSize,
  bool showDivider = true,
}) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_1,
        vertical: Dimensions.h_4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCacheImage(
            imageUrl: imageUrl,
            size: Dimensions.h_28,
            widthSize: Dimensions.h_28,
            isShadow: false,
          ),
          SizedBox(width: Dimensions.w_6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: fontSize ??  FontSize.sp_10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: FontSize.sp_8_5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          if (showDivider)
            Container(
              margin: EdgeInsets.only(left: Dimensions.w_4,right: Dimensions.w_4),
              width: 0.5,
              height: Dimensions.h_38,
              color: Colors.grey,
            ),
        ],
      ),
    ),
  );
}

class CommunityJourneyCard extends StatelessWidget {
  final DashboardController controller;
  const CommunityJourneyCard({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_8,
        Dimensions.h_8,
        Dimensions.w_8,
        Dimensions.h_8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MY COMMUNITY JOURNEY',
                style: TextStyle(
                  color: Theme.of(context).hoverColor,
                  fontSize: FontSize.sp_13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: Theme.of(context).primaryColorDark,
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
           SizedBox(height: Dimensions.h_8),
          GetBuilder(
            id: ControllerBuilders.homeSectionsController,
            init: controller,
            builder: (controller) {
              return CommonCard(
                padding: EdgeInsets.fromLTRB(
                  Dimensions.w_8,
                  Dimensions.h_10,
                  Dimensions.w_8,
                  Dimensions.h_8,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppCacheImage(
                          imageUrl: controller.communityData?.journey?.badge?.image ?? '',
                          size: Dimensions.h_80,
                          widthSize: Dimensions.h_80,
                          isShadow: false,
                        ),
                        SizedBox(width: Dimensions.w_10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.communityData?.journey?.badge?.title ?? '',
                              style: TextStyle(
                                fontSize: FontSize.sp_18,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).hoverColor,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_2),
                            Text(
                              "Founder Candidate",
                              style: TextStyle(
                                fontSize: FontSize.sp_12,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).hoverColor,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Text(
                                  controller.communityData?.journey?.level?.points ?? '',
                                  style: TextStyle(
                                    fontSize: FontSize.sp_13,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).hoverColor,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  Icons.info_outline,
                                  size: Dimensions.h_13,
                                  color: Theme.of(context).hoverColor,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: Dimensions.h_10),
                    Row(
                      children: [
                        Expanded(
                          child: JourneyStat(
                            icon: Icons.star,
                            iconColor: Colors.white,
                            bgColor: Colors.deepPurple,
                            value: controller.communityData?.journey?.stats?[0].value ?? '',
                            title: controller.communityData?.journey?.stats?[0].title ?? '',
                          ),
                        ),
                        Expanded(
                          child: JourneyStat(
                            icon: Icons.local_fire_department,
                            iconColor: Colors.white,
                            bgColor: Colors.orange,
                            value: controller.communityData?.journey?.stats?[1].value ?? '',
                            title: controller.communityData?.journey?.stats?[1].title ?? '',
                          ),
                        ),
                        Expanded(
                          child: JourneyStat(
                            icon: Icons.near_me,
                            iconColor: Colors.white,
                            bgColor: AppColor.communityGreen,
                            value: controller.communityData?.journey?.stats?[2].value ?? '',
                            title: controller.communityData?.journey?.stats?[2].title ?? '',
                          ),
                        ),
                      ],
                    ),
                     SizedBox(height: Dimensions.h_10),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: ((controller.communityData?.journey?.progress?.percent ?? 0) / 100).clamp(0.0, 1.0),
                          minHeight: 8,
                          backgroundColor: const Color(0xffE6E6F0),
                          valueColor: const AlwaysStoppedAnimation(Color(0xff6A1BDB)),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.h_5),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                          "${controller.communityData?.journey?.progress?.percent.toString()}% ",
                          style: TextStyle(
                            color: Theme.of(context).hoverColor,
                            fontSize: FontSize.sp_13,
                            fontWeight: FontWeight.w600,
                          ),
                          ),
                         Text(
                           controller.communityData?.journey?.progress?.label ?? '',
                           style: TextStyle(
                             color: Theme.of(context).hoverColor,
                             fontSize: FontSize.sp_11,
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                       ],
                     )
                  ],
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}

class JourneyStat extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String value;
  final String title;

  const JourneyStat({
    super.key,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: Dimensions.h_12,
          backgroundColor: bgColor,
          child: Icon(
            icon,
            color: iconColor,
            size: 22,
          ),
        ),
         SizedBox(height: Dimensions.h_5),
        Text(
          value,
          style:  TextStyle(
            fontSize: FontSize.sp_13,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).hoverColor,
          ),
        ),
        Text(
          title.toLowerCase(),
          textAlign: TextAlign.center,
          style:  TextStyle(
            color: Theme.of(context).hoverColor,
            fontSize: FontSize.sp_9_5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

