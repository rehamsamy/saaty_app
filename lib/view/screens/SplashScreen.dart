
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/splash_model.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/view/screens/splah_language_screen.dart';


import '../../cons.dart';

class SplashScreen extends StatefulWidget {
  static String SPLASH_SCREEN_ROUTE='/18';


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StorageController _storageController=Get.put(StorageController());
  int _index;
  @override
  Widget build(BuildContext context) {
    Cons.buildColors(context);
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    CarouselController buttonCarouselController = CarouselController();
    List<SplashModel> _splahList=[
      new SplashModel('assets/images/splash_photo_1.png','أختر منتجك وطريقة الدفع '),
      new SplashModel('assets/images/splash_photo_2.png','يصل اليك منتجك بأسرع وقت '),
      new SplashModel('assets/images/splash_photo_3.png','يسعدنا رضا جميع عملاؤنا البائعين والمشترين  ')
    ];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SizedBox(height: 10,),
            Transform.rotate(
              alignment: Alignment.bottomCenter,
              angle: 0.5,
              child: Center(
                child: SizedBox(width:width*0.6,
                    height: height *0.1,child: Image.asset('assets/images/color.png')),
              ),
            ),
            CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                  onPageChanged: (ind,x)async{
                    setState(() {
                      _index=ind;
                    });
                    if(ind==2){
                      Navigator.of(context).pushNamed(SplashLanguageScreen.SPLASH_LANGUAGE_SCREEN_ROUTE);
                     await StorageController.setBool(StorageController.splashKey, true);
                    }
                  },
                  initialPage: 1,
                  autoPlayAnimationDuration: Duration(seconds: 5),
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio:6/6,
                  viewportFraction:0.81
              ),
              items: _splahList.map((e) =>
                 Container(
                  height: height*.6,
                 //  color: Colors.red,
                   child: Column(
                     children: [
                       SizedBox(height: 10,),
                       ClipRRect(
                         borderRadius: BorderRadius.all(Radius.circular(1.0)),
                         child: Image.asset(e.img,
                           fit: BoxFit.contain,
                           width: 200.0,
                           height: height*0.4,
                         ),
                       ),
                       SizedBox(height: 20,),
                       Text(e.txt,style: TextStyle(color: Colors.black,fontSize: 15,fontStyle: FontStyle.italic),)
                     ],
                   ),
                 )
              ).toList(),
            ),

            SizedBox(height: 10,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCircleSlider(0),
                  buildCircleSlider(1),
                  buildCircleSlider(2),
                ],
              ),
            ),

          ],
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
