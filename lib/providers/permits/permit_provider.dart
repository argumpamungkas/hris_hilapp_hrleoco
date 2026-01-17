import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../data/models/permit.dart';
import '../../data/network/api/api_permit.dart';
import '../../ui/util/utils.dart';

class PermitProvider extends ChangeNotifier {
  ApiPermit api = ApiPermit();

  PermitProvider() {
    _getLinkServer();
    // fetchPermitType();
  }

  DateTime _initDate = DateTime.now();
  List<ResultPermit> _listPermit = [];
  ResultStatus _resultStatus = ResultStatus.init;

  DateTime get initDate => _initDate;
  late String _linkServer;
  late String _message;

  List<ResultPermit> get lisPermit => _listPermit;

  ResultStatus get resultStatus => _resultStatus;

  String get linkServer => _linkServer;

  String get message => _message;

  void _getLinkServer() async {
    _linkServer = await getLink();
  }

  Future<dynamic> fetchPermit(int year) async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      Map<String, dynamic> response = await api.fetchPermit(year);
      Permit permit = Permit.fromJson(response);
      _listPermit = permit.results;
      if (_listPermit.isEmpty) {
        _resultStatus = ResultStatus.noData;
        notifyListeners();
        return [];
      } else {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return _listPermit;
      }
    } on TimeoutException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = errTimeOutMsg;
      notifyListeners();
      return false;
    } on SocketException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = errMessageNoInternet;
      notifyListeners();
      return false;
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = errMessage;
      notifyListeners();
      return false;
    }
  }

  Future<void> onChangeYear(DateTime value) async {
    _initDate = value;
    notifyListeners();
  }
}
