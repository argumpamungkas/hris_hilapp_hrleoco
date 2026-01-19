import 'package:easy_hris/injection.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/providers/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constant/routes.dart';
import 'data/services/notification_services.dart';
import 'data/network/api/firebase_api.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Injection().initialize();

  await dotenv.load(fileName: '.env');

  /// GET URL FORM SUPABASE
  String projectUrl = dotenv.env['PROJECT_URL'] ?? "";
  String publishUrl = dotenv.env['PUBLISH_API_KEY'] ?? "";

  await Supabase.initialize(url: projectUrl, anonKey: publishUrl);

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseApi().setupNotification();

  final NotificationServices notificationServices = NotificationServices();
  await notificationServices.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: Providers.providers,
          child: Consumer<PreferencesProvider>(
            builder: (context, prov, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: true,
                title: "Easy HRIS",
                theme: prov.themeData,
                initialRoute: Routes.splashScreen,
                routes: Routes.routesPage,
              );
            },
          ),
        );
      },
    );
  }
}
