import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wikixm/Presentation/widgets/circular_percent.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/data/datasource/local/local_storage.dart';
import '../../constants/constants.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../widgets/bill_widget.dart';
import '../widgets/cache_image.dart';
import '../widgets/drawer/src/slider_drawer.dart';
import '../widgets/town_hall_drawer.dart';

class TownHallScreen extends StatefulWidget {
  const TownHallScreen({super.key});

  @override
  State<TownHallScreen> createState() => _TownHallScreenState();
}

class _TownHallScreenState extends State<TownHallScreen> {
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey<SliderDrawerState>();
  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return SliderDrawer(
      key: sliderDrawerKey,
      sliderOpenSize: 300,
      isDraggable: true,
      slider: CommonSliderDrawer(
        isLight: isLight,
        onDashboard: () {},
        onProjects: () {},
        onDiscussions: () {},
        onRepresentatives: () {},
        onMeetings: () {},
        onTransparency: () {},
        onLearn: () {},
       onClose:  () {
          sliderDrawerKey.currentState?.closeSlider();
       },
        onAllLevels: () {},
        onCity: () {},
        onCounty: () {},
        onState: () {},
        onFederal: () {},
      ),
      child: AppScaffold(
          top: false,
          bottom: false,
          bodyPadding: EdgeInsets.zero,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: CommonScrollBlurScaffold(
            isDrawer: true,
            onTap: () {
              sliderDrawerKey.currentState?.openSlider();
            },
            expandedHeight: Dimensions.h_210,
            expandedColor: isLight ? Colors.black:Colors.white,
            collapsedColor: Theme.of(context).highlightColor,
            hero: buildHeroHeader(isLight), slivers: [
            SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      firstCard(isLight),
                      SizedBox(height: Dimensions.h_8),
                      CommonCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.sparkles,
                                  color: isLight ? AppColor.darkBlue : AppColor.white,
                                  size: Dimensions.h_18,
                                ),
                                SizedBox(width: Dimensions.w_5),
                                Text(
                                  'AI DAILY COMMUNITY BRIEF',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isLight ? AppColor.darkBlue : AppColor.white,
                                    fontSize: FontSize.sp_11,
                                    fontWeight: FontWeight.w800,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_5),
      
                              ],
                            ),
      
                            SizedBox(height: Dimensions.h_10),
      
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_10),
                              child: Text(
                                'Here’s what happened in Issaquah today.',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: FontSize.sp_13_5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                  height: 1.1,
                                ),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_6),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_10),
                              child: Text(
                                'AI analyzed 128 updates from local government, projects, '
                                    'and community activity.',
                                style: TextStyle(
                                  color: Theme.of(context).highlightColor,
                                  fontSize: FontSize.sp_9_5,
                                  fontWeight: FontWeight.w500,
                                  height: 1.25,
                                ),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(Dimensions.w_3),
                                    decoration: BoxDecoration(
                                      color: isLight
                                          ? const Color(0xFFE8F4EE)
                                          : const Color(0xFF18352C),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.briefcase_fill,
                                      color: isLight ? AppColor.townHallGreen :AppColor.townHallGreenDark,
                                      size: Dimensions.h_15,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.w_5),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '3',
                                              style: TextStyle(
                                                color: isLight ? AppColor.townHallGreen :AppColor.townHallGreenDark,
                                                fontSize: FontSize.sp_15,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.w_4),
                                            Text(
                                              'advanced or updated',
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: FontSize.sp_9_5,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Dimensions.h_5),
                                        Text(
                                          'Transportation Benefit District Bill advanced to committee. '
                                              'Two other bills changed status and are approaching votes.',
                                          style: TextStyle(
                                            color: Theme.of(context).highlightColor,
                                            fontSize: FontSize.sp_9,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.h_5),
                                        Row(
                                          children: [
                                            Text(
                                              'See bill updates below',
                                              style: TextStyle(
                                                color: isLight ? AppColor.darkBlue : const Color(0xFF4b8bff),
                                                fontSize: FontSize.sp_9,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.w_3),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: isLight ? AppColor.darkBlue : const Color(0xFF4b8bff),
                                              size: Dimensions.h_11,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            Container(
                              height: 0.2,
                              color: Theme.of(context).dividerColor),
                            SizedBox(height: Dimensions.h_10),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(Dimensions.w_3),
                                    decoration: BoxDecoration(
                                      color: isLight
                                          ? const Color(0xFFE8EDFF)
                                          : const Color(0xFF19284D),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.person_2_fill,
                                      color: const Color(0xFF365DEB),
                                      size: Dimensions.h_15,
                                    ),
                                  ),
      
                                  SizedBox(width: Dimensions.w_5),
      
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '18',
                                              style: TextStyle(
                                                color: const Color(0xFF365DEB),
                                                fontSize: FontSize.sp_15,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.w_4),
                                            Text(
                                              'New resident actions',
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: FontSize.sp_9_5,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
      
                                        SizedBox(height: Dimensions.h_5),
      
                                        Text(
                                          '12 comments, 4 votes, 2 solution proposals',
                                          style: TextStyle(
                                            color: Theme.of(context).highlightColor,
                                            fontSize: FontSize.sp_9,
                                            fontWeight: FontWeight.w500,
                                            height: 1.35,
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.h_4),
                                        Text(
                                          '+12% vs yesterday',
                                          style: TextStyle(
                                            color: isLight ? AppColor.townHallGreen :AppColor.townHallGreenDark,
                                            fontSize: FontSize.sp_9,
                                            fontWeight: FontWeight.w700,
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
                                height: 0.2,
                                color: Theme.of(context).dividerColor),
                            SizedBox(height: Dimensions.h_10),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(Dimensions.w_3),
                                    decoration: BoxDecoration(
                                      color: isLight
                                          ? const Color(0xFFFFE8E8)
                                          : const Color(0xFF432326),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.shield_fill,
                                      color: const Color(0xFFE83D4F),
                                      size: Dimensions.h_15,
                                    ),
                                  ),
      
                                  SizedBox(width: Dimensions.w_5),
      
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Parks maintenance funding proposal gaining support',
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: FontSize.sp_9_5,
                                            fontWeight: FontWeight.w700,
                                            height: 1.15,
                                          ),
                                        ),
      
                                        SizedBox(height: Dimensions.h_5),
      
                                        Text(
                                          'Ranked #1 topic today with 79% support',
                                          style: TextStyle(
                                            color: Theme.of(context).highlightColor,
                                            fontSize: FontSize.sp_9,
                                            fontWeight: FontWeight.w500,
                                            height: 1.35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.h_12),
                            Row(
                              children: [
                                CommonCard(
                                  radius: Dimensions.h_4,
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8,vertical: Dimensions.h_6),
                                    child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Read Full Brief',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColorDark,
                                        fontSize: FontSize.sp_9,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.w_2),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context).primaryColorDark,
                                      size: Dimensions.h_10,
                                    ),
                                  ],
                                )),
                                const Spacer(),
                                Padding(
                                  padding:  EdgeInsets.only(top: Dimensions.h_1),
                                  child: Text(
                                    'Share Brief',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: FontSize.sp_9,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_2),
                                Icon(
                                  Icons.share,
                                  color: Theme.of(context).primaryColorDark,
                                  size: Dimensions.h_10,
                                ),
                                SizedBox(width: Dimensions.w_4),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_10),
                      LegislativeBillsSection(isLight: isLight),
                      SizedBox(height: Dimensions.h_15),
                      Row(
                        children: [
                          Text(
                            'NEXT TOWN HALL MEETING ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isLight
                                  ? AppColor.townHallGreen
                                  : AppColor.townHallGreenDark,
                              fontSize: FontSize.sp_11,
                              fontWeight: FontWeight.w800,
                              height: 1,
                            ),
                          ),
                          SizedBox(width: Dimensions.w_5),
                          Container(
                            margin: EdgeInsets.only(left: Dimensions.w_4),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w_5,
                              vertical: Dimensions.h_3,
                            ),
                            decoration: BoxDecoration(
                              color: isLight
                                  ? AppColor.townHallGreen
                                  : AppColor.townHallGreenDark,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'LIVE ONLINE',
                              style: TextStyle(
                                color: !isLight ? AppColor.black : AppColor.white,
                                fontSize: FontSize.sp_8,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CommonCard(
                        margin: EdgeInsets.only(top: Dimensions.h_10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: Dimensions.h_70,
                                  height: Dimensions.h_80,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(Dimensions.h_6),
                                    border: Border.all(color: Theme.of(context).focusColor),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                          vertical: Dimensions.h_5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius: BorderRadius.circular(Dimensions.h_6),
                                        ),
                                        child: Text(
                                          'TUESDAY',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: FontSize.sp_8,
                                            fontWeight: FontWeight.w800,
                                            height: 1,
                                          ),
                                        ),
                                      ),
      
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                          vertical: Dimensions.h_5,
                                        ),
                                        color: const Color(0xFFED1C24),
                                        child: Text(
                                          'JUN',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: FontSize.sp_10,
                                            fontWeight: FontWeight.w800,
                                            height: 1,
                                          ),
                                        ),
                                      ),
      
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '03',
                                            style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontSize: FontSize.sp_26,
                                              fontWeight: FontWeight.w800,
                                              height: 1,
                                            ),
                                          ),
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
                                        'First Tuesday of Every Month',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: FontSize.sp_14,
                                          fontWeight: FontWeight.w800,
                                          height: 1.1,
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.h_10),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.clock,
                                            color: Theme.of(context).primaryColorDark,
                                            size: Dimensions.h_13,
                                          ),
                                          SizedBox(width: Dimensions.w_4),
                                          Text(
                                            '7:00 PM PT',
                                            style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontSize: FontSize.sp_9_5,
                                              fontWeight: FontWeight.w600,
                                              height: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.h_4),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.chat_bubble,
                                            color: Theme.of(context).primaryColorDark,
                                            size: Dimensions.h_13,
                                          ),
                                          SizedBox(width: Dimensions.w_4),
                                          Text(
                                            'Live Online Meeting',
                                            style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontSize: FontSize.sp_9_5,
                                              fontWeight: FontWeight.w600,
                                              height: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_10),
                            Text(
                              'Resident-created agenda. Community-approved topics. '
                                  'Representatives invited at every relevant level.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: FontSize.sp_9_5,
                                fontWeight: FontWeight.w500,
                                height: 1.35,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: Dimensions.h_28,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.w_20,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark,
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.h_6,
                                      ),
                                    ),
                                    child: Text(
                                      'View Agenda (6)',
                                      style: TextStyle(
                                        color: isLight ? Colors.white : AppColor.black,
                                        fontSize: FontSize.sp_9_5,
                                        fontWeight: FontWeight.w800,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_6),
      
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: Dimensions.h_28,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.w_20,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.h_6,
                                      ),
                                      border: Border.all(
                                        color: Theme.of(context).focusColor,
                                      ),
                                    ),
                                    child: Text(
                                      'Commit to Attend',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColorDark,
                                        fontSize: FontSize.sp_9_5,
                                        fontWeight: FontWeight.w800,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: Dimensions.h_10),
                              height: 0.1,
                              width: Get.width,
                              color: Theme.of(context).highlightColor,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'MEETING AT A GLANCE',
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: FontSize.sp_10,
                                            fontWeight: FontWeight.w800,
                                            height: 1,
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.h_10),
                                        Row(
                                          children: [
                                            Container(
                                              width: Dimensions.h_16,
                                              height: Dimensions.h_16,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColorDark
                                                      .withValues(alpha: 0.15),
                                                ),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.search,
                                                color: Theme.of(context).primaryColorDark,
                                                size: Dimensions.h_10,
                                              ),
                                            ),
      
                                            SizedBox(width: Dimensions.w_4),
                              
                                            Text(
                                              '6 Topics on the Agenda',
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: FontSize.sp_8_5,
                                                fontWeight: FontWeight.w500,
                                                height: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Dimensions.h_4),
                                        Row(
                                          children: [
                                            Container(
                                              width: Dimensions.h_16,
                                              height: Dimensions.h_16,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColorDark
                                                      .withValues(alpha: 0.15),
                                                ),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.person_add,
                                                color: Theme.of(context).primaryColorDark,
                                                size: Dimensions.h_10,
                                              ),
                                            ),
      
                                            SizedBox(width: Dimensions.w_4),
                              
                                            Text(
                                              '4 Representatives Invited',
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: FontSize.sp_8_5,
                                                fontWeight: FontWeight.w500,
                                                height: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Dimensions.h_4),
                                        Row(
                                          children: [
                                            Container(
                                              width: Dimensions.h_16,
                                              height: Dimensions.h_16,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColorDark
                                                      .withValues(alpha: 0.15),
                                                ),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.person_2_fill,
                                                color: Theme.of(context).primaryColorDark,
                                                size: Dimensions.h_10,
                                              ),
                                            ),
      
                                            SizedBox(width: Dimensions.w_4),
                              
                                            Text(
                                              'Live Q&A with Representatives',
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: FontSize.sp_8_5,
                                                fontWeight: FontWeight.w500,
                                                height: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Dimensions.h_4),
                                        Row(
                                          children: [
                                            Container(
                                              width: Dimensions.h_16,
                                              height: Dimensions.h_16,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColorDark
                                                      .withValues(alpha: 0.15),
                                                ),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.calendar,
                                                color: Theme.of(context).primaryColorDark,
                                                size: Dimensions.h_10,
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.w_4),
                                            Text(
                                              'Community Solutions Spotlight',
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: FontSize.sp_8_5,
                                                fontWeight: FontWeight.w500,
                                                height: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: Dimensions.w_4),
                                    height: Dimensions.h_100,
                                    width: 0.1,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                  SizedBox(width: Dimensions.w_4),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'QUALIFICATION PROGRESS',
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: FontSize.sp_10,
                                            fontWeight: FontWeight.w800,
                                            height: 1,
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.h_10),
                                        Row(
                                          children: [
                                            Stack(
                                              children: [
                                                ArcGaugeIndicator(
                                                  radius: Dimensions.h_30,
                                                  lineWidth: 10,
                                                  percent: .80,
                                                  progressColor: isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark,
                                                  backgroundColor: Colors.grey,
                                                  sweepAngle: 360,
                                                  startAngle: 0,
                                                ),
                                                Positioned(
                                                  top: Dimensions.h_25,
                                                  left: 0,
                                                  right: 0,
                                                  child: Text(
                                                    '80%',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark,
                                                      fontSize: FontSize.sp_12,
                                                      fontWeight: FontWeight.w700,
                                                      height: 1.05,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(width: Dimensions.w_8),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '8 of 10',
                                                  style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontSize: FontSize.sp_12,
                                                    fontWeight: FontWeight.w800,
                                                    height: 1,
                                                  ),
                                                ),
                                                Text(
                                                  'requirements met',
                                                  style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontSize: FontSize.sp_9_5,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Dimensions.h_5),
                                        Container(
                                          margin: EdgeInsets.only(left: Dimensions.w_2),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.w_5,
                                            vertical: Dimensions.h_3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isLight
                                                ? const Color(0xFFeaf3ed)
                                                : const Color(0xFF12281d),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(CupertinoIcons.check_mark_circled_solid,color: isLight
                                                  ? AppColor.townHallGreen
                                                  : AppColor.townHallGreenDark,size: Dimensions.h_10),
                                              SizedBox(width: Dimensions.w_8),
                                              Text(
                                                'ON TRACK TO BE APPROVED',
                                                style: TextStyle(
                                                  color: isLight
                                                      ? AppColor.townHallGreen
                                                      : AppColor.townHallGreenDark,
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
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_10),
                      CommonCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
      
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'TOP COMMUNITY PRIORITIES',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: FontSize.sp_11,
                                      fontWeight: FontWeight.w800,
                                      height: 1,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'See all priorities & vote',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColorDark,
                                          fontSize: FontSize.sp_9,
                                          fontWeight: FontWeight.w700,
                                          height: 1,
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.w_2),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Theme.of(context).primaryColorDark,
                                        size: Dimensions.h_10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_10),
                            _priorityItem(
                              rank: '1',
                              title: 'Parks Maintenance Funding',
                              percentage: '79%',
                              label: 'Support',
                              progress: 0.79,
                              isLight: isLight,
                              color: const Color(0xFF157a4c),
                            ),
                            SizedBox(height: Dimensions.h_8),
                            _priorityItem(
                              rank: '2',
                              title: 'Improve Front Street Traffic Flow',
                              percentage: '72%',
                              label: 'Support',
                              progress: 0.72,
                              isLight: isLight,
                              color: const Color(0xFF2563eb),
                            ),
      
                            SizedBox(height: Dimensions.h_8),
                            _priorityItem(
                              rank: '3',
                              title: 'Preserve Affordable Housing',
                              percentage: '68%',
                              label: 'Support',
                              progress: 0.68,
                              isLight: isLight,
                              color: const Color(0xFFb092ff),
                            ),
                            SizedBox(height: Dimensions.h_8),
                            _priorityItem(
                              rank: '4',
                              title: 'Expand Community Parks',
                              percentage: '64%',
                              label: 'Support',
                              progress: 0.64,
                              color: const Color(0xFFb8480a),
                              isLight: isLight),
      
                            SizedBox(height: Dimensions.h_8),
                            _priorityItem(
                              rank: '5',
                              title: 'Improve Downtown Safety',
                              percentage: '56%',
                              label: 'Support',
                              progress: 0.56,
                              isLight: isLight,
                              color: const Color(0xFF3fb8ab)
                            ),
                            SizedBox(height: Dimensions.h_15),
                            Row(
                              children: [
                                Text(
                                  '336',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: FontSize.sp_13_5,
                                    fontWeight: FontWeight.w800,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_4),
                                Text(
                                  'Total Participants',
                                  style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: FontSize.sp_9_5,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_15),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'REPRESENTATIVE TEAM SCORECARD',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'How rankings work',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: FontSize.sp_9_5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_2),
                                Icon(
                                  CupertinoIcons.info_circle,
                                  size: Dimensions.h_10,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_10),
                      CommonCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _scoreFilter(
                                  title: 'All',
                                  isSelected: true,
                                ),
                                SizedBox(width: Dimensions.w_4),
                                _scoreFilter(title: 'City'),
                                SizedBox(width: Dimensions.w_4),
                                _scoreFilter(title: 'County'),
                                SizedBox(width: Dimensions.w_4),
                                _scoreFilter(title: 'State'),
                                SizedBox(width: Dimensions.w_4),
                                _scoreFilter(title: 'Federal'),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_10),
                            Row(
                              children: [
                                SizedBox(
                                  width: Dimensions.w_28,
                                  child: Text(
                                    'RANK',
                                    style: _tableHeaderStyle(),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'REPRESENTATIVE',
                                    style: _tableHeaderStyle(),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.w_40,
                                  child: Text(
                                    'LEVEL',
                                    style: _tableHeaderStyle(),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.w_32,
                                  child: Text(
                                    'SCORE',
                                    style: _tableHeaderStyle(),
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_5),
                                SizedBox(
                                  width: Dimensions.w_60,
                                  child: Text(
                                    'CONFIDENCE',
                                    style: _tableHeaderStyle(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_8),
                            Container(
                              height: 1,
                              width: Get.width,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(height: Dimensions.h_5),
                            _representativeRow(
                              rank: '1',
                              name: 'Mary Lou Pauly',
                              role: 'State Representative',
                              level: 'State',
                              score: '91',
                              confidence: 'High',
                            ),
                            _representativeRow(
                              rank: '2',
                              name: 'Tolmar',
                              role: 'City Council Position 1',
                              level: 'City',
                              score: '88',
                              confidence: 'High',
                            ),
      
                            _representativeRow(
                              rank: '3',
                              name: 'Zach Hall',
                              role: 'City Council Position 2',
                              level: 'City',
                              score: '85',
                              confidence: 'Medium',
                            ),
      
                            _representativeRow(
                              rank: '4',
                              name: 'Victoria Hunt',
                              role: 'City Council Position 3',
                              level: 'City',
                              score: '81',
                              confidence: 'Medium',
                            ),
      
                            _representativeRow(
                              rank: '5',
                              name: 'Chris Reh',
                              role: 'City Council Position 4',
                              level: 'City',
                              score: '78',
                              confidence: 'Medium',
                            ),
      
                            _representativeRow(
                              rank: '6',
                              name: 'Regan Dunn',
                              role: 'King County Council',
                              level: 'County',
                              score: '73',
                              confidence: 'Low',
                            ),
      
                            _representativeRow(
                              rank: '7',
                              name: 'Maria Cantwell',
                              role: 'U.S. Senator',
                              level: 'Federal',
                              score: '68',
                              confidence: 'Low',
                            ),
                            SizedBox(height: Dimensions.h_8),
                            GestureDetector(
                              onTap: () {},
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'View full scorecard details',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColorDark,
                                        fontSize: FontSize.sp_9_5,
                                        fontWeight: FontWeight.w800,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.w_4),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: Dimensions.h_11,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_15),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'COMMUNITY ENGAGEMENT TODAY',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'View all activity',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: FontSize.sp_9_5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_2),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Theme.of(context).primaryColorDark,
                                  size: Dimensions.h_10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_10),
                      CommonCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _activityItem(
                              avatar: const Icon(
                                CupertinoIcons.person_fill,
                                color: Colors.white,
                                size: 14,
                              ),
                              avatarColor: AppColor.darkBlue,
                              title: 'Lindsey Walsh',
                              action: 'submitted a new idea for Front',
                              highlight: 'Street Traffic Flow',
                              time: '2m ago',
                            ),
                            SizedBox(height: Dimensions.h_8),
                            _activityItem(
                              avatar: const Icon(
                                CupertinoIcons.person_fill,
                                color: Colors.white,
                                size: 14,
                              ),
                              avatarColor: AppColor.darkBlue,
                              title: 'Councilmember Zach Hall',
                              action: 'responded to a',
                              highlight: 'question',
                              time: '15m ago',
                            ),
                            SizedBox(height: Dimensions.h_8),
                            _activityItem(
                              avatar: Icon(
                                CupertinoIcons.house_fill,
                                color: Theme.of(context).primaryColorDark,
                                size: Dimensions.h_15,
                              ),
                              avatarColor: isLight ? Theme.of(context)
                                  .primaryColorDark
                                  .withValues(alpha: 0.10) : AppColor.darkBlue,
                              title: 'Project “Parks Enhancements”',
                              action: 'reached 100',
                              highlight: 'supporters',
                              time: '32m ago',
                            ),
                            SizedBox(height: Dimensions.h_8),
                            _activityItem(
                              avatar:  Icon(
                                CupertinoIcons.person_fill,
                                color: Colors.white,
                                size: Dimensions.h_13,
                              ),
                              avatarColor: AppColor.darkBlue,
                              title: 'Mary Lou Pauly',
                              action: 'added a document to Emergency',
                              highlight: 'Preparedness Plan',
                              time: '1h ago',
                            ),
                            SizedBox(height: Dimensions.h_8),
                            _activityItem(
                              avatar: Icon(
                                Icons.calendar_month,
                                color: Theme.of(context).primaryColorDark,
                                size: Dimensions.h_15,
                              ),
                              avatarColor: isLight ? Theme.of(context)
                                  .primaryColorDark
                                  .withValues(alpha: 0.10) : AppColor.darkBlue,
                              title: '“Housing Density Discussion”',
                              action: 'New meeting topic added',
                              highlight: '',
                              time: '2h ago',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_15),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'ACTIVE COMMUNITY PROJECTS',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'View all projects',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: FontSize.sp_9_5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_2),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Theme.of(context).primaryColorDark,
                                  size: Dimensions.h_10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_10),
                      CommonCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '24',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: FontSize.sp_18,
                                          fontWeight: FontWeight.w900,
                                          height: 1,
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.h_3),
                                      Text(
                                        'Active Projects',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: FontSize.sp_9_5,
                                          fontWeight: FontWeight.w500,
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '2,314',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: FontSize.sp_18,
                                          fontWeight: FontWeight.w900,
                                          height: 1,
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.h_3),
                                      Text(
                                        'Total Participants',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: FontSize.sp_9_5,
                                          fontWeight: FontWeight.w500,
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '+8 this week',
                                  style: TextStyle(
                                    color: isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark,
                                    fontSize: FontSize.sp_9_5,
                                    fontWeight: FontWeight.w800,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_15),
                            _projectItem(title: 'Parks Maintenance Funding', percentage: 79),
                            SizedBox(height: Dimensions.h_6),
                            _projectItem(title: 'Front Street Traffic Flow', percentage: 72),
                            SizedBox(height: Dimensions.h_6),
                            _projectItem(title: 'Emergency Preparedness Plan', percentage: 65),
                            SizedBox(height: Dimensions.h_6),
                            _projectItem(title: 'Downtown Safety Improvements', percentage: 58),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_15),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'GOVERNMENT TRANSPARENCY',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'View Dashboard',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: FontSize.sp_9_5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_2),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Theme.of(context).primaryColorDark,
                                  size: Dimensions.h_10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_10),
                      CommonCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _transparencyItem(
                              title: 'Budget Transparency',
                              percentage: 92,
                              isLight: isLight
                            ),
                            SizedBox(height: Dimensions.h_7),
      
                            _transparencyItem(
                              title: 'Meeting Transparency',
                              percentage: 95,
                                isLight: isLight
      
                            ),
      
                            SizedBox(height: Dimensions.h_7),
      
                            _transparencyItem(
                              title: 'Voting Transparency',
                              percentage: 93,
                                isLight: isLight
      
                            ),
      
                            SizedBox(height: Dimensions.h_7),
      
                            _transparencyItem(
                              title: 'Contract Transparency',
                              percentage: 88,
                                isLight: isLight
      
                            ),
      
                            SizedBox(height: Dimensions.h_7),
      
                            _transparencyItem(
                              title: 'Open Data Availability',
                              percentage: 90,
                                  isLight: isLight
      
                            ),
                            SizedBox(height: Dimensions.h_10),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.w_8,
                                vertical: Dimensions.h_4),
                              decoration: BoxDecoration(
                                color: AppColor.townHallGreen.withValues(
                                  alpha: isLight ? 0.08 : 0.16,
                                ),
                                borderRadius: BorderRadius.circular(
                                  Dimensions.h_6,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: Dimensions.w_28,
                                    height: Dimensions.h_28,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isLight ? AppColor.townHallGreen.withValues(alpha: 0.12): AppColor.townHallGreenDark.withValues(alpha: 0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.shield_fill,
                                      color: isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark,
                                      size: Dimensions.h_15,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.w_6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Overall Transparency Score',
                                          style: TextStyle(
                                            color: Theme.of(context).highlightColor,
                                            fontSize: FontSize.sp_9_5,
                                            fontWeight: FontWeight.w500,
                                            height: 1,
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.h_5),
                                        Text(
                                          'Very Good',
                                          style: TextStyle(
                                            color: isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark,
                                            fontSize: FontSize.sp_10,
                                            fontWeight: FontWeight.w700,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
      
                                  Text(
                                    '91%',
                                    style: TextStyle(
                                      color: isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark,
                                      fontSize: FontSize.sp_18,
                                      fontWeight: FontWeight.w900,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_10),
                      communitySentimentWidget(isLight),
                      SizedBox(height: Dimensions.h_15),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'COMMUNITY POLL',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: FontSize.sp_11,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'View all polls',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: FontSize.sp_9_5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_2),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Theme.of(context).primaryColorDark,
                                  size: Dimensions.h_10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_10),
                      CommonCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Which issue should be the top priority\n'
                                  'for our next Town Hall agenda?',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w500,
                                height: 1.3,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            _pollOption(
                              title: 'Parks Maintenance Funding',
                              percentage: 42,
                              isLight: isLight
                            ),
                            SizedBox(height: Dimensions.h_5),
                            _pollOption(
                              title: 'Improve Front Street Traffic Flow',
                              percentage: 28,
                                isLight: isLight
                            ),
                            SizedBox(height: Dimensions.h_5),
                            _pollOption(
                              title: 'Preserve Affordable Housing',
                              percentage: 16,
                                isLight: isLight
                            ),
                            SizedBox(height: Dimensions.h_5),
                            _pollOption(
                              title: 'Expand Community Parks',
                              percentage: 9,
                                isLight: isLight
                            ),
                            SizedBox(height: Dimensions.h_5),
                            _pollOption(
                              title: 'Improve Downtown Safety',
                              percentage: 5,
                                isLight: isLight
                            ),
                            SizedBox(height: Dimensions.h_10),
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '1,102 ',
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: FontSize.sp_10,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'votes cast',
                                          style: TextStyle(
                                            color: Theme.of(context).highlightColor,
                                            fontSize: FontSize.sp_10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: Dimensions.h_25,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.w_12,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColor.darkBlue,
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.h_6,
                                      ),
                                    ),
                                    child: Text(
                                      'Vote Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSize.sp_10,
                                        fontWeight: FontWeight.w800,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                  Row(
                                    children: [
                                      Text('ASK WIKIXM AI', style: TextStyle(
                                          color: Theme.of(Get.context!).highlightColor,
                                          fontSize: FontSize.sp_12,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.1
                                      )),
                                      Container(
                                        margin: EdgeInsets.only(left: Dimensions.w_4),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.w_5,
                                          vertical: Dimensions.h_3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: !isLight
                                              ? const Color(0xffffc264)
                                              : const Color(0xFF97590a),
                                          borderRadius: BorderRadius.circular(999),
                                        ),
                                        child: Text(
                                          'COMING SOON',
                                          style: TextStyle(
                                            color: !isLight ? AppColor.black : AppColor.white,
                                            fontSize: FontSize.sp_7,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0.5,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_5),
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
                                  color: AppColor.darkBlue),
                              child: Icon(CupertinoIcons.chat_bubble,size: Dimensions.h_18,color: AppColor.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
            SliverToBoxAdapter(child: SizedBox(height: Dimensions.h_20)),
          ],
          )),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
        sliderDrawerKey.currentState?.closeSlider();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w_10,
          vertical: Dimensions.h_10,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: Dimensions.h_18,
            ),

            SizedBox(width: Dimensions.w_8),

            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  TextStyle _tableHeaderStyle() {
    return TextStyle(
      color: Theme.of(context).hintColor,
      fontSize: FontSize.sp_8_5,
      fontWeight: FontWeight.w500,
      height: 1,
    );
  }

  Widget _scoreFilter({
    required String title,
    bool isSelected = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: Dimensions.h_22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColor.darkBlue
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(Dimensions.h_5),
            border: isSelected ? null :Border.all(
              color:Theme.of(context).focusColor,
            ),
          ),
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
        ),
      ),
    );
  }

  Widget communitySentimentWidget(bool isLight) {
    final chartData = <ChartData>[
      ChartData(
        x: 'Positive',
        y: 62,
        color: isLight
            ? const Color(0xFF0F7A44)
            : const Color(0xFF4FC98A),
      ),
      ChartData(
        x: 'Neutral',
        y: 25,
        color: isLight
            ? const Color(0xFFf09708)
            : const Color(0xFFf5b13d),
      ),
      ChartData(
        x: 'Negative',
        y: 13,
        color: isLight
            ? const Color(0xFFe5231f)
            : const Color(0xFFd93643),
      ),
    ];

    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'COMMUNITY SENTIMENT (30 DAYS)',
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: FontSize.sp_11,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          SizedBox(height: Dimensions.h_12),
          Row(
            children: [
              SizedBox(
                width: Dimensions.h_80,
                height: Dimensions.h_80,
                child: SfCircularChart(
                  margin: EdgeInsets.zero,
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData, String>(
                      dataSource: chartData,
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      innerRadius: '62%',
                      radius: '100%',
                      strokeWidth: 0,
                      animationDuration: 800,
                    ),
                  ],
                ),
              ),

              SizedBox(width: Dimensions.w_15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sentimentLegend(
                      color: isLight
                          ? const Color(0xFF0F7A44)
                          : const Color(0xFF4FC98A),
                      title: 'Positive',
                      value: '62%',
                    ),

                    SizedBox(height: Dimensions.h_8),

                    _sentimentLegend(
                      color: isLight
                          ? const Color(0xFFf09708)
                          : const Color(0xFFf5b13d),
                      title: 'Neutral',
                      value: '25%',
                    ),

                    SizedBox(height: Dimensions.h_8),

                    _sentimentLegend(
                      color: isLight
                          ? const Color(0xFFe5231f)
                          : const Color(0xFFd93643),
                      title: 'Negative',
                      value: '13%',
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8,vertical: Dimensions.h_8),
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(Dimensions.h_8)
            ),
            child: Row(
              children: [
                Text(
                  'Overall Sentiment',
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_9_5,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),

                const Spacer(),

                Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: isLight
                      ? const Color(0xFF10783F)
                      : const Color(0xFF56CF90),
                  size: Dimensions.h_12,
                ),

                SizedBox(width: Dimensions.w_4),

                Text(
                  'Positive',
                  style: TextStyle(
                    color: isLight
                        ? const Color(0xFF10783F)
                        : const Color(0xFF56CF90),
                    fontSize: FontSize.sp_9_5,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sentimentLegend({
    required Color color,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: Dimensions.w_12,
          height: Dimensions.w_12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: Dimensions.w_6),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: FontSize.sp_9_5,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontSize: FontSize.sp_9_5,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget _representativeRow({
    required String rank,
    required String name,
    required String role,
    required String level,
    required String score,
    required String confidence,
  }) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    Color levelTextColor;
    Color levelBgColor;

    switch (level) {
      case 'City':
        levelTextColor = isLight
            ? const Color(0xFF0F7A3D)
            : const Color(0xFF4CC98B);

        levelBgColor = isLight
            ? const Color(0xFFE8F3EC)
            : const Color(0xFF102B1F);
        break;

      case 'County':
        levelTextColor = isLight
            ? const Color(0xFF3341D8)
            : const Color(0xFF7F95FF);

        levelBgColor = isLight
            ? const Color(0xFFE5ECFE)
            : const Color(0xFF111D3A);
        break;

      case 'State':
        levelTextColor = isLight
            ? const Color(0xFF6D28E0)
            : const Color(0xFFB092FF);

        levelBgColor = isLight
            ? const Color(0xFFECE6FD)
            : const Color(0xFF241D47);
        break;

      case 'Federal':
        levelTextColor = isLight
            ? const Color(0xFF12246E)
            : const Color(0xFF9FBDFF);

        levelBgColor = isLight
            ? const Color(0xFFE5ECFE)
            : const Color(0xFF111D3A);
        break;

      default:
        levelTextColor = Theme.of(context).primaryColorDark;
        levelBgColor = Theme.of(context)
            .highlightColor
            .withValues(alpha: 0.10);
    }

    Color confidenceTextColor;
    Color confidenceBgColor;

    switch (confidence) {
      case 'High':
        confidenceTextColor = isLight
            ? const Color(0xFF10783F)
            : const Color(0xFF56CF90);

        confidenceBgColor = isLight
            ? const Color(0xFFE8F3EC)
            : const Color(0xFF102B1F);
        break;

      case 'Medium':
        confidenceTextColor = isLight
            ? const Color(0xFFB94705)
            : const Color(0xFFFFA761);

        confidenceBgColor = isLight
            ? const Color(0xFFFDEADA)
            : const Color(0xFF3D2411);
        break;

      case 'Low':
        confidenceTextColor = isLight
            ? const Color(0xFFD81324)
            : const Color(0xFFFF8A92);

        confidenceBgColor = isLight
            ? const Color(0xFFFDE7E9)
            : const Color(0xFF3A1720);
        break;

      default:
        confidenceTextColor = Theme.of(context).highlightColor;
        confidenceBgColor = Theme.of(context).highlightColor.withValues(alpha: 0.10);
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.h_5,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Theme.of(context).focusColor))
      ),
      child: Row(
        children: [
          SizedBox(
            width: Dimensions.w_15,
            child: Center(
              child: Text(
                rank,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          AppCacheImage(
            imageUrl:
            'https://preetis-html.vercel.app/assets/images/townhall/townhall3/people/person-7.jpg',
            size: Dimensions.h_25,
            widthSize: Dimensions.h_25,
            isShadow: false,
            isCircle: true,
          ),

          SizedBox(width: Dimensions.w_6),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),

                SizedBox(height: Dimensions.h_2),

                Text(
                  role,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: FontSize.sp_9,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: Dimensions.w_45,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_5,
                  vertical: Dimensions.h_3,
                ),
                decoration: BoxDecoration(
                  color: levelBgColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  level,
                  style: TextStyle(
                    color: levelTextColor,
                    fontSize: FontSize.sp_9_5,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: Dimensions.w_5),

          SizedBox(
            width: Dimensions.w_32,
            child: Text(
              score,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
          ),

          SizedBox(width: Dimensions.w_15),

          SizedBox(
            width: Dimensions.w_45,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.h_3,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: confidenceBgColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                confidence,
                style: TextStyle(
                  color: confidenceTextColor,
                  fontSize: FontSize.sp_9_5,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pollOption({
    required String title,
    required int percentage,
    required bool isLight
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isLight ? AppColor.darkBlue : const Color(0xFF4B8BFF),
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
            SizedBox(width: Dimensions.w_4),
            Text(
              '$percentage%',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_9_5,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_3),
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: double.infinity,
              height: Dimensions.h_2,
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: constraints.maxWidth *
                      (percentage / 100),
                  height: Dimensions.h_2,
                  decoration: BoxDecoration(
                    color: isLight ? AppColor.darkBlue : const Color(0xFF4B8BFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _transparencyItem({
    required String title,
    required int percentage,
    required bool isLight
  }) {
    return Padding(
      padding:  EdgeInsets.only(left: Dimensions.w_6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_10,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_5),
          SizedBox(
            width: Dimensions.w_100,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: Dimensions.h_3,
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: constraints.maxWidth *
                          (percentage / 100),
                      height: Dimensions.h_3,
                      decoration: BoxDecoration(
                        color: isLight ? AppColor.townHallGreen : AppColor.townHallGreenDark,
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: Dimensions.w_5),
          SizedBox(
            width: Dimensions.w_23,
            child: Text(
              '$percentage%',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _projectItem({
    required String title,
    required int percentage,
  }) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.w_6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.sp_9_5,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_4),
              Text(
                '$percentage%',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_9_5,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: Get.width,
                height: Dimensions.h_3,
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: constraints.maxWidth * (percentage / 100),
                    height: Dimensions.h_3,
                    decoration: BoxDecoration(
                      color: AppColor.darkBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _activityItem({
    required Widget avatar,
    required Color avatarColor,
    required String title,
    required String action,
    required String highlight,
    required String time,
  }) {
    return Padding(
      padding:  EdgeInsets.only(left: Dimensions.w_5,bottom: Dimensions.h_5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Dimensions.h_22,
            height: Dimensions.h_22,
            decoration: BoxDecoration(
              color: avatarColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: avatar,
          ),
          SizedBox(width: Dimensions.w_6),
          Expanded(
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                  if (action.isNotEmpty)
                    TextSpan(
                      text: ' $action $highlight',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: FontSize.sp_9_5,
                        fontWeight: FontWeight.w500,
                        height: 1.1,
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_5),
          Text(
            time,
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: FontSize.sp_9,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _priorityItem({
    required String rank,
    required String title,
    required String percentage,
    required String label,
    required double progress,
    required Color color,
    required bool isLight
  }) {
    return Padding(
      padding:  EdgeInsets.only(left: Dimensions.w_8),
      child: Row(
        children: [
          Container(
            width: Dimensions.w_20,
            height: Dimensions.w_20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Text(
              rank,
              style:  TextStyle(
                color: Colors.white,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_5),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: FontSize.sp_10,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_4),
          Text(
            percentage,
            style: TextStyle(
              color: isLight ? AppColor.townHallGreen: AppColor.townHallGreenDark,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          SizedBox(width: Dimensions.w_2),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: FontSize.sp_9,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
          SizedBox(width: Dimensions.w_8),
          SizedBox(
            width: Dimensions.w_40,
            height: Dimensions.h_4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: Theme.of(context).highlightColor.withValues(alpha: 0.12)),
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(color: color),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget firstCard(bool isLight) {
    return CommonCard(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_1,vertical: Dimensions.h_5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: Dimensions.w_4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.h_4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "COMMUNITY IMPACT AT A GLANCE",
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
                    Text(
                      'Updated 8:30 AM PT',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: FontSize.sp_8_5,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h_12),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(width: Dimensions.w_10),
                      _impactItem(
                        icon: CupertinoIcons.heart_fill,
                        iconColor: isLight ? AppColor.townHallGreen:AppColor.townHallGreenDark,
                        value: '82',
                        title: 'Community Health',
                        subtitle: 'Good',
                      ),
                      _verticalDivider(),
                      SizedBox(width: Dimensions.w_10),
                      _impactItem(
                        icon: CupertinoIcons.person_2_fill,
                        iconColor: !isLight ? Color(0xffffc264):const Color(0xFF97590a),
                        value: '74%',
                        title: 'Participation Rate',
                        subtitle: 'Active',
                      ),
                      _verticalDivider(),
                      SizedBox(width: Dimensions.w_10),
                      _impactItem(
                        icon: CupertinoIcons.shield_fill,
                        iconColor: !isLight ? Color(0xffffc264):const Color(0xFF97590a),
                        value: '68%',
                        title: 'Gov. Responses',
                        subtitle: 'Improving',
                      ),
                      _verticalDivider(),
                      SizedBox(width: Dimensions.w_10),
                      _impactItem(
                        icon: CupertinoIcons.smiley_fill,
                        iconColor: isLight ? AppColor.townHallGreen:AppColor.townHallGreenDark,
                        value: '91%',
                        title: 'Community Satisfaction',
                        subtitle: 'High',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.h_12),
                Container(
                  height: 0.5,
                  width: Get.width,
                  color: Theme.of(context).highlightColor.withValues(alpha: 0.15)),
                SizedBox(height: Dimensions.h_10),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(width: Dimensions.w_10),
                      _impactItem(
                        icon: CupertinoIcons.checkmark_rectangle,
                        iconColor: Theme.of(context).highlightColor,
                        value: '56',
                        iconSize: Dimensions.h_13,
                        title: 'Active Projects',
                        subtitle: '+4 this week',
                        subTitleColor:  isLight ? AppColor.townHallGreen:AppColor.townHallGreenDark,
                      ),
                      _verticalDivider(),
                      SizedBox(width: Dimensions.w_10),
                      _impactItem(
                        icon: Icons.calendar_today_outlined,
                        iconColor: Theme.of(context).highlightColor,
                        value: '2',
                        title: 'Town Hall Meetings',
                        subtitle: 'This Month',
                        iconSize: Dimensions.h_13
                      ),
                      _verticalDivider(),
                      SizedBox(width: Dimensions.w_10),
                      _impactItem(
                        icon: CupertinoIcons.person_3_fill,
                        iconColor: Theme.of(context).highlightColor,
                        value: '2,314',
                        iconSize: Dimensions.h_16,
                        title: 'Residents Engaged',
                        subtitle: '+128 this week',
                        subTitleColor:  isLight ? AppColor.townHallGreen:AppColor.townHallGreenDark
                      ),
                      _verticalDivider(),
                      SizedBox(width: Dimensions.w_10),
                      _impactItem(
                        icon: CupertinoIcons.lightbulb,
                        iconSize: Dimensions.h_13,
                        iconColor: Theme.of(context).highlightColor,
                        value: '149',
                        title: 'Solutions Proposed',
                        subtitle: '+11 this week',
                        subTitleColor:  isLight ? AppColor.townHallGreen:AppColor.townHallGreenDark
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Dimensions.h_4),
              ],
            ),
          ),
          SizedBox(width: Dimensions.w_4),
        ],
      ),
    );
  }

  Widget _impactItem({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String title,
    double? iconSize,
    required String subtitle,
    Color? subTitleColor,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w_1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: iconSize ?? Dimensions.h_15,
                ),
                SizedBox(width: Dimensions.w_5),
                Text(
                  value,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_4),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
            SizedBox(height: Dimensions.h_2),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: subTitleColor ??  iconColor,
                fontSize: FontSize.sp_8_5,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 0.5,
      color: Theme.of(context).focusColor,
    );
  }

  Widget buildHeroHeader(bool isLight) {
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
        Positioned(
          child: Container(
            height: Dimensions.h_312,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: isLight
                    ? [
                  Colors.white.withValues(alpha: 0.70),
                  Colors.white.withValues(alpha: 0.70),
                  Colors.white.withValues(alpha: 0.60),
                  Colors.white.withValues(alpha: 0.30),
                  Colors.white.withValues(alpha: 0.0),
                ]
                    : [
                  const Color(0xE6020B15).withValues(alpha: 0.60),
                  const Color(0x99020B15).withValues(alpha: 0.60),
                  const Color(0x99020B15).withValues(alpha: 0.50),
                  const Color(0x00000000),
                  const Color(0x00000000),
                ],
                stops: const [0.08, 0.15, 0.35, 0.78, 1],
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
                "Issaquah Town Hall ",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_24,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_8,top: Dimensions.h_8),
              child: Text(
                "Your Community. Your Voice. Your Future.",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_13_5,
                  fontWeight: isLight ? FontWeight.w900 : FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_8,top: Dimensions.h_15,right: Dimensions.w_120),
              child: Text(
                "Town Hall is where our community comes together to identify issues, build better solutions, and engage with our representatives to create real change.",
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: FontSize.sp_11,
                  fontWeight:  FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: Dimensions.h_20),
            Container(
              padding: EdgeInsets.fromLTRB(
                Dimensions.w_5,
                Dimensions.h_1,
                Dimensions.w_5,
                Dimensions.h_5,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: isLight ? Colors.white:Color(0xE6020B15),
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
                          horizontal: Dimensions.w_12,
                          vertical: Dimensions.h_4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff1d5fef),
                          borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.pencil_circle_fill,
                              size: Dimensions.h_13,
                              color: Colors.white,
                            ),
                            SizedBox(width: Dimensions.w_5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Raise an Issue or Idea",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_10,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2
                                  ),
                                ),
                                Text(
                                  "Start a new project",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_8_5,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()=> Get.toNamed(AppRoutes.school),
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.w_8,top: Dimensions.h_5,bottom: Dimensions.h_8),
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_15,
                          vertical: Dimensions.h_4,
                        ),
                        decoration: BoxDecoration(
                          color: isLight ? Colors.white:Colors.black45,
                          border: Border.all(color: isLight ? AppColor.sportsLightBorder:Colors.white,width: 0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add,size: Dimensions.h_13,color: Theme.of(context).highlightColor),
                            SizedBox(width: Dimensions.w_2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Join a Discussion",
                                  style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontSize: FontSize.sp_10,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2
                                  ),
                                ),
                                Text(
                                  "Contribute to Solutions",
                                  style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontSize: FontSize.sp_8_5,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2
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
              ),
            ),
          ],
        ),
      ],
    );
  }

}



