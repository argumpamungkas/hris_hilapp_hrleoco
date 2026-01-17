class Teams {
  String title;
  String message;
  String theme;
  List<ResultTeams> results;

  Teams({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
        title: json["title"],
        message: json["message"],
        theme: json["theme"],
        results: List<ResultTeams>.from(
            json["results"].map((x) => ResultTeams.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "theme": theme,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultTeams {
  String position;
  List<Detail> details;

  ResultTeams({
    required this.position,
    required this.details,
  });

  factory ResultTeams.fromJson(Map<String, dynamic> json) => ResultTeams(
        position: json["position"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  String avatar;
  String name;
  String telp;
  String services;
  String employeeId;
  String dateSign;

  Detail({
    required this.avatar,
    required this.name,
    required this.telp,
    required this.services,
    required this.employeeId,
    required this.dateSign,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        avatar: json["avatar"],
        name: json["name"],
        telp: json["telp"],
        services: json["services"],
        employeeId: json["employee_id"],
        dateSign: json["date_sign"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "name": name,
        "telp": telp,
        "services": services,
        "employeeId": employeeId,
        "date_sign": dateSign,
      };
}
