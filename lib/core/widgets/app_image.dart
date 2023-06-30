import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppImage extends StatelessWidget {
  const AppImage(this.imageUrl,
      {this.width, this.height, this.boxFit = BoxFit.cover, Key? key})
      : super(key: key);

  final double? width;
  final double? height;
  final String? imageUrl;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: imageUrl == null
          ? Image.asset(
              'assets/images/default_image.png',
              fit: boxFit,
            )
          : CachedNetworkImage(
              imageUrl: imageUrl!,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Image.asset(
                'assets/images/default_image.png',
                fit: boxFit,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: boxFit,
              cacheManager: CacheManager(
                Config(
                  'cache key',
                  stalePeriod: const Duration(days: 7),
                  maxNrOfCacheObjects: 20,
                ),
              ),
            ),
    );
  }
}
