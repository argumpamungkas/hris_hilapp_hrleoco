import 'package:animate_do/animate_do.dart';
import 'package:easy_hris/ui/permit/widgets/item_permit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../constant/routes.dart';
import '../../data/models/permit.dart';
import '../../providers/permits/permit_provider.dart';
import '../../providers/preferences_provider.dart';
import '../util/utils.dart';
import '../util/widgets/app_bar_custom.dart';
import '../util/widgets/card_info.dart';
import '../util/widgets/data_not_found.dart';
import '../util/widgets/shimmer_list_load_data.dart';
import '../util/widgets/show_dialog_picker_year.dart';

class PermitScreen extends StatefulWidget {
  const PermitScreen({super.key});

  @override
  State<PermitScreen> createState() => _PermitScreenState();
}

class _PermitScreenState extends State<PermitScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final date = Provider.of<PermitProvider>(context, listen: false).initDate;
      Provider.of<PermitProvider>(context, listen: false).fetchPermit(date.year);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(
        context,
        title: "Permit",
        leadingBack: true,
        action: [
          Consumer2<PermitProvider, PreferencesProvider>(
            builder: (context, provPermit, provPref, _) {
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Material(
                  color: provPref.isDarkTheme ? Colors.black : Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: provPref.isDarkTheme ? ConstantColor.colorPurpleAccent : Colors.grey.shade100),
                  ),
                  child: provPermit.resultStatus == ResultStatus.loading
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          child: InkWell(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ShowDialogPickerYear(
                                    selectDate: provPermit.initDate,
                                    onChanged: (value) async {
                                      provPermit.onChangeYear(value).then((value) async {
                                        if (!context.mounted) return;
                                        Navigator.pop(context);
                                        await provPermit.fetchPermit(provPermit.initDate.year);
                                      });
                                    },
                                  );
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(provPermit.initDate.year.toString(), style: TextStyle(fontSize: 9.sp)),
                                SizedBox(width: 4.w),
                                Icon(Iconsax.calendar_1_outline, size: 12.w),
                              ],
                            ),
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<PermitProvider>(
        builder: (context, prov, child) {
          switch (prov.resultStatus) {
            case ResultStatus.loading:
              return const ShimmerListLoadData();
            case ResultStatus.noData:
              return const DataEmpty(dataName: "Permit");
            case ResultStatus.error:
              return FadeInUp(
                child: Center(
                  child: CardInfo(
                    iconData: Iconsax.info_circle_outline,
                    colorIcon: Colors.red,
                    title: "Error",
                    description: prov.message,
                    onPressed: () {
                      prov.fetchPermit(prov.initDate.year);
                    },
                    titleButton: "Refresh",
                    colorTitle: Colors.red,
                    buttonStyle: ElevatedButton.styleFrom(backgroundColor: ConstantColor.colorBlueDark, foregroundColor: Colors.white),
                  ),
                ),
              );
            case ResultStatus.hasData:
              return RefreshIndicator(
                onRefresh: () => prov.fetchPermit(prov.initDate.year),
                child: ListView.builder(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  itemCount: prov.lisPermit.length,
                  itemBuilder: (context, index) {
                    ResultPermit resultPermit = prov.lisPermit[index];

                    var permitDate = '';
                    if (resultPermit.permitDate != null) {
                      var dateFormatDefault = DateFormat("yyyy-MM-dd").parse(resultPermit.permitDate!);
                      permitDate = formatDateWithNameMonth(dateFormatDefault);
                    }

                    return ItemPermit(resultPermit: resultPermit, permitDate: permitDate);
                  },
                ),
              );
            default:
              return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: Colors.grey.shade100),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () async {
          Navigator.pushNamed(context, Routes.permitAddedScreen);
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage("assets/images/plus.png")),
          ),
        ),
      ),
    );
  }
}
