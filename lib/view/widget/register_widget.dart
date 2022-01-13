import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/cons.dart';
import 'package:saaty_app/model/http_exception.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/view/screens/home_screen.dart';
import 'package:saaty_app/view/screens/register_screen.dart';

class RegisterWidget extends StatefulWidget {
  int userType;
  RegisterWidget(this.userType);
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  bool _isLoading=false;
  var _formKey = GlobalKey<FormState>();
  Map<String, String> map = {
    'name': '',
    'phone': '',
    'email': '',
    'password': '',
    'confirm_password': '',
    'type': '',
    'store_name':''
  };
  var password_controller = TextEditingController();
  var confirm_password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Cons.buildColors(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buidTextForm('name', Cons.getText('user_name'), Icons.person, map,
                    TextInputType.text),
                SizedBox(height: 10,),
                buidTextForm('email', Cons.getText('email'), Icons.email, map,
                    TextInputType.emailAddress),
                widget.userType==1?
                    Column(
                      children: [
                        SizedBox(height: 10,),
                        buidTextForm(
                            'store_name', Cons.getText('store_name'), Icons.store_mall_directory_outlined, map,
                            TextInputType.text),
                      ],
                    ):
                SizedBox(height: 10,),
                buidTextForm(
                    'phone', Cons.getText('phone'), Icons.phone_android_sharp, map,
                    TextInputType.number),
                SizedBox(height: 10,),
                buidTextForm('password', Cons.getText('password'), Icons.work, map,
                    TextInputType.text),
                SizedBox(height: 10,),
                buidTextForm(
                    'confirm_password', Cons.getText('confirm_password'), Icons.work,
                    map, TextInputType.text),
                SizedBox(height: 20,),
               _isLoading?Center(child:CircularProgressIndicator()) :SizedBox(
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
                      registerUser();
                    }, child: Text(Cons.getText('register'), style: Cons.whiteFont,),),
                ),
              ],
            )),
      ),
    );
  }

  Widget buidTextForm(String flag, String hint, IconData icon,
      Map<String, String> map, TextInputType inputType) {
    print('vvvvvv ${password_controller.text}');
    return TextFormField(
      controller: flag == 'password'
          ? password_controller
          : null,
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
        if (value.isEmpty) {
          return Cons.getText('password');
        }
        if (value.length < 6 &&
            (flag == 'password' || flag == 'confirm_password')) {
          return Cons.getText('weak_password');
        }
        if (flag == 'confirm_password' && value != password_controller.text) {
          print('pppppp ${value}');
          return 'password not match';
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
        if (flag == 'password') {
          map['password'] = value;
        }
        if (flag == 'confirm_password') {
          map['confirm_password'] = value;
        }
        if (flag == 'store_name') {
          map['store_name'] = value;
        }
      },
      keyboardType: inputType,
    );
  }


  void registerUser() async{
    final AuthController ctrl = Get.find();
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
        map['type']=widget.userType.toString();
      print(map.toString());
      try {
        await ctrl.registerUser(map).then((value) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pushNamed(HomeScreen.HOME_SCREEN_RIUTE);
        }
        );

        Navigator.of(context).pushNamed(HomeScreen.HOME_SCREEN_RIUTE);
      }
    on HttpError catch(r) {
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
    } catch(e){
        print(e);
      }
    }
  }
   _showErrorMessage(BuildContext context, String message) {
    showDialog(context: context, builder: (context)=>
        AlertDialog(
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
