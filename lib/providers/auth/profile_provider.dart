import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/constant.dart';
import '../../data/models/profile.dart';
import '../../data/models/response/user_model.dart';
import '../../data/network/api/api_auth.dart';
import '../../data/network/api/api_dashboard.dart';
import '../../ui/util/utils.dart';

class ProfileProvider extends ChangeNotifier {
  final ApiDashboard _api = ApiDashboard();
  final ApiAuth _apiAuth = ApiAuth();

  late ResultProfile _userProfile;
  late String _linkServer;
  ResultStatus _resultStatus = ResultStatus.init;

  ResultProfile get userProfile => _userProfile;

  String get linkServer => _linkServer;

  ResultStatus get resultStatus => _resultStatus;

  String _greetingCondition = "Good";
  UserModel? _userModel;
  String _message = '';
  ResultStatus _resultStatusUserModel = ResultStatus.init;

  String get message => _message;
  String get greetingCondition => _greetingCondition;
  UserModel? get userModel => _userModel;
  ResultStatus get resultStatusUserModel => _resultStatusUserModel;

  void getUser() async {
    _resultStatusUserModel = ResultStatus.loading;
    _greetingCondition = greeting();
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString(ConstantSharedPref.user) != null) {
      final user = prefs.getString(ConstantSharedPref.user);
      _userModel = UserModel.fromJson(jsonDecode(user!));
      _resultStatusUserModel = ResultStatus.hasData;
      notifyListeners();
    } else {
      _resultStatusUserModel = ResultStatus.noData;
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

  Future<dynamic> fetchUserProfile() async {
    // print("call kdmbali");
    // print("ERR");
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    _linkServer = await getLink();
    try {
      Map<String, dynamic> response = await _api.fetchUserProfile();
      User user = User.fromJson(response);
      // debugPrint("USERR => ${user.results.toJson()}");
      _userProfile = user.results;
      // print(user.results.status);
      if (_userProfile.status == "1") {
        _resultStatus = ResultStatus.noData;
        _message = "You account deactivate. You haven't access this application";
        notifyListeners();
        return;
      } else {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return _userProfile;
      }
    } on TimeoutException {
      _resultStatus = ResultStatus.error;
      _message = errMessageNoInternet;
      notifyListeners();
      return;
    } on SocketException {
      _resultStatus = ResultStatus.error;
      _message = errMessageNoInternet;
      notifyListeners();
      return;
    } catch (e) {
      // print(e);
      _resultStatus = ResultStatus.error;
      _message = errMessage;
      notifyListeners();
      return;
    }
  }

  Future<void> onClearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userModel = null;
    prefs.remove(ConstantSharedPref.isLogin);
    prefs.remove(ConstantSharedPref.user);
    prefs.remove(ConstantSharedPref.numberUser);
  }

  Future<void> logout(BuildContext context) async {
    await onClearPrefs();
  }
}
