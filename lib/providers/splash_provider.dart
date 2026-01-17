import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constant/constant.dart';
import '../constant/exports.dart';
import '../data/network/api/api_dashboard.dart';

class SplashProvider extends ChangeNotifier {
  final ApiDashboard _api = ApiDashboard();

  String _message = '';
  String _route = '';

  String get message => _message;

  String get route => _route;

  Future<String> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final permission = await _requestPermission();
    if (!permission) {
      return "splash";
    }

    if (prefs.getBool(ConstantSharedPref.isLogin) != null) {
      _route = 'dashboard';
      notifyListeners();
      return _route;
    } else {
      _route = 'signIn';
      notifyListeners();
      return _route;
    }
  }

  Future<bool> _requestPermission() async {
    var locStatus = await Permission.location.status;
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
