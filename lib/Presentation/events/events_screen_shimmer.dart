import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EventsScreenShimmer extends StatelessWidget {
  const EventsScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: false,
          floating: false,
          snap: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          expandedHeight: 312,
          flexibleSpace: FlexibleSpaceBar(
            background: _HeroShimmer(
              cardColor: Theme.of(context).scaffoldBackgroundColor,
              lineColor: isLight ? Colors.white : Colors.white10,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 70),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                _CardShimmer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _box(30, 30, context: context, isCircle: true),
                          const SizedBox(width: 8),
                          _box(110, 12, context: context),
                          const Spacer(),
                          _box(58, 10, context: context),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _box(double.infinity, 12, context: context),
                      const SizedBox(height: 8),
                      _box(double.infinity, 10, context: context),
                      const SizedBox(height: 8),
                      _box(180, 10, context: context),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _box(92, 10, context: context),
                            const SizedBox(width: 6),
                            _box(12, 12, context: context, isCircle: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const _SectionHeaderShimmer(),
                const SizedBox(height: 10),
                _EventsGridShimmer(cardColor: isLight ? Colors.white : const Color(0xFF1E2430)),
                const SizedBox(height: 12),
                const _WideCardSectionShimmer(itemCount: 2),
                const SizedBox(height: 12),
                _CategoryGridShimmer(cardColor: isLight ? Colors.white : const Color(0xFF1E2430)),
                const SizedBox(height: 12),
                const _ContributorsShimmer(),
                const SizedBox(height: 12),
                _FeatureStoryShimmer(cardColor: isLight ? Colors.white : const Color(0xFF1E2430)),
                const SizedBox(height: 12),
                const _ArticleGridShimmer(),
                const SizedBox(height: 12),
                _PlannerShimmer(cardColor: isLight ? Colors.white : const Color(0xFF1E2430)),
                const SizedBox(height: 12),
                _NewsletterShimmer(cardColor: const Color(0xFF2A2AD4)),
                const SizedBox(height: 16),
                _box(110, 12, context: context),
                const SizedBox(height: 10),
                const _ActionGridShimmer(),
                const SizedBox(height: 16),
                _box(128, 12, context: context),
                const SizedBox(height: 10),
                _ExploreShimmer(cardColor: isLight ? Colors.white : const Color(0xFF1E2430)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroShimmer extends StatelessWidget {
  const _HeroShimmer({
    required this.cardColor,
    required this.lineColor,
  });

  final Color cardColor;
  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 312,
          decoration: BoxDecoration(
            color: cardColor,
          ),
        ),
        Positioned(
          top: 22,
          right: -20,
          child: _box(120, 120, context: context, isCircle: true, color: Colors.white10),
        ),
        Positioned(
          left: -16,
          top: 128,
          child: _box(80, 80, context: context, isCircle: true, color: Colors.white10),
        ),
        Positioned(
          top: 46,
          left: 8,
          right: 8,
          child: Row(
            children: [
              _box(34, 34, context: context, radius: 10),
              const Spacer(),
              _box(34, 34, context: context, radius: 10),
              const SizedBox(width: 8),
              _box(34, 34, context: context, radius: 10),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 90, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _pill(88, 18, context: context),
              const SizedBox(height: 12),
              _box(228, 28, context: context, radius: 8),
              const SizedBox(height: 8),
              _box(182, 28, context: context, radius: 8),
              const SizedBox(height: 16),
              _box(232, 11, context: context),
              const SizedBox(height: 7),
              _box(176, 11, context: context),
              const Spacer(),
              Container(height: 1, color: lineColor),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _statBlock()),
                  const SizedBox(width: 18),
                  Expanded(child: _statBlock()),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _statBlock()),
                  const SizedBox(width: 18),
                  Expanded(child: _statBlock()),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _outlinedPill(112, 30, context: context),
                  const SizedBox(width: 8),
                  _outlinedPill(120, 30, context: context),
                  const SizedBox(width: 8),
                  _outlinedPill(94, 30, context: context),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statBlock() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _box(18, 18, isCircle: true),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _box(46, 11),
              const SizedBox(height: 5),
              _box(72, 9),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardShimmer extends StatelessWidget {
  const _CardShimmer({required this.child, this.color});

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionHeaderShimmer extends StatelessWidget {
  const _SectionHeaderShimmer();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pill(64, 10),
            const SizedBox(height: 6),
            _box(132, 14),
          ],
        ),
        const Spacer(),
        _outlinedPill(90, 28),
      ],
    );
  }
}

class _EventsGridShimmer extends StatelessWidget {
  const _EventsGridShimmer({required this.cardColor});

  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (_, __) {
        return _CardShimmer(
          color: cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    _box(double.infinity, double.infinity, radius: 10),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: _box(34, 42, radius: 8),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _pill(42, 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _box(28, 34, radius: 8),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _box(double.infinity, 10),
                        const SizedBox(height: 6),
                        _box(82, 9),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _iconTextLine(),
              const SizedBox(height: 6),
              _iconTextLine(width: 118),
              const SizedBox(height: 6),
              _iconTextLine(width: 92),
            ],
          ),
        );
      },
    );
  }
}

class _WideCardSectionShimmer extends StatelessWidget {
  const _WideCardSectionShimmer({required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return _CardShimmer(
      child: Column(
        children: List.generate(itemCount, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: index == itemCount - 1 ? 0 : 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    _box(84, 56, radius: 8),
                    Positioned(
                      top: 6,
                      left: 6,
                      child: _pill(32, 12),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _box(double.infinity, 11),
                      const SizedBox(height: 6),
                      _box(140, 9),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _box(52, 8),
                          const SizedBox(width: 8),
                          _box(40, 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _CategoryGridShimmer extends StatelessWidget {
  const _CategoryGridShimmer({required this.cardColor});

  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.18,
      ),
      itemBuilder: (_, __) {
        return _CardShimmer(
          color: cardColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  _box(34, 34, isCircle: true, color: Colors.white24),
                  _box(22, 22, isCircle: true),
                ],
              ),
              const SizedBox(height: 10),
              _box(54, 10),
              const SizedBox(height: 5),
              _box(38, 8),
            ],
          ),
        );
      },
    );
  }
}

class _ContributorsShimmer extends StatelessWidget {
  const _ContributorsShimmer();

  @override
  Widget build(BuildContext context) {
    return _CardShimmer(
      child: Row(
        children: List.generate(4, (index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: index == 3 ? 0 : 8),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      _box(54, 54, isCircle: true, color: Colors.white24),
                      _box(46, 46, isCircle: true),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _box(52, 10),
                  const SizedBox(height: 5),
                  _box(34, 8),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _FeatureStoryShimmer extends StatelessWidget {
  const _FeatureStoryShimmer({required this.cardColor});

  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return _CardShimmer(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              _box(double.infinity, 160, radius: 8),
              Positioned(
                left: 10,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _pill(58, 12),
                    const SizedBox(height: 8),
                    _box(188, 16, radius: 5),
                    const SizedBox(height: 6),
                    _box(134, 16, radius: 5),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _box(90, 9),
              const SizedBox(width: 8),
              _box(52, 9),
              const SizedBox(width: 8),
              _box(56, 9),
            ],
          ),
          const SizedBox(height: 10),
          _box(double.infinity, 10),
          const SizedBox(height: 6),
          _box(190, 10),
          const SizedBox(height: 10),
          Row(
            children: [
              _box(34, 10),
              const SizedBox(width: 14),
              _box(34, 10),
              const SizedBox(width: 14),
              _box(34, 10),
            ],
          ),
        ],
      ),
    );
  }
}

class _ArticleGridShimmer extends StatelessWidget {
  const _ArticleGridShimmer();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.92,
      ),
      itemBuilder: (_, __) {
        return _CardShimmer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _box(double.infinity, 110, radius: 8),
              const SizedBox(height: 8),
              _pill(56, 10),
              const SizedBox(height: 6),
              _box(double.infinity, 10),
              const SizedBox(height: 6),
              _box(110, 9),
              const SizedBox(height: 8),
              _box(78, 8),
              const Spacer(),
              Row(
                children: [
                  _box(40, 9),
                  const SizedBox(width: 10),
                  _box(40, 9),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PlannerShimmer extends StatelessWidget {
  const _PlannerShimmer({required this.cardColor});

  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return _CardShimmer(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeaderShimmer(),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(4, (index) => _outlinedPill(88 + (index == 1 ? 12 : 0), 28)),
          ),
          const SizedBox(height: 12),
          ...List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: index == 2 ? 0 : 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      _box(42, 50, radius: 8),
                      const SizedBox(height: 6),
                      _box(28, 8),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _box(double.infinity, 11),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _pill(64, 14),
                            const SizedBox(width: 6),
                            _pill(74, 14),
                          ],
                        ),
                        const SizedBox(height: 6),
                        _iconTextLine(width: 138),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _NewsletterShimmer extends StatelessWidget {
  const _NewsletterShimmer({required this.cardColor});

  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _box(24, 24, isCircle: true),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _box(148, 12),
                    const SizedBox(height: 6),
                    _box(166, 10),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _box(double.infinity, 34, radius: 4)),
              const SizedBox(width: 8),
              _outlinedPill(114, 34),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionGridShimmer extends StatelessWidget {
  const _ActionGridShimmer();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(4, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == 3 ? 0 : 6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      _box(36, 36, isCircle: true, color: Colors.white24),
                      _box(24, 24, isCircle: true),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _box(56, 9),
                  const SizedBox(height: 6),
                  _box(48, 8),
                  const SizedBox(height: 4),
                  _box(40, 8),
                  const SizedBox(height: 8),
                  _outlinedPill(58, 18),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _ExploreShimmer extends StatelessWidget {
  const _ExploreShimmer({required this.cardColor});

  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardShimmer(
          color: cardColor,
          child: Column(
            children: [
              Stack(
                children: [
                  _box(double.infinity, 156, radius: 8),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: _pill(52, 14),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _outlinedPill(64, 22),
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _box(90, 10),
                        const SizedBox(height: 6),
                        _box(188, 10),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const _WideCardSectionShimmer(itemCount: 3),
        const SizedBox(height: 12),
        const _WideCardSectionShimmer(itemCount: 3),
        const SizedBox(height: 12),
        const _WideCardSectionShimmer(itemCount: 3),
        const SizedBox(height: 12),
        _CardShimmer(
          color: cardColor,
          child: Row(
            children: [
              _box(30, 30, isCircle: true),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _box(88, 11),
                    const SizedBox(height: 6),
                    _box(double.infinity, 10),
                    const SizedBox(height: 6),
                    _box(150, 10),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _outlinedPill(40, 34),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _box(
    double width,
    double height, {
      BuildContext? context,
      bool isCircle = false,
      double radius = 6,
      Color color = Colors.white,
    }) {
  Widget placeholder(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final baseColor = isLight ? Colors.grey.shade300 : Colors.grey.shade800;
    final highlightColor = isLight ? Colors.grey.shade100 : Colors.grey.shade700;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: const Duration(milliseconds: 950),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: isCircle ? null : BorderRadius.circular(radius),
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }

  if (context != null) {
    return placeholder(context);
  }

  return Builder(builder: placeholder);
}

Widget _pill(double width, double height, {BuildContext? context}) {
  return _box(width, height, context: context, radius: 20);
}

Widget _outlinedPill(double width, double height, {BuildContext? context}) {
  return _box(
    width,
    height,
    context: context,
    radius: 999,
    color: Colors.white.withValues(alpha: 0.14),
  );
}

Widget _iconTextLine({double width = 92}) {
  return Row(
    children: [
      _box(11, 11, isCircle: true),
      const SizedBox(width: 6),
      _box(width, 8),
    ],
  );
}
