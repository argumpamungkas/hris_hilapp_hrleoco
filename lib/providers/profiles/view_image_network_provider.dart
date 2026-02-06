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

            await _notifService.showNotificationProgressDownload(notificationId, progress);
          }
        },
      );
      await Future.delayed(Duration(milliseconds: 1500));

      await _notifService.notificationCancel(notificationId);

      // await Future.delayed(Duration(milliseconds: 1500));

      await _notifService.showNotificationSuccessDownloadPicture(filePath, notificationId);

      return true;
    } catch (e, trace) {
      ;
      return false;
    }
  }
}
