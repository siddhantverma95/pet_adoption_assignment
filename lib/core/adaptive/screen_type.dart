import 'package:pet_adoption_assignment/core/logger/app_logger.dart';

enum ScreenType { desktop, tablet, mobile }

ScreenType getScreenType(double size) {
  AppLog.info('Screen Size: $size');
  if (size > 900) {
    return ScreenType.desktop;
  } else if (size <= 990 && size >= 672) {
    return ScreenType.tablet;
  } else {
    return ScreenType.mobile;
  }
}
