import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/view/screens/product_item_detail_screen.dart';

import '../../cons.dart';

class ProductItemWidget extends StatefulWidget {
  Product product;
  ProductItemWidget(this.product);

  @override
  _ProductItemWidgetState createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  ProductController _productController=Get.find();
  IconData _icon=Icons.favorite_border;
  @override
  Widget build(BuildContext context) {
    Product product=widget.product;
      return GestureDetector(
        onTap: (){
          Navigator.of(context).
          pushNamed(ProductItemDetailScreen.
          PRODUCT_DETAIL_ROUTE,arguments: product);},
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child:
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            elevation: 8,
            child: Padding(
              padding:EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                        child: FadeInImage(image: NetworkImage( product.images[0],scale: 1),
                        placeholder: AssetImage('assets/images/watch_item1.png'),),
                      )),
                  SizedBox(height: 10,),
                  Positioned(
                      bottom: 1,
                    right: 1,
                    child:
                  Text( product.name,style: Cons.greyFont1,)),
                  Positioned(
                    bottom: 1,
                    left: 1,
                    child:  Text(
                      '${ product.price}  PSD',style:TextStyle(color: Colors.green.shade600,fontSize: 15),),

                  ),
                  Positioned(
                    top: 0,
                    right: 1,
                    child: IconButton(
                      onPressed: () async{
                     Map<String,dynamic>  map= Product().toMap(product);
                        if( product.isFav==1){
                          print('case1');
                         await toogleFav(0, Icons.favorite_border,map);
                        }else{
                          print('case2');
                        await  toogleFav(1, Icons.favorite,map);
                        }

                      },
                      icon:Icon( product.isFav==0?_icon:Icons.favorite,color: Colors.red,)
                      //Icon(prodList[index].isFav==0?icon:Icons.favorite)),color:Colors.red),
                  )
                  ) ],
              ),
            ),
          ),
        ),
      );
  }

  Future toogleFav(int fav,IconData iconData, Map<String,dynamic>  map)async{
    map['isFav']=fav;
    await _productController.toggleFav(map['id'], map).then((value) =>
        setState(()=>_icon=iconData)
    );

  }
}