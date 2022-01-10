import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/user_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/view/screens/edit_account_screen.dart';

import '../../cons.dart';
import 'main_page_screen.dart';

class AccountScreen extends StatelessWidget {
  static String ACCOUNT_SCREEN_ROUTE='/13';
  AuthController _authController=Get.find();
  UserModel _userModel=AuthController.model;

  @override
  Widget build(BuildContext context) {
    fetchUserData();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account',style: Cons.greyFont,),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.home,color: Cons.accent_color,),
          onPressed:() =>Navigator.of(context).pushReplacementNamed(MainPageScreen.MAIN_PRAGE_ROUTE),),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:
                Image.asset('assets/images/sidemenu_photo.png',width: 120,height: 120,),
            ) ,

             Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              padding: EdgeInsets.all(5),
              child: Stack(
                children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Card(
                      elevation: 12,
                      child:Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person,color: Cons.primary_color,),
                            title: Text('User Name',style: Cons.blackFont,),
                            subtitle: Text(_userModel.name),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone_android,color: Cons.primary_color,),
                            title: Text('Phone Number',style: Cons.blackFont,),
                            subtitle: Text(_userModel.mobile),
                          ),
                          ListTile(
                            leading: Icon(Icons.email,color: Cons.primary_color,),
                            title: Text('Email',style: Cons.blackFont,),
                            subtitle: Text(_userModel.email),
                          ),
                          ListTile(
                            leading: Icon(Icons.password_rounded,color: Cons.primary_color,),
                            title: Text('Password',style: Cons.blackFont,),
                            subtitle: Text(_userModel.password),
                            trailing:SizedBox(
                              width: 150,
                              child:  Row(
                                  children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Cons.accent_color,
                                              shape: BoxShape.circle
                                            ),
                                            child: Center(
                                              child: Icon(Icons.edit,color: Colors.white,),
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Cons.accent_color,
                                                shape: BoxShape.circle
                                            ),
                                            child: Center(
                                              child: Icon(Icons.remove_red_eye,color: Colors.white,),
                                            ),
                                          )
                                  ],
                                )

                            )

                          )
                        ],
                      ) ,

                   ),
                ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: ()=>Navigator.of(context).pushNamed(EditAccountScreen.EDIT_ACCOUNT_SCREEN_ROUTE),
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Cons.accent_color
                        ),
                        child:Icon(Icons.edit,color: Colors.white,size: 30,)
                        ,
                      ),
                    ),
                  )

    ]
              ),
            ),
          ],
        ),

    );
  }

  void fetchUserData() async{
    await _authController.getUserDate();
  }
}
