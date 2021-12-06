import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saaty_app/cons.dart';
import 'package:saaty_app/model/product_model.dart';
import 'dart:convert';

import 'package:saaty_app/providers/auth_controller.dart';
import 'package:flutter/services.dart' show rootBundle;
// import "package:path_provider/path_provider.dart";

import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class ProductController extends GetxController {
  List<String> vv = [];
  List<Product> allProducts = [];
  List<Product> favProducts = [];
  List<Product> adsProducts = [];
  List<Product> watchProducts = [];
  List<Product> bracletesProducts = [];
  List<Product> searchList = [];

  List<String> imagesResult = [];
  int selectedTabIndex = 0;

  String token = AuthController.token;
  String userId = AuthController.userId;

  Future createProduct(Map<String, dynamic> map, List<dynamic> images) async {
    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=${AuthController.token}';
    try {
      map['id'] = AuthController.userId;
      print('step1');
      var response = await http.post(Uri.parse(url), body: json.encode(map));
      Map<String, dynamic> result =
          json.decode(response.body) as Map<String, dynamic>;
      String idd;
      result.forEach((key, value) {
        idd = value;
      });
      if (response.statusCode == 200) {
        imagesResult = await uploadFile(images, idd);
        print('**************   ${imagesResult.length}');
        setImagesToProduct(imagesResult, idd, map);
        print('yes');
      } else {
        print('no');
        print(response.body.toString());
      }
      update();
    } catch (err) {
      print(err);
    }
  }

  Future editProduct(String id, Map<String, Object> map) async {
    print('step 1');
    int index = adsProducts.indexWhere((element) => id == element.id);

    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/products/$id.json?auth=${AuthController.token}';
    try {
      var response = await http.patch(Uri.parse(url), body: json.encode(map));
      print(response.statusCode);
      print('step 2');
      allProducts[index] = Product.fromJson(id, map) as Product;
      print(response.body);
      update();
    } catch (err) {
      print('step 3');
      print(err);
    }
  }

  Future fetchProducts(String flag) async {
    allProducts.clear();
    favProducts.clear();
    String token = AuthController.token;
    String url;
    print(token);
    if (flag == 'fav') {
      url =
          'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites.json?auth=$token';
    } else if (flag == 'all' || flag == 'ads') {
      url =
          'https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=$token';
    }
    try {
      var response = await http.get(Uri.parse(url));
      print('step0');
      if (response.statusCode == 200) {
        print('step1');
        Map<String, dynamic> result =
            json.decode(response.body) as Map<String, dynamic>;
        print(result);
        if (flag == 'all') {
          result.forEach((key, value) async {
            String prodId = value['id'];
            List<String> imgs;
            Product product = Product.fromJson(key, value);
            allProducts.add(product);
          });
        } else if (flag == 'ads') {
          adsProducts.clear();
          result.forEach((key, value) async {
            if (value['id'] == AuthController.userId) {
              List<String> imgs;
              String prodId = value['id'];
              Product product = Product.fromJson(key, value);
              adsProducts.add(product);
              print('!!!!!!!!!!!   ${adsProducts.length}');
              print(adsProducts);
            }
          });
        } else if (flag == 'fav') {
          result.forEach((key, value) async {
            if (key == AuthController.userId) {
              value.forEach((key, val1) async {
                Product product = Product.fromJson(key, val1);
                allProducts.add(product);
                favProducts.add(product);
                print('fav  vvvv  => ${favProducts[0].id}');
              });
            }
          });
        }
      }
      print('ddd ${allProducts.length} ');
    } catch (err) {
      print(err);
    }
    update();
  }

  changeSelectedTab(int index) {
    selectedTabIndex = index;
    update();
  }

  orderProducts(int selectedTabIndex) {
    this.selectedTabIndex = selectedTabIndex;
    watchProducts.clear();
    bracletesProducts.clear();
    print('ddd ${allProducts.length}  $selectedTabIndex');
    allProducts.forEach((element) {
      if (element.cat == 0 && selectedTabIndex == 0) {
        watchProducts.add(element);
        print(element.name);
      } else if (element.cat == 1 && selectedTabIndex == 1) {
        bracletesProducts.add(element);
      }
    });
    update();
  }

  List<Product> getWatchProductsList() {
    watchProducts = allProducts.where((element) => element.cat == 0).toList();
  }

  Future<String> getImageUrl(String userId) async {
    var ref = FirebaseStorage.instance
        .ref()
        .child('user_iamge')
        .child(userId)
        .child(0.toString());
    return await ref.getDownloadURL();
  }

  Future toggleFav(String id, Map<String, dynamic> map) async {
    String token = AuthController.token;
    print(AuthController.userId);
    print(id);
    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${AuthController.userId}.json?auth=$token';
    ;
    String url1 =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${AuthController.userId}/$id.json?auth=$token';
    int flag = 0;
    var response;
    int index = allProducts.indexWhere((element) => element.id == id);
    // map['id']=index;
    if (favProducts.length != 0) {
      favProducts.firstWhere((element) => (element.id == id)) == null
          ? flag = 0
          : flag = 1;
    }

    print('flagggggg  = $flag');

    if (flag == 0) {
      response = await http.post(Uri.parse(url), body: json.encode(map));
    } else {
      response = await http.patch(Uri.parse(url1), body: json.encode(map));
    }

    print(response.statusCode);
    try {
      if (response.statusCode == 200) {
        print('yesss');
      } else {
        print('noooooo');
      }
    } on Exception catch (e) {
      print(e);
    }
    allProducts[index] = Product.fromJson(id, map) as Product;
    update();
  }

  Future<List<String>> uploadFile(List<dynamic> images, String id) async {
    print('uploadddd');
    List<String> imagesUrls = [];
    try {
      imagesUrls =
          await Future.wait(images.map((_image) => uploadFileNew(_image, id)));
      print(imagesUrls);
      print('#############   ${imagesUrls.length}');
      return imagesUrls;
    } catch (err) {
      print(err);
    }
  }

  Future<String> uploadFileNew(var _image, String id) async {
    List<String> newImg = [];
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('posts/$id/${basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(File(_image.path));
    await uploadTask.onComplete;

    // newImg.add(await storageReference.getDownloadURL());
    //  print('#############   ${newImg.length}');
    return await storageReference.getDownloadURL();
    ;
  }

  Future setImagesToProduct(
      List<String> imageString, String id, Map<String, dynamic> map) async {
    String url1 =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/products/$id.json?auth=${AuthController.token}';

    map['images'] = imageString;
    print(map['images'][0]);
    var response = await http.patch(Uri.parse(url1), body: json.encode(map));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('fpppppppppppp');
      print(response.body);
    } else {
      print('npppppppp');
    }
  }

  void search(String text) {
    searchList.clear();
    if (text.isEmpty) {
      return;
    }

    if (selectedTabIndex == 0) {
      print('watch $text');
      searchList = watchProducts
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    } else if (selectedTabIndex == 1) {
      searchList = bracletesProducts
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    update();
  }
}
