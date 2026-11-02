import 'dart:math';

import 'package:flutter/material.dart';


class EntranceAnimation extends StatefulWidget {
  const EntranceAnimation({super.key, required this.child, this.index = 0});

  final Widget child;
  final int index;

  @override
  State<EntranceAnimation> createState() => _EntranceAnimationState();
}

class _EntranceAnimationState extends State<EntranceAnimation> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  late final Animation<double> _curve = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 150 * min(widget.index, 6)), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: _curve,
      builder: (context, child) => Opacity(
        opacity: _curve.value,
        child: Transform.translate(offset: Offset(0, 24 * (1 - _curve.value)), child: child),
      ),
      child: widget.child,
    );
  }
}

List<Widget> staggered(List<Widget> children, {int start = 0}) {
  var index = start;
  return [for (final child in children) child is SizedBox && child.child == null ? child : EntranceAnimation(index: index++, child: child)];
}

List<Widget> entranceList(List<Widget> children, {int stagger = 4}) => [for (final (i, child) in children.indexed) EntranceAnimation(index: i < stagger ? i : 0, child: child)];
