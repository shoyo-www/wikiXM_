import 'dart:async';
import 'package:flutter/material.dart';
import '../../constants/fontsize.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({super.key, required this.days, required this.hours, required this.minutes, required this.seconds, this.textColor = Colors.white});

  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final Color textColor;

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _remaining = Duration(days: widget.days, hours: widget.hours, minutes: widget.minutes, seconds: widget.seconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      setState(() {
        if (_remaining.inSeconds > 0) {
          _remaining -= const Duration(seconds: 1);
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void didUpdateWidget(covariant CountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.days != widget.days || oldWidget.hours != widget.hours || oldWidget.minutes != widget.minutes || oldWidget.seconds != widget.seconds) {
      _remaining = Duration(days: widget.days, hours: widget.hours, minutes: widget.minutes, seconds: widget.seconds);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours.remainder(24);
    final minutes = _remaining.inMinutes.remainder(60);
    final seconds = _remaining.inSeconds.remainder(60);

    return Row(mainAxisSize: MainAxisSize.min, children: [_item(days, "DAYS"), _separator(), _item(hours, "HRS"), _separator(), _item(minutes, "MIN"), _separator(), _item(seconds, "SEC")]);
  }

  Widget _separator() => Padding(
    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7),
    child: Text(
      ":",
      style: TextStyle(color: widget.textColor, fontSize: FontSize.sp_22, fontWeight: FontWeight.w900),
    ),
  );

  Widget _item(int value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: TextStyle(color: widget.textColor, fontSize: FontSize.sp_24, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(color: widget.textColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
