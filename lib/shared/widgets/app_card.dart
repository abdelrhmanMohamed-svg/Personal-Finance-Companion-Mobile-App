import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? elevation;
  final bool center;

  const AppCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.elevation,
    this.center = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget content = child;
    if (center) {
      content = Center(child: child);
    }

    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: 8.h),
      child: Material(
        color: backgroundColor ?? theme.cardTheme.color,
        elevation: elevation ?? 0,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: padding ?? EdgeInsets.all(16.w),
            child: content,
          ),
        ),
      ),
    );
  }
}
