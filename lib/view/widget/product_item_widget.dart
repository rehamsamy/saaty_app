import 'package:flutter/material.dart';
import 'package:saaty_app/model/product_model.dart';

class ProductItemWidget extends StatefulWidget {
  List<Product> allProducts=[];
  int indx=0;


  ProductItemWidget(this.allProducts,this.indx);

  @override
  _ProductItemWidgetState createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child:
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          elevation: 8,
          child: Padding(
            padding:EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Stack(
             // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Image.network(widget.allProducts[widget.indx].images[0],fit: BoxFit.cover,)),
                //Image.asset(stores[indx].images.,fit: BoxFit.contain,),
                SizedBox(height: 10,),
                Align(
                    alignment: Alignment.bottomLeft,
                  child:
                Text(widget.allProducts[widget.indx].name,)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                  '${widget.allProducts[widget.indx].price}  PSD',),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: (){},
                    icon:Icon(Icons.favorite_border),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  }
}
