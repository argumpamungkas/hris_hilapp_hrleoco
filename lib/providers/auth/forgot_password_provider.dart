import 'package:flutter/material.dart';

import '../../data/network/api/api_auth.dart';

class ForgotPasswordProvider with ChangeNotifier {
  final ApiAuth _api = ApiAuth();

  final TextEditingController _emailC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _message = "";

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController get emailC => _emailC;

  String get title => _title;
  String get message => _message;

  Future<bool> resetPassword(BuildContext context) async {
    try {
      var result = await _api.forgotPassword(_emailC.text);
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
}
