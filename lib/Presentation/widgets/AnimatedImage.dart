import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/fontsize.dart';
import 'cache_image.dart';

class AnimatedWeatherImage extends StatefulWidget {
  final double? height;
  final String? image;
  const AnimatedWeatherImage({super.key,this.height,this.image});

  @override
  State<AnimatedWeatherImage> createState() => _AnimatedWeatherImageState();
}

class _AnimatedWeatherImageState extends State<AnimatedWeatherImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: widget.height ?? Dimensions.h_310,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = Curves.easeInOut.transform(_controller.value);
            return Transform.scale(
              scale: 1.0 + (t * 0.08),
              child: AppCacheImage(
                imageUrl:
                widget.image ?? 'https://imgs.search.brave.com/r8PVTNv7PB0EznHHk6beAqe-ssIaz9WIcbI_i_Sfatc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMwMS5ueXQuY29t/L2F0aGxldGljL3Vw/bG9hZHMvd3AvMjAy/Ni8wNy8wNjE0NTc0/Ni9HZXR0eUltYWdl/cy0yMjU1MTAxMTM2/LmpwZz93aWR0aD0x/OTIwJnF1YWxpdHk9/NzAmYXV0bz13ZWJw',
                widthSize: Get.width,
                size: Dimensions.h_310,
                radius: 0,
              ),
            );
          },
        ),
      ),
    );
  }
}