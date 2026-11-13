import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/constants/fontsize.dart';
import 'common_appbar.dart';

class CommonBlurScaffold extends StatefulWidget {
  const CommonBlurScaffold({super.key, required this.child, this.heroHeight = 280, this.blurDistance = 120, this.expandedColor = Colors.white, this.collapsedColor = Colors.black, this.backgroundColor, this.physics, this.showBack = false, this.isDrawer = false, this.onTap, this.appBarChild, this.scrollController, this.bottomNavigationBar});

  final Widget? bottomNavigationBar;
  final Widget child;
  final bool showBack;
  final double heroHeight;
  final double blurDistance;
  final bool isDrawer;
  final Color expandedColor;
  final Color collapsedColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final Widget? appBarChild;
  final ScrollPhysics? physics;

  final ScrollController? scrollController;

  @override
  State<CommonBlurScaffold> createState() => _CommonBlurScaffoldState();
}

class _CommonBlurScaffoldState extends State<CommonBlurScaffold> {
  late final ScrollController _scrollController;
  double _scrollOffset = 0;
  bool _appBarHidden = false;

  bool get _isExternalController => widget.scrollController != null;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;
    final offset = _scrollController.offset;
    if ((_scrollOffset - offset).abs() < 1) {
      return;
    }

    final inRange = offset >= 0 && offset <= _scrollController.position.maxScrollExtent;
    // near the top the bar always shows, even when the page got there without a scroll (e.g. content shrank on a tab switch)
    final hidden = offset > Dimensions.h_50 && (inRange ? offset > _scrollOffset : _appBarHidden);
    final next = offset.clamp(0.0, double.infinity);
    final changed = hidden != _appBarHidden || _blurFor(next) != _blurOpacity;
    _scrollOffset = next;
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
    _scrollController.removeListener(_handleScroll);

    if (!_isExternalController) {
      _scrollController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      backgroundColor: widget.backgroundColor,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: Stack(
        children: [
          Positioned.fill(
            // shrinking content moves the offset without telling scroll listeners, so re-check on size changes too
            child: NotificationListener<ScrollMetricsNotification>(
              onNotification: (_) {
                _handleScroll();
                return false;
              },
              child: SingleChildScrollView(controller: _scrollController, physics: widget.physics ?? const AlwaysScrollableScrollPhysics(), child: widget.child),
            ),
          ),
          Positioned(
            top: Platform.isAndroid ? -10 : -20,
            left: 0,
            right: 0,
            child: IgnorePointer(
              ignoring: _appBarHidden,
              child: AnimatedOpacity(
                opacity: _appBarHidden ? 0 : 1,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                child: CommonBlurAppBar(blurOpacity: _blurOpacity, foregroundColor: _foregroundColor, showBackButton: widget.showBack, onTap: widget.onTap, isDrawer: widget.isDrawer, child: widget.appBarChild),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
