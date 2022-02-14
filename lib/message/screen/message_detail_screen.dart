import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/message_model.dart';
import 'package:saaty_app/providers/message_controller.dart';
import 'package:saaty_app/message/screen/messages_screen.dart';
import 'package:saaty_app/create_product/screen/send_message_screen.dart';

import '../../cons.dart';

class MessageDetailScreen extends StatelessWidget {
  static String MESSAGES_Detail_SCREEN_ROUTE='/12';
  double width;
  double height;
  MessageModel model;
  MessageController _messageController;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    model=ModalRoute.of(context).settings.arguments as MessageModel;
    _messageController=Get.find();

    return Scaffold(
     appBar:  AppBar(
        title: Text('messages'.tr,style: Cons.greyFont),
    centerTitle: true,
      ),
      body: GetBuilder<MessageController>(
       builder:(_)=> SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                      scale: 2.2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/sidemenu_photo.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.fill,
                        ),
                      )),
                  SizedBox(width: 30,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton.icon(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPressed: null,
                          icon: Icon(
                            Icons.person,
                            color: Cons.primary_color,
                          ),
                          label: Text(
                            model.name,
                            style: Cons.blackFont,
                          )),
                      FlatButton.icon(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPressed: null,
                          icon: Icon(
                            Icons.email,
                            color: Cons.primary_color,
                          ),
                          label: Text(
                            model.email,
                            style: Cons.blackFont,
                          )),
                      FlatButton.icon(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPressed: null,
                          icon: Icon(
                            Icons.phone_android_sharp,
                            color: Cons.primary_color,
                          ),
                          label: Text(
                            model.phone,
                            style: Cons.blackFont,
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              ListTile(
               leading: Icon(Icons.bookmark,color: Cons.primary_color,),
                title: Text(model.title),
              ),
              ListTile(
                leading: Icon(Icons.message,color: Cons.primary_color,),
                title: Text(model.content),
              ),
              SizedBox(height: height *0.15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width *0.4,
                    height: 50,
                    child: RaisedButton(
                      color: Cons.accent_color,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: (){
                        Navigator.of(context).pushNamed(SendMessageScreen.SEND_MESSAGE_SCREEN_ROUTE);
                      },child: Text('reply'.tr,style: Cons.whiteFont,),),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: width *0.4,
                    height: 50,
                    child: RaisedButton(
                      color: Cons.accent_color,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: (){
                        deleteSelectedMessage(model.id,context);
                        Navigator.of(context).pop();
                      },child: Text('delete'.tr,style: Cons.whiteFont,),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteSelectedMessage(String id,BuildContext context) async{
    await _messageController.deleteSingleMessage(id).then(
        await Navigator.of(context).pushNamed(MessageScreen.MESSAGES_SCREEN_ROUTE)
    );

  }
}
