import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/message_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/message_controller.dart';

import '../../cons.dart';

class SendMessageScreen extends StatelessWidget {

  static String SEND_MESSAGE_SCREEN_ROUTE='/7';
  MessageController _messageController =Get.find();

  var _formKey = GlobalKey<FormState>();
  Map<String, String> map = {
    'name': '',
    'phone': '',
    'email': '',
    'title': '',
    'content': '',
    'from':'',
    'to':'',
    'date':''
  };
  String name,email, phone,title, content, from,to,date;

  MessageModel messageModel;
String creator_id;

  @override
  Widget build(BuildContext context) {
    creator_id=ModalRoute.of(context).settings.arguments.toString();
    print('createdd  '+creator_id);
    return GetBuilder<MessageController>(
        builder:(_)=> Scaffold(
        appBar: AppBar(
          title: Text('send_message'.tr),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 20),
            child: Column(
              children: [
                buidTextForm('name', 'name'.tr, Icons.person, map,
                    TextInputType.text),
                SizedBox(height: 12,),
                buidTextForm('email', 'email'.tr, Icons.email, map,
                    TextInputType.emailAddress),
                SizedBox(height: 12,),
                buidTextForm(
                    'phone', 'phone'.tr, Icons.phone_android_sharp, map,
                    TextInputType.number),
                SizedBox(height: 12,),
                buidTextForm('title', 'message_title'.tr, Icons.message_sharp, map,
                    TextInputType.text),
                SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                buidTextForm('content', 'message_content'.tr, Icons.email_outlined, map,
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
                      submitSendMessage(context);
                    }, child: Text('send'.tr, style: Cons.whiteFont,),),
                ),
              ],
            ),
          )),
        ),
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

        if (value.isEmpty&&flag=='name') {
          return 'enter name';
        }if (value.isEmpty&&flag=='email') {
          return 'enter email';
        }if (value.isEmpty&&flag=='phone') {
          return 'enter phone';
        } if (value.isEmpty&&flag=='title') {
          return 'enter message title';
        }  if (value.isEmpty&&flag=='content') {
          return 'enter message content';
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
        if (flag == 'title') {
          map['title'] = value;
        }
        if (flag == 'content') {
          map['content'] = value;
        }
      },
      keyboardType: inputType,
    );
  }

  void submitSendMessage(BuildContext context) async{
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
   map['date']=DateTime.now().toString();
   map['from']=AuthController.userId;

   map['to']=creator_id;
   if(_messageController.isLoading==true){
     showAlertMessageSend(context);
   }else{
     Navigator.of(context).pop();
   }

   try{
     await _messageController.createNewMessage(map).then((){
       _messageController.changeLoadingMessage(false);
       Navigator.of(context).pop();
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         content: Text("send_message_sucessfully".tr),
       ));


     }

     );
   }catch(err){

   }
    }
  }

  void showAlertMessageSend(BuildContext context) {
    showDialog(context: context, builder: (_)=>
    AlertDialog(
      title: Text('send_message'.tr),
      content: Container(
          width:100,
          height:100,
          child: Center(child: CircularProgressIndicator())),
    ));
  }
}
