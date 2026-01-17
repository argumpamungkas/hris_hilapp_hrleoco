import 'dart:io';

import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildUploadCardImage extends StatelessWidget {
  const BuildUploadCardImage({
    super.key,
    required this.title,
    required this.isRequired,
    required this.onTap,
    required this.placeholderPath,
    this.image,
  });

  final String title;
  final bool isRequired;
  final File? image;
  final Function()? onTap;
  final Widget placeholderPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Card dengan border
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 155,
            width: MediaQuery.of(context).size.width,
            // beri jarak agar label tidak kepotong
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: image != null ? Image.file(image!, height: 150, width: double.infinity, fit: BoxFit.fitHeight) : placeholderPath,
              ),
            ),
          ),
          // Label di atas border
          Consumer<PreferencesProvider>(
            builder: (context, prov, _) {
              return Positioned(
                left: 12,
                top: 6,
                child: Container(
                  color: prov.isDarkTheme ? Colors.black : Colors.white, // biar label gak ketimpa border
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                      if (isRequired) const Text(' *', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
