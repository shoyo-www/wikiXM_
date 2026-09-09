import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/constants/fontsize.dart';

class AdsWidget extends StatefulWidget {
  final double topPadding;
  final double bottomPadding;

  const AdsWidget({
    super.key,
    this.topPadding = 5,
    this.bottomPadding = 0,
  });

  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  int currentIndex = 0;

  final CarouselSliderController carouselController = CarouselSliderController();

  final List<String> adsList = [
    'https://imgs.search.brave.com/OZptIDw6mcHEtpYaOitTLZtEmWvCG6FaiUhlRmqXnfE/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cG9zdGNhcmRtYW5p/YS5jb20vd3AtY29u/dGVudC91cGxvYWRz/L2Rlc2lnbnMvaW1n/L0xhbmRzY2FwZXIt/TWFya2V0aW5nLVNw/cmluZy1MTkQtMTAy/MC5qcGc',
    'https://imgs.search.brave.com/9_hgpaQx0l2lsM9EfJSvK-4DTQILIDoBePQ9wFTVfVc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pZGVh/bC10dXJmLmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyMC8x/Mi9Eb2ctRnJpZW5k/bHktQmFja3lhcmQt/MTAzMHg2ODcuanBn',
    'https://imgs.search.brave.com/oxh4_hX-ErT5nZ4V6lum3oYfy6VIgBg2dHeg4Ng_MKY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE2/Mzc2NjY0NjUwNDct/ODM5OGU3ZDgwMzhl/P2ZtPWpwZyZxPTYw/Jnc9MzAwMCZhdXRv/PWZvcm1hdCZmaXQ9/Y3JvcCZpeGxpYj1y/Yi00LjEuMCZpeGlk/PU0zd3hNakEzZkRC/OE1IeHpaV0Z5WTJo/OE1USjhmRzVwYTJV/bE1qQmhaSHhsYm53/d2ZId3dmSHg4TUE9/PQ',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.topPadding,
        bottom: widget.bottomPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
            controller: carouselController,
            itemCount: adsList.length,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () {
                  debugPrint('Ad ${index + 1} clicked');
                },
                child: AppCacheImage(
                  imageUrl: adsList[index],
                  widthSize: Get.width,
                  size: Dimensions.h_120,
                  fit: BoxFit.fill,
                  borderColor: Colors.grey.shade400,
                  radius: Dimensions.h_4,
                  isShadow: false,
                ),
              );
            },
            options: CarouselOptions(
              height: Dimensions.h_120,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.15,
              viewportFraction: 0.85,
              enableInfiniteScroll: true,
              padEnds: true,
              onPageChanged: (index, reason) {
                if (!mounted) return;
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          SizedBox(height: Dimensions.h_6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              adsList.length,
                  (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: currentIndex == index ? Dimensions.h_8 : Dimensions.h_4,
                height: Dimensions.h_4,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Theme.of(context).highlightColor
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}