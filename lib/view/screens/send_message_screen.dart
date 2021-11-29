import 'package:flutter/material.dart';

import '../../cons.dart';

class SendMessageScreen extends StatelessWidget {

  static String SEND_MESSAGE_SCREEN_ROUTE='/7';

  var _formKey = GlobalKey<FormState>();
  Map<String, String> map = {
    'name': '',
    'phone': '',
    'email': '',
    'messageTitle': '',
    'messageContent': '',
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Message'),
      ),
      body: SingleChildScrollView(
        child: Form(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 20),
          child: Column(
            children: [
              buidTextForm('name', 'Enter Name', Icons.person, map,
                  TextInputType.text),
              SizedBox(height: 12,),
              buidTextForm('email', 'Enter Email', Icons.email, map,
                  TextInputType.emailAddress),
              SizedBox(height: 12,),
              buidTextForm(
                  'phone', 'Enter Phone', Icons.phone_android_sharp, map,
                  TextInputType.number),
              SizedBox(height: 12,),
              buidTextForm('messageTitle', 'Enter Message Title', Icons.message_sharp, map,
                  TextInputType.text),
              SizedBox(height: MediaQuery.of(context).size.height*0.25,),
              buidTextForm('messageContent', 'Enter Message Content', Icons.email_outlined, map,
                  TextInputType.text),
              SizedBox(height: MediaQuery.of(context).size.height*0.06,),
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
                  }, child: Text('Send', style: Cons.whiteFont,),),
              ),
            ],
          ),
        )),
      ),
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
        if (value.isEmpty) {
          return 'enter password';
        }
        if (value.length < 6 &&
            (flag == 'password' || flag == 'confirm_password')) {
          return 'password weak';
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
      },
      keyboardType: inputType,
    );
  }


}
