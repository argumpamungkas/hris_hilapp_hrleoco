import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../providers/preferences_provider.dart';

class PhotoBottomSheet extends StatelessWidget {
  const PhotoBottomSheet({super.key, required this.openGallery, required this.openCamera});

  final void Function() openGallery, openCamera;

  @override
  Widget build(BuildContext context) {
    PreferencesProvider provPref = Provider.of<PreferencesProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Choose your upload photo from", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: openGallery,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo_size_select_actual_outlined, size: 36, color: provPref.isDarkTheme ? Colors.white : colorBlueDark),
                      const SizedBox(height: 8),
                      const Text("Gallery"),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: openCamera,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo_camera_outlined, size: 36, color: provPref.isDarkTheme ? Colors.white : colorBlueDark),
                      const SizedBox(height: 8),
                      const Text("Photo"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
