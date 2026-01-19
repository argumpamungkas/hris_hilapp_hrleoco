import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/services/url_services.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class Injection {
  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final urlService = UrlServices();
      sl.registerLazySingleton<SharedPreferences>(() => prefs);
      sl.registerLazySingleton<UrlServices>(() => urlService);
    } catch (e) {
      print("error DI $e");
      rethrow;
    }
  }
}
