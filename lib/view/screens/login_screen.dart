

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saaty_app/cons.dart';
import 'package:saaty_app/model/http_exception.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/view/screens/forget_password_screen.dart';
import 'package:saaty_app/view/screens/home_screen.dart';
import 'package:saaty_app/view/screens/register_screen.dart';

class LoginScreen extends StatefulWidget{
  static String LOGIN_SCREEN_ROUTE='/1';
  @override
  State<StatefulWidget> createState() {
   return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  var _authController=Get.put(AuthController());
  bool _isLoading=false;
  var _formKey=GlobalKey<FormState>();
  Map<String,String> loginMap={
    'email':''
    ,'password':''
  };


  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    Color primary=Theme.of(context).primaryColor;
    Color accent=Theme.of(context).accentColor;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Stack(
                  children: [
                    Center(
                      child: Container(width:width*0.6,
                          margin: EdgeInsets.only(top: 30),
                          height: height *0.4,child: Image.asset('assets/images/login_photo.png',)),
                    ),
                    Center(
                      child: SizedBox(width:width*0.6,
                      height: height *0.1,child: Image.asset('assets/images/color.png')),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: GestureDetector(
                    onTap: (){
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Form(
                      key: _formKey,
                        child: Column(
                      children: [
                        TextFormField(
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email,color: primary,),
                            hintText:'enter_email'.tr,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primary,
                              width: 1.0,
                            ),
                           )
                           // hoverColor: Theme.of(context).primaryColor,focusColor: Colors.amber
                          ),
                          validator: (value){
                            if(!value.contains('.com')||value.isEmpty) {
                              return 'not_valid_mail'.tr;
                            }
                          },
                          onSaved: (value){
                            loginMap['email']=value;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 20,),
                        TextFormField(
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              icon: Icon(Icons.work,color: primary,),
                              hintText:'password'.tr,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: primary,
                                  width: 1.0,
                                ),
                              )
                            // hoverColor: Theme.of(context).primaryColor,focusColor: Colors.amber
                          ),
                          validator: (value){
                            if(value.isEmpty) {
                              return 'password'.tr;
                            } if(value.length<6) {
                              return  'weak_password'.tr;
                            }
                          },
                          onSaved: (value){
                            loginMap['password']=value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                        ),


                      ],
                    )),
                  ),
                ),
                SizedBox(height: 30,),
                // CheckboxListTile(
                //     title :Text('save'),value: true, onChanged: (val){}),
                _isLoading?Center(child: CircularProgressIndicator(),):
                SizedBox(
                  width: width*0.8,
                  height: 40,
                  child: RaisedButton(
                    color: accent,
                    onPressed: (){
                      loginUser();
                    },child: Text('login_user'.tr,style: Cons.whiteFont,),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),

                ),
                SizedBox(height: 15,),
                SizedBox(
                  width: width*0.8,
                  height: 40,
                  child: RaisedButton(
                    color: accent,
                    shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: (){
                   // StorageController.isGuest==true;
                    StorageController.setString(StorageController.type, 'guest');
                     //print('xxxxxxx  '+_authController.visitorFlag.toString());
                     Navigator.of(context).pushNamed(HomeScreen.HOME_SCREEN_RIUTE);
                    },child: Text('login_as_visitor'.tr,style: Cons.whiteFont,),),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(RegisterScreen.REGISTER_SCREEN_ROUTE);
                      },
                      child: Text('create_new_account'.tr,style: Cons.blackFont,),
                    ),
                    InkWell(
                      onTap: (){
                        print('jjjj');
                        Navigator.of(context).pushNamed(ForgetPasswordScreen.FORGET_PASSWORD_SCREEN_ROUTE);
                      },
                      child: Text('forget_password'.tr,style: Cons.blackFont,),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(loginMap.toString());
      setState(() {
        _isLoading=true;
      });

      try {

        await _authController.loginUser(loginMap).then((value) {
          setState(() {
            _isLoading = false;
          });
        });
        Navigator.of(context).pushReplacementNamed(HomeScreen.HOME_SCREEN_RIUTE);

      }on HttpError catch(r){
        String message='';
        if(r.message.contains('EMAIL_NOT_FOUND')){
          message='EMAIL_NOT_FOUND';
        }if(r.message.contains('INVALID_PASSWORD')){
          message='INVALID_PASSWORD';
        }if(r.message.contains('USER_DISABLED')){
          message='USER_DISABLED';
        }if(r.message.contains('EMAIL_EXISTS')){
          message='EMAIL_EXISTS';
        }if(r.message.contains('INVALID_EMAIL')){
          message='INVALID_EMAIL';
        }

        _showErrorMessage(context, message);
      }
      catch(err){
        _showErrorMessage(context, err.toString());
      }
    }
  }

  _showErrorMessage(BuildContext context, String message) {
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('Authonication Failed'),
          content:Text(message) ,
          actions: [
            FlatButton(onPressed:(){
              Navigator.of(context).pop();
              setState(() {
                _isLoading=false;
              });
            },
                child: Text('OK!'))
          ],
        ));

  }


}
