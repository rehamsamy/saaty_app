import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/view/screens/product_item_detail_screen.dart';


import '../../cons.dart';

class HomeProductWidget extends StatelessWidget {
  Product product;
  String flag;
  ProductController _productController = Get.find();
  AuthController _authController=Get.find();
  HomeProductWidget(this.product, [this.flag]);
  double width,height;

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return GetBuilder<ProductController>(
      builder: (_)=>
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                  ProductItemDetailScreen.PRODUCT_DETAIL_ROUTE,
                  arguments: {'prod': product, 'flag': flag});
            },
            child: Container(
              //width: 500,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Card(
                //  color: Colors.white,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Stack(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                           Container(
                             padding: EdgeInsets.all(5),
                             child: Align(
                               alignment: Alignment.topRight,
                          child: Image.asset('assets/images/new1.jpeg',width: 35,height: 35,),),),
                        Align(
                            alignment: Alignment.center,
                            child:
                                Hero(
                                  tag: product.id,
                                  child: Container(
                                    width: width*0.4,height: height*0.2,
                                    child: FadeInImage(
                                         fit: BoxFit.fill,
                                      image:
                                          product.cat==0?
                                      AssetImage('assets/images/watch_item1.png'):
                                          AssetImage('assets/images/bracelets_item2.png')
                                      ,
                                     // NetworkImage(product.images[0],),
                                      placeholder:
                                      AssetImage('assets/images/watch_item1.png'),
                                    ),
                                  ),)
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                            child:  Container(
                              margin: EdgeInsets.all(10),
                              width: 80,
                              height: 30,
                              child: Center(
                                child: Text(
                                    product.name,
                                    overflow: TextOverflow.ellipsis,
                                    style:  TextStyle(color: Colors.black, fontSize: 14,)
                                ),
                              ),
                            ),

                          ),
                    Align(
                      alignment: Alignment.topLeft,
                      child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                                    width: 50,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft:Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                      border: Border.all(color: Colors.red)
                                    ),
                                    child: Center(
                                      child: Text(
                                          product.price,
                                          overflow: TextOverflow.ellipsis,
                                          style:  TextStyle(color: Colors.black, fontSize: 14,)
                                      ),
                                    ),
                                  ),

                            Container(
                              width: 70,
                              height: 25,
                              child: RaisedButton(
                                color: Cons.accent_color,
                                onPressed: (){
                                  Navigator.of(context).pushNamed(
                                      ProductItemDetailScreen.PRODUCT_DETAIL_ROUTE,
                                      arguments: {'prod': product, 'flag': flag});
                                },
                                child: Text('view'.tr,style:
                                TextStyle(color: Colors.white),),
                                shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                            ),

                          ],
                        )
                    ),
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
