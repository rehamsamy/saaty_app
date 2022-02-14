import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:saaty_app/model/splash_model.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/login_register/screen/login_screen.dart';

import '../cons.dart';
import '../main_page/screen/main_page_screen.dart';

class AboutApp extends StatelessWidget {
  static String ABOUT_APP_SCREEN_ROUTE='/20';
  StorageController _storageController=Get.put(StorageController());



  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;



    return Scaffold(
      appBar: AppBar(
        title: Text('about_app'.tr,style: Cons.greyFont,),
        actions: [
          IconButton(icon:Icon(Icons.home,color: Cons.accent_color,),
            onPressed: ()=>Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE),)
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
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
                    height: height *0.4,child: Image.asset('assets/images/about_app_photo.png',)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
               // height: 100,
                child: Center(child: Text('هو تطبيق يوفر للتجار والمستخدمين عرض منتجاتهم من الساعات - الاساور بغرض بيعها للمشترين عن طريق نشر بيانات منتجاتهم علي التطبيق ونشر وساءل الاتصال الخاصه بهم لكي يعمل التطبيق علي عرضها علي المشترين كوسيط بين البائع والمشتري فقط للتواصل مع بعضهم البعض واتمام عمليه البيع '.tr,
                  style: TextStyle(color: Colors.black,fontSize: 15,fontStyle: FontStyle.italic,),textAlign: TextAlign.center,)),
              ),
              SizedBox(height: 30,),



            ],
          ),
        ),
      ),
    );
  }



}
