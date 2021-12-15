import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/view/screens/product_item_detail_screen.dart';

import '../../cons.dart';

class ProductItemWidget extends StatefulWidget {
  Product product;
  String flag;
  ProductItemWidget( this.product,[this.flag]);

  @override
  _ProductItemWidgetState createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  ProductController _productController=Get.find();
  IconData _icon=Icons.favorite_border;
  int fav=0;
  List<Product> favs=[];
  @override
  Widget build(BuildContext context) {
   fetchFav();


    Product product=widget.product;
    String flag=widget.flag;
      return GestureDetector(
        onTap: (){
          Navigator.of(context).
          pushNamed(ProductItemDetailScreen.
          PRODUCT_DETAIL_ROUTE,arguments: {'prod':product,'flag':flag});},
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
                        if( fav==1){
                          print('case1');
                         await toogleFav(0, Icons.favorite_border,map);
                        }else{
                          print('case2');
                        await  toogleFav(1, Icons.favorite,map);
                        }

                      },
                      icon:Icon( fav==0?_icon:Icons.favorite,color: Colors.red,)
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
    print('favxxxxx'+fav.toString());
    await _productController.toggleFav(map['id'], map).then((value) =>
        setState(()=>_icon=iconData)
    );

  }

  Future fetchFav()async{
    _productController.favProducts.clear();
    await _productController.fetchFavorite().then((value) {
      print('bbbb  111 '+_productController.favProducts.length.toString());
      if(_productController.favProducts.length>0){
        print('888888888888');
        Product prod= _productController.favProducts.firstWhere((element) =>
        (element.id == widget.product.id));
        if(prod==null){
          setState(() {
            fav=0;
          });

        }else{
          setState(() {
            fav=prod.isFav;
          });

        }

        print('bbbbbbbbbbbb       ' +fav.toString());
      }else{
        fav=0;
      }


    });


  }
}