import 'package:easy_hris/ui/permit/widgets/form_permit_added.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../providers/permits/permit_added_provider.dart';
import '../../providers/preferences_provider.dart';
import '../util/widgets/form_container.dart';

class PermitAddedScreen extends StatelessWidget {
  const PermitAddedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PermitAddedProvider(),
      child: Consumer<PreferencesProvider>(
        builder: (context, prov, _) {
          return Scaffold(
            backgroundColor: prov.isDarkTheme ? Theme.of(context).scaffoldBackgroundColor : colorPurpleAccent,
            appBar: AppBar(
              backgroundColor: prov.isDarkTheme ? Theme.of(context).scaffoldBackgroundColor : colorPurpleAccent,
              elevation: 0,
              foregroundColor: Colors.white,
              title: const Text(
                "Add Permit",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            body: SingleChildScrollView(
              child: FormContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Please Complete your input Permit", softWrap: true, style: TextStyle(fontSize: 10.sp)),
                    SizedBox(height: 8.h),
                    const FormPermitAdded(),
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
