import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/id_name_model.dart';
import 'package:easy_hris/data/models/request/family_request.dart';
import 'package:easy_hris/data/network/api/api_employee.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AddFamilyProvider extends ChangeNotifier {
  final ApiEmployee _api = ApiEmployee();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _placeOfBirthController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  List<IdNameModel> _listFamilyRelation = [];

  ResultStatus _resultStatus = ResultStatus.init;
  String _title = '';
  String _message = '';

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get nationalIdController => _nationalIdController;
  TextEditingController get familyNameController => _familyNameController;
  TextEditingController get placeOfBirthController => _placeOfBirthController;
  TextEditingController get birthdayController => _birthdayController;
  TextEditingController get relationController => _relationController;
  TextEditingController get professionController => _professionController;
  TextEditingController get contractController => _contactController;

  List<IdNameModel> get listFamilyRelation => _listFamilyRelation;

  ResultStatus get resultStatus => _resultStatus;

  String get title => _title;
  String get message => _message;

  AddFamilyProvider() {
    fetchMaster();
  }

  Future<void> fetchMaster() async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();

    try {
      final result = await _api.fetchMaster("family_relation");

      if (result.theme == "success") {
        _listFamilyRelation = result.result!;
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

  void onChangeRelation(String value) {
    _relationController.text = value;
    notifyListeners();
  }

  void onChangePicker(DateTime? pickDate) {
    _birthdayController.text = DateFormat('yyyy-MM-dd').format(pickDate!);
    notifyListeners();
  }

  Future<bool> addFamily() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final number = prefs.getString(ConstantSharedPref.numberUser);

    final request = FamilyRequest(
      number: number ?? "",
      nationalId: _nationalIdController.text,
      name: _familyNameController.text,
      place: _placeOfBirthController.text,
      birthday: _birthdayController.text,
      relation: _relationController.text,
      profession: _professionController.text,
      contact: _contactController.text,
    );

    try {
      final result = await _api.addFamily(request);

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

  Future<bool> deleteFamily(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final number = prefs.getString(ConstantSharedPref.numberUser);

    try {
      final result = await _api.deleteEmployee(id, number ?? "", "");

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
