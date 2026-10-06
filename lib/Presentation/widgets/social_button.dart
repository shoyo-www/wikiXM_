import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wikixm/constants/fontsize.dart';
import 'package:wikixm/constants/images.dart';

import '../../constants/appcolor.dart';

class SocialLoginButtons extends StatelessWidget {
  final bool isCreateAccount;

  const SocialLoginButtons({super.key, this.isCreateAccount = false});

  @override
  Widget build(BuildContext context) {
    if (isCreateAccount) {
      return Row(
        children: [
          Expanded(
            child: _socialButton(image: Images.google, text: "Google", onTap: () {}, isBox: true),
          ),
          SizedBox(width: Dimensions.w_5),
          Expanded(
            child: _socialButton(image: Images.apple, text: "Apple", onTap: () {}, isBox: true),
          ),
          SizedBox(width: Dimensions.w_5),
          Expanded(
            child: _socialButton(image: Images.facebook, text: "Facebook", onTap: () {}, isBox: true),
          ),
          SizedBox(width: Dimensions.w_5),
          Expanded(
            child: _socialButton(image: Images.twitter, text: "Twitter(X)", onTap: () {}, isBox: true),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialButton(image: Images.apple, text: "Apple", onTap: () {}, height: Dimensions.h_18, width: Dimensions.h_18, spacing: Dimensions.h_6),

        SizedBox(width: Dimensions.w_15),

        _socialButton(image: Images.google, text: "Google", onTap: () {}, height: Dimensions.h_18, width: Dimensions.h_18, spacing: Dimensions.h_6),

        SizedBox(width: Dimensions.w_15),

        _socialButton(image: Images.facebook, text: "Facebook", onTap: () {}),

        SizedBox(width: Dimensions.w_15),

        _socialButton(image: Images.twitter, text: "X (Twitter)", onTap: () {}),
      ],
    );
  }

  Widget _socialButton({String? image, required String text, required VoidCallback onTap, double? height, double? width, double? spacing, bool isBox = false}) {
    if (isBox) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: Dimensions.h_35,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.borderDivider, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image ?? '', width: Dimensions.h_13, height: Dimensions.h_13, fit: BoxFit.contain),
              SizedBox(width: Dimensions.w_5),
              Flexible(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w600, color: AppColor.textPrimary),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spacing ?? 5),
        decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
        child: Image.asset(image ?? '', width: width ?? Dimensions.h_22, height: height ?? Dimensions.h_22, fit: BoxFit.contain),
      ),
    );
  }
}
