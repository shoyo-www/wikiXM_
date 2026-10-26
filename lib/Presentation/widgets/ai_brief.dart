import 'package:flutter/material.dart';
import '../../constants/fontsize.dart';
import 'package:wikixm/constants/appcolor.dart';

class CommonAiBrief extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const CommonAiBrief({super.key, required this.child, this.margin,this.padding});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_8, Dimensions.w_8, Dimensions.h_8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.aiBriefBlueTranslucent(context), width: 0.6),
        borderRadius: BorderRadius.circular(Dimensions.h_8),
        gradient: isLight ? const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFAE5F2FD), Color(0xF5A9CFF0)]) : const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF09224E), Color(0xFF031636)]),
        boxShadow: [BoxShadow(color: AppColor.aiBriefBlueDeepTranslucent(context), blurRadius: 14, offset: const Offset(0, 5))],
      ),
      child: child,
    );
  }
}
