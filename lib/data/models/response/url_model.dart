class UrlModel {
  String? link;
  String? access;

  UrlModel({required this.link, required this.access});

  factory UrlModel.fromJson(Map<String, dynamic> json) => UrlModel(link: json['link'], access: json['access']);

  Map<String, dynamic> toJson() => {'link': link, 'access': access};
}
