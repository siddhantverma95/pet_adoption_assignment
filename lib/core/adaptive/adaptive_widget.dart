import 'package:flutter/material.dart';
import 'package:pet_adoption_assignment/core/adaptive/adaptive_builder.dart';
import 'package:pet_adoption_assignment/core/adaptive/screen_type.dart';

class AdaptiveWidget extends StatelessWidget {
  const AdaptiveWidget({
    super.key,
    this.desktop = const _DefaultContainer(screenType: ScreenType.desktop),
    this.tablet = const _DefaultContainer(screenType: ScreenType.tablet),
    this.mobile = const _DefaultContainer(screenType: ScreenType.mobile),
  });

  final Widget desktop;

  final Widget tablet;

  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (sizingInfo.type == ScreenType.desktop) {
          return desktop;
        } else if (sizingInfo.type == ScreenType.tablet) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}

class _DefaultContainer extends StatelessWidget {
  const _DefaultContainer({required this.screenType});

  final ScreenType screenType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Center(
            child: Text(
              '${screenType.name} not implemented',
              style: theme.textTheme.displayMedium,
            ),
          ),
        );
      },
    );
  }
}
