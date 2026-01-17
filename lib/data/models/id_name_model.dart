class IdNameModel {
  String id;
  String name;

  IdNameModel({required this.id, required this.name});

  factory IdNameModel.fromJson(Map<String, dynamic> json) => IdNameModel(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  static List<IdNameModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => IdNameModel.fromJson(json)).toList();
  }
}
