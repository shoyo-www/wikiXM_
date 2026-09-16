import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/weather/shimmer.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/extensions.dart';
import 'package:wikixm/data/datasource/local/local_storage.dart';
import '../../constants/constants.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../dashboard/controller.dart';
import '../widgets/AnimatedImage.dart';
import '../widgets/cache_image.dart';
import '../widgets/common_bullet.dart';
import '../widgets/common_header.dart';
import 'events_screen_shimmer.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  void initState() {
   dashboardController.getEntertainment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
        top: false,
        bottom: false,
        bodyPadding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: GetBuilder(
          id: ControllerBuilders.entertainmentController,
          init: dashboardController,
          builder: (controller) {
            return  controller.isLoading ? EventsScreenShimmer():  CommonScrollBlurScaffold(
              expandedHeight: Dimensions.h_280,
              expandedColor: Colors.white,
              collapsedColor: Theme.of(context).highlightColor,
              hero: buildHeroHeader(isLight), slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    aiBrief()])),
              SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.h_15),
                        CommonSectionHeader(
                          title: "Upcoming Events".toUpperCase(),
                          actionText: "View All Events",
                          secondActionText: "",
                          onActionTap: () {
                          },
                        ),
                        SizedBox(height: Dimensions.h_10),
                        upcomingEventsGrid(),
                        SizedBox(height: Dimensions.h_10),
                        todayInTown(),
                        SizedBox(height: Dimensions.h_10),
                        popularCategories(),
                        SizedBox(height: Dimensions.h_10),
                        topContributors(),
                        SizedBox(height: Dimensions.h_10),
                        featureStory(context),
                        SizedBox(height: Dimensions.h_10),
                        commonArticleGrid(),
                        SizedBox(height: Dimensions.h_10),
                        eventsPlanner(),
                        SizedBox(height: Dimensions.h_10),
                        Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.h_8),
                            gradient: const LinearGradient(
                              begin: Alignment(-0.85, -0.35),
                              end: Alignment(0.85, 0.35),
                              colors: [
                              Color(0xff12119C),
                              Color(0xff2A2AD4),
                              Color(0xff4A2EE0)],
                              stops: [0.0, 0.52, 1.0])),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              Dimensions.w_8,
                              Dimensions.h_10,
                              Dimensions.w_8,
                              Dimensions.h_10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(CupertinoIcons.mail,size: Dimensions.h_18,color: AppColor.white),
                                    SizedBox(width: Dimensions.w_8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'The Pine Valley Weekender',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: FontSize.sp_14,
                                              fontWeight: FontWeight.w900,
                                              height: 1.12)),
                                          SizedBox(height: Dimensions.h_2),
                                          Text(
                                            ' Five stories. Five events. Every Thursday.',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: FontSize.sp_10,
                                              fontWeight: FontWeight.w800,
                                              height: 1.12))]))]),
                                SizedBox(height: Dimensions.h_10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
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
                                    ),
                                    SizedBox(width: Dimensions.w_8),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: Dimensions.h_8,horizontal: Dimensions.w_15),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColor.white,width: 0.5),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Get the Weekender', style: TextStyle(
                                              color: Colors.white,
                                              fontSize: FontSize.sp_10,
                                              fontWeight: FontWeight.w900
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.h_15),
                        Text(
                          ' GET INVOLVED',
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: FontSize.sp_11,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: Dimensions.h_10),
                        Row(
                          children: [
                            _buildTownNeedAction(
                              icon: CupertinoIcons.calendar,
                              color: const Color(0xff4B2EE5),
                              label: 'Submit an Event',
                              subtitle: 'Share your event with the community',
                              action: 'Submit Now',
                              isBrief: true,
                            ),
                            SizedBox(width: Dimensions.w_6),

                            _buildTownNeedAction(
                              icon: Icons.edit,
                              color: const Color(0xff216B3A),
                              label: 'Write a Review',
                              subtitle: 'Help others discover great local spots',
                              action: 'Write Now',
                              isBrief: true,
                            ),
                            SizedBox(width: Dimensions.w_6),

                            _buildTownNeedAction(
                              icon: Icons.storefront,
                              color: const Color(0xff2864C7),
                              label: 'Add Your Business',
                              subtitle: 'Get discovered by local customers',
                              action: 'Add Now',
                              isBrief: true,
                            ),
                            SizedBox(width: Dimensions.w_6),

                            _buildTownNeedAction(
                              icon: Icons.notifications,
                              color: const Color(0xffD77A00),
                              label: 'Get Weekly Picks',
                              subtitle: 'Top events, deals and more',
                              action: 'Sign Up',
                              isBrief: true,
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_15),
                        Text(
                          ' PLAN SAVE & EXPLORE',
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: FontSize.sp_11,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: Dimensions.h_10),
                        Stack(
                          children: [
                            AppCacheImage(
                              imageUrl: controller.entertainmentData?.explore?.weekend?.image ?? '',
                              size: Dimensions.h_150,
                              widthSize: Get.width,
                              radius: Dimensions.h_10,
                              alignment: Alignment(0, 1),
                              isShadow: false,
                            ),
                            Positioned.fill(child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.h_10,
                                  ),
                                  gradient: const LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Color(0xE6020B15),
                                      Color(0xA6020B15),
                                      Color(0x66020B15),
                                      Color(0x00020B15),
                                      Color(0x00020B15),
                                    ],
                                    stops: [
                                      0.08,
                                      0.25,
                                      0.48,
                                      0.78,
                                      1.0,
                                    ],
                                  ),
                                ),
                              )),
                            Positioned(
                              top: Dimensions.h_7,
                              left: Dimensions.w_7,
                              child: Text(
                                controller.entertainmentData?.explore?.weekend?.eyebrow ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_12,
                                  fontWeight: FontWeight.w900,
                                  height: 1,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.9),
                                      blurRadius: 10,
                                      offset: const Offset(2, 2),
                                    ),
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.9),
                                      blurRadius: 80,
                                      offset: const Offset(5, 2),
                                    ),
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.9),
                                      blurRadius: 80,
                                      offset: const Offset(-20, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: Dimensions.h_7,
                              right: Dimensions.w_7,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.w_7,
                                  vertical: Dimensions.h_7,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      controller.entertainmentData?.explore?.weekend?.action?.label ?? '',
                                      style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w800,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.w_3),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: AppColor.darkBlue,
                                      size: Dimensions.h_10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: Dimensions.w_8,
                              right: Dimensions.w_8,
                              bottom: Dimensions.h_8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.entertainmentData?.explore?.weekend?.dates ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_11,
                                      fontWeight: FontWeight.w900,
                                      height: 1,
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.h_4),
                                  Text(
                                    controller.entertainmentData?.explore?.weekend?.description ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_9_5,
                                      fontWeight: FontWeight.w500,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_10),
                        CommonCard(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_8,
                            vertical: Dimensions.h_8,
                          ),
                          child: Column(
                            children: [
                              CommonSectionHeader(
                                title: "Local Deals".toUpperCase(),
                                actionText: "View All Deals",
                                secondActionText: "",
                                onActionTap: () {},
                              ),
                              SizedBox(height: Dimensions.h_12),
                               ListView.builder(
                                 padding: EdgeInsets.only(left: Dimensions.w_10),
                                   physics: NeverScrollableScrollPhysics(),
                                   shrinkWrap: true,
                                   itemCount: controller.entertainmentData?.explore?.deals?.items?.length ?? 0,
                                   itemBuilder: (c,i) {
                                   var item = controller.entertainmentData?.explore?.deals?.items?[i];
                                 return Padding(
                                   padding:  EdgeInsets.only(bottom: i != (controller.entertainmentData?.explore?.deals?.items?.length ?? 0) -1  ? Dimensions.h_10 : 0),
                                   child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       AppCacheImage(
                                         imageUrl: item?.image ?? '',
                                         widthSize: Dimensions.w_80,
                                         size: Dimensions.h_40,
                                         isShadow: false,
                                         radius: Dimensions.h_6,
                                       ),
                                       SizedBox(width: Dimensions.w_10),
                                       Expanded(
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(
                                              item?.title ?? '',
                                               maxLines: 2,
                                               overflow: TextOverflow.ellipsis,
                                               style: TextStyle(
                                                 color: Theme.of(context).primaryColor,
                                                 fontSize: FontSize.sp_11,
                                                 fontWeight: FontWeight.w800,
                                               ),
                                             ),
                                             SizedBox(height: Dimensions.h_3),
                                             Text(
                                               item?.subtitle ?? '',
                                               maxLines: 1,
                                               overflow: TextOverflow.ellipsis,
                                               style: TextStyle(
                                                 color: Theme.of(context).primaryColor,
                                                 fontSize: FontSize.sp_9,
                                                 fontWeight: FontWeight.w400,
                                               ),
                                             ),
                                             SizedBox(height: Dimensions.h_4),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                 );
                               })

                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.h_10),
                        CommonCard(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_8,
                            vertical: Dimensions.h_8,
                          ),
                          child: Column(
                            children: [
                              CommonSectionHeader(
                                title: "Venue Guide".toUpperCase(),
                                actionText: "Explore Venues",
                                secondActionText: "",
                                onActionTap: () {},
                              ),
                              SizedBox(height: Dimensions.h_12),
                              ListView.builder(
                                  padding: EdgeInsets.only(left: Dimensions.w_10),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: dashboardController.entertainmentData?.explore?.venues?.items?.length ?? 0,
                                  itemBuilder: (c,i) {
                                    var item = dashboardController.entertainmentData?.explore?.venues?.items?[i];
                                    return Padding(
                                      padding:  EdgeInsets.only(bottom: i != 2 ? Dimensions.h_10 : 0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppCacheImage(
                                            imageUrl: item?.image ?? '',
                                            widthSize: Dimensions.w_80,
                                            size: Dimensions.h_40,
                                            isShadow: false,
                                            radius: Dimensions.h_6,
                                          ),
                                          SizedBox(width: Dimensions.w_10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item?.title ?? '',
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontSize: FontSize.sp_11,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                SizedBox(height: Dimensions.h_3),
                                                Text(
                                                  item?.subtitle ?? '',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontSize: FontSize.sp_9,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(height: Dimensions.h_4),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })

                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.h_10),
                        CommonCard(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_8,
                            vertical: Dimensions.h_8,
                          ),
                          child: Column(
                            children: [
                              CommonSectionHeader(
                                title: "Featured Businesses".toUpperCase(),
                                actionText: "View All",
                                secondActionText: "",
                                onActionTap: () {},
                              ),
                              SizedBox(height: Dimensions.h_12),
                              ListView.builder(
                                  padding: EdgeInsets.only(left: Dimensions.w_10),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: dashboardController.entertainmentData?.explore?.businesses?.items?.length ?? 0,
                                  itemBuilder: (c,i) {
                                    var item = dashboardController.entertainmentData?.explore?.businesses?.items?[i];
                                    return Padding(
                                      padding:  EdgeInsets.only(bottom: i != 2 ? Dimensions.h_10 : 0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppCacheImage(
                                            imageUrl: item?.image ?? '',
                                            widthSize: Dimensions.w_80,
                                            size: Dimensions.h_40,
                                            isShadow: false,
                                            radius: Dimensions.h_6,
                                          ),
                                          SizedBox(width: Dimensions.w_10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item?.title ?? '',
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontSize: FontSize.sp_11,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                SizedBox(height: Dimensions.h_3),
                                                Text(
                                                  item?.subtitle ?? '',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontSize: FontSize.sp_9,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(height: Dimensions.h_4),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.h_10),
                        CommonCard(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.sparkles,size: Dimensions.h_25,color: Theme.of(context).primaryColor),
                              SizedBox(width: Dimensions.w_12),
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
                                      "Ask anything about pine valley events, places, venues and more",
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
                                    color: const Color(0xff5B34EA)),
                                child: Icon(CupertinoIcons.chat_bubble,size: Dimensions.h_18,color: AppColor.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SliverToBoxAdapter(child: SizedBox(height: Dimensions.h_65)),
            ],
            );
          }
        ));
  }

  Widget eventsPlanner() {
    final events =
        dashboardController.entertainmentData?.events?.items ?? [];

    final filters = [
      'This Week',
      'This Weekend',
      'Next 7 Days',
      'Next 30 Days',
    ];

    Color getCategoryColor(String? category) {
      switch (category?.toLowerCase()) {
        case 'live music':
        case 'arts':
        case 'theater':
          return const Color(0xff2864F0);

        case 'local & fresh':
        case 'local & community':
          return const Color(0xff27844A);

        case 'family & fun':
        case 'festival':
          return const Color(0xffD71945);

        default:
          return const Color(0xff2864F0);
      }
    }

    String getDayName(DateTime date) {
      switch (date.weekday) {
        case DateTime.monday:
          return 'MON';
        case DateTime.tuesday:
          return 'TUE';
        case DateTime.wednesday:
          return 'WED';
        case DateTime.thursday:
          return 'THU';
        case DateTime.friday:
          return 'FRI';
        case DateTime.saturday:
          return 'SAT';
        case DateTime.sunday:
          return 'SUN';
        default:
          return '';
      }
    }

    if (events.isEmpty) {
      return const SizedBox.shrink();
    }

    final selectedIndex =
        dashboardController.selectedEventFilter;

    // Always show all events.
    // Filters only change the selected UI state.
    final displayedEvents = events;

    return CommonCard(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_8,
        vertical: Dimensions.h_8,
      ),
      child: Column(
        children: [
          CommonSectionHeader(
            title: "Upcoming Events Planner".toUpperCase(),
            actionText: "Plan Event",
            secondActionText: "",
            onActionTap: () {}),
          SizedBox(height: Dimensions.h_10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                filters.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == filters.length - 1 ? 0 : Dimensions.w_2),
                    child: GestureDetector(
                      onTap: () {
                        dashboardController.changeEventFilter(index);
                      },
                      child: _eventFilter(
                        title: filters[index],
                        isSelected: selectedIndex == index),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: displayedEvents.length,
            itemBuilder: (context, index) {
              final event = displayedEvents[index];
              final eventDate = DateTime.tryParse(event.date?.value?.toString() ?? '');
              return _upcomingEventItem(
                month: (event.date?.month ?? '').toString().toUpperCase(),
                date: event.date?.day?.toString() ?? '',
                day: eventDate != null ? getDayName(eventDate) : '',
                image: event.image?.toString() ?? '',
                title: event.title?.toString() ?? '',
                time: event.time?.label?.toString() ?? '',
                location: event.location?.label?.toString() ?? '',
                category: event.category?.label?.toString() ?? '',
                categoryColor: getCategoryColor(event.category?.label?.toString()),
                isLast: index == displayedEvents.length - 1,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget featureStory(BuildContext context) {
    final featuredNews =
        dashboardController.entertainmentData?.featuredNews;

    IconData getStatIcon(String? iconUrl) {
      final iconName = iconUrl?.split('#').last.toLowerCase();

      switch (iconName) {
        case 'heart-fill':
          return Icons.favorite;

        case 'comments':
          return CupertinoIcons.chat_bubble;

        case 'eye':
          return Icons.visibility_outlined;

        default:
          return Icons.info_outline;
      }
    }

    if (featuredNews == null) {
      return const SizedBox.shrink();
    }

    return CommonCard(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          AppCacheImage(
            imageUrl: featuredNews.image ?? '',
            size: Dimensions.h_150,
            widthSize: Get.width,
            radius: Dimensions.h_8,
            isShadow: false,
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.h_8),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF020B15).withValues(alpha: 0.55),
                    const Color(0xFF020B15).withValues(alpha: 0.45),
                    const Color(0xFF020B15).withValues(alpha: 0.25),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.35, 0.65, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Dimensions.h_10,
            left: Dimensions.w_10,
            right: Dimensions.w_10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (featuredNews.kicker ?? '').toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_8_5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),

                SizedBox(height: Dimensions.h_7),

                Text(
                  featuredNews.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_18,
                    fontWeight: FontWeight.w900,
                    height: 1.15,
                  ),
                ),

                SizedBox(height: Dimensions.h_7),

                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'By ${featuredNews.author?.name ?? ''}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_9_5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    _dot(),

                    Text(
                      featuredNews.publishedAt?.label ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSize.sp_9_5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    _dot(),

                    Text(
                      featuredNews.readTime ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSize.sp_9_5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Dimensions.h_7),

                Text(
                  featuredNews.excerpt ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_9_5,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                  ),
                ),

                SizedBox(height: Dimensions.h_8),

                Row(
                  children: List.generate(
                    featuredNews.stats?.length ?? 0,
                        (index) {
                      final stat = featuredNews.stats![index];

                      return Padding(
                        padding: EdgeInsets.only(
                          right: index ==
                              (featuredNews.stats?.length ?? 0) - 1
                              ? 0
                              : Dimensions.w_15,
                        ),
                        child: _articleStat(
                          icon: getStatIcon(stat.icon),
                          value: stat.value?.toString() ?? '',
                          iconColor: stat.id == 'likes'
                              ? const Color(0xffD71945)
                              : Colors.white
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
    );
  }

  Widget popularCategories() {
    final categories =
        dashboardController.entertainmentData?.categories;

    final items = categories?.items ?? [];

    IconData getCategoryIcon(String? iconUrl) {
      final iconName = iconUrl?.split('#').last.toLowerCase();

      switch (iconName) {
        case 'music-note-fill':
          return CupertinoIcons.music_note_2;

        case 'fork-spoon-fill':
          return Icons.restaurant;

        case 'film-fill':
          return Icons.movie;

        case 'festival-fill':
          return Icons.park;

        case 'mountain-fill':
          return Icons.terrain;

        case 'shopping-bag':
          return Icons.shopping_bag_outlined;

        case 'wellness-fill':
          return Icons.accessibility_new;

        default:
          return Icons.category_outlined;
      }
    }

    Color getToneColor(String? tone) {
      switch (tone?.toLowerCase()) {
        case 'red':
          return const Color(0xffD71945);

        case 'orange':
          return const Color(0xffF39C12);

        case 'green':
          return const Color(0xff27844A);

        case 'indigo':
          return const Color(0xff2864F0);

        default:
          return Theme.of(context).primaryColor;
      }
    }

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return CommonCard(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_8,
        vertical: Dimensions.h_8,
      ),
      child: Column(
        children: [
          CommonSectionHeader(
            title: (categories?.title ?? "Popular Categories").toUpperCase(),
            actionText: categories?.link?.label ?? "View All",
            secondActionText: "",
            onActionTap: () {},
          ),

          SizedBox(height: Dimensions.h_12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w_4,
            ),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: Dimensions.w_5,
              mainAxisSpacing: Dimensions.h_2,
              childAspectRatio: 1.6,
            ),
            itemBuilder: (context, index) {
              final item = items[index];

              return commonCategoryItem(
                icon: getCategoryIcon(item.icon),
                iconColor: getToneColor(item.tone),
                title: item.label ?? '',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget todayInTown() {
    final today = dashboardController.entertainmentData?.today;
    final items = today?.items ?? [];

    IconData getTodayIcon(String? iconUrl) {
      final iconName = iconUrl?.split('#').last.toLowerCase();

      switch (iconName) {
        case 'music-note-fill':
          return CupertinoIcons.music_note_2;

        case 'fork-spoon-fill':
          return Icons.restaurant;

        case 'palette-fill':
          return Icons.palette;

        case 'family-fill':
          return Icons.family_restroom;

        case 'cocktail':
          return Icons.local_bar;

        default:
          return Icons.category_outlined;
      }
    }

    Color getToneColor(String? tone) {
      switch (tone?.toLowerCase()) {
        case 'red':
          return const Color(0xffD71945);

        case 'orange':
          return const Color(0xffF39C12);

        case 'green':
          return const Color(0xff27844A);

        case 'indigo':
          return const Color(0xff2864F0);

        default:
          return Theme.of(context).primaryColor;
      }
    }
    return CommonCard(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_8,
        vertical: Dimensions.h_8,
      ),
      child: Column(
        children: [
          CommonSectionHeader(
            title: "Today in Pine Valley".toUpperCase(),
            actionText: "Explore",
            secondActionText: "",
            onActionTap: () {},
          ),
          SizedBox(height: Dimensions.h_12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: Dimensions.w_10,
              mainAxisSpacing: Dimensions.h_1,
              childAspectRatio: 4.5,
            ),
            itemBuilder: (context, index) {
              final item = items[index];

              return commonCategoryItem(
                icon: getTodayIcon(item.icon),
                iconColor: getToneColor(item.tone),
                title: item.label ?? '',
                subtitle:
                '${item.count?.toString() ?? '0'} ${item.countLabel ?? ''}',
                horizontal: true,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _eventFilter({
    required String title,
    bool isSelected = false,
  }) {
    return Container(
      margin: EdgeInsets.only(
        right: Dimensions.w_5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_8,
        vertical: isSelected ? Dimensions.h_8:Dimensions.h_7,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColor.darkBlue
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? null :Border.all(
          color: Theme.of(context).focusColor,
          width: 0.5)),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? Colors.white
              : Theme.of(context).primaryColor,
          fontSize: FontSize.sp_9_5,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }

  Widget _upcomingEventItem({
    required String month,
    required String date,
    required String day,
    required String image,
    required String title,
    required String time,
    required String location,
    required String category,
    required Color categoryColor,
    bool isLast = false
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_7),
      decoration: BoxDecoration(
        border: isLast ? null:Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.2))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Dimensions.w_35,
            child: Column(
              children: [
                Text(
                  month,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.sp_8_5,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
                SizedBox(height: Dimensions.h_2),
                Text(
                  date,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.sp_14,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
                SizedBox(height: Dimensions.h_2),
                Text(
                  day,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.sp_8_5,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Dimensions.w_6),
          AppCacheImage(
            imageUrl: image,
            widthSize: Dimensions.h_55,
            size: Dimensions.h_55,
            isShadow: false,
            radius: Dimensions.h_6,
          ),
          SizedBox(width: Dimensions.w_10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: Dimensions.h_3),
                Row(
                  children: [
                    Text(
                      time,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: FontSize.sp_8_5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_4,
                      ),
                      child: Text(
                        '•',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: FontSize.sp_8_5,
                        ),
                      ),
                    ),
                    Text(
                      location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: FontSize.sp_8_5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_4),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w_6,
                    vertical: Dimensions.h_3,
                  ),
                  decoration: BoxDecoration(
                    color: categoryColor.withValues(alpha: 0.10),
                    border: Border.all(
                      color: categoryColor.withValues(alpha: 0.35),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: categoryColor,
                      fontSize: FontSize.sp_8_5,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.heart,
            color: Theme.of(context).primaryColorDark,
            size: Dimensions.h_13,
          ),
          SizedBox(width: Dimensions.w_5),
        ],
      ),
    );
  }

  Widget commonArticleGrid() {
    final articles = dashboardController.entertainmentData?.news?.items ?? [];

    IconData getStatIcon(String? iconUrl) {
      final iconName = iconUrl?.split('#').last.toLowerCase();
      switch (iconName) {
        case 'heart-fill':
          return Icons.favorite;
        case 'comments':
          return CupertinoIcons.chat_bubble;
        case 'eye':
          return Icons.visibility_outlined;
        default:
          return Icons.info_outline;
      }
    }

    Color? getStatIconColor(String? id) {
      switch (id?.toLowerCase()) {
        case 'likes':
          return const Color(0xffD71945);
        default:
          return null;
      }
    }

    if (articles.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: articles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Get.width > 700 ? 4 : 2,
        crossAxisSpacing: Dimensions.w_8,
        mainAxisSpacing: Dimensions.h_8,
        childAspectRatio: Get.width > 700 ? 0.82 : 0.67),
      itemBuilder: (context, index) {
        final article = articles[index];
        final stats = article.stats ?? [];

        return CommonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: AppCacheImage(
                  imageUrl: article.image ?? '',
                  widthSize: Get.width,
                  size: Dimensions.h_95,
                  isShadow: false,
                ),
              ),
              SizedBox(height: Dimensions.h_5),
              Text(
                (article.kicker ?? '').toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: FontSize.sp_8_5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  height: 1,
                ),
              ),

              SizedBox(height: Dimensions.h_5),

              Text(
                article.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),

              SizedBox(height: Dimensions.h_7),

              Row(
                children: [
                  Flexible(
                    child: Text(
                      'By ${article.author ?? ''}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: FontSize.sp_8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  _dot(),

                  Flexible(
                    child: Text(
                      article.publishedAt?.label ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: FontSize.sp_8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Dimensions.h_7),

              Text(
                article.excerpt ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_8_5,
                  fontWeight: FontWeight.w500,
                  height: 1.25,
                ),
              ),
              SizedBox(height: Dimensions.h_8),
              Row(
                children: List.generate(stats.length, (statIndex) {
                  final stat = stats[statIndex];
                  return Padding(
                    padding: EdgeInsets.only(
                      right: statIndex == stats.length - 1
                          ? 0
                          : Dimensions.w_12,
                    ),
                    child: _articleStat(
                      icon: getStatIcon(stat.icon),
                      value: stat.value?.toString() ?? '',
                      iconColor: getStatIconColor(stat.id),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _dot() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_5,
      ),
      child: Container(
        width: Dimensions.h_2,
        height: Dimensions.h_2,
        decoration:  BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _articleStat({
    required IconData icon,
    required String value,
    Color? iconColor,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: iconColor ?? Theme.of(context).primaryColor,
          size: Dimensions.h_10,
        ),
        SizedBox(width: Dimensions.w_3),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontSize: FontSize.sp_9_5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget topContributors() {
    final contributorsData = dashboardController.entertainmentData?.contributors;
    final contributors = contributorsData?.items ?? [];
    if (contributors.isEmpty) {
      return const SizedBox.shrink();
    }
    return CommonCard(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_10,
        vertical: Dimensions.h_8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.h_3),
          Text(
            (contributorsData?.title ?? 'Top Contributors').toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: FontSize.sp_11,
              fontWeight: FontWeight.w700,
              height: 1
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contributors.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final contributor = contributors[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.w_10,
                  bottom: index == contributors.length - 1 ? 0 : Dimensions.h_7),
                child: Row(
                  children: [
                    SizedBox(
                      width: Dimensions.w_15,
                      child: Text(
                        '${contributor.rank ?? index + 1}',
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontSize: FontSize.sp_13_5,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                    ),
                    AppCacheImage(
                      imageUrl: contributor.image ?? '',
                      size: Dimensions.h_28,
                      widthSize: Dimensions.h_28,
                      isShadow: false,
                      isCircle: true,
                    ),
                    SizedBox(width: Dimensions.w_7),
                    Expanded(
                      child: Text(
                        contributor.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: FontSize.sp_12,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_5),
                    Text(
                      contributor.beat ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: FontSize.sp_9_5,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: Dimensions.h_8),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  contributorsData?.note?.text ??
                      'Thank you to our amazing community!',
                  style: TextStyle(
                    color: context.sports.primaryText,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                SizedBox(width: Dimensions.w_3),
                Icon(
                  CupertinoIcons.heart,
                  color: context.sports.primaryText,
                  size: Dimensions.h_13,
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h_2),
        ],
      ),
    );
  }
  Widget commonCategoryItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    bool horizontal = false,
  }) {
    final textContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: horizontal
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: horizontal ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: FontSize.sp_10,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),

        if (subtitle != null) ...[
          SizedBox(height: Dimensions.h_3),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: horizontal ? TextAlign.start : TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: FontSize.sp_9,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ],
      ],
    );
    if (horizontal) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: Dimensions.h_20,
          ),
          SizedBox(width: Dimensions.w_6),
          Expanded(
            child: textContent,
          ),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.h_20,
        ),
        SizedBox(height: Dimensions.h_5),
        textContent,
      ],
    );
  }

  Widget category() {
    final List<IntelligenceCategory> intelligenceList = [
      IntelligenceCategory(
        title: "Government",
        subTitle: "Intelligence",
        updates: "12 new updates",
        color: const Color(0xff1551E0),
        icon: CupertinoIcons.building_2_fill,
      ),
      IntelligenceCategory(
        title: "Sports",
        subTitle: "Intelligence",
        updates: "14 new updates",
        color: const Color(0xff15843D),
        icon: CupertinoIcons.sportscourt,
      ),
      IntelligenceCategory(
        title: "Business",
        subTitle: "Intelligence",
        updates: "9 new updates",
        color: const Color(0xff5A1FC8),
        icon: CupertinoIcons.briefcase_fill,
      ),
      IntelligenceCategory(
        title: "Education",
        subTitle: "Intelligence",
        updates: "8 new updates",
        color: const Color(0xffD83A2F),
        icon: CupertinoIcons.book_fill,
      ),
    ];
    return SizedBox(
      height: Dimensions.h_170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: intelligenceList.length,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_5),
        itemBuilder: (context, index) {
          final item = intelligenceList[index];

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: ()=> index == 1 ? Get.toNamed(AppRoutes.sports) : index == 2 ? Get.toNamed(AppRoutes.business) : null,
            child: Container(
              width: Dimensions.w_100,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: BorderRadius.circular(Dimensions.h_8),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_8,
                      vertical: Dimensions.h_5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          item.icon,
                          color: Colors.white,
                          size: Dimensions.h_30,
                        ),
                        SizedBox(height: Dimensions.h_8),
                        Text(
                          item.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          item.subTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: Dimensions.h_6),
                        Text(
                          item.updates,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: Dimensions.h_5),
                        Icon(
                          Icons.trending_up,
                          color: const Color(0xff35E35B),
                          size: Dimensions.h_35,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.w_8,
                        Dimensions.h_60,
                        Dimensions.w_8,
                        Dimensions.h_10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.h_8),
                          bottomRight: Radius.circular(Dimensions.h_8),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.0),
                            Colors.black.withValues(alpha: .25),
                            Colors.black.withValues(alpha: .45),
                            Colors.black.withValues(alpha: .80),
                          ],
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_8,
                          vertical: Dimensions.h_6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white,
                            width: .6,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Explore",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: Dimensions.w_3),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: Dimensions.h_12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget secondCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_8,
        Dimensions.h_8,
        Dimensions.w_8,
        0,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).focusColor),
          borderRadius: BorderRadius.circular(Dimensions.h_10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.sun_max,
                color: context.sports.primaryText,
                size: Dimensions.h_18,
              ),
              SizedBox(width: Dimensions.w_5),
              Text(
                'TODAY IN ${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.sports.primaryText,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: Dimensions.h_3,
                      left: Dimensions.w_8,
                      right: Dimensions.w_3),
                  child: Text(
                    'Busy day ahead! 6 government meetings, 18 community events, sunny with a high of 72°. Waterfront vote',
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontSize: FontSize.sp_9_5,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
              AppCacheImage(imageUrl: Images.sunny,size: Dimensions.h_40,widthSize: Dimensions.h_70,isShadow: false)
            ],
          ),
        ],
      ),
    );
  }


  Widget firstCard(bool isLight) {
    return CommonCard(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: Dimensions.w_4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Today's Highlights".toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_5,
                        vertical: Dimensions.h_3,
                      ),
                      decoration: BoxDecoration(
                        color: isLight ? const Color(0xFFdac0c6):const Color(0x24FF3C50),
                        border: Border.all(
                          color: isLight ? const Color(0xFFdac0c6):const Color(0x24FF3C50),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: Dimensions.h_5,
                            height: Dimensions.h_5,
                            decoration:  BoxDecoration(
                              color: isLight ? const Color(0xffD71945):Color(0xFF8C0C22),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: Dimensions.w_3),
                          Text(
                            'LIVE',
                            style: TextStyle(
                              color: !isLight ? AppColor.white: const Color(0xffD71945),
                              fontSize: FontSize.sp_8,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_10),
                CommonBulletItem(
                  text: 'Friday Night Live',
                  subtitle: 'Pine Valley Town Square',
                  trailingText: '6:00 PM',
                  leadingIcon: Icons.music_note,
                  iconColor: Colors.deepPurple,
                  iconSize: Dimensions.h_15,
                ),
                SizedBox(height: Dimensions.h_8),
                CommonBulletItem(
                  text: 'Movie in the Park',
                  subtitle: 'Pine Creek Park',
                  trailingText: '8:30 PM',
                  leadingIcon: Icons.movie,
                  iconColor: Colors.orange,
                  iconSize: Dimensions.h_15,
                ),
                SizedBox(height: Dimensions.h_8),
                CommonBulletItem(
                  text: 'Alpine Arts Walk',
                  subtitle: 'Main Street',
                  trailingText: '5:00 PM',
                  leadingIcon: Icons.palette,
                  iconColor: Colors.orange,
                  iconSize: Dimensions.h_15,
                ),
                SizedBox(height: Dimensions.h_10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        'View Full Calender',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: FontSize.sp_10,
                            fontWeight: FontWeight.w800,
                            height: 1)),
                    SizedBox(width: Dimensions.w_4),
                    Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).primaryColorDark,
                        size: Dimensions.h_13),
                    SizedBox(width: Dimensions.w_5),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: Dimensions.w_4),
        ],
      ),
    );
  }

  Widget _buildTownNeedAction({
    required IconData icon,
    required Color color,
    required String label,
    required bool isBrief,
    String? subtitle,
    String? action,
    void Function()? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: Dimensions.h_70,
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w_8,
            vertical: Dimensions.h_6,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(
              color: Theme.of(context).focusColor,
              width: 0.6,
            ),
            borderRadius: BorderRadius.circular(Dimensions.h_8),
          ),
          child: Column(
            children: [
              Container(
                width: Dimensions.h_30,
                height: Dimensions.h_30,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: Dimensions.h_15,
                ),
              ),
              SizedBox(height: Dimensions.h_8),
              Text(
                label,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeroHeader(bool isLight) {
    return GetBuilder(
      id: ControllerBuilders.entertainmentController,
      init: dashboardController,
      builder: (c) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedWeatherImage(image: c.entertainmentData?.hero?.image ?? ''),
            Positioned(
              child: Container(
                height: Dimensions.h_312,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xE6020B15).withValues(alpha: 0.60),
                      Color(0x99020B15).withValues(alpha: 0.50),
                      Color(0x99020B15).withValues(alpha: 0.40),
                      Color(0x00000000),
                      Color(0x00000000),
                    ],
                    stops: [0.08, 0.15,0.35, 0.78, 1],
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_8),
                  child: Text(
                    c.entertainmentData?.hero?.eyebrow?.toUpperCase() ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.sp_11,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.9),
                          blurRadius: 30,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_8,top: Dimensions.h_5),
                  child: Text(
                    "${c.entertainmentData?.hero?.title?.line1 ?? ''}\n${c.entertainmentData?.hero?.title?.line2 ?? ''}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.sp_24,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.9),
                          blurRadius: 30,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.w_8,top: Dimensions.h_10,right: Dimensions.w_100),
                  child: Text(
                    c.entertainmentData?.hero?.description ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.sp_12,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.9),
                          blurRadius: 30,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimensions.h_10,bottom: Dimensions.h_8,left: Dimensions.w_5,right: Dimensions.w_12),
                  height: 0.5,
                  width: Get.width,
                  color: AppColor.white,
                ),
                communityStatsSection(),
                SizedBox(height: Dimensions.h_7),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    Dimensions.w_5,
                    Dimensions.h_1,
                    Dimensions.w_5,
                    Dimensions.h_5,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: isLight ? null :[
                      BoxShadow(
                        color: Color(0xE6020B15),
                        offset: Offset(0, 150),
                        spreadRadius: 70,
                        blurRadius: 1,
                      ),
                    ],
                    gradient: isLight ? LinearGradient(
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
                    ) :LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x00000000),
                        Color(0x00000000),
                        Color(0xE6020B15).withValues(alpha: 0.78),
                        Color(0xE6020B15),
                        Color(0x99020B15),
                      ],
                      stops: [0.08,0.20, 0.35, 0.78, 1],
                    ),
                  ),
                  child: IntrinsicHeight(
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
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xff5B34EA),
                                  Color(0xff7C5CEB),
                                ],
                              ),
                              border: Border.all(
                                color: const Color(0xff5B34EA),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xff5B34EA).withValues(alpha: 0.55),
                                  offset: const Offset(0, 10),
                                  blurRadius: 22,
                                  spreadRadius: -8,
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  CupertinoIcons.calendar,
                                  size: Dimensions.h_13,
                                  color: Colors.white,
                                ),
                                SizedBox(width: Dimensions.w_5),
                                Text(
                                  "Events Calender",
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
                        Container(
                          margin: EdgeInsets.only(left: Dimensions.w_8,top: Dimensions.h_5,bottom: Dimensions.h_8),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_6,
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
                              Icon(Icons.add,size: Dimensions.h_13,color: Colors.white),
                              SizedBox(width: Dimensions.w_2),
                              Text(
                                "Submit an Event",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: Dimensions.w_8,top: Dimensions.h_5,bottom: Dimensions.h_8),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_6,
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
                              Icon(Icons.favorite_border,size: Dimensions.h_13,color: Colors.white),
                              SizedBox(width: Dimensions.w_2),
                              Text(
                                "My Favorites",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget communityStatsSection() {
    final stats =
        dashboardController.entertainmentData?.hero?.stats ?? [];

    IconData getStatIcon(String? iconUrl) {
      final iconName = iconUrl?.split('#').last.toLowerCase();

      switch (iconName) {
        case 'calendar':
          return Icons.calendar_month_outlined;

        case 'pin':
          return Icons.location_on_outlined;

        case 'storefront-fill':
          return Icons.storefront_outlined;

        case 'heart-fill':
          return Icons.favorite;

        default:
          return Icons.info_outline;
      }
    }

    if (stats.isEmpty) {
      return const SizedBox.shrink();
    }

    final rowCount = (stats.length / 2).ceil();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_5,
        vertical: Dimensions.h_5,
      ),
      child: Column(
        children: List.generate(rowCount, (rowIndex) {
          final firstIndex = rowIndex * 2;
          final secondIndex = firstIndex + 1;

          return Padding(
            padding: EdgeInsets.only(
              bottom: rowIndex == rowCount - 1
                  ? 0
                  : Dimensions.h_12,
            ),
            child: Row(
              children: [
                _communityStatItem(
                  icon: getStatIcon(stats[firstIndex].icon),
                  value: stats[firstIndex].value?.toString() ?? '',
                  label: stats[firstIndex].label ?? '',
                ),
                if (secondIndex < stats.length) ...[
                  SizedBox(width: Dimensions.w_30),
                  _communityStatItem(
                    icon: getStatIcon(stats[secondIndex].icon),
                    value: stats[secondIndex].value?.toString() ?? '',
                    label: stats[secondIndex].label ?? '',
                  ),
                ] else
                  const Spacer(),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget aiBrief() {
    return CommonCard(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppCacheImage(imageUrl: dashboardController.entertainmentData?.hero?.aiBrief?.guide?.image ?? '',
                  size: Dimensions.h_30,
                  widthSize: Dimensions.h_30,
                  isCircle: true,
                  isShadow: false),
              SizedBox(width: Dimensions.w_5),
              Text(
                'AI EVENTS BRIEF',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_12,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              const Spacer(),
              Text(
                dashboardController.entertainmentData?.hero?.aiBrief?.updated?.label  ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: FontSize.sp_9,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ],),
          SizedBox(height: Dimensions.h_8),
          Padding(
            padding:  EdgeInsets.only(left: Dimensions.w_8),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: dashboardController.entertainmentData?.hero?.aiBrief?.highlight ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: FontSize.sp_11,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_8),
              child: Text(
                dashboardController.entertainmentData?.hero?.aiBrief?.description ?? '',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              )
          ),
          SizedBox(height: Dimensions.h_10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                  'Ask AI About Tonight',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w800,
                      height: 1)),
              SizedBox(width: Dimensions.w_4),
              Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColorDark,
                  size: Dimensions.h_13),
              SizedBox(width: Dimensions.w_15),
            ],
          ),
        ],
      ),
    );
  }

  Widget _communityStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: Dimensions.h_20,
        ),
        SizedBox(width: Dimensions.w_5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.sp_16,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
            SizedBox(height: Dimensions.h_2),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget upcomingEventsGrid() {
    final events =
        dashboardController.entertainmentData?.events?.items ?? [];

    IconData getEventIcon(String? iconUrl) {
      final iconName = iconUrl?.split('#').last.toLowerCase();

      switch (iconName) {
        case 'category-grid':
          return Icons.category_outlined;

        case 'pin':
          return Icons.location_on_outlined;

        case 'clock':
          return Icons.access_time;

        default:
          return Icons.info_outline;
      }
    }

    if (events.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: events.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Dimensions.w_8,
        mainAxisSpacing: Dimensions.h_8,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final event = events[index];
        return CommonCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.h_8),
                      topLeft: Radius.circular(Dimensions.h_8),
                    ),
                    child: AppCacheImage(
                      imageUrl: event.image ?? '',
                      size: Dimensions.h_120,
                      radius: 0,
                      widthSize: Get.width,
                    ),
                  ),

                  Positioned(
                    left: Dimensions.w_7,
                    bottom: Dimensions.h_7,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w_8,
                              vertical: Dimensions.h_3,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xff5B34EA),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                            child: Text(
                              event.date?.month ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize.sp_8,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w_6,
                              vertical: Dimensions.h_4,
                            ),
                            child: Text(
                              event.date?.day ?? '',
                              style: TextStyle(
                                color: AppColor.primaryNavyNew,
                                fontSize: FontSize.sp_14,
                                fontWeight: FontWeight.w900,
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w_8,
                    vertical: Dimensions.h_5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              event.title ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: FontSize.sp_12,
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: const Color(0xffD71945),
                                size: Dimensions.h_10,
                              ),
                              SizedBox(width: Dimensions.w_3),
                              Text(
                                event.savedCount?.toString() ?? '0',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: FontSize.sp_9,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_5),
                      _eventInfo(
                        icon: getEventIcon(event.category?.icon),
                        text: event.category?.label ?? '',
                      ),
                      SizedBox(height: Dimensions.h_5),
                      _eventInfo(
                        icon: getEventIcon(event.location?.icon),
                        text: event.location?.label ?? '',
                      ),
                      SizedBox(height: Dimensions.h_5),
                      _eventInfo(
                        icon: getEventIcon(event.timeIcon),
                        text: event.time?.label ?? '',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _eventInfo({
    required IconData icon,
    required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColorDark,
          size: Dimensions.h_11),
        SizedBox(width: Dimensions.w_5),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: FontSize.sp_9,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}


