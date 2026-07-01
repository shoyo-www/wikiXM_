import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/dashboard/controller.dart';
import '../home/home.dart';
import '../menu/menu.dart';
import '../widgets/common_scaffold.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = Get.find<DashboardController>();

  final List<Widget Function()> screens = [
    () => Home(),
    () => Home(),
    () => Home(),
    () => Home(),
    () => Menu(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      isNavbar: true,
      body: Obx(() {
        return Stack(
          children: List.generate(screens.length, (index) {
            final isActive = controller.tabIndex.value == index;
            return AnimatedScale(
              scale: isActive ? 1.0 : 0.95,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                opacity: isActive ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: IgnorePointer(
                  ignoring: !isActive,
                  child: isActive ? screens[index]() : const SizedBox.shrink(),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
