import 'package:flutter/widgets.dart';

class HelpCenterProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  HelpCenterProvider() {}

  void onChangeTab(int idx) {
    _index = idx;
    notifyListeners();
  }
}
