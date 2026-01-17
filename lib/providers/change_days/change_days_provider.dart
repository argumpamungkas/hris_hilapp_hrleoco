import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../constant/constant.dart';
import '../../../data/models/change_days.dart';
import '../../../data/network/api/api_change_days.dart';
import '../../ui/util/utils.dart';

class ChangeDaysProvider with ChangeNotifier {
  ApiChangeDays api = ApiChangeDays();

  List<ResultsChangeDays> _listChangeDays = [];
  ResultStatus _resultStatus = ResultStatus.init;
  late String _message;

  List<ResultsChangeDays> get listChangeDays => _listChangeDays;
  ResultStatus get resultStatus => _resultStatus;
  String get message => _message;

  Future<dynamic> fetchChangeDays(BuildContext context) async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      Map<String, dynamic> response = await api.fetchChangeDays();
      ChangeDays changeDays = ChangeDays.fromJson(response);
      _listChangeDays = changeDays.results;
      if (_listChangeDays.isEmpty) {
        _resultStatus = ResultStatus.noData;
        notifyListeners();
        return _listChangeDays;
      } else {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return _listChangeDays;
      }
    } on TimeoutException catch (_) {
      if (!context.mounted) return;
      showFailSnackbar(context, errTimeOutMsg);
      notifyListeners();
      return _message;
    } on SocketException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = errMessageNoInternet;
      notifyListeners();
      return _message;
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = errMessage;
      notifyListeners();
      return _message;
    }
  }

  Future<dynamic> addChangeDays(BuildContext context, String start, String end, String remarks) async {
    try {
      Map<String, dynamic> response = await api.addChangeDays(start, end, remarks);
      ResponseChangeDays respChangeDays = ResponseChangeDays.fromJson(response);
      if (respChangeDays.theme == "success") {
        fetchChangeDays(context);
        notifyListeners();
        return respChangeDays;
      } else {
        return respChangeDays;
      }
    } on TimeoutException catch (_) {
      Navigator.pop(context);
      if (!context.mounted) return;
      showFailedDialog(context, titleFailed: "Failed", descriptionFailed: errTimeOutMsg);
      return;
    } on SocketException catch (_) {
      Navigator.pop(context);
      showFailedDialog(context, titleFailed: "Failed", descriptionFailed: errMessageNoInternet);
      return;
    } catch (e) {
      Navigator.pop(context);
      showFailedDialog(context, titleFailed: "Failed", descriptionFailed: errMessage);
      notifyListeners();
      return;
    }
  }

  Future<void> cancelRequest(BuildContext context, String id) async {
    Map<String, dynamic> response = await api.cancelRequest(id);
    ResponseChangeDays respChangeDays = ResponseChangeDays.fromJson(response);
    if (respChangeDays.message == "success") {
      return;
    } else {
      return showFailedDialog(context, titleFailed: respChangeDays.title, descriptionFailed: respChangeDays.message);
    }
  }
}
