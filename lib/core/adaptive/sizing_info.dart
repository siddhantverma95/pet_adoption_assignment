import 'package:flutter/material.dart';
import 'package:pet_adoption_assignment/core/adaptive/screen_type.dart';

class SizingInfo {
  SizingInfo({
    required this.type,
    required this.screenSize,
    required this.localWidgetSize,
  });
  final ScreenType type;
  final Size screenSize;
  final Size localWidgetSize;
}
