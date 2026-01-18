import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/request/education_request.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../constant/constant.dart';
import '../../../data/models/response/id_name_model.dart';
import '../../../data/network/api/api_employee.dart';

class AddEducationProvider extends ChangeNotifier {
  final ApiEmployee _api = ApiEmployee();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _educationLevelController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _qpaController = TextEditingController();

  List<IdNameModel> _listEducationLevel = [];

  ResultStatus _resultStatus = ResultStatus.init;
  String _title = '';
  String _message = '';

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get educationLevelController => _educationLevelController;
  TextEditingController get degreeController => _degreeController;
  TextEditingController get schoolController => _schoolController;
  TextEditingController get startController => _startController;
  TextEditingController get endController => _endController;
  TextEditingController get qpaController => _qpaController;

  List<IdNameModel> get listEducationLevel => _listEducationLevel;

  ResultStatus get resultStatus => _resultStatus;

  String get title => _title;
  String get message => _message;

  AddEducationProvider() {
    fetchEducationLevel();
  }

  Future<void> fetchEducationLevel() async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();

    try {
      final result = await _api.fetchMaster("education_level");

      if (result.theme == "success") {
        _listEducationLevel = result.result!;
        _resultStatus = ResultStatus.hasData;
      } else {
        _title = result.title!;
        _message = result.message!;
        _resultStatus = ResultStatus.noData;
      }

      notifyListeners();
    } catch (e) {
      _title = "Failed";
      _resultStatus = ResultStatus.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  void onChangeEducationLevel(String value) {
    _educationLevelController.text = value;
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

  Future<bool> addEducation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final number = prefs.getString(ConstantSharedPref.numberUser);

    final request = EducationRequest(
      number: number ?? "",
      educationLevel: _educationLevelController.text,
      degree: _degreeController.text,
      school: _schoolController.text,
      start: _startController.text,
      end: _endController.text,
      qpa: _qpaController.text,
    );

    try {
      final result = await _api.addEducation(request);

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
