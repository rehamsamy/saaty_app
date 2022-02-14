import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/carts/widget/cart_item_widget.dart';
import 'package:saaty_app/model/cart.dart';
import 'package:saaty_app/providers/Orders.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/login_register/screen/login_screen.dart';

class CartScreen extends StatelessWidget {
  static String Cart_Route='cart_screen';
  Cart cart=  Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        centerTitle: true,
      ),
      body: GetBuilder<Cart>(
        builder: (_)=> Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              elevation: 15,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('total'.tr,style: TextStyle(color: Colors.black87,fontSize: 20)),
                    Spacer(),
                    Container(
                      width: 100,
                      height: 50,
                      child: Chip(label: Text('\$${cart.getTotal.toStringAsFixed(2)}'
                        ,style: TextStyle(color: Colors.white),),
                        backgroundColor: Theme.of(context).primaryColor,),
                    ),
                    OrderButton(cart)

                    // ${cart.getTotal.toStringAsFixed(2)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            GetBuilder<Cart>(
              builder: (_){
                List<CartItem> carts= cart.cartsList.values.toList();
                return Expanded(
                child: ListView.builder(
                    itemCount: cart.cartsList.length,itemBuilder: (_,index){
                  return
                    CartItemWidget(
                        carts[0].id,carts[index].title,carts[index].price,carts[index].quantity
                    );
                }),
              );}
            )
          ],
        ),
      ),
    );
  }

}


class OrderButton extends StatefulWidget {

  Cart cart;

  OrderButton(this.cart);

  @override
  State<StatefulWidget> createState() {
    return OrderButtonState();
  }
}

class OrderButtonState extends State<OrderButton>{
  Orders _orders=Get.find();
  bool _isLoading=false;

  @override
  Widget build(BuildContext context) {
        return
      _isLoading?CircularProgressIndicator():
      FlatButton(
          onPressed:
          widget.cart.cartsList.isEmpty||StorageController.getString(StorageController.type)=='guest'?null:()async{
            setState(() {
              _isLoading=true;
            });
            await  _orders.addOrder(widget.cart.cartsList.values.toList(), widget.cart.getTotal)
                .then((value) {
              setState(() {
                _isLoading=false;
              });
              widget.cart.clearAll();
            });


          }, child: Text('order_now'.tr,style: TextStyle(color: Theme.of(context).primaryColor,
        fontSize: 15),));
  }

}