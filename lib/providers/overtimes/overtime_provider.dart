import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../data/models/overtime.dart';
import '../../data/network/api/api_overtime.dart';
import '../../ui/util/utils.dart';

class OvertimeProvider extends ChangeNotifier {
  final ApiOvertime _api = ApiOvertime();

  OvertimeProvider() {
    _getLinkServer();
  }

  DateTime _initDate = DateTime.now();
  List<ResultsOvertime> _listOvertime = [];
  ResultStatus _resultStatus = ResultStatus.init;

  DateTime get initDate => _initDate;
  late String _linkServer;
  late String _message;

  List<ResultsOvertime> get listOvertime => _listOvertime;

  ResultStatus get resultStatus => _resultStatus;

  String get linkServer => _linkServer;

  String get message => _message;

  void _getLinkServer() async {
    _linkServer = await getLink();
  }

  Future<dynamic> fetchOvertime(int year) async {
    _resultStatus = ResultStatus.loading;
    _linkServer = await getLink();
    notifyListeners();
    try {
      Map<String, dynamic> response = await _api.fetchOvertime(year);
      Overtime overtime = Overtime.fromJson(response);
      _listOvertime = overtime.results;
      if (_listOvertime.isEmpty) {
        _resultStatus = ResultStatus.noData;
        notifyListeners();
        return [];
      } else {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return _listOvertime;
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
