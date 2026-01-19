import 'package:firebase_messaging/firebase_messaging.dart';

import '../../services/notification_services.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final NotificationServices _NotificationServices = NotificationServices();

  Future<dynamic> setupNotification() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // debugPrint(tokenFcm);
      initPushNotification();
      return true;
    } else {
      return false;
    }
  }

  Future<void> initPushNotification() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) async {
      if (message.notification != null) {
        _NotificationServices.showNotifOnForeground(message);
      }
    });
  }
}
