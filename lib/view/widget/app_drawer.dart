import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/message_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/view/screens/about_app.dart';
import 'package:saaty_app/view/screens/account_screen.dart';
import 'package:saaty_app/view/screens/ads_screen.dart';
import 'package:saaty_app/view/screens/call_us.dart';
import 'package:saaty_app/view/screens/create_product_screen.dart';
import 'package:saaty_app/view/screens/home_screen.dart';
import 'package:saaty_app/view/screens/login_screen.dart';
import 'package:saaty_app/view/screens/main_page_screen.dart';
import 'package:saaty_app/view/screens/messages_screen.dart';
import 'package:saaty_app/view/screens/setting_screen.dart';
import 'package:saaty_app/view/screens/stores_screen.dart';

import '../../cons.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  MessageController _messageController=Get.find();
  AuthController _authController=Get.find();
  StorageController _storageController=Get.find();
  @override
  Widget build(BuildContext context){
    String flag='all';
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
            icon:  Icon(Icons.arrow_back,color: Cons.accent_color,),
            onPressed: () { Navigator.pop(context); }),
          ),
              SizedBox(height: 20,),
              ListTile(
                leading: Image.asset('assets/images/sidemenu_photo.png',fit: BoxFit.cover,),
                title: Text(_storageController.UserModelData.name),
              ),
              SizedBox(height: 15,),
              SizedBox(
                width: double.infinity-20,
                height: 45,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateProductScreen.CREATE_PRODUCT_ROUTE);
                  },
                  child: Text(
                    'add_ads'.tr,
                    style: TextStyle(color: Colors.white,fontSize: 16),
                  ),
                  color: Cons.accent_color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Cons.primary_color,
                ),
                title: Text('main_page'.tr),
                onTap: ()=>Navigator.of(context).pushNamed(HomeScreen.HOME_SCREEN_RIUTE),
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Cons.primary_color,
                ),
                title: Text('my_account'.tr),
                  onTap: ()=>Navigator.of(context).pushNamed(AccountScreen.ACCOUNT_SCREEN_ROUTE)
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Cons.primary_color,
                ),
                title: Text('favorites'.tr),
                onTap: (){
                  Navigator.of(context).pushNamed(AdsScreen.ADS_SCREEN_ROUTE,arguments:flag='fav' );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.add_alert,
                  color: Cons.primary_color,
                ),
                title: Text('my_ads'.tr),
                onTap: (){
                  Navigator.of(context).pushNamed(AdsScreen.ADS_SCREEN_ROUTE,arguments:flag='ads' );
                },
              ),
              ListTile(
                onTap: ()=>Navigator.of(context).pushNamed(MessageScreen.MESSAGES_SCREEN_ROUTE)
                ,
                leading: Icon(
                  Icons.message_sharp,
                  color: Cons.primary_color,
                ),
                title: Text('messages'.tr),
                trailing:_messageController.receivedMessage.length>0? Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Cons.accent_color,
                  ),
                  child: Center(child: Text('ss',style: TextStyle(color: Colors.white),)),
                ):null,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Cons.primary_color,
                ),
                title: Text('setting'.tr),
                  onTap: ()=>Navigator.of(context).pushNamed(SettingScreen.SETTING_SCREEN_ROUTE)
              ),
              ListTile(
                onTap: ()=>Navigator.of(context).pushNamed(AboutApp.ABOUT_APP_SCREEN_ROUTE),
                leading: Icon(
                  Icons.info,
                  color: Cons.primary_color,
                ),
                title: Text('about_app'.tr),

              ),
              // ListTile(
              //   onTap: ()=>Navigator.of(context).pushNamed(CallUs.CALL_US_SCREEN_ROUTE),
              //   leading: Icon(
              //     Icons.help_rounded,
              //     color: Cons.primary_color,
              //   ),
              //   title: Text('about_us'.tr),
              // ),
              ListTile(
                onTap: ()=>Navigator.of(context).pushNamed(CallUs.CALL_US_SCREEN_ROUTE),
                leading: Icon(
                  Icons.phone,
                  color: Cons.primary_color,
                ),
                title: Text('call_us'.tr),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pushNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
                },
                leading: Icon(
                  Icons.logout,
                  color: Cons.primary_color,
                ),
                title: Text('log_out'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
