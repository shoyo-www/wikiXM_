import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../approutes.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Get.offAllNamed(AppRoutes.firstTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.splash),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: Dimensions.h_170,
            height: Dimensions.h_170,
            child: Image.asset(Images.appLogoGif),
          ),
        ),
      ),
    );
  }
}
