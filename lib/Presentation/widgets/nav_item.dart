import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wikixm/constants/fontsize.dart';

class NavItem extends StatefulWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final bool? isPng;
  final bool? isIcon;
  final IconData? isIconName;
  final bool? isLogged;
  final List<NavSubItem> subItems;

  const NavItem({
    super.key,
    required this.icon,
    this.isPng,
    required this.title,
    required this.onTap,
    this.isLogged,
    this.isIcon,
    this.isIconName,
    this.subItems = const [],
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _expanded = false;

  bool get hasSubItems => widget.subItems.isNotEmpty;
  IconData get iconData {
    switch (widget.title) {
      case 'Home':
        return Icons.home_outlined;
      case 'Town Overview':
        return Icons.location_city_outlined;
      case 'My Content':
        return Icons.article_outlined;
      case 'Town Hall':
        return Icons.forum_outlined;
      case 'My Business':
        return Icons.business_center_outlined;
      case 'Town feed':
        return Icons.campaign_outlined;
      case 'Messages':
        return Icons.mail_outline;
      case 'Bookmarks':
        return Icons.bookmark_border;
      case 'Archives':
        return Icons.archive_outlined;
      case 'Invites':
        return Icons.group_add_outlined;
      case 'Notifications':
        return Icons.notifications_none;
      default:
        return Icons.circle_outlined;
    }
  }

  void _handleTap() {
    if (widget.isLogged == true) {
      widget.onTap();
    } else {
      if (hasSubItems) {
        setState(() => _expanded = !_expanded);
      } else {
        widget.onTap();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _handleTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w_10,
              vertical: Dimensions.h_5,
            ),
            child: Row(
              children: [
                widget.isIcon == true
                    ? Icon(
                        widget.isIconName ??
                            CupertinoIcons.cloud_bolt_rain_fill,
                        size: Dimensions.h_16,
                        color: Colors.grey.shade700,
                      )
                    : widget.isPng == true
                    ? Image.asset(
                        widget.icon,
                        color: Colors.black87,
                        height: Dimensions.h_15,
                        width: Dimensions.h_15,
                      )
                    : Icon(
                        iconData,
                        size: Dimensions.h_16,
                        color: Colors.grey.shade700,
                      ),
                SizedBox(width: Dimensions.w_10),
                Text(
                  widget.title.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.sp(12.5),
                  ),
                ),
                Spacer(),
                if (hasSubItems)
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: Dimensions.h_20,
                      color: Colors.black87,
                    ),
                  ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeOut,
          child: _expanded
              ? ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 1.0,
                    child: Container(
                      margin: EdgeInsets.only(left: Dimensions.w_35),
                      padding: EdgeInsets.only(left: Dimensions.w_15),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.grey.shade500,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Column(
                        children: widget.subItems.map((sub) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              sub.onTap();
                              setState(() {
                                _expanded = false;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Dimensions.h_6,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      sub.title,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: SizeConfig.sp(12.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}

class NavSubItem {
  final String title;
  final VoidCallback onTap;

  NavSubItem({required this.title, required this.onTap});
}
