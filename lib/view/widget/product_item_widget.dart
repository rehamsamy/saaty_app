import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/cart.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/login_register/screen/login_screen.dart';
import 'package:saaty_app/details/screen/product_item_detail_screen.dart';
import 'package:saaty_app/view/widget/app_cashed_image.dart';

import '../../cons.dart';

class ProductItemWidget extends StatelessWidget {
  Product product;
  String flag;
  ProductController _productController = Get.find();
  Cart _cart = Get.find();
  AuthController _authController=Get.find();
  ProductItemWidget(this.product, [this.flag]);

  @override
  Widget build(BuildContext context) {
    print('vvvvv' +product.images[0]);
        return GetBuilder<ProductController>(
          builder: (_)=>
           GestureDetector(
      onTap: () {
          Navigator.of(context).pushNamed(
              ProductItemDetailScreen.PRODUCT_DETAIL_ROUTE,
              arguments: {'prod': product, 'flag': flag});
      },
      child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Positioned(
                      left: 20,
                      right: 20,
                      top: 30,
                      bottom: 25,
                      child: Hero(
                        tag: product.id,
                        child:
                        AppCashedImage(
                          imageUrl:product.images[0] ,
                          fit: BoxFit.contain,
                        ),

                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                        width: 50,
                        child: Text(
                          product.name,
                            overflow: TextOverflow.ellipsis,
                          style:  TextStyle(color: Colors.black54, fontSize: 15,)
                        ),
                      )),
                  Positioned(
                    bottom: 1,
                    left: 1,
                    child: Container(
                      width: 55,
                      child: Text(
                        '${product.price}${'currency'.tr}',
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: Colors.green.shade600, fontSize: 15,),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 1,
                      child: IconButton(onPressed: (){
                        _cart.addCartItem(product.id, double.parse(product.price), product.name);
                        _cart.changeCartFlag(1);
                        _cart.update();
                      },
                      icon: GetBuilder<Cart>(
                        builder: (_)=> Icon(Icons.shopping_cart_outlined,
                          color:Colors.grey,),
                          //_cart.isCart==1 ?Colors.red:Colors.grey,),
                      ),),
                     ),
                  Positioned(
                      top: 0,
                      right: 1,
                      child: IconButton(
                          onPressed: () async {
                            if(StorageController.isGuest){
                              Navigator.of(context).pushReplacementNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
                           }else{
                             Map<String, dynamic> map = Product().toMap(product);
                             if (product.isFav == 1) {
                               print('case1');
                               await toogleFav(0, Icons.favorite_border, map);
                             } else {
                               print('case2');
                               await toogleFav(1, Icons.favorite, map);
                             }
                             _productController.changeFavoriteFlag(product.isFav);
                             _productController.update();
                           }
                          },
                          icon: Icon(
                            product.isFav==1 ?Icons.favorite  : Icons.favorite_border,
                            color: Colors.red,
                          )
                          ))
                ],
              ),
            ),
          ),
      ),
    ),
        );
  }

  Future toogleFav(int fav, IconData iconData, Map<String, dynamic> map) async {
    map['isFav'] = fav;
    await _productController
        .toggleFav(map['id'], fav)
        .then((value) => product.isFav=fav);
  }
}
