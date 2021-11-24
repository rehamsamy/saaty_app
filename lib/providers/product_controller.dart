import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saaty_app/model/product_model.dart';
import 'dart:convert';

import 'package:saaty_app/providers/auth_controller.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class ProductController extends GetxController{
  List<dynamic> product_images=[];
  List<Product> allProducts=[];

  Future createProduct(Map<String,dynamic> map,List<dynamic> images)async{
    String url='https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=${AuthController.token}';
    try{
      map['id']=AuthController.userId;

      print('step1');
  var response=  await http.post(Uri.parse(url),body: json.encode(map));
  print(response.statusCode);
  if(response.statusCode==200){
    uploadImageRequest(images);
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
  try{
    for (int i=0;i<images.length;i++){
      var ref= FirebaseStorage.instance.ref().child('user_iamge').child(AuthController.userId).child(i.toString());
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

void fetchProducts()async{
    String token=AuthController.token;
 String url='https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json/auth=$token';
 try{
   var response=await http.get(Uri.parse(url));
   if(response.statusCode==200) {
     Map<String, dynamic> result = json.decode(response.body);
     Product product;
     result.
     forEach((key, value){
       product=Product.fromJson(value);
         allProducts.add(value);
       }
     );
     }

 }catch(err){
  print(err);
 }
    update();
}


}
