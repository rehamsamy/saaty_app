
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/message_controller.dart';
import 'package:saaty_app/view/screens/message_detail_screen.dart';

import '../../cons.dart';

class MessageItemWidget extends StatelessWidget {
  bool messageSelectedFlag;
  int index;

  MessageItemWidget(this.index);

 // MessageItemWidget(this.messageSelectedFlag);
  MessageController _messageController=Get.find();
  bool _cheked=false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (_)=>
       GestureDetector(
         onTap: (){
           Navigator.of(context).pushNamed(MessageDetailScreen.MESSAGES_Detail_SCREEN_ROUTE);
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
             visible: true,
             child: Positioned(
              // top: 10,
               bottom: 1,
               left: 1,
               child: Transform.scale(
                 scale: 1.3,
                 child: Checkbox(value: _messageController.isChecked[index], onChanged: (val){
                   _messageController.isChecked[index]=val;
                   _messageController.update();
                 // if(messageSelectedFlag==true){
                 //   _messageController.changeCheckedMessageAll(true);
                 // //  _cheked=true;
                 // }else{
                 //   _messageController.changeCheckedMessage(val);
                 // }
                 },
                 side: BorderSide(color: Cons.primary_color,width: 1.5),),
               ),
             ),
           )
          ]
          ),
          title: Text('Name'),
            subtitle: Text('sum fjfhjf  gigjk  fsum fjfhjf  gigjk'
                'sum fjfhjf  gigjk sum fjfhjf  gigjk sum fjfhjf  gigjk ',overflow: TextOverflow.ellipsis,),
            trailing: Text('time not'),
          ),
        )
      ),
    );
  }
}
