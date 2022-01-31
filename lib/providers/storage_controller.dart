import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saaty_app/model/user_model.dart';

class StorageController extends GetxController {
  final box = GetStorage();

  /// keys
  static const String languageKey = 'language';
  static const String apiToken = 'token';
  static const String userId = 'userId';
  static const String userName = 'user_name';
  static const String userImage = 'user_image';
  static const String type = 'type';
  static const String loginKey = 'loginKey';
  static const String splashKey = 'splashKey';
  static const String expireDate='expireDate';

  static const String loginDataKey = 'loginDataKey';

  static const String loginUserModel = 'loginUserModel';



  static Future init() async {
    await GetStorage.init();
    if (GetStorage().read(languageKey) == null) {
      await setString(languageKey, 'ar');
    }
  }

  static String getUserToken = getString(apiToken) ?? 'No Token';

  static bool get isClient => getString(type) == 'client';

  static bool get isGuest => getString(type) == null;

  static bool get isLogged => getBool(loginKey);

  static bool isArabicLanguage = GetStorage().read(languageKey) == 'ar';

  static bool get isSplashLogged => getBool(splashKey)?? false;

  static String get getExpire => getString(expireDate);

  //static UserModel get getUserModel=>g

  /// ============= ============== ===================  =================
  static Future setString(String key, String value) async {
    await GetStorage().write(key, value);
  }

  static String getString(String key) {
    String value = GetStorage().read(key);
    return value;
  }

  static Future setBool(String key, bool value) async {
    await GetStorage().write(key, value);
  }

  static bool getBool(String key) {
    bool value = GetStorage().read(key);
    return value ;
  }

  static setInt(String key, int value) async {
    await GetStorage().write(key, value);
  }

  static int getInt(String key) {
    return GetStorage().read(key) ?? 0;
  }


  UserModel get UserModelData => box.read('user_model');

  // void setSplashFlag(String flag) => box.write('splash_flag', 'yes');
  //
  // void setSplashLang(String flag) => box.write('lang', flag);
  //
  // void setAuthData(dynamic data) => box.write('data', data);
  //
  // void setExpireDate(DateTime val) => box.write('expire', val);

  void setUserModelData(UserModel model) async{
  await  box.write('user_model', model);
  }
}
