import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/data/models/employee_response_model.dart';
import 'package:easy_hris/providers/employee/employee_provider.dart';
import 'package:easy_hris/providers/employee/personal_provider.dart';
import 'package:easy_hris/ui/util/utils.dart';
import 'package:easy_hris/ui/util/widgets/build_upload_card_image.dart';
import 'package:easy_hris/ui/util/widgets/dialog_helpers.dart';
import 'package:easy_hris/ui/util/widgets/elevated_button_custom.dart';
import 'package:easy_hris/ui/util/widgets/text_field_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/widgets/bottom_sheet_helpers.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key, required this.employee});

  final EmployeeResponseModel employee;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PersonalEmployeeProvider(employee),
      child: Scaffold(
        body: Consumer<PersonalEmployeeProvider>(
          builder: (context, prov, _) {
            switch (prov.resultStatus) {
              case ResultStatus.loading:
                return Center(child: CupertinoActivityIndicator());
              case ResultStatus.error:
                return Center(child: Text(prov.message));
              case ResultStatus.noData:
                return Center(child: Text(prov.message));
              case ResultStatus.hasData:
                return SafeArea(
                  child: Form(
                    key: prov.key,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              child: Text(
                                "Personal Data".toUpperCase(),
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                              ),
                            ),

                            Divider(),

                            employee.temporary.isNotEmpty
                                ? Column(
                                    children: [
                                      Card(
                                        child: Container(
                                          decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(16)),
                                          padding: EdgeInsets.all(16),
                                          child: Row(
                                            spacing: 8.w,
                                            children: [
                                              Icon(Icons.info_outline),
                                              Expanded(child: Text("You cannot update Personal Data. Because yours data still Waiting Approval.")),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12.h),
                                    ],
                                  )
                                : SizedBox.shrink(),

                            SizedBox(height: 8.h),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 12.h,
                              children: [
                                TextFieldCustom(
                                  controller: prov.addressController,
                                  label: "Address",
                                  hint: "Input Address",
                                  isRequired: true,
                                  keyboardType: TextInputType.streetAddress,
                                ),

                                TextFieldCustom(
                                  controller: prov.domicileController,
                                  label: "Domicile",
                                  hint: "Input Domicile",
                                  isRequired: true,
                                  keyboardType: TextInputType.streetAddress,
                                ),

                                TextFieldCustom(
                                  controller: prov.placeOfBirthController,
                                  label: "Place of Birth",
                                  hint: "Input Place of Birth",
                                  isRequired: true,
                                  keyboardType: TextInputType.text,
                                ),

                                TextFieldCustom(
                                  label: 'Birth Date',
                                  controller: prov.birthDateController,
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

                                /// GENDER
                                TextFieldCustom(
                                  label: 'Gender',
                                  controller: prov.genderController,
                                  hint: "Select Gender",
                                  isRequired: true,
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  onTap: () {
                                    DialogHelper.showSelectedDialog(
                                      context,
                                      title: "Select Gender",
                                      listData: prov.listGender,
                                      itemBuilder: (context, item, index) {
                                        return Card(
                                          child: ListTile(
                                            onTap: () {
                                              prov.onChangeGender(item);
                                              Navigator.pop(context);
                                            },
                                            title: Text(item.name, textAlign: TextAlign.center),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),

                                /// BLOOD
                                TextFieldCustom(
                                  label: 'Blood Type',
                                  controller: prov.bloodTypeController,
                                  hint: "Select Blood Type",
                                  isRequired: true,
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  onTap: () {
                                    DialogHelper.showSelectedDialog(
                                      context,
                                      title: "Select Blood Type",
                                      listData: prov.listBlood,
                                      itemBuilder: (context, item, index) {
                                        return Card(
                                          child: ListTile(
                                            onTap: () {
                                              prov.onChangeBloodType(item);
                                              Navigator.pop(context);
                                            },
                                            title: Text(item.name, textAlign: TextAlign.center),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),

                                /// RELIGION
                                TextFieldCustom(
                                  label: 'Religion',
                                  controller: prov.religionController,
                                  hint: "Select Religion",
                                  isRequired: true,
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  onTap: () {
                                    DialogHelper.showSelectedDialog(
                                      context,
                                      title: "Select Religion",
                                      listData: prov.listReligion,
                                      itemBuilder: (context, item, index) {
                                        return Card(
                                          child: ListTile(
                                            onTap: () {
                                              prov.onChangeReligion(item);
                                              Navigator.pop(context);
                                            },
                                            title: Text(item.name!, textAlign: TextAlign.center),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),

                                /// MARITAL STATUS
                                TextFieldCustom(
                                  label: 'Marital Status',
                                  controller: prov.maritalStatusController,
                                  hint: "Select Marital Status",
                                  isRequired: true,
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  onTap: () {
                                    DialogHelper.showSelectedDialog(
                                      context,
                                      title: "Select Marital Status",
                                      listData: prov.listMarital,
                                      itemBuilder: (context, item, index) {
                                        return Card(
                                          child: ListTile(
                                            onTap: () {
                                              prov.onChangeMarital(item);
                                              Navigator.pop(context);
                                            },
                                            title: Text(item.name!, textAlign: TextAlign.center),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),

                                /// NATIONAL ID
                                Row(
                                  spacing: 8.w,
                                  children: [
                                    Expanded(
                                      child: TextFieldCustom(
                                        controller: prov.nationalIdNoController,
                                        label: "National ID No",
                                        hint: "Input National ID no",
                                        isRequired: true,
                                        keyboardType: TextInputType.number,
                                        maxLength: 16,
                                      ),
                                    ),

                                    Expanded(
                                      child: TextFieldCustom(
                                        controller: prov.fileNationalIdName,
                                        label: "Choose File National ID",
                                        hint: "Choose File National ID",
                                        readOnly: true,
                                        isRequired: true,
                                        maxLine: 1,
                                        iconPrefix: prov.fileNationalIdFIle != null
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(context, Routes.viewImageScreen, arguments: prov.fileNationalIdFIle);
                                                },
                                                child: Icon(Icons.visibility, size: 16.sp),
                                              )
                                            : prov.imageKTPFromDataExist.isNotEmpty
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    Routes.viewImageNetworkScreen,
                                                    arguments: "${Constant.baseUrl}/${Constant.urlProfileKtp}/${prov.imageKTPFromDataExist}",
                                                  );
                                                },
                                                child: Icon(Icons.visibility, size: 16.sp),
                                              )
                                            : null,
                                        onTap: () {
                                          BottomSheetHelper.showUploadOptions(context, (file, base64) async {
                                            await Future.delayed(Duration(milliseconds: 100));
                                            if (!context.mounted) return;
                                            showLoadingDialog(context);

                                            prov.onChangeFileNationalId(file, base64);

                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                /// FAMILY CARD ID
                                Row(
                                  spacing: 8.w,
                                  children: [
                                    Expanded(
                                      child: TextFieldCustom(
                                        controller: prov.familyCardController,
                                        label: "Family Card (KK)",
                                        hint: "Input Family Card No",
                                        isRequired: true,
                                        keyboardType: TextInputType.number,
                                        maxLength: 16,
                                      ),
                                    ),

                                    Expanded(
                                      child: TextFieldCustom(
                                        controller: prov.fileFamilyCardName,
                                        label: "Choose File Family Card",
                                        hint: "Choose File Family Card",
                                        readOnly: true,
                                        isRequired: true,
                                        maxLine: 1,
                                        iconPrefix: prov.fileFamilyCard != null
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(context, Routes.viewImageScreen, arguments: prov.fileFamilyCard);
                                                },
                                                child: Icon(Icons.visibility, size: 16.sp),
                                              )
                                            : prov.imageKKFromDataExist.isNotEmpty
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    Routes.viewImageNetworkScreen,
                                                    arguments: "${Constant.baseUrl}/${Constant.urlProfileKk}/${prov.imageKKFromDataExist}",
                                                  );
                                                },
                                                child: Icon(Icons.visibility, size: 16.sp),
                                              )
                                            : null,
                                        onTap: () {
                                          BottomSheetHelper.showUploadOptions(context, (file, base64) async {
                                            await Future.delayed(Duration(milliseconds: 100));
                                            if (!context.mounted) return;
                                            showLoadingDialog(context);

                                            prov.onChangeFileFamilyCard(file, base64);

                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),

                        /// CONTACT INFORMATION
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            "Contact Information".toUpperCase(),
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                            spacing: 12.h,
                            children: [
                              /// TAX NO CARD
                              Row(
                                spacing: 8.w,
                                children: [
                                  Expanded(
                                    child: TextFieldCustom(
                                      controller: prov.taxNoController,
                                      label: "Tax No (NPWP)",
                                      hint: "Input Tax No (NPWP)",
                                      isRequired: true,
                                      keyboardType: TextInputType.number,
                                      maxLine: 1,
                                    ),
                                  ),

                                  Expanded(
                                    child: TextFieldCustom(
                                      controller: prov.fileTaxNoNPWPName,
                                      label: "Choose File Tax No (NPWP)",
                                      hint: "Choose File Tax No",
                                      readOnly: true,
                                      isRequired: true,
                                      maxLine: 1,
                                      iconPrefix: prov.fileTaxNoNPWP != null
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context, Routes.viewImageScreen, arguments: prov.fileTaxNoNPWP);
                                              },
                                              child: Icon(Icons.visibility, size: 16.sp),
                                            )
                                          : prov.imageNPWPFromDataExist.isNotEmpty
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  Routes.viewImageNetworkScreen,
                                                  arguments: "${Constant.baseUrl}/${Constant.urlProfileNpwp}/${prov.imageNPWPFromDataExist}",
                                                );
                                              },
                                              child: Icon(Icons.visibility, size: 16.sp),
                                            )
                                          : null,
                                      onTap: () {
                                        BottomSheetHelper.showUploadOptions(context, (file, base64) async {
                                          await Future.delayed(Duration(milliseconds: 100));
                                          if (!context.mounted) return;
                                          showLoadingDialog(context);

                                          prov.onChangeFileTaxNPWP(file, base64);

                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              TextFieldCustom(
                                controller: prov.telephoneNoController,
                                label: "Telp No",
                                hint: "Input Telp No",
                                isRequired: false,
                                keyboardType: TextInputType.number,
                                maxLength: 15,
                                iconPrefix: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("+62")]),
                              ),

                              TextFieldCustom(
                                controller: prov.phoneNoController,
                                label: "Phone No",
                                hint: "Input Phone No",
                                isRequired: true,
                                keyboardType: TextInputType.number,
                                maxLength: 15,
                                iconPrefix: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("+62")]),
                              ),

                              TextFieldCustom(
                                controller: prov.emergencyNoController,
                                label: "Emergency No",
                                hint: "Input Emergency No",
                                isRequired: false,
                                keyboardType: TextInputType.number,
                                maxLength: 15,
                                iconPrefix: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("+62")]),
                              ),

                              TextFieldCustom(
                                controller: prov.emailController,
                                label: "Email",
                                hint: "Input Email",
                                isRequired: true,
                                keyboardType: TextInputType.emailAddress,
                              ),

                              /// RELIGION
                              TextFieldCustom(
                                label: 'Number of Family',
                                controller: prov.numberOfFamilyController,
                                hint: "Input Number of Family",
                                isRequired: true,
                                readOnly: false,
                                enabled: true,
                                keyboardType: TextInputType.number,
                              ),

                              /// BPJS TK
                              Row(
                                spacing: 8.w,
                                children: [
                                  Expanded(
                                    child: TextFieldCustom(
                                      controller: prov.bpjsController,
                                      label: "BPJS TK",
                                      hint: "-",
                                      isRequired: false,
                                      readOnly: true,
                                      keyboardType: TextInputType.number,
                                      enabled: false,
                                    ),
                                  ),

                                  Expanded(
                                    child: TextFieldCustom(
                                      controller: prov.bpjsDateController,
                                      label: "Date BPJS TK",
                                      hint: "-",
                                      isRequired: false,
                                      readOnly: true,
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              ),

                              /// JKN
                              Row(
                                spacing: 8.w,
                                children: [
                                  Expanded(
                                    child: TextFieldCustom(
                                      controller: prov.jknController,
                                      label: "JKN",
                                      hint: "-",
                                      isRequired: true,
                                      readOnly: true,
                                      enabled: false,
                                    ),
                                  ),

                                  Expanded(
                                    child: TextFieldCustom(
                                      controller: prov.jknDateController,
                                      label: "Date JKN",
                                      hint: "-",
                                      isRequired: false,
                                      readOnly: true,
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              ),

                              /// Driving license
                              Row(
                                spacing: 8.w,
                                children: [
                                  Expanded(
                                    child: TextFieldCustom(
                                      controller: prov.drivingLicenseController,
                                      label: "Driving Licensed",
                                      hint: "Input Driving Licensed",
                                      isRequired: false,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),

                                  Expanded(
                                    child: TextFieldCustom(
                                      label: 'Date Driving Licensed',
                                      controller: prov.drivingLicenseDateController,
                                      hint: "yyyy-mm-dd",
                                      isRequired: false,
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
                                            prov.onChangePickerDriver(pickedDate);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              /// STNK NO
                              Row(
                                spacing: 8.w,
                                children: [
                                  Expanded(
                                    child: TextFieldCustom(
                                      controller: prov.stnkNoController,
                                      label: "STNK No",
                                      hint: "Input STNK No",
                                      isRequired: false,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),

                                  Expanded(
                                    child: TextFieldCustom(
                                      label: 'Date STNK No',
                                      controller: prov.stnkNoDateController,
                                      hint: "yyyy-mm-dd",
                                      isRequired: false,
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
                                            prov.onChangePickerStnk(pickedDate);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              TextFieldCustom(
                                controller: prov.filePhotoProfileName,
                                label: "Foto Profile",
                                hint: "Choose Foto Profile",
                                readOnly: true,
                                isRequired: true,
                                maxLine: 1,
                                iconPrefix: prov.filePhotoProfile != null
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, Routes.viewImageScreen, arguments: prov.filePhotoProfile);
                                        },
                                        child: Icon(Icons.visibility, size: 16.sp),
                                      )
                                    : prov.imageProfileDataExist.isNotEmpty
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.viewImageNetworkScreen,
                                            arguments: "${Constant.baseUrl}/${Constant.urlProfileImage}/${prov.imageProfileDataExist}",
                                          );
                                        },
                                        child: Icon(Icons.visibility, size: 16.sp),
                                      )
                                    : null,
                                onTap: () {
                                  BottomSheetHelper.showUploadOptions(context, (file, base64) async {
                                    await Future.delayed(Duration(milliseconds: 100));
                                    if (!context.mounted) return;
                                    showLoadingDialog(context);

                                    prov.onChangeFileImgProfile(file, base64);

                                    Navigator.pop(context);
                                  });
                                },
                              ),

                              /// FOTO PROFILE
                              // BuildUploadCardImage(
                              //   title: "Foto Profile",
                              //   isRequired: true,
                              //   image: null,
                              //   onTap: () {
                              //     BottomSheetHelper.showUploadOptions(context, (file, base64) async {
                              //       await Future.delayed(Duration(milliseconds: 100));
                              //       if (!context.mounted) return;
                              //       showLoadingDialog(context);
                              //
                              //       prov.onChangeFileImgProfile(file, base64);
                              //
                              //       Navigator.pop(context);
                              //     });
                              //   },
                              //   placeholderPath: Icon(Icons.person),
                              // ),
                            ],
                          ),
                        ),

                        SizedBox(height: 8.h),

                        employee.temporary.isEmpty
                            ? Consumer<EmployeeProvider>(
                                builder: (context, provEmployee, _) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                                    child: ElevatedButtonCustom(
                                      onPressed: () async {
                                        if (prov.key.currentState!.validate()) {
                                          showLoadingDialog(context);

                                          final result = await prov.updatePersonalData();

                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                          if (result) {
                                            DialogHelper.showInfoDialog(
                                              context,
                                              icon: Icon(Icons.check, size: 32, color: Colors.green),
                                              title: prov.title,
                                              message: prov.message,
                                              onPressed: () {
                                                provEmployee.fetchEmployee();
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
                                      title: "UPDATE",
                                      backgroundColor: colorPurpleAccent,
                                    ),
                                  );
                                },
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                );
              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
