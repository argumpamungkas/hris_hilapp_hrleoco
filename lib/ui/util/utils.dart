import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/constant.dart';

String formatRp(int value) => NumberFormat('#,###').format(value);

NumberFormat idrFormat = NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0);

String formatDateNow(DateTime date) => DateFormat("EEEE, dd MMMM yyyy").format(date);

String formatCreated(DateTime date) => DateFormat("EE, dd MMMM yyyy").format(date);

String formatCreatedDate(DateTime date) => DateFormat("EEEE, dd MMMM yyyy hh:mm").format(date);

String formatClock(DateTime date) => DateFormat("HH:mm:ss").format(date);

String formatDateAttendance(DateTime date) => DateFormat("yyyy-MM-dd").format(date);

String formatDateWithNameMonth(DateTime date) => DateFormat("dd MMMM yyyy").format(date);

String formatDatePeriod(DateTime date) => DateFormat("MMMM yyyy").format(date);
String formatDateYearMont(DateTime date) => DateFormat("yyyy-MM").format(date);

String formatTimeDay(DateTime date) => DateFormat("dd").format(date);
String formatTimeMonth(DateTime date) => DateFormat("MMMM").format(date);
String formatTimeyear(DateTime date) => DateFormat("yyyy").format(date);
String formatTimeAttendance(DateTime date) => DateFormat("HH:mm").format(date);

Future<String> getLink() async {
  String link = "init";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString(ConstantSharedPref.linkServer) != null) {
    link = prefs.getString(ConstantSharedPref.linkServer)!;
  } else {
    // debugPrint("TAK ADA LINK");
  }
  return link;
}

showLoadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 16), child: CircularProgressIndicator()),
            SizedBox(),
          ],
        ),
      );
    },
  );
}

showFailedDialog(BuildContext context, {required String titleFailed, required String descriptionFailed}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(titleFailed),
          content: Text(descriptionFailed, softWrap: true),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    },
  );
}

showInfoDialog(BuildContext context, {required String titleSuccess, required String descriptionSuccess, required void Function() onPressed}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(titleSuccess),
          content: Text(descriptionSuccess, softWrap: true),
          actions: [TextButton(onPressed: onPressed, child: const Text("OK"))],
        ),
      );
    },
  );
}

showConfirmDialog(BuildContext context, {required String titleConfirm, required String descriptionConfirm, required List<Widget> action}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(title: Text(titleConfirm), content: Text(descriptionConfirm, softWrap: true), actions: action);
    },
  );
}

showFailSnackbar(BuildContext context, String text, {SnackBarAction? action}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10)),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      backgroundColor: Colors.red.shade600,
      duration: const Duration(seconds: 3),
      action: action,
    ),
  );
}

showInfoSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, style: const TextStyle(color: Colors.white)),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}
