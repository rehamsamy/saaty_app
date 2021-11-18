import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
           Text('Welcome To Saaty As Visitor',style: TextStyle(color: Cons.accent_color,fontSize: 18),),
            SizedBox(height: 20,),
            Divider(color: Cons.primary_color,thickness: 1.5,),
            SizedBox(height: 15,),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Cons.primary_color,
              ),
              title: Text('Main Page'),
            ),

            ListTile(
              leading: Icon(
                Icons.settings,
                color: Cons.primary_color,
              ),
              title: Text('Setting'),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Cons.primary_color,
              ),
              title: Text('About App'),
            ),
            ListTile(
              leading: Icon(
                Icons.help_rounded,
                color: Cons.primary_color,
              ),
              title: Text('Who Are We'),
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Cons.primary_color,
              ),
              title: Text('Call Us'),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Cons.primary_color,
              ),
              title: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
