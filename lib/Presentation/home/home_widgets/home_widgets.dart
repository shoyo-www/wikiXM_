part of '../home.dart';

class _HomePinnedTopBar extends StatelessWidget {
  const _HomePinnedTopBar({
    required this.state,
    required this.topPadding,
    required this.blurOpacity,
  });

  final _HomeState state;
  final double topPadding;
  final double blurOpacity;

  @override
  Widget build(BuildContext context) =>
      state._buildPinnedTopBar(topPadding, blurOpacity);
}

class _HomeUserEvents extends StatelessWidget {
  const _HomeUserEvents({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.userEvents();
}

class _HomeTownNeedsYou extends StatelessWidget {
  const _HomeTownNeedsYou({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildTownNeedsYou();
}

class _HomePosts extends StatelessWidget {
  const _HomePosts({required this.state, this.isTop = false});

  final _HomeState state;
  final bool isTop;

  @override
  Widget build(BuildContext context) => state.buildPosts(isTop: isTop);
}

class _HomeMattersMost extends StatelessWidget {
  const _HomeMattersMost({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildMattersMost();
}

class _HomeFridayNightLights extends StatelessWidget {
  const _HomeFridayNightLights({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildFridayNightLights();
}

class _HomeNewsAroundYou extends StatelessWidget {
  const _HomeNewsAroundYou({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildNewsAroundYou();
}

class _HomeHappening extends StatelessWidget {
  const _HomeHappening({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildHappening();
}

class _HomeFriday extends StatelessWidget {
  const _HomeFriday({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildFriday();
}

class _HomeTownHall extends StatelessWidget {
  const _HomeTownHall({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildTownHall();
}

class _HomeBusinessEconomy extends StatelessWidget {
  const _HomeBusinessEconomy({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildBusinessEconomy();
}

class _HomeSchoolsEducation extends StatelessWidget {
  const _HomeSchoolsEducation({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildSchoolsEducation();
}

class _HomeWeatherEnvironment extends StatelessWidget {
  const _HomeWeatherEnvironment({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildWeatherEnvironment();
}

class _HomeTownMemoryProject extends StatelessWidget {
  const _HomeTownMemoryProject({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildTownMemoryProject();
}

class _HomeCommunityPulse extends StatelessWidget {
  const _HomeCommunityPulse({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildCommunityPulse();
}

class _HomeGarageMarketplace extends StatelessWidget {
  const _HomeGarageMarketplace({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildGarageMarketplace();
}

class _HomeCommunityRecognition extends StatelessWidget {
  const _HomeCommunityRecognition({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildCommunityRecognition();
}

class _HomeYourImpact extends StatelessWidget {
  const _HomeYourImpact({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildYourImpact();
}

class _HomeExploreMore extends StatelessWidget {
  const _HomeExploreMore({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildExploreMore();
}

class _HomeInviteNeighbors extends StatelessWidget {
  const _HomeInviteNeighbors({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildInviteNeighbors();
}

class _HomeBiggestConversation extends StatelessWidget {
  const _HomeBiggestConversation({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildBiggestConversation();
}

class _HomeFloatingBriefPlayer extends StatelessWidget {
  const _HomeFloatingBriefPlayer({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state._buildFloatingBriefPlayer();
}

extension _HomeWidgetBuilders on _HomeState {
  Widget _buildPinnedTopBar(double topPadding, double blurOpacity) {
    final foregroundColor = Color.lerp(
      Colors.white,
      Colors.black,
      blurOpacity,
    )!;

    return CommonBlurAppBar(
      topPadding: topPadding,
      blurOpacity: blurOpacity,
      foregroundColor: foregroundColor,
      child: _buildHeroTopRow(foregroundColor: foregroundColor),
    );
  }

  Widget userEvents() {
    final DashboardController dashboardController = Get.find<DashboardController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TODAY IN ${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: FontSize.sp_14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      color: const Color(0xFF2431A5),
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: const Color(0xFF2431A5),
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          SizedBox(
            height: Dimensions.h_45,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _activitySummaryItems.length,
              separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_8),
              itemBuilder: (context, index) {
                final item = _activitySummaryItems[index];
                return Container(
                  width: Dimensions.w_100,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w_2,
                    vertical: Dimensions.h_3,
                  ),
                  decoration: BoxDecoration(
                    color: item.backgroundColor,
                    borderRadius: BorderRadius.circular(Dimensions.h_4),
                    border: Border.all(color: item.borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            item.icon,
                            color: item.iconBackgroundColor,
                            size: Dimensions.h_20,
                          ),
                          SizedBox(width: Dimensions.w_5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  maxLines: 2,
                                  item.value,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: FontSize.sp_8_5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                'LIVE IN ${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: FontSize.sp_14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      color: const Color(0xFF2431A5),
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: const Color(0xFF2431A5),
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
              final items = List<Item>.from(
                dashboardController.homeData?.liveInTown?.items ?? [],
              );
              items.sort(
                    (a, b) => dashboardController
                    .relativeTimeWeight(a.createdAt)
                    .compareTo(
                  dashboardController.relativeTimeWeight(b.createdAt),
                ),
              );
              return SizedBox(
                height: Dimensions.h_98,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final name = item.user?.name?.trim() ?? '';

                    return SizedBox(
                      width: Dimensions.w_90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
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
                                child: Container(
                                  height: Dimensions.h_45,
                                  width: Dimensions.h_45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(item.user?.image ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -1,
                                bottom: 0,
                                child: Container(
                                  width: Dimensions.h_16,
                                  height: Dimensions.h_16,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2F6BFF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.5,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    CupertinoIcons.photo_on_rectangle,
                                    size: Dimensions.h_8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if ((item.createdAt ?? '').isNotEmpty)
                                Positioned(
                                  right: -2,
                                  top: Dimensions.h_1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.w_4,
                                      vertical: Dimensions.h_1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      dashboardController.time(item.createdAt),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_7,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: Dimensions.h_4),
                          Text(
                            name.isEmpty
                                ? '--'
                                : name.split(RegExp(r'\s+')).first,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: FontSize.sp_12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: Dimensions.h_1),
                          Text(
                            "${item.module ?? ''} ${item.activity ?? ''}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black87,
                              fontSize: FontSize.sp_9,
                              fontWeight: FontWeight.w400,
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
        ],
      ),
    );
  }

  Widget buildTownNeedsYou() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_8,
        Dimensions.h_8,
        Dimensions.w_8,
        Dimensions.h_8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F4FF),
        borderRadius: BorderRadius.circular(Dimensions.h_8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.person_2_fill,
                color: const Color(0xFF4A2CFF),
                size: Dimensions.h_15,
              ),
              SizedBox(width: Dimensions.w_8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR TOWN NEEDS YOU',
                      style: TextStyle(
                        color: const Color(0xFF2F24D9),
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_5),
                    Text(
                      'There are many ways to participate in the conversation.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: FontSize.sp_9_5,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                CupertinoIcons.chevron_right,
                color: const Color(0xFF2F24D9),
                size: Dimensions.h_13,
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_6),
          Row(
            children: [
              _buildTownNeedAction(
                icon: CupertinoIcons.chat_bubble_fill,
                color: const Color(0xFF4A2CFF),
                label: 'Join\nDiscussion',
              ),
              SizedBox(width: Dimensions.w_6),
              _buildTownNeedAction(
                icon: Icons.bar_chart_rounded,
                color: Colors.green,
                label: 'Vote in\nPoll',
              ),
              SizedBox(width: Dimensions.w_6),
              _buildTownNeedAction(
                icon: CupertinoIcons.question_circle_fill,
                color: Colors.deepOrange,
                label: 'Ask a\nQuestion',
              ),
              SizedBox(width: Dimensions.w_6),
              _buildTownNeedAction(
                icon: CupertinoIcons.camera_fill,
                color: Colors.blue,
                label: 'Share a\nPhoto',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTownNeedAction({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Expanded(
      child: Container(
        height: Dimensions.h_50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.h_4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: Dimensions.h_20),
            SizedBox(height: Dimensions.h_3),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black87,
                fontSize: FontSize.sp_8,
                fontWeight: FontWeight.w700,
                height: 1.05,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPosts({bool isTop = false}) {
    final DashboardController dashboardController = Get.find<DashboardController>();
    return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.w_8,
                  right: Dimensions.w_8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOP STORY TODAY',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: FontSize.sp_12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'View all',
                          style: TextStyle(
                            color: const Color(0xFF2431A5),
                            fontSize: FontSize.sp_10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.chevron_right,
                          color: const Color(0xFF2431A5),
                          size: Dimensions.h_11,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_6),
              GetBuilder(
                init: dashboardController,
                id: ControllerBuilders.homeController,
                builder: (context) {
                  var data = dashboardController.homeData?.topStoryToday?.story;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: Dimensions.w_8),
                          child: Stack(
                            children: [
                              AppCacheImage(
                                size: Dimensions.h_110,
                               widthSize: Get.width,
                               imageUrl:  data?.image ?? '',
                                isShadow: false,
                                borderColor: Colors.grey.shade400,
                              ),
                              Positioned(
                                top: Dimensions.h_5,
                                left: Dimensions.w_5,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.w_3,
                                    vertical: Dimensions.h_2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        CupertinoIcons.flame_fill,
                                        color: Colors.white,
                                        size: Dimensions.h_10,
                                      ),
                                      Text(
                                        'HOT DISCUSSION',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: FontSize.sp_8,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            Dimensions.w_8,
                            0,
                            Dimensions.w_8,
                            0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: Dimensions.w_5,
                                  right: Dimensions.w_5,
                                  top: Dimensions.h_2,
                                  bottom: Dimensions.h_2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2F24D9),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  maxLines: 2,
                                  'Local News'.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_8_5,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.h_4),
                              Text(
                                maxLines: 2,
                                data?.title ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: FontSize.sp_14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_6),
                              Text(
                                maxLines: 3,
                                data?.description ?? '',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: FontSize.sp_10,
                                  fontWeight: FontWeight.w500,
                                  height: 1.25,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '1h ago',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: FontSize.sp_10,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  Text(
                                    '${data?.totalComments.toString()} Comment',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: FontSize.sp_10,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.h_2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              ),
            ],
          );
  }


  Widget _buildMattersAvatar({
    required Color color,
    required String initials,
    double? size,
  }) {
    return Container(
      width: size ?? Dimensions.h_12,
      height: size ?? Dimensions.h_12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: FontSize.sp_7,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget buildMattersMost() {
    return _buildRankedCardSection(bottomMargin: Dimensions.h_10);
  }

  Widget buildFridayNightLights() {
    final item = _featuredGame;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Friday Night Lights'.toUpperCase(),
                style: TextStyle(
                  color: const Color(0xFF231A16),
                  fontSize: FontSize.sp_12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      color: const Color(0xFF2431A5),
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: const Color(0xFF2431A5),
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF202634),
              borderRadius: BorderRadius.circular(Dimensions.h_4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.h_6),
              child: Stack(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: Dimensions.w_140,
                        height: Dimensions.h_90,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(item.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: Dimensions.h_90,
                          padding: EdgeInsets.fromLTRB(
                            Dimensions.w_6,
                            Dimensions.h_8,
                            Dimensions.w_6,
                            Dimensions.h_8,
                          ),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF202634),
                                Color(0xE6202634),
                                Color(0x66202634),
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.schedule,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_9,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_10),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTeamColumn(
                                      town: item.homeTown,
                                      team: item.homeTeam,
                                      emoji: item.homeEmoji,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.w_5,
                                    ),
                                    child: Text(
                                      'VS',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: FontSize.sp_13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildTeamColumn(
                                      town: item.awayTown,
                                      team: item.awayTeam,
                                      emoji: item.awayEmoji,
                                      alignEnd: true,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.caption,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_10,
                                        fontWeight: FontWeight.w500,
                                      ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNewsAroundYou() {
    final DashboardController controller = Get.find<DashboardController>();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF4D21F3),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: FontSize.sp_12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_10),
                  Text(
                    'NEWS AROUND YOU',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSize.sp_14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      color: const Color(0xFF2431A5),
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: const Color(0xFF2431A5),
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_8),
        GetBuilder(
          init: controller,
          id: ControllerBuilders.homeSectionsController,
          builder: (context) {
            return SizedBox(
              height: Dimensions.h_280,
              child: PageView.builder(
                controller: _newsPageController,
                itemCount: controller.homeCatData?.newsAroundYou?.storyCards?.length ?? 0,
                onPageChanged: _setNewsPage,
                itemBuilder: (context, index) {
                  var item = controller.homeCatData?.newsAroundYou?.storyCards?[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.h_6),
                          border: Border.all(color: Colors.grey,width: 0.3)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.h_6),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              AppCacheImage(
                                  size: Dimensions.h_280,
                                  imageUrl: item?.image ?? '',
                                  isShadow: false,
                                  fit: BoxFit.cover,
                                  widthSize: Get.width),
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0x00000000),
                                      Color(0x99020B15),
                                      Color(0xF2020B15),
                                    ],
                                    stops: [0.25, 0.62, 1],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(Dimensions.w_10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.w_4,
                                        vertical: Dimensions.h_5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4318E8),
                                        borderRadius: BorderRadius.circular(Dimensions.h_5),
                                      ),
                                      child: Text(
                                        (item?.categoryTitle?.toUpperCase()) ?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: FontSize.sp_9,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      item?.title ?? '',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_18,
                                        fontWeight: FontWeight.w900,
                                        height: 1.25,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_12),
                                    Text(
                                      item?.description ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_11,
                                        fontWeight: FontWeight.w600,
                                        height: 1.45,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h_10),
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.chat_bubble_text,
                                          color: Colors.white,
                                          size: Dimensions.h_13,
                                        ),
                                        SizedBox(width: Dimensions.w_5),
                                        Text(
                                          item?.totalComments.toString() ?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: FontSize.sp_13,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          CupertinoIcons.flame_fill,
                                          color: Colors.red,
                                          size: Dimensions.h_15,
                                        ),
                                        SizedBox(width: Dimensions.w_5),
                                        Text(
                                          'Hot Discussion',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: FontSize.sp_10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Dimensions.h_10),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
                                      height: Dimensions.h_30,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4318E8),
                                        borderRadius: BorderRadius.circular(Dimensions.h_5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Explore All News',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: FontSize.sp_11,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.w_5),
                                          Icon(
                                            CupertinoIcons.chevron_right,
                                            color: Colors.white,
                                            size: Dimensions.h_13,
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
                      ),
                    );},
              ),
            );
          }
        ),
        SizedBox(height: Dimensions.h_6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(controller.homeCatData?.newsAroundYou?.storyCards?.length ?? 0, (index) {
            final active = index == _newsPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
              width: active ? Dimensions.w_15 : Dimensions.w_5,
              height: Dimensions.h_5,
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF2431A5)
                    : const Color(0xFFD7DCE8),
                borderRadius: BorderRadius.circular(Dimensions.h_10),
              ),
            );
          }),
        ),
        SizedBox(height: Dimensions.h_8),
      ],
    );
  }

  Widget buildHappening() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF4D21F3),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: FontSize.sp_12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_10),
                  Text(
                    "WHAT'S HAPPENING THIS WEEK",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSize.sp_14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      color: const Color(0xFF2431A5),
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: const Color(0xFF2431A5),
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_8),
        SizedBox(
          height: Dimensions.h_280,
          child: PageView.builder(
            controller: _eventPageController,
            itemCount: _weeklyEvents.length,
            onPageChanged: _setEventPage,
            itemBuilder: (context, index) =>
                _buildWeeklyEventCard(_weeklyEvents[index]),
          ),
        ),
        SizedBox(height: Dimensions.h_6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_weeklyEvents.length, (index) {
            final active = index == _eventPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
              width: active ? Dimensions.w_15 : Dimensions.w_5,
              height: Dimensions.h_5,
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF2431A5)
                    : const Color(0xFFD7DCE8),
                borderRadius: BorderRadius.circular(Dimensions.h_10),
              ),
            );
          }),
        ),
        SizedBox(height: Dimensions.h_8),
      ],
    );
  }

  Widget buildFriday() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF4D21F3),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: FontSize.sp_12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_10),

                  Text(
                    "FRIDAY NIGHT LIGHTS",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSize.sp_14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      color: const Color(0xFF2431A5),
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: const Color(0xFF2431A5),
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_8),
        SizedBox(
          height: Dimensions.h_250,
          child: PageView.builder(
            controller: _fridayPageController,
            itemCount: 3,
            onPageChanged: _setFridayPage,
            itemBuilder: (context, index) =>
                _buildFridayGameCard(_featuredGame),
          ),
        ),
        SizedBox(height: Dimensions.h_6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final active = index == _fridayPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
              width: active ? Dimensions.w_15 : Dimensions.w_5,
              height: Dimensions.h_5,
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF2431A5)
                    : const Color(0xFFD7DCE8),
                borderRadius: BorderRadius.circular(Dimensions.h_10),
              ),
            );
          }),
        ),
        SizedBox(height: Dimensions.h_8),
      ],
    );
  }

  Widget _buildFridayGameCard(_FeaturedGameItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
      child: Container(
        height: Dimensions.h_250,
        decoration: BoxDecoration(
          color: const Color(0xFF111A2D),
          borderRadius: BorderRadius.circular(Dimensions.h_8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.h_8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(item.imageUrl, fit: BoxFit.cover),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xF2111A2D),
                      Color(0xD9111A2D),
                      Color(0x66111A2D),
                      Color(0x00111A2D),
                    ],
                    stops: [0, 0.42, 0.72, 1],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  Dimensions.w_18,
                  Dimensions.h_16,
                  Dimensions.w_15,
                  Dimensions.h_15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'TONIGHT',
                        style: TextStyle(
                          color: const Color(0xFF5D3DFF),
                          fontSize: FontSize.sp_10,
                          fontWeight: FontWeight.w900,
                        ),
                        children: [
                          TextSpan(
                            text: ' · 7:30 PM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.sp_10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.h_13),
                    Text(
                      'Eagles vs\nRiverton',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSize.sp_22,
                        fontWeight: FontWeight.w900,
                        height: 1.12,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_18),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildGameTeamBadge(
                          mark: item.homeEmoji,
                          team: 'EAGLES',
                          record: '8-1',
                          size: FontSize.sp_50,
                          fSize: FontSize.sp_14,
                          rSize: FontSize.sp_14,
                        ),
                        SizedBox(width: Dimensions.w_20),
                        _buildGameTeamBadge(
                          mark: 'R',
                          team: 'RIVERTON',
                          record: '6-3',
                          size: FontSize.sp_50,
                          fSize: FontSize.sp_14,
                          rSize: FontSize.sp_14,
                          markColor: const Color(0xFF315DAD),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          width: Dimensions.w_175,
                          height: Dimensions.h_30,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4D21F3),
                            borderRadius: BorderRadius.circular(Dimensions.h_6),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'View Game',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.sp_10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.w_20),
                        Container(
                          width: Dimensions.h_30,
                          height: Dimensions.h_30,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            CupertinoIcons.chevron_right,
                            color: Color(0xFF4D21F3),
                            size: Dimensions.h_16,
                          ),
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
    );
  }

  Widget _buildGameTeamBadge({
    required String mark,
    required String team,
    required String record,
    double? size,
    double? fSize,
    double? rSize,
    Color markColor = Colors.white,
  }) {
    return Column(
      children: [
        Text(
          mark,
          style: TextStyle(
            color: markColor,
            fontSize: size ?? FontSize.sp_26,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
        SizedBox(height: Dimensions.h_5),
        Text(
          team,
          style: TextStyle(
            color: Colors.white,
            fontSize: fSize ?? FontSize.sp_10,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: Dimensions.h_2),
        Text(
          record,
          style: TextStyle(
            color: Colors.white,
            fontSize: rSize ?? FontSize.sp_10,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget buildTownHall() {
    final DashboardController dashboardController = Get.find<DashboardController>();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF4D21F3),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '4',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: FontSize.sp_12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_10),
                  Text(
                    "TOWN HALL",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSize.sp_14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      color: const Color(0xFF2431A5),
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: const Color(0xFF2431A5),
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_8),
        GetBuilder(
          init: dashboardController,
          id: ControllerBuilders.homeSectionsController,
          builder: (context) {
            return SizedBox(
              height: Dimensions.h_390,
              child: PageView.builder(
                controller: _townHallPageController,
                itemCount: dashboardController.homeCatData?.townHall?.topics?.length ?? 0,
                onPageChanged: _setTownHallPage,
                itemBuilder: (context, index) => _buildTownHallCard(dashboardController.homeCatData?.townHall?.topics?[index]),
              ),
            );
          }
        ),
        SizedBox(height: Dimensions.h_10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(dashboardController.homeCatData?.townHall?.topics?.length ?? 0, (index) {
            final active = index == _townHallPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: active ? Dimensions.w_15 : Dimensions.w_8,
              height: Dimensions.h_5,
              margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF4D21F3)
                    : const Color(0xFFD7DCE8),
                borderRadius: BorderRadius.circular(Dimensions.h_10),
              ),
            );
          }),
        ),
        SizedBox(height: Dimensions.h_8),
      ],
    );
  }

  Widget _buildTownHallCard(Topic? item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.h_8),
          border: Border.all(color: const Color(0xFFE4E7F1)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.h_8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  Dimensions.w_10,
                  Dimensions.h_10,
                  Dimensions.w_18,
                  Dimensions.h_10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.h_1,
                        horizontal: Dimensions.w_2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: const Color(0xFF0B8F2D),
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        'ACTIVE QUESTION',
                        style: TextStyle(
                          color: const Color(0xFF0B8F2D),
                          fontSize: FontSize.sp_9_5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.h_10),
                    Text(
                      item?.title ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFF111650),
                        fontSize: FontSize.sp_18,
                        fontWeight: FontWeight.w900,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.h_160,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppCacheImage(imageUrl: item?.imageUrl ?? '',radius: 0,isShadow: false,size: Dimensions.h_160,widthSize: Get.width),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white70.withValues(alpha: 0.99),
                            Colors.white54.withValues(alpha: 0.45),
                            Colors.white24,
                          ],
                          stops: const [0.05, 0.20, 0.25],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  Dimensions.w_10,
                  Dimensions.h_8,
                  Dimensions.w_18,
                  Dimensions.h_5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        _TownHallAvatar(
                          imageUrl:
                              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=100&q=80',
                        ),
                        _TownHallAvatar(
                          imageUrl:
                              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=100&q=80',
                        ),
                        _TownHallAvatar(
                          imageUrl:
                              'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=100&q=80',
                        ),
                        _TownHallAvatar(
                          imageUrl:
                              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=100&q=80',
                        ),
                        _TownHallAvatar(
                          imageUrl:
                              'https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=100&q=80',
                        ),
                        _TownHallAvatar(
                          imageUrl:
                              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=100&q=80',
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.h_5),
                    Text(
                      '12 neighbors have joined\nthe discussion',
                      style: TextStyle(
                        color: const Color(0xFF111650),
                        fontSize: FontSize.sp_11,
                        fontWeight: FontWeight.w800,
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_18),
                    Container(
                      height: Dimensions.h_35,
                      decoration: BoxDecoration(
                        color: const Color(0xFF168E24),
                        borderRadius: BorderRadius.circular(Dimensions.h_5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Join Discussion',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.sp_12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: Dimensions.w_5),
                          Icon(
                            CupertinoIcons.chevron_right,
                            color: Colors.white,
                            size: Dimensions.h_13,
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
      ),
    );
  }

  Widget buildBusinessEconomy() {
    final DashboardController dashboardController = Get.find<DashboardController>();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimensions.h_10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF4D21F3),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: FontSize.sp_12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_10),
                  Text(
                    'BUSINESS & ECONOMY',
                    style: TextStyle(
                      color: const Color(0xFF111650),
                      fontSize: FontSize.sp_14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'See all',
                    style: TextStyle(
                      color: const Color(0xFF4D21F3),
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: Dimensions.w_4),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: const Color(0xFF4D21F3),
                    size: Dimensions.h_11,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
          child: Container(
            decoration: BoxDecoration(
              // color: const Color(0xFFFF4A12).withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              border: Border.all(color: const Color(0xFFE4E7F1)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              child: GetBuilder(
                id: ControllerBuilders.homeSectionsController,
                init: dashboardController,
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          Dimensions.w_10,
                          Dimensions.h_8,
                          Dimensions.w_18,
                          Dimensions.h_15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FEATURED BUSINESS',
                              style: TextStyle(
                                color: const Color(0xFFFF4A12),
                                fontSize: FontSize.sp_9,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            Text(
                              dashboardController.homeCatData?.businessAndEconomy?.stories?.first.headline ?? '',
                              style: TextStyle(
                                color: const Color(0xFF111650),
                                fontSize: FontSize.sp_18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            Text(
                              'Local   •   Family Owned',
                              style: TextStyle(
                                color: const Color(0xFF111650),
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.h_210,
                        width: Get.width,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                           AppCacheImage(isShadow: false,radius: 0,imageUrl: dashboardController.homeCatData?.businessAndEconomy?.stories?.first.image ?? ''),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0x00000000),
                                    Color(0x33020B15),
                                    Color(0x99020B15),
                                  ],
                                  stops: [0.45, 0.72, 1],
                                ),
                              ),
                            ),
                            Positioned(
                              left: Dimensions.w_12,
                              bottom: Dimensions.h_10,
                              child: Container(
                                height: Dimensions.h_30,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.w_18,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF4A12),
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.h_6,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Learn More',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_11,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.w_10),
                                    Icon(
                                      CupertinoIcons.chevron_right,
                                      color: Colors.white,
                                      size: Dimensions.h_13,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_15),
        _buildBusinessSmallCard(
          tag: 'NEW BUSINESS',
          title: 'Mountain Roots\nBoutique',
          subtitle: 'Now Open!',
          imageUrl:
              'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?auto=format&fit=crop&w=700&q=80',
        ),
        SizedBox(height: Dimensions.h_10),
        _buildBusinessSmallCard(
          tag: 'LOCAL DEAL',
          title: '20% Off Oil Change\nat Valley Auto',
          subtitle: 'Today - May 18',
          imageUrl:
              'https://images.unsplash.com/photo-1487754180451-c456f719a1fc?auto=format&fit=crop&w=700&q=80',
          tagColor: const Color(0xFF4D21F3),
        ),
        SizedBox(height: Dimensions.h_10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            final active = index == 0;
            return Container(
              width: active ? Dimensions.w_8 : Dimensions.w_6,
              height: Dimensions.h_5,
              margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF4D21F3)
                    : const Color(0xFFD7DCE8),
                borderRadius: BorderRadius.circular(Dimensions.h_10),
              ),
            );
          }),
        ),
        SizedBox(height: Dimensions.h_10),
      ],
    );
  }

  Widget _buildBusinessSmallCard({
    required String tag,
    required String title,
    required String subtitle,
    required String imageUrl,
    Color tagColor = const Color(0xFFFF4A12),
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
      child: Container(
        height: Dimensions.h_90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.h_8),
          border: Border.all(color: const Color(0xFFE4E7F1)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.h_8),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    Dimensions.w_8,
                    Dimensions.h_8,
                    Dimensions.w_8,
                    Dimensions.h_10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tag,
                        style: TextStyle(
                          color: tagColor,
                          fontSize: FontSize.sp_8,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_8),
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFF111650),
                          fontSize: FontSize.sp_13,
                          fontWeight: FontWeight.w900,
                          height: 1.25,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFF111650),
                          fontSize: FontSize.sp_10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Dimensions.w_175,
                height: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(imageUrl, fit: BoxFit.cover),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white.withValues(alpha: 1),
                            Colors.white.withValues(alpha: 0.95),
                            Colors.white.withValues(alpha: 0.55),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                          stops: const [0, 0.10, 0.20, 0.30],
                        ),
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

  Widget buildSchoolsEducation() {
    final DashboardController dashboardController = Get.find<DashboardController>();
    return Column(
      children: [
        _buildNumberedSectionHeader('6', 'SCHOOLS & EDUCATION'),
        SizedBox(height: Dimensions.h_12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              border: Border.all(color: const Color(0xFFE4E7F1)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              child: GetBuilder(
                init: dashboardController,
                id: ControllerBuilders.homeSectionsController,
                builder: (context) {
                  return Stack(
                    children: [
                      SizedBox(
                        height: Dimensions.h_250,
                        width: Get.width,
                        child: AppCacheImage(imageUrl: dashboardController.homeCatData?.schoolsAndEducation?.stories?.first.image ?? '',isShadow: false),
                      ),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withValues(alpha: 0.98),
                                Colors.white.withValues(alpha: 0.78),
                                Colors.white.withValues(alpha: 0.12),
                                Colors.black.withValues(alpha: 0.18),
                              ],
                              stops: const [0.0, 0.34, 0.58, 1],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          Dimensions.w_12,
                          Dimensions.h_12,
                          Dimensions.w_18,
                          Dimensions.h_12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FEATURED STORY',
                              style: TextStyle(
                                color: const Color(0xFF4D21F3),
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_16),
                            Text(
                              dashboardController.homeCatData?.schoolsAndEducation?.stories?.first.title ?? '',
                              style: TextStyle(
                                color: const Color(0xFF06124F),
                                fontSize: FontSize.sp_22,
                                fontWeight: FontWeight.w900,
                                height: 1.28,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_90),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                height: Dimensions.h_30,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.w_15,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4D21F3),
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.h_5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Read Story',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_10,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.w_10),
                                    Icon(
                                      CupertinoIcons.chevron_right,
                                      color: Colors.white,
                                      size: Dimensions.h_12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_12),
        _buildEducationSpotlightCard(),
        SizedBox(height: Dimensions.h_10),
        _buildEducationEventCard(),
        SizedBox(height: Dimensions.h_12),
        _buildPagerDots(),
        SizedBox(height: Dimensions.h_10),
      ],
    );
  }

  Widget _buildEducationSpotlightCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
      child: Container(
        height: Dimensions.h_90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.h_8),
          border: Border.all(color: const Color(0xFFE4E7F1)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.h_8),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    Dimensions.w_10,
                    Dimensions.h_8,
                    Dimensions.w_6,
                    Dimensions.h_8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STUDENT SPOTLIGHT',
                        style: TextStyle(
                          color: const Color(0xFF4D21F3),
                          fontSize: FontSize.sp_8,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_12),
                      Text(
                        'Emma Johnson earns\nfull ride scholarship',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFF06124F),
                          fontSize: FontSize.sp_12,
                          fontWeight: FontWeight.w900,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Dimensions.w_160,
                height: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80',
                      fit: BoxFit.cover,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white.withValues(alpha: 1),
                            Colors.white.withValues(alpha: 0.25),
                            Colors.white.withValues(alpha: 0),
                          ],
                          stops: const [0, 0.32, 0.72],
                        ),
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

  Widget _buildEducationEventCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
      child: Container(
        height: Dimensions.h_90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.h_8),
          border: Border.all(color: const Color(0xFFE4E7F1)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.h_8),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    Dimensions.w_10,
                    Dimensions.h_8,
                    Dimensions.w_4,
                    Dimensions.h_8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UPCOMING EVENT',
                        style: TextStyle(
                          color: const Color(0xFF4D21F3),
                          fontSize: FontSize.sp_8,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_8),
                      Text(
                        'Spring Band Concert',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFF06124F),
                          fontSize: FontSize.sp_12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_6),
                      Text(
                        'May 22 - 7:00 PM\nPVHS Auditorium',
                        style: TextStyle(
                          color: const Color(0xFF06124F),
                          fontSize: FontSize.sp_9,
                          fontWeight: FontWeight.w700,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Dimensions.w_160,
                height: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1460723237483-7a6dc9d0b212?auto=format&fit=crop&w=600&q=80',
                      fit: BoxFit.cover,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white.withValues(alpha: 1),
                            Colors.white.withValues(alpha: 0.3),
                            Colors.white.withValues(alpha: 0),
                          ],
                          stops: const [0, 0.26, 0.72],
                        ),
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

  Widget buildWeatherEnvironment() {
    return Column(
      children: [
        _buildNumberedSectionHeader('7', 'WEATHER & ENVIRONMENT'),
        SizedBox(height: Dimensions.h_12),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.h_8),
            border: Border.all(color: const Color(0xFFE4E7F1)),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.h_8),
                  topRight: Radius.circular(Dimensions.h_8),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: Dimensions.h_170,
                      width: double.infinity,
                      child: Image.network(
                        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0.98),
                              Colors.white.withValues(alpha: 0.84),
                              Colors.white.withValues(alpha: 0.35),
                              Colors.transparent,
                            ],
                            stops: const [0, 0.43, 0.80, 1],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.w_12,
                        Dimensions.h_12,
                        Dimensions.w_12,
                        Dimensions.h_12,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'WEEKLY OUTLOOK',
                                  style: TextStyle(
                                    color: const Color(0xFF4D21F3),
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: Dimensions.h_16),
                                Text(
                                  'Sunny and warm\nweek ahead',
                                  style: TextStyle(
                                    color: const Color(0xFF06124F),
                                    fontSize: FontSize.sp_18,
                                    fontWeight: FontWeight.w900,
                                    height: 1.25,
                                  ),
                                ),
                                SizedBox(height: Dimensions.h_16),
                                Text(
                                  'Highs 68 - 78\nLows 42 - 50',
                                  style: TextStyle(
                                    color: const Color(0xFF06124F),
                                    fontSize: FontSize.sp_12,
                                    fontWeight: FontWeight.w700,
                                    height: 1.45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            CupertinoIcons.sun_max_fill,
                            color: Color(0xFFECB505),
                            size: Dimensions.h_55,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildWeatherInfoCard(
                icon: Icons.air,
                tag: 'WEATHER ALERT',
                title: 'Wind Advisory',
                subtitle: 'Through Thursday',
                imageUrl: null,
                isBorder: true,
              ),
              _buildWeatherInfoCard(
                icon: null,
                tag: 'COMMUNITY PHOTO',
                title: 'Beautiful sunset over\nthe Pine Valley River',
                subtitle: null,
                isBorder: false,
                imageUrl:
                    'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=500&q=80',
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_12),
        _buildPagerDots(),
        SizedBox(height: Dimensions.h_10),
      ],
    );
  }

  Widget _buildWeatherInfoCard({
    required IconData? icon,
    required String tag,
    required String title,
    required String? subtitle,
    required String? imageUrl,
    required bool? isBorder,
  }) {
    return Container(
      height: Dimensions.h_70,
      decoration: BoxDecoration(
        border: isBorder == true
            ? Border(bottom: BorderSide(color: const Color(0xFFE4E7F1)))
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: Dimensions.w_75,
            height: double.infinity,
            child: imageUrl == null
                ? Container(
                    color: const Color(0xFFEAF7FF),
                    child: Icon(
                      icon,
                      color: const Color(0xFF1B9AEF),
                      size: Dimensions.h_35,
                    ),
                  )
                : Image.network(imageUrl, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                Dimensions.w_10,
                Dimensions.h_1,
                Dimensions.w_8,
                Dimensions.h_8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tag,
                    style: TextStyle(
                      color: const Color(0xFF4D21F3),
                      fontSize: FontSize.sp_8_5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: Dimensions.h_4),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFF06124F),
                      fontSize: FontSize.sp_13,
                      fontWeight: FontWeight.w900,
                      height: 1.25,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: Dimensions.h_8),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFF06124F),
                        fontSize: FontSize.sp_9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTownMemoryProject() {
    final DashboardController dashboardController = Get.find<DashboardController>();
    return Column(
      children: [
        _buildNumberedSectionHeader('8', 'TOWN MEMORY PROJECT'),
        SizedBox(height: Dimensions.h_12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              border: Border.all(color: const Color(0xFFE4E7F1)),
            ),
            child: GetBuilder(
              id: ControllerBuilders.homeSectionsController,
              init: dashboardController,
              builder: (context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: Dimensions.h_210,
                        width: double.infinity,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.matrix(<double>[
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0,
                            0,
                            0,
                            1,
                            0,
                          ]),
                          child: AppCacheImage(imageUrl: dashboardController.homeLocalData?.townHistoryProject?.project?.latestMemory?.image ?? '',isShadow: false),
                        ),
                      ),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.white.withValues(alpha: 0.98),
                                Colors.white.withValues(alpha: 0.83),
                                Colors.white.withValues(alpha: 0.32),
                                Colors.white.withValues(alpha: 0.0),
                              ],
                              stops: const [0, 0.35, 0.66, 1],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          Dimensions.w_20,
                          Dimensions.h_15,
                          Dimensions.w_15,
                          Dimensions.h_5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MEMORY OF THE DAY',
                              style: TextStyle(
                                color: const Color(0xFF4D21F3),
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_15),
                            Text(
                              dashboardController.homeLocalData?.townHistoryProject?.project?.latestMemory?.caption ?? '',
                              style: TextStyle(
                                color: const Color(0xFF06124F),
                                fontSize: FontSize.sp_20,
                                fontWeight: FontWeight.w900,
                                height: 1.25,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_16),
                            SizedBox(height: Dimensions.h_55),
                            Container(
                              height: Dimensions.h_33,
                              width: Dimensions.w_120,
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4D21F3),
                                borderRadius: BorderRadius.circular(Dimensions.h_6),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'View Memory',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w900,
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
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_10),
      ],
    );
  }

  Widget buildCommunityPulse() {
    return Column(
      children: [
        _buildNumberedSectionHeader('9', 'COMMUNITY PULSE'),
        SizedBox(height: Dimensions.h_12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
          child: Container(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w_20,
              Dimensions.h_15,
              Dimensions.w_20,
              Dimensions.h_15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              border: Border.all(color: const Color(0xFFE4E7F1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HOW OUR TOWN FEELS',
                  style: TextStyle(
                    color: const Color(0xFF4D21F3),
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: Dimensions.h_16),
                Row(
                  children: [
                    Text(
                      '76% ',
                      style: TextStyle(
                        color: const Color(0xFF19A84A),
                        fontSize: FontSize.sp_22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                    Text(
                      'Positive',
                      style: TextStyle(
                        color: const Color(0xFF19A84A),
                        fontSize: FontSize.sp_22,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: Dimensions.w_10),
                    Icon(
                      Icons.sentiment_satisfied_alt,
                      color: const Color(0xFF19A84A),
                      size: Dimensions.h_28,
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_12),
                Text(
                  '+8% from last month',
                  style: TextStyle(
                    color: const Color(0xFF06124F),
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: Dimensions.h_16),
                SizedBox(
                  height: Dimensions.h_170,
                  width: double.infinity,
                  child: CustomPaint(painter: _PulseChartPainter()),
                ),
                SizedBox(height: Dimensions.h_15),
                _buildPulseMetricRow(
                  color: const Color(0xFF21A852),
                  icon: Icons.favorite_border,
                  title: 'Proud of our town',
                  value: '76%',
                  progress: 0.76,
                ),
                SizedBox(height: Dimensions.h_18),
                _buildPulseMetricRow(
                  color: const Color(0xFF21A852),
                  icon: Icons.shield_outlined,
                  title: 'Optimistic about future',
                  value: '64%',
                  progress: 0.64,
                ),
                SizedBox(height: Dimensions.h_18),
                _buildPulseMetricRow(
                  color: const Color(0xFFFF7A00),
                  icon: Icons.report_problem_outlined,
                  title: 'Concerned about taxes',
                  value: '28%',
                  progress: 0.28,
                ),
                SizedBox(height: Dimensions.h_18),
                _buildPulseMetricRow(
                  color: const Color(0xFFFF2D20),
                  icon: Icons.security_outlined,
                  title: 'Concerned about crime',
                  value: '18%',
                  progress: 0.18,
                ),
                SizedBox(height: Dimensions.h_22),
                Container(
                  height: Dimensions.h_33,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D21F3),
                    borderRadius: BorderRadius.circular(Dimensions.h_6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View Full Pulse',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: Dimensions.w_5),
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: Colors.white,
                        size: Dimensions.h_15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_12),
        _buildPagerDots(),
        SizedBox(height: Dimensions.h_10),
      ],
    );
  }

  Widget _buildPulseMetricRow({
    required Color color,
    required IconData icon,
    required String title,
    required String value,
    required double progress,
  }) {
    return Row(
      children: [
        Container(
          width: Dimensions.h_22,
          height: Dimensions.h_22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Dimensions.h_6),
          ),
          child: Icon(icon, color: Colors.white, size: Dimensions.h_15),
        ),
        SizedBox(width: Dimensions.w_12),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF06124F),
              fontSize: FontSize.sp_11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(width: Dimensions.w_8),
        SizedBox(
          width: Dimensions.w_50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.h_10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: Dimensions.h_5,
              backgroundColor: const Color(0xFFE8ECF5),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        SizedBox(width: Dimensions.w_8),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF06124F),
            fontSize: FontSize.sp_12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget buildGarageMarketplace() {
    final DashboardController dashboardController = Get.find<DashboardController>();
    return Column(
      children: [
        _buildNumberedSectionHeader('10', 'GARAGE & MARKETPLACE'),
        SizedBox(height: Dimensions.h_12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              border: Border.all(color: const Color(0xFFE4E7F1)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              child: GetBuilder(
                init: dashboardController,
                id: ControllerBuilders.homeSectionsController,
                builder: (context) {
                  return SizedBox(
                    height: Dimensions.h_200,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AppCacheImage(imageUrl: dashboardController.homeLocalData?.garageAndMarketplace?.popularItems?.first.image ?? '',isShadow: false),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.white.withValues(alpha: 0.98),
                                Colors.white.withValues(alpha: 0.86),
                                Colors.white.withValues(alpha: 0.30),
                                Colors.white.withValues(alpha: 0),
                              ],
                              stops: const [0, 0.42, 0.72, 1],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            Dimensions.w_12,
                            Dimensions.h_10,
                            Dimensions.w_12,
                            Dimensions.h_5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'FEATURED ITEM',
                                style: TextStyle(
                                  color: const Color(0xFF4D21F3),
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_15),
                              Text(
                                dashboardController.homeLocalData?.garageAndMarketplace?.popularItems?.first.title ?? '',
                                style: TextStyle(
                                  color: const Color(0xFF06124F),
                                  fontSize: FontSize.sp_20,
                                  fontWeight: FontWeight.w900,
                                  height: 1.25,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_12),
                              Text(
                                dashboardController.homeLocalData?.garageAndMarketplace?.popularItems?.first.priceLabel ?? '',
                                style: TextStyle(
                                  color: const Color(0xFF1AA84C),
                                  fontSize: FontSize.sp_20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_12),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.location_solid,
                                    color: const Color(0xFF06124F),
                                    size: Dimensions.h_12,
                                  ),
                                  SizedBox(width: Dimensions.w_4),
                                  Text(
                                    LocalStorage.getString(GetXStorageConstants.townName),
                                    style: TextStyle(
                                      color: const Color(0xFF06124F),
                                      fontSize: FontSize.sp_10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.h_15),
                              Container(
                                height: Dimensions.h_32,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.w_15,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4D21F3),
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.h_5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'View Item',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_10,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.w_8),
                                    Icon(
                                      CupertinoIcons.chevron_right,
                                      color: Colors.white,
                                      size: Dimensions.h_12,
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
                }
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_12),
        _buildPagerDots(),
        SizedBox(height: Dimensions.h_12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.h_5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              border: Border.all(color: const Color(0xFFE4E7F1)),
            ),
            child: Column(
              children: [
                _buildMarketplaceRow(
                  color: const Color(0xFF22A85A),
                  icon: CupertinoIcons.money_dollar_circle,
                  title: 'GARAGE SALES',
                  subtitle: '12 sales this weekend',
                ),
                _buildMarketplaceDivider(),
                _buildMarketplaceRow(
                  color: const Color(0xFF2F6BFF),
                  icon: CupertinoIcons.gift,
                  title: 'FREE ITEMS',
                  subtitle: '23 items available',
                ),
                _buildMarketplaceDivider(),
                _buildMarketplaceRow(
                  color: const Color(0xFFFF3B21),
                  icon: CupertinoIcons.search_circle,
                  title: 'WANTED ADS',
                  subtitle: '8 active requests',
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_12),
        _buildPagerDots(),
        SizedBox(height: Dimensions.h_10),
      ],
    );
  }

  Widget _buildMarketplaceRow({
    required Color color,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_8,
        vertical: Dimensions.h_8,
      ),
      child: Row(
        children: [
          Container(
            width: Dimensions.h_35,
            height: Dimensions.h_35,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Dimensions.h_6),
            ),
            child: Icon(icon, color: Colors.white, size: Dimensions.h_18),
          ),
          SizedBox(width: Dimensions.w_15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: Dimensions.h_2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: const Color(0xFF06124F),
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketplaceDivider() {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.w_65, right: Dimensions.w_15),
      child: const Divider(height: 1, color: Color(0xFFE4E7F1)),
    );
  }

  Widget buildCommunityRecognition() {
    return Column(
      children: [
        _buildNumberedSectionHeader('11', 'COMMUNITY RECOGNITION'),
        SizedBox(height: Dimensions.h_12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              border: Border.all(color: const Color(0xFFE4E7F1)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.h_170,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=900&q=80',
                          fit: BoxFit.cover,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.white.withValues(alpha: 0.98),
                                Colors.white.withValues(alpha: 0.82),
                                Colors.white.withValues(alpha: 0.15),
                                Colors.transparent,
                              ],
                              stops: const [0, 0.30, 0.65, 1],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            Dimensions.w_12,
                            Dimensions.h_15,
                            Dimensions.w_10,
                            Dimensions.h_12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'COMMUNITY HERO\nOF THE WEEK',
                                style: TextStyle(
                                  color: const Color(0xFFFF7A00),
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w900,
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_10),
                              Text(
                                'Sarah Johnson',
                                style: TextStyle(
                                  color: const Color(0xFF06124F),
                                  fontSize: FontSize.sp_20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_10),
                              Text(
                                'Thank you for making\n${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()} a better place!',
                                style: TextStyle(
                                  color: const Color(0xFF06124F),
                                  fontSize: FontSize.sp_10,
                                  fontWeight: FontWeight.w700,
                                  height: 1.35,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const _RecognitionAvatar(
                                    imageUrl:
                                        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=100&q=80',
                                  ),
                                  const _RecognitionAvatar(
                                    imageUrl:
                                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=100&q=80',
                                  ),
                                  const _RecognitionAvatar(
                                    imageUrl:
                                        'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=100&q=80',
                                  ),
                                  const _RecognitionAvatar(
                                    imageUrl:
                                        'https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=100&q=80',
                                  ),
                                  const _RecognitionAvatar(
                                    imageUrl:
                                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=100&q=80',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Dimensions.w_12,
                      Dimensions.h_5,
                      Dimensions.w_12,
                      Dimensions.h_12,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: Dimensions.h_30,
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_18,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC56B00),
                          borderRadius: BorderRadius.circular(Dimensions.h_5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Read More',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(width: Dimensions.w_10),
                            Icon(
                              CupertinoIcons.chevron_right,
                              color: Colors.white,
                              size: Dimensions.h_12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildRecognitionRow(
                    icon: CupertinoIcons.pen,
                    tag: 'TOP PHOTOGRAPHER',
                    name: 'Mike Williams',
                    imageUrl:
                        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=160&q=80',
                  ),
                  _buildRecognitionRow(
                    icon: CupertinoIcons.pen,
                    tag: 'FEATURED WRITER',
                    name: 'Linda Brown',
                    imageUrl:
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=160&q=80',
                  ),
                  _buildRecognitionRow(
                    icon: Icons.star,
                    tag: 'MOST HELPFUL NEIGHBOR',
                    name: 'Tom Anderson',
                    imageUrl:
                        'https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=160&q=80',
                  ),
                  _buildRecognitionRow(
                    icon: CupertinoIcons.clock,
                    tag: 'RISING CONTRIBUTOR',
                    name: 'Emily Welcome',
                    imageUrl:
                        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=160&q=80',
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_12),
        _buildPagerDots(),
        SizedBox(height: Dimensions.h_10),
      ],
    );
  }

  Widget _buildRecognitionRow({
    required IconData icon,
    required String tag,
    required String name,
    required String imageUrl,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
      child: Container(
        height: Dimensions.h_50,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFE4E7F1))),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                imageUrl,
                width: Dimensions.h_35,
                height: Dimensions.h_35,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: Dimensions.w_12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tag,
                    style: TextStyle(
                      color: const Color(0xFF4D21F3),
                      fontSize: FontSize.sp_9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: Dimensions.h_5),
                  Text(
                    name,
                    style: TextStyle(
                      color: const Color(0xFF06124F),
                      fontSize: FontSize.sp_11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: Dimensions.h_35,
              height: Dimensions.h_35,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F2FF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: const Color(0xFF06124F),
                size: Dimensions.h_22,
              ),
            ),
            SizedBox(width: Dimensions.w_12),
          ],
        ),
      ),
    );
  }

  Widget buildYourImpact() {
    return Column(
      children: [
        _buildNumberedSectionHeader('12', 'YOUR IMPACT'),
        SizedBox(height: Dimensions.h_12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  Dimensions.w_12,
                  Dimensions.h_10,
                  Dimensions.w_12,
                  Dimensions.h_12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF9FF),
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                  border: Border.all(color: const Color(0xFFE4E7F1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR CONTRIBUTIONS',
                      style: TextStyle(
                        color: const Color(0xFF4D21F3),
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_12),
                    _buildImpactStatRow(
                      icon: CupertinoIcons.camera,
                      value: '24',
                      label: 'Photos Shared',
                    ),
                    SizedBox(height: Dimensions.h_12),
                    _buildImpactStatRow(
                      icon: CupertinoIcons.chat_bubble_text,
                      value: '37',
                      label: 'Comments',
                    ),
                    SizedBox(height: Dimensions.h_12),
                    _buildImpactStatRow(
                      icon: CupertinoIcons.doc_text,
                      value: '5',
                      label: 'Stories',
                    ),
                    SizedBox(height: Dimensions.h_12),
                    _buildImpactStatRow(
                      icon: CupertinoIcons.question_circle,
                      value: '3',
                      label: 'Questions',
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              Container(
                padding: EdgeInsets.fromLTRB(
                  Dimensions.w_12,
                  Dimensions.h_10,
                  Dimensions.w_12,
                  Dimensions.h_12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8EF),
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                  border: Border.all(color: const Color(0xFFFFE7C6)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.emoji_events,
                      color: Color(0xFFFFB000),
                      size: Dimensions.h_35,
                    ),
                    SizedBox(width: Dimensions.w_12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOWN RANK',
                            style: TextStyle(
                              color: const Color(0xFFFF8A00),
                              fontSize: FontSize.sp_10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: Dimensions.h_6),
                          Text(
                            '#1',
                            style: TextStyle(
                              color: const Color(0xFF06124F),
                              fontSize: FontSize.sp_20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: Dimensions.h_5),
                          Text(
                            'Most Engaged Small Town\nin Wyoming',
                            style: TextStyle(
                              color: const Color(0xFF06124F),
                              fontSize: FontSize.sp_10,
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              Container(
                padding: EdgeInsets.all(Dimensions.h_12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F5FF),
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                  border: Border.all(color: const Color(0xFFEADFFF)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOU LAST MONTH',
                      style: TextStyle(
                        color: const Color(0xFF4D21F3),
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: Dimensions.h_12),
                    _buildImpactChangeRow('+12', 'More interactions'),
                    SizedBox(height: Dimensions.h_8),
                    _buildImpactChangeRow('+15', 'More minutes read'),
                    SizedBox(height: Dimensions.h_8),
                    _buildImpactChangeRow('+3', 'More neighbors helped'),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              Container(
                padding: EdgeInsets.all(Dimensions.h_12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F1FF),
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                  border: Border.all(color: const Color(0xFFE4D9FF)),
                ),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.heart,
                      color: const Color(0xFF4D21F3),
                      size: Dimensions.h_35,
                    ),
                    SizedBox(width: Dimensions.w_12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Keep it up!',
                            style: TextStyle(
                              color: const Color(0xFF06124F),
                              fontSize: FontSize.sp_12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: Dimensions.h_5),
                          Text(
                            "You're helping make ${LocalStorage.getString(GetXStorageConstants.townName)} a stronger community.",
                            style: TextStyle(
                              color: const Color(0xFF06124F),
                              fontSize: FontSize.sp_9,
                              fontWeight: FontWeight.w700,
                              height: 1.35,
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
        ),
        SizedBox(height: Dimensions.h_10),
      ],
    );
  }

  Widget _buildImpactStatRow({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF06124F), size: Dimensions.h_18),
        SizedBox(width: Dimensions.w_15),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF06124F),
            fontSize: FontSize.sp_15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: Dimensions.w_8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFF06124F),
              fontSize: FontSize.sp_11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImpactChangeRow(String value, String label) {
    return Row(
      children: [
        Text(
          '↑',
          style: TextStyle(
            color: const Color(0xFF16A34A),
            fontSize: FontSize.sp_18,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
        SizedBox(width: Dimensions.w_8),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF16A34A),
            fontSize: FontSize.sp_14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: Dimensions.w_8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFF06124F),
              fontSize: FontSize.sp_11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildExploreMore() {
    final items = [
      (CupertinoIcons.news, 'News'),
      (CupertinoIcons.calendar, 'Events Calendar'),
      (CupertinoIcons.chat_bubble_2, 'Sports'),
      (CupertinoIcons.chat_bubble_text, 'Town Talk'),
      (CupertinoIcons.building_2_fill, 'Business Directory'),
      (CupertinoIcons.house, 'Schools'),
      (CupertinoIcons.cloud_sun, 'Weather'),
      (CupertinoIcons.house_alt, 'Town Hall'),
      (CupertinoIcons.cart, 'Marketplace'),
      (CupertinoIcons.clock, 'Memories'),
      (CupertinoIcons.chart_bar, 'Community Pulse'),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EXPLORE MORE',
            style: TextStyle(
              color: const Color(0xFF06124F),
              fontSize: FontSize.sp_14,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          Text(
            'Jump to any section',
            style: TextStyle(
              color: const Color(0xFF06124F).withValues(alpha: 0.75),
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: Dimensions.h_12),
          SizedBox(
            height: Dimensions.h_85,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_8),
              itemBuilder: (context, index) {
                return _buildExploreMoreTile(
                  icon: items[index].$1,
                  label: items[index].$2,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreMoreTile({
    required IconData icon,
    required String label,
  }) {
    return Container(
      width: Dimensions.w_90,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_8,
        vertical: Dimensions.h_8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.h_8),
        border: Border.all(color: const Color(0xFFE4E7F1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF06124F), size: Dimensions.h_22),
          SizedBox(height: Dimensions.h_8),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF06124F),
              fontSize: FontSize.sp_11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInviteNeighbors() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w_12,
              Dimensions.h_10,
              Dimensions.w_12,
              Dimensions.h_12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF6B39F4),
              borderRadius: BorderRadius.circular(Dimensions.h_8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invite Your Neighbors',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: Dimensions.h_5),
                Text(
                  'Grow our community\ntogether!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: Dimensions.h_185),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.w_25),
                  height: Dimensions.h_30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.h_5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Invite Now',
                        style: TextStyle(
                          color: const Color(0xFF4D21F3),
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: Dimensions.w_10),
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: const Color(0xFF4D21F3),
                        size: Dimensions.h_13,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.h_68,
            left: 0,
            right: 0,
            child: SizedBox(
              height: Dimensions.h_180,
              width: double.infinity,
              child: Image.asset(Images.invite, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedSectionHeader(String number, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.h_10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF4D21F3),
                ),
                alignment: Alignment.center,
                child: Text(
                  number,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF111650),
                  fontSize: FontSize.sp_14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'See all',
                style: TextStyle(
                  color: const Color(0xFF4D21F3),
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: Dimensions.w_4),
              Icon(
                CupertinoIcons.chevron_right,
                color: const Color(0xFF4D21F3),
                size: Dimensions.h_11,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPagerDots({int activeIndex = 0, int count = 4}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final active = index == activeIndex;
        return Container(
          width: active ? Dimensions.w_8 : Dimensions.w_6,
          height: Dimensions.h_5,
          margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF4D21F3) : const Color(0xFFD7DCE8),
            borderRadius: BorderRadius.circular(Dimensions.h_10),
          ),
        );
      }),
    );
  }

  Widget _buildWeeklyEventCard(_WeeklyEventItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              border: Border.all(color: const Color(0xFFE4E7F1)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(item.imageUrl, fit: BoxFit.cover),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.99),
                          Colors.white.withValues(alpha: 0.94),
                          Colors.white.withValues(alpha: 0.68),
                          Colors.white24,
                        ],
                        stops: const [0.25, 0.30, 0.45, 0.55],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: Dimensions.w_10,
                    top: Dimensions.h_10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_20,
                          ),
                          height: Dimensions.h_80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(Dimensions.h_6),
                            border: Border.all(color: const Color(0xFFE1E5F4)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.month,
                                style: TextStyle(
                                  color: const Color(0xFF4318E8),
                                  fontSize: FontSize.sp_10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_4),
                              Text(
                                item.day,
                                style: TextStyle(
                                  color: const Color(0xFF111650),
                                  fontSize: FontSize.sp_26,
                                  fontWeight: FontWeight.w900,
                                  height: 1,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_8),
                              Text(
                                item.badge,
                                style: TextStyle(
                                  color: const Color(0xFF4318E8),
                                  fontSize: FontSize.sp_9,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.w_10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.time,
                                style: TextStyle(
                                  color: const Color(0xFF4318E8),
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_10),
                              Text(
                                item.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: FontSize.sp_20,
                                  fontWeight: FontWeight.w900,
                                  height: 1.25,
                                ),
                              ),
                              SizedBox(height: Dimensions.h_15),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.location_solid,
                                    color: Colors.black87,
                                    size: Dimensions.h_12,
                                  ),
                                  SizedBox(width: Dimensions.w_4),
                                  Expanded(
                                    child: Text(
                                      item.location,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: FontSize.sp_10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: Dimensions.w_18,
                    right: Dimensions.w_70,
                    bottom: Dimensions.h_16,
                    child: Container(
                      height: Dimensions.h_30,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4318E8),
                        borderRadius: BorderRadius.circular(Dimensions.h_5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'View Event Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.sp_10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: Dimensions.w_20),
                          Icon(
                            CupertinoIcons.chevron_right,
                            color: Colors.white,
                            size: Dimensions.h_13,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: Dimensions.w_10,
            bottom: Dimensions.h_18,
            child: Container(
              width: Dimensions.h_30,
              height: Dimensions.h_30,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x220C1460),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
                border: Border.all(color: const Color(0xFFE4E7F1)),
              ),
              child: Icon(
                CupertinoIcons.chevron_right,
                color: const Color(0xFF4318E8),
                size: Dimensions.h_18,
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget buildBiggestConversation() {
    final DashboardController controller = Get.find<DashboardController>();
    return GetBuilder(
      id: ControllerBuilders.homeController,
      init: controller,
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
          padding: EdgeInsets.fromLTRB(
            Dimensions.w_8,
            Dimensions.h_8,
            Dimensions.w_8,
            Dimensions.h_8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFF3B30).withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(Dimensions.h_8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: const Color(0xFFFF3B30),
                    size: Dimensions.h_15,
                  ),
                  SizedBox(width: Dimensions.w_4),
                  Text(
                    controller.homeData?.topConversation?.title?.toUpperCase() ?? '',
                    style: TextStyle(
                      color: const Color(0xFFFF3B30),
                      fontSize: FontSize.sp_11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.homeData?.topConversation?.conversation?.headline ?? '',
                          style: TextStyle(
                            color: const Color(0xFF1B2461),
                            fontSize: FontSize.sp_13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: Dimensions.h_8),
                        Row(
                          children: [
                            Text(
                              '5 neighbors discussing',
                              style: TextStyle(
                                color: const Color(0xFF1B2461),
                                fontSize: FontSize.sp_8_5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: Dimensions.w_8),
                            Container(
                              width: Dimensions.h_4,
                              height: Dimensions.h_4,
                              decoration: const BoxDecoration(
                                color: Color(0xFF8F98B2),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: Dimensions.w_8),
                            Text(
                              '15% support',
                              style: TextStyle(
                                color: const Color(0xFF22B34F),
                                fontSize: FontSize.sp_9_5,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.h_10),
                          child: LinearProgressIndicator(
                            value: 0.15,
                            minHeight: Dimensions.h_3,
                            backgroundColor: const Color(0xFFD5D8DE),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF2EC35A),
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.h_15),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: Dimensions.h_25,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF1B12),
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.h_4,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Join Discussion',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w900
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Dimensions.w_10),
                            Expanded(
                              child: Container(
                                height: Dimensions.h_25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.h_4,
                                  ),
                                  border: Border.all(
                                    color: const Color(0xFFBEC7FF),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'View Details',
                                  style: TextStyle(
                                    color: const Color(0xFF1B2461),
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: Dimensions.w_10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.h_4),
                    child: SizedBox(
                      width: Dimensions.w_120,
                      height: Dimensions.h_90,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AppCacheImage(imageUrl: controller.homeData?.topConversation?.conversation?.image ?? ''),
                          Positioned(
                            right: Dimensions.w_5,
                            top: Dimensions.h_5,
                            child: Container(
                              padding: EdgeInsets.only(
                                left: Dimensions.w_2,
                                right: Dimensions.w_2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF1B12),
                                borderRadius: BorderRadius.circular(Dimensions.h_1),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Text(
                                    controller.homeData?.topConversation?.conversation?.totalComments.toString() ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_9,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.w_4),
                                  Text(
                                    'comments',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.sp_9,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildTeamColumn({
    required String town,
    required String team,
    required String emoji,
    bool alignEnd = false,
  }) {
    return IgnorePointer(
      child: Row(
        mainAxisAlignment: alignEnd
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: alignEnd
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                town,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.sp_8,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                team,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.sp_14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRankedCardSection({required double bottomMargin}) {
    final DashboardController dashboardController = Get.find<DashboardController>();
    return GetBuilder(
      id: ControllerBuilders.homeController,
      init: dashboardController,
      builder: (_) {
        final storyCards = dashboardController.homeData?.whatMattersMost?.storyCards ?? [];
        return Container(
          margin: EdgeInsets.fromLTRB(
            Dimensions.w_10,
            Dimensions.h_5,
            Dimensions.w_10,
            bottomMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('WHAT MATTERS MOST',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSize.sp_12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'View all',
                        style: TextStyle(
                          color: const Color(0xFF2431A5),
                          fontSize: FontSize.sp_10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: const Color(0xFF2431A5),
                        size: Dimensions.h_11,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_10),
              SizedBox(
                height: Dimensions.h_120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: storyCards.length,
                  separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_10),
                  itemBuilder: (context, index) {
                    final item = storyCards[index];
                    final badgeColor = _rankBadgeColor(index);
                    final avatarInitials = _storyInitials(item.reporterName, index,);
                    final avatarColors = _avatarColors(index);

                    return Container(
                      width: Dimensions.w_100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Dimensions.h_6),
                        border: Border.all(color: badgeColor,width: 0.5)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(Dimensions.h_6),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: Dimensions.h_55,
                                  width: double.infinity,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          item.image ?? '',
                                          cacheKey: item.image ?? '',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: Dimensions.w_4,
                                  top: Dimensions.h_4,
                                  child: Container(
                                    width: Dimensions.w_20,
                                    height: Dimensions.h_20,
                                    decoration: BoxDecoration(
                                      color: badgeColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.2,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_10,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              Dimensions.w_4,
                              Dimensions.h_3,
                              Dimensions.w_4,
                              0,
                            ),
                            child: Text(
                              item.title ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: const Color(0xFF1E1E1E),
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              Dimensions.w_4,
                              Dimensions.h_2,
                              Dimensions.w_4,
                              0,
                            ),
                            child: Text(
                              '${item.totalComments ?? 0} comments',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: FontSize.sp_9,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              Dimensions.w_4,
                              0,
                              Dimensions.w_4,
                              Dimensions.h_3,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Dimensions.w_28,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      _buildMattersAvatar(
                                        color: avatarColors[0],
                                        initials: avatarInitials[0],
                                      ),
                                      Positioned(
                                        left: Dimensions.w_8,
                                        child: _buildMattersAvatar(
                                          color: avatarColors[1],
                                          initials: avatarInitials[1],
                                        ),
                                      ),
                                      Positioned(
                                        left: Dimensions.w_15,
                                        child: _buildMattersAvatar(
                                          color: avatarColors[2],
                                          initials: avatarInitials[2],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.w_5,
                                    vertical: Dimensions.h_1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEEF2FF),
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.h_10,
                                    ),
                                  ),
                                  child: Text(
                                    '${item.totalLikes ?? 0}',
                                    style: TextStyle(
                                      color: const Color(0xFF3F64FF),
                                      fontSize: FontSize.sp_9,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins',
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
              ),
            ],
          ),
        );
      },
    );
  }

  Color _rankBadgeColor(int index) {
    const colors = [
      Color(0xFF1D2B8F),
      Color(0xFF7A2FC6),
      Color(0xFF2E8B57),
      Color(0xFFFF7A00),
      Color(0xFFE91E63),
    ];
    return colors[index % colors.length];
  }

  List<Color> _avatarColors(int index) {
    const colors = [
      Color(0xFFD99A77),
      Color(0xFFC28B68),
      Color(0xFFE0B086),
      Color(0xFF8A5A44),
      Color(0xFFB97A56),
    ];
    return [
      colors[index % colors.length],
      colors[(index + 1) % colors.length],
      colors[(index + 2) % colors.length],
    ];
  }

  List<String> _storyInitials(String? name, int index) {
    final parts = (name ?? '')
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    final initials = parts.isEmpty
        ? 'U${index + 1}'
        : parts.take(2).map((part) => part[0].toUpperCase()).join();

    return [initials, '${index + 1}', '+'];
  }

  Widget _buildHeroTopRow({Color? foregroundColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _buildLocationRow(
            isLight: foregroundColor == null,
            overrideColor: foregroundColor,
          ),
        ),
        Row(
          children: [
            Row(
              children: [
                AppCacheImage(imageUrl: dashboardController.weatherData?.weather?.icon ?? '',
                size: Dimensions.h_16,
                widthSize: Dimensions.h_16,
                isShadow: false),
                SizedBox(width: Dimensions.w_2),
                GetBuilder(
                  init: dashboardController,
                  id: ControllerBuilders.homeController,
                  builder: (context) {
                    return Text(
                      dashboardController.weatherData?.weather?.temperatureText ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: foregroundColor,
                        fontFamily: 'Poppins',
                        fontSize: FontSize.sp_14,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(width: Dimensions.w_8),
            _buildHeaderAction(
              icon: CupertinoIcons.bell,
              badgeText: '3',
              isLight: true,
              isGlass: false,
              overrideColor: foregroundColor,
            ),
            SizedBox(width: Dimensions.w_8),
            _buildHeaderAction(
              icon: CupertinoIcons.search,
              isGlass: false,
              isLight: foregroundColor == null,
              overrideColor: foregroundColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationRow({bool isLight = false, Color? overrideColor}) {
    final color =
        overrideColor ?? (isLight ? Colors.white : const Color(0xFF111827));
    final DashboardController dashboardController =
        Get.find<DashboardController>();

    return Row(
      children: [
        Icon(
          CupertinoIcons.location_solid,
          color: color,
          size: Dimensions.h_12,
        ),
        SizedBox(width: Dimensions.w_2),
        GetBuilder(
          init: dashboardController,
          id: ControllerBuilders.homeController,
          builder: (context) {
            return Flexible(
              child: Text(
                dashboardController.homeData?.heroBanner?.location?.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontSize: FontSize.sp_13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            );
          },
        ),
        SizedBox(width: Dimensions.w_3),
        Icon(CupertinoIcons.chevron_down, color: color, size: Dimensions.h_12),
      ],
    );
  }

  Widget _buildHeaderAction({
    required IconData icon,
    String? badgeText,
    bool isLight = false,
    bool isGlass = false,
    Color? overrideColor,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        isGlass
            ? ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: Container(
                    width: Dimensions.h_25,
                    height: Dimensions.h_25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withValues(alpha: 0.28),
                          Colors.white.withValues(alpha: 0.10),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.35),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      icon,
                      color:
                          overrideColor ??
                          (isLight ? Colors.white : const Color(0xFF111827)),
                      size: Dimensions.h_15,
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: Dimensions.h_25,
                height: Dimensions.h_25,
                child: Icon(
                  icon,
                  color:
                      overrideColor ??
                      (isLight ? Colors.white : const Color(0xFF111827)),
                  size: Dimensions.h_18,
                ),
              ),
        if (badgeText != null)
          Positioned(
            right: isGlass ? -1 : 2,
            top: isGlass ? 3 : 5,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w_4,
                vertical: Dimensions.h_1,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFFF3B30),
                shape: BoxShape.circle,
              ),
              child: Text(
                badgeText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.sp_8,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFloatingBriefPlayer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_8,
        Dimensions.h_6,
        Dimensions.w_8,
        Dimensions.h_6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F3FF),
        borderRadius: BorderRadius.circular(Dimensions.h_6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.sparkles,
                      color: const Color(0xFF2F24D9),
                      size: Dimensions.h_12,
                    ),
                    SizedBox(width: Dimensions.w_4),
                    Expanded(
                      child: Text(
                        'YOUR PINE VALLEY BRIEF',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFF2F24D9),
                          fontSize: FontSize.sp_10,
                          fontWeight: FontWeight.w900,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_5),
                _buildBriefPoint('School budget discussion is growing.'),
                SizedBox(height: Dimensions.h_3),
                _buildBriefPoint('Eagles play Riverton tonight.'),
                SizedBox(height: Dimensions.h_3),
                _buildBriefPoint('Graduation week begins Saturday.'),
              ],
            ),
          ),
          SizedBox(width: Dimensions.w_8),
          SizedBox(
            width: Dimensions.w_145,
            child: Column(
              children: [
                _buildBriefButton(
                  icon: _isBriefPlaying
                      ? CupertinoIcons.stop_circle_fill
                      : CupertinoIcons.play_circle_fill,
                  label: _isBriefPlaying ? 'Stop' : 'Listen Brief',
                  filled: true,
                  onTap: _isBriefPlaying
                      ? _stopPineValleyBrief
                      : _playPineValleyBrief,
                ),
                SizedBox(height: Dimensions.h_8),
                _buildBriefButton(
                  icon: CupertinoIcons.chat_bubble_text,
                  label: 'Ask AI Guide',
                  onTap: () => Get.toNamed(AppRoutes.askGuide),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBriefPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          CupertinoIcons.checkmark_circle_fill,
          color: const Color(0xFF2F24D9),
          size: Dimensions.h_10,
        ),
        SizedBox(width: Dimensions.w_4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black87,
              fontSize: FontSize.sp_9,
              fontWeight: FontWeight.w500,
              height: 1.1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBriefButton({
    required IconData icon,
    required String label,
    bool filled = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Dimensions.h_22,
        decoration: BoxDecoration(
          color: filled ? const Color(0xFF4519E6) : Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.h_4),
          border: filled
              ? null
              : Border.all(color: const Color(0xFF4519E6), width: 0.5),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: filled ? Colors.white : const Color(0xFF4519E6),
              size: Dimensions.h_12,
            ),
            SizedBox(width: Dimensions.w_5),
            Text(
              label,
              style: TextStyle(
                color: filled ? Colors.white : const Color(0xFF4519E6),
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
