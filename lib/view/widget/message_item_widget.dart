
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saaty_app/model/message_model.dart';
import 'package:saaty_app/providers/message_controller.dart';
import 'package:saaty_app/view/screens/message_detail_screen.dart';

import '../../cons.dart';

class MessageItemWidget extends StatelessWidget {
  bool messageSelectedFlag;
  int index;
  MessageModel model;
  double width,height;

  MessageItemWidget(this.index,this.model);

 // MessageItemWidget(this.messageSelectedFlag);
  MessageController _messageController=Get.find();
  bool _cheked=false;
  @override
  Widget build(BuildContext context) {
    String date = DateFormat("dd-MM-yy").format(DateTime.parse(model.date));
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;

  print(date);
    return GetBuilder<MessageController>(
      builder: (_)=>
       GestureDetector(
         onTap: (){
           Navigator.of(context).pushNamed(MessageDetailScreen.MESSAGES_Detail_SCREEN_ROUTE,arguments: model);
         },
        child:Card(
          child: ListTile(
          leading:Stack(
            children: [
              CircleAvatar(
                radius: 50,
              child: Image.asset('assets/images/sidemenu_photo.png'),
            ),
           Visibility(
             visible: _messageController.visibleChechBox==true?true:false,
             child: Positioned(
              // top: 10,
               bottom: 1,
               left: 1,
               child: Transform.scale(
                 scale: 1.3,
                 child: Checkbox(value: _messageController.checkedAllMessage==true?true:
                 _messageController.isChecked[index], onChanged: (val){
                   _messageController.isChecked[index]=val;
                   model.isSelected=val;
                   print('inedssss  '+ index.toString());
                   _messageController.update();
                 //  _modalBottomSheetMenu(context);
                 },
                 side: BorderSide(color: Cons.primary_color,width: 1.5),),
               ),
             ),
           )
          ]
          ),
          title: Text(model.name,style: Cons.blackFont,),
            subtitle: Text(model.title,overflow: TextOverflow.ellipsis,style: Cons.greenFont,),
            trailing: Text(date,style: TextStyle(color: Colors.deepOrange),),
          ),
        )
      ),
    );
  }




}
