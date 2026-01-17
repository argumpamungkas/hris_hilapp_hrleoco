import 'dart:io';

import 'package:flutter/material.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({super.key, required this.selectImage});

  final File? selectImage;

  @override
  Widget build(BuildContext context) {
    print("SelectImage ${selectImage}");
    print("SelectImage ${selectImage?.path}");
    return Scaffold(
      body: Center(
        child: InteractiveViewer(
          maxScale: 5,
          child: Hero(
            tag: selectImage!.path,
            child: SizedBox(height: MediaQuery.sizeOf(context).height, child: Image.file(File(selectImage!.path))),
          ),
        ),
      ),
    );
  }
}
