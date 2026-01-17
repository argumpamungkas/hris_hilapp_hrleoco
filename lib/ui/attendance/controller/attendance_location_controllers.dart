import 'package:flutter/widgets.dart';

import '../../../constant/constant.dart';
import '../../../data/models/location_office.dart';
import '../../../data/network/api/api_attendance.dart';

class AttendanceLocationController extends ChangeNotifier {
  ApiAttendance apiAttendance = ApiAttendance();
  List<ResultsLocationOffice> _listResultLocationOffice = [];
  ResultsLocationOffice? _resultsLocationOffice;
  double? _latOffice;
  double? _longOffice;
  double? _radius;

  ResultStatus _resultStatus = ResultStatus.init;
  late String _message;

  List<ResultsLocationOffice> get listResultLocationOffice => _listResultLocationOffice;
  ResultsLocationOffice? get resultsLocationOffice => _resultsLocationOffice;
  double? get latOffice => _latOffice;
  double? get longOffice => _longOffice;
  double? get radius => _radius;
  ResultStatus get resultStatus => _resultStatus;
  String get message => _message;

  setAttendanceLocation(ResultsLocationOffice value) {
    _resultsLocationOffice = value;
    _latOffice = double.parse(_resultsLocationOffice!.latitude!);
    _longOffice = double.parse(_resultsLocationOffice!.longitude!);
    _radius = double.parse(_resultsLocationOffice!.radius!);
    notifyListeners();
  }

  void clearData() {
    _resultsLocationOffice = null;
  }

  Future<List<ResultsLocationOffice>> getLocationOffice(String divisionName) async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      Map<String, dynamic> respLocOffice = await apiAttendance.fetchLocationOffice();
      LocationOffice locOffice = LocationOffice.fromJson(respLocOffice);
      _listResultLocationOffice = locOffice.results;
      if (_listResultLocationOffice.isNotEmpty) {
        for (var element in _listResultLocationOffice) {
          if (element.name == divisionName) {
            setAttendanceLocation(element);
          }
        }
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return _listResultLocationOffice;
      } else {
        _resultStatus = ResultStatus.noData;
        notifyListeners();
        return [];
      }
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = errMessage;
      notifyListeners();
      return [];
    }
  }
}
