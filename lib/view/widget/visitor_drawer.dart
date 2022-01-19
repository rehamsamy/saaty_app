import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cons.dart';

class VisitorDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
            ),

            ListTile(
              leading: Icon(
                Icons.settings,
                color: Cons.primary_color,
              ),
              title: Text('setting'.tr),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Cons.primary_color,
              ),
              title: Text('about_pp'.tr),
            ),
            ListTile(
              leading: Icon(
                Icons.help_rounded,
                color: Cons.primary_color,
              ),
              title: Text('about_us'.tr),
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Cons.primary_color,
              ),
              title: Text('call_us'.tr),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Cons.primary_color,
              ),
              title: Text('logout'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
