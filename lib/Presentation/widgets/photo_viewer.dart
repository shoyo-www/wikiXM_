import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/fontsize.dart';

/// Full-screen, swipeable and pinch-to-zoom photo viewer. Open it with [PhotoViewer.open].
class PhotoViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  const PhotoViewer({super.key, required this.images, this.initialIndex = 0});

  static void open(List<String> images, {int index = 0}) => Get.to(() => PhotoViewer(images: images, initialIndex: index), fullscreenDialog: true, transition: Transition.fadeIn);

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

// the page index is pure view state, so it lives here instead of in a controller
class _PhotoViewerState extends State<PhotoViewer> {
  late final PageController pager = PageController(initialPage: widget.initialIndex);
  late int index = widget.initialIndex;

  @override
  void dispose() {
    pager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: pager,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => index = i),
            itemBuilder: (context, i) => InteractiveViewer(
              maxScale: 4,
              child: Center(
                child: AppCacheImage(imageUrl: widget.images[i], widthSize: Get.width, size: Get.height, fit: BoxFit.contain, isShadow: false, radius: 0),
              ),
            ),
          ),
          Positioned(
            top: padding.top + Dimensions.h_10,
            left: Dimensions.w_10,
            right: Dimensions.w_10,
            child: Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: Get.back,
                  child: Container(
                    width: Dimensions.h_30,
                    height: Dimensions.h_30,
                    decoration: BoxDecoration(color: AppColor.white.withValues(alpha: 0.15), shape: BoxShape.circle),
                    child: Icon(CupertinoIcons.xmark, color: AppColor.white, size: Dimensions.h_15),
                  ),
                ),
                const Spacer(),
                if (widget.images.length > 1)
                  Text(
                    '${index + 1} / ${widget.images.length}',
                    style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
