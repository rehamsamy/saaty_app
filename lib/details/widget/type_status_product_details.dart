import 'package:flutter/material.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:get/get.dart';

import '../../cons.dart';

class TypeStatusProduct extends StatelessWidget {
  Product product;
  TypeStatusProduct(this.product);
  @override
  Widget build(BuildContext context) {
       return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Container(child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('category'.tr,style:Theme.of(context).textTheme.headline6,),
              Text(product.cat==0?'watch'.tr:'braclete'.tr,style: Cons.accentFont)
            ],
          )),
          Container(child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('status'.tr,style:Theme.of(context).textTheme.headline6,),
              //Cons.blackStyle1,),
              Text(product.status==0?'new'.tr:'old'.tr,style:Cons.accentFont,)
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              // height: 80,
              child: Center(
                child: Text(
                  product.desc,
                  style: Cons.blackFont,
                  //  overflow: TextOverflow.ellipsis
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
