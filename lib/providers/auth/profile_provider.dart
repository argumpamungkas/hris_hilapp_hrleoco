import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_hris/data/network/api/api_attendance.dart';
import 'package:easy_hris/data/network/api/api_home.dart';
import 'package:easy_hris/data/services/url_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/constant.dart';
import '../../data/models/profile.dart';
import '../../data/models/response/user_model.dart';
import '../../data/network/api/api_auth.dart';
import '../../data/network/api/api_dashboard.dart';
import '../../injection.dart';
import '../../ui/util/utils.dart';

class ProfileProvider extends ChangeNotifier {
  final ApiDashboard _api = ApiDashboard();
  final ApiHome _apiHome = ApiHome();
  final ApiAuth _apiAuth = ApiAuth();
  final _prefs = sl<SharedPreferences>();
  final _urlService = sl<UrlServices>();

  String _isActive = '0';
  ResultStatus _resultStatus = ResultStatus.init;
  ResultStatus _resultStatusUserModel = ResultStatus.init;
  String _greetingCondition = "Good";
  UserModel? _userModel;
  String _title = '';
  String _message = '';
  String _photoProfile = '';

  String get photoProfile => _photoProfile;
  String get isActive => _isActive;
  ResultStatus get resultStatus => _resultStatus;
  String get title => _title;
  String get message => _message;
  String get greetingCondition => _greetingCondition;
  UserModel? get userModel => _userModel;
  ResultStatus get resultStatusUserModel => _resultStatusUserModel;

  void getUser() async {
    _resultStatusUserModel = ResultStatus.loading;
    _greetingCondition = greeting();
    notifyListeners();

    if (_prefs.getString(ConstantSharedPref.user) != null) {
      final user = _prefs.getString(ConstantSharedPref.user);
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      _userModel = UserModel.fromJson(jsonDecode(user!));

      try {
        final result = await _apiHome.fetchShiftUser(number ?? '');

        if (result.theme == 'success') {
          _isActive = result.result!.employeeStatus!;
          if (result.result?.imageProfile != null && result.result?.imageProfile != '') {
            final urlModel = await _urlService.getUrlModel();
            _photoProfile = "${urlModel?.link}/${Constant.urlProfileImage}/${result.result?.imageProfile}";
          }
          _resultStatusUserModel = ResultStatus.hasData;
          notifyListeners();
        } else {
          _resultStatusUserModel = ResultStatus.noData;
          _message = result.message!;
          notifyListeners();
        }
      } catch (e) {
        _resultStatusUserModel = ResultStatus.error;
        _message = "Check status employee error. $e";
        notifyListeners();
      }
    } else {
      _resultStatusUserModel = ResultStatus.noData;
      _message = "User not found. Please login again.";
      notifyListeners();
    }
  }

  String greeting() {
    var hour = DateTime.now().toLocal().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  Future<void> fetchUpdateProfile() async {
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final result = await _apiHome.fetchShiftUser(number ?? '');

      if (result.theme == 'success') {
        // _isActive = result.result!.employeeStatus!;
        if (result.result?.imageProfile != null && result.result?.imageProfile != '') {
          final urlModel = await _urlService.getUrlModel();
          _photoProfile = "${urlModel?.link}/${Constant.urlProfileImage}/${result.result?.imageProfile}";
        }
        // _resultStatusUserModel = ResultStatus.hasData;
        notifyListeners();
      } else {
        // _resultStatusUserModel = ResultStatus.noData;
        _message = result.message!;
        notifyListeners();
      }
    } catch (e) {
      // _resultStatusUserModel = ResultStatus.error;
      _message = "Check status employee error. $e";
      notifyListeners();
    }
  }

  Future<bool> logoutUser() async {
    try {
      // var result = await _api.loginUser(_usernameC.text, _pwdC.text, fcmToken!);
      var result = await _apiAuth.logoutUser(userModel!.username!);
      if (result.theme == "error") {
        _title = result.title!;
        _message = result.message!;
        return false;
      } else {
        await onClearPrefs();
        return true;
      }
    } catch (e) {
      _title = "Failed";
      _message = e.toString();
      return false;
    }
  }

  Future<void> onClearPrefs() async {
    _userModel = null;
    _photoProfile = '';
    _prefs.remove(ConstantSharedPref.isLogin);
    _prefs.remove(ConstantSharedPref.user);
    _prefs.remove(ConstantSharedPref.numberUser);
  }

  // Future<void> logout(BuildContext context) async {
  //   await onClearPrefs();
  // }
}
