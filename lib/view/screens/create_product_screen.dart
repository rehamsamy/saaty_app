import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker_flutter/image_picker_flutter.dart';

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
  List<Asset> images = [];

  int _radValCat=0;
  int _radValType=0;
  int _radValContact=0;
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
                      Text('EGYPT',style: TextStyle(color: Colors.lightGreen),)
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
                ListTile(
                  leading: Text('Attatch Product Images:',style: Cons.blackFont,),
                  onTap:  buildMultiImagePicker,
                  //     (){
                  //   buildMultiImagePicker();
                  //   print('cccccc');
                  // },
                  trailing: CircleAvatar(child: Icon(Icons.attach_file,color: Colors.white,),backgroundColor: Cons.accent_color,)
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
    return Row(
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
    );
  }

  Widget buildTextFormProductData(String flag, String hint, IconData icon, TextInputType inputType){
    return TextFormField(
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
          map['email'] = value;
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
    return Column(
      children: [
        Row(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(value: 0, groupValue: _radValContact, onChanged: (value){
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
    );

  }
  
  Widget buildGridImagePicker(){
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      childAspectRatio: 1/0.8,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];

        return Container(
          width: 2,
          height: 2,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Cons.accent_color),
            borderRadius: BorderRadius.circular(15)
          ),
          child: AssetThumb(
            asset: asset,
            width: 100,
            height: 100,
          ),
        );
      }),
    );
  }

 Future buildMultiImagePicker() async{

    var f=await ImagePicker.mulPicker(context);
    List<Asset> resultList = List<Asset>();
    //List<MultipartFile> resultList = List<MultipartFile>();
    try {
      resultList = (await MultiImagePicker.pickImages(
          maxImages: 300,
          selectedAssets: images,
          enableCamera: true,
          materialOptions: MaterialOptions(
            actionBarTitle: "FlutterCorner.com",
          )));

      setState(() {
        images=resultList;
      });

      print(images.length);
    }
    catch(err){
 print('vvvvvvvvvvvvvvvv      $err');
    }
  }

 Widget buildProductType() {
    return Row(
     // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Type:'),
        SizedBox(width: 30,),
        Radio(value: 0, groupValue: _radValType, onChanged: (value){
          setState(() {
            print(value);
            _radValType=value;
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
    );
  }

  void saveProductData() async{
    // List<String> newImages=[];
    if(_key.currentState.validate()&& images.length>0){
      _key.currentState.save();
    //   for (int i=0;i<images.length;i++){
    //     newImages.add(images[i].name);
    //   }
      map['images']=images;
      map['id']=AuthController.userId;
      map['isFav']=0;
      map['cat']=0;
      map['status']=0;
      print('${images[0].name}');

      List<MultipartFile> multipart = List<MultipartFile>();

      var path2 = await FlutterAbsolutePath.getAbsolutePath(images[0].identifier);
      print(path2);
      await controller.createProduct(map,path2);
     // print(images[0].name);

    }else if(images.length==0){
      print( 'please select at least one image');

      Fluttertoast.showToast(
          msg: "please select at least one image",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
      );
    }
  }
}
