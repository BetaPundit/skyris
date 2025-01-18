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
    final isLandscape = MediaQuery.orientationOf(context) == Orientation.landscape;

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
            padding: EdgeInsets.symmetric(
              horizontal: isLandscape ? 10 : 14,
              vertical: isLandscape ? 16 : 26,
            ),
            child: isLandscape
                ? Row(
                    children: [
                      icon,
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 4,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              heading,
                              style: textStyle.bodyMedium.copyWith(fontSize: 13),
                            ),
                            Text(
                              content,
                              style: textStyle.labelLarge.copyWith(
                                height: 1,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
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
