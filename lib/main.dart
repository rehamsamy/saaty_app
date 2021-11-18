import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/cons.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/view/screens/create_product_screen.dart';
import 'package:saaty_app/view/screens/home_screen.dart';
import 'package:saaty_app/view/screens/login_screen.dart';
import 'package:saaty_app/view/screens/main_page_screen.dart';

import 'view/screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final controller = Get.put(AuthController());

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
      home: LoginScreen(),
      routes: {
         LoginScreen.LOGIN_SCREEN_ROUTE:(_)=>LoginScreen(),
        RegisterScreen.REGISTER_SCREEN_ROUTE:(_)=>RegisterScreen(),
        HomeScreen.HOME_SCREEN_RIUTE:(_)=>HomeScreen(),
        CreateProductScreen.CREATE_PRODUCT_ROUTE:(_)=>CreateProductScreen()
      },
    );
  }
}