import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaty_app/cons.dart';
import 'package:saaty_app/view/widget/register_widget.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  static String REGISTER_SCREEN_ROUTE = '/2';

  @override
  State createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FocusScope.of(context).unfocus();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Cons.buildColors(context);

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              floating: true,
              centerTitle: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'create_new_account'.tr,
                    style: Cons.greyFont,
                  ),
                  background: Image.asset(
                    'assets/images/signup_photo_1.png',
                    fit: BoxFit.contain,
                  )),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(70.0),
                child: Card(
                  color: Colors.white,
                  elevation: 1,
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

          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            RegisterWidget(0),
            RegisterWidget(1),
          ],
        ),
      ),
    );
  }
}
