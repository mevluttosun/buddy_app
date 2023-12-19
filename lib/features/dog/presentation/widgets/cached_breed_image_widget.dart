import 'package:buddy/config/theme/app_theme.dart';
import 'package:buddy/core/constants/asset_paths.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedBreedImageWidget extends StatelessWidget {
  const CachedBreedImageWidget({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return CachedNetworkImage(
      imageUrl: imageUrl ?? kDefaultImageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRadiusValue),
          color: theme.disabledColor,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
        width: size.width,
        height: size.width,
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        width: size.width,
        height: size.width,
        decoration: BoxDecoration(
          color: theme.disabledColor,
        ),
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Container(
        width: size.width,
        height: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRadiusValue),
          color: theme.disabledColor,
        ),
        child: const Icon(Icons.error),
      ),
    );
  }
}
