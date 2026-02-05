import 'package:easy_hris/providers/change_days/change_day_add_provider.dart';
import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
import 'package:easy_hris/ui/util/widgets/elevated_button_custom.dart';
import 'package:easy_hris/ui/util/widgets/text_field_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../providers/permits/permit_add_provider.dart';
import '../../providers/preferences_provider.dart';
import '../util/utils.dart';
import '../util/widgets/dialog_helpers.dart';
import '../util/widgets/elevated_button_custom_icon.dart';

class ChangeDayAddScreen extends StatelessWidget {
  const ChangeDayAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangeDayAddProvider(),
      child: Consumer<PreferencesProvider>(
        builder: (context, prov, _) {
          return Scaffold(
            // backgroundColor: prov.isDarkTheme ? Theme.of(context).scaffoldBackgroundColor : Colors.grey.shade50,
            appBar: AppbarCustom.appbar(context, title: "Add Change Day", leadingBack: true),
            body: Consumer<ChangeDayAddProvider>(
              builder: (context, prov, _) {
                return Padding(
                  padding: EdgeInsets.all(8.w),
                  child: SingleChildScrollView(
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Form(
                          key: prov.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFieldCustom(
                                controller: prov.dayFromController,
                                label: "Day From",
                                hint: "YYYY MM DD",
                                isRequired: true,
                                enabled: true,
                                readOnly: true,
                                iconSuffix: IconButton(
                                  icon: const Icon(Iconsax.calendar_add_outline),
                                  onPressed: () async {
                                    final now = DateTime.now().toLocal();

                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: now.toLocal(),
                                      firstDate: DateTime(1900).toLocal(),
                                      lastDate: now.add(Duration(days: 365)),
                                    );

                                    if (pickedDate != null) {
                                      prov.onChangePickerDayFrom(pickedDate);
                                    }
                                  },
                                ),
                              ),

                              SizedBox(height: 16.h),

                              TextFieldCustom(
                                controller: prov.dayReplaceToController,
                                label: "Replace To",
                                hint: "YYYY MM DD",
                                isRequired: true,
                                enabled: true,
                                readOnly: true,
                                iconSuffix: IconButton(
                                  icon: const Icon(Iconsax.calendar_add_outline),
                                  onPressed: () async {
                                    final now = DateTime.now().toLocal();

                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: now.toLocal(),
                                      firstDate: DateTime(1900).toLocal(),
                                      lastDate: now.add(Duration(days: 365)),
                                    );

                                    if (pickedDate != null) {
                                      prov.onChangePickerReplaceTo(pickedDate);
                                    }
                                  },
                                ),
                              ),

                              SizedBox(height: 16.h),

                              TextFieldCustom(
                                controller: prov.noteController,
                                label: "Note",
                                hint: "Note",
                                isRequired: true,
                                enabled: true,
                                keyboardType: TextInputType.text,
                              ),

                              SizedBox(height: 24.h),

                              ElevatedButtonCustomIcon(
                                onPressed: () async {
                                  if (prov.formKey.currentState!.validate()) {
                                    showLoadingDialog(context);

                                    final result = await prov.addCareer();

                                    if (!context.mounted) return;
                                    Navigator.pop(context);
                                    if (result) {
                                      DialogHelper.showInfoDialog(
                                        context,
                                        icon: Icon(Icons.check, size: 32, color: Colors.green),
                                        title: prov.title,
                                        message: prov.message,
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      );
                                    } else {
                                      DialogHelper.showInfoDialog(
                                        context,
                                        icon: Icon(Icons.close_rounded, size: 32, color: Colors.red.shade700),
                                        title: prov.title,
                                        message: prov.message,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    }
                                  }
                                },
                                title: "Save Data",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
