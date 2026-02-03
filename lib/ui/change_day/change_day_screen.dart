import 'package:easy_hris/ui/change_day/widgets/item_change_days.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../data/models/change_days.dart';
import '../../providers/change_days/change_days_provider.dart';
import 'change_day_adding_screen.dart';
import '../util/widgets/data_empty.dart';
import '../util/widgets/shimmer_list_load_data.dart';

class ChangeDayScreen extends StatefulWidget {
  static const routeName = "/change_day_screen";

  const ChangeDayScreen({super.key});

  @override
  State<ChangeDayScreen> createState() => _ChangeDayScreenState();
}

class _ChangeDayScreenState extends State<ChangeDayScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChangeDaysProvider>(context, listen: false).fetchChangeDays(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Day",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Consumer<ChangeDaysProvider>(
        builder: (context, prov, child) {
          switch (prov.resultStatus) {
            case ResultStatus.loading:
              return const ShimmerListLoadData();
            case ResultStatus.noData:
              return const DataEmpty(dataName: "Change Days");
            case ResultStatus.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(prov.message),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        prov.fetchChangeDays(context);
                      },
                      child: const Text("Refresh"),
                    ),
                  ],
                ),
              );
            case ResultStatus.hasData:
              return RefreshIndicator(
                onRefresh: () => prov.fetchChangeDays(context),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  itemCount: prov.listChangeDays.length,
                  itemBuilder: (context, index) {
                    ResultsChangeDays resultsChangeDays = prov.listChangeDays[index];
                    return Column(
                      children: [
                        ItemChangeDays(resultsChangeDays: resultsChangeDays),
                        Divider(thickness: 1, height: 0, color: Colors.grey.shade300),
                      ],
                    );
                  },
                ),
              );
            default:
              return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () => Navigator.pushNamed(context, ChangeDayAddingScreen.routeName),
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
