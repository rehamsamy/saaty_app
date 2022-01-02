import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saaty_app/model/http_exception.dart';
import 'dart:convert';

import 'package:saaty_app/model/user_model.dart';

class AuthController extends GetxController{
static String userId;
 static String token;
 static UserModel model;
  Future registerUser(Map<String,String> regMap)async {
    String url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB7ObVnKxOeS5ohxXCz952NwCXNmWUgPc0';
    Map<String, Object> map = {
      'email': regMap['email'],
      'password': regMap['password'],
      'returnSecureToken': true
    };
    try {
      var x = await http.post(Uri.parse(url), body: json.encode(map));
      if (x.statusCode == 200) {
        print('step1');
        var res = json.decode(x.body);
        String userId = res['localId'];
         token = res['idToken'];
         print(token);

        // UserModel model = UserModel(
        //     regMap['name'], regMap['email'], regMap['mobile'],
        //     regMap['password'], regMap['confirm_password'], userId);

        String url = 'https://saaty-9ba9f-default-rtdb.firebaseio.com/users.json?auth=$token';

        var y = await http.post(Uri.parse(url), body: json.encode(regMap));
        if (y.statusCode == 200) {
          print('step2');
           model=json.decode(y.body);
          print(y.statusCode);
          print(y.body);
        } else {
          print('step4');
          print(y.statusCode);
        }
        update();
      } else {
        print('step3');
      }

      throw HttpError(json.decode(x.body)['error']['message']);
    }
    catch (err) {
      throw err;
    }
  }


  Future loginUser(Map<String,String> loginMap) async{
    String url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyB7ObVnKxOeS5ohxXCz952NwCXNmWUgPc0';
    Map<String,dynamic> map={
    'email': loginMap['email'],
    'password': loginMap['password'],
    'returnSecureToken': true };
    try{
      var x= await http.post(Uri.parse(url),body:json.encode(map));
      print(x.body);
      if(x.statusCode==200){
          print('step1');
          var y=json.decode(x.body);
          userId=y['localId'];
          token = y['idToken'];
          print('user id idd $userId');
      }else{
        print('step2');
      }
      update();
     var response_data=json.decode(x.body);
      if(response_data['error'] !=null){
        throw HttpError(response_data['error']['message']);
      }
    }catch(err){
      print('step3');
      throw err;
    }
  }
}