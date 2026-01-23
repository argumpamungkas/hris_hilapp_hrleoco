import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/providers/attendances/attendance_provider.dart';
import 'package:easy_hris/ui/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:icons_plus/icons_plus.dart';

import '../util/widgets/dialog_helpers.dart';

class PicturePreview extends StatefulWidget {
  const PicturePreview({super.key, required this.args});

  final Map<String, dynamic> args;

  @override
  State<PicturePreview> createState() => _PicturePreviewState();
}

class _PicturePreviewState extends State<PicturePreview> {
  XFile? picture;

  @override
  void initState() {
    super.initState();
    picture = widget.args['picture'];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendanceProvider(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Transform.flip(flipX: true, child: Image.file(File(picture!.path), fit: BoxFit.cover)),
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
                    Consumer<AttendanceProvider>(
                      builder: (context, prov, _) {
                        return Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              showLoadingDialog(context);

                              await Future.delayed(Duration(seconds: 2));

                              final result = await prov.submitAttendances(widget.args['location'], File(picture!.path));

                              if (!context.mounted) return;
                              if (result) {
                                DialogHelper.showInfoDialog(
                                  context,
                                  icon: Icon(Icons.check, size: 32, color: Colors.green),
                                  title: prov.title,
                                  message: prov.message,
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardScreen, (route) => false);
                                  },
                                );
                              } else {
                                DialogHelper.showInfoDialog(
                                  context,
                                  icon: Icon(Icons.close_rounded, size: 32, color: Colors.red.shade700),
                                  title: prov.title,
                                  message: prov.message,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                );
                              }
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
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
