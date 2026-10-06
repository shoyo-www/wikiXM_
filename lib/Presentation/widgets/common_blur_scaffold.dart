import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'common_appbar.dart';

class CommonBlurScaffold extends StatefulWidget {
  const CommonBlurScaffold({
    super.key,
    required this.child,
    this.heroHeight = 280,
    this.blurDistance = 120,
    this.expandedColor = Colors.white,
    this.collapsedColor = Colors.black,
    this.backgroundColor,
    this.physics,
    this.showBack = false,
    this.isDrawer = false,
    this.onTap,
    this.appBarchild,
    this.scrollController,
  });

  final Widget child;
  final bool showBack;
  final double heroHeight;
  final double blurDistance;
  final bool isDrawer;
  final Color expandedColor;
  final Color collapsedColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final Widget? appBarchild;
  final ScrollPhysics? physics;

  final ScrollController? scrollController;

  @override
  State<CommonBlurScaffold> createState() => _CommonBlurScaffoldState();
}

class _CommonBlurScaffoldState extends State<CommonBlurScaffold> {
  late final ScrollController _scrollController;
  double _scrollOffset = 0;

  bool get _isExternalController =>
      widget.scrollController != null;

  @override
  void initState() {
    super.initState();

    _scrollController =
        widget.scrollController ?? ScrollController();

    _scrollController.addListener(_handleScroll);
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

    return (_scrollOffset / widget.blurDistance)
        .clamp(0.0, 1.0);
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
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: widget.physics ??
                const AlwaysScrollableScrollPhysics(),
            child: widget.child,
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
              child: widget.appBarchild,
            ),
          ),
        ],
      ),
    );
  }
}
