import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsScreenShimmer extends StatelessWidget {
  const NewsScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.grey.shade300;
    final highlightColor = Theme.of(context).brightness == Brightness.dark ? Colors.white24 : Colors.grey.shade100;

    return Stack(
      children: [
        CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: false,
              floating: false,
              stretch: true,
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                stretchModes: const [StretchMode.zoomBackground],
                background: _NewsShimmerBox(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF26374A), Color(0xFF38516C), Color(0xFF0F1D2A)]),
                    ),
                    padding: EdgeInsets.fromLTRB(16, Platform.isAndroid ? 86 : 96, 16, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _line(width: 120, height: 14, baseColor: baseColor, highlightColor: highlightColor),
                        const SizedBox(height: 14),
                        _line(width: 220, height: 26, baseColor: baseColor, highlightColor: highlightColor),
                        const SizedBox(height: 10),
                        _line(width: 170, height: 12, baseColor: baseColor, highlightColor: highlightColor),
                        const Spacer(),
                        Row(
                          children: [
                            _pill(width: 72, baseColor: baseColor, highlightColor: highlightColor),
                            const SizedBox(width: 8),
                            _pill(width: 88, baseColor: baseColor, highlightColor: highlightColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _headlineCard(baseColor, highlightColor),
                    const SizedBox(height: 6),
                    _headlineCard(baseColor, highlightColor, compact: true),
                    const SizedBox(height: 16),
                    _sectionHeader(baseColor, highlightColor),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: index == 4 ? 0 : 6),
                            child: _metricCard(baseColor, highlightColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _topStoryCard(baseColor, highlightColor),
                    const SizedBox(height: 16),
                    _sectionHeader(baseColor, highlightColor),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 140,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        separatorBuilder: (_, __) => const SizedBox(width: 6),
                        itemBuilder: (_, __) => SizedBox(width: 110, child: _repCard(baseColor, highlightColor)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _questionCard(baseColor, highlightColor),
                    const SizedBox(height: 16),
                    _sectionHeader(baseColor, highlightColor),
                    const SizedBox(height: 10),
                    _meetingCard(baseColor, highlightColor),
                    const SizedBox(height: 16),
                    _sectionHeader(baseColor, highlightColor),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 170,
                      child: ListView.separated(scrollDirection: Axis.horizontal, itemCount: 4, separatorBuilder: (_, __) => const SizedBox(width: 5), itemBuilder: (_, __) => _topicCard(baseColor, highlightColor)),
                    ),
                    const SizedBox(height: 16),
                    _sectionHeader(baseColor, highlightColor),
                    const SizedBox(height: 10),
                    _storyListCard(baseColor, highlightColor),
                    const SizedBox(height: 16),
                    _sectionHeader(baseColor, highlightColor),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 140,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (_, __) => SizedBox(width: 110, child: _regionCard(baseColor, highlightColor)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _sectionHeader(baseColor, highlightColor),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 130,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        separatorBuilder: (_, __) => const SizedBox(width: 6),
                        itemBuilder: (_, __) => SizedBox(width: 85, child: _communityCard(baseColor, highlightColor)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _partnerCard(baseColor, highlightColor),
                    const SizedBox(height: 10),
                    _aiCard(baseColor, highlightColor),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: Platform.isAndroid ? -10 : -20,
          left: 0,
          right: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: EdgeInsets.fromLTRB(12, Platform.isAndroid ? 44 : 56, 12, 10),
                color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.18),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.location_solid, color: Colors.white, size: 14),
                          const SizedBox(width: 6),
                          _line(width: 110, height: 14, baseColor: baseColor, highlightColor: highlightColor),
                          const SizedBox(width: 6),
                          Icon(CupertinoIcons.chevron_down, color: Colors.white, size: 12),
                        ],
                      ),
                    ),
                    Row(children: [_circle(28, baseColor, highlightColor), const SizedBox(width: 8), _circle(28, baseColor, highlightColor)]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(Color baseColor, Color highlightColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _line(width: 130, height: 16, baseColor: baseColor, highlightColor: highlightColor),
        _line(width: 84, height: 12, baseColor: baseColor, highlightColor: highlightColor),
      ],
    );
  }

  Widget _headlineCard(Color baseColor, Color highlightColor, {bool compact = false}) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                _circle(42, baseColor, highlightColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _line(width: 120, height: 12, baseColor: baseColor, highlightColor: highlightColor),
                      const SizedBox(height: 6),
                      _line(width: 170, height: 10, baseColor: baseColor, highlightColor: highlightColor),
                    ],
                  ),
                ),
                _circle(28, baseColor, highlightColor),
              ],
            ),
            if (!compact) ...[const SizedBox(height: 10), _line(width: double.infinity, height: 56, baseColor: baseColor, highlightColor: highlightColor, radius: 10)],
          ],
        ),
      ),
    );
  }

  Widget _metricCard(Color baseColor, Color highlightColor) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          children: [
            _circle(26, baseColor, highlightColor),
            const SizedBox(height: 10),
            _line(width: 26, height: 14, baseColor: baseColor, highlightColor: highlightColor),
            const SizedBox(height: 6),
            _line(width: 44, height: 10, baseColor: baseColor, highlightColor: highlightColor),
          ],
        ),
      ),
    );
  }

  Widget _topStoryCard(Color baseColor, Color highlightColor) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(baseColor, highlightColor),
            const SizedBox(height: 8),
            _line(width: double.infinity, height: 110, baseColor: baseColor, highlightColor: highlightColor, radius: 8),
            const SizedBox(height: 10),
            _line(width: 90, height: 16, baseColor: baseColor, highlightColor: highlightColor),
            const SizedBox(height: 8),
            _line(width: double.infinity, height: 14, baseColor: baseColor, highlightColor: highlightColor),
            const SizedBox(height: 6),
            _line(width: 240, height: 10, baseColor: baseColor, highlightColor: highlightColor),
            const SizedBox(height: 10),
            Row(
              children: [
                _line(width: 40, height: 10, baseColor: baseColor, highlightColor: highlightColor),
                const SizedBox(width: 12),
                _line(width: 62, height: 10, baseColor: baseColor, highlightColor: highlightColor),
                const SizedBox(width: 12),
                _line(width: 54, height: 10, baseColor: baseColor, highlightColor: highlightColor),
                const Spacer(),
                _circle(14, baseColor, highlightColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _repCard(Color baseColor, Color highlightColor) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _circle(35, baseColor, highlightColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _pill(width: 42, baseColor: baseColor, highlightColor: highlightColor, height: 14),
                      const SizedBox(height: 6),
                      _line(width: 52, height: 10, baseColor: baseColor, highlightColor: highlightColor),
                      const SizedBox(height: 4),
                      _line(width: 56, height: 9, baseColor: baseColor, highlightColor: highlightColor),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            _line(width: 72, height: 10, baseColor: baseColor, highlightColor: highlightColor),
            const SizedBox(height: 10),
            _line(width: double.infinity, height: 28, baseColor: baseColor, highlightColor: highlightColor, radius: 8),
          ],
        ),
      ),
    );
  }

  Widget _questionCard(Color baseColor, Color highlightColor) {
    return _card(
      color: const Color(0xFFEFEAFB),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _line(width: 150, height: 12, baseColor: baseColor, highlightColor: highlightColor),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _circle(34, baseColor, highlightColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _line(width: 220, height: 16, baseColor: baseColor, highlightColor: highlightColor),
                      const SizedBox(height: 8),
                      _line(width: 140, height: 10, baseColor: baseColor, highlightColor: highlightColor),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _line(width: double.infinity, height: 34, baseColor: baseColor, highlightColor: highlightColor, radius: 8),
            const SizedBox(height: 8),
            _line(width: double.infinity, height: 34, baseColor: baseColor, highlightColor: highlightColor, radius: 8),
          ],
        ),
      ),
    );
  }

  Widget _meetingCard(Color baseColor, Color highlightColor) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(children: [_meetingRow(baseColor, highlightColor, live: true), const Divider(height: 12), _meetingRow(baseColor, highlightColor)]),
      ),
    );
  }

  Widget _meetingRow(Color baseColor, Color highlightColor, {bool live = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        children: [
          _circle(20, baseColor, highlightColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _line(width: 120, height: 12, baseColor: baseColor, highlightColor: highlightColor),
                    if (live) ...[const SizedBox(width: 6), _pill(width: 28, baseColor: baseColor, highlightColor: highlightColor, height: 14)],
                  ],
                ),
                const SizedBox(height: 6),
                _line(width: 78, height: 10, baseColor: baseColor, highlightColor: highlightColor),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _line(width: 70, height: 24, baseColor: baseColor, highlightColor: highlightColor, radius: 6),
        ],
      ),
    );
  }

  Widget _topicCard(Color baseColor, Color highlightColor) {
    return Container(
      width: 100,
      decoration: BoxDecoration(color: const Color(0xFF315CB6), borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _circle(28, baseColor, highlightColor),
            const SizedBox(height: 10),
            _line(width: 54, height: 12, baseColor: baseColor, highlightColor: highlightColor),
            const SizedBox(height: 4),
            _line(width: 62, height: 12, baseColor: baseColor, highlightColor: highlightColor),
            const SizedBox(height: 10),
            _line(width: 68, height: 10, baseColor: baseColor, highlightColor: highlightColor),
            const Spacer(),
            _line(width: 28, height: 28, baseColor: baseColor, highlightColor: highlightColor, radius: 8),
          ],
        ),
      ),
    );
  }

  Widget _storyListCard(Color baseColor, Color highlightColor) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            _storyRow(baseColor, highlightColor),
            const Divider(height: 12),
            _storyRow(baseColor, highlightColor),
            const Divider(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _line(width: 110, height: 12, baseColor: baseColor, highlightColor: highlightColor),
                  const SizedBox(width: 8),
                  _circle(12, baseColor, highlightColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _storyRow(Color baseColor, Color highlightColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _line(width: 84, height: 10, baseColor: baseColor, highlightColor: highlightColor),
                const SizedBox(height: 8),
                _line(width: double.infinity, height: 12, baseColor: baseColor, highlightColor: highlightColor),
                const SizedBox(height: 6),
                _line(width: 120, height: 10, baseColor: baseColor, highlightColor: highlightColor),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _line(width: 70, height: 70, baseColor: baseColor, highlightColor: highlightColor, radius: 8),
          const SizedBox(width: 8),
          _circle(12, baseColor, highlightColor),
        ],
      ),
    );
  }

  Widget _regionCard(Color baseColor, Color highlightColor) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _line(width: double.infinity, height: 12, baseColor: baseColor, highlightColor: highlightColor),
            const SizedBox(height: 6),
            _line(width: 80, height: 10, baseColor: baseColor, highlightColor: highlightColor),
            const SizedBox(height: 10),
            _line(width: double.infinity, height: 70, baseColor: baseColor, highlightColor: highlightColor, radius: 8),
          ],
        ),
      ),
    );
  }

  Widget _communityCard(Color baseColor, Color highlightColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _line(width: 70, height: 70, baseColor: baseColor, highlightColor: highlightColor, radius: 8),
        const SizedBox(height: 8),
        _line(width: 60, height: 10, baseColor: baseColor, highlightColor: highlightColor),
        const SizedBox(height: 4),
        _line(width: 46, height: 9, baseColor: baseColor, highlightColor: highlightColor),
      ],
    );
  }

  Widget _partnerCard(Color baseColor, Color highlightColor) {
    return _card(
      color: const Color(0xFFFDF5E9),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _line(width: 150, height: 12, baseColor: baseColor, highlightColor: highlightColor),
                  const SizedBox(height: 10),
                  _line(width: 130, height: 16, baseColor: baseColor, highlightColor: highlightColor),
                  const SizedBox(height: 8),
                  _line(width: double.infinity, height: 10, baseColor: baseColor, highlightColor: highlightColor),
                  const SizedBox(height: 6),
                  _line(width: 160, height: 10, baseColor: baseColor, highlightColor: highlightColor),
                  const SizedBox(height: 10),
                  _line(width: 100, height: 30, baseColor: baseColor, highlightColor: highlightColor, radius: 6),
                ],
              ),
            ),
            const SizedBox(width: 10),
            _line(width: 110, height: 110, baseColor: baseColor, highlightColor: highlightColor, radius: 8),
          ],
        ),
      ),
    );
  }

  Widget _aiCard(Color baseColor, Color highlightColor) {
    return _card(
      color: const Color(0xFFE2EEE7),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _line(width: 110, height: 16, baseColor: baseColor, highlightColor: highlightColor),
                  const SizedBox(height: 10),
                  _line(width: double.infinity, height: 10, baseColor: baseColor, highlightColor: highlightColor),
                  const SizedBox(height: 6),
                  _line(width: 180, height: 10, baseColor: baseColor, highlightColor: highlightColor),
                  const SizedBox(height: 10),
                  _line(width: 110, height: 30, baseColor: baseColor, highlightColor: highlightColor, radius: 6),
                ],
              ),
            ),
            const SizedBox(width: 10),
            _line(width: 110, height: 98, baseColor: baseColor, highlightColor: highlightColor, radius: 8),
          ],
        ),
      ),
    );
  }

  Widget _card({required Widget child, Color? color}) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
      ),
      child: child,
    );
  }

  Widget _line({required double width, required double height, required Color baseColor, required Color highlightColor, double radius = 6}) {
    return _NewsShimmerBox(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }

  Widget _pill({required double width, required Color baseColor, required Color highlightColor, double height = 18}) {
    return _line(width: width, height: height, baseColor: baseColor, highlightColor: highlightColor, radius: 999);
  }

  Widget _circle(double size, Color baseColor, Color highlightColor) {
    return _line(width: size, height: size, baseColor: baseColor, highlightColor: highlightColor, radius: size);
  }
}

class _NewsShimmerBox extends StatelessWidget {
  const _NewsShimmerBox({required this.baseColor, required this.highlightColor, required this.child});

  final Color baseColor;
  final Color highlightColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(baseColor: baseColor, highlightColor: highlightColor, child: child);
  }
}
