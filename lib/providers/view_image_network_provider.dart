import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_hris/data/services/notification_services.dart';
import 'package:easy_hris/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class ViewImageNetworkProvider extends ChangeNotifier {
  final _notifService = NotificationServices();

  Future<bool> prepareSaveDir(String url) async {
    String nameFile = url.split("/").last;
    String typeFile = '';

    if (url.contains("kk")) {
      typeFile = 'kk_$nameFile';
    } else if (url.contains('npwp')) {
      typeFile = 'npwp_$nameFile';
    } else if (url.contains('profile')) {
      typeFile = 'profile_$nameFile';
    } else {
      typeFile = 'ktp_$nameFile';
    }

    String _localPath = '';
    Dio dio = Dio();
    String now = DateFormat('ddMMyy_mmss').format(DateTime.now().toLocal());
    String name = "${now}_$typeFile";
    if (Platform.isAndroid) {
      var infoDevice = await DeviceInfoPlugin().androidInfo;
      if (infoDevice.version.sdkInt > 28) {
        _localPath = Directory("/storage/emulated/0/Download").path;
      } else {
        _localPath = '/storage/emulated/0/Download';
      }
    } else {
      final directory = await getApplicationDocumentsDirectory();
      _localPath = directory.path;
    }

    // print("LOCAL PATH => $_localPath");
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create(recursive: true);
    }

    // print("URL => $url");
    try {
      /// DOWNLOAD FILE AS BYTES
      final filePath = "$_localPath/$name";
      const notificationId = 100;

      await dio.download(
        url,
        filePath,
        onReceiveProgress: (count, total) async {
          if (total != -1) {
            final progress = (count / total * 100).floor();

            await _notifService.showNotificationProgressDownload(flutterLocalNotificationsPlugin, notificationId, progress);
            // await flutterLocalNotificationsPlugin.show(
            //   notificationId,
            //   "Downloading Image",
            //   "$progress%",
            //   NotificationDetails(
            //     android: AndroidNotificationDetails(
            //       'download_channel',
            //       'Download',
            //       channelDescription: 'Image download progress',
            //       importance: Importance.low,
            //       priority: Priority.low,
            //       showProgress: true,
            //       maxProgress: 100,
            //       progress: progress,
            //       ongoing: true,
            //       onlyAlertOnce: true,
            //     ),
            //   ),
            // );
          }
        },
      );
      await Future.delayed(Duration(milliseconds: 1500));

      await flutterLocalNotificationsPlugin.cancel(notificationId);

      // await Future.delayed(Duration(milliseconds: 1500));

      await _notifService.showNotificationSuccessDownloadPicture(flutterLocalNotificationsPlugin, filePath, notificationId);
      // Notifikasi sukses
      // await flutterLocalNotificationsPlugin.show(
      //   notificationId,
      //   "Download Selesai",
      //   "Gambar berhasil diunduh",
      //   const NotificationDetails(
      //     android: AndroidNotificationDetails(
      //       'download_channel',
      //       'Download',
      //       importance: Importance.high,
      //       priority: Priority.high,
      //       ongoing: false,
      //       showProgress: false,
      //     ),
      //   ),
      // );

      print("file tersimpan $filePath");

      // print("DOWNLOAD BERHASIL => ${file.path}");
      return true;
    } catch (e, trace) {
      // print("Error $e");
      // print("trace $trace");
      return false;
    }

    // try {
    //   print(localPath);
    //   var file = File("$_localPath/$name");
    //   await dio.download(_url.toString(), "$_localPath/$name");
    //   print("DOWNLOAD PRINT BERHASIL");
    //   // if (!context.mounted) return;
    //   await _notifService.showNotificationDownload(file.path, name);
    //   print("PATH ${file.path}");
    // } catch (e) {
    //   print("Error $e");
    //   // if (!context.mounted) return;
    //   // snackBarFailed(description: "Download Gagal");
    // }
  }
}
