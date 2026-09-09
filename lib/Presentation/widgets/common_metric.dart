import 'package:flutter/material.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';

import '../../constants/fontsize.dart';

class CommonMetricCard extends StatelessWidget {
  final Widget icon;
  final String value;
  final String label;
  final Color? valueColor;
  final Color? labelColor;
  final EdgeInsetsGeometry? padding;

  const CommonMetricCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.valueColor,
    this.labelColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: Dimensions.w_3,
            vertical: Dimensions.h_2,
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              icon,
              SizedBox(height: Dimensions.h_6),
              Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: valueColor ?? Theme.of(context).highlightColor,
                  fontSize: FontSize.sp_18,
                  fontWeight: FontWeight.w700,
                  height: 1.05,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: labelColor ?? Theme.of(context).highlightColor,
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w500,
                height: 1.05,
              ),
            ),
          ),
        ],
      ),
    );
  }
}