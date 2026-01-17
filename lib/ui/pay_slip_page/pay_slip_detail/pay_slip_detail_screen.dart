import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../../constant/constant.dart';
import '../../../data/models/pay_slip.dart';
import '../../../providers/preferences_provider.dart';
import '../../util/utils.dart';
import 'widgets/data_pay_slip.dart';
import 'widgets/pay_slip_downloaded.dart';

class PaySlipDetailScreen extends StatefulWidget {
  static const routeName = "/pay_slip_detail_screen";

  const PaySlipDetailScreen({
    super.key,
    required this.resultsPaySlip,
  });

  final ResultsPaySlip resultsPaySlip;

  @override
  State<PaySlipDetailScreen> createState() => _PaySlipDetailScreenState();
}

class _PaySlipDetailScreenState extends State<PaySlipDetailScreen> {
  @override
  void initState() {
    super.initState();
    _initPermission();
  }

  Future<void> _initPermission() async {
    final devPlugin = DeviceInfoPlugin();
    final info = await devPlugin.androidInfo;
    if (info.version.sdkInt >= 30) {
      var status = await Permission.manageExternalStorage.status;
      if (status == PermissionStatus.denied) {
        var req = await Permission.manageExternalStorage.request();
        if (req == PermissionStatus.granted) {
          // print("Granted");
        } else {
          if (!mounted) return;
          showFailSnackbar(
            context,
            "Your has not granted permission",
          );
        }
      } else {
        // print("Granted");
      }
    } else {
      var status = await Permission.storage.status;
      if (status == PermissionStatus.denied ||
          status == PermissionStatus.permanentlyDenied) {
        var req = await Permission.storage.request();
        if (req == PermissionStatus.granted) {
          // print("GRANTED");
          return;
        } else {
          if (!mounted) return;
          showFailSnackbar(
            context,
            "Your has not granted permission",
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: prov.isDarkTheme
            ? Theme.of(context).colorScheme.background
            : Colors.white,
        backgroundColor: prov.isDarkTheme
            ? Theme.of(context).colorScheme.background
            : Colors.white,
        title: const Text(
          "Pay Slip",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        children: [
          DataPaySlip(resultsPaySlip: widget.resultsPaySlip),
          const SizedBox(height: 26),
          ElevatedButton(
            onPressed: () async {
              await _checkPermissionStorage().then(
                (value) async {
                  if (value) {
                    if (!context.mounted) return;
                    showLoadingDialog(context);
                    await PaySlipDownloaded()
                        .createPdf(context, widget.resultsPaySlip);
                  } else {
                    if (!context.mounted) return;
                    showFailSnackbar(
                      context,
                      "Your has not granted permission",
                    );
                  }
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorBlueDark,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size.fromHeight(46),
            ),
            child: const Text("Download Pay Slip"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<bool> _checkPermissionStorage() async {
    final devPlugin = DeviceInfoPlugin();
    final info = await devPlugin.androidInfo;
    // print("INFO $info");
    if (info.version.sdkInt >= 30) {
      var status = await Permission.manageExternalStorage.status;
      if (status == PermissionStatus.denied) {
        var req = await Permission.manageExternalStorage.request();
        if (req == PermissionStatus.granted) {
          // print("Granted");
          return true;
        } else {
          if (!mounted) return false;
          showFailSnackbar(
            context,
            "Your has not granted permission",
          );
          return false;
        }
      } else {
        return true;
      }
    } else {
      var status = await Permission.storage.status;
      if (status == PermissionStatus.denied ||
          status == PermissionStatus.permanentlyDenied) {
        var req = await Permission.storage.request();
        if (req == PermissionStatus.granted) {
          // print("GRANTED");
          return true;
        } else {
          if (!mounted) return false;
          showFailSnackbar(
            context,
            "Your has not granted permission",
          );
          return false;
        }
      } else {
        return true;
      }
    }
  }
}
