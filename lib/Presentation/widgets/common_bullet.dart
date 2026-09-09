import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/appcolor.dart';
import '../../constants/fontsize.dart';

class CommonBulletItem extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;

  // New optional properties
  final String? subtitle;
  final String? trailingText;
  final IconData? leadingIcon;
  final Color? trailingColor;
  final FontWeight? textFontWeight;

  const CommonBulletItem({
    super.key,
    required this.text,
    this.textColor,
    this.iconColor,
    this.iconSize,
    this.padding,
    this.subtitle,
    this.trailingText,
    this.leadingIcon,
    this.trailingColor,
    this.textFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            left: Dimensions.w_2,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            leadingIcon ??
                CupertinoIcons.checkmark_circle_fill,
            color: iconColor ??
                AppColor.darkGreenSportsSecondaryText,
            size: iconSize ?? Dimensions.h_13,
          ),
          SizedBox(width: Dimensions.w_8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor ??
                        Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_10,
                    fontWeight:
                    textFontWeight ?? FontWeight.w600,
                    height: 1.1,
                  ),
                ),

                if (subtitle != null) ...[
                  SizedBox(height: Dimensions.h_2),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor ??
                          Theme.of(context).highlightColor,
                      fontSize: FontSize.sp_8_5,
                      fontWeight: FontWeight.w400,
                      height: 1.1,
                    ),
                  ),
                ],
              ],
            ),
          ),

          if (trailingText != null) ...[
            SizedBox(width: Dimensions.w_8),
            Text(
              trailingText!,
              style: TextStyle(
                color: trailingColor ??
                    textColor ??
                    Theme.of(context).highlightColor,
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    );
  }
}