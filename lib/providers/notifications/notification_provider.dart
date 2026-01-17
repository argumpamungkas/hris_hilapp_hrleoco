import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../data/models/notifications/notification_response.dart';
import '../../data/network/api/api_notification.dart';
import '../../ui/util/utils.dart';

class NotificationProvider extends ChangeNotifier {
  final ApiNotification _api = ApiNotification();

  List<ResultNotif> _listNotification = [];
  int _total = 0;
  ResultStatus _resultStatus = ResultStatus.init;
  late String _message;
  late String _linkServer;

  List<ResultNotif> get listNotification => _listNotification;

  int get total => _total;

  ResultStatus get resultStatus => _resultStatus;

  String get message => _message;

  String get linkServer => _linkServer;

  Future<dynamic> fetchNotification() async {
    _resultStatus = ResultStatus.hasData;
    notifyListeners();
    // _resultStatus = ResultStatus.loading;
    // _linkServer = await getLink();
    // notifyListeners();
    // try {
    //   var response = await _api.fetchNotification();
    //   NotifResponse notifModel = NotifResponse.fromJson(response);
    //   _listNotification = notifModel.resultNotification;
    //   if (_listNotification.isEmpty) {
    //     _resultStatus = ResultStatus.noData;
    //     _message = "Notification is Empty";
    //     _total = notifModel.total;
    //     notifyListeners();
    //     return _message;
    //   } else {
    //     _resultStatus = ResultStatus.hasData;
    //     _total = notifModel.total;
    //     notifyListeners();
    //     return _listNotification;
    //   }
    // } on TimeoutException catch (_) {
    //   _resultStatus = ResultStatus.error;
    //   _message = errTimeOutMsg;
    //   notifyListeners();
    //   return false;
    // } on SocketException catch (_) {
    //   _resultStatus = ResultStatus.error;
    //   _message = errMessageNoInternet;
    //   notifyListeners();
    //   return false;
    // } catch (e) {
    //   _resultStatus = ResultStatus.error;
    //   _message = errMessage;
    //   notifyListeners();
    //   return false;
    // }
  }
}
