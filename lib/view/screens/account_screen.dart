import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/user_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/view/screens/change_password_screen.dart';
import 'package:saaty_app/view/screens/edit_account_screen.dart';

import '../../cons.dart';
import 'main_page_screen.dart';

class AccountScreen extends StatelessWidget {
  static String ACCOUNT_SCREEN_ROUTE = '/13';
  AuthController _authController = Get.find();
  double width, height;
  UserModel _userModel;


  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  //  fetchUserData();

    // Map<String,dynamic> map= jsonDecode(StorageController.getString(StorageController.loginUserModel));
    //
    // print(map['data'].name);
   // _userModel = jsonDecode(StorageController.getString(StorageController.loginUserModel))['data'];
   // print('888888888      ' + _userModel.email);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'my_account'.tr,
          style: Cons.greyFont,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Cons.accent_color,
          ),
          onPressed: () => Navigator.of(context)
              .pushReplacementNamed(MainPageScreen.MAIN_PRAGE_ROUTE),
        ),
      ),
      body: GetBuilder<AuthController>(
        builder: (_) => Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/sidemenu_photo.png',
                    width: 120,
                    height: 120,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(5),
                  child: Stack(children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Card(
                        elevation: 12,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Cons.primary_color,
                              ),
                              title: Text(
                                'user_name'.tr,
                                style: Cons.blackFont,
                              ),
                              subtitle: Text(_userModel.name),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.phone_android,
                                color: Cons.primary_color,
                              ),
                              title: Text(
                                'phone'.tr,
                                style: Cons.blackFont,
                              ),
                              subtitle: Text(_userModel.mobile),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.email,
                                color: Cons.primary_color,
                              ),
                              title: Text(
                                'email'.tr,
                                style: Cons.blackFont,
                              ),
                              subtitle: Text(_userModel.email),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: width * 0.5,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    leading: Icon(
                                      Icons.password_rounded,
                                      color: Cons.primary_color,
                                    ),
                                    title: Text(
                                      'password'.tr,
                                      style: Cons.blackFont,
                                    ),
                                    subtitle: Text(
                                        _authController.visiblePassword == true
                                            ? _userModel.password
                                            : '********'),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Cons.accent_color,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Colors.white,
                                      onPressed: () => Navigator.of(context)
                                          .pushNamed(
                                              ChangePasswordScreen
                                                  .CHANGE_PASSWORD_SCREEN_ROUTE,
                                              arguments: _userModel.password),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Cons.accent_color,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () =>
                                          _authController.changeVisiblePassword(
                                              !_authController.visiblePassword),
                                      icon: Icon(Icons.remove_red_eye),
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: StorageController.isArabicLanguage
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            EditAccountScreen.EDIT_ACCOUNT_SCREEN_ROUTE),
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Cons.accent_color),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void fetchUserData() async {
    await _authController.getUserDate();
  }
}
