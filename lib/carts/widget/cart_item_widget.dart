import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/cart.dart';

class CartItemWidget  extends StatelessWidget{
  String id;
  String title;
  String  price;
  int  quantity;
  Cart _cart=Get.find();


  CartItemWidget(this.id, this.title, this.price,
      this.quantity); //CartItemWidget( this.id,this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    print('111111  '+ id+'   '+_cart.cartsList.values.toList().length.toString());
    return GetBuilder<Cart>(
      builder: (_)=>
          Dismissible(key: ValueKey(id),
              background: Container(
                margin: EdgeInsets.all(15),
                color: Theme.of(context).primaryColor,
                child: Text('delete'.tr),
              ),
              direction: DismissDirection.endToStart,
              confirmDismiss: (dir){
                showDialog(context: context, builder: (ctx)=>
                    AlertDialog(title:Text('delete_item'.tr),content: Text('are_you_sure_delete'.tr),
                      actions: [
                        FlatButton(onPressed: ()async{
                          Navigator.of(ctx).pop();
                          await _cart.removeItem(id).then((value) =>  print('hhh  v '+id +'    '+_cart.cartsList.values.toList()[0].id));
                          _cart.update();
                          // print('hhh  v '+id +'    '+_cart.cartsList.values.toList()[0].id);
                        }, child: Text('ok'.tr))
                      ],)
                );
              },
              onDismissed: (dir){
                print('disssssss');
                _cart.removeSingleItem(id);
                _cart.update();
              },
              child:  Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 15,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(child: Text('\$${price}',style: TextStyle(color: Colors.white,fontSize: 15),)),
                      ),
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                    trailing: Text('${quantity} x'),
                    title: Text(title),
                    subtitle: Text('total \$${price* quantity}'),
                    // ${'total'.tr}
                  ),
                ),
              )
          ),
    );
  }
}
