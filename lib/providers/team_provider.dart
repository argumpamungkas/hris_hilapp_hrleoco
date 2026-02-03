import 'dart:async';

import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/response/team_model.dart';
import 'package:easy_hris/data/network/api/api_home.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../injection.dart';

class TeamProvider with ChangeNotifier {
  final ApiHome _api = ApiHome();
  final _prefs = sl<SharedPreferences>();

  ResultStatus _resultStatus = ResultStatus.init;
  String _message = '';

  TextEditingController _searchC = TextEditingController();

  List<TeamModel> _listTeams = [];
  List<TeamModel> _listTeamsFilter = [];
  bool _isFilter = false;

  ResultStatus get resultStatus => _resultStatus;
  String get message => _message;

  TextEditingController get searchC => _searchC;

  List<TeamModel> get listTeam => _listTeams;
  List<TeamModel> get listTeamFilter => _listTeamsFilter;
  bool get isFilter => _isFilter;

  TeamProvider() {
    fetchTeams();
  }

  Future<void> fetchTeams() async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final result = await _api.fetchTeam(number ?? '');

      if (result.theme == 'success') {
        if (result.result!.isEmpty) {
          _resultStatus = ResultStatus.noData;
          notifyListeners();
        } else {
          _listTeams = result.result!;
          _resultStatus = ResultStatus.hasData;
          _message = 'Permission Today is Empty';
          notifyListeners();
        }
      } else {
        _resultStatus = ResultStatus.error;
        _message = result.message!;
        notifyListeners();
      }
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = e.toString();
      notifyListeners();
      return;
    }
  }

  void onChangeIsSearch(bool value) {
    if (!value) {
      _searchC.clear();
      _listTeamsFilter.clear();
    } else {
      _listTeamsFilter = _listTeams;
    }

    _isFilter = value;

    notifyListeners();
  }

  void onSearch(String value) {
    if (value.isNotEmpty) {
      _listTeamsFilter = _listTeams.where((e) {
        /// ambil query yang disearch
        final keywords = value.toLowerCase().trim().split(' ');

        /// multiple search
        final searchable = [e.name, e.number, e.positionName].join(" ").toLowerCase();

        /// kembalikan nilai sesuai search
        return keywords.every((k) => searchable.contains(k.toLowerCase()));
      }).toList();
    } else {
      _isFilter = false;
    }

    notifyListeners();
  }
}
