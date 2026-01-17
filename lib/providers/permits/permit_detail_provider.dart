import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constant/constant.dart';
import '../../data/models/permit.dart';
import '../../data/network/api/api_permit.dart';
import '../../ui/util/utils.dart';

class PermitDetailProvider extends ChangeNotifier {
  final ApiPermit _api = ApiPermit();

  String _permitDate = '';
  String _message = '';

  String get permitDate => _permitDate;

  String get message => _message;

  PermitDetailProvider(ResultPermit resultPermit) {
    _convert(resultPermit);
  }

  void _convert(ResultPermit resultPermit) {
    if (resultPermit.permitDate != null) {
      var dateFormatDefautlt = DateFormat("yyyy-MM-dd").parse(resultPermit.permitDate!);
      _permitDate = formatCreated(dateFormatDefautlt);
    }
    notifyListeners();
  }

  Future<bool> cancelRequestPermit(String id) async {
    try {
      Map<String, dynamic> response = await _api.cancelRequestPermit(id);
      ResponsePermit responsePermit = ResponsePermit.fromJson(response);
      // print("RESPONSE ${responsePermit.toJson()}");
      if (responsePermit.theme == "success") {
        _message = "Data success canceled";
        return true;
      } else {
        _message = responsePermit.message;
        notifyListeners();
        return false;
      }
    } on TimeoutException catch (_) {
      _message = errTimeOutMsg;
      notifyListeners();
      return false;
    } on SocketException catch (_) {
      _message = errMessageNoInternet;
      notifyListeners();
      return false;
    } catch (e) {
      _message = errMessage;
      notifyListeners();
      return false;
    }
  }
}
