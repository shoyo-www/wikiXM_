import 'dart:io';
import 'package:cupertino_native/components/tab_bar.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/fontsize.dart';
import '../dashboard/controller.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.body, this.appBar, this.top, this.bottom, this.backgroundColor, this.bodyPadding, this.isNavbar, this.drawer, this.bottomNavigationBar});

  final PreferredSizeWidget? appBar;
  final Widget body;
  final bool? top;
  final bool? bottom;
  final bool? isNavbar;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? bodyPadding;
  final Widget? bottomNavigationBar;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return ColoredBox(
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        top: top ?? true,
        bottom: Platform.isAndroid ? true : bottom ?? false,
        child: isNavbar == true
            ? Stack(
                children: [
                  Positioned.fill(
                    child: Scaffold(
                      appBar: appBar,
                      drawer: drawer,
                      body: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                        child: Padding(
                          padding: bodyPadding ?? EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                          child: body,
                        ),
                      ),
                      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  Obx(
                    () => Positioned(
                      left: 0,
                      right: 0,
                      bottom: Platform.isAndroid ? Dimensions.h_5 : 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_20),
                        child: Platform.isAndroid
                            ? Container(
                                height: Dimensions.h_42,
                                padding: EdgeInsets.all(Dimensions.h_3),
                                decoration: BoxDecoration(
                                  color: isLight ? Theme.of(context).cardColor : Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(color: Theme.of(context).focusColor, width: 0.4),
                                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .06), blurRadius: 12, offset: const Offset(0, 4))],
                                ),
                                child: Row(
                                  children: List.generate(_tabs.length, (index) {
                                    final selected = controller.tabIndex.value == index;
                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () => controller.changeTabIndex(index),
                                        behavior: HitTestBehavior.opaque,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: selected
                                                ? isLight
                                                      ? Theme.of(context).scaffoldBackgroundColor
                                                      : Theme.of(context).cardColor
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(35),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(_tabs[index].icon, color: selected ? Theme.of(context).primaryColorDark : Theme.of(context).highlightColor, size: index == 3 ? Dimensions.h_20 : Dimensions.h_18),
                                              Text(
                                                _tabs[index].title,
                                                style: TextStyle(fontSize: FontSize.sp_8_5, fontWeight: selected ? FontWeight.w700 : FontWeight.w600, color: selected ? Theme.of(context).primaryColorDark : Theme.of(context).highlightColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              )
                            : CNTabBar(
                                height: Dimensions.h_60,
                                items: const [
                                  CNTabBarItem(label: 'Home', icon: CNSymbol('house.fill')),
                                  CNTabBarItem(label: 'News', icon: CNSymbol('newspaper.fill')),
                                  CNTabBarItem(label: 'Post', icon: CNSymbol('square.and.pencil')),
                                  CNTabBarItem(label: 'Events', icon: CNSymbol('music.note')),
                                  CNTabBarItem(label: 'Menu', icon: CNSymbol('line.3.horizontal')),
                                ],
                                iconSize: Dimensions.h_11,
                                currentIndex: controller.tabIndex.value,
                                split: false,
                                tint: isLight ? AppColor.darkBlue : const Color(0xFF73aaff),
                                backgroundColor: Colors.transparent,
                                splitSpacing: Dimensions.w_10,
                                rightCount: 0,
                                shrinkCentered: true,
                                onTap: controller.changeTabIndex,
                              ),
                      ),
                    ),
                  ),
                ],
              )
            : Scaffold(
                appBar: appBar,
                drawer: drawer,
                body: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Padding(
                    padding: bodyPadding ?? EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                    child: body,
                  ),
                ),
                backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
                bottomNavigationBar: bottomNavigationBar,
              ),
      ),
    );
  }
}

class BottomTab {
  final String title;
  final IconData icon;

  const BottomTab({required this.title, required this.icon});
}

const List<BottomTab> _tabs = [
  BottomTab(title: 'Home', icon: CupertinoIcons.house_fill),
  BottomTab(title: 'News', icon: CupertinoIcons.news),
  BottomTab(title: 'Post', icon: CupertinoIcons.square_pencil_fill),
  BottomTab(title: 'Events', icon: CupertinoIcons.music_note),
  BottomTab(title: 'Menu', icon: CupertinoIcons.line_horizontal_3),
];
