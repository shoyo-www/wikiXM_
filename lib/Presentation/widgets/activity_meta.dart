import 'package:flutter/material.dart';
import '../../constants/fontsize.dart';

class ActivityMeta extends StatelessWidget {
  final IconData icon;
  final String text;
  const ActivityMeta({super.key,required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: Dimensions.w_3),
        Icon(icon, size: Dimensions.h_11, color: Theme.of(context).highlightColor),
        SizedBox(width: Dimensions.w_4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: FontSize.sp_9_5, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
