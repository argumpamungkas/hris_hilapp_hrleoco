// import 'dart:io';
//
// import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
// import 'package:face_camera/face_camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CameraFaceDetectionScreen extends StatefulWidget {
//   const CameraFaceDetectionScreen({super.key});
//
//   @override
//   State<CameraFaceDetectionScreen> createState() => _CameraFaceDetectionScreenState();
// }
//
// class _CameraFaceDetectionScreenState extends State<CameraFaceDetectionScreen> {
//   late FaceCameraController controller;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller = FaceCameraController(
//       autoCapture: false,
//       defaultCameraLens: CameraLens.front,
//       defaultFlashMode: CameraFlashMode.off,
//       enableAudio: false,
//       imageResolution: ImageResolution.low,
//       onFaceDetected: (face) {
//         debugPrint("Face detected: ${face?.boundingBox}");
//       },
//       onCapture: (File? image) {},
//     );
//
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await controller.initialize();
//     });
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppbarCustom.appbar(context, title: "Check In", leadingBack: true),
//       body: SafeArea(
//         child: Builder(
//           builder: (context) {
//             return SizedBox(
//               width: double.infinity,
//               height: 360,
//               child: SmartFaceCamera(controller: controller, message: 'Center your face in the square'),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
