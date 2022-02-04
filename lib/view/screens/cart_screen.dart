import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/cart.dart';
import 'package:saaty_app/providers/Orders.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/view/screens/login_screen.dart';

class CartScreen extends StatelessWidget {
  static String Cart_Route='cart_screen';
  Cart cart=  Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    var carts=cart.cartsList.values.toList();
    print('ssssss     '+carts[0].id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
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
              Expanded(
                child: ListView.builder(
                    itemCount: cart.cartsList.length,itemBuilder: (_,index){
                  return
                    CartItemWidget(
                        carts[index].id,carts[index].title,carts[index].price,carts[index].quantity
                    );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
                    FlatButton(onPressed: (){
                      Navigator.of(ctx).pop();
                     _cart.removeItem(id);
                     _cart.update();
                     print('hhh  v'+id);
                    }, child: Text('ok'.tr))
                  ],)
            );
          },
          onDismissed: (dir){
            print('disssssss');
            _cart.removeItem(id);
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
                    child: FittedBox(child: Text('\$${price}',style: TextStyle(color: Colors.white),)),
                  ),
                  backgroundColor: Theme.of(context).accentColor,
                ),
                trailing: Text('${quantity} x'),
                title: Text(title),
                subtitle: Text('total\$${price* quantity}'),
                 // ${'total'.tr}
              ),
            ),
          )
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
    return _isLoading?CircularProgressIndicator():
    FlatButton(
        onPressed:StorageController.isGuest?Navigator.of(context).pushNamed(LoginScreen.LOGIN_SCREEN_ROUTE):
        widget.cart.cartsList.length<0||_isLoading?null:()async{
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