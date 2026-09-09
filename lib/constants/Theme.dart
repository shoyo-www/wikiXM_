import 'package:flutter/material.dart';
import 'package:wikixm/constants/sports_theme.dart';
import 'appcolor.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
      fontFamily: 'Inter',
      bodyColor: AppColor.primaryInk,
      displayColor: AppColor.wikiXMNavy,
    ),
    primaryTextTheme: ThemeData.light().primaryTextTheme.apply(
      fontFamily: 'Inter',
      bodyColor: AppColor.primaryInk,
      displayColor: AppColor.wikiXMNavy,
    ),
    primaryColor: AppColor.primaryNavyNew,
    primaryColorDark: AppColor.darkBlue,
    scaffoldBackgroundColor: AppColor.softBackground,
    canvasColor: AppColor.intelligencePurple,
    cardColor: AppColor.white,
    highlightColor: AppColor.black,
    splashColor: AppColor.white,
    hoverColor: AppColor.headingColor,
    focusColor: AppColor.borderDivider,
    disabledColor: AppColor.borderGray,
    hintColor: AppColor.mutedGrayLight,
    indicatorColor: AppColor.communityGreen,
    shadowColor: AppColor.black.withValues(alpha: 0.08),
    colorScheme: const ColorScheme.light(
      primary: AppColor.communityGreen,
      secondary: AppColor.civicBlue,
      surface: AppColor.white,
      error: AppColor.alertRed,
      onPrimary: AppColor.white,
      onSecondary: AppColor.white,
      onSurface: AppColor.primaryInk,
      onError: AppColor.white,
    ),
    extensions: const [
      SportsTheme.light,
    ],
  );

  static final darkTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: 'Inter',
      bodyColor: AppColor.white,
      displayColor: AppColor.white,
    ),
    primaryTextTheme: ThemeData.dark().primaryTextTheme.apply(
      fontFamily: 'Inter',
      bodyColor: AppColor.white,
      displayColor: AppColor.white,
    ),
    primaryColor: AppColor.white,
    primaryColorDark: AppColor.white,
    scaffoldBackgroundColor: AppColor.backgroundDark,
    canvasColor: AppColor.white,
    cardColor: AppColor.darkCardColor,
    highlightColor: AppColor.white,
    splashColor: AppColor.backgroundDark,
    hoverColor: AppColor.white,
    focusColor: AppColor.darkBorderColor,
    disabledColor: AppColor.slate,
    hintColor: AppColor.mutedGray,
    indicatorColor: AppColor.communityGreen,
    shadowColor: AppColor.black,
    colorScheme: const ColorScheme.dark(
      primary: AppColor.white,
      secondary: AppColor.civicBlue,
      surface: AppColor.primaryInk,
      error: AppColor.alertRed,
      onPrimary: AppColor.white,
      onSecondary: AppColor.white,
      onSurface: AppColor.white,
      onError: AppColor.white,
    ),
    extensions: const [
      SportsTheme.dark,
    ],
  );
}