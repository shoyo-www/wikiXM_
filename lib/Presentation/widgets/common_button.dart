import 'package:flutter/material.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/fontsize.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final IconData? icon;
  final double? width;
  final double? height;
  final double? radius;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  const CommonButton({super.key, this.height,required this.title, required this.onTap, this.color, this.textColor, this.borderColor, this.icon, this.width, this.radius, this.fontSize, this.padding});

  @override
  Widget build(BuildContext context) {
    final foreground = textColor ?? AppColor.white;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding ?? EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
        decoration: BoxDecoration(
          color: color ?? AppColor.blue(context),
          borderRadius: BorderRadius.circular(radius ?? Dimensions.h_15),
          border: borderColor == null ? null : Border.all(color: borderColor!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon, color: foreground, size: Dimensions.h_15), SizedBox(width: Dimensions.w_8)],
            Text(
              title,
              style: TextStyle(color: foreground, fontSize: fontSize ?? FontSize.sp_13, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
