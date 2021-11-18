import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saaty_app/model/store_model.dart';
import 'package:saaty_app/view/widget/app_drawer.dart';

import '../../cons.dart';

class MainPageScreen extends StatefulWidget {

  @override
  _MainPageScreenState createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> with SingleTickerProviderStateMixin {
  TabController _controller;
  double width,height;

List<StoreModel> stores=[
  StoreModel('Store1', 'assets/images/store1.png'),
  StoreModel('Store2', 'assets/images/store2.png'),
  StoreModel('Store3', 'assets/images/store3.png'),
  StoreModel('Store14', 'assets/images/store4.png')
];

  @override
  void initState() {
    super.initState();
    _controller=TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

     width=MediaQuery.of(context).size.width;
     height=MediaQuery.of(context).size.height;
   // FocusManager.instance.primaryFocus.unfocus();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Container(
          //height: 250,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                  child: AppBar( title: Text('Stores',style: Cons.greyFont),
                  elevation:8,
                  actions: [
                    IconButton(icon:Icon(Icons.home,color: Cons.accent_color,size: 25,)),
                  ],),),
              SizedBox(height: 2,),
              Expanded(
                flex: 1,
                child: Card(
                  margin: EdgeInsets.all(2),
                  elevation: 6,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'search',
                        prefixIcon: Icon(Icons.search,color: Cons.accent_color,size: 25,),
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(
                           color: Cons.accent_color,
                           width: 1.0,
                         ),
                       )
                       //ثى prefix: Icon(Icons.search,color: Cons.accent_color,)
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex:1,child: Card(
                elevation: 4,
                    child: TabBar(tabs: [
                      Tab(text: 'Stores',),
                      Tab(text: 'Watches',),
                      Tab(text: 'Bracletes',)
              ],
                controller: _controller,
              ),
                  )),
            ],
          ),
        ),
      )
     ,
      body: Container(
        height: height*0.7,
        child: TabBarView(
          controller: _controller,
          children: [
           buildGrid(0),
            buildGrid(1),
            buildGrid(2)

          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }

Widget  buildGrid(int i) {
    return
      GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio:8/9,
          crossAxisCount: 2
        ),
          itemCount: stores.length,
          itemBuilder: (ctx,inx){
          return storeGridItem(stores,inx);
          }
    );
  }


  Widget storeGridItem(List<StoreModel> stores,int indx){
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child:
         Card(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10)
           ),
           elevation: 8,
           child: Padding(
             padding:EdgeInsets.fromLTRB(1, 0, 1, 0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Image.asset(stores[indx].image,fit: BoxFit.contain,),
                 SizedBox(height: 10,),
                 Center(child: Text(stores[indx].name,))
               ],
             ),
           ),
         ),
    );
  }
}
