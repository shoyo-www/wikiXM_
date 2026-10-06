import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:wikixm/Presentation/dashboard/controller.dart';
import '../../constants/appcolor.dart';
import '../../constants/fontsize.dart';

class CommunityIntelligenceCard extends StatelessWidget {
  final DashboardController controller;

  const CommunityIntelligenceCard({super.key, required this.controller});

  Map<String, dynamic> _getScoreData(double score) {
    if (score < 20) {
      return {'label': 'Low', 'color': const Color(0xFFF30E12), 'icon': Icons.arrow_downward};
    } else if (score < 40) {
      return {'label': 'Weak', 'color': const Color(0xFFFF6B35), 'icon': Icons.arrow_downward};
    } else if (score < 60) {
      return {'label': 'Moderate', 'color': const Color(0xFFFFB020), 'icon': Icons.remove};
    } else if (score < 80) {
      return {'label': 'Strong', 'color': const Color(0xFF63C04E), 'icon': Icons.arrow_upward};
    } else {
      return {'label': 'Very Strong', 'color': const Color(0xFF3DDC55), 'icon': Icons.arrow_upward};
    }
  }

  @override
  Widget build(BuildContext context) {
    final score = (controller.communityOverview?.pulse?.score ?? 0).toDouble();
    final scoreData = _getScoreData(score);
    final Color scoreColor = scoreData['color'] as Color;
    final String scoreLabel = scoreData['label'] as String;
    final IconData scoreIcon = scoreData['icon'] as IconData;
    final double percent = (score / 100).clamp(0.0, 1.0).toDouble();
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.w_8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "COMMUNITY\nINTELLIGENCE INDEX",
                style: TextStyle(
                  color: const Color(0xFF3DDC55),
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: score.toStringAsFixed(0),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_50,
                            fontWeight: FontWeight.bold,
                            height: 1,
                            shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                          ),
                        ),
                        TextSpan(
                          text: "/100",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_16,
                            fontWeight: FontWeight.w600,
                            shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_5),
              Row(
                children: [
                  Icon(scoreIcon, color: scoreColor, size: Dimensions.h_15),
                  SizedBox(width: Dimensions.w_1),
                  Text(
                    scoreLabel,
                    style: TextStyle(
                      color: scoreColor,
                      fontWeight: FontWeight.w900,
                      fontSize: FontSize.sp_13,
                      shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: Dimensions.h_10,
            left: Dimensions.w_45,
            child: ArcGaugeIndicator(radius: Dimensions.h_48, lineWidth: 10, percent: percent, progressColor: scoreColor, backgroundColor: Colors.white, sweepAngle: 120, startAngle: 295),
          ),
        ],
      ),
    );
  }
}

class ArcGaugeIndicator extends StatefulWidget {
  final double radius;
  final double lineWidth;
  final double percent;
  final Color progressColor;
  final Color backgroundColor;
  final double sweepAngle;
  final double startAngle;

  const ArcGaugeIndicator({super.key, required this.radius, required this.lineWidth, required this.percent, required this.progressColor, this.backgroundColor = Colors.white, this.sweepAngle = 270, this.startAngle = 135});

  @override
  State<ArcGaugeIndicator> createState() => _ArcGaugeIndicatorState();
}

class _ArcGaugeIndicatorState extends State<ArcGaugeIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _animation = Tween<double>(begin: 0, end: widget.percent).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return CustomPaint(
            painter: _ArcGaugePainter(percent: _animation.value, lineWidth: widget.lineWidth, progressColor: widget.progressColor, backgroundColor: widget.backgroundColor, sweepAngle: widget.sweepAngle, startAngle: widget.startAngle),
          );
        },
      ),
    );
  }
}

class _ArcGaugePainter extends CustomPainter {
  final double percent;
  final double lineWidth;
  final Color progressColor;
  final Color backgroundColor;
  final double sweepAngle;
  final double startAngle;

  _ArcGaugePainter({required this.percent, required this.lineWidth, required this.progressColor, required this.backgroundColor, required this.sweepAngle, required this.startAngle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - lineWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final startRad = startAngle * math.pi / 180;
    final sweepRad = sweepAngle * math.pi / 180;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startRad, sweepRad, false, bgPaint);
    canvas.drawArc(rect, startRad, sweepRad * percent, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _ArcGaugePainter oldDelegate) {
    return oldDelegate.percent != percent || oldDelegate.progressColor != progressColor || oldDelegate.backgroundColor != backgroundColor;
  }
}

class MiniIndexGauge extends StatelessWidget {
  final int value;

  const MiniIndexGauge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.h_38,
      height: Dimensions.h_38,
      child: CustomPaint(
        painter: _GaugePainter(progress: value / 100),
        child: Center(
          child: Text(
            '$value',
            style: TextStyle(fontSize: FontSize.sp_15, fontWeight: FontWeight.w700, color: AppColor.darkGreenSportsSecondaryText),
          ),
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;

  _GaugePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    final background = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final foreground = Paint()
      ..color = AppColor.darkGreenSportsSecondaryText
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const startAngle = math.pi * 0.75;
    const sweepAngle = math.pi * 1.5;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, background);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle * progress, false, foreground);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
