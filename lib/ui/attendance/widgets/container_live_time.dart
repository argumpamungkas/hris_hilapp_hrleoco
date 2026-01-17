import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../util/utils.dart';

class ContainerLiveTime extends StatelessWidget {
  ContainerLiveTime({super.key});

  final DateTime _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimerBuilder.periodic(
          const Duration(seconds: 1),
          builder: (context) {
            DateTime dateRunning = DateTime.now();
            return Text(
              formatClock(dateRunning),
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
            );
          },
        ),
        Text(formatDateNow(_now), style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
