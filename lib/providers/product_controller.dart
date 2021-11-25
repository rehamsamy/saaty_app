import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:saaty_app/model/http_exception.dart';
import 'package:saaty_app/model/product_model.dart';
import 'dart:convert';

import 'package:saaty_app/providers/auth_controller.dart';
import 'package:flutter/services.dart' show rootBundle;
// import "package:path_provider/path_provider.dart";

import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class ProductController extends GetxController{
  List<String> vv=[];
List<Product> allProducts=[];

  String token=AuthController.token;
  String userId=AuthController.userId;


  Future createProduct(Map<String,dynamic> map,List<dynamic> images)async{
    String url='https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=${AuthController.token}';
    try{
      map['id']=AuthController.userId;

      print('step1');
  var response=  await http.post(Uri.parse(url),body: json.encode(map));
  print(response.statusCode);
  if(response.statusCode==200){
   // uploadImageRequest(images);
print('yes');
  }else{
    print('no');
print(response.body.toString());
  }
update(); }
catch(err){
      print(err) ;
}
  }

  void uploadImageRequest(List<dynamic> images) async {
    List<String> vv=[];
    print('step0');
    print(AuthController.userId);

  print('step1');
var ref= FirebaseStorage.instance.ref();
  try{
    for (int i=0;i<images.length;i++){
       ref= ref.child('user_iamge').child(AuthController.userId).child(i.toString());
      print('step22 ');
      File file=File(images[i].path);
         await ref.putFile(file);
       String url = await ref.getDownloadURL();
       print('step21 $url ');
        vv.add(url);
      // String url = (await ref.getDownloadURL()).toString();
        print('step55 ');
      print(vv[0]);


    }

    print('step3');
  //  print('${ref.path}   ${ref.getParent()} ');
   // product_images.addAll(await ref.child(AuthController.userId) as List<File>);
    //String url= await ref.child(AuthController.userId);
  //  print('uuuuu ${product_images[0].toString()}');
  }catch(err){
    print(err);
    print('step4');
  }



  }


  Future fetchProducts()async{
    allProducts.clear();
    String token=AuthController.token;
    print(token);
    String url='https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=$token';
    try{
      var response=await http.get(Uri.parse(url));
      print('step0');
      if(response.statusCode==200) {
        print('step1');
        Map<String, dynamic> result = json.decode(response.body) as Map<String,dynamic>;
        print(result);
        result.
        forEach((key, value) async {
          Product product=Product.fromJson(key,value);
          allProducts.add(product);
        }
        );
      }
      print('ddd ${allProducts.length} ');
    }catch(err){
      print(err);
    }
    update();
  }

  Future<String> getImageUrl(String userId) async{
    var ref= FirebaseStorage.instance.ref().child('user_iamge').child(userId).child(0.toString());
    return await ref.getDownloadURL();

  }



  Future toggleFav(String id,Map<String,dynamic> map)async{
    String token=AuthController.token;
   // String url='https://shop-93ba9-default-rtdb.firebaseio.com/products/$id.json?auth=${AuthProvider.token}';
    print(id);
    int index=allProducts.indexWhere((element) => element.id==id);
    String url='https://saaty-9ba9f-default-rtdb.firebaseio.com/products/$id.json?auth=$token';
    var response=await http.patch(Uri.parse(url),body:json.encode(map));
    print(response.statusCode);
    try {
      if (response.statusCode==200){
          print('yesss');
      }else{
        print('noooooo');
      }
    } on Exception catch (e) {
      print(e);
    }
    allProducts[index]=Product.fromJson(id, map) as Product;
  update();
  }
}