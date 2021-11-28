import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:saaty_app/model/product_model.dart';

import '../../cons.dart';

class ProductItemDetailScreen extends StatefulWidget {

  static String PRODUCT_DETAIL_ROUTE='/6';

  @override
  _ProductItemDetailScreenState createState() => _ProductItemDetailScreenState();
}

class _ProductItemDetailScreenState extends State<ProductItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 10,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.name),
              centerTitle: true,
              background:null
            ),
      
          ),
          SliverList(delegate: SliverChildListDelegate(
            [
              Column(
                children: [
                  Stack(
                    children: [
                     Container(
                       width: 300,
                       height: 300,
                       child: Hero(
                        tag: product.id,
                        child: FadeInImage(image: NetworkImage(product.images[0],scale: 1),
                          placeholder: AssetImage('watch_item1.png'),
                          fit: BoxFit.cover,),
                    ),
                     ),
                      Positioned(
                        left: 10,
                          bottom: 10,
                          child: Icon(product.isFav==0?Icons.favorite:Icons.favorite_border,color: Colors.red,))
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(product.cat==0?'Watch':'Braclet',style: Cons.accentFont,),
                      Text(product.price,style: Cons.greenFont,)
                    ],
                  ),SizedBox(height: 20,),
                  Text(product.desc,),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Cons.primary_color)
                    ),
                    child: Stack(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.images.length,
                            itemBuilder: (_,indx){
                              return Container(
                                  margin:EdgeInsets.all(5)
                                  ,child: Image.network(product.images[0],scale: 1,fit: BoxFit.cover,));
                            }
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                           height: 70,
                            width: 80,
                            color: Cons.accent_color,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(product.images.length.toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                Icon(Icons.photo_camera,color: Colors.white,),
                                Icon(Icons.arrow_forward_ios,color: Colors.white,)
                              ],
                            ) ,
                          ),
                        ),

                      ],
                    )

                    ),
                  SizedBox(height: 10,),
                  Divider(color: Cons.primary_color,)
                ],
              ),
            ]
          ))
        ],
      ),
    );
  }
}