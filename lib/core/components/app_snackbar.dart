import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_assignment/core/config/theme/typography.dart';

enum SnackType { error, success, info }

class AppSnack {
  static void error(
    BuildContext context,
    String message, [
    DesktopSnackBarPosition? position,
  ]) {
    final colorScheme = Theme.of(context).colorScheme;
    AnimatedSnackBar(
      mobilePositionSettings: const MobilePositionSettings(
        topOnAppearance: 100,
        bottomOnAppearance: 100,
      ),
      desktopSnackBarPosition: position ?? DesktopSnackBarPosition.topCenter,
      duration: const Duration(seconds: 6),
      builder: (context) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.error,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            minLeadingWidth: 8,
            leading: Icon(
              Icons.error,
              color: colorScheme.primary,
            ),
            title: message.text12Regular(
              color: colorScheme.primary,
              maxLines: 2,
            ),
          ),
        );
      },
    ).show(context);
  }

  static void success(
    BuildContext context,
    String message, [
    DesktopSnackBarPosition? position,
  ]) {
    final colorScheme = Theme.of(context).colorScheme;
    AnimatedSnackBar(
      mobilePositionSettings: const MobilePositionSettings(
        topOnAppearance: 80,
      ),
      desktopSnackBarPosition: position ?? DesktopSnackBarPosition.topCenter,
      duration: const Duration(seconds: 6),
      builder: (context) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            minLeadingWidth: 8,
            leading: Icon(
              Icons.done,
              color: colorScheme.primary,
            ),
            title: message.text12Regular(
              color: colorScheme.primary,
              maxLines: 2,
            ),
          ),
        );
      },
    ).show(context);
  }
}
