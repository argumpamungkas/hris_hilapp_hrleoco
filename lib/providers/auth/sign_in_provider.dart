import 'dart:async';
import 'dart:convert';

import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/response/user_model.dart';
import 'package:easy_hris/data/network/api/firebase_api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../data/models/profile.dart';
import '../../data/network/api/api_auth.dart';
import '../../data/network/api/api_dashboard.dart';
import '../../injection.dart';

class SignInProvider with ChangeNotifier {
  final ApiAuth _api = ApiAuth();
  final ApiDashboard _apiD = ApiDashboard();
  final _prefs = sl<SharedPreferences>();
  final FirebaseApi _firebaseApi = FirebaseApi();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameC = TextEditingController();
  final TextEditingController _pwdC = TextEditingController();
  // final FirebaseApi _firebaseApi = FirebaseApi();
  String _title = "";
  String _message = "";

  bool _pwdVisible = true;

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController get usernameC => _usernameC;

  TextEditingController get pwdC => _pwdC;

  // FirebaseApi get firebaseApi => _firebaseApi;

  bool get pwdVisible => _pwdVisible;

  String get title => _title;
  String get message => _message;

  void onChangePwd() {
    _pwdVisible = !_pwdVisible;
    notifyListeners();
  }

  // Future<bool> signInEmployee() async {
  //   final firebaseMessaging = FirebaseMessaging.instance;
  //   final fcmToken = await firebaseMessaging.getToken();
  //
  //   print("TOKENNN =>> $fcmToken");
  //
  //   final user = UserModel(
  //     departementId: "IT",
  //     number: "2360-020525",
  //     name: "ARGUMELAR PAMUNGKAS",
  //     description: "TEST",
  //     username: "argum",
  //     // password: "123",
  //     email: "arg",
  //     phone: "081",
  //     position: "Mobile Developer",
  //     avatar: "",
  //     roles: "Lead",
  //   );
  //   _prefs.setString(ConstantSharedPref.user, jsonEncode(user));
  //   _prefs.setString(ConstantSharedPref.numberUser, user.number!);
  //   _prefs.setBool(ConstantSharedPref.isLogin, true);
  //   return true;
  // }

  Future<bool> signInEmployee() async {
    try {
      final firebaseMessaging = FirebaseMessaging.instance;
      final fcmToken = await firebaseMessaging.getToken();

      // print("FCM TOKEN $fcmToken");

      // var result = await _api.loginUser(_usernameC.text, _pwdC.text, fcmToken!);
      var result = await _api.loginUser(_usernameC.text, _pwdC.text, fcmToken!);
      var resultStatus = result["theme"];
      if (resultStatus == "error") {
        _title = result['title'];
        _message = result['message'];
        _pwdC.clear();
        notifyListeners();
        // return result;
        return false;
      } else {
        final user = UserModel.fromJson(result['result']);

        if (user.number == null || user.number == "") {
          _title = "User";
          _message = "Sorry your employee is empty";
          notifyListeners();
          return false;
        } else {
          _prefs.setString(ConstantSharedPref.user, jsonEncode(user));
          _prefs.setString(ConstantSharedPref.numberUser, user.number!);
          _prefs.setBool(ConstantSharedPref.isLogin, true);

          return true;
        }
      }
    } catch (e) {
      _title = "Failed";
      _message = e.toString();
      return false;
    }
  }

  Future<dynamic> fetchUserProfile() async {
    // print("ERR");
    try {
      Map<String, dynamic> response = await _apiD.fetchUserProfile();
      User user = User.fromJson(response);
      if (user.results.status == "1") {
        _pwdC.clear();
        notifyListeners();
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return 'error';
    }
  }
}
