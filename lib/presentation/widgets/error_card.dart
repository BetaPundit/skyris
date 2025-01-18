import 'package:flutter/material.dart';
import 'package:skyris/config/themes/extensions/app_color_scheme.dart';
import 'package:skyris/config/themes/extensions/app_text_style.dart';
import 'package:skyris/utils/extensions/app_theme_extension.dart';

class ErrorCard extends StatelessWidget {
  final String errorMessage;
  final Function()? onRetry;

  const ErrorCard({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = context.themeData.extension<AppTextStyle>()!;
    final colorScheme = context.themeData.extension<AppColorScheme>()!;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.orange[900],
            size: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Error',
                  style: textStyle.titleSmall.copyWith(
                    color: Colors.orange[900],
                  ),
                ),
                Text(
                  errorMessage,
                  style: textStyle.bodyMedium.copyWith(
                    color: colorScheme.text,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                onRetry?.call();
              },
              child: Text(
                'Retry',
                style: textStyle.labelMedium.copyWith(
                  color: Colors.deepPurple[600],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
