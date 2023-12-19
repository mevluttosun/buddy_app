import 'package:buddy/features/dog/presentation/widgets/cached_breed_image_widget.dart';
import 'package:flutter/material.dart';

class BreedWidget extends StatelessWidget {
  final String? imageUrl;
  final String? breedName;
  final Function? onTap;
  const BreedWidget({
    super.key,
    this.imageUrl,
    this.breedName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap as void Function()?,
        child: GridTile(
            footer: Container(
              // cut minimum text and border only top right
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  breedName ?? "Unknown",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            child: CachedBreedImageWidget(imageUrl: imageUrl)));
  }
}
