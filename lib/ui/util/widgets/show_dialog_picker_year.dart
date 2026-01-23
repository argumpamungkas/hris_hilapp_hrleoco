import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../constant/exports.dart';
import '../../../providers/auth/profile_provider.dart';

class ShowDialogPickerYear extends StatelessWidget {
  const ShowDialogPickerYear({super.key, required this.selectDate, required this.onChanged});

  final DateTime selectDate;
  final void Function(DateTime) onChanged;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Date"),
      content: Consumer<ProfileProvider>(
        builder: (context, provProf, _) {
          // var dateFormatDefault = DateFormat("yyyy-MM-dd").parse(provProf.userProfile!.dateSign!);
          return SizedBox(
            height: 300.h,
            width: 300.w,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year),
              lastDate: DateTime(DateTime.now().year),
              selectedDate: selectDate,
              onChanged: onChanged,
            ),
          );
        },
      ),
    );
  }
}
