import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/dashboard/controller.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/constants.dart';
import 'package:wikixm/data/datasource/local/local_storage.dart';
import 'package:wikixm/data/datasource/remote/models/response/home_cat.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../../data/datasource/remote/models/response/home_response.dart';
import '../widgets/brief_speaking_overlay.dart';
import '../widgets/common_appbar.dart';
import '../widgets/common_scaffold.dart';
part 'home_widgets/home_widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DashboardController dashboardController =
      Get.find<DashboardController>();
  final ScrollController _scrollController = ScrollController();
  final PageController _newsPageController = PageController();
  final PageController _eventPageController = PageController();
  final PageController _fridayPageController = PageController();
  final PageController _townHallPageController = PageController();
  final FlutterTts _briefTts = FlutterTts();
  static const String _briefText =
      'Your Pine Valley brief. School budget discussion is growing. '
      'Eagles play Riverton tonight. Graduation week begins Saturday.';
  Timer? _newsAutoScrollTimer;
  double _scrollOffset = 0;
  double _briefProgress = 0;
  int _newsPage = 0;
  int _eventPage = 0;
  int _fridayPage = 0;
  int _townHallPage = 0;
  bool _isBriefPlaying = false;

  double get _heroHeight => Dimensions.h_200;
  double get _stickyBarHeight => Dimensions.h_40;
  double get _collapseRange =>
      (_heroHeight - _stickyBarHeight).clamp(1, double.infinity);
  double get _collapseProgress =>
      (_scrollOffset / _collapseRange).clamp(0.0, 1.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _briefTts.setCompletionHandler(_hideBriefPlayer);
    _briefTts.setCancelHandler(_hideBriefPlayer);
    _briefTts.setErrorHandler((_) => _hideBriefPlayer());
    _briefTts.setProgressHandler((text, start, end, word) {
      if (!mounted || text.isEmpty) return;
      setState(() {
        _briefProgress = (end / text.length).clamp(0.0, 1.0);
      });
    });
    _newsAutoScrollTimer = Timer.periodic(
      const Duration(seconds: 4),
      (_) => _advanceNewsCarousel(),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    _newsAutoScrollTimer?.cancel();
    _newsPageController.dispose();
    _eventPageController.dispose();
    _fridayPageController.dispose();
    _townHallPageController.dispose();
    _briefTts.stop();
    super.dispose();
  }

  void _advanceNewsCarousel() {
    if (!mounted || !_newsPageController.hasClients || _newsItems.length < 2) {
      return;
    }
    final nextPage = (_newsPage + 1) % _newsItems.length;
    _newsPageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  void _handleScroll() {
    final offset = _scrollController.hasClients
        ? _scrollController.offset
        : 0.0;
    if ((offset - _scrollOffset).abs() < 1) {
      return;
    }
    setState(() {
      _scrollOffset = offset.clamp(0, double.infinity);
    });
  }

  Future<void> _playPineValleyBrief() async {
    await _briefTts.stop();
    if (mounted) {
      setState(() {
        _briefProgress = 0;
        _isBriefPlaying = true;
      });
    }
    await _briefTts.setSpeechRate(0.50);
    await _briefTts.setVoice({'name': 'Karen', 'locale': 'en-US'});
    try {
      await _briefTts.speak(_briefText);
    } catch (_) {
      _hideBriefPlayer();
    }
  }

  Future<void> _stopPineValleyBrief() async {
    await _briefTts.stop();
    _hideBriefPlayer();
  }

  void _hideBriefPlayer() {
    if (mounted && _isBriefPlaying) {
      setState(() {
        _briefProgress = 0;
        _isBriefPlaying = false;
      });
    }
  }

  void _setNewsPage(int index) => setState(() => _newsPage = index);

  void _setEventPage(int index) => setState(() => _eventPage = index);

  void _setFridayPage(int index) => setState(() => _fridayPage = index);

  void _setTownHallPage(int index) => setState(() => _townHallPage = index);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final blurOpacity = (_scrollOffset / 120).clamp(0.0, 1.0);

    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: Dimensions.h_150,
                pinned: false,
                floating: false,
                foregroundColor: Colors.transparent,
                stretch: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  stretchModes: const [StretchMode.zoomBackground],
                  background: buildHeroHeader(),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimensions.h_6),
                    // buildComposer(),
                    _HomeUserEvents(state: this),
                    SizedBox(height: Dimensions.h_1),
                    _HomeBiggestConversation(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomeTownNeedsYou(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomeMattersMost(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomePosts(state: this, isTop: true),
                    SizedBox(height: Dimensions.h_15),
                    _HomeFridayNightLights(state: this),
                    SizedBox(height: Dimensions.h_8),
                    _HomeFloatingBriefPlayer(state: this),
                    // buildPosts(),
                    // buildPosts(),
                    // buildPosts(),
                    SizedBox(height: Dimensions.h_10),
                    _HomeNewsAroundYou(state: this),
                    SizedBox(height: Dimensions.h_15),
                    _HomeHappening(state: this),
                    SizedBox(height: Dimensions.h_15),
                    _HomeFriday(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomeTownHall(state: this),
                    _HomeBusinessEconomy(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomeSchoolsEducation(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomeWeatherEnvironment(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomeTownMemoryProject(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomeCommunityPulse(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomeGarageMarketplace(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomeCommunityRecognition(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomeYourImpact(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomeExploreMore(state: this),
                    SizedBox(height: Dimensions.h_10),
                    _HomeInviteNeighbors(state: this),
                    SizedBox(height: Dimensions.h_60),
                    // buildTopReporters(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: Platform.isAndroid ? -10 : -20,
            left: 0,
            right: 0,
            child: _HomePinnedTopBar(
              state: this,
              topPadding: topPadding,
              blurOpacity: blurOpacity,
            ),
          ),
          if (_isBriefPlaying)
            Positioned(
              bottom: Dimensions.h_65,
              left: 0,
              right: 0,
              child: BriefSpeakingOverlay(
                progress: _briefProgress,
                onStop: _stopPineValleyBrief,
              ),
            ),
        ],
      ),
    );
  }

  Widget buildHeroHeader() {
    final fade = 1 - _collapseProgress;
    return GetBuilder(
      id: ControllerBuilders.homeController,
      init: dashboardController,
      builder: (context) {
        final hour = DateTime.now().hour;
        final greeting = hour < 12
            ? 'Morning'
            : hour < 17
            ? 'Afternoon'
            : 'Evening';
        return Stack(
          children: [
            Container(
              height: Dimensions.h_200,
              width: Get.width,
              padding: EdgeInsets.fromLTRB(
                Dimensions.w_10,
                Dimensions.h_65,
                Dimensions.w_10,
                Dimensions.h_1,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    dashboardController.homeData?.heroBanner?.backgroundImage ??
                        '',
                    cacheKey:
                        dashboardController
                            .homeData
                            ?.heroBanner
                            ?.backgroundImage ??
                        '',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.40),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Transform.translate(
                offset: Offset(0, _collapseProgress * Dimensions.h_30),
                child: Opacity(
                  opacity: fade,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good $greeting, \n${dashboardController.homeData?.username ?? ''}!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.sp_24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_3),
                      Text(
                        'Your town. Your neighbors. Your community.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.99),
                          fontSize: FontSize.sp_11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: Dimensions.h_8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w_1,
                              vertical: Dimensions.h_1,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: Dimensions.h_5),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: Dimensions.h_16,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dashboardController
                                              .homeData
                                              ?.heroBanner
                                              ?.stats
                                              ?.neighborsOnline
                                              .toString() ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: FontSize.sp_15,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      'Neighbours Online',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: Dimensions.w_8),
                                Container(
                                  margin: EdgeInsets.only(top: Dimensions.h_5),
                                  height: Dimensions.h_25,
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: Dimensions.w_1),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w_1,
                              vertical: Dimensions.h_1,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: Dimensions.h_5),
                                  child: Icon(
                                    CupertinoIcons.chat_bubble_fill,
                                    color: Color(0xFFFFB300),
                                    size: Dimensions.h_16,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dashboardController
                                              .homeData
                                              ?.heroBanner
                                              ?.stats
                                              ?.storiesToday
                                              .toString() ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: FontSize.sp_15,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      'Stories Today',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: Dimensions.w_8),
                                Container(
                                  margin: EdgeInsets.only(top: Dimensions.h_5),
                                  height: Dimensions.h_25,
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: Dimensions.w_1),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w_1,
                              vertical: Dimensions.h_1,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: Dimensions.h_5),
                                  child: Icon(
                                    Icons.construction_rounded,
                                    color: Colors.deepOrange,
                                    size: Dimensions.h_16,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dashboardController
                                              .weatherData
                                              ?.activeAlerts
                                              .toString() ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: FontSize.sp_15,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      'Active Alerts',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -2,
              child: IgnorePointer(
                child: Container(
                  height: Dimensions.h_20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.0),
                        Colors.white.withValues(alpha: 0.30),
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
        );
      },
    );
  }
}

class _PulseChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final points = <Offset>[
      Offset(size.width * 0.04, size.height * 0.80),
      Offset(size.width * 0.18, size.height * 0.55),
      Offset(size.width * 0.32, size.height * 0.67),
      Offset(size.width * 0.45, size.height * 0.48),
      Offset(size.width * 0.58, size.height * 0.30),
      Offset(size.width * 0.70, size.height * 0.47),
      Offset(size.width * 0.84, size.height * 0.42),
      Offset(size.width * 0.94, size.height * 0.18),
    ];

    final gridPaint = Paint()
      ..color = const Color(0xFFEAF0F6)
      ..strokeWidth = 1;
    for (var i = 1; i <= 3; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final fillPath = Path()..moveTo(points.first.dx, size.height);
    for (final point in points) {
      fillPath.lineTo(point.dx, point.dy);
    }
    fillPath
      ..lineTo(points.last.dx, size.height)
      ..close();
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF20B557).withValues(alpha: 0.30),
          const Color(0xFF20B557).withValues(alpha: 0.02),
        ],
      ).createShader(Offset.zero & size);
    canvas.drawPath(fillPath, fillPaint);

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }
    final linePaint = Paint()
      ..color = const Color(0xFF1AA84C)
      ..strokeWidth = 2.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(linePath, linePaint);

    final dotPaint = Paint()..color = const Color(0xFF1AA84C);
    final dotBorderPaint = Paint()..color = Colors.white;
    for (final point in points) {
      canvas.drawCircle(point, 4, dotBorderPaint);
      canvas.drawCircle(point, 2.5, dotPaint);
    }

    final labelPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    const labels = ['1st', '3rd', '5th', 'Sat'];
    for (var i = 0; i < labels.length; i++) {
      labelPainter.text = TextSpan(
        text: labels[i],
        style: const TextStyle(
          color: Color(0xFF06124F),
          fontSize: 9,
          fontWeight: FontWeight.w700,
        ),
      );
      labelPainter.layout();
      final x = size.width * (0.18 + (i * 0.24)) - labelPainter.width / 2;
      labelPainter.paint(canvas, Offset(x, size.height - 12));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RecognitionAvatar extends StatelessWidget {
  const _RecognitionAvatar({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.h_25,
      height: Dimensions.h_25,
      margin: EdgeInsets.only(right: Dimensions.w_5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

final List<_ActivitySummaryItem> _activitySummaryItems = [
  _ActivitySummaryItem(
    icon: CupertinoIcons.chat_bubble_fill,
    value: 'Eagles Tonight',
    title: '7:30 pm',
    footer: 'Join conversation',
    footerColor: const Color(0xFF5A39D6),
    backgroundColor: const Color(0xFFF8F6FF),
    borderColor: const Color(0xFFEAE4FF),
    iconBackgroundColor: const Color(0xFF5A39D6),
  ),
  _ActivitySummaryItem(
    icon: CupertinoIcons.calendar,
    value: 'Budget Trending',
    title: '412 talking',
    footer: 'View calendar',
    footerColor: Colors.deepOrange,
    backgroundColor: const Color(0xFFFFF9F5),
    borderColor: const Color(0xFFFFEBDD),
    iconBackgroundColor: Colors.deepOrange,
  ),
  _ActivitySummaryItem(
    icon: CupertinoIcons.shield_fill,
    value: 'Graduation Week',
    title: 'This Sat',
    footer: 'View all alerts',
    footerColor: const Color(0xFF2F6BFF),
    backgroundColor: const Color(0xFFF5F8FF),
    borderColor: const Color(0xFFE2EAFF),
    iconBackgroundColor: const Color(0xFF2F6BFF),
  ),
  _ActivitySummaryItem(
    icon: CupertinoIcons.shield_fill,
    value: 'Graduation Week',
    title: 'This Sat',
    footer: 'View all alerts',
    footerColor: const Color(0xFF2F6BFF),
    backgroundColor: const Color(0xFFF5F8FF),
    borderColor: const Color(0xFFE2EAFF),
    iconBackgroundColor: const Color(0xFF2F6BFF),
  ),
];

final List<_NewsItem> _newsItems = [
  _NewsItem(
    category: 'Local News',
    title: 'Pine Valley approves plan for new downtown parking',
    summary:
        'Plan will improve access for businesses and create 37 new public parking spaces.',
    time: '1h ago',
    comments: '128 comments',
    imageUrl:
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80',
  ),
  _NewsItem(
    category: 'Schools',
    title: 'High school budget hearing set for Thursday',
    summary:
        'Parents and teachers will get one more public comment window before the vote.',
    time: '2h ago',
    comments: '84 Comment',
    imageUrl:
        'https://images.unsplash.com/photo-1509062522246-3755977927d7?auto=format&fit=crop&w=900&q=80',
  ),
  _NewsItem(
    category: 'Community',
    title: 'Farmers market expands weekend vendor spots',
    summary:
        'The town approved extra tents after spring attendance beat expectations.',
    time: '4h ago',
    comments: '42 Comment',
    imageUrl:
        'https://images.unsplash.com/photo-1488459716781-31db52582fe9?auto=format&fit=crop&w=900&q=80',
  ),
];

final List<_WeeklyEventItem> _weeklyEvents = [
  _WeeklyEventItem(
    month: 'MAY',
    day: '16',
    badge: 'TODAY',
    time: '7:30 PM',
    title: 'Eagles vs Riverton\nHome Game',
    location: 'Pine Valley Stadium',
    imageUrl:
        'https://images.unsplash.com/photo-1518604666860-9ed391f76460?auto=format&fit=crop&w=900&q=80',
  ),
  _WeeklyEventItem(
    month: 'MAY',
    day: '18',
    badge: 'SAT',
    time: '9:00 AM',
    title: 'Pine Valley Farmers\nMarket',
    location: 'Downtown Square',
    imageUrl:
        'https://images.unsplash.com/photo-1488459716781-31db52582fe9?auto=format&fit=crop&w=900&q=80',
  ),
  _WeeklyEventItem(
    month: 'MAY',
    day: '20',
    badge: 'MON',
    time: '6:00 PM',
    title: 'Town Hall Budget\nMeeting',
    location: 'Community Center',
    imageUrl:
        'https://images.unsplash.com/photo-1517048676732-d65bc937f952?auto=format&fit=crop&w=900&q=80',
  ),
];

const _FeaturedGameItem _featuredGame = _FeaturedGameItem(
  imageUrl:
      'https://images.unsplash.com/photo-1518604666860-9ed391f76460?auto=format&fit=crop&w=1200&q=80',
  schedule: 'State Semifinal - This Friday 7:00 PM',
  homeTown: 'PINE VALLEY',
  homeTeam: 'EAGLES',
  homeEmoji: '🦅',
  awayTown: 'RIVERGATE',
  awayTeam: 'RAPTORS',
  awayEmoji: '🐉',
  caption: "Let's pack the stands. Go Eagles!",
);

class _ActivitySummaryItem {
  const _ActivitySummaryItem({
    required this.icon,
    required this.value,
    required this.title,
    required this.footer,
    required this.footerColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconBackgroundColor,
  });

  final IconData icon;
  final String value;
  final String title;
  final String footer;
  final Color footerColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconBackgroundColor;
}

class _NewsItem {
  const _NewsItem({
    required this.category,
    required this.title,
    required this.summary,
    required this.time,
    required this.comments,
    required this.imageUrl,
  });

  final String category;
  final String title;
  final String summary;
  final String time;
  final String comments;
  final String imageUrl;
}

class _WeeklyEventItem {
  const _WeeklyEventItem({
    required this.month,
    required this.day,
    required this.badge,
    required this.time,
    required this.title,
    required this.location,
    required this.imageUrl,
  });

  final String month;
  final String day;
  final String badge;
  final String time;
  final String title;
  final String location;
  final String imageUrl;
}

class _FeaturedGameItem {
  const _FeaturedGameItem({
    required this.imageUrl,
    required this.schedule,
    required this.homeTown,
    required this.homeTeam,
    required this.homeEmoji,
    required this.awayTown,
    required this.awayTeam,
    required this.awayEmoji,
    required this.caption,
  });

  final String imageUrl;
  final String schedule;
  final String homeTown;
  final String homeTeam;
  final String homeEmoji;
  final String awayTown;
  final String awayTeam;
  final String awayEmoji;
  final String caption;
}

class _TownHallAvatar extends StatelessWidget {
  const _TownHallAvatar({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.h_25,
      height: Dimensions.h_25,
      margin: EdgeInsets.only(right: Dimensions.w_1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
    );
  }
}
