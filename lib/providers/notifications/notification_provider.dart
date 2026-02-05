import 'dart:async';

import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/response/notification_model.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../data/network/api/api_notification.dart';
import '../../injection.dart';

class NotificationProvider extends ChangeNotifier {
  final ApiNotification _api = ApiNotification();
  final _prefs = sl<SharedPreferences>();

  ResultStatus _resultStatus = ResultStatus.init;
  List<NotificationModel> _listNotification = [];
  String _message = '';

  ResultStatus get resultStatus => _resultStatus;
  List<NotificationModel> get listNotification => _listNotification;
  String get message => _message;

  NotificationProvider() {
    fetchNotification();
  }

  Future<void> fetchNotification() async {
    _listNotification.clear();
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final response = await _api.fetchNotification(number!);
      if (response.theme == 'success') {
        if (response.result!.isEmpty) {
          _resultStatus = ResultStatus.noData;
          notifyListeners();
          return;
        } else {
          _listNotification = response.result!;
          _resultStatus = ResultStatus.hasData;
          notifyListeners();
          return;
        }
      } else {
        _resultStatus = ResultStatus.error;
        _message = response.message!;
        notifyListeners();
      }
    } catch (e, trace) {
      print("error $e");
      print("error $trace");
      _resultStatus = ResultStatus.error;
      _message = e.toString();
      notifyListeners();
      return;
    }
  }
}
