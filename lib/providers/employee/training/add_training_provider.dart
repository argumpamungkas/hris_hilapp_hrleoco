import 'package:easy_hris/data/models/request/training_request.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../constant/constant.dart';
import '../../../constant/exports.dart';
import '../../../data/network/api/api_employee.dart';
import '../../../injection.dart';

class AddTrainingProvider extends ChangeNotifier {
  final ApiEmployee _api = ApiEmployee();
  final _prefs = sl<SharedPreferences>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _trainingNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  ResultStatus _resultStatus = ResultStatus.init;
  String _title = '';
  String _message = '';

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get trainingNameController => _trainingNameController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get dateController => _dateController;
  TextEditingController get professionController => _professionController;
  TextEditingController get contactController => _contactController;

  ResultStatus get resultStatus => _resultStatus;

  String get title => _title;
  String get message => _message;

  AddTrainingProvider() {
    _resultStatus = ResultStatus.hasData;
    notifyListeners();
  }

  void onChangePicker(DateTime? pickDate) {
    _dateController.text = DateFormat('yyyy-MM-dd').format(pickDate!);
    notifyListeners();
  }

  Future<bool> addTraining() async {
    final number = _prefs.getString(ConstantSharedPref.numberUser);

    final request = TrainingRequest(
      number: number ?? "",
      name: _trainingNameController.text,
      description: _descriptionController.text,
      start: _dateController.text,
      profession: _professionController.text,
      contact: _contactController.text,
    );

    try {
      final result = await _api.addTraining(request);

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
