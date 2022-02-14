import 'package:flutter/material.dart';
import 'package:saaty_app/carts/screen/cart_screen.dart';

class Badge extends StatelessWidget {
  String value;
  Color color;
  Badge( this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(icon:Icon(Icons.shopping_cart,),
          onPressed: ()=>Navigator.of(context).pushNamed(CartScreen.Cart_Route),),
        Positioned(
         right: 5,
          top: 4,
          child: Container(
            width: 20,
            height: 20,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: color!=null?color:Theme.of(context).accentColor,
             shape: BoxShape.circle
             // borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text(value)),
          ),
            )
      ],
    );
  }
}
