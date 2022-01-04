import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/message_controller.dart';
import 'package:saaty_app/view/widget/message_item_widget.dart';

import '../../cons.dart';

class MessageScreen extends StatefulWidget {
  static String MESSAGES_SCREEN_ROUTE='/11';

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> with SingleTickerProviderStateMixin{
var _tabController;
double width;
double height;
bool messageSelectedFlag=false;
MessageController _messageController=Get.find();
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2,
      child: GetBuilder<MessageController>(
        builder: (_)=>
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Column(
              children: [
                Card(
                  elevation: 8,
                  child: AppBar(
                    title: Text('Messages',style: Cons.greyFont),
                  centerTitle: true,
                  actions: [
                    IconButton(onPressed: (){
                      _modalBottomSheetMenu();
                    }, icon: Icon(Icons.delete,color: Cons.accent_color,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.home,color: Cons.accent_color,)),

                  ],
                  ),
                ),
                Card(
                  elevation: 7,
                  child: TabBar(
                    onTap: (indx){
                      setState(() {
                        indx= _tabController.index ;
                      });
                    },
                    tabs: [
                      Tab(child: Text('Received',style:  _tabController.index == 0
                      ? Cons.blueFont
                          :Cons.greyFont ,),
                      ),
                  Tab(child: Text('Sender',style:  _tabController.index == 1
                      ? Cons.blueFont
                      :Cons.greyFont ,),
                  )
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              buildMessageList(),
              buildMessageList(),
            ],

          ),
        ),
      ),

    );
  }
 Widget buildMessageList() {
    return ListView.builder(
      itemCount: 4,
        itemBuilder: (_,index)=>
        MessageItemWidget(index)
    );
  }


void _modalBottomSheetMenu(){
  showModalBottomSheet(
      context: context,
      builder: (builder){
        return new Container(
          height: height * 0.3,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                    width: width *0.4,
                        height: 50,
                        child: RaisedButton(
                          color: Cons.accent_color,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          onPressed: (){
                          },child: Text('Delete',style: Cons.whiteFont,),),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: width *0.4,
                        height: 50,
                        child: RaisedButton(
                          color: Cons.accent_color,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },child: Text('Cancel',style: Cons.whiteFont,),),
                      ),
                    ],
                  ),
                 SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: (){
                         _messageController.changeCheckedMessageAll(true);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            width: width *0.4,
                            height: 50,child: Center(child: Text('select all',style: Cons.blueFont,))),
                      ),
                     // SizedBox(width: 10,),
                      FlatButton(
                        onPressed: (){
                          _messageController.changeCheckedMessageAll(false);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            width: width *0.4,
                            height: 50,child: Center(child: Text('cancell all',style: Cons.blueFont,))),
                      )
                    ],
                  )
                ],
              )),
        );
      }
  );
}
}
