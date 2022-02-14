

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/message_model.dart';
import 'package:saaty_app/providers/message_controller.dart';
import 'package:saaty_app/main_page/screen/main_page_screen.dart';
import 'package:saaty_app/message/widget/message_item_widget.dart';

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
    fetchMessages();
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1)).then((value) =>
        _messageController.changeVisibleCheckBox(false));
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
                  elevation: 5,
                  child: AppBar(
                    title: Text('messages'.tr, style: Cons.greyFont1),
                  centerTitle: true,
                  actions: [
                    IconButton(onPressed: (){
                      _messageController.changeVisibleCheckBox(true);
                      _messageController.changeCheckedMessageAll(false);
                      _modalBottomSheetMenu(context);
                    }, icon: Icon(Icons.delete,color: Cons.accent_color,)),
                    IconButton(onPressed: (){
                      Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE);
                    }, icon: Icon(Icons.home,color: Cons.accent_color,)),

                  ],
                  ),
                ),
                Card(
                  elevation: 4,
                  child: TabBar(
                    controller: _tabController,
                    onTap: (indx){
                      _messageController.changeVisibleCheckBox(false);
                      _messageController.changeSelectedTabIndex(indx);
                    },
                    tabs: [
                      Tab(child: Text('message_receive'.tr,style:  _tabController.index == 0
                      ? Cons.blueFont
                          :Cons.greyFont1,),
                      ),
                  Tab(child: Text('message_send'.tr,style:  _tabController.index == 1
                      ? Cons.blueFont
                      :Cons.greyFont1 ,),
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
    print('mmmm'+ _messageController.messagesList.length.toString());
    return GetBuilder<MessageController>(
      builder: (_)=>_messageController.isLoading==true?
          Center(child: CircularProgressIndicator(),):
      _messageController.newList.isEmpty?
          Center(child: Text('empty_data'.tr)):
      ListView.builder(
        itemCount: _messageController.newList.length,
          itemBuilder: (_,index){
          return  MessageItemWidget(index,_messageController.newList[index]);
          }

      ),

    );
  }



  void fetchMessages()async {
 await  _messageController.changeLoadingMessage(true);
    await _messageController.fetchMessages().then(
      _messageController.isLoading=false
    );
  }


void _modalBottomSheetMenu(BuildContext context){
  showModalBottomSheet(
      context: context,
      builder: (builder){
        return new Container(
          height: height * 0.3,
          color: Colors.red,
          //could change this to Color(0xFF737373),
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
                            showConfirmDeleteMessageDialog(context);
                          },child: Text('delete'.tr,style: Cons.whiteFont,),),
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
                            _messageController.changeCheckedMessageAll(false);
                            _messageController.changeVisibleCheckBox(false);
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
                            height: 50,child: Center(child: Text('select_all'.tr,style: Cons.blueFont,))),
                      ),
                      // SizedBox(width: 10,),
                      FlatButton(
                        onPressed: (){
                          _messageController.changeCheckedMessageAll(false);
                          _messageController.changeVisibleCheckBox(false);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            width: width *0.4,
                            height: 50,child: Center(child: Text('cancel_all'.tr,style: Cons.blueFont,))),
                      )
                    ],
                  )
                ],
              )),
        );
      }
  );
}



void showConfirmDeleteMessageDialog(BuildContext context){
  showDialog(
      context: context, builder: (_){
    return Center(
      child: Container(
        width: width *0.9,
        height: height *0.4,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: Center(child: Text('Delete 2 Messages',style: Cons.accentFont,)),
          content: Center(child: Text('are you sure delete this messages ?')),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: width *0.3,
                  child: RaisedButton(
                    color: Cons.accent_color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: (){
                      deleteSelectedMessages(context);
                    },child: Text('delete'.tr,style: Cons.whiteFont,),),
                ),
                Container(
                  width: width *0.3,
                  child: RaisedButton(
                    color: Cons.accent_color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: (){
                      Navigator.of(context).pop();
                      _messageController.changeVisibleCheckBox(false);
                      _messageController.changeCheckedMessageAll(false);
                    },child: Text('cancel'.tr,style: Cons.whiteFont,),
                  ),
                ),
              ],
            )



          ],
        ),
      ),
    );
  });
}


void deleteSelectedMessages(BuildContext context) async{
  List<MessageModel> list= _messageController.newList.where((element) => element.isSelected==true).toList();
  print(list.length.toString());
  await _messageController.deleteSelectedMessages(list);
  await _messageController.fetchMessages();
  Navigator.of(context).pop();
}



}
