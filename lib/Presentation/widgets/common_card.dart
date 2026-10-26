import 'package:flutter/material.dart';
import '../../constants/fontsize.dart';
import 'package:wikixm/constants/appcolor.dart';

class CommonCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? radius;
  final Color? color;
  final bool? isBorder;

  const CommonCard({super.key, required this.child, this.height, this.padding, this.margin, this.radius, this.color, this.isBorder,this.width});

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.brightnessOf(context) == Brightness.light;
    return Container(
      margin: margin ?? EdgeInsets.zero,
      height: height,
      width: width,
      padding: padding ?? EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_8, Dimensions.w_8, Dimensions.h_8),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        border: isBorder == false ? null : Border.all(color: AppColor.border(context), width: isLight ? 0.4 : 0.4),
        borderRadius: BorderRadius.circular(radius ?? Dimensions.h_10),
      ),
      child: child,
    );
  }
}
