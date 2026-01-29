import 'package:easy_hris/ui/attendance/attendance_history_screen.dart';
import 'package:flutter/material.dart';

import '../ui/home/home_screen.dart';
import '../ui/news/news_screen.dart';
import '../ui/profile/profile_screen.dart';
import '../ui/team/team_screen.dart';

class DashboardProvider extends ChangeNotifier {
  int _currentIndex = 0;
  late String linkServer = "";

  final List _widgetScreenLead = [HomeScreen(), const AttendanceHistoryScreen(), const NewsScreen(), const TeamScreen(), const ProfileScreen()];

  final List _widgetScreenNonLead = [
    HomeScreen(
      // viewAllNews: dashboardC.viewAllNews,
    ),
    const NewsScreen(),
    const ProfileScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarLead = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.history_outlined), label: "Attendance History"),
    const BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
    const BottomNavigationBarItem(icon: Icon(Icons.people_outline_outlined), label: "Team"),
    const BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: "Profile"),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarNonLead = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
    const BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: "Profile"),
  ];

  List get widgetScreenLead => _widgetScreenLead;
  List get widgetScreenNonLead => _widgetScreenNonLead;

  List<BottomNavigationBarItem> get bottomNavBarLead => _bottomNavBarLead;
  List<BottomNavigationBarItem> get bottomNavBarNonLead => _bottomNavBarNonLead;

  get currentIndex => _currentIndex;

  setIndex() {
    _currentIndex = 0;
  }

  void changeScreen(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    notifyListeners();
  }

  void funcViewAllNews() {
    _currentIndex = 1;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _currentIndex = 0;
  }
}
