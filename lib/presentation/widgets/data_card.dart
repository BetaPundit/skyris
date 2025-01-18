import 'package:flutter/material.dart';
import 'package:skyris/config/themes/extensions/app_color_scheme.dart';
import 'package:skyris/config/themes/extensions/app_text_style.dart';
import 'package:skyris/utils/extensions/app_theme_extension.dart';

class DataCard extends StatelessWidget {
  final Widget icon;
  final String heading;
  final String content;
  final Widget? customChild;

  const DataCard({
    super.key,
    required this.icon,
    required this.heading,
    required this.content,
    this.customChild,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.themeData.extension<AppColorScheme>()!;
    final textStyle = context.themeData.extension<AppTextStyle>()!;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF5395FD).withValues(alpha: .8),
            Color(0xFFB086FC).withValues(alpha: .8),
          ],
        ),
      ),
      child: customChild ??
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                Text(
                  heading,
                  style: textStyle.bodyMedium,
                ),
                Text(
                  content,
                  style: textStyle.labelLarge.copyWith(height: 1),
                ),
              ],
            ),
          ),
    );
  }
}
