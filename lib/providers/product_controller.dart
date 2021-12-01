import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
List<Product> favProducts=[];

  List<String> imagesResult=[];

  String token=AuthController.token;
  String userId=AuthController.userId;


  Future createProduct(Map<String,dynamic> map,List<dynamic> images)async{
    String url='https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=${AuthController.token}';
    try{
      map['id']=AuthController.userId;
      print('step1');
  var response=  await http.post(Uri.parse(url),body: json.encode(map));
  Map<String, dynamic> result = json.decode(response.body) as Map<String,dynamic>;
 String idd;
 result.forEach((key, value) { idd=value;});

  if(response.statusCode==200){
    imagesResult=await uploadFile(images, idd);
    print( '**************   ${imagesResult.length}');
  //  setImagesToProduct(imagesResult,idd, map);
   // uploadImagesToFirebase(images, idd);

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




  Future fetchProducts(int flag)async{
    allProducts.clear();
    String token=AuthController.token;
    String url;
    print(token);
    if (flag==1){
    url='https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=$token';
    }else if(flag==2){
      url='https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites.json?auth=$token';
    }

    try{
      var response=await http.get(Uri.parse(url));
      print('step0');
      if(response.statusCode==200) {
        print('step1');
        Map<String, dynamic> result = json.decode(response.body) as Map<String,dynamic>;
        print(result);
        if(flag==1) {
          result.
          forEach((key, value) async {
           String prodId= value['id'];
           List<String> imgs;
            Product product = Product.fromJson(key, value);
            allProducts.add(product);
          }
          );
        }else if(flag==2){
          result.
          forEach((key, value) async {
            if(key==AuthController.userId){
              value.forEach((key,val1)async {
                Product product = Product.fromJson(key, val1);
                allProducts.add(product);
                favProducts.add(product);
                print('fav  vvvv  => ${favProducts[0].id}');
              });
            }

          }
          );
        }
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
    print(AuthController.userId);
    print(id);
    String url='https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${AuthController.userId}.json?auth=$token';;
    String url1='https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${AuthController.userId}/$id.json?auth=$token';
    int flag=0;
    var response;
    int index=allProducts.indexWhere((element) => element.id==id);
   // map['id']=index;
    if(favProducts.length !=0){
      favProducts.firstWhere((element) => (element.id==id)) == null?flag=0:flag=1;
    }

  print('flagggggg  = $flag');

    if(flag==0){
       response=await http.post(Uri.parse(url),body:json.encode(map));
    }else{
       response=await http.patch(Uri.parse(url1),body:json.encode(map));
    }

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



  Future<List<String> >uploadImagesToFirebase(List images,String id) async{
    List<String> vv=[];
    print('idddddddd         eeeeeeee    $id');
    print('step1');

    var imageUrls = await Future.wait(images.map((_image) {
      //uploadFile(images, id);
    }
    ));
    print(imageUrls);
    return imageUrls;


  //   try{
  //     for (int i=0;i<images.length;i++){
  //       var ref= FirebaseStorage.instance.ref().child('user_image') .child(id).child(i.toString());
  //       print('step22 ');
  //       File file=File(images[i].path);
  //       await ref.putFile(file);
  //       String url = await ref.getDownloadURL();
  //       print('step21 $url ');
  //       vv.add(url);
  //       // String url = (await ref.getDownloadURL()).toString();
  //       print('step55 ');
  //       print(vv[0]);
  //
  //
  //     }
  //
  //     print('step3');
  //     //  print('${ref.path}   ${ref.getParent()} ');
  //     // product_images.addAll(await ref.child(AuthController.userId) as List<File>);
  //     //String url= await ref.child(AuthController.userId);
  //     //  print('uuuuu ${product_images[0].toString()}');
  //   }catch(err){
  //     print(err);
  //     print('step4');
  //   }
  //
  //
  //   return vv;
  }

  Future<List<String>> uploadFile(List<dynamic> images,String id) async {
    print('uploadddd');
    List<String>imagesUrls=[];

      images.forEach((_image) async {
      String imageName = basename(_image.path);
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('posts/$id/$imageName');
      try{
        StorageUploadTask uploadTask =   await storageReference.putFile(
            File(_image.path));
      }catch(err){
        print(err);
      }



      // if(uploadTask.isSuccessful){
      //   print('aaaaaaaaaaaaaaaaaaa');
      //   imagesUrls.add(await (await uploadTask.onComplete).ref.getDownloadURL());
      // }else{
      //   print('bbbbbbbbbb');
      // }

      //     onComplete.then((value)async {
      //       print('!!!!!!!!!!!!!!   ') ;
      //       String v=await  value.ref.getDownloadURL();
      //       print(v);
      // });


    //  imagesResult.add(await (await uploadTask.onComplete).ref.getDownloadURL());
    // await  uploadTask.onComplete;
    //   print('zzz       ${storageReference.getDownloadURL().toString()}');
    //   imagesUrls.add(await (await uploadTask.onComplete).ref.getDownloadURL());

      print (imagesUrls[0]);
    }
    );
    print('##########  ${imagesUrls.length}');
    return imagesUrls;
  }

  Future setImagesToProduct(List<String> imageString,String id,Map<String,dynamic> map)async{

    String url1='https://saaty-9ba9f-default-rtdb.firebaseio.com/products/$id.json?auth=${AuthController.token}';
    map['images']=imageString;
    var  response=await http.patch(Uri.parse(url1),body:json.encode(map));
    print(response.statusCode);
    if(response.statusCode==200){
      print('fpppppppppppp');
    }else{
      print('npppppppp');
    }
  }


}



