import 'package:flutter/material.dart';

const Color colorPurpleAccent = Color(0xFF7965C1);
const Color colorBlueDark = Color(0xFF23265A);
const String fontSpaceAge = "Space Age";
// String tokenFcm = "";
String errMessage = "Request to server is failed.";
String errMessageNoInternet = "Disconnect. You internet is not active";
String errTimeOutMsg = "You connection is bad. Request to server is low.";
// String baseUrlMaster = "https://app.hris-server.com";
// String versionApp = "v1.1.0";

class Constant {
  static const String baseUrlMaster = "https://app.hris-server.com";
  static const String fontSpaceAge = "Space Age";
  static const String tokenFcm = "";
  static const String versionApp = "v1.0.0";

  static const String logo = "assets/images/logo.png";
  static const String homeBg = "assets/images/home_bg.jpg";

  // static const String appVersion = "v1.1.0";
  static const String appVersion = "v1.1.1";

  // static const String baseUrl = "https://hrleoco.hris-server.com";
  static const String urlILogo = "assets/image/config/logo";
  static const String urlDefaultImage = "assets/image/users/default.png";
  static const String urlProfileImage = "assets/image/employee/profile";
  static const String urlProfileNpwp = "assets/image/employee/npwp";
  static const String urlProfileKk = "assets/image/employee/kk";
  static const String urlProfileKtp = "assets/image/employee/id";
  static const String bgIdCard = "assets/image/idcard_front.png";
  static const String urlAttendance = "assets/image/attandance";
}

class ConstantSharedPref {
  static const user = 'user';
  static const numberUser = 'numberUser';
  static const isLogin = 'isLogin';
  static const apiKey = 'apiKey';
  static const linkServer = 'linkServer';
  static const baseUrl = 'baseUrl';
  static const baseUrlDate = 'baseUrlDate';
}

class ConstantMessage {
  static const String errMsg = "Request to server is failed.";
  static const String errMsgNoInternet = "Disconnect. Your data connection Inactive.";
  static const String errMsgTimeOut = "The connection is bad. Request to server is failed.";

  static const String loremIpsumText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
}

class ConstantColor {
  // static Color colorPurpleAccent = Color(0xFF6d80ff);
  static Color colorPurpleAccent = Color(0xFFBB8ED0);
  static Color colorBlueDark = Color(0xFF23265A);
  static Color colorBlue = Color(0xFF4A5AE5);
  static Color bgColorWhite = Color(0xFFE8EAFF);
  static Color bgIcon = Colors.deepPurple.withAlpha(80);
}

enum ResultStatus { init, loading, noData, hasData, error }

enum ResponseError { timeOut, socket, catchExc }

class MediaQ {
  double mediaQueryHeight(BuildContext context) => MediaQuery.sizeOf(context).height;
  double mediaQueryWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
}
