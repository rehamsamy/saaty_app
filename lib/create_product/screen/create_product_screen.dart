import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:saaty_app/create_product/widget/category_name_create_product.dart';
import 'package:saaty_app/create_product/widget/connection_type_create_product.dart';
import 'package:saaty_app/create_product/widget/product_type_create_product.dart';
import 'package:saaty_app/create_product/widget/text_form_create_product.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
// import 'package:image_picker_flutter/image_picker_flutter.dart';
import 'package:image_picker/image_picker.dart' ;
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/main_page/screen/main_page_screen.dart';
import 'dart:io';

import '../../cons.dart';
import 'package:path_provider/path_provider.dart';


class CreateProductScreen extends StatefulWidget {
 static String CREATE_PRODUCT_ROUTE = '/4';
  @override
  State<StatefulWidget> createState() {
    print('bbbbbbbbbb  '+jsonDecode(
        StorageController.getString(StorageController.loginUserModel))['name']);
    return CreateProductScreenState();

  }
}

class CreateProductScreenState extends State<CreateProductScreen>{
  var controller=Get.put(ProductController());
  var _nameController,_priceController,_phoneController,
      _emailController,_descController;

  Map<String,dynamic> map={
    'name':'',
    'email':'',
    'price':'',
    'desc':'',
    'phone':'',
    'email':'',
    'creator_name':'',
    'images':[]
  };


  var catId, statusId,connType;

  bool _isLoading=false;
  List<dynamic> images = [];
  List<dynamic> prodImages=[];
  int _radValCat=0;
  int _radValType=0;
  int _radValContact=0;
  Product product;
  var _key=GlobalKey<FormState>();
  var _style=TextStyle(
    color: Colors.black,
    fontSize: 15,
  );


  @override
  Widget build(BuildContext context) {
     product =ModalRoute.of(context).settings.arguments as Product;
     print(MediaQuery.of(context).size.width);
    if(product !=null){
      inialializeValuesFromProduct(product);
      print(';;;;;;;;;;;;;;;;;;;;;;;;   ${product.id}');
    }
    Cons.buildColors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('create_product'.tr,style:  Cons.greyFont,),
      ),
      body:
      Form(
        key: _key,
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              CategoryName(),
              ProductType(),
              SizedBox(height: 15,),
               Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('prod_name'.tr,style: Cons.blackFont,),
                   TextFormProductData('name', 'prod_name'.tr, Icons.info_sharp, TextInputType.text,map),
                 ],
               ),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('prod_price'.tr,style: Cons.blackFont,),
                  Row(
                    children: [
                      Flexible(child: TextFormProductData('price','prod_price'.tr,
                          Icons.monetization_on_rounded, TextInputType.number,map)),
                      Text('EGYPT',style: Cons.greenFont,)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('phone_conn'.tr,style: Cons.blackFont,),
                  TextFormProductData('phone', 'phone_conn'.tr, Icons.phone_android_sharp,  TextInputType.number,map),
                ],
              ),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('email_conn'.tr,style: Cons.blackFont,),
                  TextFormProductData('email', 'email_conn'.tr, Icons.email,  TextInputType.emailAddress,map),
                ],
              ),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('conn_type'.tr,style: Cons.blackFont,),
                  ConnectionType(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Divider(color: Cons.accent_color,thickness: 1.5,),
              ),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('prod_desc'.tr,style: Cons.blackFont,),
                  TextFormProductData('desc', 'Enter Description', Icons.comment, TextInputType.text,map),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Visibility(
                  visible: product==null?true:false,
                  child: ListTile(
                    leading: Text('attatch_prod_images'.tr,style: Cons.blackFont,),
                    onTap:
                        (){
                      buildMultiImagePicker(1);
                      print('cccccc');
                    },
                    trailing: CircleAvatar(child: Icon(Icons.attach_file,color: Colors.white,),backgroundColor: Cons.accent_color,)
                  ),
                )
                 ,
                  SizedBox(
                    height: 120,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Cons.primary_color)
                      ),
                      child: buildGridImagePicker(),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onPressed: (){
                    saveProductData();
                  },child:
                  Text('save'.tr,style: Cons.whiteFont,),
                color: Cons.accent_color,),
              )

            ],
          ),
        ),
      ),
      )
    );
  }


  Widget buildGridImagePicker(){
    return
      GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      childAspectRatio: 1/0.8,
      children: List.generate(
          prodImages.length==0?images.length:
          prodImages.length, (index) {
      //  AssetData asset = images[index];
        return Container(
          width: 2,
          height: 2,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Cons.accent_color),
            borderRadius: BorderRadius.circular(15)
          ),
          child:prodImages.length==0?Image.file(File(images[index].path),
            fit: BoxFit.contain,):Image.network(prodImages[index])

        );
      }),
    );
  }

 Future buildMultiImagePicker(var src) async{
    images.clear();
   var x=await ImagePicker.platform.getMultiImage(maxWidth: 100,
       maxHeight:100,);
       print(x.length);

   if (x.isNotEmpty) {
     setState(() {
       images.addAll(x);
     });

   }


  }


   saveProductData() async{
     List<dynamic> newImages=[];
    if(_key.currentState.validate()&& (images.length>0||prodImages.length>0)){
      print('////////////////');
      _key.currentState.save();
      map['id']=StorageController.getString(StorageController.userId);
      map['isFav']=0;
      map['cat']=_radValCat;
      map['status']=_radValType;
      map['connType']=_radValContact;
      map['creator_name']=jsonDecode(
          StorageController.getString(StorageController.loginUserModel))['name'];

      print('xx  $_radValCat cc    $_radValType vv    $_radValCat  ${map['price']}'   );
      try{
        if(prodImages.length==0){
          print('nnnnnnnnnnnnnn');
          for (int i=0;i<images.length;i++){
            // file = File(images[i].path);
            newImages.add(images[i].path);

          }
          map['images']=newImages;
          map['id']=StorageController.getString(StorageController.userId);
          map['creator_id']=
              StorageController.getString(StorageController.apiToken);

          await controller.createProduct(map,images)
              .then((value) {
            Fluttertoast.showToast(
                msg: "product uploaded suseccfully",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE);
            setState(() {
              _isLoading=false;
            });
          }).catchError(()=>buildLoading(context));

        }else if(prodImages.length >0){
          print('mmmmmm');
          map['images']=prodImages;

          await controller.editProduct(product.id,map).catchError(()=>buildLoading(context))
              .then((value) {
            Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE);
            setState(() {
              _isLoading=false;
            });
          });

        }


      }
      catch (err){
        print('err       '+err.toString());
     buildLoading(context);
      }

    }else if(images.length==0){
      print( 'please select at least one image');
      Fluttertoast.showToast(
          msg: "please select at least one image",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
      );
    }

   }

  void buildLoading(BuildContext ctx) {
    showDialog(context: ctx, builder: (ctx)=>
        AlertDialog(
          content: Text('errror occured'),
          title: Text('error'),
          actions: [
            FlatButton(onPressed: (){
              Navigator.of(ctx).pop();
              Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE);
            }, child: Text('Ok'))
          ],
        )

    );

  }

  Future<List<String> >uploadImagesToFirebase(List images) async{
    List<String> vv=[];
    print('step0');

    print('step1');
    try{
      for (int i=0;i<3;i++){
       var ref= FirebaseStorage.instance.ref().child('user_image').
       child(StorageController.getString(StorageController.userId)).child(i.toString());
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


  return vv;
  }

  void inialializeValuesFromProduct(Product product) {
     _nameController=  TextEditingController(text:product.name);
     _priceController= TextEditingController(text:product.price);
     _phoneController= TextEditingController(text:product.phone);
     _emailController= TextEditingController(text:product.email);
     _descController=  TextEditingController(text:product.desc);
     setState(() {
       _radValCat=product.cat;
       _radValType=product.status;
       _radValContact=product.connType;
       prodImages=product.images;
     });

     print('**************');
     print(prodImages.length);
     print('  $_radValCat    $_radValType    $_radValContact');
  }





}

