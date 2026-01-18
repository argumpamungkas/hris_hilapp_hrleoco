import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/ui/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:icons_plus/icons_plus.dart';

class PicturePreview extends StatelessWidget {
  const PicturePreview({super.key, required this.picture});

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Transform.flip(flipX: true, child: Image.file(File(picture.path), fit: BoxFit.cover)),
            ),
            // SizedBox(height: 24.h),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.red.shade200),
                      ),
                      label: Text("Retry"),
                      icon: Icon(Iconsax.refresh_circle_outline),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        showLoadingDialog(context);

                        await Future.delayed(Duration(seconds: 2));

                        Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardScreen, (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.green.shade200),
                      ),
                      label: Text("Done"),
                      icon: Icon(Icons.check_circle_outline),
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () => Navigator.pop(context),
                  //   child: Container(
                  //     padding: const EdgeInsets.all(8),
                  //     decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  //     child: const Icon(Icons.close, color: Colors.white, size: 36),
                  //   ),
                  // ),
                  // const SizedBox(width: 16),
                  // GestureDetector(
                  //   onTap: () {
                  //     showConfirmDialog(
                  //       context,
                  //       titleConfirm: "Confirm",
                  //       descriptionConfirm: "Are you sure you keep this attendance?",
                  //       action: [
                  //         TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                  //         TextButton(
                  //           onPressed: () async {
                  //             showLoadingDialog(context);
                  //             await Future.delayed(const Duration(seconds: 1));
                  //           },
                  //           child: const Text("Yes"),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  //   child: Container(
                  //     padding: const EdgeInsets.all(8),
                  //     decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  //     child: const Icon(Icons.check, color: Colors.white, size: 36),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
