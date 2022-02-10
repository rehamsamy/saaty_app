
import 'dart:convert';
import 'package:get/get.dart';
import 'package:saaty_app/model/message_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:http/http.dart' as http;

class MessageController  extends GetxController{
  bool checkedAllMessage =false;
  bool  checkSingleMess=false;
  int selectedTabIndex=0;
  List<MessageModel> _messagesList=[];
  bool visibleChechBox=false;

  bool isLoading=true;
  List<bool> isChecked = List.generate(10, (index) => false);
 // List<String> ids=List.generate(10, (index) => null);

  changeCheckedMessage(bool val){
    isChecked.where((check) => check == val).length;
    update();
  }


  changeVisibleCheckBox(bool val){
    visibleChechBox=val;
    update();
  }
  changeLoadingMessage(bool val) {
    isLoading=val;
    update();
  }

  changeSelectedTabIndex(int val){
    selectedTabIndex=val;
    getFinalMessagesList();
  }

  get messagesList{
    return _messagesList;
  }

  get sendMessages{
    return _messagesList.where((element) => element.to==AuthController.userId).toList();
  }

  get receivedMessage{
  return  _messagesList.where((element) => element.from==AuthController.userId).toList();
  }


  changeCheckedMessageAll(bool val){
    checkedAllMessage=val;
    update();
  }

  List<MessageModel> list=[];

  createNewMessage(Map<String,dynamic> map)async{
    print('3330'+map.toString());
    String  url = 'https://saaty-9ba9f-default-rtdb.firebaseio.com/messages.json?auth=${AuthController.token}';
    try{
      print(map['date']);
      map['date']=DateTime.now().toString();
      var response=await http.post(Uri.parse(url),body: json.encode(map));
      print(response.body.toString());
    }catch(err){
      print(err);
    }

  }



  fetchMessages()async{
    _messagesList.clear();
    messagesList.clear();
    print(selectedTabIndex.toString()+ 'll ');
    String  url = 'https://saaty-9ba9f-default-rtdb.firebaseio.com/messages.json?auth=${AuthController.token}';
    try{
      var response=await http.get(Uri.parse(url));
    var res=json.decode(response.body) as Map<String,dynamic>;
    res.forEach((key, value) {
      MessageModel model=   MessageModel.fromJson(value,key);
      _messagesList.add(model);
    });
    print('lengtg '+_messagesList.length.toString());
   getFinalMessagesList();
    }catch(err){
      print(err);
    }

  }
List<MessageModel> newList=[];
  void getFinalMessagesList(){
    newList.clear();
    if(selectedTabIndex==1){
      newList= sendMessages;
    }else{
      newList=receivedMessage;
    }
    update();
  }

  deleteSelectedMessages(List<MessageModel> list)async {
    List<String> ids = [];
    list.forEach((element) {
      ids.add(element.id);
    });
    for (int i = 0; i < ids.length; i++) {
      String url = 'https://saaty-9ba9f-default-rtdb.firebaseio.com/messages/${ids[i]}.json?auth=${AuthController
          .token}';
      try {
        var response = await http.delete(Uri.parse(url));
        print(response.statusCode);
      }
      catch (err) {
        print(err);
      }
    }
  }

  deleteSingleMessage(String id)async{
    String url = 'https://saaty-9ba9f-default-rtdb.firebaseio.com/messages/$id.json?auth=${AuthController
        .token}';
    try {
      var response = await http.delete(Uri.parse(url));
      print(response.statusCode);
    }
    catch (err) {
      print(err);
    }
  }

}