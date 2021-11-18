import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saaty_app/model/http_exception.dart';
import 'dart:convert';

import 'package:saaty_app/providers/auth_controller.dart';
import 'package:flutter/services.dart' show rootBundle;
// import "package:path_provider/path_provider.dart";

import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class ProductController extends GetxController{

  Future createProduct(Map<String,dynamic> map,var name)async{
    String url='https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=${AuthController.token}';
    try{
      map['id']=AuthController.userId;
     // File file=map['images'][0];
      File file= await getImageFileFromAssets(name);
      print('xxx $file');
  var response=  await http.post(Uri.parse(url),body: json.encode(map));
  print(response.statusCode);
  if(response.statusCode==200){

    uploadImageRequest(file);
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

  void uploadImageRequest(File file) async {
    print('step0');
  var ref= FirebaseStorage.instance.ref().child('user_iamge').child(AuthController.userId);
  print('step1');
     await ref.putFile(file);
     print('step2');
String url= await ref.getDownloadURL();
print(url);


  }



  Future<File> getImageFileFromAssets(var path) async {
   // ByteData byteData = await rootBundle.load('assets/image/color.png');
    print('ffff $path');
    try{
      final file = File('${(await getTemporaryDirectory()).path}/$path');
      final byteData = await rootBundle.load('{$path.}');

      await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      print('vvvvv $path');
      return file;
    }catch(err){
      print(err);
    }

  }


}