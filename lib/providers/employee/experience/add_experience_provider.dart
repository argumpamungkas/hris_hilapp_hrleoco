import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/data/models/request/experience_request.dart';
import 'package:easy_hris/data/network/api/api_employee.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../constant/exports.dart';

class AddExperienceProvider extends ChangeNotifier {
  final ApiEmployee _api = ApiEmployee();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _industriesTypeController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  ResultStatus _resultStatus = ResultStatus.init;

  String _title = '';
  String _message = '';

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get companyNameController => _companyNameController;
  TextEditingController get industriesTypeController => _industriesTypeController;
  TextEditingController get startController => _startController;
  TextEditingController get endController => _endController;
  TextEditingController get positionController => _positionController;
  TextEditingController get salaryController => _salaryController;

  ResultStatus get resultStatus => _resultStatus;

  String get title => _title;
  String get message => _message;

  AddExperienceProvider() {
    _resultStatus = ResultStatus.hasData;
    notifyListeners();
  }

  void onChangePickerStart(DateTime pickDate) {
    // _startController.text = DateFormat('yyyy-MM-dd').format(pickDate!);
    _startController.text = pickDate.year.toString();
    notifyListeners();
  }

  void onChangePickerEnd(DateTime pickDate) {
    // _endController.text = DateFormat('yyyy-MM-dd').format(pickDate!);
    _endController.text = pickDate.year.toString();
    notifyListeners();
  }

  Future<bool> addExperience() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final number = prefs.getString(ConstantSharedPref.numberUser);

    final request = ExperienceRequest(
      number: number ?? "",
      name: _companyNameController.text,
      type: _industriesTypeController.text,
      start: _startController.text,
      end: _endController.text,
      position: _positionController.text,
      salary: _salaryController.text,
    );

    try {
      final result = await _api.addExperience(request);

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
