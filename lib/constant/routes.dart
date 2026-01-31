import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_hris/data/models/response/permit_model.dart';
import 'package:easy_hris/providers/attendances/attendance_history_provider.dart';
import 'package:easy_hris/ui/attendance/attendance_history_screen.dart';
import 'package:easy_hris/ui/attendance/camera_face_detection_screen.dart';
import 'package:easy_hris/ui/employee/add/add_career_screen.dart';
import 'package:easy_hris/ui/employee/add/add_education_screen.dart';
import 'package:easy_hris/ui/employee/add/add_experience_screen.dart';
import 'package:easy_hris/ui/employee/add/add_family_screen.dart';
import 'package:easy_hris/ui/employee/add/add_training_screen.dart';
import 'package:easy_hris/ui/employee/employee_screen.dart';
import 'package:easy_hris/ui/profile/id_card_screen.dart';
import 'package:easy_hris/ui/util/widgets/view_image.dart';
import 'package:easy_hris/ui/util/widgets/view_image_network.dart';
import 'package:flutter/material.dart';

import '../data/models/attendance_summary.dart';
import '../data/models/change_days.dart';
import '../data/models/notifications/notification_response.dart';
import '../data/models/overtime.dart';
import '../data/models/pay_slip.dart';
import '../data/models/permit.dart';
import '../ui/attendance/attendance_screen.dart';
import '../ui/attendance/camera_screen.dart';
import '../ui/attendance/picture_preview.dart';
import '../ui/attendance_summary/attendance_summary_screen.dart';
import '../ui/attendance_team/attendance_team_screen.dart';
import '../ui/auth/forgot_password_screen.dart';
import '../ui/auth/sign_in_screen.dart';
import '../ui/auth/sign_up_screen.dart';
import '../ui/change_day/change_day_screen.dart';
import '../ui/change_day/change_day_adding_screen.dart';
import '../ui/change_day/change_day_detail_screen.dart';
import '../ui/dashboard/dashboard_screen.dart';
import '../ui/news/news_screen_detail.dart';
import '../ui/notification/notification_screen.dart';
import '../ui/notification/notification_detail.dart';
import '../ui/overtime/overtime_screen.dart';
import '../ui/overtime/overtime_added_screen.dart';
import '../ui/overtime/overtime_detail_screen.dart';
import '../ui/pay_slip_page/pay_slip/pay_slip_screen.dart';
import '../ui/pay_slip_page/pay_slip_detail/pay_slip_detail_screen.dart';
import '../ui/permit/permit_add_screen.dart';
import '../ui/permit/permit_detail_screen.dart';
import '../ui/permit/permit_screen.dart';
import '../ui/profile/profile_change_password_screen.dart';
import '../ui/profile/profile_personal_data_screen.dart';
import '../ui/settings/settings_screen.dart';
import '../ui/splash/splash_screen.dart';
import '../ui/team/teams_detail_screen.dart';
import '../ui/util/widgets/foto_screen.dart';

class Routes {
  // SPLASH SCREEN
  static const splashScreen = '/splash_screen';

  // AUTH
  static const signInScreen = '/sign_in_screen';
  static const signUpScreen = '/sign_up_screen';
  static const forgotPasswordScreen = '/forgot_password_screen';
  static const companyCodeScreen = '/company_code_screen';

  // DASHBOARD
  static const dashboardScreen = '/dashboard_screen';
  static const newsDetailScreen = '/news_detail_screen';
  static const profileChangePasswordScreen = '/profile_change_password_screen';
  static const profilePersonalDataScreen = '/profile_personal_data_screen';
  static const settingScreen = '/setting_screen';
  static const idCardScreen = '/id_card_screen';
  static const teamsDetailScreen = '/teams_detail_screen';

  // NOTIFICATION
  static const notificationScreen = '/notification_screen';
  static const notificationDetailScreen = '/notification_detail_screen';

  /// EMPLOYEE
  static const employeeScreen = '/employee_screen';
  static const addFamilyScreen = '/add_family_screen';
  static const addEducationScreen = '/add_education_screen';
  static const addExperienceScreen = '/add_experience_screen';
  static const addTrainingScreen = '/add_training_screen';
  static const addCareerScreen = '/add_career_screen';
  static const viewImageScreen = '/view_image_screen';
  static const viewImageNetworkScreen = '/view_image_network_screen';

  // ATTENDANCE
  static const cameraScreen = '/camera_screen';
  static const cameraFaceDetectionScreen = '/camera_face_detection_screen';
  static const picturePreviewScreen = '/picture_preview_screen';
  static const attendanceSummaryScreen = '/attendance_summary_screen';
  static const attendanceTeamScreen = '/attendance_team_screen';
  static const attendanceHistory = '/attendance_history';

  // OVERTIME
  static const overtimeScreen = "/overtime_screen";
  static const overtimeAddedScreen = "/overtime_added_screen";
  static const overtimeDetailScreen = "/overtime_detail";

  // PERMITS
  static const permitScreen = "/permit_screen";
  static const permitAddScreen = "/permit_add_screen";
  static const permitDetailScreen = "/permit_detail";

  static Map<String, Widget Function(BuildContext)> routesPage = {
    // Splash Screen
    splashScreen: (context) => const SplashScreen(),

    // AUTH
    signInScreen: (context) => const SignInScreen(),
    signUpScreen: (context) => SignUpScreen(nameCompany: ModalRoute.of(context)?.settings.arguments as String),
    forgotPasswordScreen: (context) => const ForgotPasswordScreen(),

    // Dashboard
    dashboardScreen: (context) => const DashboardScreen(),
    newsDetailScreen: (context) => NewsDetailScreen(args: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>),
    profilePersonalDataScreen: (context) => ProfilePersonalDataScreen(),
    profileChangePasswordScreen: (context) => const ProfileChangePasswordScreen(),
    settingScreen: (context) => const SettingsScreen(),
    idCardScreen: (context) => const IdCardScreen(),

    // Notification
    notificationScreen: (context) => const NotificationScreen(),
    notificationDetailScreen: (context) => NotificationDetail(dataNotif: ModalRoute.of(context)?.settings.arguments as ResultNotif),

    /// EMPLOYEE
    employeeScreen: (context) => const EmployeeScreen(),
    addFamilyScreen: (context) => const AddFamilyScreen(),
    addEducationScreen: (context) => const AddEducationScreen(),
    addExperienceScreen: (context) => const AddExperienceScreen(),
    addTrainingScreen: (context) => const AddTrainingScreen(),
    addCareerScreen: (context) => const AddCareerScreen(),
    viewImageScreen: (context) => ViewImage(selectImage: ModalRoute.of(context)?.settings.arguments as File?),
    viewImageNetworkScreen: (context) => ViewImageNetwork(selectImage: ModalRoute.of(context)?.settings.arguments as String),

    // Attendance
    cameraScreen: (context) => CameraScreen(args: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
    // cameraFaceDetectionScreen: (context) => CameraFaceDetectionScreen(),
    picturePreviewScreen: (context) => PicturePreview(args: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
    attendanceSummaryScreen: (context) => AttendanceSummaryScreen(result: ModalRoute.of(context)?.settings.arguments as AttendanceSummary),
    attendanceTeamScreen: (context) => const AttendanceTeam(),
    attendanceHistory: (context) => const AttendanceHistoryScreen(),

    // Permits
    overtimeScreen: (context) => const OvertimeScreen(),
    overtimeAddedScreen: (context) => const OvertimeAddedScreen(),
    overtimeDetailScreen: (context) => OvertimeDetailScreen(resultOvertime: ModalRoute.of(context)?.settings.arguments as ResultsOvertime),

    // Permits
    permitScreen: (context) => const PermitScreen(),
    permitAddScreen: (context) => const PermitAddScreen(),
    permitDetailScreen: (context) => PermitDetailScreen(resultPermit: ModalRoute.of(context)?.settings.arguments as ResultPermitModel),

    teamsDetailScreen: (context) => TeamsDetailScreen(dataEmployee: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>),

    AttendanceScreen.routeName: (context) => AttendanceScreen(locOffice: ModalRoute.of(context)!.settings.arguments as String),
    ChangeDayScreen.routeName: (context) => const ChangeDayScreen(),
    ChangeDayDetailScreen.routeName: (context) =>
        ChangeDayDetailScreen(resultsChangeDays: ModalRoute.of(context)!.settings.arguments as ResultsChangeDays),
    ChangeDayAddingScreen.routeName: (context) => const ChangeDayAddingScreen(),
    FotoScreen.routeName: (context) => FotoScreen(imgUrl: ModalRoute.of(context)?.settings.arguments as String),
    PaySlipScreen.routeName: (context) => const PaySlipScreen(),
    PaySlipDetailScreen.routeName: (context) => PaySlipDetailScreen(resultsPaySlip: ModalRoute.of(context)?.settings.arguments as ResultsPaySlip),
  };
}
