import 'package:flutter/material.dart';

import '../../constants/extensions.dart';
import '../../constants/fontsize.dart';

class SportsStatItem extends StatelessWidget {
  final String value;
  final String label;

  const SportsStatItem({super.key, required this.value, required this.label});

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
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_20, fontWeight: FontWeight.w800, height: 1.05),
            ),
            SizedBox(height: Dimensions.h_8),
            Text(
              label.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8, fontWeight: FontWeight.w500, height: 1.05),
            ),
          ],
        ),
      ),
    );
  }
}
