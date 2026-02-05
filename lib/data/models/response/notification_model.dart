class NotificationModel {
  String? tableId;
  String? tableName;
  String? name;
  String? position;
  String? avatar;
  String? description;
  DateTime createdDate;
  List<Detail> details;

  NotificationModel({
    required this.tableId,
    required this.tableName,
    required this.name,
    required this.position,
    required this.avatar,
    required this.description,
    required this.createdDate,
    required this.details,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    tableId: json["table_id"] ?? '',
    tableName: json["table_name"] ?? '',
    name: json["name"] ?? '',
    position: json["position"] ?? '',
    avatar: json["avatar"] ?? '',
    description: json["description"] ?? '',
    createdDate: DateTime.parse(json["created_date"]),
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "table_id": tableId,
    "table_name": tableName,
    "name": name,
    "position": position,
    "avatar": avatar,
    "description": description,
    "created_date": createdDate.toIso8601String(),
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };

  static List<NotificationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NotificationModel.fromJson(json)).toList();
  }
}

class Detail {
  String? description;
  String? value;

  Detail({required this.description, required this.value});

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(description: json["description"] ?? '', value: json["value"] ?? '');

  Map<String, dynamic> toJson() => {"description": description, "value": value};
}
