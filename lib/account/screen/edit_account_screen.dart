import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/account/screen/account_screen.dart';

import '../../cons.dart';

class EditAccountScreen extends StatelessWidget {
  static String EDIT_ACCOUNT_SCREEN_ROUTE='/14';
  var _formKey = GlobalKey<FormState>();
  AuthController _authController=Get.find();
  Map<String, String> map = {
    'name': '',
    'phone': '',
    'email': '',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my_account'.tr,style: Cons.greyFont,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Center(
          child:
          Image.asset('assets/images/sidemenu_photo.png',width: 120,height: 120,),
    ),
              SizedBox(height: 20,),
              Form(
                key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buidTextForm('name', 'name'.tr, Icons.person, map,
                            TextInputType.text),
                        SizedBox(
                          height: 20,
                        ),
                        buidTextForm('email', 'email'.tr, Icons.email, map,
                            TextInputType.emailAddress),
                        SizedBox(
                          height: 20,
                        ),
                        buidTextForm('phone', 'phone'.tr, Icons.phone_android_sharp, map,
                            TextInputType.number),
                      ])
    ),
              SizedBox(height: 60,),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                height: 45,
                child: RaisedButton(
                  color: Cons.accent_color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  onPressed: () {
                    UpdateUserData(context);
                  }, child: Text('save'.tr, style: Cons.whiteFont,),),
              ),]
    ),
        ),
      )
    );
  }



  Widget buidTextForm(String flag, String hint, IconData icon,
      Map<String, String> map, TextInputType inputType) {
    return TextFormField(
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Cons.primary_color),
          hintText: hint,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Cons.primary_color,
              width: 1.0,
            ),
          )
        // hoverColor: Theme.of(context).primaryColor,focusColor: Colors.amber
      ),
      validator: (value) {
        if (flag=='name' && value.isEmpty) {
          return 'enter name';
        }if (flag=='email' && value.isEmpty) {
          return 'enter email';
        }if (flag=='phone' && value.isEmpty) {
          return 'enter phone';
        }
        if (!value.contains('.com') && flag == 'email') {
          return 'enter valid email';
        }
      },
      onSaved: (value) {
        //loginMap['password'] = value!;
        if (flag == 'name') {
          map['name'] = value;
        }
        if (flag == 'email') {
          map['email'] = value;
        }
        if (flag == 'phone') {
          map['phone'] = value;
        }
      },
      keyboardType: inputType,
    );
  }

  void UpdateUserData(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _authController.updateUserData(map).printError((err)=>print(err)).then(
          ()=>Navigator.of(context).pushNamed(AccountScreen.ACCOUNT_SCREEN_ROUTE)
      );

      Navigator.of(context).pushNamed(AccountScreen.ACCOUNT_SCREEN_ROUTE);
    }
  }

}
