import 'package:easy_hris/data/services/url_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant/constant.dart';
import '../constant/styles.dart';
import '../data/helpers/preferences_helper.dart';
import '../data/models/response/config_model.dart';
import '../data/network/api/api_auth.dart';
import '../injection.dart';

class PreferencesProvider extends ChangeNotifier {
  final ApiAuth _api = ApiAuth();
  final _urlServices = sl<UrlServices>();

  PreferencesHelper preferencesHelper;
  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  ResultStatus _resultStatus = ResultStatus.init;

  ConfigModel? _configModel;

  String _baseUrl = '';
  bool _isUpdatePersonalData = false;

  String _title = '';
  String _message = '';

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  ConfigModel? get configModel => _configModel;
  ResultStatus get resultStatus => _resultStatus;
  String get baseUrl => _baseUrl;
  String get title => _title;
  String get message => _message;
  bool get isUpdatePersonalData => _isUpdatePersonalData;

  PreferencesProvider({required this.preferencesHelper}) {
    // fetchInit();
    _getDarkTheme();
  }

  Future<void> getUrl() async {
    final urlModel = await _urlServices.getUrlModel();
    _baseUrl = urlModel!.link!;
    return;
  }

  Future<void> fetchInit() async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();

    try {
      final result = await _api.fetchConfig();

      if (result.theme == 'success') {
        _configModel = result.result;

        /// Cek untuk periode update data employee
        if (_configModel!.empDateStart!.isNotEmpty && _configModel!.empDateEnd!.isNotEmpty) {
          checkUpdatePersonalData();
        }
        _resultStatus = ResultStatus.hasData;
        await getUrl();
        notifyListeners();
      } else {
        _title = result.title!;
        _message = result.message!;
        _resultStatus = ResultStatus.noData;
        await getUrl();
        notifyListeners();
      }
    } catch (e, trace) {
      _title = 'Failed';
      _message = e.toString();
      _resultStatus = ResultStatus.error;
      notifyListeners();
    }
  }

  void checkUpdatePersonalData() {
    final now = DateTime.now().toLocal();

    final dateNow = DateTime(now.year, now.month, now.day);

    final dateStart = DateFormat('yyyy-MM-dd').parse(_configModel!.empDateStart!);
    final dateEnd = DateFormat('yyyy-MM-dd').parse(_configModel!.empDateEnd!);

    if (dateNow.isBefore(dateStart) || dateNow.isAfter(dateEnd)) {
      _isUpdatePersonalData = false;
    } else {
      _isUpdatePersonalData = true;
    }

    // print("is update $isUpdatePersonalData");
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
