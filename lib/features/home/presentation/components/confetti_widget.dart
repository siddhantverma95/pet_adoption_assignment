import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConfettiWidget extends StatelessWidget {
  const ConfettiWidget({
    required this.controller,
    required this.onLoaded,
    super.key,
  });

  final void Function(LottieComposition)? onLoaded;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, cnst) {
        return Lottie.asset(
          'assets/lottie/confetti.json',
          height: cnst.maxHeight,
          width: cnst.maxWidth,
          controller: controller,
          onLoaded: onLoaded,
        );
      },
    );
  }
}
