import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saaty_app/model/http_exception.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:saaty_app/model/user_model.dart';
import 'package:saaty_app/providers/storage_controller.dart';

class AuthController extends GetxController {
  static UserModel model;
  bool visitorFlag = false;
  bool visiblePassword = true;
  bool isLoading = true;

  changeIsLoading(bool newVal) {
    isLoading = newVal;
    update();
  }

  changeVisitorFlag(bool val) {
    visitorFlag = val;
    update();
  }

  Future registerUser(Map<String, String> regMap) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB7ObVnKxOeS5ohxXCz952NwCXNmWUgPc0';
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
       String token = res['idToken'];
        print(userId);

        await StorageController.setString(StorageController.apiToken, token);
        await StorageController.setString(StorageController.userId, userId);
        DateTime expire =
        DateTime.now().add(Duration(seconds: int.parse(res['expiresIn'])));
        String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(expire);
        DateTime expireRes = DateTime.parse(formattedDate);

        await StorageController.setString(
            StorageController.expireDate, formattedDate);
        Map<String, dynamic> data = {'localId': userId, 'idToken': token};
        await StorageController.setString(
            StorageController.loginDataKey, jsonEncode(data));

        await StorageController.setString(
            StorageController.type, 'user');

        String url =
            'https://saaty-9ba9f-default-rtdb.firebaseio.com/users.json?auth=${StorageController
            .getString(StorageController.apiToken)}';
        regMap['localId'] = userId;
        var y = await http.post(Uri.parse(url), body: json.encode(regMap));
        if (y.statusCode == 200) {
          print('step2');

          //   model=json.decode(y.body);

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
      dynamic response_data = json.decode(x.body);
      if (response_data['error'] != null) {
        throw HttpError(response_data['error']['message']);
      }
    //
    } catch (err) {

      // print('xxxxx  '+err);
      // throw err;
    }
  }

  Future loginUser(Map<String, String> loginMap) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyB7ObVnKxOeS5ohxXCz952NwCXNmWUgPc0';
    Map<String, dynamic> map = {
      'email': loginMap['email'],
      'password': loginMap['password'],
      'returnSecureToken': true
    };
    try {
      var x = await http.post(Uri.parse(url), body: json.encode(map));

      if (x.statusCode == 200) {
        print('step1');
        var y = json.decode(x.body);
      String  userId = y['localId'];
      String  token = y['idToken'];
        await StorageController.setString(StorageController.apiToken, token);
        await StorageController.setString(StorageController.userId, userId);
        print('mmmmmmm   ' + y['expiresIn'] + 'llll ' + y['refreshToken']);
        print('user id idd $userId');
        DateTime expire =
        DateTime.now().add(Duration(seconds: int.parse(y['expiresIn'])));
        String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(expire);
        DateTime expireRes = DateTime.parse(formattedDate);
        await StorageController.setString(
            StorageController.type, 'user');

        await StorageController.setString(
            StorageController.expireDate, formattedDate);
        //.toIso8601String()
        Map<String, dynamic> data = {'localId': userId, 'idToken': token};
        await StorageController.setString(
            StorageController.loginDataKey, jsonEncode(data));
      } else {
        print('step2');
      }
      update();
      dynamic response_data = json.decode(x.body);
      if (response_data['error'] != null) {
        throw HttpError(response_data['error']['message']);
      }
    } catch (err) {
      print('step3');
      throw err;
    }
  }

  updateUserData(Map<String, String> map) async {
    String id=jsonDecode(StorageController.getString(StorageController.loginUserModel))['id'];
    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/users/$id.json?auth=${StorageController.getString(StorageController.apiToken)}';
    String url1 =
        'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyB7ObVnKxOeS5ohxXCz952NwCXNmWUgPc0';

    Map<String, dynamic> map_new = {
      'email': map['email'],
      'idToken': StorageController.getString(StorageController.apiToken),
      'returnSecureToken': true
    };
    try {
      var response2 =
      await http.post(Uri.parse(url1), body: json.encode(map_new));
      print('ssssssss  ' + response2.body.toString());
      if (response2.statusCode == 200) {
        var response = await http.patch(Uri.parse(url), body: json.encode(map));
        getUserDate();
      } else {
        Fluttertoast.showToast(
            msg: 'Token is expired Please login again',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } catch (err) {}
  }

  getUserDate() async {
    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/users.json?auth=${StorageController
        .getString(StorageController.apiToken)}';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var res = json.decode(response.body) as Map<String, dynamic>;
        res.forEach((key, value) async {
          if (value['localId'] == StorageController.getString(StorageController.userId)) {
            model = UserModel.fromJson(value, key);
            print('step2');
            print(model.toString());
            Map<String, dynamic> data = toMap(model, key);

            await StorageController.setString(
                StorageController.loginUserModel, jsonEncode(data));
            print('step1');
            //Map<String,dynamic> map= jsonDecode(StorageController.getString(StorageController.loginUserModel));

            // print(map['data'].name);
            // _storageController.setUserModelData(model);
          }
        });
      }

      update();
    } catch (err) {
      print(err);
    }
  }

  changeVisiblePassword(bool val) {
    visiblePassword = val;
    update();
  }

  changePassword(Map<String, dynamic> map) async {
    String id=jsonDecode(StorageController.getString(StorageController.loginUserModel))['id'];
    print('new iii   '+id);
    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/users/$id'
        '.json?auth=${StorageController.getString(StorageController.apiToken)}';
    String url1 =
        'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyB7ObVnKxOeS5ohxXCz952NwCXNmWUgPc0';

    Map<String, dynamic> map_new = {
      'password': map['new'],
      'idToken': StorageController.getString(StorageController.apiToken),
      'returnSecureToken': true
    };
    Map<String, dynamic> map_new1 = {
      'password': map['new'],
      'confirm_password': map['confirm']
    };

    try {
      var response2 =
      await http.post(Uri.parse(url1), body: json.encode(map_new));
      print('ssssssss  ' + response2.body.toString());
      if (response2.statusCode == 200) {
        var response =
        await http.patch(Uri.parse(url), body: json.encode(map_new1));
        getUserDate();
      } else {
        Fluttertoast.showToast(
            msg: 'Token is expired Please login again',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } catch (err) {}
  }

  resetForgetPassword(Map<String, dynamic> map) async {
    String url1 =
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyB7ObVnKxOeS5ohxXCz952NwCXNmWUgPc0';
    Map<String, dynamic> map_new = {
      'email': map['email'],
      'requestType': 'PASSWORD_RESET'
    };

    try {
      var response2 =
      await http.post(Uri.parse(url1), body: json.encode(map_new));
      print('ssssssss  ' + response2.body.toString());
      if (response2.statusCode == 200) {
        print(response2.body.toString());
        getUserDate();
      } else {
        Fluttertoast.showToast(
            msg: 'Token is expired Please login again',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } catch (err) {
      Fluttertoast.showToast(
          msg: 'Token is expired Please login again',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);

    }
  }

  enterNewResetPassword(Map<String, dynamic> map) async {
    String url2 =
        'https://saaty-9ba9f.firebaseapp.com/__/auth/action?mode=resetPassword&oobCode=elUokGpI0Twg9sSHiHnMTP9sMc9BWBQAWwBSM78gbpkAAAF-Th-8_w&apiKey=AIzaSyB7ObVnKxOeS5ohxXCz952NwCXNmWUgPc0&lang=en';
    var response = await http.patch(Uri.parse(url2), body: json.encode(map));
    if (response.statusCode == 200) {
      print('sucesssssssssss');
    }
  }

  Map<String, dynamic> toMap(UserModel model,String key) {
    return {
      'name': model.name,
      'email': model.email,
      'type': model.type,
      'phone': model.mobile,
      'password': model.password,
      'confirm_password': model.confirm_password,
      'localId': model.userId,
      'id': key
    };
  }

}