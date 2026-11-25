import 'package:flutter/material.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import 'common_button.dart';

class CommonErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;

  const CommonErrorView({super.key, this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_20, vertical: Dimensions.h_20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline_rounded, size: Dimensions.h_35, color: AppColor.red(context)),
          SizedBox(height: Dimensions.h_10),
          Text(
            'Something went wrong',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.ink(context), fontSize: FontSize.sp_16, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: Dimensions.h_5),
          Text(
            message ?? Constants.someThingWentWrong,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_13),
          ),
          SizedBox(height: Dimensions.h_15),
          CommonButton(title: 'Try again', icon: Icons.refresh_rounded, onTap: onRetry),
        ],
      ),
    );
  }
}
