import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/routes/custom_transition.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:wikixm/Presentation/auth/sign_in.dart';
import 'package:wikixm/Presentation/business/microsite.dart';
import 'package:wikixm/Presentation/command_center/command_center.dart';
import 'package:wikixm/Presentation/dashboard/dashboard.dart';
import 'package:wikixm/Presentation/first_visit/first_visit.dart';
import 'package:wikixm/Presentation/garage/add_item.dart';
import 'package:wikixm/Presentation/garage/garage_screen.dart';
import 'package:wikixm/Presentation/garage/market_brief.dart';
import 'package:wikixm/Presentation/garage/market_place.dart';
import 'package:wikixm/Presentation/groups/activity_detail.dart';
import 'package:wikixm/Presentation/groups/create_group.dart';
import 'package:wikixm/Presentation/groups/detail_page.dart';
import 'package:wikixm/Presentation/groups/group_detail.dart';
import 'package:wikixm/Presentation/groups/group_profile.dart';
import 'package:wikixm/Presentation/groups/my_group.dart';
import 'package:wikixm/Presentation/groups/search_groups.dart';
import 'package:wikixm/Presentation/groups/public_profile.dart';
import 'package:wikixm/Presentation/groups/group_settings.dart';
import 'package:wikixm/Presentation/groups/group_settings_page.dart';
import 'package:wikixm/Presentation/guide/ask_guide.dart';
import 'package:wikixm/Presentation/notifications/notifications.dart';
import 'package:wikixm/Presentation/politics/politics.dart';
import 'package:wikixm/Presentation/school/school_screen.dart';
import 'package:wikixm/Presentation/sports/sports_screen.dart';
import 'package:wikixm/Presentation/town_hall/town_hall_screen.dart';
import 'package:wikixm/Presentation/weather/weather.dart';
import 'package:wikixm/Presentation/widgets/ads_widget.dart';
import '../../approutes.dart';
import '../auth/sign_up.dart';
import '../business/business.dart';
import '../groups/groups.dart';
import '../splash/splash_screen.dart';

class AppPages {
  static const Duration duration = Duration(milliseconds: 1000);
  static const Transition transition = Transition.cupertinoDialog;
  static const Transition dashBoard = Transition.fadeIn;
  static var list = [
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.splashScreen, page: () => const SplashScreen()),
    // fade + rise + slight zoom so the entry is visible (both screens share the same city image); ease-out so it settles in
    GetPage(transitionDuration: const Duration(milliseconds: 550), curve: Curves.easeOutCubic, customTransition: DashboardTransition(), transition: dashBoard, name: AppRoutes.dashboard, page: () => const DashboardScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.askGuide, page: () => const AskGuide()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.firstTime, page: () => const FirstVisit()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.signIn, page: () => const SignInScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.signUp, page: () => const SignUpScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.sports, page: () => const SportsScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.business, page: () => const BusinessScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.weather, page: () => const WeatherScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.townHall, page: () => const TownHallScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.school, page: () => const SchoolScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.politics, page: () => const PoliticsScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.commandCenter, page: () => const CommandCenterScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.garage, page: () => const GarageScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.addItem, page: () => const AddItemScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.marketBrief, page: () => const MarketBrief()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.marketPlace, page: () => const MarketPlace()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.microsite, page: () => const BusinessMicrosite()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.adsWidget, page: () => const AdsWidget()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.notifications, page: () => const Notifications()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.groups, page: () => const GroupsScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.groupDetail, page: () => const GroupDetail()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.createGroup, page: () => const CreateGroupScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.activityDetail, page: () => const ActivityDetail()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.detailPage, page: () => const DetailPage()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.groupUserProfile, page: () => const GroupUserProfile()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.myGroup, page: () => const MyGroupsScreen()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.searchGroups, page: () => const SearchGroups()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.publicProfile, page: () => const PublicProfile()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.groupSettings, page: () => const GroupSettings()),
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.groupSettingsPage, page: () => const GroupSettingsPage()),
  ];
}

class DashboardTransition extends CustomTransition {
  @override
  Widget buildTransition(BuildContext context, Curve? curve, Alignment? alignment, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final curved = CurvedAnimation(parent: animation, curve: curve ?? Curves.easeOutCubic);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween(begin: const Offset(0, 0.06), end: Offset.zero).animate(curved),
        child: ScaleTransition(scale: Tween(begin: 0.96, end: 1.0).animate(curved), child: child),
      ),
    );
  }
}
