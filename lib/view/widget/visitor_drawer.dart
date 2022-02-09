import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/view/screens/about_app.dart';
import 'package:saaty_app/view/screens/call_us.dart';
import 'package:saaty_app/view/screens/home_screen.dart';
import 'package:saaty_app/view/screens/login_screen.dart';
import 'package:saaty_app/view/screens/setting_screen.dart';

import '../../cons.dart';

class VisitorDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Drawer(
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
                SizedBox(height: 50,),
               Text('welcome_as_visitor'.tr,style: TextStyle(color: Cons.accent_color,fontSize: 18),),
                SizedBox(height: 20,),
                Divider(color: Cons.primary_color,thickness: 1.5,),
                SizedBox(height: 15,),
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
                    Icons.settings,
                    color: Cons.primary_color,
                  ),
                  title: Text('setting'.tr),
                  onTap: ()=>Navigator.of(context).pushNamed(SettingScreen.SETTING_SCREEN_ROUTE),
                ),
                ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Cons.primary_color,
                  ),
                  title: Text('about_app'.tr),
                    onTap: ()=>Navigator.of(context).pushNamed(AboutApp.ABOUT_APP_SCREEN_ROUTE)
                ),

                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Cons.primary_color,
                  ),
                  title: Text('call_us'.tr),
                    onTap: ()=>Navigator.of(context).pushNamed(CallUs.CALL_US_SCREEN_ROUTE)
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Cons.primary_color,
                  ),
                  title: Text('login'.tr),
                    onTap:(){
                      Navigator.of(context).pushNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
                      StorageController.removeStorage();
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
