import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:saaty_app/model/splash_model.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/login_register/screen/login_screen.dart';
import 'package:saaty_app/main_page/screen/main_page_screen.dart';

import '../cons.dart';

class CallUs extends StatelessWidget {
  static String CALL_US_SCREEN_ROUTE='/21';


  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;



    return Scaffold(
      appBar: AppBar(
        title: Text('call_us'.tr,style: Cons.greyFont,),
        actions: [
          IconButton(icon:Icon(Icons.home,color: Cons.accent_color,),
          onPressed: ()=>Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE),)
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Center(
                  child: SizedBox(width:width*0.6,
                      height: height *0.1,child: Image.asset('assets/images/color.png',fit: BoxFit.fill,)),
                ),
                Center(
                  child: Container(width:width*0.8,
                      margin: EdgeInsets.only(top: 30),
                      height: height *0.25,child: Image.asset('assets/images/contact_photo.png',)),
                ),
                  SizedBox(height: 5,),
                Column(
                  children: [
                    ListTile(
                      title: Text('phone'.tr),
                      subtitle: Text('01143551070'),
                      leading: Icon(Icons.phone_android,color: Cons.primary_color,),
                    ),
                    ListTile(
                      title: Text('address'.tr),
                      subtitle: Text('street,area,country,city'),
                      leading: Icon(Icons.location_on,color: Cons.primary_color,),
                    ),
                    ListTile(
                      title: Text('website'.tr),
                      subtitle: Text('www.company.com'),
                      leading: Icon(Icons.vpn_lock_sharp,color: Cons.primary_color,),
                    ),

                    ListTile(
                      title: Text('email'.tr),
                      subtitle: Text('company@gmail.com'),
                      leading: Icon(Icons.email,color: Cons.primary_color,),
                    ),

                    SizedBox(height: 15,),
                    SizedBox(
                      width: width-40,
                      height: 40,
                      child: RaisedButton(
                        color: Cons.accent_color,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        onPressed: ()async{
                          Navigator.of(context).pushNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
                        },child: Text('send_message'.tr,style: Cons.whiteFont,),),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.facebook,color: Cons.accent_color,),
                        Icon(Icons.twelve_mp,color: Cons.accent_color,),
                        Icon(Icons.photo_camera,color: Cons.accent_color,),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                )



              ],
            ),
          ),
        ),
      ),
    );
  }



}
