import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/helpers/notification_helper.dart';
import '../../main.dart';
import '../util/utils.dart';
import '../util/widgets/app_bar_custom.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key, required this.args});

  final Map<String, dynamic> args;

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final Dio dio = Dio();

  String _localPath = "";

  final NotificationHelper _notificationHelper = NotificationHelper();

  Future<bool> _checkPermissionStorage() async {
    // print("CALL");
    final devPlugin = DeviceInfoPlugin();
    final info = await devPlugin.androidInfo;
    // print("INFO ${info.version.sdkInt}");
    if (info.version.sdkInt >= 30) {
      // print("CALL 29");
      var status = await Permission.manageExternalStorage.status;
      if (status == PermissionStatus.denied) {
        var req = await Permission.manageExternalStorage.request();
        if (req == PermissionStatus.granted) {
          // print("Granted");
          return true;
        } else {
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
          return false;
        }
      } else {
        return true;
      }
    }
  }

  Future<void> _prepareSaveDir() async {
    if (Platform.isAndroid) {
      var infoDevice = await DeviceInfoPlugin().androidInfo;
      if (infoDevice.version.sdkInt > 28) {
        final directories = await getExternalStorageDirectories();
        // print("DIRECTORIES $directories");
        if (directories != null && directories.isNotEmpty) {
          _localPath = '/storage/emulated/0/Download/';
          // _localPath = directories.first.path;
        } else {
          _localPath = '/storage/emulated/0/Download/';
          throw Exception("Could not find a valid downloads directory.");
        }
      } else {
        _localPath = '/storage/emulated/0/Download/';
      }
    } else {
      var directory = await getApplicationDocumentsDirectory();
      _localPath = '${directory.path}${Platform.pathSeparator}Download';
    }

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  @override
  Widget build(BuildContext context) {
    var format = widget.args['news'].attachment.split(".").last;

    return Scaffold(
      appBar: appBarCustom(context, title: "News Detail", leadingBack: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 10,
        ),
        children: [
          Text(
            widget.args['news'].name,
            textAlign: TextAlign.center,
            softWrap: true,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Html(
            data: widget.args['news'].description,
          ),
          Visibility(
            visible: widget.args['news'].attachment == "" ? false : true,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  format == 'pdf'
                      ? Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade300.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.file_copy_outlined),
                              const SizedBox(width: 8),
                              Text("${widget.args['news'].name}.pdf"),
                            ],
                          ),
                        )
                      : Image.network(
                          "${widget.args['link']}${widget.args['news'].attachment}"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      var response = await _checkPermissionStorage();
                      if (format == 'pdf') {
                        if (response) {
                          if (!context.mounted) return;
                          showLoadingDialog(context);
                          await _prepareSaveDir();
                          try {
                            final file = File(
                                "$_localPath/${widget.args['news'].name}.pdf");
                            await Dio()
                                .download(
                              "${widget.args['link']}${widget.args['news'].attachment}",
                              file.path,
                            )
                                .then((value) async {
                              Navigator.pop(context);
                              await _notificationHelper
                                  .showNotificationSuccessDownloading(
                                flutterLocalNotificationsPlugin,
                                file.path,
                                "${widget.args['news'].name}.pdf",
                              );
                            });
                          } catch (e) {
                            if (!context.mounted) return;
                            Navigator.pop(context);
                            showFailSnackbar(
                              context,
                              "Downloading ${widget.args['news'].name} is Failed",
                            );
                          }
                        } else {
                          if (!context.mounted) return;
                          showFailSnackbar(
                              context, "Your has not granted permission");
                        }
                      } else {
                        if (response) {
                          if (!context.mounted) return;
                          showLoadingDialog(context);
                          await _prepareSaveDir();
                          try {
                            final file = File(
                                "$_localPath/${widget.args['news'].name}.jpg");
                            await Dio()
                                .download(
                              "${widget.args['link']}${widget.args['news'].attachment}",
                              file.path,
                            )
                                .then((value) async {
                              Navigator.pop(context);
                              await _notificationHelper
                                  .showNotificationSuccessDownloading(
                                flutterLocalNotificationsPlugin,
                                file.path,
                                "${widget.args['news'].name}.jpg",
                              );
                            });
                          } catch (e, trace) {
                            // print("ERROR $e");
                            // print("ERROR $trace");
                            if (!context.mounted) return;
                            Navigator.pop(context);
                            showFailSnackbar(
                              context,
                              "Downloading ${widget.args['news'].name} is Failed",
                            );
                          }
                        } else {
                          if (!context.mounted) return;
                          Navigator.pop(context);
                          showFailSnackbar(
                              context, "Your has not granted permission");
                        }
                      }
                    },
                    child: const Text("Download"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
