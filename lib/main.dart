import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Presentation/getx/appPages.dart';
import 'approutes.dart';
import 'constants/Theme.dart';
import 'constants/fontsize.dart';
import 'data/datasource/local/local_storage.dart';
import 'data/datasource/remote/services/dio/dio.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      builder: EasyLoading.init(
        builder: (context,child) {
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarDividerColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
          );
          return child!;
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: LocalStorage().getTheme(),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppPages.list,
    );
  }
}

