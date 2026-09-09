import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/appcolor.dart';
import '../../constants/extensions.dart';
import '../../constants/fontsize.dart';

class SportsEventItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  final bool isLive;
  final bool showWatchLive;
  final VoidCallback? onWatchLive;
  final VoidCallback? onTap;

  const SportsEventItem({
    super.key,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.isLive = false,
    this.showWatchLive = false,
    this.onWatchLive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: Dimensions.w_5),

          // TIME
          Text(
            time,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),

          SizedBox(width: Dimensions.w_15),

          // SPORT ICON
          Icon(
            icon,
            color: iconColor,
            size: Dimensions.h_18,
          ),

          SizedBox(width: Dimensions.w_10),

          // TITLE + SUBTITLE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),

                SizedBox(height: Dimensions.h_2),

                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_9,
                    fontWeight: FontWeight.w500,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),

          // LIVE
          if (isLive) ...[
            SizedBox(width: Dimensions.w_5),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w_5,
                vertical: Dimensions.h_1,
              ),
              decoration: BoxDecoration(
                color: AppColor.sportsLightSecondaryText,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'LIVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.sp_8,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],

          // WATCH LIVE
          if (showWatchLive) ...[
            SizedBox(width: Dimensions.w_8),

            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onWatchLive,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.h_3,
                  horizontal: Dimensions.w_5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: context.sports.secondaryText,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.play_arrow_solid,
                      size: Dimensions.h_12,
                      color: context.sports.secondaryText,
                    ),

                    SizedBox(width: Dimensions.w_3),

                    Text(
                      'Watch Live',
                      style: TextStyle(
                        color: context.sports.secondaryText,
                        fontSize: FontSize.sp_9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          SizedBox(width: Dimensions.w_8),

          // ARROW
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: Dimensions.h_11,
            color: Theme.of(context).highlightColor,
          ),

          SizedBox(width: Dimensions.w_5),
        ],
      ),
    );
  }
}