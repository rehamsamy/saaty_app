import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/view/screens/login_screen.dart';
import 'package:saaty_app/view/screens/product_item_detail_screen.dart';

import '../../cons.dart';

class HomeProductWidget extends StatelessWidget {
  Product product;
  String flag;
  ProductController _productController = Get.find();
  AuthController _authController=Get.find();
  HomeProductWidget(this.product, [this.flag]);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (_)=>
          Container(
            height: 100,
            width: double.infinity-40,
            child: GestureDetector(
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
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Stack(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                           Align(
                             alignment: Alignment.centerRight,
                             child: Column(
                              children: [
                                Image.asset('assets/images/new1.jpeg',width: 50,height: 50,),
                                Hero(
                                  tag: product.id,
                                  child: Container(
                                    width: 70,height: 40,
                                    decoration: BoxDecoration(

                                    ),
                                    child: FadeInImage(
                                         fit: BoxFit.fill,
                                      image: NetworkImage(product.images[0],),
                                      placeholder:
                                      AssetImage('assets/images/watch_item1.png'),
                                    ),
                                  ),
                                )
                              ],
                          ),
                           ),

                        // Positioned(
                        //     left: 0,
                        //     right: 1,
                        //     top: 0,
                        //     bottom: 0,
                        //     child: Hero(
                        //       tag: product.id,
                        //       child: FadeInImage(
                        //      //   fit: BoxFit.cover,
                        //         image: NetworkImage(product.images[0], scale: 1,),
                        //         placeholder:
                        //         AssetImage('assets/images/watch_item1.png'),
                        //       ),
                        //     )),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Positioned(
                        //     bottom: 1,
                        //     left: 1,
                        //     child: Container(
                        //       width: 50,
                        //       child: Text(
                        //           product.name,
                        //           overflow: TextOverflow.ellipsis,
                        //           style:  TextStyle(color: Colors.black54, fontSize: 15,)
                        //       ),
                        //     )),
                        // Positioned(
                        //   bottom: 1,
                        //   left: 1,
                        //   child: Container(
                        //     width: 55,
                        //     child: Text(
                        //       '${product.price}${'currency'.tr}',
                        //       overflow: TextOverflow.ellipsis,
                        //       style:
                        //       TextStyle(color: Colors.green.shade600, fontSize: 15,),
                        //     ),
                        //   ),
                        // ),
                        // Positioned(
                        //     top: 0,
                        //     right: 1,
                        //     child: Image.asset('assets/images/new1.jpeg',width: 50,height: 50,)
                        //        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    );

  }




}
