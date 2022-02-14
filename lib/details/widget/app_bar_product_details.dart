import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:saaty_app/ads_favorite/screen/ads_screen.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/create_product/screen/create_product_screen.dart';
import 'package:saaty_app/login_register/screen/login_screen.dart';

import '../../cons.dart';

class AppBarProduct extends StatelessWidget {
Product product;
String _prodType;
ProductController _productController=Get.find();
AppBarProduct(this.product, this._prodType);
  @override
  Widget build(BuildContext context) {
      return  AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Cons.blueColor,
          elevation: 5.0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          flexibleSpace:  GetBuilder<ProductController>(
            builder: (_)=>
                FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(5),
                  centerTitle: true,
                  title: _prodType==null ||_prodType=='fav'?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: false,
                        child: IconButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, icon: Icon(Icons.arrow_back,color: Colors.white,size: 30)),
                      ),
                      Text(product.name, style: Cons.whiteFont),
                      IconButton(onPressed: ()async{
                        if(StorageController.isGuest){
                          Navigator.of(context).pushReplacementNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
                        }else{
                          print('pppp');
                          if(product.isFav==1){
                            await  toogleFav(0, product.id,product);
                          }else{
                            await toogleFav(1, product.id,product);
                          }
                          _productController.changeFavoriteFlag(product.isFav);
                        }

                      }, icon: Icon(product.isFav==1?Icons.favorite:Icons.favorite_border,color: Colors.red,size: 30,)),
                    ],
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                          flex: 1,
                          child: SizedBox(width: 1,)
                        // IconButton(onPressed: (){
                        //   Navigator.of(context).pop();
                        // }, icon: Icon(Icons.arrow_back,color: Cons.accent_color,size: 25)),
                      ),
                      Flexible(
                        flex: 1,
                        child: IconButton(onPressed: ()async{
                          print('ppppp');
                          if(StorageController.isGuest==true){
                            Navigator.of(context).pushReplacementNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
                          }else {
                            if (product.isFav == 1) {
                              await toogleFav(0, product.id, product);
                            } else {
                              await toogleFav(1, product.id, product);
                            }
                            _productController.changeFavoriteFlag(product.isFav);
                            _productController.update();
                          }
                        }, icon: Icon(product.isFav==1?Icons.favorite:Icons.favorite_border,color: Colors.red,size: 25)),
                      ),
                      Padding(
                          padding:EdgeInsets.only(left: 10,right: 10),child: Text(product.name, style: TextStyle(fontSize: 18,color: Colors.black54))),
                      Flexible(
                          flex:1,child: IconButton(onPressed: (){
                            _productController.deleteProduct(product.id).then((value) => Navigator.of(context).pushNamed(AdsScreen.ADS_SCREEN_ROUTE));
                      }, icon: Icon(Icons.delete,color: Colors.white,size: 25))),
                      Flexible(
                          flex:1,child: IconButton(onPressed: (){
                        Navigator.of(context).pushNamed(CreateProductScreen.CREATE_PRODUCT_ROUTE,arguments: product);
                      }, icon: Icon(Icons.edit,color: Colors.white,size: 25,))),

                    ],
                  ),

                ),
          ));



  }

Future toogleFav(int fav,String prodId,Product product) async {
  await _productController
      .toggleFav(prodId, fav)
      .then((value) => product.isFav=fav);
}

}
