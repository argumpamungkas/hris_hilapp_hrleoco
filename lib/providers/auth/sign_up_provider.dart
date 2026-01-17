import 'package:flutter/material.dart';

import '../../data/network/api/api_auth.dart';

class SignUpProvider with ChangeNotifier {
  final ApiAuth _apiAuth = ApiAuth();

  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _companyCodeController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _repeatPwdController = TextEditingController();
  bool _pwdVisible = true;
  bool _repeatPwdVisible = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = "";
  String _message = "";

  bool get pwdVisible => _pwdVisible;
  bool get repeatPwdVisible => _repeatPwdVisible;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get employeeIdController => _employeeIdController;
  TextEditingController get companyCodeController => _companyCodeController;
  TextEditingController get pwdController => _pwdController;
  TextEditingController get repeatPwdController => _repeatPwdController;
  GlobalKey<FormState> get formKey => _formKey;

  String get title => _title;
  String get message => _message;

  void visiblePassword() {
    _pwdVisible = !_pwdVisible;
    notifyListeners();
  }

  void visibleRepPassword() {
    _repeatPwdVisible = !_repeatPwdVisible;
    notifyListeners();
  }

  Future<bool> createAccount(BuildContext context) async {
    try {
      Map<String, dynamic> result = await _apiAuth.registerUser(_employeeIdController.text, _usernameController.text, _pwdController.text);

      _title = result['title'];
      _message = result['message'];
      var status = result['theme'];

      if (status == "error") {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      _title = "Failed";
      _message = e.toString();
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _employeeIdController.dispose();
    _usernameController.dispose();
    _companyCodeController.dispose();
    _pwdController.dispose();
    _repeatPwdController.dispose();
    _pwdVisible = true;
    _repeatPwdVisible = true;
  }
}
