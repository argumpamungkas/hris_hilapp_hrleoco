import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../data/models/teams.dart';
import '../data/network/api/api_dashboard.dart';
import '../ui/util/utils.dart';

class TeamProvider with ChangeNotifier {
  final ApiDashboard _api = ApiDashboard();

  TeamProvider() {
    fetchTeams();
  }

  List<ResultTeams> _listTeams = [];
  late String _linkServer;
  ResultStatus _resultStatus = ResultStatus.init;
  late String _message;

  List<ResultTeams> get listTeam => _listTeams;

  String get linkServer => _linkServer;

  ResultStatus get resultStatus => _resultStatus;

  String get message => _message;

  Future<dynamic> fetchTeams() async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    _linkServer = await getLink();
    try {
      Map<String, dynamic> respTeams = await _api.fetchTeams();
      Teams teams = Teams.fromJson(respTeams);
      _listTeams = teams.results;
      if (_listTeams.isEmpty) {
        _resultStatus = ResultStatus.noData;
        notifyListeners();
        return _listTeams;
      } else {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return _listTeams;
      }
    } on TimeoutException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = ConstantMessage.errMsgTimeOut;
      notifyListeners();
    } on SocketException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = ConstantMessage.errMsgNoInternet;
      notifyListeners();
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = '${ConstantMessage.errMsg} $e';
      notifyListeners();
    }
  }
}
