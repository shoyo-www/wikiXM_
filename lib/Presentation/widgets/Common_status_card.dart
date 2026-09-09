import 'package:flutter/material.dart';

import '../../constants/fontsize.dart';
import 'common_card.dart';

class CommonStatusCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final Widget icon;
  final Color valueColor;
  final Color? titleColor;

  const CommonStatusCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.subtitle,
    this.valueColor = Colors.black87,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CommonCard(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w_2,
          vertical: Dimensions.h_3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: Dimensions.w_3),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: titleColor ?? Theme.of(context).highlightColor,
                      fontSize: FontSize.sp_8_5,
                      fontWeight: FontWeight.w500,
                      height: 1.05,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: Dimensions.h_4),

            Padding(
              padding: EdgeInsets.only(left: Dimensions.w_4),
              child: Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w600,
                  height: 1.05,
                ),
              ),
            ),

            if (subtitle != null) ...[
              SizedBox(height: Dimensions.h_1),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_4),
                child: Text(
                  subtitle!,
                  style: TextStyle(
                    color: valueColor,
                    fontSize: FontSize.sp_7,
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}