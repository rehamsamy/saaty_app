import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/view/widget/app_drawer.dart';
import 'package:saaty_app/view/widget/visitor_drawer.dart';

import '../../cons.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'main_page_screen.dart';

class HomeScreen extends StatefulWidget{
  static String HOME_SCREEN_RIUTE='/3';
  @override
  State<StatefulWidget> createState() {
   return HomeScreenState();
  }

}


class HomeScreenState extends State<HomeScreen> {

  List<String> images=['assets/images/store1.png',
                        'assets/images/store2.png',
                        'assets/images/store3.png',
                        'assets/images/store4.png'];

  int _index=0;
  AuthController _authController=Get.find();


  @override
  Widget build(BuildContext context) {
    Cons.buildColors(context);
    CarouselController buttonCarouselController = CarouselController();
    return Scaffold(
      appBar: AppBar(
          title: Text('main_page'.tr,style: Cons.greyFont,),
        ),
      body: Column(
        children: [
         Expanded(flex:5, child: CarouselSlider(
         carouselController: buttonCarouselController,
         options: CarouselOptions(
           onPageChanged: (ind,x){
             setState(() {
               _index=ind;
             });
           },
           initialPage: 1,
          autoPlayAnimationDuration: Duration(milliseconds: 400),
           autoPlay: true,
           enlargeCenterPage: true,
           aspectRatio: 7/6,
           viewportFraction: 0.97
         ),
         items: images.map((e) =>
             Image.asset(e)
         ).toList(),
           ),),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCircleSlider(0),
              buildCircleSlider(1),
              buildCircleSlider(2),
              buildCircleSlider(3),
            ],
          ),
          SizedBox(height: 20,),
          
          Expanded(flex:5,child: Stack(
            children: [
              Align(
                  alignment : Alignment.bottomCenter,
                  child: Image.asset('assets/images/home_photo.png',fit: BoxFit.contain,)),
              Column(
                children: [
                buildCardItem('stores'.tr,context),
                  buildCardItem('watches'.tr,context),
                  buildCardItem('bracletes'.tr,context),

                ],
              )
            ],
          )),
        
        ],
      ),
      drawer: MyDrawer(),
    );
  }


  Widget buildCardItem(String title,BuildContext context){
      return  Card(
        margin: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
      elevation: 8,
        child: Container(
          padding: EdgeInsets.all(8),
          height:60 ,
          child: ListTile(
            trailing: Icon(Icons.arrow_forward_ios_sharp,color:Theme.of(context).accentColor),
            leading: Text(title,style: Cons.greyFont1,),
            onTap: (){
              Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE);
            },
          ),
        ),
    );
  }

  Widget buildCircleSlider(int index){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 12,
         width: 12,
       decoration: BoxDecoration(
         //borderRadius: BorderRadius.circular(30),
         border:index==_index? Border.all(width:2,color:Cons.primary_color ):Border.all(width:1,color:Cons.primary_color ),
           shape: BoxShape.circle,
         color:_index==index?Colors.white:Cons.accent_color
       ),
      ),
    );
  }




}