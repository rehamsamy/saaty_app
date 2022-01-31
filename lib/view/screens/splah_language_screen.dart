import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:saaty_app/model/splash_model.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/view/screens/login_screen.dart';

import '../../cons.dart';

class SplashLanguageScreen extends StatelessWidget {
  static String SPLASH_LANGUAGE_SCREEN_ROUTE='/19';
  StorageController _storageController=Get.put(StorageController());

  int _index;

  final List locale =[
    {'name':'ENGLISH','locale': Locale('us')},
    {'name':'العربية','locale': Locale('ar')},

  ];
  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }


  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;



    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Center(
              child: SizedBox(width:width*0.6,
                  height: height *0.1,child: Image.asset('assets/images/color.png')),
            ),
            Center(
              child: Container(width:width*0.6,
                  margin: EdgeInsets.only(top: 30),
                  height: height *0.4,child: Image.asset('assets/images/splash_language.png',)),
            ),
            Center(child: Text('choose_lang'.tr,style: TextStyle(color: Colors.black,fontSize: 18,fontStyle: FontStyle.italic),)),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width*0.4,
                  height: 40,
                  child: RaisedButton(
                    color: Cons.accent_color,
                    onPressed: ()async{
                      updateLanguage(locale[1]['locale']);
                    await  StorageController.setString(StorageController.languageKey,'ar');
                      Navigator.of(context).pushNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
                    },child: Text('العربية',style: Cons.whiteFont,),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),

                ),
                SizedBox(height: 15,),
                SizedBox(
                  width: width*0.4,
                  height: 40,
                  child: RaisedButton(
                    color: Cons.accent_color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: ()async{
                      updateLanguage(locale[0]['locale']);
                    await  StorageController.setString(StorageController.languageKey,'en');
                      Navigator.of(context).pushNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
                    },child: Text('English',style: Cons.whiteFont,),),
                ),
              ],
            ),
            SizedBox(height: 10,),


          ],
        ),
      ),
    );
  }



}
