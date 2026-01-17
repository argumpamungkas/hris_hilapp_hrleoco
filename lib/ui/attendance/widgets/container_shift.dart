import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/models/attendance.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/preferences_provider.dart';

class ContainerShift extends StatelessWidget {
  ContainerShift({super.key});

  String? _shiftEmployee;
  String? _shiftName;

  void checkShift(ResultsAttendance attendanceToday) {
    if (attendanceToday.shiftName != null) {
      var parseStart = DateFormat("hh:mm:ss").parse(attendanceToday.start!);
      var parseEnd = DateFormat("hh:mm:ss").parse(attendanceToday.end!);
      var start = DateFormat("HH:mm").format(parseStart);
      var end = DateFormat("HH:mm").format(parseEnd);
      _shiftEmployee = "$start - $end";
      _shiftName = "${attendanceToday.shiftName} - ${attendanceToday.shiftDetail}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, PreferencesProvider>(
      builder: (context, prov, provPref, _) {
        checkShift(prov.attendanceToday);
        return _shiftEmployee != null
            ? Column(
                children: [
                  Text(
                    _shiftEmployee!,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: provPref.isDarkTheme ? Colors.white : Colors.grey),
                  ),
                  Text(_shiftName!, style: TextStyle(color: provPref.isDarkTheme ? Colors.white : Colors.grey, fontSize: 12)),
                ],
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Your shift schedule is unknown",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: Colors.red.shade800),
                ),
              );
      },
    );
  }
}
