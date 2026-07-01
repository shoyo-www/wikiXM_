import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:wikixm/Presentation/auth/sign_in.dart';
import 'package:wikixm/Presentation/dashboard/dashboard.dart';
import 'package:wikixm/Presentation/first_visit/first_visit.dart';
import 'package:wikixm/Presentation/guide/ask_guide.dart';
import '../../approutes.dart';
import '../auth/sign_up.dart';
import '../home/home.dart';
import '../splash/splash_screen.dart';

class AppPages {
  static const Duration duration = Duration(milliseconds: 500);
  static const Transition transition = Transition.cupertinoDialog;
  static var list = [
    GetPage(
      transitionDuration: duration,
      transition: transition,
      name: AppRoutes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      transitionDuration: duration,
      transition: transition,
      name: AppRoutes.home,
      page: () => const Home(),
    ),
    GetPage(
      transitionDuration: duration,
      transition: transition,
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      transitionDuration: duration,
      transition: transition,
      name: AppRoutes.askGuide,
      page: () => const AskGuide(),
    ),
    GetPage(
      transitionDuration: duration,
      transition: Transition.cupertinoDialog,
      name: AppRoutes.firstTime,
      page: () => const FirstVisit(),
    ),
    GetPage(
      transitionDuration: duration,
      transition: Transition.cupertinoDialog,
      name: AppRoutes.signIn,
      page: () => const SignInScreen(),
    ),
    GetPage(
      transitionDuration: duration,
      transition: Transition.cupertinoDialog,
      name: AppRoutes.signUp,
      page: () => const SignUpScreen(),
    ),
  ];
}
