import 'dart:io';

import 'package:cupertino_native/components/button.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';

import '../../constants/fontsize.dart';

class WeatherShimmerScreen extends StatelessWidget {
  const WeatherShimmerScreen({super.key});

  Color _baseColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light ? const Color(0xFFE6EAF0) : const Color(0xFF2F343B);
  }

  Color _highlightColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light ? const Color(0xFFF6F8FB) : const Color(0xFF454B54);
  }

  Color _fillColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light ? const Color(0xFFF1F4F8) : const Color(0xFF262A31);
  }

  Widget _shimmerBox(BuildContext context, {required double height, double? width, double radius = 8, BoxShape shape = BoxShape.rectangle, EdgeInsets? margin}) {
    return Container(
      margin: margin,
      child: Shimmer.fromColors(
        baseColor: _baseColor(context),
        highlightColor: _highlightColor(context),
        period: const Duration(milliseconds: 1400),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(color: _fillColor(context), borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(radius), shape: shape),
        ),
      ),
    );
  }

  Widget _surfaceCard(BuildContext context, {required Widget child, double? height, EdgeInsets? padding}) {
    return Container(
      height: height,
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(14)),
      child: child,
    );
  }

  Widget _sectionTitle(BuildContext context, {double width = 130}) {
    return _shimmerBox(context, height: 12, width: width, radius: 4);
  }

  Widget _cardLine(BuildContext context, double width) {
    return _shimmerBox(context, height: 10, width: width, radius: 4);
  }

  Widget _heroHeader(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: Dimensions.h_30),
        Container(
          height: Dimensions.h_250,
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Theme.of(context).scaffoldBackgroundColor, Theme.of(context).scaffoldBackgroundColor], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        Positioned(
          left: 12,
          top: Dimensions.h_100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(context, height: 58, width: 72, radius: 10),
              const SizedBox(height: 8),
              _cardLine(context, 95),
              const SizedBox(height: 6),
              _cardLine(context, 75),
              const SizedBox(height: 16),
              Row(children: [_shimmerBox(context, height: 26, width: 52, radius: 13), const SizedBox(width: 6), _shimmerBox(context, height: 26, width: 52, radius: 13)]),
            ],
          ),
        ),
        Positioned(
          top: Dimensions.h_50,
          left: Dimensions.w_10,
          child: Platform.isIOS
              ? CNButton.icon(
                  icon: CNSymbol('chevron.left', size: Dimensions.h_10),
                  size: Dimensions.h_25,
                  onPressed: () => Get.back(),
                )
              : GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF0b6030)),
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: Dimensions.h_11),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _hourlyCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: _surfaceCard(
        context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(context, width: 105),
            const SizedBox(height: 12),
            Row(
              children: List.generate(
                6,
                (_) => Expanded(
                  child: Column(
                    children: [
                      _cardLine(context, 26),
                      const SizedBox(height: 6),
                      _shimmerBox(context, height: 25, width: 25, shape: BoxShape.circle),
                      const SizedBox(height: 6),
                      _cardLine(context, 20),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Align(alignment: Alignment.center, child: _cardLine(context, 110)),
          ],
        ),
      ),
    );
  }

  Widget _guideCard(BuildContext context) {
    return _surfaceCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _shimmerBox(context, height: 15, width: 15, shape: BoxShape.circle),
              const SizedBox(width: 4),
              _sectionTitle(context, width: 95),
              const SizedBox(width: 8),
              _shimmerBox(context, height: 14, width: 25, radius: 3),
            ],
          ),
          const SizedBox(height: 8),
          _cardLine(context, 190),
          const SizedBox(height: 6),
          _cardLine(context, 170),
          const SizedBox(height: 12),
          _shimmerBox(context, height: 30, width: double.infinity, radius: 5),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              final chipWidth = (constraints.maxWidth - 5) / 2;
              return Wrap(spacing: 5, runSpacing: 5, children: List.generate(6, (_) => _shimmerBox(context, height: 30, width: chipWidth, radius: 5)));
            },
          ),
        ],
      ),
    );
  }

  Widget _glanceCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).splashColor,
        border: Border.all(color: Theme.of(context).focusColor, width: 0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [_cardLine(context, 20), const SizedBox(height: 8), _cardLine(context, 28), const SizedBox(height: 3), _cardLine(context, 22)]),
    );
  }

  Widget _glanceSection(BuildContext context) {
    return _surfaceCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_sectionTitle(context, width: 110), _cardLine(context, 45)]),
          const SizedBox(height: 10),
          GridView.builder(
            itemCount: 8,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 4, mainAxisSpacing: 4, childAspectRatio: 1.10),
            itemBuilder: (context, index) => _glanceCard(context),
          ),
        ],
      ),
    );
  }

  Widget _iconLabelRow(BuildContext context, {int count = 5}) {
    return Row(
      children: List.generate(
        count,
        (_) => Expanded(
          child: Column(
            children: [
              _shimmerBox(context, height: 38, width: 38, shape: BoxShape.circle),
              const SizedBox(height: 5),
              _cardLine(context, 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _communitySection(BuildContext context) {
    return _surfaceCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(context, width: 145),
          const SizedBox(height: 6),
          _cardLine(context, 120),
          const SizedBox(height: 10),
          _iconLabelRow(context),
          const SizedBox(height: 10),
          Container(height: 0.5, color: Theme.of(context).focusColor),
          const SizedBox(height: 8),
          Center(child: _cardLine(context, 135)),
        ],
      ),
    );
  }

  Widget _activitySection(BuildContext context) {
    return _surfaceCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(context, width: 165),
          const SizedBox(height: 12),
          _iconLabelRow(context),
          const SizedBox(height: 12),
          Align(alignment: Alignment.center, child: _cardLine(context, 110)),
        ],
      ),
    );
  }

  Widget _bottomBanner(BuildContext context) {
    return _surfaceCard(
      context,
      height: 150,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(colors: [Color(0xFFBAC7D8), Color(0xFF7F95B5)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [_cardLine(context, 95), const SizedBox(height: 6), _cardLine(context, 130), const SizedBox(height: 10), _shimmerBox(context, height: 28, width: 80, radius: 14)]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 230,
            pinned: false,
            floating: false,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(collapseMode: CollapseMode.parallax, background: _heroHeader(context)),
          ),
          SliverToBoxAdapter(child: _hourlyCard(context)),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _guideCard(context),
                  const SizedBox(height: 10),
                  _glanceSection(context),
                  const SizedBox(height: 10),
                  _communitySection(context),
                  const SizedBox(height: 10),
                  _activitySection(context),
                  const SizedBox(height: 10),
                  _bottomBanner(context),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
