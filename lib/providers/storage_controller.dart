
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  final box = GetStorage();
String get splash_flag=>box.read('splash_flag')?? null;
String get lang=>box.read('lang') ?? null;
dynamic get authData=>box.read('data');
  void setSplashFlag(String flag)=>box.write('splash_flag', 'yes');

  void setSplashLang(String flag)=>box.write('lang', 'en');
  void setAuthData(dynamic data)=>box.write('data', data);

}
