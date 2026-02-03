class PermitTodayModel {
  String? name;
  String? permitName;
  String? note;
  String? imageProfile;

  PermitTodayModel({required this.name, required this.permitName, required this.note, required this.imageProfile});

  factory PermitTodayModel.fromJson(Map<String, dynamic> json) => PermitTodayModel(
    name: json["name"] ?? '',
    permitName: json["permit_name"] ?? '',
    note: json["note"] ?? '',
    imageProfile: json["image_profile"] ?? '',
  );

  Map<String, dynamic> toJson() => {"name": name, "permit_name": permitName, "note": note, "image_profile": imageProfile};

  static List<PermitTodayModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PermitTodayModel.fromJson(json)).toList();
  }
}
