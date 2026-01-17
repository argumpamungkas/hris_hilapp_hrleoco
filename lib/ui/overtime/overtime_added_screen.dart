import 'package:easy_hris/ui/overtime/widgets/form_overtime_added.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../providers/overtimes/overtime_added_provider.dart';
import '../../providers/preferences_provider.dart';
import '../util/widgets/form_container.dart';

class OvertimeAddedScreen extends StatelessWidget {
  const OvertimeAddedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OvertimeAddedProvider(),
      child: Consumer<PreferencesProvider>(
        builder: (context, prov, _) {
          return Scaffold(
            backgroundColor: prov.isDarkTheme ? Theme.of(context).scaffoldBackgroundColor : colorPurpleAccent,
            appBar: AppBar(
              backgroundColor: prov.isDarkTheme ? Theme.of(context).scaffoldBackgroundColor : colorPurpleAccent,
              foregroundColor: Colors.white,
              title: const Text(
                "Add Overtime",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: FormContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Please Complete your input Overtime", softWrap: true, style: TextStyle(fontSize: 10.sp)),
                    SizedBox(height: 8.h),
                    const FormOvertimeAdded(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
