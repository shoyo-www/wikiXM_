import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/constants/fontsize.dart';
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
    this.onTap,
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
  State<CommonScrollBlurScaffold> createState() => _CommonScrollBlurScaffoldState();
}

class _CommonScrollBlurScaffoldState extends State<CommonScrollBlurScaffold> {
  late final ScrollController _scrollController;
  double _scrollOffset = 0;
  bool _appBarHidden = false;

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
    // iOS bounce past either end reverses direction on its own; don't let it flick the bar
    final inRange = offset >= 0 && offset <= _scrollController.position.maxScrollExtent;
    final hidden = inRange ? offset > _scrollOffset && offset > Dimensions.h_50 : _appBarHidden;
    final next = offset.clamp(0.0, double.infinity);
    final changed = hidden != _appBarHidden || _blurFor(next) != _blurOpacity;
    _scrollOffset = next;
    // past the blur distance nothing on screen changes per pixel, so skip rebuilding the page every frame
    if (changed) setState(() => _appBarHidden = hidden);
  }

  double _blurFor(double offset) {
    if (widget.blurDistance <= 0) {
      return 1;
    }
    return (offset / widget.blurDistance).clamp(0.0, 1.0);
  }

  double get _blurOpacity => _blurFor(_scrollOffset);

  Color get _foregroundColor {
    return Color.lerp(widget.expandedColor, widget.collapsedColor, _blurOpacity)!;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
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
                flexibleSpace: FlexibleSpaceBar(collapseMode: CollapseMode.parallax, stretchModes: const [StretchMode.zoomBackground], background: widget.hero),
              ),
              ...widget.slivers,
            ],
          ),
          Positioned(
            top: Platform.isAndroid ? -Dimensions.h_15 : -20,
            left: 0,
            right: 0,
            // a faded-out bar would still catch taps meant for the content under it
            child: IgnorePointer(
              ignoring: _appBarHidden,
              child: AnimatedOpacity(
                opacity: _appBarHidden ? 0 : 1,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                child: CommonBlurAppBar(blurOpacity: _blurOpacity, foregroundColor: _foregroundColor, showBackButton: widget.showBack, onTap: widget.onTap, isDrawer: widget.isDrawer),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
