import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartItem{
  String id;
  String title;
  String  price;
  int  quantity;

  CartItem({@ required this.id,@ required this.title,@ required this.price, @ required this.quantity});
}

class Cart extends GetxController {
  Map<String,CartItem> _cartsList={};
  int quantity=0;
  Map<String, CartItem> get cartsList => _cartsList;
  int get itemCount{
    return _cartsList.length;
  }

  double get getTotal{
    double _total = 0.0;
    _cartsList.forEach((key, cart) {
      _total+=cart.quantity * double.parse(cart.price);
    });
    return _total;
  }

  void addCartItem(String id,double price,String title){

   if(_cartsList.containsKey(id)){
   _cartsList.update(id, (oldCart) =>
       CartItem(id: oldCart.id,
           title: oldCart.title,
           price: oldCart.price,
           quantity: oldCart.quantity+1)
   );
   }else{
     _cartsList.putIfAbsent(id, () =>
         CartItem(id: DateTime.now().toString(), title: title, price: price.toString(), quantity: 1)
     );
   }
   print('exit ${_cartsList.toString()}');
   update();
  }

  void removeItem(String id){
    _cartsList.remove(id);
    update();
  }

  void removeSingleItem(String id){
    if(_cartsList[id].quantity>1){
    _cartsList.update(id, (oldCart) =>
    CartItem(id: oldCart.id,
        title: oldCart.title,
        price: oldCart.price,
        quantity: oldCart.quantity-1));
    }else{
      _cartsList.remove(id);
    }
    update();
  }

  void clearAll(){
    _cartsList.clear();
    update();
  }

}