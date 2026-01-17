import 'package:flutter/material.dart';

import '../../../constant/constant.dart';
import '../../../data/models/days_off.dart';
import '../../../data/network/api/api_dashboard.dart';
import '../../util/utils.dart';

class AttendanceTeamController extends ChangeNotifier {
  final ApiDashboard _api = ApiDashboard();

  List<ResultsDaysOff> _listDaysOff = [];
  late String _linkServer;
  late String _message;
  // ResultStatus _resultStatus = ResultStatus.init;
  ResultStatus _resultStatus = ResultStatus.hasData;
  List<ResultsDaysOff> _listFilter = [];
  bool _searchFiltered = false;

  List<ResultsDaysOff> get listDaysOff => _listDaysOff;
  String get linkServer => _linkServer;
  String get message => _message;
  ResultStatus get resultStatus => _resultStatus;
  List<ResultsDaysOff> get listFilter => _listFilter;
  bool get searchFiltered => _searchFiltered;

  Future<List<ResultsDaysOff>> fetchDaysOff() async {
    _resultStatus = ResultStatus.loading;
    _linkServer = await getLink();
    notifyListeners();
    try {
      Map<String, dynamic> respDaysOff = await _api.fetchDaysOff();
      DaysOff daysOff = DaysOff.fromJson(respDaysOff);
      _listDaysOff = daysOff.results;
      if (_listDaysOff.isEmpty) {
        _resultStatus = ResultStatus.noData;
        notifyListeners();
        return _listDaysOff;
      } else {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return _listDaysOff;
      }
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = "An error occurred while fetching data";
      notifyListeners();
      return [];
    }
  }

  List<Map<String, dynamic>> listFilterValue = [
    {'title': "Permit", 'color': "blue"},
    {'title': "On Time", 'color': "green"},
    {'title': "Late", 'color': "orange"},
    {'title': "Un Setting", 'color': "red"},
  ];

  // filter
  Future<void> filterData(String query) async {
    _searchFiltered = true;
    _listFilter.clear();
    notifyListeners();

    _listFilter.addAll(_listDaysOff.where((element) => element.color.contains(query)));

    _listFilter = _listFilter.toSet().toList();
    // debugPrint("$_listFilter");
    if (_listFilter.isNotEmpty) {
      _resultStatus = ResultStatus.hasData;
      notifyListeners();
    } else {
      _resultStatus = ResultStatus.noData;
      notifyListeners();
    }
  }

  void clearFilter() {
    _searchFiltered = false;
    _listFilter.clear();
    notifyListeners();
  }
}
