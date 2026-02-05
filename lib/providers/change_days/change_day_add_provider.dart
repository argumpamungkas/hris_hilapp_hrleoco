import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/request/change_day_request.dart';
import 'package:easy_hris/data/network/api/api_change_day.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../injection.dart';
import '../../constant/constant.dart';

class ChangeDayAddProvider extends ChangeNotifier {
  final ApiChangeDay _api = ApiChangeDay();
  final _prefs = sl<SharedPreferences>();

  String _title = '';
  String _message = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dayFromController = TextEditingController();
  final TextEditingController _dayReplaceToController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String get title => _title;
  String get message => _message;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get dayFromController => _dayFromController;
  TextEditingController get dayReplaceToController => _dayReplaceToController;
  TextEditingController get noteController => _noteController;

  void onChangePickerDayFrom(DateTime? pickDate) {
    _dayFromController.text = DateFormat('yyyy-MM-dd').format(pickDate!);
    notifyListeners();
  }

  void onChangePickerReplaceTo(DateTime? pickDate) {
    _dayReplaceToController.text = DateFormat('yyyy-MM-dd').format(pickDate!);
    notifyListeners();
  }

  Future<bool> addCareer() async {
    final number = _prefs.getString(ConstantSharedPref.numberUser);

    final request = ChangeDayRequest(
      number: number ?? '',
      start: _dayFromController.text,
      end: _dayReplaceToController.text,
      remarks: _noteController.text,
    );

    try {
      final result = await _api.createChangeDay(request);

      if (result.theme == 'success') {
        _title = result.title!;
        _message = result.message!;
        return true;
      } else {
        _title = result.title!;
        _message = result.message!;
        return false;
      }
    } catch (e) {
      _title = "Failed";
      _message = e.toString();
      notifyListeners();
      return false;
    }
  }
}
