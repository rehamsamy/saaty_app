import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart 'as http;
import 'package:saaty_app/model/cart.dart';
import 'package:saaty_app/providers/storage_controller.dart';

class OrderItem{
  String id;
  String totalAmount;
  List<CartItem> orders;
  DateTime  dateTime;

  OrderItem( {@required this.id,@required this.totalAmount,@required this.orders, @required this.dateTime});

  factory OrderItem.fromjson(Map<String,dynamic> map){
    return OrderItem(id: map['id'],
        totalAmount: map['totalAmount'],
    orders: (map['orders'] as List<CartItem>).map((cart) =>
        CartItem(id: cart.id, title: cart.title, price: cart.price, quantity: cart.quantity)).toList(),
        dateTime: DateTime.parse(map['dateTime']));
  }
}

class Orders extends GetxController{
List<OrderItem> _ordersList=[];
String token;
String userId;


getData(String tokenn,String id,List<OrderItem> prods){
  print('idddd $id');
  token=tokenn;
  userId=id;
  _ordersList=prods;
update();
}

List<OrderItem> get ordersList => _ordersList;

Future<void> fetchOrdersData()async{
  _ordersList=[];
  List<OrderItem> ordered=[];
  String url='https://saaty-9ba9f-default-rtdb.firebaseio.com/orders/${StorageController.getString(StorageController.userId)}.json?auth=${StorageController.getString(StorageController.apiToken)}';

  try{
    var res= await http.get(Uri.parse(url));
    Map<String,dynamic> list=json.decode(res.body) as Map<String,dynamic> ;
    List<OrderItem> ordered=[];

    OrderItem item= OrderItem.fromjson(list);
    ordered.add(item);
    _ordersList=ordered.reversed;
  }catch(err){
    print(err);
throw err;

  }

update();

}


Future addOrder(List<CartItem> carts,double total_amount)async{
  Map<String,dynamic> map={
    'createdId':userId,
     'totalAmount':total_amount,
      'dateTime' :DateTime.now().toIso8601String(),
      'orders':(carts.map((cart) =>
          CartItem(id: cart.id, title: cart.title,
              price: cart.price, quantity: cart.quantity))).toList()};

  print('111');
  String url='https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json/'
      '${StorageController.getString(StorageController.userId)}.json?auth=${StorageController.getString(StorageController.apiToken)}';
  var response=await http.post(Uri.parse(url),body: json.encode(map));
  print('222');
  print(response.body);
  update();
}

}