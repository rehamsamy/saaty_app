import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/model/user_model.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/view/screens/product_item_detail_screen.dart';
import 'package:saaty_app/view/screens/stores_screen.dart';

import '../../cons.dart';

class StoreItemWidget extends StatelessWidget {
  int index;
  UserModel model;
  StoreItemWidget(this.model,this.index);

  @override
  Widget build(BuildContext context) {
    int inx;
    if (index>4 ){
      inx=1;
    }else{
      inx=index+1;
    }
    print('+++ '+inx.toString());
    Map<String,dynamic> map={
      'model':model,
    'index':inx
    };
    return GetBuilder<ProductsController>(
      builder: (_)=>
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                  StoresScreen.Stores_SCREEN_ROUTE,
                  arguments: map);
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                color: Colors.white,
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Hero(tag:model.userId,child: Image.asset('assets/images/store${inx.toString()}.png')),
                    ),
                   // SizedBox(height: 10,),
                    Center(child:Text(model.name,style: TextStyle(color: Colors.black87,fontSize: 18),))
                  ],
                )
              ),
            ),
          ),
    );

  }

// Future toogleFav(int fav, IconData iconData, Map<String, dynamic> map) async {
//   map['isFav'] = fav;
//   await _productController
//       .toggleFav(map['id'], fav)
//       .then((value) => product.isFav=fav);
// }


}
