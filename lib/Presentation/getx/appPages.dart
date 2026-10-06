import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:wikixm/Presentation/auth/sign_in.dart';
import 'package:wikixm/Presentation/business/microsite.dart';
import 'package:wikixm/Presentation/command_center/command_center.dart';
import 'package:wikixm/Presentation/dashboard/dashboard.dart';
import 'package:wikixm/Presentation/first_visit/first_visit.dart';
import 'package:wikixm/Presentation/garage/add_item.dart';
import 'package:wikixm/Presentation/garage/garage_screen.dart';
import 'package:wikixm/Presentation/garage/marketBrief.dart';
import 'package:wikixm/Presentation/garage/market_place.dart';
import 'package:wikixm/Presentation/guide/ask_guide.dart';
import 'package:wikixm/Presentation/politics/politics.dart';
import 'package:wikixm/Presentation/school/school_screen.dart';
import 'package:wikixm/Presentation/sports/sports_screen.dart';
import 'package:wikixm/Presentation/town_hall/town_hall_screen.dart';
import 'package:wikixm/Presentation/weather/weather.dart';
import 'package:wikixm/Presentation/widgets/ads_widget.dart';
import '../../approutes.dart';
import '../auth/sign_up.dart';
import '../business/business.dart';
import '../splash/splash_screen.dart';

class AppPages {
  static const Duration duration = Duration(milliseconds: 1000);
  static const Transition transition = Transition.cupertinoDialog;
  static const Transition dashBoard = Transition.fadeIn;
  static var list = [
    GetPage(transitionDuration: duration, transition: transition, name: AppRoutes.splashScreen, page: () => const SplashScreen()),
    GetPage(transitionDuration: duration, transition: dashBoard, name: AppRoutes.dashboard, page: () => const DashboardScreen()),
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
  ];
}
