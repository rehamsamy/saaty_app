import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cons {
  static Color primary_color=Colors.white;
  static Color accent_color=Colors.white;

  static var whiteFont=TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold );
  static var blackFont=TextStyle(color: Colors.black,fontSize: 15,fontStyle: FontStyle.italic);
  static var greyFont=TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.bold);
  static var blueFont=TextStyle(color: Color.fromARGB(255,123,196,229),fontSize: 20,fontWeight: FontWeight.bold);
  static var greyFont1=TextStyle(color: Colors.black54,fontSize: 18);




 static void buildColors(BuildContext ctx){
   primary_color=Theme.of(ctx).primaryColor;
   accent_color=Theme.of(ctx).accentColor;
 }
//static Widget getAppbar(String title);

}