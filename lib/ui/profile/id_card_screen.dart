import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/providers/profiles/id_card_provider.dart';
import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
import 'package:easy_hris/ui/util/widgets/image_network_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barcode/barcode.dart';

import '../../constant/constant.dart';

class IdCardScreen extends StatelessWidget {
  const IdCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IdCardProvider(),
      child: Scaffold(
        appBar: AppbarCustom.appbar(context, title: "ID Card", leadingBack: true),
        body: Consumer2<IdCardProvider, PreferencesProvider>(
          builder: (context, prov, provPref, _) {
            if (prov.resultStatus == ResultStatus.loading) {
              return Center(child: CupertinoActivityIndicator());
            }

            if (prov.resultStatus == ResultStatus.error || prov.resultStatus == ResultStatus.noData) {
              return Center(child: Text(prov.message));
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(24)),
                  child: Container(
                    width: 1.sw,
                    height: 1.sh,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(image: NetworkImage("${prov.baseUrl}/${Constant.bgIdCard}"), fit: BoxFit.cover),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(top: 0.1.sh),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 0.3.sw,
                              child: ImageNetworkCustom(url: "${prov.baseUrl}/${Constant.urlILogo}/${provPref.configModel!.logo}"),
                            ),

                            SizedBox(height: 24.h),

                            SizedBox(
                              width: 0.25.sw,
                              height: 0.25.sw,
                              child: ClipOval(
                                child: ImageNetworkCustom(
                                  isFit: true,
                                  url: prov.employee?.imageProfile != null && prov.employee?.imageProfile != ''
                                      ? prov.employee!.imageProfile!
                                      : "${prov.baseUrl}/${Constant.urlDefaultImage}",
                                ),
                              ),
                            ),

                            SizedBox(height: 24.h),

                            Text(
                              prov.employee?.name?.toUpperCase() ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
                            ),

                            Text(
                              prov.employeePosition?.name?.toUpperCase() ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.sp, color: Colors.black),
                            ),

                            SizedBox(height: 32.h),

                            BarcodeWidget(
                              data: "Name : ${prov.employee?.name}, NIK: ${prov.employee?.number}, Address : ${prov.employee?.address}",
                              barcode: Barcode.qrCode(),
                              width: 80.w,
                              height: 80.w,
                            ),

                            SizedBox(height: 24.h),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                provPref.configModel?.address ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.sp, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );

            // return Container(
            //   width: 1.sw,
            //   height: 1.sh,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(image: NetworkImage("${prov.baseUrl}/${Constant.bgIdCard}"), fit: BoxFit.cover),
            //   ),
            //   child: SafeArea(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         SizedBox(
            //           width: 0.3.sw,
            //           child: ImageNetworkCustom(url: "${prov.baseUrl}/${Constant.urlILogo}/${provPref.configModel!.logo}"),
            //         ),
            //         SizedBox(height: 12.h),
            //         SizedBox(
            //           width: 0.3.sw,
            //           child: ImageNetworkCustom(url: "${prov.baseUrl}/${Constant.urlDefaultImage}"),
            //         ),
            //         SizedBox(height: 24.h),
            //         Text(
            //           prov.employee?.name?.toUpperCase() ?? "",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //         ),
            //         Text(
            //           prov.employeePosition?.name?.toUpperCase() ?? "",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(fontSize: 18),
            //         ),
            //
            //         SizedBox(height: 24.h),
            //
            //         BarcodeWidget(data: "${prov.employee?.number}\n${prov.employee?.address}", barcode: Barcode.qrCode(), width: 80.h, height: 80.w),
            //
            //         SizedBox(height: 24.h),
            //
            //         Text(
            //           prov.employee?.address ?? "",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(fontSize: 18),
            //         ),
            //       ],
            //     ),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
