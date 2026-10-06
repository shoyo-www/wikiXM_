import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/command_center/controller.dart';
import 'package:wikixm/Presentation/events/events_screen_shimmer.dart';
import 'package:wikixm/Presentation/widgets/ai_brief.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/AnimatedImage.dart';
import '../widgets/cache_image.dart';
import '../widgets/circular_percent.dart';
import '../widgets/common_header.dart';

class CommandCenterScreen extends StatefulWidget {
  const CommandCenterScreen({super.key});

  @override
  State<CommandCenterScreen> createState() => _CommandCenterScreenState();
}

class _CommandCenterScreenState extends State<CommandCenterScreen> {
  final CommandCenterController commandCenterController = Get.put(CommandCenterController());

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetBuilder(
        id: ControllerBuilders.commandCenterController,
        init: commandCenterController,
        builder: (controller) {
          return controller.isLoading
              ? EventsScreenShimmer()
              : CommonScrollBlurScaffold(
                  showBack: true,
                  expandedHeight: Dimensions.h_256,
                  expandedColor: Colors.white,
                  collapsedColor: Theme.of(context).highlightColor,
                  hero: buildHeroHeader(isLight),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(height: Dimensions.h_5),
                          aiBrief(),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Dimensions.h_15),
                            topPriorities(isLight),
                            SizedBox(height: Dimensions.h_15),
                            activeBills(isLight),
                            SizedBox(height: Dimensions.h_15),
                            civicActivePlan(isLight),
                            SizedBox(height: Dimensions.h_15),
                            liveCivic(isLight),
                            SizedBox(height: Dimensions.h_15),
                            communityTownHall(isLight),
                            SizedBox(height: Dimensions.h_15),
                            communityProgress(isLight),
                            SizedBox(height: Dimensions.h_15),
                            topRepresentatives(isLight),
                            SizedBox(height: Dimensions.h_15),
                            upcomingMeeting(isLight),
                            SizedBox(height: Dimensions.h_20),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget democracyStartsAtHome(bool isLight) {
    return Stack(
      children: [
        AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/politics/politics2/capitol-hero-sm.webp', size: Dimensions.h_180, widthSize: Get.width, isShadow: false, radius: Dimensions.h_8),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppColor.primaryNavyNew.withValues(alpha: 1), AppColor.primaryNavyNew.withValues(alpha: 0.98), AppColor.primaryNavyNew.withValues(alpha: 0.90), AppColor.primaryNavyNew.withValues(alpha: 0.85)],
                stops: const [0.0, 0.35, 0.65, 1.0],
              ),
            ),
          ),
        ),
        Container(
          height: Dimensions.h_180,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Democracy starts at home.',
                style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_18, fontWeight: FontWeight.w800, height: 1.1),
              ),
              SizedBox(height: Dimensions.h_8),
              Text(
                'Stay informed. Ask questions. Participate.',
                style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
              ),
              Text(
                'Help shape the future of Pine Valley.',
                style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: _democracyActionButton(title: 'Join Town Hall', subtitle: 'See upcoming events', color: const Color(0xFF23704F), onTap: () {}),
                  ),

                  SizedBox(width: Dimensions.w_5),

                  Expanded(
                    child: _democracyActionButton(title: 'Ask a Question', subtitle: 'Voice your concerns', color: const Color(0xFF345BB2), onTap: () {}),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_5),
              Row(
                children: [
                  Expanded(
                    child: _democracyActionButton(title: 'Follow Officials', subtitle: 'Stay connected', color: const Color(0xFF5737B8), onTap: () {}),
                  ),

                  SizedBox(width: Dimensions.w_5),

                  Expanded(
                    child: _democracyActionButton(title: 'Track Bills', subtitle: 'Stay informed', color: Colors.transparent, isOutlined: true, onTap: () {}),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _democracyActionButton({required String title, required String subtitle, required Color color, required VoidCallback onTap, bool isOutlined = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Dimensions.h_45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Dimensions.h_7),
          border: isOutlined ? Border.all(color: AppColor.white.withValues(alpha: 0.55), width: 1) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: Dimensions.h_3),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_9, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget topPriorities(bool isLight) {
    final priorities = [
      {
        'number': '1',
        'title': 'Traffic Safety on Front Street',
        'stage': 'DISCUSSION STAGE',
        'momentum': '91%',
        'assigned': 'City Council assigned',
        'participants': '428 participants',
        'support': '87% community support',
        'color': isLight ? const Color(0xff267257) : const Color(0xff70B894),
        'bgColor': isLight ? const Color(0xffE7F3EC) : const Color(0xff20382D),
      },
      {
        'number': '2',
        'title': 'Affordable Housing Solutions',
        'stage': 'RESEARCH STAGE',
        'momentum': '72%',
        'assigned': 'Representative response pending',
        'participants': '312 participants',
        'support': '72% community support',
        'color': isLight ? const Color(0xffA5660B) : const Color(0xffD99A5A),
        'bgColor': isLight ? const Color(0xffFFF3DD) : const Color(0xff3D2E20),
      },
      {
        'number': '3',
        'title': 'Downtown Parking Management Plan',
        'stage': 'FINAL PROPOSAL',
        'momentum': '86%',
        'assigned': 'Council vote · May 28',
        'participants': '186 participants',
        'support': '91% community support',
        'color': isLight ? const Color(0xff2860B5) : const Color(0xff78A6E8),
        'bgColor': isLight ? const Color(0xffE6F0FC) : const Color(0xff1F3048),
      },
    ];
    return Column(
      children: [
        CommonSectionHeader(title: 'Top community priorities'.toUpperCase(), actionText: '', secondActionText: "", onActionTap: () {}),
        SizedBox(height: Dimensions.h_10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: priorities.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: Get.width > 700 ? 3 : 2, crossAxisSpacing: Dimensions.w_8, mainAxisSpacing: Dimensions.h_8, childAspectRatio: Get.width > 700 ? 1.45 : 0.70),
          itemBuilder: (context, index) {
            final item = priorities[index];
            final color = item['color'] as Color;
            final bgColor = item['bgColor'] as Color;
            final momentum = item['momentum'] as String;

            return CommonCard(
              padding: EdgeInsets.all(Dimensions.w_8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: Dimensions.h_18,
                        height: Dimensions.h_18,
                        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                        child: Center(
                          child: Text(
                            item['number'] as String,
                            style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_8, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.w_5),
                      Expanded(
                        child: Text(
                          item['title'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_2),
                    decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                    child: Text(
                      item['stage'] as String,
                      style: TextStyle(color: color, fontSize: FontSize.sp_8, fontWeight: FontWeight.w900, letterSpacing: 0.4),
                    ),
                  ),
                  SizedBox(height: Dimensions.h_7),
                  Stack(
                    children: [
                      Container(
                        height: Dimensions.h_3,
                        width: double.infinity,
                        decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(Dimensions.h_10)),
                      ),
                      FractionallySizedBox(
                        widthFactor: double.parse(momentum.replaceAll('%', '')) / 100,
                        child: Container(
                          height: Dimensions.h_3,
                          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(Dimensions.h_10)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_3),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$momentum momentum',
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                    ),
                  ),

                  SizedBox(height: Dimensions.h_7),

                  Row(
                    children: [
                      ...List.generate(
                        3,
                        (avatarIndex) => Container(
                          width: Dimensions.h_18,
                          height: Dimensions.h_18,
                          margin: EdgeInsets.only(right: Dimensions.w_2),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12 + (avatarIndex * 0.05)),
                            shape: BoxShape.circle,
                            border: Border.all(color: Theme.of(context).cardColor, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              ['SM', 'JT', 'RM'][avatarIndex],
                              style: TextStyle(color: color, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: Dimensions.h_18,
                        height: Dimensions.h_18,
                        decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            '+22',
                            style: TextStyle(color: color, fontSize: FontSize.sp_7, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.h_7),

                  Row(
                    children: [
                      Icon(CupertinoIcons.building_2_fill, size: Dimensions.h_13, color: Theme.of(context).primaryColor.withValues(alpha: 0.65)),
                      SizedBox(width: Dimensions.w_4),
                      Expanded(
                        child: Text(
                          item['assigned'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_6),
                  Row(
                    children: [
                      Icon(CupertinoIcons.person_2, size: Dimensions.h_13, color: Theme.of(context).primaryColor.withValues(alpha: 0.65)),
                      SizedBox(width: Dimensions.w_4),
                      Text(
                        item['participants'] as String,
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_6),
                  Row(
                    children: [
                      Icon(CupertinoIcons.heart, size: Dimensions.h_13, color: Theme.of(context).primaryColor.withValues(alpha: 0.65)),
                      SizedBox(width: Dimensions.w_4),
                      Text(
                        item['support'] as String,
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_7),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(Dimensions.h_6),
                      border: Border.all(color: color.withValues(alpha: 0.20), width: 0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View progress',
                          style: TextStyle(color: color, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(width: Dimensions.w_5),
                        Icon(Icons.arrow_forward, color: color, size: Dimensions.h_12),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget civicActivePlan(bool isLight) {
    final actions = [
      {'number': '1', 'time': '2 MIN', 'title': 'Comment on AB 8421', 'description': 'Public comment closes May 24', 'button': ''},
      {'number': '2', 'time': '5 MIN', 'title': 'Review the Town Hall agenda', 'description': "Help prioritize Tuesday's discussion", 'button': 'Review agenda'},
      {'number': '3', 'time': '5 MIN', 'title': 'Support Black Nugget crossing', 'description': 'Implementation is 91% complete', 'button': 'View progress'},
    ];

    final primaryColor = isLight ? const Color(0xff246B4D) : const Color(0xff3F8A68);

    final lightBlue = isLight ? const Color(0xffE5F1FC) : const Color(0xff1D3348);

    final borderColor = isLight ? const Color(0xffC9DDED) : const Color(0xff304A60);

    return Column(
      children: [
        CommonSectionHeader(title: 'Your civic action plan'.toUpperCase(), actionText: '', secondActionText: "", onActionTap: () {}),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(begin: Alignment(-0.9, 0.4), end: Alignment(0.9, -0.4), colors: [Color(0xFF203E62), Color(0xFF286847)]),
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PERSONALIZED FOR SEAN',
                            style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, letterSpacing: 0.5),
                          ),
                          SizedBox(height: Dimensions.h_2),
                          Text(
                            'Three meaningful actions you can take this week',
                            style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: Dimensions.h_3),
                          Text(
                            'About 12 minutes total · Earn up to 85 civic points',
                            style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Dimensions.w_8),
                    Container(
                      width: Dimensions.h_38,
                      height: Dimensions.h_38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.white.withValues(alpha: 0.7), width: 1),
                      ),
                      child: Center(
                        child: Text(
                          '3',
                          style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: actions.length,
                itemBuilder: (context, index) {
                  final item = actions[index];
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: borderColor, width: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: Dimensions.h_20,
                          height: Dimensions.h_20,
                          decoration: BoxDecoration(color: isLight ? const Color(0xffE7F3EC) : const Color(0xff20382D), shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              item['number']!,
                              style: TextStyle(color: primaryColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.w_6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['time']!,
                                style: TextStyle(color: isLight ? const Color(0xff2860B5) : const Color(0xff78A6E8), fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                item['title']!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800),
                              ),
                              SizedBox(height: Dimensions.h_2),
                              Text(
                                item['description']!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.7), fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        if (item['button']!.isNotEmpty) ...[
                          SizedBox(width: Dimensions.w_5),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(Dimensions.h_5),
                              border: Border.all(color: borderColor, width: 0.5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  item['button']!,
                                  style: TextStyle(color: isLight ? const Color(0xff2860B5) : const Color(0xff78A6E8), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w800),
                                ),
                                if (item['button'] == 'View progress') ...[SizedBox(width: Dimensions.w_3), Icon(Icons.arrow_forward, size: Dimensions.h_10, color: isLight ? const Color(0xff2860B5) : const Color(0xff78A6E8))],
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: Dimensions.h_8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                decoration: BoxDecoration(color: lightBlue, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.bell, size: Dimensions.h_16, color: isLight ? const Color(0xff2860B5) : const Color(0xff78A6E8)),
                    SizedBox(width: Dimensions.w_6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Stay connected to local civic activity',
                            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: Dimensions.h_2),
                          Text(
                            'Representative replies, issue milestones, and meeting reminders.',
                            style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.7), fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Dimensions.w_10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_5),
                      decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(Dimensions.h_5)),
                      child: Text(
                        'Follow updates',
                        style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800),
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

  Widget activeBills(bool isLight) {
    final bills = [
      {
        'level': 'CITY',
        'code': 'AB 8421',
        'title': 'Safe Routes & Crosswalk Improvements',
        'status': 'Committee review',
        'description': 'Funds three priority pedestrian crossings near Front Street.',
        'impact': 'LOCAL IMPACT',
        'impactValue': 'High',
        'bottomText': 'Public comment closes May 24',
        'comments': '126',
        'color': isLight ? const Color(0xff267257) : const Color(0xff70B894),
        'badgeColor': isLight ? const Color(0xffE7F3EC) : const Color(0xff20382D),
      },
      {
        'level': 'COUNTY',
        'code': 'KC 2026-0148',
        'title': 'Regional Housing & Transit Access',
        'status': 'Public hearing',
        'description': 'Connects housing targets with expanded eastside transit service.',
        'impact': 'LOCAL IMPACT',
        'impactValue': 'High',
        'bottomText': 'Hearing May 27',
        'comments': '94',
        'color': isLight ? const Color(0xff6950A5) : const Color(0xffA58BD8),
        'badgeColor': isLight ? const Color(0xffF0EAF9) : const Color(0xff302746),
      },
      {
        'level': 'STATE',
        'code': 'HB 2221',
        'title': 'Urban Wildlife & Habitat Protection',
        'status': 'Senate consideration',
        'description': 'Creates habitat standards alongside growth planning.',
        'impact': 'LOCAL IMPACT',
        'impactValue': 'High',
        'bottomText': 'Possible vote this week',
        'comments': '211',
        'color': isLight ? const Color(0xff267257) : const Color(0xff70B894),
        'badgeColor': isLight ? const Color(0xffE7F3EC) : const Color(0xff20382D),
      },
      {
        'level': 'FEDERAL',
        'code': 'H.R. 4812',
        'title': 'Community Infrastructure Resilience Act',
        'status': 'Subcommittee',
        'description': 'Makes cities eligible for flood, bridge, and emergency grants.',
        'impact': 'LOCAL IMPACT',
        'impactValue': 'High',
        'bottomText': 'Representative response received',
        'comments': '172',
        'color': isLight ? const Color(0xffA5660B) : const Color(0xffD99A5A),
        'badgeColor': isLight ? const Color(0xffFFF3DD) : const Color(0xff3D2E20),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active bills affecting Issaquah'.toUpperCase(),
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: Dimensions.h_3),
        Padding(
          padding: EdgeInsets.only(left: Dimensions.w_5),
          child: Text(
            textAlign: TextAlign.start,
            'Track legislation at every level and understand what it could mean',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: bills.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: Get.width > 700 ? 4 : 2, crossAxisSpacing: Dimensions.w_8, mainAxisSpacing: Dimensions.h_8, childAspectRatio: Get.width > 700 ? 1.25 : 0.90),
          itemBuilder: (context, index) {
            final item = bills[index];

            final color = item['color'] as Color;
            final badgeColor = item['badgeColor'] as Color;

            return CommonCard(
              padding: EdgeInsets.all(Dimensions.w_8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_2),
                        decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                        child: Text(
                          item['level'] as String,
                          style: TextStyle(color: color, fontSize: FontSize.sp_9, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        item['code'] as String,
                        style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.7), fontSize: FontSize.sp_9, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  Text(
                    item['title'] as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800, height: 1.2),
                  ),

                  SizedBox(height: Dimensions.h_10),
                  Text(
                    item['status'].toString().toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: color, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: Dimensions.h_7),
                  Text(
                    item['description'] as String,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.8), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1.3),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_4),
                    decoration: BoxDecoration(color: isLight ? const Color(0xffFFF3D6) : const Color(0xff3D3020), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                    child: Row(
                      children: [
                        Text(
                          item['impact'] as String,
                          style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.7), fontSize: FontSize.sp_9, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text(
                          item['impactValue'] as String,
                          style: TextStyle(color: isLight ? const Color(0xff8A5A12) : const Color(0xffD9A35A), fontSize: FontSize.sp_9, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.h_5),
                  Row(
                    children: [
                      Icon(CupertinoIcons.clock, size: Dimensions.h_10, color: Theme.of(context).primaryColor.withValues(alpha: 0.65)),
                      SizedBox(width: Dimensions.w_3),
                      Expanded(
                        child: Text(
                          item['bottomText'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.75), fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(width: Dimensions.w_8),
                      Icon(CupertinoIcons.chat_bubble, size: Dimensions.h_12, color: Theme.of(context).primaryColor.withValues(alpha: 0.65)),
                      SizedBox(width: Dimensions.w_2),
                      Text(
                        item['comments'] as String,
                        style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.75), fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget communityProgress(bool isLight) {
    final green = isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark;

    final items = [
      {'category': 'COMMUNITY DISCUSSION', 'percentage': 38, 'title': 'Front Street Traffic Safety', 'description': 'Residents are refining three leading safety ideas.', 'next': 'Research review'},
      {'category': 'RESEARCH & EVIDENCE', 'percentage': 52, 'title': 'Affordable Housing Options', 'description': 'Housing data and comparable programs are being reviewed.', 'next': 'Draft solutions'},
      {'category': 'COMMUNITY REVIEW', 'percentage': 78, 'title': 'Downtown Parking Plan', 'description': 'The recommended plan is open for final resident feedback.', 'next': 'Council decision'},
      {'category': 'IMPLEMENTATION', 'percentage': 91, 'title': 'Black Nugget Road Crossing', 'description': 'Scheduling and contractor coordination are underway.', 'next': 'Installation'},
      {'category': 'RESULTS CONFIRMED', 'percentage': 100, 'title': 'Library Evening Hours', 'description': 'Extended hours completed a successful 60-day trial.', 'next': 'Result adopted'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Community Progress'.toUpperCase(),
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800),
        ),

        SizedBox(height: Dimensions.h_3),

        Padding(
          padding: EdgeInsets.only(left: Dimensions.w_5),
          child: Text(
            'Track active community initiatives and see what happens next.',
            style: TextStyle(color: Theme.of(context).highlightColor.withValues(alpha: 0.8), fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
          ),
        ),

        SizedBox(height: Dimensions.h_10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Get.width > 900
                ? 5
                : Get.width > 650
                ? 3
                : 2,
            crossAxisSpacing: Dimensions.w_8,
            mainAxisSpacing: Dimensions.h_8,
            childAspectRatio: Get.width > 900
                ? 0.92
                : Get.width > 650
                ? 0.95
                : 1.1,
          ),
          itemBuilder: (context, index) {
            final item = items[index];

            final percentage = item['percentage'] as int;

            return CommonCard(
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_2, vertical: Dimensions.h_3),
                          decoration: BoxDecoration(color: isLight ? const Color(0xffEAF2FA) : const Color(0xff263A4D), borderRadius: BorderRadius.circular(Dimensions.h_4)),
                          child: Text(
                            item['category'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: isLight ? const Color(0xff315F96) : const Color(0xff8DB9E5), fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w800, letterSpacing: .2, height: 1),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.w_6),
                      Text(
                        '$percentage%',
                        style: TextStyle(color: green, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w900, height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_12),
                  Text(
                    item['title'] as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1.2),
                  ),
                  SizedBox(height: Dimensions.h_10),
                  Text(
                    item['description'] as String,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.78), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1.35),
                  ),
                  const Spacer(),
                  Container(
                    height: Dimensions.h_4,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Theme.of(context).highlightColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: percentage / 100,
                      child: Container(
                        decoration: BoxDecoration(color: green, borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.h_8),
                  Text(
                    'Next: ${item['next']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget upcomingMeeting(bool isLight) {
    final events = [
      {'month': 'MAY', 'day': '20', 'title': 'City Council Meeting', 'time': '7:00 PM', 'location': 'City Hall'},
      {'month': 'MAY', 'day': '22', 'title': 'County Budget Hearing', 'time': '6:30 PM', 'location': 'Eastside'},
      {'month': 'MAY', 'day': '27', 'title': 'Planning Commission', 'time': '5:30 PM', 'location': 'City Hall'},
      {'month': 'MAY', 'day': '29', 'title': 'School Board Meeting', 'time': '6:00 PM', 'location': 'Admin Bldg'},
    ];

    final dateColor = isLight ? const Color(0xff315F96) : const Color(0xff8DB9E5);

    final dateBackground = isLight ? const Color(0xffEAF2FA) : const Color(0xff263A4D);

    return Column(
      children: [
        CommonSectionHeader(title: 'Upcoming meetings'.toUpperCase(), actionText: 'Town Hall'),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_7),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: Dimensions.h_30,
                              height: Dimensions.h_30,
                              decoration: BoxDecoration(color: dateBackground, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    event['month']!,
                                    style: TextStyle(color: dateColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w800, height: 1),
                                  ),
                                  SizedBox(height: Dimensions.h_2),
                                  Text(
                                    event['day']!,
                                    style: TextStyle(color: dateColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: Dimensions.w_8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event['title']!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800, height: 1.15),
                                  ),
                                  SizedBox(height: Dimensions.h_4),
                                  Text(
                                    '${event['time']} · ${event['location']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.65), fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, height: 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (index != events.length - 1)
                        Container(
                          height: 0.6,
                          margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                          color: Theme.of(context).highlightColor.withValues(alpha: 0.16),
                        ),
                    ],
                  );
                },
              ),
              SizedBox(height: Dimensions.h_5),
            ],
          ),
        ),
      ],
    );
  }

  Widget topRepresentatives(bool isLight) {
    final representatives = [
      {'initials': 'MP', 'name': 'Mary Lou Pauly', 'role': 'Mayor', 'rating': '4.8'},
      {'initials': 'ZH', 'name': 'Zach Hall', 'role': 'Council Member', 'rating': '4.8'},
      {'initials': 'VH', 'name': 'Victoria Hunt', 'role': 'Deputy Mayor', 'rating': '4.8'},
      {'initials': 'TM', 'name': 'Tola Marts', 'role': 'Council Member', 'rating': '4.8'},
      {'initials': 'KS', 'name': 'Kirk Sinclair', 'role': 'Council Member', 'rating': '4.8'},
    ];

    final green = isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark;

    return Column(
      children: [
        CommonSectionHeader(title: 'Your representative team'.toUpperCase(), actionText: '', secondActionText: '', onActionTap: () {}),
        SizedBox(height: Dimensions.h_10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: representatives.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Get.width > 900
                ? 5
                : Get.width > 650
                ? 3
                : 2,
            crossAxisSpacing: Dimensions.w_8,
            mainAxisSpacing: Dimensions.h_8,
            childAspectRatio: Get.width > 900
                ? 0.90
                : Get.width > 650
                ? 0.95
                : 1,
          ),
          itemBuilder: (context, index) {
            final item = representatives[index];

            return CommonCard(
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: Dimensions.h_50,
                    height: Dimensions.h_50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 0 || index == 4
                          ? (isLight ? const Color(0xffDDF1E7) : const Color(0xff294638))
                          : index == 2
                          ? (isLight ? const Color(0xffEEE3FA) : const Color(0xff3B2D4D))
                          : (isLight ? const Color(0xffE2EDF9) : const Color(0xff2B4057)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item['initials'] as String,
                      style: TextStyle(
                        color: index == 0 || index == 4
                            ? (isLight ? const Color(0xff35634F) : const Color(0xff9ED2B5))
                            : index == 2
                            ? (isLight ? const Color(0xff674D91) : const Color(0xffC0A6E2))
                            : (isLight ? const Color(0xff365B82) : const Color(0xff9BBBDD)),
                        fontSize: FontSize.sp_12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h_6),

                  Text(
                    item['name'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1.1),
                  ),

                  SizedBox(height: Dimensions.h_10),
                  Text(
                    item['role'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.65), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1),
                  ),
                  SizedBox(height: Dimensions.h_8),
                  Text(
                    'Responded recently',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: green, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w600, height: 1),
                  ),
                  const Spacer(),
                  Container(width: double.infinity, height: 0.1, color: Theme.of(context).highlightColor),
                  SizedBox(height: Dimensions.h_7),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(Icons.star_border_rounded, size: Dimensions.h_12, color: Theme.of(context).primaryColor.withValues(alpha: 0.65)),

                        SizedBox(width: Dimensions.w_3),

                        Text(
                          item['rating'] as String,
                          style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.75), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget liveCivic(bool isLight) {
    final activities = [
      {'type': 'Resident post', 'time': '8 min ago', 'initials': 'SM', 'name': 'Sarah M.', 'description': 'Shared a photo and proposed a safer crossing near Front Street.', 'action': 'View issue', 'icon': CupertinoIcons.arrow_right},
      {'type': 'Representative reply', 'time': '18 min ago', 'initials': 'MP', 'name': 'Mayor Mary Lou Pauly', 'description': 'Answered residents about the Front Street safety timeline.', 'action': '', 'icon': null},
      {'type': 'Issue milestone', 'time': '36 min ago', 'initials': '', 'name': 'Civic Solutions', 'description': 'Black Nugget Road Crossing moved into implementation.', 'action': 'View progress', 'icon': CupertinoIcons.arrow_right},
    ];

    final chipBorderColor = isLight ? const Color(0xffC8D9E8) : const Color(0xff385066);

    final selectedChipColor = isLight ? const Color(0xff285A94) : const Color(0xff477DB8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonSectionHeader(title: 'Live civic activity'.toUpperCase(), actionText: '', secondActionText: '', onActionTap: () {}),
        SizedBox(height: Dimensions.h_10),

        CommonCard(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3, vertical: Dimensions.h_2),
                child: Wrap(
                  spacing: Dimensions.w_5,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7, vertical: Dimensions.h_5),
                      decoration: BoxDecoration(
                        color: selectedChipColor,
                        borderRadius: BorderRadius.circular(Dimensions.h_15),
                        border: Border.all(color: selectedChipColor, width: 0.6),
                      ),
                      child: Text(
                        'All',
                        style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_9, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7, vertical: Dimensions.h_5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.h_15),
                        border: Border.all(color: chipBorderColor, width: 0.6),
                      ),
                      child: Text(
                        'Neighbors',
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7, vertical: Dimensions.h_5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.h_15),
                        border: Border.all(color: chipBorderColor, width: 0.6),
                      ),
                      child: Text(
                        'Representatives',
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_5),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final item = activities[index];

                  final isRepresentative = index == 1;
                  final isMilestone = index == 2;

                  final avatarColor = isMilestone
                      ? (isLight ? const Color(0xffDCEAF8) : const Color(0xff263D54))
                      : isRepresentative
                      ? (isLight ? const Color(0xffDCEFE4) : const Color(0xff20382D))
                      : (isLight ? const Color(0xffDCEAF8) : const Color(0xff263D54));

                  final avatarTextColor = isMilestone
                      ? (isLight ? const Color(0xff4C78A5) : const Color(0xff8BB6E5))
                      : isRepresentative
                      ? (isLight ? const Color(0xff397A5D) : const Color(0xff72B894))
                      : (isLight ? const Color(0xff4C78A5) : const Color(0xff8BB6E5));

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_8),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: chipBorderColor, width: 0.5)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Dimensions.h_25,
                          height: Dimensions.h_25,
                          decoration: BoxDecoration(color: avatarColor, shape: BoxShape.circle),
                          child: Center(
                            child: isMilestone
                                ? Icon(CupertinoIcons.checkmark_circle, size: Dimensions.h_13, color: avatarTextColor)
                                : Text(
                                    item['initials'].toString(),
                                    style: TextStyle(color: avatarTextColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700),
                                  ),
                          ),
                        ),
                        SizedBox(width: Dimensions.w_6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${item['type']} · ',
                                      style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.7), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
                                    ),
                                    TextSpan(
                                      text: item['time'].toString(),
                                      style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.7), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.h_2),
                              Text(
                                item['name'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800),
                              ),
                              SizedBox(height: Dimensions.h_2),
                              Text(
                                item['description'].toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Theme.of(context).primaryColor.withValues(alpha: 0.8), fontSize: FontSize.sp_9, fontWeight: FontWeight.w400, height: 1.25),
                              ),
                              if (item['action'].toString().isNotEmpty) ...[
                                SizedBox(height: Dimensions.h_6),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item['action'].toString(),
                                      style: TextStyle(color: isLight ? const Color(0xff2454B8) : const Color(0xff78A6E8), fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(width: Dimensions.w_3),
                                    Icon(item['icon'] as IconData, size: Dimensions.h_10, color: isLight ? const Color(0xff2454B8) : const Color(0xff78A6E8)),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: Dimensions.h_10),
            ],
          ),
        ),
      ],
    );
  }

  Widget communityTownHall(bool isLight) {
    final green = isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark;

    final textColor = Theme.of(context).highlightColor;
    final secondaryColor = Theme.of(context).highlightColor.withValues(alpha: 0.75);

    return Column(
      children: [
        CommonSectionHeader(title: 'Community Town Hall'.toUpperCase(), actionText: '', secondActionText: '', onActionTap: () {}),
        SizedBox(height: Dimensions.h_10),

        CommonCard(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TUESDAY',
                          style: TextStyle(color: secondaryColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w700, height: 1),
                        ),

                        SizedBox(height: Dimensions.h_12),
                        Text(
                          'JUNE 2',
                          style: TextStyle(color: textColor, fontSize: FontSize.sp_24, fontWeight: FontWeight.w800, height: 1),
                        ),
                        SizedBox(height: Dimensions.h_12),
                        Row(
                          children: [
                            Icon(Icons.access_time_outlined, size: Dimensions.h_12, color: secondaryColor),
                            SizedBox(width: Dimensions.w_3),
                            Text(
                              '7:00 PM',
                              style: TextStyle(color: textColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on_outlined, size: Dimensions.h_12, color: secondaryColor),
                            SizedBox(width: Dimensions.w_2),
                            Text(
                              'City Hall + live stream',
                              style: TextStyle(color: textColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: Dimensions.w_15),
                  Center(
                    child: SizedBox(
                      width: Dimensions.h_100,
                      height: Dimensions.h_100,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ArcGaugeIndicator(radius: Dimensions.h_45, lineWidth: Dimensions.w_8, percent: .92, progressColor: green, backgroundColor: Theme.of(context).highlightColor.withValues(alpha: 0.14), sweepAngle: 360, startAngle: 0),

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '92%',
                                style: TextStyle(color: textColor, fontSize: FontSize.sp_22, fontWeight: FontWeight.w800, height: 1),
                              ),
                              SizedBox(height: Dimensions.h_3),
                              Text(
                                'READY',
                                style: TextStyle(color: green, fontSize: FontSize.sp_7, fontWeight: FontWeight.w600, letterSpacing: .5, height: 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: Dimensions.h_10, bottom: Dimensions.h_15),
                height: 0.1,
                width: Get.width,
                color: Theme.of(context).highlightColor,
              ),
              Text(
                'MEETING READINESS',
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800, height: 1),
              ),
              SizedBox(height: Dimensions.h_12),
              _townHallReadinessRow(title: 'Topics prepared', value: '5 / 5', progress: 1.0, isLight: isLight),

              SizedBox(height: Dimensions.h_8),

              _townHallReadinessRow(title: 'Residents confirmed', value: '14 / 15', progress: 14 / 15, isLight: isLight),

              SizedBox(height: Dimensions.h_8),

              _townHallReadinessRow(title: 'Representatives invited', value: '5 / 5', progress: 1.0, isLight: isLight),

              SizedBox(height: Dimensions.h_8),

              _townHallReadinessRow(title: 'Agenda reviewed', value: 'Complete', progress: 1.0, isLight: isLight),
              Container(
                margin: EdgeInsets.only(top: Dimensions.h_20, bottom: Dimensions.h_15),
                height: 0.1,
                width: Get.width,
                color: Theme.of(context).highlightColor,
              ),
              Text(
                'PROPOSED AGENDA',
                style: TextStyle(color: secondaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800, height: 1),
              ),

              SizedBox(height: Dimensions.h_10),

              _townHallAgendaRow(number: '1.', title: 'Front Street traffic safety', duration: '40 min', isLight: isLight),

              SizedBox(height: Dimensions.h_6),

              _townHallAgendaRow(number: '2.', title: 'Affordable housing solutions', duration: '34 min', isLight: isLight),

              SizedBox(height: Dimensions.h_6),

              _townHallAgendaRow(number: '3.', title: 'Downtown parking management', duration: '31 min', isLight: isLight),

              SizedBox(height: Dimensions.h_6),

              _townHallAgendaRow(number: '4.', title: 'Park improvements', duration: '28 min', isLight: isLight),
              Container(
                margin: EdgeInsets.only(top: Dimensions.h_20, bottom: Dimensions.h_10),
                height: 0.1,
                width: Get.width,
                color: Theme.of(context).highlightColor,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
                child: Row(
                  children: [
                    Icon(Icons.people_outline, size: Dimensions.h_16, color: Theme.of(context).highlightColor),
                    SizedBox(width: Dimensions.w_7),
                    Expanded(
                      child: Text(
                        '148 residents interested',
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                      ),
                    ),

                    Container(
                      height: Dimensions.h_25,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
                      decoration: BoxDecoration(color: green, borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      child: Text(
                        'RSVP now',
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_9, fontWeight: FontWeight.w800),
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

  Widget _townHallReadinessRow({required String title, required String value, required double progress, required bool isLight}) {
    final green = isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
      child: Row(
        children: [
          SizedBox(
            width: Dimensions.w_120,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1),
            ),
          ),

          SizedBox(width: Dimensions.w_8),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: Dimensions.h_4,
                  decoration: BoxDecoration(color: Theme.of(context).highlightColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: progress.clamp(0.0, 1.0),
                      child: Container(
                        height: Dimensions.h_4,
                        decoration: BoxDecoration(color: green, borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: Dimensions.w_10),
          SizedBox(
            width: Dimensions.w_45,
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, height: 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _townHallAgendaRow({required String number, required String title, required String duration, required bool isLight}) {
    final green = isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Dimensions.w_15,
            child: Text(
              number,
              style: TextStyle(color: green, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1),
            ),
          ),

          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1),
            ),
          ),

          SizedBox(width: Dimensions.w_8),

          Text(
            duration,
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1),
          ),
        ],
      ),
    );
  }

  Widget aiBrief() {
    return CommonAiBrief(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppCacheImage(imageUrl: "https://preetis-html.vercel.app/assets/images/school/version2/ai-guide.webp", size: Dimensions.h_28, widthSize: Dimensions.h_28, isCircle: true, isShadow: false),
              SizedBox(width: Dimensions.w_10),
              Text(
                'AI CIVIC BRIEF',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_12),
            child: Text(
              'Housing, safer streets, and the city budget are leading the conversation.',
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800, height: 1.2),
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_12),
            child: Text(
              'Explore 8 open decisions and 12 public meetings to find where your voice can make a difference.',
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1.25),
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Ask AI about Community',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, height: 1),
              ),
              SizedBox(width: Dimensions.w_4),
              Icon(Icons.arrow_forward, color: Theme.of(context).primaryColorDark, size: Dimensions.h_13),
              SizedBox(width: Dimensions.w_15),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeroHeader(bool isLight) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedWeatherImage(height: Dimensions.h_330, image: "https://preetis-html.vercel.app/assets/images/civic-command-center/version1/hero-issaquah.webp"),
        Positioned.fill(
          child: Container(
            height: Dimensions.h_330,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [const Color(0xFF020B15).withValues(alpha: 0.85), const Color(0xFF020B15).withValues(alpha: 0.65), const Color(0xFF020B15).withValues(alpha: 0.35), Colors.transparent],
                stops: const [0.0, 0.30, 0.58, 1.0],
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.h_330,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_10),
                child: Text(
                  'WELCOME BACK SEAN',
                  style: TextStyle(color: const Color(0xFFFFE47A), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_10),
                child: Text(
                  "CIVIC COMMAND CENTER".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_22,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, right: Dimensions.w_60),
                child: Text(
                  'Your voice. Your community. Real change.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_14,
                    fontWeight: FontWeight.w700,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              communityStatsSection(),
              SizedBox(height: Dimensions.h_5),
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
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    (isLight ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.0),

                    (isLight ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.15),

                    (isLight ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.35),

                    (isLight ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.78),

                    isLight ? AppColor.softBackground : AppColor.backgroundDark,
                  ],
                  stops: const [0.08, 0.25, 0.45, 0.75, 1.0],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget communityStatsSection() {
    final stats = [
      {'icon': CupertinoIcons.person_2, 'value': '24', 'label': 'Representatives'},
      {'icon': CupertinoIcons.archivebox, 'value': '8', 'label': 'Open Decisions'},
      {'icon': CupertinoIcons.chat_bubble, 'value': '384', 'label': 'Active Discussions'},
      {'icon': CupertinoIcons.calendar, 'value': '12', 'label': 'Public Meetings'},
      {'icon': CupertinoIcons.heart, 'value': '1,248', 'label': 'Community Actions'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_10),
      child: Column(
        children: List.generate((stats.length / 2).ceil(), (rowIndex) {
          final firstIndex = rowIndex * 2;
          final secondIndex = firstIndex + 1;

          final firstStat = stats[firstIndex];
          final secondStat = secondIndex < stats.length ? stats[secondIndex] : null;
          return Padding(
            padding: EdgeInsets.only(bottom: rowIndex != (stats.length / 2).ceil() - 1 ? Dimensions.h_12 : 0),
            child: Row(
              children: [
                Expanded(
                  child: _communityStatItem(icon: firstStat['icon'] as IconData, value: firstStat['value'] as String, label: firstStat['label'] as String),
                ),
                Expanded(
                  child: secondStat != null ? _communityStatItem(icon: secondStat['icon'] as IconData, value: secondStat['value'] as String, label: secondStat['label'] as String) : const SizedBox(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _communityStatItem({required IconData icon, required String value, required String label}) {
    return Row(
      children: [
        Icon(icon, size: Dimensions.h_18, fontWeight: FontWeight.bold, color: const Color(0xFF8adfff)),
        SizedBox(width: Dimensions.w_8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(fontSize: FontSize.sp_15, fontWeight: FontWeight.w900, color: AppColor.white),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: FontSize.sp_10,
                  color: AppColor.white,
                  shadows: [
                    Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2)),
                    Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2)),
                    Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
