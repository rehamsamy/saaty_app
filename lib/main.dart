import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saaty_app/LocalString.dart';
import 'package:flutter/services.dart';
import 'package:saaty_app/cons.dart';
import 'package:saaty_app/providers/Orders.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/fav_ads_controller.dart';
import 'package:saaty_app/providers/lang_controller.dart';
import 'package:saaty_app/providers/message_controller.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/status_product_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/others/about_app.dart';
import 'package:saaty_app/account/screen/account_screen.dart';
import 'package:saaty_app/ads_favorite/screen/ads_screen.dart';
import 'package:saaty_app/others/call_us.dart';
import 'package:saaty_app/carts/screen/cart_screen.dart';
import 'package:saaty_app/account/screen/change_password_screen.dart';
import 'package:saaty_app/create_product/screen/create_product_screen.dart';
import 'package:saaty_app/account/screen/edit_account_screen.dart';
import 'package:saaty_app/login_register/screen/forget_password_screen.dart';
import 'package:saaty_app/home_page/screen/home_screen.dart';
import 'package:saaty_app/login_register/screen/login_screen.dart';
import 'package:saaty_app/main_page/screen/main_page_screen.dart';
import 'package:saaty_app/message/screen/message_detail_screen.dart';
import 'package:saaty_app/message/screen/messages_screen.dart';
import 'package:saaty_app/orders/screen/order_screen.dart';
import 'package:saaty_app/details/screen/product_item_detail_screen.dart';
import 'package:saaty_app/login_register/screen/reset_password_screen.dart';
import 'package:saaty_app/create_product/screen/send_message_screen.dart';
import 'package:saaty_app/others/setting_screen.dart';
import 'package:saaty_app/splash/SplashScreen.dart';
import 'package:saaty_app/splash/splah_language_screen.dart';
import 'package:saaty_app/stores/screen/stores_screen.dart';

import 'model/cart.dart';
import 'providers/products_controller.dart';
import 'login_register/screen/register_screen.dart';

void main() async {
  await StorageController.init();
  print(StorageController.getString(StorageController.type));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final controller = Get.put(AuthController());
  final controller1 = Get.put(ProductController());
  final controller2 = Get.put(ProductsController());
  final controller3 = Get.put(StatusProductController());
  final controller4 = Get.put(FavsAdsController());
  final controller5 = Get.put(MessageController());
  final controller6 = Get.put(LangController());
  final controller7 = Get.put(StorageController());
  final controller8 = Get.put(Cart());
  final controller9 = Get.put(Orders());
  String splash_flag;
  DateTime expire;
  DateTime nowRes;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    if(StorageController.getString(StorageController.expireDate) !=null){
      expire = DateTime.parse(StorageController.getString(StorageController.expireDate));
      String nowFormat = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      nowRes = DateTime.parse(nowFormat);
      print ('exp '+expire.toString() +'  noe '+nowFormat.toString());
      print(expire.isBefore(nowRes));
    }

    final List locale = [
      {'name': 'ENGLISH', 'locale': Locale('us')},
      {'name': 'العربية', 'locale': Locale('ar')},
    ];
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Cons.buildColors(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      translations: LocaleString(),
      locale: StorageController.isArabicLanguage ? Locale('ar') : Locale('en'),
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 213, 177, 57),
          unselectedWidgetColor: Color.fromARGB(255, 123, 196, 229),
          // rgba(228,190,55,255)
          accentColor: Color.fromARGB(255, 123, 196, 229),
          canvasColor: Colors.white,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              centerTitle: true,
              foregroundColor: Colors.grey.shade300,
              brightness: Brightness.light,
              iconTheme: IconThemeData(color: Theme.of(context).accentColor))),
      home:getInitialRoute(),
      routes: {
        LoginScreen.LOGIN_SCREEN_ROUTE: (_) =>
            GetBuilder<LangController>(builder: (_) => LoginScreen()),
        RegisterScreen.REGISTER_SCREEN_ROUTE: (_) => RegisterScreen(),
        HomeScreen.HOME_SCREEN_RIUTE: (_) => HomeScreen(),
        CreateProductScreen.CREATE_PRODUCT_ROUTE: (_) => CreateProductScreen(),
        MainPageScreen.MAIN_PRAGE_ROUTE: (_) => MainPageScreen(),
        ProductItemDetailScreen.PRODUCT_DETAIL_ROUTE: (_) =>
            ProductItemDetailScreen(),
        SendMessageScreen.SEND_MESSAGE_SCREEN_ROUTE: (_) => SendMessageScreen(),
        AdsScreen.ADS_SCREEN_ROUTE: (_) => AdsScreen(),
        SettingScreen.SETTING_SCREEN_ROUTE: (_) => SettingScreen(),
        StoresScreen.Stores_SCREEN_ROUTE: (_) => StoresScreen(),
        MessageScreen.MESSAGES_SCREEN_ROUTE: (_) => MessageScreen(),
        MessageDetailScreen.MESSAGES_Detail_SCREEN_ROUTE: (_) =>
            MessageDetailScreen(),
        AccountScreen.ACCOUNT_SCREEN_ROUTE: (_) => AccountScreen(),
        EditAccountScreen.EDIT_ACCOUNT_SCREEN_ROUTE: (_) => EditAccountScreen(),
        ChangePasswordScreen.CHANGE_PASSWORD_SCREEN_ROUTE: (_) =>
            ChangePasswordScreen(),
        ForgetPasswordScreen.FORGET_PASSWORD_SCREEN_ROUTE: (_) =>
            ForgetPasswordScreen(),
        ResetPasswordScreen.RESET_PASSWORD_SCREEN_ROUTE: (_) =>
            ResetPasswordScreen(),
        SplashScreen.SPLASH_SCREEN_ROUTE: (_) => SplashScreen(),
        SplashLanguageScreen.SPLASH_LANGUAGE_SCREEN_ROUTE: (_) =>
            SplashLanguageScreen(),
        AboutApp.ABOUT_APP_SCREEN_ROUTE: (_) => AboutApp(),
        CallUs.CALL_US_SCREEN_ROUTE: (_) => CallUs(),
        CartScreen.Cart_Route:(_)=> CartScreen(),
        OrderScreen.Order_Screen_Route:(_)=>OrderScreen()
      },
    );
  }

  getInitialRoute() {
    return   !StorageController.isSplashLogged&&StorageController.getString(StorageController.type)==null
        ? SplashScreen():
    StorageController.getString(StorageController.type)=='user'&&expire.isBefore(nowRes)?
    LoginScreen():
    StorageController.getString(StorageController.type)=='guest'?
    HomeScreen():
    StorageController.getString(StorageController.type)=='user'&&expire.isAfter(nowRes)?
    HomeScreen():LoginScreen();

  }
}