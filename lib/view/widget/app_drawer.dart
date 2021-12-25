import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaty_app/view/screens/ads_screen.dart';
import 'package:saaty_app/view/screens/create_product_screen.dart';
import 'package:saaty_app/view/screens/login_screen.dart';
import 'package:saaty_app/view/screens/main_page_screen.dart';

import '../../cons.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                title: Text('user name'),
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
                    'Add Product',
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
                title: Text('Main Page'),
                onTap: ()=>Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE),
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Cons.primary_color,
                ),
                title: Text('My Account'),
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Cons.primary_color,
                ),
                title: Text('Favorites'),
                onTap: (){
                  Navigator.of(context).pushNamed(AdsScreen.ADS_SCREEN_ROUTE,arguments:flag='fav' );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.add_alert,
                  color: Cons.primary_color,
                ),
                title: Text('My Ads'),
                onTap: (){
                  Navigator.of(context).pushNamed(AdsScreen.ADS_SCREEN_ROUTE,arguments:flag='ads' );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.message_sharp,
                  color: Cons.primary_color,
                ),
                title: Text('Messages'),
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
                onTap: (){
                  Navigator.of(context).pushReplacementNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
                },
                leading: Icon(
                  Icons.logout,
                  color: Cons.primary_color,
                ),
                title: Text('Log Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
