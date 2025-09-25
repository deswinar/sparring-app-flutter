import 'package:flutter/material.dart';

enum SnackbarType { success, error, info, warning }
enum SnackbarPosition { bottom, top }

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    SnackbarType type = SnackbarType.info,
    SnackbarPosition position = SnackbarPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }) {
    final theme = Theme.of(context);

    final colors = _mapTypeToColors(type, theme.colorScheme);

    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      margin: position == SnackbarPosition.bottom
          ? const EdgeInsets.only(bottom: 24, left: 16, right: 16)
          : const EdgeInsets.only(top: 24, left: 16, right: 16),
      duration: duration,
      dismissDirection: DismissDirection.horizontal,
      content: _SnackbarContent(
        title: title,
        message: message,
        backgroundColor: colors.background,
        textColor: colors.text,
        icon: colors.icon,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Color palette per type
  static _SnackbarColors _mapTypeToColors(
    SnackbarType type,
    ColorScheme scheme,
  ) {
    switch (type) {
      case SnackbarType.success:
        return _SnackbarColors(
          background: scheme.primaryContainer,
          text: scheme.onPrimaryContainer,
          icon: Icons.check_circle,
        );
      case SnackbarType.error:
        return _SnackbarColors(
          background: scheme.errorContainer,
          text: scheme.onErrorContainer,
          icon: Icons.error,
        );
      case SnackbarType.warning:
        return _SnackbarColors(
          background: scheme.tertiaryContainer,
          text: scheme.onTertiaryContainer,
          icon: Icons.warning,
        );
      case SnackbarType.info:
      return _SnackbarColors(
          background: scheme.secondaryContainer,
          text: scheme.onSecondaryContainer,
          icon: Icons.info,
        );
    }
  }
}

class _SnackbarColors {
  final Color background;
  final Color text;
  final IconData icon;
  _SnackbarColors({
    required this.background,
    required this.text,
    required this.icon,
  });
}

class _SnackbarContent extends StatelessWidget {
  final String? title;
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;

  const _SnackbarContent({
    required this.message,
    this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.9, end: 1),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: backgroundColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: textColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Text(
                        message,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
