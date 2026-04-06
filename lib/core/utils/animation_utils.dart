import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnimationUtils {
  static bool shouldAnimate(BuildContext context) {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness != Brightness.dark;
  }

  static bool reduceMotionEnabled(BuildContext context) {
    final mediaQuery = MediaQuery.maybeOf(context);
    if (mediaQuery != null) {
      return mediaQuery.disableAnimations;
    }
    return false;
  }

  static Duration get shortDuration => const Duration(milliseconds: 200);
  static Duration get mediumDuration => const Duration(milliseconds: 300);
  static Duration get longDuration => const Duration(milliseconds: 500);

  static Curve get defaultCurve => Curves.easeInOut;
  static Curve get bounceCurve => Curves.elasticOut;
  static Curve get subtleCurve => Curves.easeOutCubic;
}
