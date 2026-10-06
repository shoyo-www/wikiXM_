import 'package:flutter/material.dart';

import '../../constants/extensions.dart';
import '../../constants/fontsize.dart';

class SportsCommunityItem extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String badge;
  final String title;

  final double badgeRight;
  final double badgeTop;

  const SportsCommunityItem({super.key, required this.icon, required this.iconSize, required this.badge, required this.title, this.badgeRight = 8, this.badgeTop = 4});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_1, vertical: Dimensions.h_10),
        decoration: BoxDecoration(
          color: context.sports.card,
          border: Border.all(color: context.sports.border),
          borderRadius: BorderRadius.circular(Dimensions.h_6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: iconSize, color: Theme.of(context).highlightColor),
                if (badge.isNotEmpty)
                  Positioned(
                    right: -Dimensions.w_8,
                    top: -Dimensions.h_4,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_2),
                      decoration: BoxDecoration(color: context.sports.secondaryText, borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        badge,
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_8, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: Dimensions.h_8),

            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1.05),
            ),
          ],
        ),
      ),
    );
  }
}
