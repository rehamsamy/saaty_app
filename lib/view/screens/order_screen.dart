import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/Orders.dart';
import 'package:saaty_app/view/widget/order_item_widget.dart';


class OrderScreen extends StatelessWidget {
  static String Order_Screen_Route='r4';
  Orders _orders=Get.find();

  @override
  Widget build(BuildContext context) {
    fetchOrdersData();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        centerTitle: true,
      ),
      //drawer: AppDrawer(),
      body: GetBuilder<Orders>(
          builder: (_) {
            return
              ListView.builder(
                  itemCount: _orders.ordersList.length,
                  itemBuilder: (ctx, index) {
                    return
                      //Center(child: Text('ord.ordersList[index].id'));
                      OrderItemWidget(_orders.ordersList[index]);
                  });
          }
                )

    );
  }

  void fetchOrdersData()async {
    await _orders.fetchOrdersData();
  }
}