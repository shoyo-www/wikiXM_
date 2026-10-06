import 'package:flutter/material.dart';
import 'package:wikixm/constants/appcolor.dart';

import '../../constants/fontsize.dart';

class CommonCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? radius;
  final Color? color;
  final bool? isBorder;

  const CommonCard({super.key, required this.child, this.height, this.padding, this.margin, this.radius, this.color, this.isBorder});

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.brightnessOf(context) == Brightness.light;
    return Container(
      margin: margin ?? EdgeInsets.zero,
      height: height,
      padding: padding ?? EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_8, Dimensions.w_8, Dimensions.h_8),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        border: isBorder == false ? null : Border.all(color: isLight ? Colors.grey : Colors.white24, width: isLight ? 0.4 : 0.4),
        borderRadius: BorderRadius.circular(radius ?? Dimensions.h_10),
      ),
      child: child,
    );
  }
}
