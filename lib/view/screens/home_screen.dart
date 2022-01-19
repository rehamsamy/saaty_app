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
  double width,height;


  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    Cons.buildColors(context);
    CarouselController buttonCarouselController = CarouselController();
    return Scaffold(
      appBar: AppBar(
          title: Text('main_page'.tr,style: Cons.greyFont,),
        ),
      body: Column(
        children: [
          Container(
            height: height*0.44,
            child: Stack(children: [
              CarouselSlider(
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
                  aspectRatio: 6/4,
                  viewportFraction:0.81
              ),
              items: images.map((e) =>
                  Image.asset(e)
              ).toList(),
            ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCircleSlider(0),
                buildCircleSlider(1),
                buildCircleSlider(2),
                buildCircleSlider(3),
              ],
            ),
          ),
            ],),
          ),
          SizedBox(height: 5,)
          ,
          Container(
            height: height*0.40,
            child: Stack(
              children: [
                Align(
                    alignment : Alignment.bottomCenter,
                    child: Image.asset('assets/images/home_photo.png',fit: BoxFit.contain,)),
                LayoutBuilder(
                  builder:(_,cons)=> Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        buildCardItem('stores'.tr,context,cons),
                      buildCardItem('watches'.tr,context,cons),
                      buildCardItem('bracletes'.tr,context,cons),

                        // buildCardItem('watches'.tr,context),
                        // buildCardItem('bracletes'.tr,context),

                      ],
                    ),
                  ),
                )
              ],
            ),
          )
          
        //  Expanded(flex:5,child: ),
        
        ],
      ),
      drawer: MyDrawer(),
    );
  }


  Widget buildCardItem(String title,BuildContext context,BoxConstraints cons){
      return  Container(
        height:cons.maxHeight*0.215,
        alignment: Alignment.center,
        child: Center(
          child: Card(
          elevation: 10,
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios_sharp,color:Theme.of(context).accentColor),
                leading: Text(title,style: Cons.greyFont1,),
                onTap: (){
                  Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE);
                },

            ),
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