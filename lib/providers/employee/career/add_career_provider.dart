import 'package:easy_hris/data/models/request/career_request.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../constant/constant.dart';
import '../../../constant/exports.dart';
import '../../../data/network/api/api_employee.dart';

class AddCareerProvider extends ChangeNotifier {
  final ApiEmployee _api = ApiEmployee();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  // final TextEditingController _divisionController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _departmentSubController = TextEditingController();
  final TextEditingController _employeeTypeController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  ResultStatus _resultStatus = ResultStatus.init;
  String _title = '';
  String _message = '';

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get dateController => _dateController;
  // TextEditingController get divisionController => _divisionController;
  TextEditingController get departmentController => _departmentController;
  TextEditingController get departmentSubController => _departmentSubController;
  TextEditingController get employeeTypeController => _employeeTypeController;
  TextEditingController get positionController => _positionController;

  ResultStatus get resultStatus => _resultStatus;

  String get title => _title;
  String get message => _message;

  AddCareerProvider() {
    _resultStatus = ResultStatus.hasData;
    notifyListeners();
  }

  void onChangePicker(DateTime? pickDate) {
    _dateController.text = DateFormat('yyyy-MM-dd').format(pickDate!);
    notifyListeners();
  }

  Future<bool> addCareer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final number = prefs.getString(ConstantSharedPref.numberUser);

    final request = CareerRequest(
      number: number ?? "",
      name: _departmentController.text,
      description: _departmentSubController.text,
      start: _dateController.text,
      profession: _positionController.text,
      contact: _employeeTypeController.text,
    );

    try {
      final result = await _api.addCareer(request);

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
