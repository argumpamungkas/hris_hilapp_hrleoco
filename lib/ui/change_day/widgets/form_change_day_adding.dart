import 'package:easy_hris/providers/change_days/change_days_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../data/network/api/api_dashboard.dart';
import '../../util/utils.dart';
import '../../util/widgets/title_form.dart';

class FormChangeDayAdding extends StatefulWidget {
  const FormChangeDayAdding({super.key});

  @override
  State<FormChangeDayAdding> createState() => _FormChangeDayAddingState();
}

class _FormChangeDayAddingState extends State<FormChangeDayAdding> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dayFromController = TextEditingController();
  final TextEditingController _replaceToController = TextEditingController();
  final TextEditingController _sendDayFromController = TextEditingController();
  final TextEditingController _sendReplaceToController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController(text: "");
  bool isAgree = false;
  DateTime now = DateTime.now();
  late ChangeDaysProvider _changeDaysC;
  bool _loading = false;
  final ApiDashboard _apiDashboard = ApiDashboard();
  int _dateStart = 0;

  @override
  void initState() {
    Future.microtask(() async => await fetchCutOff());
    super.initState();
  }

  Future<void> fetchCutOff() async {
    _loading = true;
    var response = await _apiDashboard.fetchCutOff();
    String respStart = response['start'];
    String tanggal = respStart.split("-").last;
    _dateStart = int.parse(tanggal);
    setState(() {
      _loading = false;
    });
  }

  void _openCalendarFrom() async {
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    late DateTime firstDate;
    if (now.isBefore(DateTime(now.year, now.month, _dateStart))) {
      firstDate = DateTime(now.year, now.month - 1, _dateStart);
    } else {
      firstDate = DateTime(now.year, now.month, _dateStart);
    }
    final selected = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: lastDate);

    if (selected != null) {
      setState(() {
        _dayFromController.text = DateFormat("dd MMMM yyyy").format(selected);
      });
      _sendDayFromController.text = formatDateAttendance(selected);
    }
  }

  void _openCalendarReplaceTo() async {
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    late DateTime firstDate;
    if (now.isBefore(DateTime(now.year, now.month, _dateStart))) {
      firstDate = DateTime(now.year, now.month - 1, _dateStart);
    } else {
      firstDate = DateTime(now.year, now.month, _dateStart);
    }
    final selected = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: lastDate);

    if (selected != null) {
      setState(() {
        _replaceToController.text = DateFormat("dd MMMM yyyy").format(selected);
      });
      _sendReplaceToController.text = formatDateAttendance(selected);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dayFromController.dispose();
    _replaceToController.dispose();
    _remarksController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _changeDaysC = Provider.of<ChangeDaysProvider>(context);
    return _loading
        ? const CircularProgressIndicator()
        : Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleForm(textTitle: "Date From"),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _dayFromController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Date From",
                    suffixIcon: IconButton(onPressed: _openCalendarFrom, icon: const Icon(Icons.calendar_month_outlined)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please input Date From";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleForm(textTitle: "Replace To"),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _replaceToController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Replace To",
                        suffixIcon: IconButton(onPressed: _openCalendarReplaceTo, icon: const Icon(Icons.calendar_month_outlined)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please input Replace To";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleForm(textTitle: "Remarks"),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _remarksController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(hintText: "Remarks"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please input Remarks";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoadingDialog(context);
                      await Future.delayed(const Duration(seconds: 1));
                      if (!mounted) return;
                      await _changeDaysC
                          .addChangeDays(context, _sendDayFromController.text, _sendReplaceToController.text, _remarksController.text)
                          .then((value) async {
                            if (value.theme == "success") {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                              showFailedDialog(context, titleFailed: value.title, descriptionFailed: value.message);
                            }
                          });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorBlueDark,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size.fromHeight(46),
                  ),
                  child: const Text("Send Request"),
                ),
                const SizedBox(height: 4),
              ],
            ),
          );
  }
}
