import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/getx/app_pages.dart';
import 'package:wikixm/approutes.dart';
import '../../constants/fontsize.dart';
import '../widgets/drawer/src/slider_direction.dart';
import '../widgets/drawer/src/slider_drawer.dart';
import '../widgets/drawer_menu_item.dart';

/// Menu drawer shared by the Groups pages. [builder] gets a callback that opens the drawer,
/// for the page's app bar: `CommonScrollBlurScaffold(isDrawer: true, onTap: openDrawer, ...)`.
class GroupsDrawer extends StatefulWidget {
  const GroupsDrawer({super.key, required this.builder});

  final Widget Function(VoidCallback openDrawer) builder;

  @override
  State<GroupsDrawer> createState() => _GroupsDrawerState();
}

class _GroupsDrawerState extends State<GroupsDrawer> {
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey<SliderDrawerState>();

  void _go(String route, {int? myGroupsTab}) {
    final left = Get.find<GroupController>().openGroupsPage(route, from: ModalRoute.of(context)?.settings.name, myGroupsTab: myGroupsTab);
    left ? _closeAfterTransition() : sliderDrawerKey.currentState?.closeSlider();
  }

  // closing while the next page slides in looks jumpy; close once it covers this one
  void _closeAfterTransition() {
    Future.delayed(AppPages.duration, () {
      if (mounted) sliderDrawerKey.currentState?.closeSlider();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final here = ModalRoute.of(context)?.settings.name;
    return SliderDrawer(
      key: sliderDrawerKey,
      sliderOpenSize: Dimensions.w_260,
      isDraggable: false,
      slideDirection: SlideDirection.rightToLeft,
      slider: Builder(
        builder: (context) {
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
                          'GROUPS',
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900, letterSpacing: 1, height: 1),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => sliderDrawerKey.currentState?.closeSlider(),
                          child: Container(
                            width: Dimensions.h_20,
                            height: Dimensions.h_20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Theme.of(context).highlightColor.withValues(alpha: isLight ? 0.2 : 0.10), shape: BoxShape.circle),
                            child: Icon(Icons.close_rounded, color: Theme.of(context).primaryColor, size: Dimensions.h_10),
                          ),
                        ),
                        SizedBox(width: Dimensions.w_20),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.h_10),
                  menuItem(context, title: 'Groups Home', icon: CupertinoIcons.house, isSelected: here == AppRoutes.groups, isLight: isLight, onTap: () => _go(AppRoutes.groups)),
                  menuItem(context, title: 'My Groups', icon: CupertinoIcons.person_2, isSelected: here == AppRoutes.myGroup, isLight: isLight, onTap: () => _go(AppRoutes.myGroup, myGroupsTab: 0)),
                  menuItem(context, title: 'Discover Groups', icon: CupertinoIcons.search, isSelected: here == AppRoutes.searchGroups, isLight: isLight, onTap: () => _go(AppRoutes.searchGroups)),
                  menuItem(context, title: 'Public Profile', icon: CupertinoIcons.person_crop_circle, isSelected: here == AppRoutes.publicProfile, isLight: isLight, onTap: () => _go(AppRoutes.publicProfile)),
                  // shortcut: Interest Hubs opens Groups Home until it gets a page of its own
                  menuItem(context, title: 'Interest Hubs', icon: CupertinoIcons.doc_on_clipboard, isLight: isLight, onTap: () => _go(AppRoutes.groups)),
                  menuItem(
                    context,
                    title: 'Create Group',
                    icon: CupertinoIcons.plus_circle,
                    isLight: isLight,
                    onTap: () => _go(AppRoutes.createGroup),
                  ),
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
