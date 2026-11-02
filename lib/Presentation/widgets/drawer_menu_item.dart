import 'package:flutter/material.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/fontsize.dart';

/// One row of a SliderDrawer menu (Garage, My Groups).
Widget menuItem(BuildContext context, {required String title, required IconData icon, bool isSelected = false, VoidCallback? onTap, bool? isLight, String? badge, bool isBadgeRed = false}) {
  final theme = Theme.of(context);
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: Dimensions.h_2, right: Dimensions.w_20),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7, vertical: Dimensions.h_4),
      decoration: BoxDecoration(
        color: isSelected ? (isLight == true ? const Color(0xFFEDF3FB) : const Color(0xFF14223A)) : Colors.transparent,
        borderRadius: BorderRadius.circular(Dimensions.h_6),
        border: isSelected ? Border.all(color: theme.primaryColorDark.withValues(alpha: 0.50), width: 0.5) : null,
      ),
      child: Row(
        children: [
          Container(
            width: Dimensions.h_22,
            height: Dimensions.h_22,
            decoration: BoxDecoration(
              color: isSelected ? (isLight == true ? const Color(0xFFEDF3FB) : const Color(0xFF14223A)) : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: isSelected ? theme.primaryColorDark.withValues(alpha: 0.50) : theme.primaryColor.withValues(alpha: 0.30), width: 0.5),
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? isLight == true
                        ? AppColor.darkBlue
                        : const Color(0xFF4b8bff)
                  : theme.primaryColor,
              size: Dimensions.h_12,
            ),
          ),
          SizedBox(width: Dimensions.w_7),
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                color: isSelected
                    ? isLight == true
                          ? AppColor.darkBlue
                          : const Color(0xFF4b8bff)
                    : theme.primaryColor,
                fontSize: FontSize.sp_10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w700,
                height: 1,
              ),
            ),
          ),
          if (badge != null)
            Container(
              constraints: BoxConstraints(minWidth: Dimensions.h_15, minHeight: Dimensions.h_15),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: isBadgeRed ? const Color(0xFFE51B3E) : const Color(0xFF2775C9), shape: BoxShape.circle),
              child: Text(
                badge,
                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_8, fontWeight: FontWeight.w900),
              ),
            ),
        ],
      ),
    ),
  );
}
