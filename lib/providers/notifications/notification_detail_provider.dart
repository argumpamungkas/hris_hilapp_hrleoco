import 'package:flutter/foundation.dart';

import '../../constant/constant.dart';
import '../../data/models/notifications/notification_detail_response_change_days.dart';
import '../../data/models/notifications/notification_detail_response_overtime.dart';
import '../../data/models/notifications/notification_detail_response_permit.dart';
import '../../data/models/notifications/notification_response.dart';
import '../../data/models/response_info.dart';
import '../../data/network/api/api_notification.dart';

class NotificationDetailProvider extends ChangeNotifier {
  final ApiNotification _api = ApiNotification();

  NotificationDetailProvider({required ResultNotif dataNotif}) {
    fetchNotifDetail(dataNotif.approvedTo, dataNotif.createdBy, dataNotif.module);
  }

  List<ResultNotificationDetailChangeDays> _listChangeDays = [];
  List<ResultNotificationDetailPermit> _listPermit = [];
  List<ResultNotificationDetailOvertime> _listOvertime = [];
  ResultStatus _resultStatus = ResultStatus.init;
  late String _message;
  bool _selectAll = false;

  List<ResultNotificationDetailChangeDays> get detailChangeDays => _listChangeDays;
  List<ResultNotificationDetailPermit> get detailPermit => _listPermit;
  List<ResultNotificationDetailOvertime> get detailOvertime => _listOvertime;
  ResultStatus get resultStatus => _resultStatus;
  String get message => _message;
  bool get selectAll => _selectAll;

  setSelectAll() {
    _selectAll = !_selectAll;
    notifyListeners();
  }

  Future<dynamic> fetchNotifDetail(String approvedTo, String approvedBy, String module) async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      var response = await _api.fetchNotificationDetail(approvedTo, approvedBy, module);
      // print("FETCH NOTIF DETAIL $response");
      switch (module) {
        case "change_days":
          NotificationDetailResponseChangeDays resp = NotificationDetailResponseChangeDays.fromJson(response);
          if (resp.results.isEmpty) {
            _resultStatus = ResultStatus.noData;
            _message = "Data Change Days not found";
            notifyListeners();
            return _resultStatus;
          } else {
            _listChangeDays = resp.results;
            _resultStatus = ResultStatus.hasData;
            notifyListeners();
            return _listChangeDays;
          }
        case "permits":
          NotificationDetailResponsePermit resp = NotificationDetailResponsePermit.fromJson(response);
          if (resp.results.isEmpty) {
            _resultStatus = ResultStatus.noData;
            _message = "Data Permits not found";
            notifyListeners();
            return _resultStatus;
          } else {
            _listPermit = resp.results;
            _resultStatus = ResultStatus.hasData;
            notifyListeners();
            return _listPermit;
          }
        default:
          NotificationDetailResponseOvertime resp = NotificationDetailResponseOvertime.fromJson(response);
          if (resp.results.isEmpty) {
            _resultStatus = ResultStatus.noData;
            _message = "Data Permits not found";
            notifyListeners();
            return _resultStatus;
          } else {
            _listOvertime = resp.results;
            _resultStatus = ResultStatus.hasData;
            notifyListeners();
            return _listOvertime;
          }
      }
    } catch (e, trace) {
      // print("response error $e");
      // print("response error $trace");

      _resultStatus = ResultStatus.error;
      _message = "Check your connection.";
      notifyListeners();
      return _resultStatus;
    }
  }

  Future<dynamic> updateFetchNotifDetail(String approvedTo, String approvedBy, String module) async {
    try {
      var response = await _api.fetchNotificationDetail(approvedTo, approvedBy, module);
      switch (module) {
        case "change_days":
          NotificationDetailResponseChangeDays resp = NotificationDetailResponseChangeDays.fromJson(response);
          if (resp.results.isEmpty) {
            _resultStatus = ResultStatus.noData;
            _message = "Data Change Days not found";
            notifyListeners();
            return _resultStatus;
          } else {
            _listChangeDays = resp.results;
            _resultStatus = ResultStatus.hasData;
            notifyListeners();
            return _listChangeDays;
          }
        case "permits":
          NotificationDetailResponsePermit resp = NotificationDetailResponsePermit.fromJson(response);
          if (resp.results.isEmpty) {
            _resultStatus = ResultStatus.noData;
            _message = "Data Permits not found";
            notifyListeners();
            return _resultStatus;
          } else {
            _listPermit = resp.results;
            _resultStatus = ResultStatus.hasData;
            notifyListeners();
            return _listPermit;
          }
        default:
          NotificationDetailResponseOvertime resp = NotificationDetailResponseOvertime.fromJson(response);
          if (resp.results.isEmpty) {
            _resultStatus = ResultStatus.noData;
            _message = "Data Permits not found";
            notifyListeners();
            return _resultStatus;
          } else {
            _listOvertime = resp.results;
            _resultStatus = ResultStatus.hasData;
            notifyListeners();
            return _listOvertime;
          }
      }
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = "Check your connection.";
      notifyListeners();
      return _resultStatus;
    }
  }

  Future<ResponseInfo> approved(ResultNotif dataNotif, String id, String module) async {
    var response = await _api.approved(id, module);
    ResponseInfo resp = ResponseInfo.fromJson(response);
    if (resp.theme == "success") {
      updateFetchNotifDetail(dataNotif.approvedTo, dataNotif.createdBy, module);
      return resp;
    } else {
      return resp;
    }
  }

  Future<ResponseInfo> approvedAll({required ResultNotif dataNotif, required String module}) async {
    var response = await _api.approvedAll(module, dataNotif.approvedTo, dataNotif.createdBy);
    ResponseInfo resp = ResponseInfo.fromJson(response);
    if (resp.theme == "success") {
      updateFetchNotifDetail(dataNotif.approvedTo, dataNotif.createdBy, module);
      return resp;
    } else {
      return resp;
    }
  }

  Future<ResponseInfo> disapproved(ResultNotif dataNotif, String id, String module) async {
    var response = await _api.disapproved(id, module);
    ResponseInfo resp = ResponseInfo.fromJson(response);
    if (resp.theme == "success") {
      updateFetchNotifDetail(dataNotif.approvedTo, dataNotif.createdBy, module);
      return resp;
    } else {
      return resp;
    }
  }

  Future<ResponseInfo> disapprovedAll({required ResultNotif dataNotif, required String module}) async {
    var response = await _api.disapprovedAll(module, dataNotif.approvedTo, dataNotif.createdBy);
    ResponseInfo resp = ResponseInfo.fromJson(response);
    if (resp.theme == "success") {
      updateFetchNotifDetail(dataNotif.approvedTo, dataNotif.createdBy, module);
      return resp;
    } else {
      return resp;
    }
  }
}
