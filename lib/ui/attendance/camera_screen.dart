import 'package:camera/camera.dart';
import 'package:easy_hris/ui/attendance/picture_preview.dart';
import 'package:flutter/material.dart';

import '../util/utils.dart';

class CameraScreen extends StatefulWidget {
  static const routeName = "/camera_screen.dart";
  const CameraScreen({super.key, required this.cameras});
  final List<CameraDescription>? cameras;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraC;

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![1]);
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraC = CameraController(cameraDescription, ResolutionPreset.medium, enableAudio: false, imageFormatGroup: ImageFormatGroup.yuv420);

    try {
      await _cameraC.initialize().then((value) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      if (e.toString() == "CameraException(CameraAccessDenied, Camera access permission was denied.)") {
        if (!mounted) return;
        Navigator.pop(context);
      } else {
        // debugPrint("ERROR $e");
        if (!mounted) return;
        showFailSnackbar(context, "Error open camera");
      }
    }
  }

  Future _takePicture() async {
    if (!_cameraC.value.isInitialized) return null;
    if (_cameraC.value.isTakingPicture) return null;
    try {
      await _cameraC.setFlashMode(FlashMode.off);
      XFile picture = await _cameraC.takePicture();
      if (!mounted) return;
      Navigator.pushNamed(context, PicturePreview.routeName, arguments: picture);
    } on CameraException catch (_) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: _cameraC.value.isInitialized
                  // ? CameraPreview(_cameraC)
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(_cameraC.description.lensDirection == CameraLensDirection.front ? 3.14159 : 0),
                      child: CameraPreview(_cameraC),
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                onPressed: _takePicture,
                icon: const Icon(Icons.circle, color: Colors.white, size: 80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
