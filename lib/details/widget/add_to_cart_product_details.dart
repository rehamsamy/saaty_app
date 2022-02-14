import 'package:flutter/material.dart';
import 'package:saaty_app/model/cart.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/login_register/screen/login_screen.dart';
import 'package:saaty_app/create_product/screen/send_message_screen.dart';
import 'package:get/get.dart';

import '../../cons.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    Key key,
    @required this.product,
    @ required this.cart,
    @ required this.num
  }) : super(key: key);

  final Product product;
  final Cart cart;
  final int num;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //SizedBox(width: 20,),
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton.icon(
                icon:
                Icon( Icons.message_rounded,color: Colors.white,),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Cons.accent_color,
                //color: Cons.blueColor,
                onPressed: () =>
                StorageController.isGuest?Navigator.of(context).pushNamed(LoginScreen.LOGIN_SCREEN_ROUTE):
                Navigator.of(context).pushNamed(SendMessageScreen.SEND_MESSAGE_SCREEN_ROUTE,arguments: product.creator_id),
                label: Text(
                  "send_message".tr,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
