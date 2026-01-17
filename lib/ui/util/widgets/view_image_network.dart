import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_hris/ui/util/widgets/image_network_custom.dart';
import 'package:flutter/material.dart';

class ViewImageNetwork extends StatelessWidget {
  const ViewImageNetwork({super.key, required this.selectImage});

  final String selectImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InteractiveViewer(
          maxScale: 5,
          child: Hero(
            tag: selectImage,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: ImageNetworkCustom(url: selectImage),
            ),
          ),
        ),
      ),
    );
  }
}
