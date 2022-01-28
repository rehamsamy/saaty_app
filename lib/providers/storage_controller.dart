
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  final box = GetStorage();
String get splash_flag=>box.read('splash_flag')?? null;
String get lang=>box.read('lang') ?? null;
//bool get expire=>box.read('expire');
DateTime get expire_date=>box.read('expire')?? null;

String get token=>box.read('token');
  String get userId=>box.read('userId');
  dynamic get authData=>box.read('data');

  void setSplashFlag(String flag)=>box.write('splash_flag', 'yes');

  void setSplashLang(String flag)=>box.write('lang', flag);

  void setAuthData(dynamic data)=>box.write('data', data);
  void setExpireDate(DateTime val)=> box.write('expire', val);


  void setToken(String val)=>box.write('token', val);
  void setUserId(String val)=>box.write('userId', val);



}
