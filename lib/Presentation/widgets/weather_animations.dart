import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// What a weather scene contains. Pick one with the factories; [WeatherController.weatherScene] maps the API's scene_id to them.
class WeatherScene {
  const WeatherScene({
    required this.id,
    required this.tint,
    this.clouds = 0,
    this.cloudColor = _dayCloud,
    this.rain = 0,
    this.snow = 0,
    this.fog = 0,
    this.lightning = false,
    this.sun = false,
    this.moon = false,
    this.stars = false,
    this.glow,
  });

  /// Also the crossfade key: a new id fades the old scene out.
  final String id;

  /// Sky wash over the city photo, top to bottom. Sets the mood and keeps white text readable.
  final List<Color> tint;

  /// 0–1 amounts.
  final double clouds, rain, snow, fog;
  final Color cloudColor;
  final bool lightning, sun, moon, stars;

  /// Warm horizon glow for sunrise / sunset; also drops the sun low.
  final Color? glow;

  static const _dayCloud = Color(0xFFF5F8FC);
  static const _greyCloud = Color(0xFFB4BCC8);
  static const _nightCloud = Color(0xFF7E8BA6);
  static const _stormCloud = Color(0xFF4B515E);
  static const _nightTint = [Color(0xB30A1430), Color(0x8C12224A), Color(0x401C2D5C)];

  factory WeatherScene.clear({required bool night}) => night
      ? const WeatherScene(id: 'clear-night', tint: _nightTint, moon: true, stars: true, clouds: .15, cloudColor: _nightCloud)
      : const WeatherScene(id: 'clear-day', tint: [Color(0x332F80ED), Color(0x0D2F80ED), Color(0x00000000)], sun: true, clouds: .2);

  factory WeatherScene.partlyCloudy({required bool night}) => night
      ? const WeatherScene(id: 'partly-cloudy-night', tint: _nightTint, moon: true, stars: true, clouds: .55, cloudColor: _nightCloud)
      : const WeatherScene(id: 'partly-cloudy-day', tint: [Color(0x262F80ED), Color(0x00000000)], sun: true, clouds: .55);

  factory WeatherScene.cloudy({required bool night}) => night
      ? const WeatherScene(id: 'cloudy-night', tint: [Color(0xB30E1526), Color(0x80141D33), Color(0x40182238)], clouds: 1, cloudColor: _nightCloud)
      : const WeatherScene(id: 'cloudy-day', tint: [Color(0x59606A78), Color(0x26606A78), Color(0x0D606A78)], clouds: 1, cloudColor: _greyCloud);

  factory WeatherScene.rain({required bool night}) => night
      ? const WeatherScene(id: 'rain-night', tint: [Color(0xBF0B1222), Color(0x99101828), Color(0x66141C2C)], clouds: .9, cloudColor: _stormCloud, rain: 1, fog: .25)
      : const WeatherScene(id: 'rain-day', tint: [Color(0x8C3A4250), Color(0x593A4250), Color(0x333A4250)], clouds: .9, cloudColor: _greyCloud, rain: 1, fog: .25);

  factory WeatherScene.thunderstorm({required bool night}) => WeatherScene(
    id: night ? 'storm-night' : 'storm-day',
    tint: night ? const [Color(0xD906090F), Color(0xB30B0F18), Color(0x80101520)] : const [Color(0xB31A1D24), Color(0x8C1F232B), Color(0x591F232B)],
    clouds: 1,
    cloudColor: _stormCloud,
    rain: 1.35,
    fog: .15,
    lightning: true,
  );

  factory WeatherScene.snow({required bool night}) => night
      ? const WeatherScene(id: 'snow-night', tint: [Color(0xA6142038), Color(0x731C2A48), Color(0x40263452)], clouds: .7, cloudColor: _nightCloud, snow: 1, fog: .15)
      : const WeatherScene(id: 'snow-day', tint: [Color(0x66C8D2DE), Color(0x33DDE4EC), Color(0x1AFFFFFF)], clouds: .7, cloudColor: _greyCloud, snow: 1, fog: .15);

  factory WeatherScene.fog({required bool night}) => night
      ? const WeatherScene(id: 'fog-night', tint: [Color(0xB3141A26), Color(0x8C1A2130), Color(0x661E2534)], clouds: .3, cloudColor: _nightCloud, fog: 1)
      : const WeatherScene(id: 'fog-day', tint: [Color(0x66A0A8B2), Color(0x4DB4BBC4), Color(0x33C8CED6)], clouds: .3, cloudColor: _greyCloud, fog: 1);

  factory WeatherScene.sunrise() => const WeatherScene(id: 'sunrise', tint: [Color(0x803A5BA8), Color(0x40C77DA0), Color(0x26FFB27A)], sun: true, clouds: .35, cloudColor: Color(0xFFFFE2D0), glow: Color(0xFFFFA65C));

  factory WeatherScene.sunset() => const WeatherScene(id: 'sunset', tint: [Color(0x8C2B2A5E), Color(0x598E4A7A), Color(0x40FF8A4C)], sun: true, clouds: .35, cloudColor: Color(0xFFFFC9B0), glow: Color(0xFFFF7A3D));
}

/// Animated sky for the weather hero, drawn over the city photo. Repaints straight from a clock (no widget rebuilds),
/// crossfades when the scene changes, and holds still when the system asks for reduced motion.
class WeatherSceneView extends StatefulWidget {
  const WeatherSceneView({super.key, required this.scene});

  final WeatherScene scene;

  @override
  State<WeatherSceneView> createState() => _WeatherSceneViewState();
}

class _WeatherSceneViewState extends State<WeatherSceneView> with SingleTickerProviderStateMixin {
  // seconds since the scene started; never completes. Tickers pause on their own when the route is covered.
  late final AnimationController _clock = AnimationController.unbounded(vsync: this, value: 8);
  _WeatherScenePainter? _painter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _clock.stop();
    } else if (!_clock.isAnimating) {
      _clock.animateWith(_Forever(_clock.value));
    }
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // keep the painter (and its cached shaders/particles) across parent rebuilds; only a new scene makes a new one
    if (_painter?.scene.id != widget.scene.id) _painter = _WeatherScenePainter(widget.scene, _clock);
    return IgnorePointer(
      child: RepaintBoundary(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 900),
          child: CustomPaint(key: ValueKey(widget.scene.id), painter: _painter, size: Size.infinite),
        ),
      ),
    );
  }
}

class _Forever extends Simulation {
  _Forever(this.start);

  final double start;

  @override
  double x(double time) => start + time;

  @override
  double dx(double time) => 1;

  @override
  bool isDone(double time) => false;
}

class _WeatherScenePainter extends CustomPainter {
  _WeatherScenePainter(this.scene, this.clock) : super(repaint: clock);

  final WeatherScene scene;
  final Animation<double> clock;
  _SceneLayers? _layers;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    if (_layers?.size != size) _layers = _SceneLayers(scene, size);
    _layers!.paint(canvas, clock.value);
  }

  @override
  bool shouldRepaint(_WeatherScenePainter old) => old.scene.id != scene.id;
}

/// Everything a scene draws, built once per scene + size: positions, paths, shaders and Paints.
/// Per frame only positions are recomputed and Paint alphas changed, so painting allocates nothing.
class _SceneLayers {
  _SceneLayers(this.scene, this.size) : _rnd = math.Random(scene.id.hashCode) {
    final w = size.width, h = size.height;
    // particle counts follow the area so tablets get denser scenes, capped for low-end phones
    _density = (w * h / (390 * 310)).clamp(.6, 2.2);
    _tint = Paint()..shader = ui.Gradient.linear(Offset.zero, Offset(0, h), scene.tint, _stops(scene.tint.length));
    if (scene.glow != null) _buildGlow();
    if (scene.stars) _buildStars();
    if (scene.sun) _buildSun();
    if (scene.moon) _buildMoon();
    if (scene.clouds > 0) {
      _farClouds = _buildClouds(count: (scene.clouds * 4).round() + 1, near: false);
      _nearClouds = _buildClouds(count: (scene.clouds * 3).round(), near: true);
    }
    if (scene.rain > 0) {
      _rainLayers = [
        _buildRain(count: (scene.rain * 70 * _density).round(), len: (8, 14), speed: (420, 560), width: 1, alpha: .26),
        _buildRain(count: (scene.rain * 38 * _density).round(), len: (16, 26), speed: (720, 900), width: 1.6, alpha: .45),
      ];
    }
    if (scene.snow > 0) {
      _snowLayers = [
        _buildSnow(count: (scene.snow * 60 * _density).round(), radius: 1.1, speed: (16, 26), alpha: .55),
        _buildSnow(count: (scene.snow * 36 * _density).round(), radius: 1.9, speed: (28, 42), alpha: .75),
        _buildSnow(count: (scene.snow * 16 * _density).round(), radius: 3, speed: (48, 66), alpha: .9),
      ];
    }
    if (scene.fog > 0) _buildFog();
  }

  final WeatherScene scene;
  final Size size;
  final math.Random _rnd;
  late final double _density;
  late final Paint _tint;

  double _between((double, double) range) => range.$1 + _rnd.nextDouble() * (range.$2 - range.$1);

  static List<double> _stops(int n) => [for (var i = 0; i < n; i++) n == 1 ? 0 : i / (n - 1)];

  void paint(Canvas canvas, double t) {
    canvas.drawRect(Offset.zero & size, _tint);
    if (_glowPaint != null) _paintGlow(canvas, t);
    if (_starGroups != null) _paintStars(canvas, t);
    if (_sunGlow != null) _paintSun(canvas, t);
    if (_moonGlow != null) _paintMoon(canvas, t);
    if (_farClouds != null) _paintClouds(canvas, _farClouds!, t);
    if (_rainLayers != null) _paintRain(canvas, _rainLayers![0], t);
    if (_snowLayers != null) _paintSnow(canvas, _snowLayers![0], t);
    if (_fogBlobs != null) _paintFog(canvas, t, front: false);
    if (_nearClouds != null) _paintClouds(canvas, _nearClouds!, t);
    if (_snowLayers != null) {
      _paintSnow(canvas, _snowLayers![1], t);
      _paintSnow(canvas, _snowLayers![2], t);
    }
    if (_rainLayers != null) _paintRain(canvas, _rainLayers![1], t);
    if (_fogBlobs != null) _paintFog(canvas, t, front: true);
    if (scene.lightning) _paintLightning(canvas, t);
  }

  // ---- horizon glow (sunrise / sunset)
  Paint? _glowPaint;

  void _buildGlow() {
    final c = scene.glow!;
    final center = Offset(size.width * .5, size.height * 1.05);
    _glowPaint = Paint()..shader = ui.Gradient.radial(center, size.width * .95, [c.withValues(alpha: .6), c.withValues(alpha: .22), c.withValues(alpha: 0)], [0, .45, 1]);
  }

  void _paintGlow(Canvas canvas, double t) {
    _glowPaint!.color = Color.fromRGBO(0, 0, 0, .85 + .15 * math.sin(t * .15));
    canvas.drawRect(Offset.zero & size, _glowPaint!);
  }

  // ---- stars: three twinkle groups, each one draw call
  List<(Float32List, Paint, double, double)>? _starGroups;

  void _buildStars() {
    final n = (55 * _density).round();
    _starGroups = [
      for (final width in const [1.1, 1.6, 2.2])
        (
          Float32List.fromList([for (var i = 0; i < n ~/ 3; i++) ...[_rnd.nextDouble() * size.width, _rnd.nextDouble() * size.height * .62]]),
          Paint()
            ..strokeWidth = width
            ..strokeCap = StrokeCap.round,
          .4 + _rnd.nextDouble() * .8, // twinkle speed
          _rnd.nextDouble() * math.pi * 2, // phase
        ),
    ];
  }

  void _paintStars(Canvas canvas, double t) {
    for (final (points, paint, speed, phase) in _starGroups!) {
      paint.color = Color.fromRGBO(255, 255, 255, .45 + .4 * math.sin(t * speed + phase).abs());
      canvas.drawRawPoints(ui.PointMode.points, points, paint);
    }
  }

  // ---- sun: glow, slowly turning soft rays, disc
  Paint? _sunGlow;
  late Paint _sunRays, _sunDisc;
  late Path _rayPath;
  late Offset _sunCenter;
  late double _sunRadius;

  void _buildSun() {
    final low = scene.glow != null;
    _sunRadius = size.shortestSide * (low ? .1 : .085);
    _sunCenter = Offset(size.width * .78, size.height * (low ? .7 : .3));
    final warm = low ? const Color(0xFFFFB067) : const Color(0xFFFFE08A);
    _sunGlow = Paint()..shader = ui.Gradient.radial(_sunCenter, _sunRadius * 5, [warm.withValues(alpha: .55), warm.withValues(alpha: .18), warm.withValues(alpha: 0)], [0, .35, 1]);
    _sunRays = Paint()..shader = ui.Gradient.radial(Offset.zero, _sunRadius * 3.6, [Colors.white.withValues(alpha: .5), Colors.white.withValues(alpha: 0)]);
    _sunDisc = Paint()..shader = ui.Gradient.radial(_sunCenter.translate(-_sunRadius * .3, -_sunRadius * .3), _sunRadius * 1.4, [const Color(0xFFFFFBE6), low ? const Color(0xFFFFC27A) : const Color(0xFFFFE27A), low ? const Color(0xFFFF9A4D) : const Color(0xFFFFC94D)], [0, .5, 1]);
    _rayPath = Path();
    const rays = 12;
    for (var i = 0; i < rays; i++) {
      final a = i / rays * math.pi * 2;
      final spread = math.pi / rays * .35;
      final len = _sunRadius * (i.isEven ? 3.4 : 2.6);
      _rayPath
        ..moveTo(math.cos(a - spread) * _sunRadius, math.sin(a - spread) * _sunRadius)
        ..lineTo(math.cos(a) * len, math.sin(a) * len)
        ..lineTo(math.cos(a + spread) * _sunRadius, math.sin(a + spread) * _sunRadius)
        ..close();
    }
  }

  void _paintSun(Canvas canvas, double t) {
    _sunGlow!.color = Color.fromRGBO(0, 0, 0, .85 + .15 * math.sin(t * .5));
    canvas.drawCircle(_sunCenter, _sunRadius * 5, _sunGlow!);
    _sunRays.color = Color.fromRGBO(0, 0, 0, .55 + .25 * math.sin(t * .35));
    canvas
      ..save()
      ..translate(_sunCenter.dx, _sunCenter.dy)
      ..rotate(t * .025)
      ..drawPath(_rayPath, _sunRays)
      ..restore();
    canvas.drawCircle(_sunCenter, _sunRadius, _sunDisc);
  }

  // ---- moon
  Paint? _moonGlow;
  late Paint _moonDisc, _crater;
  late Offset _moonCenter;
  late double _moonRadius;

  void _buildMoon() {
    _moonRadius = size.shortestSide * .075;
    _moonCenter = Offset(size.width * .78, size.height * .28);
    _moonGlow = Paint()..shader = ui.Gradient.radial(_moonCenter, _moonRadius * 4.5, [const Color(0x55DDE7FF), const Color(0x22C8D6F5), const Color(0x00C8D6F5)], [0, .4, 1]);
    _moonDisc = Paint()..shader = ui.Gradient.radial(_moonCenter.translate(-_moonRadius * .35, -_moonRadius * .35), _moonRadius * 1.5, [Colors.white, const Color(0xFFF0EFDC), const Color(0xFFD3D3C1)], [0, .55, 1]);
    _crater = Paint()..color = const Color(0x40A9AA9C);
  }

  void _paintMoon(Canvas canvas, double t) {
    _moonGlow!.color = Color.fromRGBO(0, 0, 0, .85 + .15 * math.sin(t * .4));
    canvas.drawCircle(_moonCenter, _moonRadius * 4.5, _moonGlow!);
    canvas.drawCircle(_moonCenter, _moonRadius, _moonDisc);
    canvas.drawCircle(_moonCenter.translate(_moonRadius * .3, _moonRadius * .15), _moonRadius * .18, _crater);
    canvas.drawCircle(_moonCenter.translate(-_moonRadius * .22, _moonRadius * .32), _moonRadius * .11, _crater);
    canvas.drawCircle(_moonCenter.translate(-_moonRadius * .05, -_moonRadius * .35), _moonRadius * .08, _crater);
  }

  // ---- clouds: soft puffs (radial gradients, no blur filters), two parallax layers
  List<_Cloud>? _farClouds, _nearClouds;

  List<_Cloud> _buildClouds({required int count, required bool near}) {
    final w = size.width, h = size.height;
    final base = scene.cloudColor;
    final shade = Color.lerp(base, Colors.black, .22)!;
    return [
      for (var i = 0; i < count; i++)
        () {
          final width = w * (near ? _between((.42, .62)) : _between((.24, .36)));
          final puffs = <(Offset, double, Paint)>[];
          void puff(double dx, double dy, double r, Color c) => puffs.add((Offset(dx, dy), r, Paint()..shader = ui.Gradient.radial(Offset(dx, dy), r, [c.withValues(alpha: .95), c.withValues(alpha: .8), c.withValues(alpha: 0)], [0, .55, 1])));
          // shaded underside first, bright crown on top
          for (var k = 0; k < 4; k++) {
            puff(-width * .38 + k * width * .25, width * .08, width * _between((.15, .2)), shade);
          }
          for (var k = 0; k < 5; k++) {
            final arc = math.sin(k / 4 * math.pi);
            puff(-width * .36 + k * width * .18, -arc * width * .11 + _between((-.02, .02)) * width, width * (.14 + .1 * arc + _between((0, .03))), base);
          }
          return _Cloud(
            x: _rnd.nextDouble() * (w + width * 2),
            y: h * (near ? _between((.12, .55)) : _between((.05, .45))),
            width: width,
            speed: (near ? _between((9, 15)) : _between((3.5, 7))) * (w / 390),
            alpha: near ? _between((.8, .95)) : _between((.45, .7)),
            phase: _rnd.nextDouble() * math.pi * 2,
            puffs: puffs,
          );
        }(),
    ];
  }

  void _paintClouds(Canvas canvas, List<_Cloud> clouds, double t) {
    final span = size.width;
    for (final c in clouds) {
      final x = (c.x + t * c.speed) % (span + c.width * 2) - c.width;
      // slow brightness breathing so the sky never looks frozen
      final alpha = c.alpha * (.88 + .12 * math.sin(t * .18 + c.phase));
      canvas
        ..save()
        ..translate(x, c.y);
      for (final (center, r, paint) in c.puffs) {
        paint.color = Color.fromRGBO(0, 0, 0, alpha);
        canvas.drawCircle(center, r, paint);
      }
      canvas.restore();
    }
  }

  // ---- rain: each layer is one drawRawPoints(lines) call over a reused buffer
  List<_Particles>? _rainLayers;
  static const _slant = .17;

  _Particles _buildRain({required int count, required (double, double) len, required (double, double) speed, required double width, required double alpha}) {
    final h = size.height;
    return _Particles(
      x: Float32List.fromList([for (var i = 0; i < count; i++) _rnd.nextDouble() * (size.width + h * _slant) - h * _slant]),
      y: Float32List.fromList([for (var i = 0; i < count; i++) _rnd.nextDouble() * h]),
      len: Float32List.fromList([for (var i = 0; i < count; i++) _between(len)]),
      speed: Float32List.fromList([for (var i = 0; i < count; i++) _between(speed) * (h / 310)]),
      buffer: Float32List(count * 4),
      paint: Paint()
        ..color = Color.fromRGBO(220, 235, 255, alpha)
        ..strokeWidth = width
        ..strokeCap = StrokeCap.round,
    );
  }

  void _paintRain(Canvas canvas, _Particles p, double t) {
    final h = size.height;
    final b = p.buffer;
    for (var i = 0; i < p.x.length; i++) {
      final len = p.len[i];
      final y = (p.y[i] + t * p.speed[i]) % (h + len) - len;
      final x = p.x[i] + y * _slant;
      b[i * 4] = x;
      b[i * 4 + 1] = y;
      b[i * 4 + 2] = x + len * _slant;
      b[i * 4 + 3] = y + len;
    }
    canvas.drawRawPoints(ui.PointMode.lines, b, p.paint);
  }

  // ---- snow: one drawRawPoints(points) call per layer, flakes sway as they fall
  List<_Particles>? _snowLayers;

  _Particles _buildSnow({required int count, required double radius, required (double, double) speed, required double alpha}) {
    return _Particles(
      x: Float32List.fromList([for (var i = 0; i < count; i++) _rnd.nextDouble() * size.width]),
      y: Float32List.fromList([for (var i = 0; i < count; i++) _rnd.nextDouble() * size.height]),
      len: Float32List.fromList([for (var i = 0; i < count; i++) _rnd.nextDouble() * math.pi * 2]), // sway phase
      speed: Float32List.fromList([for (var i = 0; i < count; i++) _between(speed) * (size.height / 310)]),
      buffer: Float32List(count * 2),
      paint: Paint()
        ..color = Color.fromRGBO(255, 255, 255, alpha)
        ..strokeWidth = radius * 2
        ..strokeCap = StrokeCap.round,
    );
  }

  void _paintSnow(Canvas canvas, _Particles p, double t) {
    final h = size.height;
    final sway = size.width * .02;
    final b = p.buffer;
    for (var i = 0; i < p.x.length; i++) {
      b[i * 2] = p.x[i] + math.sin(t * .9 + p.len[i]) * sway;
      b[i * 2 + 1] = (p.y[i] + t * p.speed[i]) % (h + 8) - 4;
    }
    canvas.drawRawPoints(ui.PointMode.points, b, p.paint);
  }

  // ---- fog: wide soft blobs drifting at two depths
  List<(Offset, double, Paint, bool)>? _fogBlobs;

  void _buildFog() {
    final w = size.width, h = size.height;
    final light = scene.tint.first.computeLuminance() > .25 || scene.id.endsWith('day');
    final c = light ? const Color(0xFFF2F4F7) : const Color(0xFF9AA6BC);
    _fogBlobs = [
      for (var i = 0; i < 8; i++)
        () {
          final front = i.isOdd;
          final r = w * _between((.35, .55));
          final paint = Paint()..shader = ui.Gradient.radial(Offset.zero, r, [c.withValues(alpha: front ? .42 : .3), c.withValues(alpha: 0)]);
          return (Offset(i / 8 * w * 2, h * (front ? _between((.62, .95)) : _between((.35, .7)))), r, paint, front);
        }(),
    ];
  }

  void _paintFog(Canvas canvas, double t, {required bool front}) {
    final w = size.width;
    for (final (pos, r, paint, isFront) in _fogBlobs!) {
      if (isFront != front) continue;
      paint.color = Color.fromRGBO(0, 0, 0, scene.fog * (.75 + .25 * math.sin(t * .2 + pos.dx)));
      final x = (pos.dx + t * (front ? 9 : 4) * (w / 390)) % (w * 2) - w * .5;
      canvas
        ..save()
        ..translate(x, pos.dy)
        ..scale(1, .35) // flatten into a drifting band
        ..drawCircle(Offset.zero, r, paint)
        ..restore();
    }
  }

  // ---- lightning: one strike per 7s window at a seeded random moment, double flash, whole sky lit
  int _boltWindow = -1;
  Path? _bolt;
  double _strikeAt = 0;
  final Paint _flash = Paint();
  final Paint _boltCore = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.2
    ..strokeJoin = StrokeJoin.round
    ..strokeCap = StrokeCap.round;
  final Paint _boltGlow = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 7
    ..strokeJoin = StrokeJoin.round
    ..strokeCap = StrokeCap.round;

  void _paintLightning(Canvas canvas, double t) {
    const window = 7.0;
    final k = (t / window).floor();
    if (k != _boltWindow) {
      // new bolt only once per window, so paths aren't built every frame
      _boltWindow = k;
      final r = math.Random(k * 7919 + scene.id.hashCode);
      _strikeAt = k * window + 1 + r.nextDouble() * 4.5;
      var x = size.width * (.2 + r.nextDouble() * .6), y = -4.0;
      _bolt = Path()..moveTo(x, y);
      while (y < size.height * (.45 + r.nextDouble() * .25)) {
        x += (r.nextDouble() - .5) * size.width * .09;
        y += size.height * (.04 + r.nextDouble() * .06);
        _bolt!.lineTo(x, y);
      }
    }
    final s = t - _strikeAt;
    if (s < 0 || s > .9) return;
    final intensity = s < .07 ? 1.0 : s < .14 ? .25 : s < .24 ? .8 : math.exp(-(s - .24) * 7) * .8;
    _flash.color = Color.fromRGBO(225, 232, 255, .32 * intensity);
    canvas.drawRect(Offset.zero & size, _flash);
    if (s < .24) {
      _boltGlow.color = Color.fromRGBO(200, 215, 255, .35 * intensity);
      _boltCore.color = Color.fromRGBO(255, 255, 255, intensity);
      canvas
        ..drawPath(_bolt!, _boltGlow)
        ..drawPath(_bolt!, _boltCore);
    }
  }
}

class _Cloud {
  _Cloud({required this.x, required this.y, required this.width, required this.speed, required this.alpha, required this.phase, required this.puffs});

  final double x, y, width, speed, alpha, phase;
  // centre (relative to the cloud), radius, paint with its radial shader
  final List<(Offset, double, Paint)> puffs;
}

class _Particles {
  _Particles({required this.x, required this.y, required this.len, required this.speed, required this.buffer, required this.paint});

  final Float32List x, y, len, speed, buffer;
  final Paint paint;
}
