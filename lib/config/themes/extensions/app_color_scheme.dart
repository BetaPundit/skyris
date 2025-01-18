import 'package:flutter/material.dart';
import 'package:skyris/config/themes/app_colors.dart';

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  final Color background;
  final Color surface;
  final Color text;
  final Color primary;

  const AppColorScheme({
    required this.background,
    required this.surface,
    required this.text,
    required this.primary,
  });

  static const light = AppColorScheme(
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    text: AppColors.lightText,
    primary: AppColors.primaryLight,
  );

  static const dark = AppColorScheme(
    background: AppColors.background,
    surface: AppColors.surface,
    text: AppColors.text,
    primary: AppColors.primary,
  );

  @override
  ThemeExtension<AppColorScheme> copyWith({
    Color? background,
    Color? surface,
    Color? text,
    Color? primary,
  }) {
    return AppColorScheme(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      text: text ?? this.text,
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<AppColorScheme> lerp(
    covariant ThemeExtension<AppColorScheme>? other,
    double t,
  ) {
    if (other is! AppColorScheme) {
      return this;
    }
    return AppColorScheme(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      text: Color.lerp(text, other.text, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
    );
  }
}
