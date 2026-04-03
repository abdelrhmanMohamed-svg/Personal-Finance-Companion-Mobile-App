import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final VoidCallback? onTap;

  const PlaceholderWidget({
    super.key,
    this.message,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
            ],
            if (message != null)
              Text(
                message!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}