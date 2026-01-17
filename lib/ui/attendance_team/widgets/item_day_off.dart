import 'package:flutter/material.dart';

import '../../../constant/routes.dart';
import '../../../data/models/days_off.dart';

class ItemDayOff extends StatelessWidget {
  const ItemDayOff({super.key, required this.urlImage, required this.results});

  final String urlImage;
  final ResultsDaysOff results;

  @override
  Widget build(BuildContext context) {
    late Color colorDesc;
    if (results.color.toUpperCase() == "GREEN") {
      colorDesc = Colors.greenAccent.shade400;
    } else if (results.color.toUpperCase() == "BLUE") {
      colorDesc = Colors.blueAccent;
    } else if (results.color.toUpperCase() == "ORANGE") {
      colorDesc = Colors.orangeAccent;
    } else {
      colorDesc = Colors.redAccent;
    }
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.teamsDetailScreen,
          arguments: {
            "employeeId": results.employeeId,
            "name": results.name,
            "imageUrl": urlImage,
            "yearsWork": results.services,
            "dateSign": results.dateSign,
          },
        );
      },
      visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(urlImage), fit: BoxFit.cover),
        ),
      ),
      title: Text(results.name),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.access_time_rounded, size: 16, color: Colors.green),
                const SizedBox(width: 4),
                Text(results.timeIn != null || results.timeIn! != "" ? results.timeIn! : "-"),
              ],
            ),
            const SizedBox(width: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.access_time_rounded, size: 16, color: Colors.red),
                const SizedBox(width: 4),
                Text(results.timeOut != null || results.timeOut! != "" ? results.timeOut! : "-"),
              ],
            ),
          ],
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: colorDesc, borderRadius: BorderRadius.circular(8)),
        child: Text(
          results.description,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 8),
        ),
      ),
    );
  }
}
