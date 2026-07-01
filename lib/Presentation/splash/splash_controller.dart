// import 'dart:async';
//
// import 'package:get/get.dart';
//
// import '../../data/local/local_storage.dart';
// import '../../utils/helper/shared_preference_helper.dart';
// import '../../widgets/push_notification_service.dart';
// import '../../utils/routes/routes.dart';
// import 'app_data_service.dart';
//
// class SplashController extends GetxController {
//   static const Duration _minimumSplashDuration = Duration(seconds: 3);
//
//   final AppDataService appDataService = Get.find<AppDataService>();
//   Timer? _navigationTimer;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadAppData();
//   }
//
//   Future<void> loadAppData() async {
//     unawaited(appDataService.loadStates());
//
//     if (NotificationService.isOpenedFromNotification) {
//       return;
//     }
//
//     final initialRoute = _resolveInitialRoute();
//     _navigationTimer?.cancel();
//     _navigationTimer = Timer(_minimumSplashDuration, () {
//       if (isClosed) return;
//       Get.offAllNamed(initialRoute);
//     });
//   }
//
//   @override
//   void onClose() {
//     _navigationTimer?.cancel();
//     super.onClose();
//   }
//
//   String _resolveInitialRoute() {
//     final preferenceHelper = SharedPreferenceHelper();
//     final isLoggedIn =
//         preferenceHelper.getIsLoggedIn() ||
//         LocalDatabase.getString('isLogin') == '0';
//     if (isLoggedIn) {
//       if (preferenceHelper.getBiometricLockEnabled()) {
//         return Routes.biometricLock;
//       }
//       return Routes.dashboard;
//     }
//     if (LocalDatabase.getString('isLogin') == '1') {
//       return Routes.dashboard;
//     }
//     return Routes.loginSelection;
//   }
// }
