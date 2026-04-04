import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

enum AppTextVariant { headline, title, body, label, caption }

class AppText extends StatelessWidget {
  final String text;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;

  const AppText({
    Key? key,
    required this.text,
    this.variant = AppTextVariant.body,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = _getTextStyle();

    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle _getTextStyle() {
    TextStyle baseStyle;

    switch (variant) {
      case AppTextVariant.headline:
        baseStyle = AppTypography.headline3;
        break;
      case AppTextVariant.title:
        baseStyle = AppTypography.titleMedium;
        break;
      case AppTextVariant.body:
        baseStyle = AppTypography.bodyLarge;
        break;
      case AppTextVariant.label:
        baseStyle = AppTypography.labelLarge;
        break;
      case AppTextVariant.caption:
        baseStyle = AppTypography.caption;
        break;
    }

    return baseStyle.copyWith(
      color: color ?? AppColors.onSurface,
      fontWeight: fontWeight,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
    );
  }
}
