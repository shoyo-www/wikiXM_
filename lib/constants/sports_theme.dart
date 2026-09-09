import 'package:flutter/material.dart';
import 'appcolor.dart';

class SportsTheme extends ThemeExtension<SportsTheme> {
  final Color background;
  final Color card;
  final Color border;
  final Color activeBorder;
  final Color primaryText;
  final Color secondaryText;
  final Color accent;
  final Color cardActiveBackground;

  const SportsTheme({
    required this.background,
    required this.card,
    required this.border,
    required this.activeBorder,
    required this.primaryText,
    required this.secondaryText,
    required this.accent,
    required this.cardActiveBackground,
  });

  static const light = SportsTheme(
    background: AppColor.white,
    card: AppColor.sportsLightCard,
    border: AppColor.sportsLightBorder,
    activeBorder: AppColor.sportsBorder,
    primaryText: AppColor.darkGreenSportsSecondaryText,
    secondaryText: AppColor.sportsLightSecondaryText,
    accent: AppColor.sportsBorder,
    cardActiveBackground: AppColor.sportsActiveCard,
  );

  static const dark = SportsTheme(
    background: AppColor.darkGreenSportsBackground,
    card: AppColor.darkGreenSportsCard,
    border: AppColor.darkGreenSportsBorder,
    activeBorder: AppColor.sportsDarkBorder,
    primaryText: AppColor.darkGreenSportsPrimaryText,
    secondaryText: AppColor.darkGreenSportsSecondaryText,
    accent: AppColor.sportsDarkBorder,
    cardActiveBackground: AppColor.darkGreenSportsCard,
  );

  @override
  SportsTheme copyWith({
    Color? background,
    Color? card,
    Color? border,
    Color? activeBorder,
    Color? primaryText,
    Color? secondaryText,
    Color? accent,
    Color? cardActiveBackground,
  }) {
    return SportsTheme(
      background: background ?? this.background,
      card: card ?? this.card,
      border: border ?? this.border,
      activeBorder: activeBorder ?? this.activeBorder,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      accent: accent ?? this.accent,
      cardActiveBackground:
      cardActiveBackground ?? this.cardActiveBackground,
    );
  }

  @override
  SportsTheme lerp(
      ThemeExtension<SportsTheme>? other,
      double t,
      ) {
    if (other is! SportsTheme) {
      return this;
    }

    return SportsTheme(
      background: Color.lerp(
        background,
        other.background,
        t,
      )!,
      card: Color.lerp(
        card,
        other.card,
        t,
      )!,
      border: Color.lerp(
        border,
        other.border,
        t,
      )!,
      activeBorder: Color.lerp(
        activeBorder,
        other.activeBorder,
        t,
      )!,
      primaryText: Color.lerp(
        primaryText,
        other.primaryText,
        t,
      )!,
      secondaryText: Color.lerp(
        secondaryText,
        other.secondaryText,
        t,
      )!,
      accent: Color.lerp(
        accent,
        other.accent,
        t,
      )!,
      cardActiveBackground: Color.lerp(
        cardActiveBackground,
        other.cardActiveBackground,
        t,
      )!,
    );
  }
}