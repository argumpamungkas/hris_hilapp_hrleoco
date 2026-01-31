import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/employee/education/add_education_provider.dart';
import 'package:easy_hris/providers/employee/experience/add_experience_provider.dart';
import 'package:easy_hris/providers/employee/training/add_training_provider.dart';
import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';
import '../../util/utils.dart';
import '../../util/widgets/dialog_helpers.dart';
import '../../util/widgets/elevated_button_custom.dart';
import '../../util/widgets/text_field_custom.dart';

class AddTrainingScreen extends StatelessWidget {
  const AddTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddTrainingProvider(),
      child: Scaffold(
        appBar: AppbarCustom.appbar(context, title: "Add Training", leadingBack: true),
        body: SafeArea(
          child: Consumer<AddTrainingProvider>(
            builder: (context, prov, _) {
              switch (prov.resultStatus) {
                case ResultStatus.loading:
                  return Center(child: CupertinoActivityIndicator());
                case ResultStatus.error:
                  return Center(child: Text(prov.message));
                case ResultStatus.noData:
                  return Center(child: Text(prov.message));
                case ResultStatus.hasData:
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                            child: Form(
                              key: prov.formKey,
                              child: Column(
                                spacing: 12.h,
                                children: [
                                  TextFieldCustom(
                                    controller: prov.trainingNameController,
                                    label: "Training Name",
                                    hint: "Input Training Name",
                                    isRequired: true,
                                    keyboardType: TextInputType.text,
                                  ),

                                  TextFieldCustom(
                                    controller: prov.descriptionController,
                                    label: "Description",
                                    hint: "Input Description",
                                    isRequired: true,
                                    keyboardType: TextInputType.text,
                                  ),

                                  TextFieldCustom(
                                    label: 'Date',
                                    controller: prov.dateController,
                                    hint: "yyyy-mm-dd",
                                    isRequired: true,
                                    readOnly: true,
                                    keyboardType: TextInputType.number,
                                    iconSuffix: IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now().toLocal(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now().toLocal(),
                                        );

                                        if (pickedDate != null) {
                                          prov.onChangePicker(pickedDate);
                                        }
                                      },
                                    ),
                                  ),

                                  /// PROFESSION
                                  // TextFieldCustom(
                                  //   controller: prov.professionController,
                                  //   label: "Profession",
                                  //   hint: "Input Profession",
                                  //   isRequired: true,
                                  //   keyboardType: TextInputType.text,
                                  // ),

                                  /// CONTACT
                                  // TextFieldCustom(
                                  //   controller: prov.contactController,
                                  //   label: "Contact",
                                  //   hint: "Input Contact",
                                  //   isRequired: true,
                                  //   keyboardType: TextInputType.number,
                                  //   iconPrefix: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("+62")]),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                        child: ElevatedButtonCustom(
                          onPressed: () async {
                            if (prov.formKey.currentState!.validate()) {
                              showLoadingDialog(context);

                              final result = await prov.addTraining();

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
                          title: "ADD",
                          backgroundColor: ConstantColor.colorBlue,
                        ),
                      ),
                    ],
                  );
                default:
                  return Center(child: Text("Page not found"));
              }
            },
          ),
        ),
      ),
    );
  }
}
