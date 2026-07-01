import 'package:flutter/material.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/constants/fontsize.dart';

import '../widgets/nav_item.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Dimensions.h_50),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: Dimensions.h_25,
                  width: Dimensions.h_25,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.close, size: Dimensions.h_15),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          Container(
            margin: EdgeInsets.symmetric(vertical: Dimensions.h_1),
            height: Dimensions.h_05,
            color: Colors.grey.shade500,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.home_outlined,
                    title: 'Home',
                    onTap: () {},
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.location_city_outlined,
                    title: 'Town Overview',
                    onTap: () {},
                    subItems: [
                      NavSubItem(title: 'Representation', onTap: () {}),
                      NavSubItem(title: 'Demographics', onTap: () {}),
                      NavSubItem(title: 'Founders', onTap: () {}),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.article_outlined,
                    title: 'My Content',
                    onTap: () {},
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.forum_outlined,
                    title: 'Town Hall',
                    onTap: () {},
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.business_center_outlined,
                    title: 'My Business',
                    onTap: () {},
                    subItems: [
                      NavSubItem(title: 'View', onTap: () {}),
                      NavSubItem(title: 'Advertisement', onTap: () {}),
                      NavSubItem(title: 'Analytics', onTap: () {}),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.campaign_outlined,
                    title: 'Town feed',
                    onTap: () {},
                    subItems: [
                      NavSubItem(title: 'Obituaries', onTap: () {}),
                      NavSubItem(title: 'Announcements', onTap: () {}),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.home_repair_service_outlined,
                    title: 'Town Essentials',
                    onTap: () {},
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.directions_car_outlined,
                    title: 'Garage',
                    onTap: () {},
                    subItems: [
                      NavSubItem(title: 'My Garage', onTap: () {}),
                      NavSubItem(title: 'Town Garage', onTap: () {}),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.mail_outline,
                    title: 'Messages',
                    onTap: () {},
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.warning_amber_outlined,
                    title: 'Alerts',
                    onTap: () {},
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.bookmark_border,
                    title: 'Bookmarks',
                    onTap: () {},
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.archive_outlined,
                    title: 'Archives',
                    onTap: () {},
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.group_add_outlined,
                    title: 'Invites',
                    onTap: () {},
                  ),
                  SizedBox(height: Dimensions.h_10),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.notifications_none,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  SizedBox(height: Dimensions.h_5),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.attach_money,
                    title: 'Subscriptions',
                    onTap: () {},
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: Dimensions.h_5),
                    height: Dimensions.h_1,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: Dimensions.h_10),
                  _MenuText(title: 'Profile'),
                  SizedBox(height: Dimensions.h_10),
                  _MenuText(title: 'Settings'),
                  SizedBox(height: Dimensions.h_10),
                  _MenuText(title: 'App Lock'),
                  SizedBox(height: Dimensions.h_10),
                  _MenuText(title: 'Privacy Policy'),
                  SizedBox(height: Dimensions.h_10),
                  _MenuText(title: 'Contact Us'),
                  SizedBox(height: Dimensions.h_10),
                  _MenuText(title: 'Sign In', color: Colors.redAccent),
                  SizedBox(height: Dimensions.h_70),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_30),
        ],
      ),
    );
  }
}

class _MenuText extends StatelessWidget {
  const _MenuText({required this.title, this.color = Colors.black87});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: color == Colors.redAccent
              ? FontWeight.w700
              : FontWeight.w500,
          fontSize: FontSize.sp_13,
        ),
      ),
    );
  }
}
