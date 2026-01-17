import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant/constant.dart';

class PreviewPhoto extends StatelessWidget {
  const PreviewPhoto({super.key, required XFile? selectImage}) : _selectImage = selectImage;

  final XFile? _selectImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(_selectImage!.name, softWrap: true, textAlign: TextAlign.center)),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: Image.file(File(_selectImage.path)),
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.preview_outlined),
        ),
      ],
    );
  }
}
