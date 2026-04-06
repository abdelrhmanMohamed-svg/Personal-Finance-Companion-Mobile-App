import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/animation_utils.dart';

enum AppButtonVariant { primary, secondary, outlined, text }

class AppButton extends StatefulWidget {
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
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown() {
    final shouldReduceMotion = AnimationUtils.reduceMotionEnabled(context);
    if (!shouldReduceMotion && widget.onPressed != null && !widget.isLoading) {
      _controller.forward();
    }
  }

  void _onTapUp() {
    final shouldReduceMotion = AnimationUtils.reduceMotionEnabled(context);
    if (!shouldReduceMotion) {
      _controller.reverse();
    }
  }

  void _onTapCancel() {
    final shouldReduceMotion = AnimationUtils.reduceMotionEnabled(context);
    if (!shouldReduceMotion) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final shouldReduceMotion = AnimationUtils.reduceMotionEnabled(context);

    final buttonStyle = _getButtonStyle(theme, colors);
    final textStyle = _getTextStyle(theme);
    final iconSize = 20.w;

    Widget buttonContent = widget.isLoading
        ? SizedBox(
            height: iconSize,
            width: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.variant == AppButtonVariant.primary
                    ? Colors.white
                    : colors.primary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: iconSize),
                SizedBox(width: 8.w),
              ],
              Text(widget.text, style: textStyle),
            ],
          );

    Widget button;
    switch (widget.variant) {
      case AppButtonVariant.primary:
        button = ElevatedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: buttonStyle,
          child: buttonContent,
        );
        break;
      case AppButtonVariant.secondary:
        button = ElevatedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: buttonStyle.copyWith(
            backgroundColor: WidgetStatePropertyAll<Color>(colors.secondary),
          ),
          child: buttonContent,
        );
        break;
      case AppButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: buttonStyle,
          child: buttonContent,
        );
        break;
      case AppButtonVariant.text:
        button = TextButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: buttonStyle,
          child: buttonContent,
        );
        break;
    }

    Widget animatedButton = GestureDetector(
      onTapDown: (_) => _onTapDown(),
      onTapUp: (_) {
        _onTapUp();
        widget.onPressed?.call();
      },
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: shouldReduceMotion ? 1.0 : _scaleAnimation.value,
            child: button,
          );
        },
      ),
    );

    if (widget.isFullWidth) {
      return SizedBox(width: double.infinity, child: animatedButton);
    }

    return animatedButton;
  }

  ButtonStyle _getButtonStyle(ThemeData theme, ColorScheme colors) {
    return ButtonStyle(
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }

  TextStyle _getTextStyle(ThemeData theme) {
    return TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500);
  }
}
