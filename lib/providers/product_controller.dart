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
import 'dart:async';
import 'dart:io';

import 'package:saaty_app/providers/products_controller.dart';

class ProductController extends GetxController {
  List<String> vv = [];
  List<Product> allProducts = [];
  List<Product> _favProducts = [];
  List<Product> adsProducts = [];
  List<Product> watchProducts = [];
  List<Product> bracletesProducts = [];
  List<Product> searchList = [];
  int isFavorite=0;
  String favKey;

  List<String> imagesResult = [];
  int selectedTabIndex = 0;

  String token = AuthController.token;
  String userId = AuthController.userId;

  List<Product> get favProducts {
    return _favProducts;
  }

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


  changeFavoriteFlag(int fav){
    isFavorite=fav;
    update();
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


  Future<String> getImageUrl(String userId) async {
    var ref = FirebaseStorage.instance
        .ref()
        .child('user_iamge')
        .child(userId)
        .child(0.toString());
    return await ref.getDownloadURL();
  }


  Future fetchFavorite() async {
    allProducts.clear();
    _favProducts.clear();
    List<Product> newList=[];
    String token = AuthController.token;
  String  url = 'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites.json?auth=$token';
    try {
      var response = await http.get(Uri.parse(url));
      print('step0');
      if (response.statusCode == 200) {
        Map<String, dynamic> result =
        json.decode(response.body) as Map<String, dynamic>;
        result.forEach((key, value) async {
          if (key == AuthController.userId) {
            value.forEach((key, val1) async {
             favKey=key;

              Product product = Product.fromJson(val1['id'], val1);
              newList.add(product);
            // _favProducts.add(product);
             print('key   => '+_favProducts.length.toString());
              print('fav  vvvv ${val1['id']}');
            });
          }
        });
        _favProducts.clear();
        _favProducts=newList;
        update();
      }
      }catch(err){

    }

  }


  Future<int> fetchFavByProdId(String id) async{
    String  url = 'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${AuthController.userId}/$favKey.json?auth=$token';
    try {
      var response = await http.get(Uri.parse(url));
    }catch(err){

    }

  }


  Future toggleFav(String id, Map<String, dynamic> map) async {
    String token = AuthController.token;
    print(AuthController.userId);
   // print('favvvvvvvv  '+favProducts.length.toString());
    print(id);
    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${AuthController.userId}.json?auth=$token';
    ;
    String url1 =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${AuthController.userId}/$favKey.json?auth=$token';
    int flag = 0;
    var response;
    int index = allProducts.indexWhere((element) => element.id == id);
    // map['id']=index;
    if (favProducts.length > 0) {
      favProducts.forEach((element) {
        if(element.id==id){
          print('ele  '+element.id);
          flag=1;
        }else{
          flag=0;
        }
      });
      print('flagggg   '+flag.toString());
     }
    if (flag == 0) {
      print('yesss');
      response = await http.post(Uri.parse(url), body: json.encode(map));
    } else if(flag==1) {
      print('noooooo');
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
    // allProducts[index] = Product.fromJson(id, map) as Product;
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
