import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/view/screens/product_item_detail_screen.dart';

import '../../cons.dart';

class StoreItemWidget extends StatelessWidget {
  Product product;
  String flag;
  ProductController _productController = Get.find();
  @override
  Widget build(BuildContext context) {
    print('vvvvv' +product.isFav.toString());
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
                child: Column(
                  children: [
                    Image.asset('assetes/images/store2.png'),
                    Center(child:Text('name'))
                  ],
                )
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
