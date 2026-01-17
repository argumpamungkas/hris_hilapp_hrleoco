class NotifResponse {
  int total;
  List<ResultNotif> resultNotification;

  NotifResponse({
    required this.total,
    required this.resultNotification,
  });

  factory NotifResponse.fromJson(Map<String, dynamic> json) => NotifResponse(
        total: json['total'],
        resultNotification: List<ResultNotif>.from(
          json['results'].map((x) => ResultNotif.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "results":
            List<dynamic>.from(resultNotification.map((x) => x.toJson())),
      };
}

class ResultNotif {
  String module;
  String approvedTo;
  String createdBy;
  String createdDate;
  String avatar;
  String fullname;
  String message;

  ResultNotif({
    required this.module,
    required this.approvedTo,
    required this.createdBy,
    required this.createdDate,
    required this.avatar,
    required this.fullname,
    required this.message,
  });

  factory ResultNotif.fromJson(Map<String, dynamic> json) => ResultNotif(
        module: json["module"],
        approvedTo: json["approved_to"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        avatar: json["avatar"],
        fullname: json["fullname"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "module": module,
        "approved_to": approvedTo,
        "created_by": createdBy,
        "created_date": createdDate,
        "avatar": avatar,
        "fullname": fullname,
        "message": message,
      };
}
