import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/extensions.dart';
import '../../constants/fontsize.dart';

class SportsScreenShimmer extends StatelessWidget {
  const SportsScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = _shimmerColors(context);
    return Stack(
      children: [
        CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHero(context, colors)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: Offset(0, -Dimensions.h_28),
                      child: _buildBriefCard(context, colors),
                    ),
                    _buildSectionHeader(context, colors),
                    SizedBox(height: Dimensions.h_10),
                    _buildSnapshotRow(context, colors),
                    SizedBox(height: Dimensions.h_15),
                    _buildCountdownCard(context, colors),
                    SizedBox(height: Dimensions.h_15),
                    _buildSectionHeader(context, colors),
                    SizedBox(height: Dimensions.h_8),
                    _buildHorizontalCards(
                      context,
                      colors,
                      itemWidth: Dimensions.w_120,
                      itemHeight: Dimensions.h_160,
                      itemCount: 3,
                    ),
                    SizedBox(height: Dimensions.h_15),
                    _buildEventsCard(context, colors),
                    SizedBox(height: Dimensions.h_15),
                    _buildSectionHeader(context, colors),
                    SizedBox(height: Dimensions.h_8),
                    _buildHorizontalCards(
                      context,
                      colors,
                      itemWidth: Dimensions.w_110,
                      itemHeight: Dimensions.h_170,
                      itemCount: 3,
                    ),
                    SizedBox(height: Dimensions.h_15),
                    _buildSectionHeader(context, colors),
                    SizedBox(height: Dimensions.h_8),
                    _buildHorizontalCards(
                      context,
                      colors,
                      itemWidth: Dimensions.w_145,
                      itemHeight: Dimensions.h_170,
                      itemCount: 2,
                    ),
                    SizedBox(height: Dimensions.h_15),
                    _buildPartnerBanner(context, colors),
                    SizedBox(height: Dimensions.h_15),
                    _buildSectionHeader(context, colors),
                    SizedBox(height: Dimensions.h_10),
                    _buildSponsorRow(context, colors),
                    SizedBox(height: Dimensions.h_15),
                    _buildVolunteerRow(context, colors),
                    SizedBox(height: Dimensions.h_23),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHero(BuildContext context, List<Color> colors) {
    return SizedBox(
      height: Dimensions.h_250,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: const Color(0xFF0B6030)),
          _block(context, colors, height: Dimensions.h_250, width: double.infinity),
        ],
      ),
    );
  }

  Widget _buildBriefCard(BuildContext context, List<Color> colors) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_8,
        Dimensions.h_8,
        Dimensions.w_8,
        Dimensions.h_6,
      ),
      decoration: BoxDecoration(
        color: context.sports.card,
        borderRadius: BorderRadius.circular(Dimensions.h_10),
        border: Border.all(color: context.sports.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _block(context, colors, height: Dimensions.h_18, width: Dimensions.h_18, radius: 9),
              SizedBox(width: Dimensions.w_6),
              Expanded(
                child: _block(context, colors, height: Dimensions.h_12, width: double.infinity),
              ),
              SizedBox(width: Dimensions.w_8),
              _block(context, colors, height: Dimensions.h_10, width: Dimensions.w_65),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          ...List.generate(
            4,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: index == 3 ? 0 : Dimensions.h_8),
              child: Row(
                children: [
                  _block(context, colors, height: Dimensions.h_12, width: Dimensions.h_12, radius: 6),
                  SizedBox(width: Dimensions.w_6),
                  Expanded(
                    child: _block(context, colors, height: Dimensions.h_11, width: double.infinity),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          Align(
            alignment: Alignment.centerRight,
            child: _block(context, colors, height: Dimensions.h_12, width: Dimensions.w_120),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, List<Color> colors) {
    return Row(
      children: [
        _block(context, colors, height: Dimensions.h_12, width: Dimensions.w_120),
        const Spacer(),
        _block(context, colors, height: Dimensions.h_10, width: Dimensions.w_48),
      ],
    );
  }

  Widget _buildSnapshotRow(BuildContext context, List<Color> colors) {
    return IntrinsicHeight(
      child: Row(
        children: List.generate(5, (index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: index == 4 ? 0 : Dimensions.w_6),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_6,
                  vertical: Dimensions.h_10,
                ),
                decoration: BoxDecoration(
                  color: context.sports.card,
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                  border: Border.all(color: context.sports.border),
                ),
                child: Column(
                  children: [
                    _block(context, colors, height: Dimensions.h_22, width: Dimensions.h_22, radius: 11),
                    SizedBox(height: Dimensions.h_10),
                    _block(context, colors, height: Dimensions.h_12, width: double.infinity),
                    SizedBox(height: Dimensions.h_6),
                    _block(context, colors, height: Dimensions.h_8, width: double.infinity),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCountdownCard(BuildContext context, List<Color> colors) {
    return Container(
      padding: EdgeInsets.all(Dimensions.h_10),
      decoration: BoxDecoration(
        color: context.sports.card,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: context.sports.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _block(context, colors, height: Dimensions.h_12, width: Dimensions.w_120),
          SizedBox(height: Dimensions.h_12),
          Row(
            children: [
              _block(context, colors, height: Dimensions.h_60, width: Dimensions.h_60, radius: 12),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        4,
                        (_) => _block(
                          context,
                          colors,
                          height: Dimensions.h_33,
                          width: Dimensions.h_33,
                          radius: 8,
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.h_10),
                    _block(context, colors, height: Dimensions.h_13, width: Dimensions.w_140),
                    SizedBox(height: Dimensions.h_6),
                    _block(context, colors, height: Dimensions.h_10, width: Dimensions.w_110),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCards(
    BuildContext context,
    List<Color> colors, {
    required double itemWidth,
    required double itemHeight,
    required int itemCount,
  }) {
    return SizedBox(
      height: itemHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, __) => SizedBox(width: Dimensions.w_8),
        itemBuilder: (_, __) {
          return Container(
            width: itemWidth,
            padding: EdgeInsets.all(Dimensions.h_6),
            decoration: BoxDecoration(
              color: context.sports.card,
              borderRadius: BorderRadius.circular(Dimensions.h_8),
              border: Border.all(color: context.sports.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _block(context, colors, height: Dimensions.h_80, width: double.infinity, radius: Dimensions.h_8),
                SizedBox(height: Dimensions.h_8),
                _block(context, colors, height: Dimensions.h_12, width: itemWidth * 0.72),
                SizedBox(height: Dimensions.h_6),
                _block(context, colors, height: Dimensions.h_10, width: itemWidth * 0.52),
                SizedBox(height: Dimensions.h_6),
                _block(context, colors, height: Dimensions.h_8, width: itemWidth * 0.6),
                 const Spacer(),
                _block(context, colors, height: Dimensions.h_15, width: itemWidth * 0.5, radius: 6),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEventsCard(BuildContext context, List<Color> colors) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.h_10, bottom: Dimensions.h_5),
      decoration: BoxDecoration(
        color: context.sports.card,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: context.sports.border, width: 0.6),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
            child: _buildSectionHeader(context, colors),
          ),
          SizedBox(height: Dimensions.h_8),
          ...List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: index == 2 ? 0 : Dimensions.h_8),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
                    child: Row(
                      children: [
                        _block(context, colors, height: Dimensions.h_35, width: Dimensions.w_40, radius: 8),
                        SizedBox(width: Dimensions.w_10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _block(context, colors, height: Dimensions.h_12, width: Dimensions.w_90),
                              SizedBox(height: Dimensions.h_6),
                              _block(context, colors, height: Dimensions.h_10, width: double.infinity),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.w_10),
                        _block(context, colors, height: Dimensions.h_23, width: Dimensions.w_60, radius: 6),
                      ],
                    ),
                  ),
                  if (index != 2) ...[
                    SizedBox(height: Dimensions.h_8),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
                      color: context.sports.border,
                      height: 0.5,
                    ),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPartnerBanner(BuildContext context, List<Color> colors) {
    return SizedBox(
      height: Dimensions.h_110,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0B6030),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.h_10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _block(context, colors, height: Dimensions.h_10, width: Dimensions.w_110),
                    SizedBox(height: Dimensions.h_10),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _block(context, colors, height: Dimensions.h_55, width: Dimensions.h_55, radius: 10),
                          SizedBox(width: Dimensions.w_10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _block(context, colors, height: Dimensions.h_10, width: double.infinity),
                                SizedBox(height: Dimensions.h_6),
                                _block(context, colors, height: Dimensions.h_10, width: Dimensions.w_135),
                                SizedBox(height: Dimensions.h_10),
                                _block(context, colors, height: Dimensions.h_23, width: Dimensions.w_90, radius: 6),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              _block(context, colors, height: double.infinity, width: Dimensions.w_90, radius: 6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSponsorRow(BuildContext context, List<Color> colors) {
    return SizedBox(
      height: Dimensions.h_100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (_, __) => SizedBox(width: Dimensions.w_5),
        itemBuilder: (_, __) {
          return Container(
            width: Dimensions.w_100,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w_4,
              vertical: Dimensions.h_8,
            ),
            decoration: BoxDecoration(
              color: context.sports.card,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: context.sports.border),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: _block(context, colors, height: Dimensions.h_55, width: Dimensions.h_70, radius: 10),
                  ),
                ),
                SizedBox(height: Dimensions.h_8),
                _block(context, colors, height: Dimensions.h_10, width: Dimensions.w_60),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildVolunteerRow(BuildContext context, List<Color> colors) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(child: _buildVolunteerCard(context, colors)),
          SizedBox(width: Dimensions.w_6),
          Expanded(child: _buildVolunteerCard(context, colors, compact: true)),
        ],
      ),
    );
  }

  Widget _buildVolunteerCard(BuildContext context, List<Color> colors, {bool compact = false}) {
    return Container(
      padding: EdgeInsets.all(Dimensions.h_8),
      decoration: BoxDecoration(
        color: context.sports.card,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: context.sports.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _block(context, colors, height: Dimensions.h_33, width: Dimensions.h_33, radius: 10),
          SizedBox(width: Dimensions.w_8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _block(context, colors, height: Dimensions.h_12, width: Dimensions.w_110),
                SizedBox(height: Dimensions.h_6),
                _block(context, colors, height: Dimensions.h_10, width: double.infinity),
                SizedBox(height: Dimensions.h_6),
                if (!compact) _block(context, colors, height: Dimensions.h_10, width: Dimensions.w_80),
                if (!compact) SizedBox(height: Dimensions.h_10),
                if (compact) SizedBox(height: Dimensions.h_10),
                _block(context, colors, height: Dimensions.h_28, width: double.infinity, radius: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _block(
    BuildContext context,
    List<Color> colors, {
    required double height,
    required double width,
    double radius = 6,
    Color? fill,
  }) {
    return Shimmer.fromColors(
      baseColor: colors[0],
      highlightColor: colors[1],
      period: const Duration(milliseconds: 1500),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: fill ?? _placeholderFill(context),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  List<Color> _shimmerColors(BuildContext context) {
    final base = context.sports.card;
    final border = context.sports.border;
    return [
      Color.lerp(base, border, 0.55) ?? base,
      Color.lerp(base, Colors.white, 0.35) ?? base,
    ];
  }

  Color _placeholderFill(BuildContext context) {
    final card = context.sports.card;
    return Color.lerp(card, context.sports.border, 0.28) ?? card;
  }
}
