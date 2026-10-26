import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/fontsize.dart';


class CommonShimmer extends StatelessWidget {
  final double heroHeight;
  final List<Widget> hero;
  final List<Widget> body;

  const CommonShimmer({super.key, required this.heroHeight, required this.hero, required this.body});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: heroHeight,
            width: Get.width,
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_40, Dimensions.w_8, Dimensions.h_10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: hero),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: body),
          ),
        ],
      ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double? radius;
  final bool isCircle;

  const ShimmerBox(this.width, this.height, {super.key, this.radius, this.isCircle = false});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Shimmer.fromColors(
      baseColor: isLight ? Colors.grey.shade300 : Colors.grey.shade800,
      highlightColor: isLight ? Colors.grey.shade100 : Colors.grey.shade700,
      period: const Duration(milliseconds: 950),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: Colors.white, borderRadius: isCircle ? null : BorderRadius.circular(radius ?? Dimensions.h_6), shape: isCircle ? BoxShape.circle : BoxShape.rectangle),
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const ShimmerCard(this.child, {super.key, this.width, this.height, this.padding, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? EdgeInsets.all(Dimensions.h_10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.h_10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: child,
    );
  }
}

class ShimmerIconLine extends StatelessWidget {
  final double width;

  const ShimmerIconLine(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.h_6),
      child: Row(
        children: [
          ShimmerBox(Dimensions.h_11, Dimensions.h_11, isCircle: true),
          SizedBox(width: Dimensions.w_6),
          ShimmerBox(width, Dimensions.h_8),
        ],
      ),
    );
  }
}
