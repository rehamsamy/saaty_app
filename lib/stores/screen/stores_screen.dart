import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/main_page/widget/filter_dialog_main_page.dart';
import 'package:saaty_app/model/user_model.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/providers/status_product_controller.dart';
import 'package:saaty_app/create_product/screen/send_message_screen.dart';
import 'package:saaty_app/stores/widget/grid_list_store.dart';
import 'package:saaty_app/view/widget/product_item_widget.dart';

import '../../cons.dart';


class StoresScreen extends StatefulWidget{
  static String Stores_SCREEN_ROUTE='/10';

  @override
  State createState() {
    return StoresScreenState();
  }
}

class StoresScreenState extends State<StoresScreen>  with SingleTickerProviderStateMixin{
  var _searcController = TextEditingController();
  TabController _tabController;
  StatusProductController _statusController = Get.find();
  FocusNode _textFocus = new FocusNode();
  bool _isLoading = false;
  UserModel model;
  int _index=0;
  int index;


  @override
  void initState() {
    _tabController=TabController(length: 2, vsync: this);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> map=ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
     model= map['model'];
     index= map['index'];
    return GetBuilder<StatusProductController>(
      builder: (_)=>
       DefaultTabController(length: 2, child:
        Scaffold(
       body: CustomScrollView(
         slivers: [
           GetBuilder<StatusProductController>(
             builder: (_)=>
              SliverAppBar(
              // expandedHeight: MediaQuery.of(context).size.height*0.4,
                expandedHeight: 200,
               pinned: true,
               floating: false,
               centerTitle: true,
               snap: false,
               flexibleSpace:LayoutBuilder(
                 builder: (_,cons)=>
                  Column(
                   children: [
                     Container(
                       height: cons.maxHeight*.3,
                       child:  Card(
                         elevation: 4,
                         child: Container(color: Colors.white,
                         child: Center(child: Text(model.name)),),
                       ),
                     ),
                    Container(
                      height: cons.maxHeight*.3,
                      child:  Card(
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.all(1),
                          child: TextFormField(
                            controller: _searcController,
                            focusNode: _textFocus,
                            onChanged:(txt) =>_statusController.search(txt),
                            decoration: InputDecoration(
                                hintText: 'search'.tr,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Cons.accent_color,
                                  size: 25,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.filter_list_alt,
                                    color: Cons.accent_color,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    FilterProductDialog.buildFilterDialogWidget(context);
                                   // buildFilterDialogWidget(context);
                                  },
                                ),
                                // SizedBox(
                                //     width:10,
                                //     height:10,child: Image.asset('assets/images/nav_filter.png',width: 15,height: 15,)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Cons.accent_color,
                                    width: 1.0,
                                  ),
                                )
                              //???? prefix: Icon(Icons.search,color: Cons.accent_color,)
                            ),
                          ),
                        ),
                      ),

                      ),
                     Container(
                         height: cons.maxHeight*0.4,
                         width: cons.maxWidth,
                         child:
                         Center(

                           child:
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                                  Hero(
                                                    tag: model.userId,
                                                    child: CircleAvatar(
                                                     radius: 30,
                                                     backgroundImage: AssetImage('assets/images/store${index.toString()}.png'),
                                                 ),
                                                  ),
                                 Text(model.name),

                               ],
                             )
                                 ),
                     )
                   ] )
               ),

              ),
           ),
           SliverFillRemaining(
             child: Scaffold(
               body:   IndexedStack(
                 index: _statusController.selectedTabIndex,
                 children:[
                   GridListStores(_searcController,_isLoading),
                   GridListStores(_searcController,_isLoading),
                   // buildGrid(1),

                 ] ,
               ),
             ),
           )

         ],
       ),
            bottomNavigationBar:  _bottomNav(),
            floatingActionButton: _fab(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked

        ),
      ),
    );
  }




  onTextChange(String text){
    String text = _searcController.text;
    print('rrrr  $text');
    _statusController.search(text);
  }


  Future fetchData() async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 200));
    _statusController
        .fetchProducts('all',model.userId)
        .then((value) => setState(() => _isLoading = false))
        .catchError((err) => print('=>>>>>  $err'));
    print('length 44444444  => ${_statusController.allProducts.length}');
  }



  _bottomNav(){
    return   GetBuilder<StatusProductController>(
      builder: (_)=>
          Container(
            height: 65,
            child: BottomAppBar(
              color: Cons.primary_color,
              child: new Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: Colors.blueGrey.shade500,
                    primaryColor: Colors.red,
                    textTheme: Theme
                        .of(context)
                        .textTheme
                        .copyWith(caption: new TextStyle(color: Colors.yellow))), // sets the inactive color of the `BottomNavigationBar`
                child: new BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _statusController.selectedTabIndex,
                  selectedItemColor: Cons.primary_color,
                  onTap: (ind){
                    _statusController.changeSelectedTab(ind);
                    _statusController.update();
                  },
                  items: [
                    new BottomNavigationBarItem(
                        icon: new Icon(Icons.home,color: checkBottomColor(0),),
                       // title: new Text('old'.tr,style: TextStyle(color:checkBottomColor(0),)),
                    ),
                    new BottomNavigationBarItem(
                      icon: new Icon(Icons.face,color: checkBottomColor(1)),
                   //   title: new Text('new'.tr,style: TextStyle(color:checkBottomColor(1))),
                    ),

                  ],
                ),
              ),

              shape:CircularNotchedRectangle(),
              clipBehavior: Clip.antiAlias,
              notchMargin: 6.0,
            ),
          ),
    );
  }


  _fab() {
  //  return IconButton(onPressed: (){}, icon: Image.asset('assets/images/send_message.png',scale: 1,));
return    FloatingActionButton(
      child:Image.asset('assets/images/send_message.png',scale: 1,),
      backgroundColor: Cons.accent_color,
      onPressed: () {
        Navigator.of(context).pushNamed(SendMessageScreen.SEND_MESSAGE_SCREEN_ROUTE);
      },
    );
  }

  checkBottomColor(int index){
    return _statusController.selectedTabIndex==index?Cons.primary_color:Colors.white;
  }



}
