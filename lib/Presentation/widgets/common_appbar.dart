import 'dart:io';
import 'dart:ui';
import 'package:cupertino_native/components/button.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/town_selection.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/fontsize.dart';

import '../../constants/constants.dart';
import '../../data/datasource/local/local_storage.dart';

class CommonBlurAppBar extends StatelessWidget {
  const CommonBlurAppBar({super.key, required this.foregroundColor, required this.blurOpacity, this.showBackButton = false, this.isDrawer = false, this.onTap, this.child});

  final Color foregroundColor;
  final double blurOpacity;
  final bool showBackButton;
  final bool isDrawer;
  final void Function()? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    return SizedBox(
      height: topPadding + Dimensions.h_50,
      // one shared backdrop read for all bands instead of one screen copy per band
      child: BackdropGroup(
        child: Stack(
        children: [
          // was two stacked bands (sigma 2.8 then 2.2); one pass at their combined sigma looks the same at half the cost
          _BlurBand(
            top: 0,
            height: topPadding + Dimensions.h_16 + Dimensions.h_1,
            sigma: 3.56 * blurOpacity,
            color: Colors.white.withValues(alpha: 0.01 * blurOpacity),
          ),
          _BlurBand(
            top: topPadding + Dimensions.h_16,
            height: Dimensions.h_8,
            sigma: 1.5 * blurOpacity,
            color: Colors.white.withValues(alpha: 0.01 * blurOpacity),
          ),
          Padding(padding: EdgeInsets.fromLTRB(Dimensions.w_10, topPadding + Dimensions.h_10, Dimensions.w_10, Dimensions.h_1), child: child ?? (showBackButton ? _buildBackHeader() : _buildFullHeader())),
        ],
        ),
      ),
    );
  }

  Widget _buildFullHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              if (isDrawer)
                GestureDetector(
                  onTap: onTap,
                  child: Icon(CupertinoIcons.line_horizontal_3, color: foregroundColor, size: Dimensions.h_20),
                ),
              if (isDrawer) SizedBox(width: Dimensions.w_20),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showModalBottomSheet(
                      context: Get.context!,
                      isScrollControlled: true,
                      scrollControlDisabledMaxHeightRatio : 0.85,
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.85,
                            child: const TownSelection());
                      },
                    );
                  },
                  child: Row(children: [
                    Icon(CupertinoIcons.location_solid, color: foregroundColor, size: Dimensions.h_12),
                    SizedBox(width: Dimensions.w_2),
                    Flexible(
                      child: Text(
                        LocalStorage.getString(GetXStorageConstants.townName),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: foregroundColor, fontSize: FontSize.sp_13, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_3),
                    Icon(CupertinoIcons.chevron_down, color: foregroundColor, size: Dimensions.h_12),
                  ],),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Get.toNamed(AppRoutes.notifications);
          },
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: Dimensions.h_28,
                    height: Dimensions.h_28,
                    child: Icon(CupertinoIcons.bell, color: foregroundColor, size: Dimensions.h_18),
                  ),
                  Positioned(
                    right: 2,
                    top: 5,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_1),
                      decoration: const BoxDecoration(color: Color(0xFFFF3B30), shape: BoxShape.circle),
                      child: Text(
                        '3',
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_8, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: Dimensions.w_8),
              AppCacheImage(imageUrl: 'https://wikixm-staging.s3.us-west-2.amazonaws.com/profile/2026/01/6970dd6c24dee7.50803251.png', size: Dimensions.h_22, widthSize: Dimensions.h_22, borderColor: Colors.white, radius: Dimensions.h_50, isCircle: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackHeader() {
    return Row(
      children: [
        _circleButton(symbol: 'chevron.left', icon: Icons.arrow_back_ios_new, onTap: () => Get.back()),
        if (isDrawer) ...[
          const Spacer(),
          _circleButton(symbol: 'line.3.horizontal', icon: CupertinoIcons.line_horizontal_3, onTap: onTap ?? () {}),
        ],
      ],
    );
  }

  Widget _circleButton({required String symbol, required IconData icon, required VoidCallback onTap}) {
    return Platform.isIOS
        ? CNButton.icon(
            icon: CNSymbol(symbol, size: Dimensions.h_10),
            size: Dimensions.h_25,
            onPressed: onTap,
          )
        : GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration:  BoxDecoration(shape: BoxShape.circle, color: Theme.of(Get.context!).cardColor),
              child: Icon(icon, color: Theme.of(Get.context!).primaryColorDark, size: Dimensions.h_11),
            ),
          );
  }
}

class _BlurBand extends StatelessWidget {
  const _BlurBand({required this.top, required this.height, required this.sigma, required this.color});

  final double top;
  final double height;
  final double sigma;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (sigma <= 0) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: top,
      left: 0,
      right: 0,
      height: height,
      child: IgnorePointer(
        child: ClipRect(
          child: BackdropFilter.grouped(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: Container(color: color),
          ),
        ),
      ),
    );
  }
}
