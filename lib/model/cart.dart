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
  int isCart=0;
  Map<String, CartItem> get cartsList => _cartsList;
  int get itemCount{
    return _cartsList.length;
  }


  changeCartFlag(int val){
    isCart=val;
    update();
  }


  double get getTotal{
    double _total = 0.0;
    _cartsList.forEach((key, cart) {
      _total+=cart.quantity * double.parse(cart.price);
    });
    return _total;
  }

  void addCartItem(String id,double price,String title){
print('kkkkv   '+id);
   if(_cartsList.containsKey(id)){
     print('yes');
   _cartsList.update(id, (oldCart) =>
       CartItem(id: oldCart.id,
           title: oldCart.title,
           price: oldCart.price,
           quantity: oldCart.quantity+1)
   );
   }else{
     print('no');
     _cartsList.putIfAbsent(id, () =>
         CartItem(id:id , title: title, price: price.toString(), quantity: 1)
    // DateTime.now().toString()
     );
   }
   print('exit ${_cartsList.toString()}');
   update();
  }

  Future removeItem(String id)async{
   await _cartsList.remove(id);
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