import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../data/models/pay_slip.dart';
import '../../data/network/api/api_pay_slip.dart';
import '../../ui/util/utils.dart';

class PayslipProvider with ChangeNotifier {
  ApiPaySlip api = ApiPaySlip();

  // PaySlipController() {
  //   fetchPaySlip();
  // }

  List<ResultsPaySlip> _listPaySlip = [];
  ResultStatus _resultStatus = ResultStatus.init;
  late String _message;

  List<ResultsPaySlip> get listPaySlip => _listPaySlip;
  ResultStatus get resultStatus => _resultStatus;
  String get message => _message;

  Future<dynamic> fetchPaySlip(BuildContext context) async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      var response = await api.fetchPaySlip();
      PaySlip paySlip = PaySlip.fromJson(response);
      _listPaySlip = paySlip.results;
      if (_listPaySlip.isEmpty) {
        _resultStatus = ResultStatus.noData;
        notifyListeners();
        return _listPaySlip;
      } else {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return _listPaySlip;
      }
    } on TimeoutException catch (_) {
      if (!context.mounted) return;
      showFailSnackbar(context, errTimeOutMsg);
      notifyListeners();
    } on SocketException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = errMessageNoInternet;
      notifyListeners();
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = errMessage;
      notifyListeners();
    }
  }
}
