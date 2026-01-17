import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../constant/styles.dart';
import '../data/helpers/preferences_helper.dart';
import '../data/models/config_models.dart';
import '../data/network/api/api_auth.dart';

class PreferencesProvider extends ChangeNotifier {
  final ApiAuth _api = ApiAuth();
  PreferencesHelper preferencesHelper;
  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  ResultStatus _resultStatus = ResultStatus.init;

  ConfigModel? _configModel;

  String _message = '';

  PreferencesProvider({required this.preferencesHelper}) {
    fetchInit();
    _getDarkTheme();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  ConfigModel? get configModel => _configModel;
  ResultStatus get resultStatus => _resultStatus;
  String get message => _message;

  Future<dynamic> fetchInit() async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();

    try {
      Map<String, dynamic> result = await _api.fetchConfig();

      if (result["theme"] == "success") {
        _configModel = ConfigModel.fromJson(result);
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
      } else {
        _message = result['message'];
        _resultStatus = ResultStatus.noData;
        notifyListeners();
      }
    } catch (e) {
      _message = e.toString();
      _resultStatus = ResultStatus.error;
      notifyListeners();
    }
  }

  void _getDarkTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void enableDarkTheme() {
    _isDarkTheme = !_isDarkTheme;
    preferencesHelper.setDarkTheme(_isDarkTheme);
    _getDarkTheme();
  }
}
