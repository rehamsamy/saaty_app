import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../cons.dart';

class MessageDetailScreen extends StatelessWidget {
  static String MESSAGES_Detail_SCREEN_ROUTE='/12';
  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(
     appBar:  AppBar(
        title: Text('Messages',style: Cons.greyFont),
    centerTitle: true,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading:
                 Transform.scale(scale:2,child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Image.asset('assets/images/sidemenu_photo.png',width: 50,height: 50,fit: BoxFit.fill,),
                 )),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 5.0, right: 0.0,top: 0.0,bottom: 0.0),
                    leading: Icon(Icons.person,color: Cons.primary_color,),title: Text('name'),),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 5.0, right: 0.0,top: 0.0,bottom: 0.0),
                    leading: Icon(Icons.email,color: Cons.primary_color,),title: Text('email'),),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 5.0, right: 0.0,top: 0.0,bottom: 0.0),
                    leading: Icon(Icons.phone_android_sharp,color: Cons.primary_color,),title: Text('phone'),)
                ],
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          width: width *0.4,
                          height: 50,child: Center(child: Text('Forward',style: Cons.blueFont,))),
                    ),
                    // SizedBox(width: 10,),
                    FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          width: width *0.4,
                          height: 50,child: Center(child: Text('Remove This',style: Cons.blueFont,))),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
