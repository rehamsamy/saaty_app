import 'package:get/get.dart';

class MessageController  extends GetxController{
  bool checkedAllMessage =false;
  bool  checkSingleMess=false;
  List<bool> isChecked = List.generate(10, (index) => false);

  changeCheckedMessage(bool val){
    isChecked.where((check) => check == val).length;
    update();
  }

  changeCheckedMessageAll(bool val){
    checkedAllMessage=val;
    update();
  }

}