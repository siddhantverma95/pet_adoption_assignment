import 'package:flutter/material.dart';
import 'package:pet_adoption_assignment/core/config/theme/typography.dart';
import 'package:pet_adoption_assignment/features/home/domain/models/image_interaction.dart';

class ImageInteractionWidget extends StatelessWidget {
  const ImageInteractionWidget({
    required this.meta,
    super.key,
  });

  final ImageInteraction meta;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: meta.name.h4(),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4,
          child: Image.asset(meta.image),
        ),
      ),
    );
  }
}
