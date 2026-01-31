import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/employee/family/add_family_provider.dart';
import 'package:easy_hris/ui/util/utils.dart';
import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
import 'package:easy_hris/ui/util/widgets/elevated_button_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';
import '../../util/widgets/dialog_helpers.dart';
import '../../util/widgets/text_field_custom.dart';

class AddFamilyScreen extends StatelessWidget {
  const AddFamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddFamilyProvider(),
      child: Scaffold(
        appBar: AppbarCustom.appbar(context, title: "Add Family", leadingBack: true),
        body: SafeArea(
          child: Consumer<AddFamilyProvider>(
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
                                    controller: prov.nationalIdController,
                                    label: "National ID",
                                    hint: "Input National ID",
                                    isRequired: false,
                                    keyboardType: TextInputType.number,
                                    maxLength: 16,
                                  ),

                                  TextFieldCustom(
                                    controller: prov.familyNameController,
                                    label: "Name",
                                    hint: "Input Name",
                                    isRequired: true,
                                    keyboardType: TextInputType.name,
                                  ),

                                  TextFieldCustom(
                                    controller: prov.placeOfBirthController,
                                    label: "Place of Birth",
                                    hint: "Input Place of Birth",
                                    isRequired: true,
                                    keyboardType: TextInputType.text,
                                  ),

                                  TextFieldCustom(
                                    label: 'Birthday',
                                    controller: prov.birthdayController,
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

                                  /// RELATION
                                  TextFieldCustom(
                                    label: 'Family Relation',
                                    controller: prov.relationController,
                                    hint: "Select Relation",
                                    isRequired: true,
                                    readOnly: true,
                                    keyboardType: TextInputType.text,
                                    onTap: () {
                                      DialogHelper.showSelectedDialog(
                                        context,
                                        title: "Select Relation",
                                        listData: prov.listFamilyRelation,
                                        itemBuilder: (context, item, index) {
                                          return Card(
                                            child: ListTile(
                                              onTap: () {
                                                prov.onChangeRelation(item.name);
                                                Navigator.pop(context);
                                              },
                                              title: Text(item.name, textAlign: TextAlign.center),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),

                                  /// PROFESSION
                                  TextFieldCustom(
                                    label: 'Profession',
                                    controller: prov.professionController,
                                    hint: "Input Profession",
                                    isRequired: false,
                                    keyboardType: TextInputType.text,
                                  ),

                                  TextFieldCustom(
                                    controller: prov.contractController,
                                    label: "Contact",
                                    hint: "Input Contact",
                                    isRequired: false,
                                    keyboardType: TextInputType.number,
                                    iconPrefix: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("+62")]),
                                  ),
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

                              final result = await prov.addFamily();

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
