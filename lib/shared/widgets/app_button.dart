import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppButtonVariant { primary, secondary, outlined, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  const AppButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final buttonStyle = _getButtonStyle(theme, colors);
    final textStyle = _getTextStyle(theme);
    final iconSize = 20.w;

    Widget buttonContent = isLoading
        ? SizedBox(
            height: iconSize,
            width: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == AppButtonVariant.primary
                    ? Colors.white
                    : colors.primary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: iconSize),
                SizedBox(width: 8.w),
              ],
              Text(text, style: textStyle),
            ],
          );

    Widget button;
    switch (variant) {
      case AppButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: buttonContent,
        );
        break;
      case AppButtonVariant.secondary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle.copyWith(
            backgroundColor: WidgetStatePropertyAll<Color>(colors.secondary),
          ),
          child: buttonContent,
        );
        break;
      case AppButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: buttonContent,
        );
        break;
      case AppButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: buttonContent,
        );
        break;
    }

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }

  ButtonStyle _getButtonStyle(ThemeData theme, ColorScheme colors) {
    return ButtonStyle(
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  TextStyle _getTextStyle(ThemeData theme) {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    );
  }
}
