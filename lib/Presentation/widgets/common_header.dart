import 'package:flutter/material.dart';

import '../../constants/fontsize.dart';

class CommonSectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final Color? linkColor;
  final Color? color;
  final Widget? icon;
  final VoidCallback? onActionTap;
  final String? secondActionText;
  final VoidCallback? onSecondActionTap;
  final bool? isSubtitle;
  const CommonSectionHeader({
    super.key,
    required this.title,
    this.actionText = 'See All',
    this.linkColor,
    this.icon,
    this.color,
    this.onActionTap,
    this.secondActionText,
    this.onSecondActionTap,
    this.isSubtitle
  });

  @override
  Widget build(BuildContext context) {
    final Color actionColor =
        linkColor ?? Theme.of(context).primaryColorDark;

    return Row(
      children: [
        if (icon != null) ...[
          icon!,
          SizedBox(width: Dimensions.w_4),
        ],
        Text(
          title,
          style: TextStyle(
            color: color ?? Theme.of(context).highlightColor,
            fontSize: FontSize.sp_11,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
        const Spacer(),
         if(actionText.isNotEmpty)
        _actionItem(
          text: actionText,
          color: actionColor,
          onTap: onActionTap,
        ),
      ],
    );
  }

  Widget _actionItem({
    required String text,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          SizedBox(width: Dimensions.w_3),
          Icon(
            Icons.arrow_forward,
            color: color,
            size: Dimensions.h_11,
          ),
        ],
      ),
    );
  }
}