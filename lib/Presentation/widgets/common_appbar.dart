import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wikixm/constants/fontsize.dart';

class CommonBlurAppBar extends StatelessWidget {
  const CommonBlurAppBar({
    super.key,
    required this.topPadding,
    required this.blurOpacity,
    required this.child,
    this.foregroundColor,
  });

  final double topPadding;
  final double blurOpacity;
  final Widget child;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final opacity = blurOpacity.clamp(0.0, 1.0);
    return SizedBox(
      height: topPadding + Dimensions.h_50,
      child: Stack(
        children: [
          _BlurBand(
            top: 0,
            height: topPadding + Dimensions.h_16,
            sigma: 2.8 * opacity,
            opacity: opacity,
            color: Colors.black87.withValues(alpha: 0.01 * opacity),
          ),
          _BlurBand(
            top: 0,
            height: topPadding + Dimensions.h_16 + Dimensions.h_1,
            sigma: 2.8 * opacity,
            opacity: opacity,
            color: Colors.white.withValues(alpha: 0.01 * opacity),
          ),
          _BlurBand(
            top: topPadding + Dimensions.h_16,
            height: Dimensions.h_8,
            sigma: 1.8 * opacity,
            opacity: opacity,
            color:   Colors.white.withValues(alpha: 0.03 * opacity)
          ),
          _BlurBand(
            top: topPadding + Dimensions.h_16 + Dimensions.h_8,
            height: Dimensions.h_8,
            sigma: 0.2 * opacity,
            opacity: opacity,
              color:  Colors.white12.withValues(alpha: 0.01 * opacity)
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w_10,
              topPadding + Dimensions.h_1,
              Dimensions.w_10,
              Dimensions.h_1,
            ),
            child: IconTheme(
              data: IconThemeData(
                color: foregroundColor ?? IconTheme.of(context).color,
              ),
              child: DefaultTextStyle.merge(
                style: TextStyle(color: foregroundColor),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurBand extends StatelessWidget {
  const _BlurBand({
    required this.top,
    required this.height,
    required this.sigma,
    required this.opacity,
    required this.color,
  });

  final double top;
  final double height;
  final double sigma;
  final double opacity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (sigma <= 0) return const SizedBox.shrink();
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      height: height,
      child: IgnorePointer(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: Container(
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
