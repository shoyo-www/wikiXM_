import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/common_blur_scaffold.dart';
import 'package:wikixm/constants/fontsize.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBlurScaffold(
      showBack: true,
      child: Column(
        children: [
          SizedBox(height: Dimensions.h_100),
          Text('Image Banner',style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: FontSize.sp_14
          ),),
          AppCacheImage(fit: BoxFit.contain, imageUrl: 'https://preetis-html.vercel.app/assets/images/ads/explore-pine-valley.webp', size: Dimensions.h_110, widthSize: Get.width, isShadow: false),
          SizedBox(height: Dimensions.h_10),
          Text('Image + text banner',style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: FontSize.sp_14
          ),),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
          //   height: Dimensions.h_105,
          //   decoration: BoxDecoration(
          //     color: const Color(0xFF111A2D),
          //     borderRadius: BorderRadius.circular(Dimensions.h_8),
          //     border: isLight ? null : Border.all(color: AppColor.white, width: 0.3),
          //   ),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(Dimensions.h_8),
          //     child: Stack(
          //       fit: StackFit.expand,
          //       children: [
          //         Align(
          //           alignment: Alignment.centerRight,
          //           child: FractionallySizedBox(
          //             widthFactor: 0.65,
          //             heightFactor: 1,
          //             child: AppCacheImage(imageUrl: imageUrl, fit: BoxFit.cover),
          //           ),
          //         ),
          //         IgnorePointer(
          //           child: DecoratedBox(
          //             decoration: BoxDecoration(
          //               gradient: LinearGradient(
          //                 begin: Alignment.centerLeft,
          //                 end: Alignment.centerRight,
          //                 colors: [
          //                   // Solid dark behind text
          //                   const Color(0xFF111A2D),
          //
          //                   const Color(0xFF111A2D),
          //
          //                   // Start revealing image
          //                   const Color(0xFF111A2D).withValues(alpha: 0.92),
          //
          //                   const Color(0xFF111A2D).withValues(alpha: 0.20),
          //
          //                   const Color(0xFF111A2D).withValues(alpha: 0.02),
          //
          //                   const Color(0xFF111A2D).withValues(alpha: 0.01),
          //
          //                   // Full image
          //                   Colors.transparent,
          //                 ],
          //                 stops: const [0.00, 0.20, 0.35, 0.50, 0.65, 0.80, 1.00],
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_10, Dimensions.w_8, Dimensions.h_10),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 businessName.toUpperCase(),
          //                 maxLines: 2,
          //                 overflow: TextOverflow.ellipsis,
          //                 style: TextStyle(color: Colors.white, fontSize: FontSize.sp_15, fontWeight: FontWeight.w900, height: 1.12),
          //               ),
          //
          //               SizedBox(height: Dimensions.h_10),
          //               SizedBox(
          //                 width: Get.width * 0.48,
          //                 child: Text(
          //                   formatTitle(tagline),
          //                   maxLines: 2,
          //                   overflow: TextOverflow.ellipsis,
          //                   style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.12),
          //                 ),
          //               ),
          //               const Spacer(),
          //               Container(
          //                 padding: EdgeInsets.symmetric(vertical: Dimensions.h_7, horizontal: Dimensions.w_10),
          //                 decoration: BoxDecoration(color: const Color(0xFF1A623E), borderRadius: BorderRadius.circular(Dimensions.h_8)),
          //                 child: Row(
          //                   mainAxisSize: MainAxisSize.min,
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Text(
          //                       'Visit Business',
          //                       style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800),
          //                     ),
          //                     SizedBox(width: Dimensions.w_15),
          //                     Icon(Icons.arrow_forward, size: Dimensions.h_12, color: Colors.white),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
