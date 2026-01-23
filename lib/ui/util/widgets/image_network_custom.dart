import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageNetworkCustom extends StatelessWidget {
  const ImageNetworkCustom({super.key, required this.url, this.isFit = false});

  final String url;
  final bool isFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      filterQuality: FilterQuality.medium,
      fit: isFit ? BoxFit.cover : null,
      placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
