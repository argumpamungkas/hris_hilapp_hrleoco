import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constant.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Poppins'),
  colorScheme: ThemeData.light().colorScheme.copyWith(secondary: ConstantColor.colorBlue, onPrimary: Colors.black),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  // scaffoldBackgroundColor: Colors.grey[50],
  scaffoldBackgroundColor: ConstantColor.bgColorWhite,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: ConstantColor.colorBlue,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    showSelectedLabels: true,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    surfaceTintColor: Colors.white,
    centerTitle: true,
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.sp),
    elevation: 8,
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
    minVerticalPadding: 8.h,
    titleTextStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
    subtitleTextStyle: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700),
    visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  dialogTheme: DialogThemeData(
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.black),
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 10.sp),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.resolveWith((states) => Colors.white),
    side: BorderSide(color: Colors.black, width: 2.w),
  ),
  cardTheme: const CardThemeData(surfaceTintColor: Colors.white, color: Colors.white),
  datePickerTheme: const DatePickerThemeData(surfaceTintColor: Colors.white, backgroundColor: Colors.white),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.black,
  textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Poppins', bodyColor: Colors.white),
  colorScheme: ThemeData.dark().colorScheme.copyWith(secondary: ConstantColor.colorBlue, onPrimary: Colors.black),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    centerTitle: true,
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: ConstantColor.colorBlue,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    showSelectedLabels: true,
  ),
  listTileTheme: ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
    minVerticalPadding: 8.h,
    titleTextStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white, overflow: TextOverflow.ellipsis),
    subtitleTextStyle: TextStyle(fontSize: 12.sp, color: Colors.white, overflow: TextOverflow.ellipsis),
    visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  dialogTheme: DialogThemeData(
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700, fontSize: 12.sp),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: ConstantColor.colorBlue),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8..h),
    filled: true,
    fillColor: Colors.black,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: ConstantColor.colorBlue),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: ConstantColor.colorBlue),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.red),
    ),
    errorStyle: const TextStyle(color: Colors.red),
    suffixIconColor: Colors.white,
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.resolveWith((states) => Colors.black),
    side: const BorderSide(color: Colors.white, width: 2),
  ),
  cardTheme: CardThemeData(
    surfaceTintColor: Colors.black,
    color: Colors.black,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: ConstantColor.colorBlue),
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  datePickerTheme: DatePickerThemeData(
    surfaceTintColor: Colors.black,
    backgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: ConstantColor.colorBlue),
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);
