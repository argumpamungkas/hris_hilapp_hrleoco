class TeamModel {
  String? number;
  String? name;
  String? positionName;
  String? mobilePhone;
  String? imageProfile;

  TeamModel({required this.number, required this.name, required this.positionName, required this.mobilePhone, required this.imageProfile});

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
    number: json["number"] ?? "",
    name: json["name"] ?? "",
    positionName: json["position_name"] ?? "",
    mobilePhone: json["mobile_phone"] ?? "",
    imageProfile: json["image_profile"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
    "position_name": positionName,
    "mobile_phone": mobilePhone,
    "image_profile": imageProfile,
  };

  static List<TeamModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TeamModel.fromJson(json)).toList();
  }
}
