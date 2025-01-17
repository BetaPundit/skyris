import 'package:flutter/material.dart';
import 'package:skyris/config/themes/app_colors.dart';

@immutable
class AppTextStyle extends ThemeExtension<AppTextStyle> {
  // Fields
  /// For default text styles refer: https://api.flutter.dev/flutter/material/TextTheme-class.html

  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;

  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;

  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  // Constructor
  const AppTextStyle({
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
  });

  @override
  AppTextStyle copyWith({
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? headline4,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? pageTitle,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
  }) {
    return AppTextStyle(
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
    );
  }

  // Controls how it displays when the instance is being passed
  // to the `print()` method.
  @override
  String toString() => 'TextStyle('
      'headlineLarge: $headlineLarge, headlineMedium: $headlineMedium, headlineSmall: $headlineSmall, bodyLarge: $bodyLarge, bodyMedium: $bodyMedium, bodySmall: $bodySmall, labelLarge: $labelLarge, labelMedium: $labelMedium, labelSmall: $labelSmall, titleLarge: $titleLarge, titleMedium: $titleMedium, titleSmall: $titleSmall'
      ')';

  static const _defaultFontFamily = 'Gilroy';

  static const _headlineLarge = TextStyle(
    fontFamily: _defaultFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 30.0,
    color: Colors.black,
  );

  static const _headlineMedium = TextStyle(
    fontFamily: _defaultFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 28.0,
    color: Colors.black,
  );

  static const _headlineSmall = TextStyle(
    fontFamily: _defaultFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 26.0,
    color: Colors.black,
  );

  static const _titleLarge = TextStyle(
    fontFamily: _defaultFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24.0,
    color: Colors.black,
  );

  static const _titleMedium = TextStyle(
    fontFamily: _defaultFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
    color: Colors.black,
  );

  static const _titleSmall = TextStyle(
    fontFamily: _defaultFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18.0,
    color: Colors.black,
  );

  static const _bodyLarge = TextStyle(
    fontFamily: _defaultFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: Colors.black,
  );

  static const _bodyMedium = TextStyle(
    fontFamily: _defaultFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.black,
  );

  static const _bodySmall = TextStyle(
    fontFamily: _defaultFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Colors.black,
  );

  static const _labelLarge = TextStyle(
    fontFamily: _defaultFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: Colors.black,
  );

  static const _labelMedium = TextStyle(
    fontFamily: _defaultFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    color: Colors.black,
  );

  static const _labelSmall = TextStyle(
    fontFamily: _defaultFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
    color: Colors.black,
  );

  // the light theme
  static AppTextStyle light = AppTextStyle(
    headlineLarge: _headlineLarge.copyWith(color: AppColors.lightText),
    headlineMedium: _headlineMedium.copyWith(color: AppColors.lightText),
    headlineSmall: _headlineSmall.copyWith(color: AppColors.lightText),
    titleLarge: _titleLarge.copyWith(color: AppColors.lightText),
    titleMedium: _titleMedium.copyWith(color: AppColors.lightText),
    titleSmall: _titleSmall.copyWith(color: AppColors.lightText),
    bodyLarge: _bodyLarge.copyWith(color: AppColors.lightText),
    bodyMedium: _bodyMedium.copyWith(color: AppColors.lightText),
    bodySmall: _bodySmall.copyWith(color: AppColors.lightText),
    labelLarge: _labelLarge.copyWith(color: AppColors.lightText),
    labelMedium: _labelMedium.copyWith(color: AppColors.lightText),
    labelSmall: _labelSmall.copyWith(color: AppColors.lightText),
  );

  // the dark theme
  static AppTextStyle dark = light.copyWith(
    headlineLarge: _headlineLarge.copyWith(color: AppColors.text),
    headlineMedium: _headlineMedium.copyWith(color: AppColors.text),
    headlineSmall: _headlineSmall.copyWith(color: AppColors.text),
    titleLarge: _titleLarge.copyWith(color: AppColors.text),
    titleMedium: _titleMedium.copyWith(color: AppColors.text),
    titleSmall: _titleSmall.copyWith(color: AppColors.text),
    labelLarge: _labelLarge.copyWith(color: AppColors.text),
    labelMedium: _labelMedium.copyWith(color: AppColors.text),
    labelSmall: _labelSmall.copyWith(color: AppColors.text),
    bodyLarge: _bodyLarge.copyWith(color: AppColors.text),
    bodyMedium: _bodyMedium.copyWith(color: AppColors.text),
    bodySmall: _bodySmall.copyWith(color: AppColors.text),
  );

  @override
  ThemeExtension<AppTextStyle> lerp(
      ThemeExtension<AppTextStyle>? other, double t) {
    if (other is! AppTextStyle) {
      return this;
    }
    return AppTextStyle(
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
    );
  }
}
