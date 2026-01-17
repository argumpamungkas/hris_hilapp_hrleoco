import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/constant.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/preferences_provider.dart';

class DateAttendanceUser extends StatelessWidget {
  const DateAttendanceUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, PreferencesProvider>(
      builder: (context, provHome, provPref, _) {
        switch (provHome.resultStatus) {
          case ResultStatus.loading:
            return _loading(context);
          case ResultStatus.hasData:
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green.shade50),
                        child: Text(
                          "In",
                          style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        provHome.attendanceToday.timeIn ?? "-",
                        style: TextStyle(color: Colors.green.shade300, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red.shade50),
                        child: Text(
                          "Out",
                          style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        provHome.attendanceToday.timeOut ?? "-",
                        style: TextStyle(color: Colors.red.shade300, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            );
          default:
            return Container();
        }
      },
    );
  }

  Widget _loading(BuildContext context) {
    PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
    return Shimmer.fromColors(
      baseColor: prov.isDarkTheme ? Colors.grey.shade800 : Colors.grey.shade300,
      highlightColor: prov.isDarkTheme ? Colors.grey.shade900 : Colors.white,
      child: Card(color: prov.isDarkTheme ? Colors.grey.shade900 : Colors.white, child: Container(height: 50)),
    );
  }
}
