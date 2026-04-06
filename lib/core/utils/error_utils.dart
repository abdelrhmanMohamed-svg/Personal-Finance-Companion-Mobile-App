import 'package:flutter/material.dart';

enum ErrorCategory { network, data, system }

class ErrorUtils {
  static String formatErrorMessage(String? error, ErrorCategory category) {
    switch (category) {
      case ErrorCategory.network:
        return 'Unable to connect. Please check your internet connection and try again.';
      case ErrorCategory.data:
        return 'Something went wrong while loading your data. Please try again.';
      case ErrorCategory.system:
        return 'Something unexpected happened. Please try again later.';
    }
  }

  static void showErrorSnackBar(
    BuildContext context, {
    required String message,
    String? retryLabel,
    VoidCallback? onRetry,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        action: retryLabel != null && onRetry != null
            ? SnackBarAction(
                label: retryLabel,
                textColor: Colors.white,
                onPressed: onRetry,
              )
            : null,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static ErrorCategory categorizeError(dynamic error) {
    final errorString = error.toString().toLowerCase();
    if (errorString.contains('network') ||
        errorString.contains('connection') ||
        errorString.contains('socket')) {
      return ErrorCategory.network;
    }
    if (errorString.contains('database') ||
        errorString.contains('supabase') ||
        errorString.contains('postgrest')) {
      return ErrorCategory.data;
    }
    return ErrorCategory.system;
  }
}
