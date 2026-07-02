import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wikixm/constants/fontsize.dart';
import 'package:wikixm/constants/images.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _socialButton(
            image: Images.apple,
            text: "Apple",
            onTap: () {},
          ),
        ),
         SizedBox(width: Dimensions.w_6),
        Expanded(
          child: _socialButton(
            image: Images.google,
            text: "Google",
            onTap: () {},
          ),
        ),
        SizedBox(width: Dimensions.w_6),
        Expanded(
          child: _socialButton(
            image: Images.facebook,
            text: "Facebook",
            onTap: () {},
          ),
        ),
        SizedBox(width: Dimensions.w_6),
        Expanded(
          child: _socialButton(
            image: Images.twitter,
            text: "X (Twitter)",
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _socialButton({
    String? image,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h_4,horizontal: Dimensions.w_2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.grey,
            width: 0.5
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              Image.asset(
                image,
                width: Dimensions.h_12,
                height: Dimensions.h_12,
              ),
             SizedBox(width: Dimensions.w_4),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style:  TextStyle(
                  fontSize: FontSize.sp_9,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}