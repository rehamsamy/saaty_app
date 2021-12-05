import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
// import 'package:image_picker_flutter/image_picker_flutter.dart';
import 'package:image_picker/image_picker.dart' ;
import 'package:saaty_app/view/screens/main_page_screen.dart';
import 'dart:io';

import '../../cons.dart';
import 'package:path_provider/path_provider.dart';


class CreateProductScreen extends StatefulWidget {
 static String CREATE_PRODUCT_ROUTE = '/4';
  @override
  State<StatefulWidget> createState() {
    return CreateProductScreenState();
  }
}

class CreateProductScreenState extends State<CreateProductScreen>{
  var controller=Get.put(ProductController());
  var _nameController,_priceController,_phoneController,
      _emailController,_descController;
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

  Map<String,dynamic> map={
    'name':'',
    'email':'',
    'price':'',
    'desc':'',
    'phone':'',
    'email':'',
    'images':[]
  };

  @override
  Widget build(BuildContext context) {
     product =ModalRoute.of(context).settings.arguments as Product;

    if(product !=null){
      inialializeValuesFromProduct(product);
      print(';;;;;;;;;;;;;;;;;;;;;;;;   ${product.id}');
    }
    Cons.buildColors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body:
      Form(
        key: _key,
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              buildCategoryName(),
              buildProductType(),
              SizedBox(height: 15,),
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Align(alignment:Alignment.topLeft,child: Text('Product name:',style: Cons.blackFont,)),
                      buildTextFormProductData('name', 'Enter Name', Icons.info_sharp, TextInputType.text),
                 ],
               ),
              SizedBox(height: 15,),
              Column(
                children: [
                  Align(alignment:Alignment.topLeft,child: Text('Product Price:',style: Cons.blackFont,)),
                  Row(
                    children: [
                      Flexible(child: buildTextFormProductData('price', 'Enter Price', Icons.monetization_on_rounded, TextInputType.number)),
                      Text('EGYPT',style: Cons.greenFont,)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Column(
                children: [
                  Align(alignment:Alignment.topLeft,child: Text('Owner Phone:',style: Cons.blackFont,)),
                  buildTextFormProductData('phone', 'Enter Phone Number', Icons.phone_android_sharp,  TextInputType.number),
                ],
              ),
              SizedBox(height: 15,),
              Column(
                children: [
                  Align(alignment:Alignment.topLeft,child: Text('Owner Email:',style: Cons.blackFont,)),
                  buildTextFormProductData('email', 'Enter Email', Icons.email,  TextInputType.emailAddress),
                ],
              ),
              SizedBox(height: 15,),
              Column(
                children: [
                  Align(alignment:Alignment.topLeft,child: Text('Connection Method:',style: Cons.blackFont,)),
                 buildConnectionTypeRadio(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Divider(color: Cons.accent_color,thickness: 1.5,),
              ),
              SizedBox(height: 15,),
              Column(
                children: [
                  Align(alignment:Alignment.topLeft,child: Text('Product Description:',style: Cons.blackFont,)),
                  buildTextFormProductData('desc', 'Enter Description', Icons.comment, TextInputType.text,),
                ],
              ),
              Column(
                children: [
                Visibility(
                  visible: product==null?true:false,
                  child: ListTile(
                    leading: Text('Attatch Product Images:',style: Cons.blackFont,),
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
                  Text('Save',style: Cons.whiteFont,),
                color: Cons.accent_color,),
              )

            ],
          ),
        ),
      ),
      )
    );
  }

 Widget buildCategoryName() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState)=>
       Row(
      // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Category:'),
          SizedBox(width: 30,),
          Radio(value: 0, groupValue: _radValCat, onChanged: (value){
            setState(() {
              print(value);
              _radValCat=value;
            });
          },
              hoverColor: Cons.primary_color,
              materialTapTargetSize: MaterialTapTargetSize.padded, activeColor:Cons.primary_color ,),
          Text('Watch'),
          Radio(value: 1, groupValue: _radValCat, onChanged: (value){
            setState(() {
              _radValCat=value;
            });
          },
          materialTapTargetSize: MaterialTapTargetSize.padded, activeColor:Cons.primary_color ,),
          Text('Braclet'),

        ],
      ),
    );
  }

  Widget buildTextFormProductData(String flag, String hint, IconData icon, TextInputType inputType){
    return TextFormField(
      controller: buildControllerValues(flag),
      textAlign: TextAlign.start,
      maxLines: flag=='desc'?5:1,
      decoration: InputDecoration(
          prefixIcon: flag=='desc'? Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
            child: Icon(icon, color: Cons.primary_color),
          )
              : Icon(icon, color: Cons.primary_color),
          hintText: hint,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Cons.primary_color,
              width: 1.0,
            ),
          )
        // hoverColor: Theme.of(context).primaryColor,focusColor: Colors.amber
      ),
      validator: (value) {
        if (value.isEmpty&&flag=='name') {
          return 'enter name';
        } if (value.isEmpty&&flag=='price') {
          return 'enter price';
        } if (value.isEmpty&&flag=='desc') {
          return 'enter description';
        } if (value.isEmpty&&flag=='phone') {
          return 'enter phone';
        } if (value.isEmpty&&flag=='name') {
          return 'enter name';
        } if (value.isEmpty&&flag=='email') {
          return 'enter email';
        }
        if (!value.contains('.com') && flag == 'email') {
          return 'enter valid email';
        }

      },
      onSaved: (value) {
        //loginMap['password'] = value!;
        if (flag == 'name') {
          map['name'] = value;
        }
        if (flag == 'price') {
          map['price'] = value;
        }
        if (flag == 'phone') {
          map['phone'] = value;
        }
        if (flag == 'email') {
          map['email'] = value;
        }
        if (flag == 'desc') {
          map['desc'] = value;
        }
      },
      keyboardType: inputType,
    );
  }

  Widget buildConnectionTypeRadio() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState)=>
       Column(
        children: [
          Row(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(value: 0, groupValue: _radValContact, onChanged: (value){
                setState(() {print('nnnnnnnnnnnn');}) ;
                setState(() {
                  _radValContact=value;
                });
              },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor:Cons.primary_color ,),
              Text('phone'),
             // SizedBox(width: 10,),
              Radio(value: 1, groupValue: _radValContact, onChanged: (value){
                setState(() {
                  _radValContact=value;
                });
              },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor:Cons.primary_color ,),
              Text('email'),
              //SizedBox(width: 10,),
              Radio(value: 2, groupValue: _radValContact, onChanged: (value){
                setState(() {
                  _radValContact=value;
                });
              },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor:Cons.primary_color ,),
              Text('meessage'),
             // SizedBox(width: 10,),
            ],
          ),
          Row(
            children: [
              Radio(value: 3, groupValue: _radValContact, onChanged: (value){
                setState(() {
                  _radValContact=value;
                });
              },
                  materialTapTargetSize: MaterialTapTargetSize.padded,
              activeColor:Cons.primary_color ,
              ),
              Text('All'),
            ],
          ),


        ],
      ),
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

 Widget buildProductType() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState)=>
     Row(
     // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Type:'),
        SizedBox(width: 30,),
        Radio(value: 0, groupValue: _radValType, onChanged: (value){
          setState(() {
            print('vvvvvvvvvvvvvvvv 1  $value');
            _radValType=value;
            print('vvvvvvvvvvvvvvvv 1 $_radValType');
          });
        },
            materialTapTargetSize: MaterialTapTargetSize.padded,
          activeColor:Cons.primary_color ,),
       Text('Old Products'),
        Radio(value: 1, groupValue: _radValType, onChanged: (value){
          setState(() {
            print(value);
            _radValType=value;
          });
        },
          materialTapTargetSize: MaterialTapTargetSize.padded,
          activeColor:Cons.primary_color ,),
        Text('New Products'),

      ],
    )
    );
  }

   saveProductData() async{


     List<dynamic> newImages=[];
    if(_key.currentState.validate()&& (images.length>0||prodImages.length>0)){
      print('////////////////');
      _key.currentState.save();



      map['id']=AuthController.userId;
      map['isFav']=0;
      map['cat']=_radValCat;
      map['status']=_radValType;
      map['connType']=_radValContact;
      print('xx  $_radValCat cc    $_radValType vv    $_radValCat');
      try{

        if(prodImages.length==0){
          print('nnnnnnnnnnnnnn');
          for (int i=0;i<images.length;i++){
            // file = File(images[i].path);
            newImages.add(images[i].path);

          }
          map['images']=newImages;
          map['id']=AuthController.userId;

          await controller.createProduct(map,images).catchError(()=>buildLoading(context))
              .then((value) {
            setState(() {
              _isLoading=false;
            });
          });

        }else if(prodImages.length >0){
          print('mmmmmm');
          map['images']=prodImages;

          await controller.editProduct(product.id,map).catchError(()=>buildLoading(context))
              .then((value) {
            setState(() {
              _isLoading=false;
            });
          });

        }


      }
      catch (err){
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
   }

  void buildLoading(BuildContext ctx) {
    showDialog(context: ctx, builder: (ctx)=>
        AlertDialog(
          content: Text('errror occured'),
          title: Text('error'),
          actions: [
            FlatButton(onPressed: (){
              Navigator.of(ctx).pop();
            }, child: Text('Ok'))
          ],
        )

    );

  }

  Future<List<String> >uploadImagesToFirebase(List images) async{
    List<String> vv=[];
    print('step0');
    print(AuthController.userId);

    print('step1');
    try{
      for (int i=0;i<3;i++){
       var ref= FirebaseStorage.instance.ref().child('user_image').
       child(AuthController.userId).child(i.toString());
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


  TextEditingController buildControllerValues(String flag){
    if(flag=='name'){
      return _nameController;
    }  if(flag=='price'){
      return _priceController;
    }  if(flag=='email'){
      return _emailController;
    }  if(flag=='desc'){
      return _descController;
    }  if(flag=='phone'){
      return _phoneController;
    } else
      {
        return null;
      }
  }



}

