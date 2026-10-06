import 'package:flutter/material.dart';

import '../../constants/extensions.dart';
import '../../constants/fontsize.dart';

class SportsInfoItem extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const SportsInfoItem({super.key, required this.icon, required this.iconSize, required this.iconColor, required this.title, required this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.sports.card,
        border: Border.all(color: context.sports.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: iconSize, color: iconColor),

          SizedBox(width: Dimensions.w_5),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
              ),

              Text(
                subtitle,
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );

    return Expanded(
      child: onTap != null ? GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: child) : child,
    );
  }
}
