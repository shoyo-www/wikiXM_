import 'package:flutter/material.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/fontsize.dart';
import 'common_button.dart';

/// Empty list placeholder: icon, title, message and up to a few actions (first one is primary).
class CommonEmptyView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final List<({String title, IconData? icon, VoidCallback onTap})> actions;

  const CommonEmptyView({super.key, required this.icon, required this.title, this.message, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_20, vertical: Dimensions.h_20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(Dimensions.h_10),
            decoration: BoxDecoration(color: AppColor.blueSoft(context), shape: BoxShape.circle),
            child: Icon(icon, size: Dimensions.h_20, color: AppColor.blue(context)),
          ),
          SizedBox(height: Dimensions.h_12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.ink(context), fontSize: FontSize.sp_16, fontWeight: FontWeight.w700),
          ),
          if (message != null) ...[
            SizedBox(height: Dimensions.h_5),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_13, height: 1.35),
            ),
          ],
          if (actions.isNotEmpty) ...[
            SizedBox(height: Dimensions.h_15),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: Dimensions.w_8,
              runSpacing: Dimensions.h_8,
              children: [for (final (i, a) in actions.indexed) i == 0 ? CommonButton(title: a.title, icon: a.icon, onTap: a.onTap) : CommonButton(title: a.title, icon: a.icon, onTap: a.onTap, color: AppColor.transparent, textColor: AppColor.blue(context), borderColor: AppColor.blue(context))],
            ),
          ],
        ],
      ),
    );
  }
}
