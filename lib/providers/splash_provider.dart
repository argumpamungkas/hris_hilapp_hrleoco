import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constant/constant.dart';
import '../constant/exports.dart';
import '../data/network/api/api_dashboard.dart';
import '../injection.dart';

class SplashProvider extends ChangeNotifier {
  final ApiDashboard _api = ApiDashboard();
  final _prefs = sl<SharedPreferences>();

  String _message = '';
  String _route = '';

  String get message => _message;

  String get route => _route;

  Future<String> autoLogin() async {
    final permission = await _requestPermission();
    if (!permission) {
      return "splash";
    }

    if (_prefs.getBool(ConstantSharedPref.isLogin) != null) {
      _route = 'dashboard';
      notifyListeners();
      return _route;
    } else {
      _route = 'signIn';
      notifyListeners();
      return _route;
    }
  }

  Future<bool> _isAndroid13OrAbove() async {
    if (!Platform.isAndroid) return false;

    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt >= 33;
  }

  Future<bool> _requestPermission() async {
    var locStatus = await Permission.location.status;
    final cameraStatus = await Permission.camera.status;

    // permission untuk versi android 13+
    bool needNotificationPermission = await _isAndroid13OrAbove();
    PermissionStatus notificationStatus = PermissionStatus.granted;

    if (needNotificationPermission) {
      notificationStatus = await Permission.notification.status;
    }

    final permissionsToRequest = [Permission.camera, Permission.location, if (needNotificationPermission) Permission.notification];

    final result = await permissionsToRequest.request();

    final cameraGranted = result[Permission.camera]?.isGranted ?? false;

    final locationGranted = result[Permission.location]?.isGranted ?? false;

    final notifGranted = needNotificationPermission ? result[Permission.notification]?.isGranted ?? false : true;

    if (!cameraGranted || !locationGranted || !notifGranted) {
      return false;
    }

    return true;

    if (locStatus != PermissionStatus.granted) {
      var locationPermission = await Permission.location.request();
      if (locationPermission == PermissionStatus.denied) {
        _message = "Location is not allowed";
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
