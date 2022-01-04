import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/cons.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/fav_ads_controller.dart';
import 'package:saaty_app/providers/message_controller.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/status_product_controller.dart';
import 'package:saaty_app/view/screens/ads_screen.dart';
import 'package:saaty_app/view/screens/create_product_screen.dart';
import 'package:saaty_app/view/screens/home_screen.dart';
import 'package:saaty_app/view/screens/login_screen.dart';
import 'package:saaty_app/view/screens/main_page_screen.dart';
import 'package:saaty_app/view/screens/message_detail_screen.dart';
import 'package:saaty_app/view/screens/messages_screen.dart';
import 'package:saaty_app/view/screens/product_item_detail_screen.dart';
import 'package:saaty_app/view/screens/send_message_screen.dart';
import 'package:saaty_app/view/screens/setting_screen.dart';
import 'package:saaty_app/view/screens/stores_screen.dart';

import 'providers/products_controller.dart';
import 'view/screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final controller = Get.put(AuthController());
  final controller1 = Get.put(ProductController());
  final controller2 = Get.put(ProductsController());
  final controller3 = Get.put(StatusProductController());
  final controller4=Get.put(FavsAdsController());
  final controller5=Get.put(MessageController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //int x=5;
    Cons.buildColors(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255,213,177,57),
         unselectedWidgetColor: Color.fromARGB(255,123,196,229),
         // rgba(228,190,55,255)
        accentColor: Color.fromARGB(255,123,196,229),
        canvasColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,
          foregroundColor: Colors.grey.shade300,
          brightness: Brightness.light,
          iconTheme: IconThemeData(
            color: Theme.of(context).accentColor
          )
        )

    ),
      home: MessageScreen(),
      routes: {
         LoginScreen.LOGIN_SCREEN_ROUTE:(_)=>LoginScreen(),
        RegisterScreen.REGISTER_SCREEN_ROUTE:(_)=>RegisterScreen(),
        HomeScreen.HOME_SCREEN_RIUTE:(_)=>HomeScreen(),
        CreateProductScreen.CREATE_PRODUCT_ROUTE:(_)=>CreateProductScreen(),
        MainPageScreen.MAIN_PRAGE_ROUTE:(_)=>MainPageScreen(),
        ProductItemDetailScreen.PRODUCT_DETAIL_ROUTE:(_)=>ProductItemDetailScreen(),
        SendMessageScreen.SEND_MESSAGE_SCREEN_ROUTE:(_)=>SendMessageScreen(),
        AdsScreen.ADS_SCREEN_ROUTE:(_)=>AdsScreen(),
        SettingScreen.SETTING_SCREEN_ROUTE:(_)=>SettingScreen(),
        StoresScreen.Stores_SCREEN_ROUTE:(_)=>StoresScreen(),
        MessageScreen.MESSAGES_SCREEN_ROUTE:(_)=>MessageScreen(),
        MessageDetailScreen.MESSAGES_Detail_SCREEN_ROUTE:(_)=>MessageDetailScreen()
      },
    );
  }
}