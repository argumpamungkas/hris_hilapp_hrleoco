import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../data/models/news.dart';
import '../../data/network/api/api_dashboard.dart';
import '../../ui/util/utils.dart';

class NewsProvider extends ChangeNotifier {
  final ApiDashboard _api = ApiDashboard();

  List<ResultsNews> _listNews = [];
  late String _linkServer;
  ResultStatus _resultStatus = ResultStatus.init;
  late String _message;

  List<ResultsNews> get listNews => _listNews;
  String get linkServer => _linkServer;
  ResultStatus get resultStatus => _resultStatus;
  String get message => _message;

  NewsProvider() {
    fetchNews();
  }

  Future<dynamic> fetchNews() async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    _linkServer = await getLink();
    try {
      Map<String, dynamic> respNews = await _api.fetchNews();
      News news = News.fromJson(respNews);
      _listNews = news.results;
      if (_listNews.isEmpty) {
        _resultStatus = ResultStatus.noData;
        notifyListeners();
        return _listNews;
      } else {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return listNews;
      }
    } on TimeoutException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = errTimeOutMsg;
      notifyListeners();
      return;
    } on SocketException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = errMessageNoInternet;
      notifyListeners();
      return;
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = errMessage;
      notifyListeners();
      return;
    }
  }
}
