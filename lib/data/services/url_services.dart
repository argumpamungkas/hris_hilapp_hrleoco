import 'dart:convert';

import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/response/url_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UrlServices {
  UrlModel? _urlModel;
  String? _message;

  // UrlModel? get urlModel => _urlModel;
  String? get message => _message;

  Future<UrlModel?> getUrlModel() async {
    final prefs = await SharedPreferences.getInstance();

    final now = DateTime.now().toLocal();
    final today = DateTime(now.year, now.month, now.day);

    try {
      if (_urlModel != null) {
        print("yang ada aja call url get it");
        return _urlModel;
      }

      final savedDatePrefs = prefs.getString(ConstantSharedPref.baseUrlDate);
      final savedUrl = prefs.getString(ConstantSharedPref.baseUrl);

      // ====== CEK: masih hari ini? ======
      if (savedUrl != null && savedDatePrefs != null) {
        final savedDate = DateTime.parse(savedDatePrefs);

        print("save date $savedDate");
        print("Today $today");

        if (savedDate.isAtSameMomentAs(today)) {
          print("PAKAI PREFS (HARI INI)");
          _urlModel = UrlModel.fromJson(jsonDecode(savedUrl));
          return _urlModel;
        }
      }

      /// ============= CALL SUPABASE =====================
      print("call supabase");
      final result = await Supabase.instance.client.from('master_link').select('''link, access''');

      if (result.isNotEmpty) {
        _urlModel = UrlModel.fromJson(result.first);
        await prefs.setString(ConstantSharedPref.baseUrl, jsonEncode(_urlModel!.toJson()));
        await prefs.setString(ConstantSharedPref.baseUrlDate, today.toIso8601String());
        return _urlModel;
      } else {
        _message = "Data URL is Empty";
        return null;
      }
    } catch (e, trace) {
      _message = e.toString();
      return null;
    }
  }
}
