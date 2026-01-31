import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:marquee/marquee.dart';

import '../../../constant/constant.dart';
import '../../../providers/preferences_provider.dart';
import '../controller/attendance_controller.dart';

class UserLocation extends StatelessWidget {
  const UserLocation({super.key});

  @override
  Widget build(BuildContext context) {
    PreferencesProvider provPref = Provider.of<PreferencesProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: provPref.isDarkTheme ? Colors.black : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: provPref.isDarkTheme ? ConstantColor.colorBlue : Colors.grey.shade100),
      ),
      child: Consumer<AttendanceController>(
        builder: (context, prov, _) {
          switch (prov.resultStatus) {
            case ResultStatus.loading:
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      "Get Your Location",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: provPref.isDarkTheme ? Colors.white : Colors.grey.shade300),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(padding: const EdgeInsets.all(4), height: 20, width: 20, child: const CircularProgressIndicator(strokeWidth: 2)),
                ],
              );
            case ResultStatus.hasData:
              if (prov.hasPermission) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/placeholder.png", height: 20),
                    const SizedBox(width: 8),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: MediaQ().mediaQueryWidth(context) * 0.5,
                      height: 20,
                      child: Marquee(
                        text: prov.address!,
                        style: TextStyle(fontSize: 12, color: provPref.isDarkTheme ? Colors.white : Colors.grey),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        blankSpace: 20,
                        velocity: 50,
                        pauseAfterRound: const Duration(seconds: 1),
                        accelerationDuration: const Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: const Duration(seconds: 1),
                        decelerationCurve: Curves.easeOut,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: InkWell(
                        onTap: () {
                          prov.getLocation(context);
                        },
                        child: const Icon(Icons.refresh),
                      ),
                    ),
                  ],
                );
              } else {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Flexible(
                      child: Text(
                        "Location not detected",
                        style: TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        prov.getPermission(context);
                      },
                      child: const Icon(Icons.refresh),
                    ),
                  ],
                );
              }
            default:
              return Container();
          }
        },
      ),
    );
  }
}
