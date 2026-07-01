import 'package:flutter/material.dart';
import 'appcolor.dart';

class AppTheme {
  final lightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Merriweather'),
    primaryTextTheme:
        ThemeData.light().primaryTextTheme.apply(fontFamily: 'Merriweather'),
    primaryColor: AppColor.appColor,
    // backgroundColor: AppColor.lightBackground,
    highlightColor: AppColor.black,
    canvasColor: AppColor.white,
    shadowColor: AppColor.textColor,
    scaffoldBackgroundColor: AppColor.white,
    cardColor: AppColor.lightCardColor,
    disabledColor: AppColor.lightCardColor,
    hoverColor: AppColor.lightCardColor,
    focusColor: AppColor.black,
    splashColor: AppColor.white,
    hintColor: AppColor.white,
    indicatorColor: AppColor.white,
    primaryColorDark: AppColor.white,
  );

  final darkTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Merriweather'),
    primaryTextTheme:
        ThemeData.dark().primaryTextTheme.apply(fontFamily: 'Merriweather'),
    primaryColor: AppColor.appColor,
    // backgroundColor: AppColor.darkCardColor,
    highlightColor: AppColor.white,
    canvasColor: AppColor.white,
    shadowColor: AppColor.textColor,
    scaffoldBackgroundColor: AppColor.darkScaffold,
    cardColor: AppColor.darkCardColor,
    disabledColor: AppColor.containerDark,
    hoverColor: AppColor.darkScaffold,
    focusColor: AppColor.white,
    splashColor: AppColor.black,
    hintColor: AppColor.darkCardColor,
    indicatorColor: AppColor.textField,
    primaryColorDark: AppColor.user
  );
}
