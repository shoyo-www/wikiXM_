import 'package:flutter/material.dart';
import 'package:wikixm/constants/fontsize.dart';

class BriefSpeakingOverlay extends StatefulWidget {
  const BriefSpeakingOverlay({
    super.key,
    required this.progress,
    required this.onStop,
  });

  final double progress;
  final VoidCallback onStop;

  @override
  State<BriefSpeakingOverlay> createState() => _BriefSpeakingOverlayState();
}

class _BriefSpeakingOverlayState extends State<BriefSpeakingOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_30),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w_3,
          vertical: Dimensions.h_3,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(Dimensions.h_30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Container(
          height: Dimensions.h_35,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.h_30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: Dimensions.w_8),
                  SizedBox(
                    width: Dimensions.w_25,
                    height: Dimensions.h_25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(4, (index) {
                        final wave =
                            ((_controller.value * 3 + index * 0.2) % 1 - 0.5)
                                .abs();
                        final height = Dimensions.h_10 + Dimensions.h_15 * wave;
                        return Container(
                          width: Dimensions.w_4,
                          height: height,
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_1,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4519E6),
                            borderRadius: BorderRadius.circular(Dimensions.h_8),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_10),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.h_10),
                      child: LinearProgressIndicator(
                        value: widget.progress.clamp(0.0, 1.0),
                        minHeight: Dimensions.h_5,
                        backgroundColor: const Color(0xFFE8E6FF),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF4519E6),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_10),
                  GestureDetector(
                    onTap: widget.onStop,
                    child: Container(
                      width: Dimensions.h_30,
                      height: Dimensions.h_30,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4519E6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.stop_rounded,
                        color: Colors.white,
                        size: Dimensions.h_18,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
