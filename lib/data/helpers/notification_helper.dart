import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:rxdart/rxdart.dart';

import '../../main.dart';
import '../models/received_notification.dart';

final selectNotificationSubject = BehaviorSubject<String?>();
final didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  // Kita akan membuat beberapa fungsi jenis notifikasi di dalam kelas ini
  Future<void> initNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: false,
      requestSoundPermission: false,
      // onDidReceiveLocalNotification:
      //     (int id, String? title, String? body, String? payload) async {
      //   didReceiveLocalNotificationSubject.add(ReceivedNotification(
      //       id: id, title: title, body: body, payload: payload));
      // }
    );

    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        final payload = details.payload;
        // debugPrint('NILAI: $payload');
        if (payload != null) {
          // debugPrint('notification payload: $payload');
          final pyld = payload.split('.').last;
          if (pyld == "pdf") {
            OpenFile.open(payload, type: "application/pdf");
          } else {
            // print("object");
            // print("payload $payload");
            OpenFile.open(payload, type: "image/jpeg");
          }
        } else {
          selectNotificationSubject.add(payload ?? "emptyPayload");
        }
      },
    );
  }

  void requestIOSPermissions(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void configureDidReceiveLocalNotificationSubject(BuildContext context, String route) {
    didReceiveLocalNotificationSubject.stream.listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null ? Text(receivedNotification.title!) : null,
          content: receivedNotification.body != null ? Text(receivedNotification.body!) : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.pushNamed(context, route, arguments: receivedNotification);
              },
            ),
          ],
        ),
      );
    });
  }

  Future<void> showNotificationSuccessDownloading(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String pathFile,
    String description,
  ) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      DateTime.now().toIso8601String(),
      "_channelDownload ${DateTime.now()}",
      channelDescription: "_channelSuccessDownload",
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, 'Download Success', description, platformChannelSpecifics, payload: pathFile);
  }

  Future<void> showNotificationSuccessDownloadingJPG(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String pathFile,
    String description,
  ) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      "01",
      "_channelDownload",
      channelDescription: "_channelSuccessDownload",
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, 'Download Success', description, platformChannelSpecifics, payload: pathFile);
  }

  Future<void> showNotifOnForeground(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      "01",
      "_channelOnForeground",
      channelDescription: "_channelonForeground",
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(1, message.notification?.title, message.notification!.body, platformChannelSpecifics);
  }

  Future<void> showNotifOnBG(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      "01",
      "_channelOnForeground",
      channelDescription: "_channelonForeground",
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(1, message.notification?.title, message.notification!.body, platformChannelSpecifics);
  }
}
