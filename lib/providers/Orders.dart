import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart 'as http;
import 'package:saaty_app/model/cart.dart';
import 'package:saaty_app/providers/storage_controller.dart';

class OrderItem{
  String id;
  double totalAmount;
  List<CartItem> orders;
  DateTime  dateTime;

  OrderItem( {@required this.id,@required this.totalAmount,@required this.orders, @required this.dateTime});

  factory OrderItem.fromjson(Map<String,dynamic> map,String key){
    return OrderItem(id: key,
        totalAmount: map['amount'],
    orders: (map['products'] as List<dynamic>)
        .map((cart) =>
       CartItem(id: cart['id'], title: cart['title'], price: cart['price'], quantity: cart['quantity'])).toList(),
       dateTime: DateTime.parse(map['dateTime']));
  }
}

class Orders extends GetxController{
List<OrderItem> _ordersList=[];
String token=StorageController.getString(StorageController.apiToken);
String userId=StorageController.getString(StorageController.userId);


// getData(String tokenn,String id,List<OrderItem> prods){
//   print('idddd $id');
//   token=tokenn;
//   userId=id;
//   _ordersList=prods;
// update();
// }

List<OrderItem> get ordersList => _ordersList;

Future<void> fetchOrdersData()async{
  _ordersList=[];
  List<OrderItem> ordered=[];
 // print(StorageController.getString(StorageController.userId)+'  lllll   '+StorageController.getString(StorageController.apiToken));
  String url='https://saaty-9ba9f-default-rtdb.firebaseio.com/orders/${StorageController.getString(StorageController.userId)}.json?auth=${StorageController.getString(StorageController.apiToken)}';

  try{
    var res= await http.get(Uri.parse(url));
    Map<String,dynamic> list=json.decode(res.body) as Map<String,dynamic> ;
    List<OrderItem> ordered=[];

    print('vvv  '+list.toString());

    list.forEach((key, value) {
      print('lllll   '+value['id']);
      OrderItem item= OrderItem.fromjson(value,key);
      ordered.add(item);
      _ordersList.add(item);
     // _ordersList=ordered.reversed;
     print('lllll   '+item.toString());
    });

    // OrderItem item= OrderItem.fromjson(list);
    // ordered.add(item);
    // _ordersList=ordered.reversed;
  }catch(err){
    print(err);
throw err;

  }

update();

}


Future addOrder(List<CartItem> carts,double total_amount)async{
  Map<String,dynamic> map={
   // 'id':StorageController.getString(StorageController.userId),
     'amount':total_amount,
      'dateTime' :DateTime.now().toIso8601String(),
    'id':'',
      'products':(carts.map((cart) =>{
       'id':cart.id,
  'quantity':cart.quantity,
  'price':cart.price,
        'title':cart.title
  })).toList()
         };

  print('111');
  String url='https://saaty-9ba9f-default-rtdb.firebaseio.com/orders/'
      '${StorageController.getString(StorageController.userId)}.json?auth=${StorageController.getString(StorageController.apiToken)}';
  var response=await http.post(Uri.parse(url),body: json.encode(map));
  var res=json.decode(response.body);
  if(response.statusCode==200){

    _ordersList.insert(0, OrderItem(id: res['name'], totalAmount: res['amount'], orders:res['products'] , dateTime: res['dateTime']));
  }
  print('222');
  print(response.body);
  update();
}

}