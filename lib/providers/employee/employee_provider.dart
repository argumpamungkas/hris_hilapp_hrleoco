import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/employee_response_model.dart';
import 'package:easy_hris/data/network/api/api_employee.dart';
import 'package:flutter/widgets.dart';

class EmployeeProvider extends ChangeNotifier {
  final ApiEmployee _api = ApiEmployee();
  int _index = 0;

  final List<String> _tabs = ["Company", "Personal Data", "Family", "Education", "Experience", "Training", "Career"];

  ResultStatus _resultStatus = ResultStatus.init;

  String _title = '';
  String _message = '';

  List<String> get tabs => _tabs;

  EmployeeResponseModel? _employeeResponseModel;

  int get index => _index;

  ResultStatus get resultStatus => _resultStatus;

  String get title => _title;
  String get message => _message;

  EmployeeResponseModel? get employeeResponseModel => _employeeResponseModel;

  EmployeeProvider() {
    fetchEmployee();
  }

  void onChangeTabs(int value) {
    _index = value;
    notifyListeners();
  }

  Future<void> fetchEmployee() async {
    print("aaa");
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      print("1");
      final prefs = await SharedPreferences.getInstance();
      print("2");
      final number = prefs.getString(ConstantSharedPref.numberUser);
      print("3");
      final result = await _api.fetchEmployeeUser(number ?? "");

      if (result.theme == "success") {
        _employeeResponseModel = result.result;
        _resultStatus = ResultStatus.hasData;
      } else {
        _title = result.title!;
        _message = result.message!;
        _resultStatus = ResultStatus.noData;
      }
      notifyListeners();
    } catch (e, trace) {
      print("error $e");
      print("Trace $trace");
      _title = "Failed"!;
      _message = e.toString()!;
      _resultStatus = ResultStatus.error;
    }
  }

  Future<bool> deleteEmployee(String id, String endPointDelete) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final number = prefs.getString(ConstantSharedPref.numberUser);

    try {
      final result = await _api.deleteEmployee(id, number ?? "", endPointDelete);

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
