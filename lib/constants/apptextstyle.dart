import 'package:flutter/material.dart';
import 'appcolor.dart';
import 'fontsize.dart';

class AppTextStyle {
  static TextStyle normalTextStyle(double fontSize, Color textColor) {
    return TextStyle(
        fontFamily: 'Merriweather',
        fontSize: fontSize,
        color: textColor,
        fontWeight: FontWeight.normal
    );
  }

  static TextStyle themeBoldTextStyle({double? fontSize ,Color? color}) {
    return TextStyle(
        fontFamily: 'Merriweather',
        fontSize: fontSize ?? FontSize.sp_24,
        color: color ?? Colors.black,
        fontWeight: FontWeight.bold
    );

  }
  static TextStyle themeBoldNormalTextStyle({double? fontSize ,Color? color}) {
    return  TextStyle(
        fontFamily: 'Merriweather',
        fontSize: fontSize ?? FontSize.sp_24,
        color: color ?? Colors.black,
        fontWeight: FontWeight.w500
    );


  }
  static TextStyle buttonTextStyle({Color? color}) =>  TextStyle(
      fontFamily: 'Merriweather',
      fontSize: FontSize.sp_16,
      color: color ?? AppColor.white,
      fontWeight: FontWeight.w600
  );

  static TextStyle bodyMediumTextStyle({Color? color}) =>  TextStyle(
      fontFamily: 'Merriweather',
      fontSize: FontSize.sp_13,
      color: color ?? Colors.black,
      fontWeight: FontWeight.w500
  );
}
