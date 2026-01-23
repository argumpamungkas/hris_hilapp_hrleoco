import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/ui/util/widgets/dialog_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:icons_plus/icons_plus.dart';

import '../util/utils.dart';

class CameraScreen extends StatefulWidget {
  // static const routeName = "/camera_screen.dart";
  const CameraScreen({super.key, required this.args});
  // final List<CameraDescription>? cameras;
  final Map<String, dynamic> args;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraC;
  int location = 0;

  @override
  void initState() {
    super.initState();
    location = widget.args['location'];
    final cameras = widget.args['cameras'] as List<CameraDescription>;

    initCamera(cameras![1]);
  }

  Future<void> initCamera(CameraDescription cameraDescription) async {
    _cameraC = CameraController(cameraDescription, ResolutionPreset.medium, enableAudio: false, imageFormatGroup: ImageFormatGroup.yuv420);
    await _cameraC.setFlashMode(FlashMode.off);

    try {
      await _cameraC.initialize().then((value) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      if (e.toString().contains("CameraException")) {
        if (!mounted) return;
        Navigator.pop(context);
      } else {
        // debugPrint("ERROR $e");
        if (!mounted) return;
        showFailSnackbar(context, "Error open camera");
      }
    }
  }

  Future<bool> _checkFaceVision(String pathImage) async {
    final inputImage = InputImage.fromFilePath(pathImage);

    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(performanceMode: FaceDetectorMode.fast, enableContours: false, enableLandmarks: false),
    );

    final faces = await faceDetector.processImage(inputImage);

    await faceDetector.close();
    if (faces.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future _takePicture() async {
    DialogHelper.showLoadingDialog(context, message: "Loading detecting image...");
    if (!_cameraC.value.isInitialized) return null;
    if (_cameraC.value.isTakingPicture) return null;
    try {
      XFile picture = await _cameraC.takePicture();

      final hasFace = await _checkFaceVision(picture.path);

      if (!mounted) return;
      Navigator.pop(context);
      if (hasFace) {
        Navigator.pushNamed(context, Routes.picturePreviewScreen, arguments: {'location': location, 'picture': picture});
      } else {
        DialogHelper.showInfoDialog(
          context,
          icon: Icon(Iconsax.close_circle_outline, size: 28.w, color: Colors.red),
          title: "Attendance",
          message: "No face was detected in the captured image. Please retake the photo with your face clearly visible.",
          onPressed: () {
            Navigator.pop(context);
          },
        );
      }
    } on CameraException catch (_) {
      Navigator.pop(context);
      showFailSnackbar(context, "Take a picture is fail");
      // debugPrint("Error occured while taking picture: $e");
      return null;
    }
  }

  @override
  void dispose() {
    _cameraC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _cameraC.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Iconsax.close_circle_outline, color: Colors.white, size: 24.w),
                    ),
                  ),
                  Center(child: CameraPreview(_cameraC)),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        // _cameraC.pausePreview();
                        _takePicture();
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                    // child: IconButton(
                    //   onPressed: _takePicture,
                    //   icon: Icon(Icons.circle, color: Colors.white, size: 0.2.sw),
                    // ),
                  ),
                ],
              )
            : CupertinoActivityIndicator(color: Colors.white),
      ),
    );
  }
}
