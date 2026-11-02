import 'package:flutter/material.dart';

class AfterRouteTransition extends StatefulWidget {
  const AfterRouteTransition({super.key, required this.child, this.placeholder = const SizedBox.shrink()});

  final Widget child;
  final Widget placeholder;

  @override
  State<AfterRouteTransition> createState() => _AfterRouteTransitionState();
}

class _AfterRouteTransitionState extends State<AfterRouteTransition> {
  Animation<double>? _animation;
  bool _settled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_settled) return;
    final animation = ModalRoute.of(context)?.animation;
    if (animation == null || animation.status == AnimationStatus.completed) {
      _settled = true;
      return;
    }
    if (animation != _animation) {
      _animation?.removeStatusListener(_onStatus);
      _animation = animation..addStatusListener(_onStatus);
    }
  }

  void _onStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _animation?.removeStatusListener(_onStatus);
    _animation = null;
    if (mounted) setState(() => _settled = true);
  }

  @override
  void dispose() {
    _animation?.removeStatusListener(_onStatus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _settled ? widget.child : widget.placeholder;
}
