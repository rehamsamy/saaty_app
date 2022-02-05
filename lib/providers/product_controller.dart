import 'dart:io';
import 'package:flutter/material.dart';
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
import 'dart:async';
import 'dart:io';

import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/view/screens/main_page_screen.dart';

class ProductController extends GetxController {
  IconData _icon = Icons.favorite_border;
  StorageController _storageController = Get.find();
  int fav = 0;

  List<String> vv = [];
  List<Product> allProducts = [];
  List<Product> _favProducts = [];
  List<Product> adsProducts = [];
  List<Product> watchProducts = [];
  List<Product> bracletesProducts = [];
  List<Product> searchList = [];
  int isFavorite = 0;
  String favKey;
  int sliderIndex = 0;
int isCart=0;
  List<String> imagesResult = [];
  int selectedTabIndex = 0;
  List<Product> get favProducts {
    return _favProducts;
  }

  changeFavoriteFlag(int fav) async {
    isFavorite = fav;
    update();
  }


  changeSliderImage(int index) async {
    sliderIndex = index;
    update();
  }

  Future createProduct(Map<String, dynamic> map, List<dynamic> images) async {
    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=${StorageController.getString(StorageController.apiToken)}';
    try {
      map['id'] = StorageController.getString(StorageController.userId);
      map['dateTime'] = DateTime.now().toString();

      var response = await http.post(Uri.parse(url), body: json.encode(map));
      if (response.statusCode == 200) {
        print('step1  ' + response.statusCode.toString());
        Map<String, dynamic> result =
            json.decode(response.body) as Map<String, dynamic>;
        String idd;
        result.forEach((key, value) {
          idd = value;
        });
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
    map['dateTime'] = DateTime.now().toString();
    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/products/$id.json?auth=${StorageController.getString(StorageController.apiToken)}';
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

  Future<String> getImageUrl(String userId) async {
    var ref = FirebaseStorage.instance
        .ref()
        .child('user_iamge')
        .child(userId)
        .child(0.toString());
    return await ref.getDownloadURL();
  }

  Future<int> fetchFavByProdId(String id) async {
    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${StorageController.getString(StorageController.userId)}/$favKey.json?auth=${StorageController.getString(StorageController.apiToken)}';
    try {
      var response = await http.get(Uri.parse(url));
    } catch (err) {}
  }

  Future toggleFav(String id, int isFav) async {
    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${StorageController.getString(StorageController.userId)}/$id.json?auth=${StorageController.getString(StorageController.apiToken)}';

    var response;

    try {
      response = await http.put(Uri.parse(url), body: json.encode(isFav));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('yesss');
      } else {
        print('noooooo');
      }
    } on Exception catch (e) {
      print(e);
    }
    changeFavoriteFlag(fav);
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
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/products/$id.json?auth=${StorageController.getString(StorageController.apiToken)}';

    print('tokev      ' + MainPageScreen.token.toString());
    map['images'] = imageString;
    var response = await http.patch(Uri.parse(url1), body: json.encode(map));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
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
