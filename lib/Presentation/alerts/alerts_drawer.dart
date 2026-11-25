import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/alerts/alerts_controller.dart';
import 'package:wikixm/Presentation/getx/app_pages.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/drawer/src/slider_direction.dart';
import '../widgets/drawer/src/slider_drawer.dart';
import '../widgets/drawer_menu_item.dart';

/// Menu drawer shared by the Alerts pages. [builder] gets a callback that opens the drawer,
/// for the page's app bar: `CommonScrollBlurScaffold(isDrawer: true, onTap: openDrawer, ...)`.
class AlertsDrawer extends StatefulWidget {
  const AlertsDrawer({super.key, required this.builder});

  final Widget Function(VoidCallback openDrawer) builder;

  @override
  State<AlertsDrawer> createState() => _AlertsDrawerState();
}

class _AlertsDrawerState extends State<AlertsDrawer> {
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey<SliderDrawerState>();

  void _go(bool Function() navigate) => navigate() ? _closeAfterTransition() : sliderDrawerKey.currentState?.closeSlider();

  void _closeAfterTransition() {
    Future.delayed(AppPages.duration, () {
      if (mounted) sliderDrawerKey.currentState?.closeSlider();
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AlertsController>();
    final isLight = Theme.of(context).brightness == Brightness.light;
    final here = ModalRoute.of(context)?.settings.name;
    return SliderDrawer(
      key: sliderDrawerKey,
      sliderOpenSize: Dimensions.w_260,
      isDraggable: false,
      slideDirection: SlideDirection.rightToLeft,
      // rebuilds only the menu, so the selected category stays in sync
      slider: GetBuilder<AlertsController>(
        id: ControllerBuilders.allAlerts,
        builder: (_) {
          return Container(
            height: double.infinity,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h_45),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.w_4),
                    child: Row(
                      children: [
                        Text(
                          'ALERTS',
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900, letterSpacing: 1, height: 1),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => sliderDrawerKey.currentState?.closeSlider(),
                          child: Container(
                            width: Dimensions.h_20,
                            height: Dimensions.h_20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor.withValues(alpha: isLight ? 0.2 : 0.10),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.close_rounded, color: Theme.of(context).primaryColor, size: Dimensions.h_10),
                          ),
                        ),
                        SizedBox(width: Dimensions.w_20),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.h_10),
                  menuItem(
                    context,
                    title: 'Alerts home',
                    icon: CupertinoIcons.house,
                    isSelected: here == AppRoutes.alerts,
                    isLight: isLight,
                    onTap: () => _go(() => c.openAlertsHome(from: here)),
                  ),
                  for (final (title, icon) in AlertsController.drawerCategories) menuItem(context, title: title, icon: icon, isSelected: here == AppRoutes.allAlerts && c.alertsCategoryName == title, isLight: isLight, onTap: () => _go(() => c.openAlertsCategory(title))),
                  menuItem(context, title: 'Communities Photos', icon: CupertinoIcons.camera, isSelected: here == AppRoutes.communityPhotos, isLight: isLight, onTap: () => _go(c.openCommunityPhotos)),
                  menuItem(context, title: 'Report an issue', icon: CupertinoIcons.pencil, isSelected: here == AppRoutes.reportIssue, isLight: isLight, onTap: () => _go(c.reportAlert)),
                ],
              ),
            ),
          );
        },
      ),
      child: widget.builder(() => sliderDrawerKey.currentState?.openSlider()),
    );
  }
}
