import 'package:flutter/material.dart';
import 'package:saaty_app/model/product_model.dart';

class ProductItemDetailScreen extends StatefulWidget {

  static String PRODUCT_DETAIL_ROUTE='/5';

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
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.name),
              background: Hero(
                tag: product.id,
                child: FadeInImage(image: NetworkImage(product.images[0],scale: 1),
                  placeholder: AssetImage('watch_item1.png'),
                fit: BoxFit.cover,),
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(
            [
              Container(
                height:700,
                child: Text('ffffffffffffffff'),
              )
            ]
          ))
        ],
      ),
    );
  }
}
