import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/constant.dart';
import '../../constant/routes.dart';
import '../../data/models/profile.dart';
import '../../data/network/api/api_auth.dart';
import '../../ui/util/utils.dart';

class ProfileChangePasswordProvider extends ChangeNotifier {
  final ApiAuth _api = ApiAuth();

  late UserChangeInPassword _userChangeInPassword;
  ResultStatus _resultStatus = ResultStatus.init;
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _repeatPwdController = TextEditingController();
  bool _pwdVisible = true;
  bool _repeatPwdVisible = true;
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _message = '';

  UserChangeInPassword get userChangeInPassword => _userChangeInPassword;
  ResultStatus get resultStatus => _resultStatus;
  TextEditingController get pwdController => _pwdController;
  TextEditingController get repeatPwdController => _repeatPwdController;
  bool get pwdVisible => _pwdVisible;
  bool get repeatPwdVisible => _repeatPwdVisible;
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

  Future<bool> changePassword(String username) async {
    try {
      final result = await _api.changePassword(username, _pwdController.text);
      if (result.theme == "success") {
        _title = result.title!;
        _message = result.message!;
        notifyListeners();
        return true;
      } else {
        _title = result.title!;
        _message = result.message!;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _title = "Failed";
      _message = e.toString();
      notifyListeners();
      return false;
    }
  }

  void _clearController() {
    _pwdController.clear();
    _repeatPwdController.clear();
    _pwdVisible = true;
    _repeatPwdVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
    _pwdController.dispose();
    _repeatPwdController.dispose();
  }
}
