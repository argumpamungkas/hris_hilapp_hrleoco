// import 'package:flutter/material.dart';
// import 'package:hris_askara_mobile/constant/constant.dart';
// import 'package:hris_askara_mobile/data/models/location_office.dart';
// import 'package:hris_askara_mobile/providers/preferences_provider.dart';
// import 'package:hris_askara_mobile/ui/attendance/controller/attendance_location_controllers.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
//
// class ContainerLocationOffice extends StatelessWidget {
//   const ContainerLocationOffice({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     PreferencesProvider provPref = Provider.of<PreferencesProvider>(context);
//     return Consumer<AttendanceLocationController>(builder: (context, prov, _) {
//       switch (prov.resultStatus) {
//         case ResultStatus.loading:
//           return _loading(context);
//         case ResultStatus.noData:
//           return const Text("No Data");
//         case ResultStatus.error:
//           return Center(child: Text(prov.message));
//         case ResultStatus.hasData:
//           return Column(
//             children: [
//               Text(
//                 "Choose Attendance Location",
//                 style: TextStyle(
//                   color: provPref.isDarkTheme ? Colors.white : Colors.grey,
//                   fontSize: 12,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               DropdownButtonHideUnderline(
//                   child: DropdownButtonFormField(
//                 value: prov.resultsLocationOffice,
//                 items: prov.listResultLocationOffice
//                     .map((ResultsLocationOffice resOffice) {
//                   return DropdownMenuItem(
//                     value: resOffice,
//                     child: Text(
//                       resOffice.name!,
//                     ),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   prov.setAttendanceLocation(value!);
//                 },
//                 hint: const Text("Location"),
//               )),
//             ],
//           );
//         default:
//           return Container();
//       }
//     });
//   }
//
//   Widget _loading(BuildContext context) {
//     PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
//     return Shimmer.fromColors(
//       baseColor: prov.isDarkTheme ? Colors.grey.shade800 : Colors.grey.shade300,
//       highlightColor: prov.isDarkTheme ? Colors.grey.shade900 : Colors.white,
//       child: Card(
//         color: prov.isDarkTheme ? Colors.grey.shade900 : Colors.white,
//         child: Container(
//           height: 50,
//         ),
//       ),
//     );
//   }
// }
