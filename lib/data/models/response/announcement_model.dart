class AnnouncementModel {
  String? title;
  String? displayDate;
  String? name;
  String? imageProfile;
  String? positionName;
  String? departmentName;
  String? description;
  String? attachment;

  AnnouncementModel({
    required this.title,
    required this.displayDate,
    required this.name,
    required this.imageProfile,
    required this.positionName,
    required this.departmentName,
    required this.description,
    required this.attachment,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) => AnnouncementModel(
    title: json["title"] ?? '',
    displayDate: json["display_date"] ?? '',
    name: json["name"] ?? '',
    imageProfile: json["image_profile"] ?? '',
    positionName: json["position_name"] ?? '',
    departmentName: json["position_name"] ?? '',
    description: json["description"] ?? '',
    attachment: json["attachment"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image_profile": imageProfile,
    "permit_name": title,
    "display_date": displayDate,
    "position_name": positionName,
    "description": description,
    "attachment": attachment,
  };

  static List<AnnouncementModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AnnouncementModel.fromJson(json)).toList();
  }
}
