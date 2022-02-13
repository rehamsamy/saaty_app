
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:saaty_app/details/widget/add_to_cart_product_details.dart';
import 'package:saaty_app/details/widget/app_bar_product_details.dart';
import 'package:saaty_app/details/widget/product_images_product_details.dart';
import 'package:saaty_app/details/widget/type_status_product_details.dart';
import 'package:saaty_app/model/cart.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/view/screens/cart_screen.dart';
import 'package:saaty_app/view/widget/app_cashed_image.dart';

import '../../cons.dart';


int quantity=1;


class ProductItemDetailScreen extends StatelessWidget {
  static String PRODUCT_DETAIL_ROUTE='/6';

  double width,height;
  ProductController _productController=Get.find();
  AuthController _authController=Get.find();
  int numOfItems=1;
  Cart _cart=Get.find();
  Product product;
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    Map<String,dynamic> map = ModalRoute.of(context).settings.arguments as  Map<String,dynamic> ;
    product=map['prod'];
    String _prodType=map['flag'];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBarProduct( product, _prodType)),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Cons.blueColor,
          ),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 0.3),
                padding: EdgeInsets.only(
                  top: 20,  //height * 0.12,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),

                ),
                child: Column(
                  children: [
                    TypeStatusProduct(product),

                    SizedBox(height: 10,),
                    ContainerProductImages(product),
                    SizedBox(height: 20,),
                            ListTile(
                                leading: Icon(Icons.phone_android_sharp,
                                  color: Cons.primary_color,),title: Text(product.phone),contentPadding: EdgeInsets.all(0)),
                            ListTile(leading: Icon(Icons.email,color: Cons.primary_color,),title: Text(product.email),contentPadding: EdgeInsets.all(0)),


                    SizedBox(height: 10,),
                    CounterWithFavBtn(context),
                    SizedBox(height: 10,),
                    AddToCart(product: product,cart:_cart,num:numOfItems)
                  ],
                ),
              ),
              buildImage(product,height),
              ProductTitleWithImage(product: product,height: height,)
            ],
          ),
        ),
      ),

    );
  }



  CounterWithFavBtn(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
        CartCounter(),
    IconButton(onPressed: () {
      Colors.red;
      _cart.addCartItem(
          product.id, double.parse(product.price) * quantity, product.name);
      Fluttertoast.showToast(
          msg: "Add  to cart Sucessfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white
      );
      Navigator.of(context).pushNamed(CartScreen.Cart_Route);
    }

    , icon: Icon(Icons.add_shopping_cart_outlined,size: 30,
      color: Colors.black,
    ),),
      ],
    );
  }











}



class CartCounter extends StatefulWidget {


  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
                quantity=numOfItems;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
                quantity=numOfItems;
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}





class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product, this.height,
  }) : super(key: key);
  final Product product;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: height*.25,
        padding: EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "${'trader_name'.tr}\n"),
                  TextSpan(
                    text: "${product.creator_name}",
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold,fontSize: 35),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "${'price'.tr}\n"),
                  TextSpan(
                    text: "\$${product.price}",
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold,fontSize: 35),
                  ),
                ],
              ),
            ),
          //  SizedBox(width: 20)
          ],
        ),
      ),
    );
  }
}



buildImage(Product product,double height){
  return   Positioned(
   left: 0,
    child: Container(
      margin: EdgeInsets.only(top:height *0.1 ),
      width:250,
      height: 200,
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
          bottomRight:Radius.circular(30),
            bottomLeft:Radius.circular(30),
          ),
          child: Hero(
              tag: "${product.id}",
              child: AppCashedImage(imageUrl: product.images[0],fit: BoxFit.contain)
          ),
        ),
      ),
    ),
  );
}

