import 'package:flutter/material.dart';

class SplashٍScreen extends StatefulWidget {
static String SPLASH_SCREEN_ROUTE='/18';
  @override
  _SplashٍScreenState createState() => _SplashٍScreenState();
}

class _SplashٍScreenState extends State<SplashٍScreen> {
  double width,height;

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;

    return Scaffold(
    body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
        Center(
              child: SizedBox(width:width*0.6,
               height: height *0.1,child: Image.asset('assets/images/color.png')),
        ),
          ],
    ),
    );
  }
}
