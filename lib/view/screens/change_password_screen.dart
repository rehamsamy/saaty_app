

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/view/screens/account_screen.dart';

import '../../cons.dart';

class ChangePasswordScreen extends StatelessWidget {
  static String CHANGE_PASSWORD_SCREEN_ROUTE='/15';
  var _formKey = GlobalKey<FormState>();
  AuthController _authController=Get.find();
  var _oldController=TextEditingController();
  var _newController=TextEditingController();
  var _confirmController=TextEditingController();
  String password;
  Map<String, String> map = {
    'old': '',
    'new': '',
    'confirm': '',
  };
  @override
  Widget build(BuildContext context) {
     password=ModalRoute.of(context).settings.arguments as String;
    return GetBuilder<AuthController>(
      builder: (_)=> Scaffold(
          appBar: AppBar(
            title: Text('my_account'.tr,style: Cons.greyFont,),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child:
                      Image.asset('assets/images/sidemenu_photo.png',width: 120,height: 120,),
                    ),
                    SizedBox(height: 30,),
                    Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buidTextForm('old'.tr, 'Enter Old Password', Icons.person, map,
                                  TextInputType.text),
                              SizedBox(
                                height: 20,
                              ),
                              buidTextForm('new'.tr, 'Enter New Password', Icons.email, map,
                                  TextInputType.text),
                              SizedBox(
                                height: 20,
                              ),
                              buidTextForm('confirm'.tr, 'Enter Confirm Password', Icons.phone_android_sharp, map,
                                  TextInputType.text),
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
                          changePassword(context);
                        }, child: Text('Save'.tr, style: Cons.whiteFont,),),
                    ),]
              ),
            ),
          )
      ),
    );
  }



  Widget buidTextForm(String flag, String hint, IconData icon,
      Map<String, String> map, TextInputType inputType) {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: flag=='old'?_oldController:flag=='new'?_newController:_confirmController,
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
        if (flag=='old' && value.isEmpty) {
          return 'enter old password';
        }if (flag=='new' && value.isEmpty) {
          return 'enter new password';
        }if (flag=='confirm' && value.isEmpty) {
          return 'enter confirm password';
        }
        if(password !=_oldController.text){
          return 'old password is incorrect ';
        }
        if(_newController.text != _confirmController.text){
          return 'password not match ';
        }

      },
      onSaved: (value) {
        //loginMap['password'] = value!;
        if (flag == 'old') {
          map['old'] = value;
        }
        if (flag == 'new') {
          map['new'] = value;
        }
        if (flag == 'confirm') {
          map['confirm'] = value;
        }
      },
      keyboardType: inputType,
    );
  }

  void changePassword(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if(_authController.isLoading==true){
        showAlertMessageSend(context);
      }else{
        Navigator.of(context).pop();
      }
      _authController.changePassword(map).then( ()
          {
            Navigator.of(context).pushNamed(AccountScreen.ACCOUNT_SCREEN_ROUTE);
            _authController.changeIsLoading(false);
            Navigator.of(context).pop();
          }
      );
    }
  }


  void showAlertMessageSend(BuildContext context) {
    showDialog(context: context, builder: (_)=>
        AlertDialog(
          title: Text('Send Message'),
          content: Container(
              width:100,
              height:100,
              child: Center(child: CircularProgressIndicator())),
        ));
  }

}
