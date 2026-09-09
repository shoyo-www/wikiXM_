import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'common_appbar.dart';

class CommonScrollBlurScaffold extends StatefulWidget {
  const CommonScrollBlurScaffold({
    super.key,
    required this.hero,
    required this.slivers,
    this.expandedHeight = 280,
    this.blurDistance = 120,
    this.expandedColor = Colors.white,
    this.collapsedColor = Colors.black,
    this.backgroundColor,
    this.pinned = false,
    this.floating = false,
    this.stretch = true,
    this.physics,
    this.showBack = false,
    this.isDrawer = false,
    this.onTap
  });

  final Widget hero;
  final List<Widget> slivers;
  final bool showBack;
  final double expandedHeight;
  final double blurDistance;
  final bool isDrawer;
  final Color expandedColor;
  final Color collapsedColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool pinned;
  final bool floating;
  final bool stretch;

  final ScrollPhysics? physics;

  @override
  State<CommonScrollBlurScaffold> createState() =>
      _CommonScrollBlurScaffoldState();
}

class _CommonScrollBlurScaffoldState extends State<CommonScrollBlurScaffold> {
  late final ScrollController _scrollController;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_handleScroll);
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;
    final offset = _scrollController.offset;
    if ((_scrollOffset - offset).abs() < 1) {
      return;
    }
    setState(() {
      _scrollOffset = offset.clamp(0.0, double.infinity);
    });
  }

  double get _blurOpacity {
    if (widget.blurDistance <= 0) {
      return 1;
    }
    return (_scrollOffset / widget.blurDistance).clamp(0.0, 1.0);
  }

  Color get _foregroundColor {
    return Color.lerp(
      widget.expandedColor,
      widget.collapsedColor,
      _blurOpacity,
    )!;
  }

  @override
  void dispose() {
    _scrollController..removeListener(_handleScroll)..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: widget.expandedHeight,
                pinned: widget.pinned,
                floating: widget.floating,
                stretch: widget.stretch,
                automaticallyImplyLeading: false,
                backgroundColor: widget.backgroundColor,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  stretchModes: const [
                    StretchMode.zoomBackground,
                  ],
                  background: widget.hero,
                ),
              ),
              ...widget.slivers,
            ],
          ),
          Positioned(
            top: Platform.isAndroid ? -10 : -20,
            left: 0,
            right: 0,
            child: CommonBlurAppBar(
              blurOpacity: _blurOpacity,
              foregroundColor: _foregroundColor,
              showBackButton: widget.showBack,
              onTap: widget.onTap,
              isDrawer: widget.isDrawer,

            ),
          ),
        ],
      ),
    );
  }
}