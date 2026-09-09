import 'package:flutter/material.dart';

import '../../constants/extensions.dart';
import '../../constants/fontsize.dart';

class SportsStatCard extends StatelessWidget {
  final Widget icon;
  final String value;
  final String title;

  const SportsStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w_3,
          vertical: Dimensions.h_2,
        ),
        decoration: BoxDecoration(
          color: context.sports.card,
          border: Border.all(
            color: context.sports.border,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            Dimensions.h_6,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                icon,
                SizedBox(height: Dimensions.h_8),
                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_18,
                    fontWeight: FontWeight.w700,
                    height: 1.05,
                  ),
                ),
              ],
            ),

            SizedBox(height: Dimensions.h_4),

            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w500,
                height: 1.05,
              ),
            ),
          ],
        ),
      ),
    );
  }
}