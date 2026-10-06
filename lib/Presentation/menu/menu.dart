import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/dashboard/controller.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/fontsize.dart';
import '../../constants/constants.dart';
import '../../data/datasource/local/local_storage.dart';
import '../widgets/nav_item.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    final DashboardController dashboardController = Get.find<DashboardController>();
    return AppScaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Dimensions.h_20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.h_55,
                height: Dimensions.h_55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).highlightColor, width: 2),
                  image: const DecorationImage(image: CachedNetworkImageProvider('https://imgs.search.brave.com/IUfYd2HftVW3FCpGctrtu7cogsOex4KbSkTYx7ZhM4o/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJhY2Nlc3Mu/Y29tL2Z1bGwvOTQw/NDAzMi5qcGc'), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: Dimensions.w_12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shoyo',
                      style: TextStyle(fontSize: FontSize.sp_18, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                    ),
                    Text(
                      'shoyo@example.com',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: FontSize.sp_11, color: Theme.of(context).highlightColor),
                    ),
                    SizedBox(height: Dimensions.h_5),
                    GestureDetector(
                      onTap: () {
                        // Get.toNamed(AppRoutes.profile);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View Profile',
                            style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColorDark),
                          ),
                          Icon(CupertinoIcons.chevron_right, size: FontSize.sp_10, color: Theme.of(context).primaryColorDark),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  dashboardController.changeTabIndex(0);
                },
                child: Container(
                  height: Dimensions.h_20,
                  width: Dimensions.h_20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Icon(Icons.close, size: Dimensions.h_12)),
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
                  SizedBox(height: Dimensions.h_8),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.w_6),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(Dimensions.h_4),
                          decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, shape: BoxShape.circle),
                          child: Icon(!isLight ? CupertinoIcons.moon_stars : CupertinoIcons.sun_max, size: Dimensions.h_12, color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(width: Dimensions.w_10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${isLight ? 'Light' : 'Dark'} Appearance'.toUpperCase(),
                              style: TextStyle(color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500, fontSize: FontSize.sp_11),
                            ),
                            SizedBox(height: Dimensions.h_1),
                            Text(
                              'You can change your theme anytime from here',
                              style: TextStyle(color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500, fontSize: FontSize.sp_9),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Transform.scale(
                          scale: 0.6,
                          child: CupertinoSwitch(
                            value: !isLight,
                            onChanged: (value) {
                              LocalStorage.changeTheme();
                              LocalStorage.writeBool(GetXStorageConstants.day, !value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.h_3),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: CupertinoIcons.house,
                    title: 'Home',
                    onTap: () {
                      dashboardController.changeTabIndex(0);
                    },
                  ),
                  // SizedBox(height: Dimensions.h_5),
                  // NavItem(
                  //   icon: '',
                  //   isIcon: true,
                  //   isIconName: CupertinoIcons.building_2_fill,
                  //   title: 'Town Overview',
                  //   onTap: () {},
                  //   subItems: [
                  //     NavSubItem(title: 'Representation', onTap: () {}),
                  //     NavSubItem(title: 'Demographics', onTap: () {}),
                  //     NavSubItem(title: 'Founders', onTap: () {}),
                  //   ],
                  // ),
                  SizedBox(height: Dimensions.h_5),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: CupertinoIcons.doc_text,
                    title: 'Civic Command Center',
                    onTap: () {
                      Get.toNamed(AppRoutes.commandCenter);
                    },
                  ),
                  SizedBox(height: Dimensions.h_5),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: CupertinoIcons.chat_bubble_2_fill,
                    title: 'Town Hall',
                    onTap: () {
                      Get.toNamed(AppRoutes.townHall);
                    },
                  ),
                  SizedBox(height: Dimensions.h_5),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: CupertinoIcons.briefcase_fill,
                    title: 'Business',
                    onTap: () {
                      Get.toNamed(AppRoutes.business);
                    },
                  ),
                  // SizedBox(height: Dimensions.h_5),
                  // NavItem(
                  //   icon: '',
                  //   isIcon: true,
                  //   isIconName: CupertinoIcons.search,
                  //   title: 'Town Feed',
                  //   onTap: () {},
                  //   subItems: [
                  //     NavSubItem(title: 'Obituaries', onTap: () {}),
                  //     NavSubItem(title: 'Announcements', onTap: () {}),
                  //   ],
                  // ),
                  SizedBox(height: Dimensions.h_5),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: CupertinoIcons.car_detailed,
                    title: 'Garage',
                    onTap: () {
                      Get.toNamed(AppRoutes.garage);
                    },
                  ),
                  SizedBox(height: Dimensions.h_5),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.account_balance_outlined,
                    title: 'Politics',
                    onTap: () {
                      Get.toNamed(AppRoutes.politics);
                    },
                  ),
                  SizedBox(height: Dimensions.h_5),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: CupertinoIcons.book,
                    title: 'Education',
                    onTap: () {
                      Get.toNamed(AppRoutes.school);
                    },
                  ),
                  SizedBox(height: Dimensions.h_5),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.sports_football,
                    title: 'Sports',
                    onTap: () {
                      Get.toNamed(AppRoutes.sports);
                    },
                  ),
                  SizedBox(height: Dimensions.h_5),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: Icons.sunny,
                    title: 'Weather',
                    onTap: () {
                      Get.toNamed(AppRoutes.weather);
                    },
                  ),
                  SizedBox(height: Dimensions.h_5),
                  NavItem(
                    icon: '',
                    isIcon: true,
                    isIconName: CupertinoIcons.globe,
                    title: 'My Microsite',
                    onTap: () {
                      Get.toNamed(AppRoutes.microsite);
                    },
                  ),
                  // SizedBox(height: Dimensions.h_5),
                  // NavItem(
                  //   icon: '',
                  //   isIcon: true,
                  //   isIconName: CupertinoIcons.switch_camera_solid,
                  //   title: 'Ads',
                  //   onTap: () {
                  //     Get.toNamed(AppRoutes.adsWidget);
                  //   },
                  // ),
                  // SizedBox(height: Dimensions.h_5),
                  // NavItem(icon: '', isIcon: true, isIconName: CupertinoIcons.bookmark, title: 'Bookmarks', onTap: () {}),
                  // SizedBox(height: Dimensions.h_5),
                  // NavItem(icon: '', isIcon: true, isIconName: CupertinoIcons.archivebox, title: 'Archives', onTap: () {}),
                  // SizedBox(height: Dimensions.h_5),
                  // NavItem(icon: '', isIcon: true, isIconName: CupertinoIcons.person_add, title: 'Invites', onTap: () {}),
                  // SizedBox(height: Dimensions.h_5),
                  // NavItem(icon: '', isIcon: true, isIconName: CupertinoIcons.bell, title: 'Notifications', onTap: () {}),
                  // SizedBox(height: Dimensions.h_5),
                  // NavItem(icon: '', isIcon: true, isIconName: CupertinoIcons.money_dollar, title: 'Subscriptions', onTap: () {}),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: Dimensions.h_5),
                    height: 0.3,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: Dimensions.h_10),
                  MenuText(title: 'Profile'),
                  SizedBox(height: Dimensions.h_10),
                  MenuText(title: 'Settings'),
                  SizedBox(height: Dimensions.h_10),
                  MenuText(title: 'App Lock'),
                  SizedBox(height: Dimensions.h_10),
                  MenuText(title: 'Privacy Policy'),
                  SizedBox(height: Dimensions.h_10),
                  MenuText(title: 'Contact Us'),
                  SizedBox(height: Dimensions.h_10),
                  MenuText(title: "Logout", color: Colors.redAccent),
                  SizedBox(height: Dimensions.h_70),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuText extends StatelessWidget {
  const MenuText({super.key, required this.title, this.color});

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        title.toUpperCase(),
        style: TextStyle(color: color ?? Theme.of(context).highlightColor, fontWeight: color == Colors.redAccent ? FontWeight.w900 : FontWeight.w500, fontSize: FontSize.sp_11),
      ),
    );
  }
}
