import 'dart:math' as math;
import 'package:flutter/material.dart';

enum WeatherAnimationType {
  sunny,
  clearNight,
  rain,
  snow,
  thunderstorm,
  cloudy,
  partlyCloudy,
  partlyCloudyNight,
  none,
}

WeatherAnimationType getWeatherAnimationType(String? sceneId) {
  switch (sceneId?.toLowerCase().trim()) {
    case 'sunny':
    case 'clear':
    case 'clear-day':
    case 'day-clear':
      return WeatherAnimationType.sunny;

    case 'clear-night':
    case 'night-clear':
    case 'night':
      return WeatherAnimationType.clearNight;

    case 'partly-cloudy':
    case 'partly-cloudy-day':
    case 'day-partly-cloudy':
      return WeatherAnimationType.partlyCloudy;
    case 'night-partly-cloudy':
    case 'partly-cloudy-night':
      return WeatherAnimationType.partlyCloudyNight;
    case 'cloudy':
    case 'overcast':
    case 'mostly-cloudy':
    case 'night-cloudy':
      return WeatherAnimationType.cloudy;
    case 'rain':
    case 'rainy':
    case 'showers':
    case 'drizzle':
    case 'light-rain':
    case 'heavy-rain':
      return WeatherAnimationType.rain;
    case 'snow':
    case 'snowy':
    case 'light-snow':
    case 'heavy-snow':
      return WeatherAnimationType.snow;
    case 'thunderstorm':
    case 'thunderstorms':
    case 'storm':
    case 'lightning':
      return WeatherAnimationType.thunderstorm;

    default:
      return WeatherAnimationType.none;
  }
}

class WeatherAnimationOverlay extends StatefulWidget {
  final WeatherAnimationType type;
  final bool animateClouds;
  final bool animateRain;

  const WeatherAnimationOverlay({
    super.key,
    required this.type,
    this.animateClouds = true,
    this.animateRain = true,
  });

  @override
  State<WeatherAnimationOverlay> createState() =>
      _WeatherAnimationOverlayState();
}

class _WeatherAnimationOverlayState extends State<WeatherAnimationOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController.unbounded(
      vsync: this,
      value: 0.0,
    );

    _animationController.animateWith(
      _ConstantVelocitySimulation(velocity: 1.0),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == WeatherAnimationType.none) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return CustomPaint(
              painter: WeatherOverlayPainter(
                progress: _animationController.value,
                type: widget.type,
                animateClouds: widget.animateClouds,
                animateRain: widget.animateRain,
              ),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

class _ConstantVelocitySimulation extends Simulation {
  final double velocity;

  _ConstantVelocitySimulation({required this.velocity});

  @override
  double x(double time) {
    return velocity * time;
  }

  @override
  double dx(double time) {
    return velocity;
  }

  @override
  bool isDone(double time) {
    return false;
  }
}

class WeatherOverlayPainter extends CustomPainter {
  final double progress;
  final WeatherAnimationType type;
  final bool animateClouds;
  final bool animateRain;

  WeatherOverlayPainter({
    required this.progress,
    required this.type,
    required this.animateClouds,
    required this.animateRain,
  });

  final List<_RainDrop> _rainDrops = const [
    _RainDrop(.02, .58, .060, 1.25),
    _RainDrop(.05, .38, .045, 1.55),
    _RainDrop(.08, .52, .055, 1.38),
    _RainDrop(.11, .32, .040, 1.65),
    _RainDrop(.14, .48, .052, 1.32),
    _RainDrop(.17, .62, .068, 1.22),
    _RainDrop(.20, .36, .043, 1.58),
    _RainDrop(.23, .50, .058, 1.35),
    _RainDrop(.26, .40, .048, 1.48),
    _RainDrop(.29, .64, .072, 1.20),
    _RainDrop(.32, .34, .042, 1.62),
    _RainDrop(.35, .54, .060, 1.30),
    _RainDrop(.38, .42, .050, 1.44),
    _RainDrop(.41, .58, .064, 1.26),
    _RainDrop(.44, .35, .043, 1.58),
    _RainDrop(.47, .50, .058, 1.36),
    _RainDrop(.50, .38, .046, 1.50),
    _RainDrop(.53, .60, .066, 1.24),
    _RainDrop(.56, .34, .042, 1.60),
    _RainDrop(.59, .48, .054, 1.34),
    _RainDrop(.62, .40, .047, 1.46),
    _RainDrop(.65, .56, .062, 1.28),
    _RainDrop(.68, .34, .041, 1.62),
    _RainDrop(.71, .50, .058, 1.36),
    _RainDrop(.74, .42, .049, 1.48),
    _RainDrop(.77, .62, .070, 1.22),
    _RainDrop(.80, .36, .043, 1.58),
    _RainDrop(.83, .54, .060, 1.32),
    _RainDrop(.86, .40, .048, 1.50),
    _RainDrop(.89, .58, .064, 1.28),
    _RainDrop(.92, .34, .042, 1.60),
    _RainDrop(.95, .50, .056, 1.38),
    _RainDrop(.98, .38, .046, 1.50),
  ];

  final List<_SnowFlake> _snowFlakes = const [
    _SnowFlake(.02, .72, .0045, .42, .00),
    _SnowFlake(.07, .85, .0060, .34, .11),
    _SnowFlake(.12, .65, .0040, .48, .22),
    _SnowFlake(.18, .90, .0055, .38, .33),
    _SnowFlake(.24, .70, .0042, .45, .44),
    _SnowFlake(.30, .82, .0062, .32, .55),
    _SnowFlake(.36, .62, .0038, .50, .66),
    _SnowFlake(.42, .88, .0052, .40, .77),
    _SnowFlake(.48, .68, .0040, .36, .88),
    _SnowFlake(.54, .92, .0060, .46, .15),
    _SnowFlake(.60, .70, .0045, .39, .26),
    _SnowFlake(.66, .84, .0055, .33, .37),
    _SnowFlake(.72, .64, .0038, .47, .48),
    _SnowFlake(.78, .90, .0062, .35, .59),
    _SnowFlake(.84, .72, .0042, .43, .70),
    _SnowFlake(.90, .86, .0054, .37, .81),
    _SnowFlake(.96, .68, .0040, .49, .92),
    _SnowFlake(.05, .76, .0035, .52, .17),
    _SnowFlake(.27, .88, .0048, .41, .52),
    _SnowFlake(.57, .74, .0038, .55, .73),
  ];

  final List<_CloudData> _clouds = const [
    _CloudData(
      top: .30,
      scale: 0.90,
      width: .38,
      speed: .008,
      opacity: 1.0,
      delay: .00,
    ),
    _CloudData(
      top: .48,
      scale: .55,
      width: .32,
      speed: .008,
      opacity: 1.0,
      delay: .30,
    ),
    _CloudData(
      top: .62,
      scale: .98,
      width: .27,
      speed: .008,
      opacity: 1.0,
      delay: .60,
    ),
    _CloudData(
      top: .78,
      scale: .62,
      width: .23,
      speed: .008,
      opacity: 1.0,
      delay: .90,
    ),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    if (type == WeatherAnimationType.sunny) {
      _paintSun(canvas, size);
      return;
    }

    if (type == WeatherAnimationType.clearNight) {
      _paintMoon(canvas, size);
      return;
    }

    if (type == WeatherAnimationType.partlyCloudy) {
      _paintSun(canvas, size);
    }

    if (type == WeatherAnimationType.partlyCloudyNight) {
      _paintMoon(canvas, size);
    }

    final bool showRain =
        type == WeatherAnimationType.rain ||
        type == WeatherAnimationType.thunderstorm;

    final bool showSnow = type == WeatherAnimationType.snow;

    final bool showClouds =
        type != WeatherAnimationType.snow &&
            type != WeatherAnimationType.none &&
            type != WeatherAnimationType.partlyCloudy &&
            type != WeatherAnimationType.partlyCloudyNight;

    if (showRain) {
      _paintRainAtmosphere(canvas, size);
    }

    if (type == WeatherAnimationType.snow) {
      _paintSnowAtmosphere(canvas, size);
    }

    if (type == WeatherAnimationType.partlyCloudy) {
      _paintPartlyCloudlyAtmosphere(canvas, size);
    }

    if (type == WeatherAnimationType.thunderstorm) {
      _paintThunderstormAtmosphere(canvas, size);
    }

    if (showClouds) {
      _paintClouds(canvas, size);
    }

    if (showSnow) {
      _paintSnow(canvas, size);
    }

    if (showRain && animateRain) {
      _paintRain(canvas, size);
    }

    if (type == WeatherAnimationType.thunderstorm) {
      _paintLightning(canvas, size);
    }
  }

  void _paintRainAtmosphere(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(.60),
          Colors.white.withOpacity(.35),
          Colors.white.withOpacity(.065),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  void _paintSnowAtmosphere(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(.80),
          Colors.white.withOpacity(.60),
          Colors.white.withOpacity(.055),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  void _paintPartlyCloudlyAtmosphere(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(.50),
          Colors.white.withOpacity(.10),
          Colors.white.withOpacity(.005),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  void _paintThunderstormAtmosphere(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF20232A).withOpacity(.85),
          const Color(0xFF15171D).withOpacity(.60),
          const Color(0xFF20232A).withOpacity(.40),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  void _paintSun(Canvas canvas, Size size) {
    final double radius = size.width * .100;
    final Offset center = Offset(size.width * .78, size.height * .34);

    final double pulse = 1.0 + math.sin(progress * .8) * .025;

    final Paint outerGlow = Paint()
      ..isAntiAlias = true
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFFFFD54F).withOpacity(.40),
              const Color(0xFFFFC107).withOpacity(.30),
              Colors.transparent,
            ],
            stops: const [.0, .45, 1.0],
          ).createShader(
            Rect.fromCircle(center: center, radius: radius * 2.8 * pulse),
          );

    canvas.drawCircle(center, radius * 4.8 * pulse, outerGlow);

    final Paint innerGlow = Paint()
      ..isAntiAlias = true
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFF176).withOpacity(.40),
          const Color(0xFFFFD54F).withOpacity(.18),
          Colors.transparent,
        ],
        stops: const [.0, .55, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 1.65));

    canvas.drawCircle(center, radius * 1.65, innerGlow);

    final Paint sunPaint = Paint()
      ..isAntiAlias = true
      ..shader = RadialGradient(
        center: const Alignment(-.25, -.30),
        radius: 1.0,
        colors: const [Color(0xFFFFF59D), Color(0xFFFFD54F), Color(0xFFFFC107)],
        stops: const [.0, .48, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, sunPaint);

    final Paint highlightPaint = Paint()
      ..isAntiAlias = true
      ..color = Colors.white.withOpacity(.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5);

    canvas.drawCircle(
      Offset(center.dx - radius * .28, center.dy - radius * .30),
      radius * .22,
      highlightPaint,
    );
  }

  void _paintMoon(Canvas canvas, Size size) {
    final double radius = size.width * .085;
    final Offset center = Offset(size.width * .78, size.height * .34);
    final double pulse = 1.0 + math.sin(progress * .8) * .02;

    final Paint glowPaint = Paint()
      ..isAntiAlias = true
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFFF5F3CE).withOpacity(.32),
              const Color(0xFFDDE7F0).withOpacity(.15),
              Colors.transparent,
            ],
            stops: const [0.0, .45, 1.0],
          ).createShader(
            Rect.fromCircle(center: center, radius: radius * 3.5 * pulse),
          );

    canvas.drawCircle(center, radius * 3.5 * pulse, glowPaint);

    final Paint moonPaint = Paint()
      ..isAntiAlias = true
      ..shader = RadialGradient(
        center: const Alignment(-.35, -.35),
        colors: const [Color(0xFFFFFFFF), Color(0xFFF1F0D8), Color(0xFFD8D7C2)],
        stops: [0.0, .55, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, moonPaint);

    final Paint craterPaint = Paint()
      ..isAntiAlias = true
      ..color = const Color(0xFFBFC0B2).withOpacity(.25);

    canvas.drawCircle(
      Offset(center.dx + radius * .28, center.dy + radius * .15),
      radius * .18,
      craterPaint,
    );

    canvas.drawCircle(
      Offset(center.dx - radius * .22, center.dy + radius * .30),
      radius * .11,
      craterPaint,
    );

    final Paint highlightPaint = Paint()
      ..isAntiAlias = true
      ..color = Colors.white.withOpacity(.28)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5);

    canvas.drawCircle(
      Offset(center.dx - radius * .28, center.dy - radius * .30),
      radius * .20,
      highlightPaint,
    );
  }

  void _paintClouds(Canvas canvas, Size size) {
    double cloudOpacity = 1;

    switch (type) {
      case WeatherAnimationType.rain:
        cloudOpacity = .90;
        break;

      case WeatherAnimationType.snow:
        cloudOpacity = 0;
        break;

      case WeatherAnimationType.thunderstorm:
        cloudOpacity = .92;
        break;

      case WeatherAnimationType.cloudy:
        cloudOpacity = 1;
        break;

      case WeatherAnimationType.partlyCloudy:
      case WeatherAnimationType.partlyCloudyNight:
        cloudOpacity = 1;
        break;

      case WeatherAnimationType.none:
      case WeatherAnimationType.sunny:
      case WeatherAnimationType.clearNight:
        return;
    }

    for (final cloud in _clouds) {
      final double cloudProgress = animateClouds
          ? ((progress * cloud.speed * 3.5) + cloud.delay) % 1.0
          : cloud.delay;

      final double cloudWidth = size.width * cloud.width * cloud.scale;

      final double cloudHeight = cloudWidth * .30;

      final double x =
          -cloudWidth * 1.3 + cloudProgress * (size.width + cloudWidth * 2.6);

      final double y = size.height * cloud.top;

      _drawCloud(
        canvas,
        Offset(x, y),
        Size(cloudWidth, cloudHeight),
        cloud.opacity * cloudOpacity,
      );
    }
  }

  void _drawCloud(Canvas canvas, Offset position, Size size, double opacity) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0);

    final bool isThunderstorm = type == WeatherAnimationType.thunderstorm;

    final Color cloudLow = isThunderstorm
        ? Color.fromRGBO(30, 31, 36, opacity)
        : Color.fromRGBO(52, 52, 55, opacity);

    final Color cloudMid = isThunderstorm
        ? Color.fromRGBO(62, 63, 70, opacity)
        : Color.fromRGBO(98, 98, 102, opacity);

    final Color cloudHigh = isThunderstorm
        ? Color.fromRGBO(115, 116, 124, opacity * .8)
        : Color.fromRGBO(165, 165, 168, opacity * .8);

    final double w = size.width;
    final double h = size.height;

    final double cloudW = w * .78;
    final double cloudH = h * 1.45;

    final double left = position.dx + (w - cloudW) / 2;

    final double top = position.dy - h * .18;

    final Path cloudPath = Path();

    final Rect baseRect = Rect.fromLTWH(
      left,
      top + cloudH * .48,
      cloudW,
      cloudH * .34,
    );

    cloudPath.addRRect(
      RRect.fromRectAndRadius(baseRect, Radius.circular(cloudH * .17)),
    );

    cloudPath.addOval(
      Rect.fromCircle(
        center: Offset(left + cloudW * .16, top + cloudH * .53),
        radius: cloudH * .22,
      ),
    );

    cloudPath.addOval(
      Rect.fromCircle(
        center: Offset(left + cloudW * .32, top + cloudH * .36),
        radius: cloudH * .30,
      ),
    );

    cloudPath.addOval(
      Rect.fromCircle(
        center: Offset(left + cloudW * .50, top + cloudH * .28),
        radius: cloudH * .37,
      ),
    );

    cloudPath.addOval(
      Rect.fromCircle(
        center: Offset(left + cloudW * .68, top + cloudH * .38),
        radius: cloudH * .29,
      ),
    );

    cloudPath.addOval(
      Rect.fromCircle(
        center: Offset(left + cloudW * .84, top + cloudH * .53),
        radius: cloudH * .21,
      ),
    );

    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [cloudHigh, cloudMid, cloudLow],
      stops: const [0.0, 0.48, 1.0],
    ).createShader(Rect.fromLTWH(left, top, cloudW, cloudH));

    canvas.drawPath(cloudPath, paint);

    paint.shader =
        RadialGradient(
          center: Alignment.topCenter,
          radius: .80,
          colors: [
            Color.fromRGBO(205, 205, 208, opacity * .32),
            Color.fromRGBO(175, 175, 178, opacity * .10),
            Colors.transparent,
          ],
          stops: const [0.0, 0.45, 1.0],
        ).createShader(
          Rect.fromLTWH(left + cloudW * .12, top, cloudW * .76, cloudH * .65),
        );

    canvas.drawOval(
      Rect.fromLTWH(
        left + cloudW * .18,
        top + cloudH * .10,
        cloudW * .64,
        cloudH * .42,
      ),
      paint,
    );

    paint.shader =
        LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Color.fromRGBO(20, 20, 23, opacity * .16),
          ],
        ).createShader(
          Rect.fromLTWH(left, top + cloudH * .42, cloudW, cloudH * .40),
        );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          left + cloudW * .04,
          top + cloudH * .48,
          cloudW * .92,
          cloudH * .30,
        ),
        Radius.circular(cloudH * .15),
      ),
      paint,
    );
  }

  void _paintSnow(Canvas canvas, Size size) {
    for (final snow in _snowFlakes) {
      final double phase = ((progress * snow.speed) + snow.delay) % 1.0;

      final double y = -size.height * .08 + phase * size.height * 1.16;

      final double wave =
          math.sin(progress * 1.4 + snow.delay * math.pi * 2) *
          size.width *
          .018;

      final double x = size.width * snow.x + wave;

      final double radius = size.width * snow.size;

      final Paint paint = Paint()
        ..isAntiAlias = true
        ..color = Colors.white.withOpacity(snow.opacity);

      canvas.drawCircle(Offset(x, y), radius, paint);

      if (snow.size >= .005) {
        final Paint glowPaint = Paint()
          ..isAntiAlias = true
          ..color = Colors.white.withOpacity(snow.opacity * .12)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

        canvas.drawCircle(Offset(x, y), radius * 2.2, glowPaint);
      }
    }
  }

  static const double _slantFactor = .16;

  void _paintRain(Canvas canvas, Size size) {
    for (int i = 0; i < _rainDrops.length; i++) {
      final _RainDrop drop = _rainDrops[i];

      final double phase = ((progress * drop.speed * .90) + i * .071) % 1.0;

      final double xBase = size.width * drop.x;

      final double y = -size.height * .10 + phase * size.height * 1.20;

      final double length = size.height * drop.lengthFactor * 1.7;

      final double slant = size.width * _slantFactor * drop.lengthFactor * 4;

      final double x = xBase + phase * slant;

      final double xEnd = x + (length / size.height) * slant;

      final double opacity = drop.alpha;

      final Paint paint = Paint()
        ..isAntiAlias = true
        ..strokeWidth = opacity > .5 ? 1.7 : 1.15
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.white.withOpacity(opacity * .30),
            const Color(0xFFE0F2FF).withOpacity(opacity),
          ],
        ).createShader(Rect.fromLTWH(x, y, 2, length));

      canvas.drawLine(Offset(x, y), Offset(xEnd, y + length), paint);
    }
  }

  void _paintLightning(Canvas canvas, Size size) {
    final double cycle = progress % 10.0;

    double flashOpacity = 0.0;

    if (cycle >= 2.10 && cycle < 2.16) {
      flashOpacity = .95;
    } else if (cycle >= 2.16 && cycle < 2.21) {
      flashOpacity = .32;
    } else if (cycle >= 2.21 && cycle < 2.27) {
      flashOpacity = .68;
    } else if (cycle >= 6.30 && cycle < 6.37) {
      flashOpacity = .85;
    } else if (cycle >= 6.37 && cycle < 6.42) {
      flashOpacity = .22;
    }

    if (flashOpacity <= 0) return;

    final Paint flashPaint = Paint()
      ..color = Colors.white.withOpacity(flashOpacity * .25);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), flashPaint);

    final double boltX = size.width * (cycle < 5.0 ? .58 : .35);

    final Path lightning = Path();

    lightning.moveTo(boltX, -size.height * .02);

    lightning.lineTo(boltX - size.width * .035, size.height * .16);

    lightning.lineTo(boltX + size.width * .025, size.height * .15);

    lightning.lineTo(boltX - size.width * .055, size.height * .37);

    lightning.lineTo(boltX - size.width * .005, size.height * .33);

    lightning.lineTo(boltX - size.width * .075, size.height * .62);

    final Paint glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.white.withOpacity(flashOpacity * .28)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawPath(lightning, glowPaint);

    final Paint boltPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.white.withOpacity(flashOpacity);

    canvas.drawPath(lightning, boltPaint);
  }

  @override
  bool shouldRepaint(covariant WeatherOverlayPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.type != type ||
        oldDelegate.animateClouds != animateClouds ||
        oldDelegate.animateRain != animateRain;
  }
}

class _RainDrop {
  final double x;
  final double alpha;
  final double lengthFactor;
  final double speed;

  const _RainDrop(this.x, this.alpha, this.lengthFactor, this.speed);
}

class _SnowFlake {
  final double x;
  final double opacity;
  final double size;
  final double speed;
  final double delay;

  const _SnowFlake(this.x, this.opacity, this.size, this.speed, this.delay);
}

class _CloudData {
  final double top;
  final double scale;
  final double width;
  final double speed;
  final double opacity;
  final double delay;

  const _CloudData({
    required this.top,
    required this.scale,
    required this.width,
    required this.speed,
    required this.opacity,
    required this.delay,
  });
}
