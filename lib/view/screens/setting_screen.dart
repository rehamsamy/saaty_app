

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/lang_controller.dart';
import 'package:saaty_app/view/screens/main_page_screen.dart';

import '../../cons.dart';

class SettingScreen extends StatelessWidget {
  static String SETTING_SCREEN_ROUTE='/9';
  LangController _langController=Get.find();

  @override
  Widget build(BuildContext context) {
     double width=MediaQuery.of(context).size.width;
     double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting',style: Cons.greyFont,),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.home,color: Cons.accent_color,),
        onPressed:() =>Navigator.of(context).pushReplacementNamed(MainPageScreen.MAIN_PRAGE_ROUTE),),
      ),
      body:   Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Stack(
              children: [
                Center(
                  child: Container(width:width*0.6,
                      margin: EdgeInsets.only(top: 30),
                      height: height *0.4,child: Image.asset('assets/images/setting_photo.png',)),
                ),
                Center(
                  child: SizedBox(width:width*0.6,
                      height: height *0.1,child: Image.asset('assets/images/color.png')),
                ),

              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            height: 100,
            child: Card(
              elevation: 10,
            child:  Center(
              child: ListTile(
                trailing: IconButton(icon: Icon(Icons.arrow_forward_ios,color: Cons.accent_color,),
                onPressed: (){
                  showChangeLangDialog(context);
                },),
                title: Text('Language',style: Cons.blackFont,),
                subtitle: Padding(
                    padding:EdgeInsets.all(5),child: Text('English',style: Cons.greyFont1,)),
              ),
            ),
            )
          )
        ],
      ),

    );
  }

  void showChangeLangDialog(BuildContext context) {
    showDialog(context: context, builder: (ctx)=>
        AlertDialog(
          title: Text('Change To Prefered Language',style: Cons.accentFont,),
          content:Container(
            width:MediaQuery.of(context).size.width,
            child: LayoutBuilder(
              builder: (_,cons)=>
               GetBuilder<LangController>(
                 builder: (_)=>
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: cons.maxWidth*0.4,
                      child: RaisedButton(
                        color: Cons.accent_color,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        onPressed: (){
                          _langController.changeLang(false);
                        },child: Text('العربيه',style: Cons.whiteFont,),),
                    ),
                    SizedBox(width: cons.maxWidth*0.05,),
                    SizedBox(
                      width: cons.maxWidth*0.4,
                      child: RaisedButton(
                        color: Cons.accent_color,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        onPressed: (){
                          _langController.changeLang(true);
                        },child: Text('English',style: Cons.whiteFont,),),
                    ),
                  ],
              ),
               ),
            ),
          ) ,

        )
    );

  }
}
