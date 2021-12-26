import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaty_app/cons.dart';
import 'package:saaty_app/view/widget/register_widget.dart';

class RegisterScreen extends StatefulWidget{
  static String REGISTER_SCREEN_ROUTE='/2';
  @override
  State createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen>  with SingleTickerProviderStateMixin {
   TabController _tabController;
 @override
 void initState() {
   _tabController = new TabController(length: 2, vsync: this);
   super.initState();
 }

 @override
  Widget build(BuildContext context) {
  // FocusScope.of(context).unfocus();
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    Cons.buildColors(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
     appBar: AppBar(
       title: Text('Create New Account',style: Cons.greyFont,),
     ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                     // width: width * 0.6,
                      //height: height * 0.3,
                      child: Image.asset(
                        'assets/images/signup_photo_1.png',
                        fit: BoxFit.contain,
                      )),
                ),
                Container(
                    width: width * 0.4,
                    height: height * 0.1,
                    child: Image.asset('assets/images/color.png')),
                   ]
              ),
          ),
                    Container(
                      height: 60,
                      //flex: 1,
                      child: Card(
                        elevation: 10,
                        child: TabBar(
                          unselectedLabelColor: Colors.grey,
                          labelColor: Cons.accent_color,
                          labelStyle: Cons.greyFont,
                          tabs: [
                            Tab(
                              text:'User',
                            ),
                            Tab(
                              text:'Trader',
                            )
                          ],
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Card(
                        color: Colors.white,
                       // margin: EdgeInsets.only(bottom: 50),
                        child: SizedBox(
                          height: height*0.4,
                          child: TabBarView(
                            children: [RegisterWidget(0), RegisterWidget(1)],
                            controller: _tabController,
                          ),
                        ),
                      ),
                    )
        ],
      ),
    );
  }
}


