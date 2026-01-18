import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? departementId;
  String? number;
  String? name;
  String? description;
  String? username;
  // String? password;
  String? email;
  String? phone;
  String? position;
  String? avatar;
  String? theme;
  String? roles;

  UserModel({
    required this.departementId,
    required this.number,
    required this.name,
    required this.description,
    required this.username,
    // required this.password,
    required this.email,
    required this.phone,
    required this.position,
    required this.avatar,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    departementId: json["departement_id"] ?? "",
    number: json["number"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    username: json["username"] ?? "",
    // password: json["password"] ?? "",
    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    position: json["position"] ?? "",
    avatar: json["avatar"] ?? "",
    roles: json["roles"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "departement_id": departementId,
    "number": number,
    "name": name,
    "description": description,
    "username": username,
    // "password": password,
    "email": email,
    "phone": phone,
    "position": position,
    "avatar": avatar,
    "theme": theme,
    "roles": roles,
  };
}
