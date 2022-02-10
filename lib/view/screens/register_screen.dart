

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaty_app/cons.dart';
import 'package:saaty_app/view/widget/register_widget.dart';
import 'package:get/get.dart';
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight:height*.45,
              pinned: false,
              floating: true,
              centerTitle: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('create_new_account'.tr,style: Cons.greyFont,),
                background: Image.asset(
                                    'assets/images/signup_photo_1.png',
                                    fit: BoxFit.contain,
                                  )),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(80.0),
                child:  Card(
                  elevation: 3,
                  child: Container(
                    height: 60,
                    child: TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: Cons.accent_color,
                      labelStyle: Cons.greyFont,
                      tabs: [
                        Tab(
                          text: 'register_as_user'.tr,
                        ),
                        Tab(
                          text: 'register_as_trader'.tr,
                        )
                      ],
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ),
                ),
              ),
              ),
            SliverList(delegate: SliverChildListDelegate(
              [
              Container(
                height: height * .7,
                child: TabBarView(
                  children: [RegisterWidget(0), RegisterWidget(1)],
                  controller: _tabController,
                ),
              ),
            ]))
          ],

        ),
      ),
    );
  }
}


