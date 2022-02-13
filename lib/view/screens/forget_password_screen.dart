import 'package:flutter/material.dart';


import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:saaty_app/cons.dart';
import 'package:saaty_app/model/http_exception.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/home_page/screen/home_screen.dart';
import 'package:saaty_app/view/screens/login_screen.dart';
import 'package:saaty_app/view/screens/register_screen.dart';
import 'package:saaty_app/view/screens/reset_password_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String FORGET_PASSWORD_SCREEN_ROUTE = '/16';
  var controller = Get.put(AuthController());
  bool _isLoading = false;
  var _formKey = GlobalKey<FormState>();
  Map<String, String> loginMap = {
    'email': ''
  };

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    Color primary = Theme
        .of(context)
        .primaryColor;
    Color accent = Theme
        .of(context)
        .accentColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('forget_password'.tr,style: Cons.greyFont,),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Stack(
                children: [
                  Center(
                    child: Container(width: width * 0.6,
                        margin: EdgeInsets.only(top: 30),
                        height: height * 0.4,
                        child: Image.asset('assets/images/login_photo.png',)),
                  ),
                  Center(
                    child: SizedBox(width: width * 0.6,
                        height: height * 0.1,
                        child: Image.asset('assets/images/color.png')),
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 0),
                child: GestureDetector(
                  onTap: () {
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
                                icon: Icon(Icons.email, color: primary,),
                                hintText: 'email'.tr,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primary,
                                    width: 1.0,
                                  ),
                                )
                              // hoverColor: Theme.of(context).primaryColor,focusColor: Colors.amber
                            ),
                            validator: (value) {
                              if (!value.contains('.com') || value.isEmpty) {
                                return 'not valid mail';
                              }
                            },
                            onSaved: (value) {
                              loginMap['email'] = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(height: 30,),
              // CheckboxListTile(
              //     title :Text('save'),value: true, onChanged: (val){}),
              _isLoading ? Center(child: CircularProgressIndicator(),) :
              SizedBox(
                width: width * 0.8,
                height: 45,
                child: RaisedButton(
                  color: accent,
                  onPressed: () {
                    loginUser(context);
                  }, child: Text('confirm'.tr, style: Cons.whiteFont,),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),

              ),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }

  void loginUser(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(loginMap.toString());

      try {
        await controller.resetForgetPassword(loginMap).then((value) {
          _isLoading = false;

          Fluttertoast.showToast(
              msg: 'check your email to reset your password',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.yellow
          );
        });
        // Navigator.of(context).pushReplacementNamed(
        //    ResetPasswordScreen.RESET_PASSWORD_SCREEN_ROUTE);
        Navigator.of(context).pushReplacementNamed(
             LoginScreen.LOGIN_SCREEN_ROUTE);
      } on HttpError catch (r) {
        String message = '';
        if (r.message.contains('EMAIL_NOT_FOUND')) {
          message = 'EMAIL_NOT_FOUND';
        }
        if (r.message.contains('INVALID_PASSWORD')) {
          message = 'INVALID_PASSWORD';
        }
        if (r.message.contains('USER_DISABLED')) {
          message = 'USER_DISABLED';
        }
        if (r.message.contains('EMAIL_EXISTS')) {
          message = 'EMAIL_EXISTS';
        }
        if (r.message.contains('INVALID_EMAIL')) {
          message = 'INVALID_EMAIL';
        }

        _showErrorMessage(context, message);
      }
      catch (err) {
        _showErrorMessage(context, err.toString());
      }
    }
  }


  _showErrorMessage(BuildContext context, String message) {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('Authonication Failed'),
          content: Text(message),
          actions: [
            FlatButton(onPressed: () {
              Navigator.of(context).pop();
              _isLoading = false;
            },
                child: Text('OK!'))
          ],
        ));
  }

}

