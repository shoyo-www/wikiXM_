import 'package:flutter/material.dart';
import '../../constants/fontsize.dart';

/// Endlessly scrolls [items] from right to left, one after another, like a news ticker.
class Marquee extends StatefulWidget {
  final List<Widget> items;
  // space after each item, in logical pixels
  final double? gap;
  // logical pixels per second
  final double speed;
  const Marquee({super.key, required this.items, this.gap, this.speed = 25});

  @override
  State<Marquee> createState() => _MarqueeState();
}

// the scroll position is pure view state, so the widget drives it itself instead of a controller
class _MarqueeState extends State<Marquee> {
  final scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => run());
  }

  Future<void> run() async {
    while (mounted && scroll.hasClients) {
      await scroll.animateTo(scroll.offset + widget.speed * 8, duration: const Duration(seconds: 8), curve: Curves.linear);
    }
  }

  @override
  void dispose() {
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ListView.builder(
        controller: scroll,
        // null count makes the list endless, so the items repeat forever
        itemCount: widget.items.isEmpty ? 0 : null,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => Padding(
          padding: EdgeInsets.only(right: widget.gap ?? Dimensions.w_30),
          child: widget.items[i % widget.items.length],
        ),
      ),
    );
  }
}
