import 'package:animate_do/animate_do.dart';
import 'package:easy_hris/ui/overtime/widgets/item_overtime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../constant/routes.dart';
import '../../data/models/overtime.dart';
import '../../providers/overtimes/overtime_provider.dart';
import '../../providers/preferences_provider.dart';
import '../util/utils.dart';
import '../util/widgets/app_bar_custom.dart';
import '../util/widgets/card_info.dart';
import '../util/widgets/data_empty.dart';
import '../util/widgets/shimmer_list_load_data.dart';
import '../util/widgets/show_dialog_picker_year.dart';

class OvertimeScreen extends StatefulWidget {
  const OvertimeScreen({super.key});

  @override
  State<OvertimeScreen> createState() => _OvertimeScreenState();
}

class _OvertimeScreenState extends State<OvertimeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final date = Provider.of<OvertimeProvider>(context, listen: false).initDate;
      Provider.of<OvertimeProvider>(context, listen: false).fetchOvertime(date.year);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom.appbar(
        context,
        title: "Overtime",
        leadingBack: true,
        action: [
          Consumer2<OvertimeProvider, PreferencesProvider>(
            builder: (context, provOvertime, provPref, _) {
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Material(
                  color: provPref.isDarkTheme ? Colors.black : Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: provPref.isDarkTheme ? ConstantColor.colorPurpleAccent : Colors.grey.shade100),
                  ),
                  child: provOvertime.resultStatus == ResultStatus.loading
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          child: InkWell(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ShowDialogPickerYear(
                                    selectDate: provOvertime.initDate,
                                    onChanged: (value) async {
                                      provOvertime.onChangeYear(value).then((value) async {
                                        if (!context.mounted) return;
                                        Navigator.pop(context);
                                        await provOvertime.fetchOvertime(provOvertime.initDate.year);
                                      });
                                    },
                                  );
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(provOvertime.initDate.year.toString(), style: TextStyle(fontSize: 9.sp)),
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
      body: Consumer<OvertimeProvider>(
        builder: (context, prov, child) {
          switch (prov.resultStatus) {
            case ResultStatus.loading:
              return const ShimmerListLoadData();
            case ResultStatus.noData:
              return const DataEmpty(dataName: "Overtime");
            case ResultStatus.error:
              return FadeInUp(
                child: Center(
                  child: CardInfo(
                    iconData: Iconsax.info_circle_outline,
                    colorIcon: Colors.red,
                    title: "Error",
                    description: prov.message,
                    onPressed: () {
                      prov.fetchOvertime(prov.initDate.year);
                    },
                    titleButton: "Refresh",
                    colorTitle: Colors.red,
                    buttonStyle: ElevatedButton.styleFrom(backgroundColor: ConstantColor.colorBlueDark, foregroundColor: Colors.white),
                  ),
                ),
              );
            case ResultStatus.hasData:
              return RefreshIndicator(
                onRefresh: () => prov.fetchOvertime(prov.initDate.year),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  itemCount: prov.listOvertime.length,
                  itemBuilder: (context, index) {
                    ResultsOvertime resultOvertime = prov.listOvertime[index];

                    String overtimeDate = '';
                    if (resultOvertime.transDate != null) {
                      var dateFormatDefault = DateFormat("yyyy-MM-dd").parse(resultOvertime.transDate!);
                      overtimeDate = formatDateWithNameMonth(dateFormatDefault);
                    }

                    return ItemOvertime(resultOvertime: resultOvertime, overtimeDate: overtimeDate);
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
        onPressed: () => Navigator.pushNamed(context, Routes.overtimeAddedScreen),
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
