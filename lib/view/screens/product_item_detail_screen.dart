//
// import 'package:flutter/material.dart';
// import 'package:saaty_app/model/product_model.dart';
//
// class ProductItemDetailScreen extends StatelessWidget {
//   static String PRODUCT_DETAIL_ROUTE='/6';
//   double width,height;
//   Product product;
//   @override
//   Widget build(BuildContext context) {
//     width=MediaQuery.of(context).size.width;
//     height=MediaQuery.of(context).size.height;
//     Map<String,dynamic> map = ModalRoute.of(context).settings.arguments as  Map<String,dynamic> ;
//     product=map['prod'];
//     String _prodType=map['flag'];
//     return SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height:height,
//             child: Stack(
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.only(top: height * 0.3),
//                   padding: EdgeInsets.only(
//                     top: height * 0.12,
//                     left: 20,
//                     right: 20,
//                   ),
//                   // height: 500,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(24),
//                       topRight: Radius.circular(24),
//                     ),
//                   ),
//                   child: Column(
//                     children: <Widget>[
//                       ColorAndSize(product: product),
//                       SizedBox(height: 20 / 2),
//                       Description(product: product),
//                       SizedBox(height: 20 / 2),
//                       CounterWithFavBtn(),
//                       SizedBox(height: 20 / 2),
//                       AddToCart(product: product)
//                     ],
//                   ),
//                 ),
//                 ProductTitleWithImage(product: product)
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
//
// class ColorAndSize extends StatelessWidget {
//   const ColorAndSize({
//     Key key,
//     @required this.product,
//   }) : super(key: key);
//
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text("Color"),
//               Row(
//                 children: <Widget>[
//                   ColorDot(
//                     color: Color(0xFF356C95),
//                     isSelected: true,
//                   ),
//                   ColorDot(color: Color(0xFFF8C078)),
//                   ColorDot(color: Color(0xFFA29B9B)),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: RichText(
//             text: TextSpan(
//               style: TextStyle(color: Color(0xFF535353)
//               ),
//               children: [
//                 TextSpan(text: "Size\n"),
//                 TextSpan(
//                   text: "${product.price} cm",
//                   style: Theme.of(context)
//                       .textTheme
//                       .headline5
//                       .copyWith(fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
// class ColorDot extends StatelessWidget {
//   final Color color;
//   final bool isSelected;
//   const ColorDot({
//     Key key,
//     this.color,
//     // by default isSelected is false
//     this.isSelected = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(
//         top: 20 / 4,
//         right: 20 / 2,
//       ),
//       padding: EdgeInsets.all(2.5),
//       height: 24,
//       width: 24,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: isSelected ? color : Colors.transparent,
//         ),
//       ),
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }
// }
//
//
// class ProductTitleWithImage extends StatelessWidget {
//   const ProductTitleWithImage({
//     Key key,
//     @required this.product,
//   }) : super(key: key);
//
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             product.name,
//             style: TextStyle(color: Colors.white),
//           ),
//           Text(
//             product.name,
//             style: Theme.of(context)
//                 .textTheme
//                 .headline4
//                 .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           Row(
//             children: <Widget>[
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(text: "Price\n"),
//                     TextSpan(
//                       text: "\$${product.price}",
//                       style: Theme.of(context).textTheme.headline4.copyWith(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 20),
//               Expanded(
//                 child: Hero(
//                   tag: "${product.id}",
//                   child: Image.asset(
//                     product.images[0],
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
//
// class Description extends StatelessWidget {
//   const Description({
//     Key key,
//     @required this.product,
//   }) : super(key: key);
//
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: Text(
//         product.desc,
//         style: TextStyle(height: 1.5),
//       ),
//     );
//   }
// }
//
//
//
// class CounterWithFavBtn extends StatelessWidget {
//   const CounterWithFavBtn({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         CartCounter(),
//         Container(
//           padding: EdgeInsets.all(8),
//           height: 32,
//           width: 32,
//           decoration: BoxDecoration(
//             color: Color(0xFFFF6464),
//             shape: BoxShape.circle,
//           ),
//           child: Image.asset("assets/icons/store1.png"),
//         )
//       ],
//     );
//   }
// }
//
//
//
// class CartCounter extends StatefulWidget {
//   @override
//   _CartCounterState createState() => _CartCounterState();
// }
//
// class _CartCounterState extends State<CartCounter> {
//   int numOfItems = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         buildOutlineButton(
//           icon: Icons.remove,
//           press: () {
//             if (numOfItems > 1) {
//               setState(() {
//                 numOfItems--;
//               });
//             }
//           },
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
//           child: Text(
//             // if our item is less  then 10 then  it shows 01 02 like that
//             numOfItems.toString().padLeft(2, "0"),
//             style: Theme.of(context).textTheme.headline6,
//           ),
//         ),
//         buildOutlineButton(
//             icon: Icons.add,
//             press: () {
//               setState(() {
//                 numOfItems++;
//               });
//             }),
//       ],
//     );
//   }
//
//   SizedBox buildOutlineButton({IconData icon, Function press}) {
//     return SizedBox(
//       width: 40,
//       height: 32,
//       child: OutlineButton(
//         padding: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(13),
//         ),
//         onPressed: press,
//         child: Icon(icon),
//       ),
//     );
//   }
// }
//
//
//
// class AddToCart extends StatelessWidget {
//   const AddToCart({
//     Key key,
//     @required this.product,
//   }) : super(key: key);
//
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: Row(
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.only(right: 20),
//             height: 50,
//             width: 58,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(18),
//               border: Border.all(
//                 color: Colors.blueGrey,
//               ),
//             ),
//             child: IconButton(
//               icon: Image.asset(
//                 "assets/icons/splash.png",
//                 color: Colors.blueGrey,
//               ),
//               onPressed: () {},
//             ),
//           ),
//           Expanded(
//             child: SizedBox(
//               height: 50,
//               child: FlatButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18)),
//                 color: Colors.blueGrey,
//                 onPressed: () {},
//                 child: Text(
//                   "Buy  Now".toUpperCase(),
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//




import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:saaty_app/model/cart.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/view/screens/cart_screen.dart';
import 'package:saaty_app/view/screens/send_message_screen.dart';

import '../../cons.dart';
import 'create_product_screen.dart';
import 'login_screen.dart';

int quantity=1;


class ProductItemDetailScreen extends StatelessWidget {
  static String PRODUCT_DETAIL_ROUTE='/6';
  CarouselController _carouselController = CarouselController();
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
      appBar: buildAppBar(context, product, _prodType),
      body: SingleChildScrollView(
        child: Container(
         // padding: EdgeInsets.all(10),
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
                    buildTypeStatusProduct(context),

                    SizedBox(height: 10,),
                    buildContainerProductImages(product,context),
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
      // floatingActionButton:
      //        FloatingActionButton(
      //     child: Icon(Icons.email_rounded,color: Colors.white,),
      //     onPressed: ()=>_authController.visitorFlag?Navigator.of(context).pushNamed(LoginScreen.LOGIN_SCREEN_ROUTE):
      //         Navigator.of(context).pushNamed(SendMessageScreen.SEND_MESSAGE_SCREEN_ROUTE,arguments: product.creator_id),
      //   )
    );
  }

  buildTypeStatusProduct(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Container(child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('category'.tr,style:Theme.of(context).textTheme.headline6,),
              Text(product.cat==0?'watch'.tr:'braclete'.tr,style: Cons.accentFont)
            ],
          )),
          Container(child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('status'.tr,style:Theme.of(context).textTheme.headline6,),
              //Cons.blackStyle1,),
              Text(product.status==0?'new'.tr:'old'.tr,style:Cons.accentFont,)
            ],
          )),
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
       // height: 80,
        child: Center(
          child: Text(
                    product.desc,
                    style: Cons.blackStyle1,
                  //  overflow: TextOverflow.ellipsis
                    ),
        ),
      ),
    )

          // Row(
          //  // crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //   //  SizedBox(width: 5,),
          //     Container(
          //       height: 70,
          //       width: double.infinity,
          //       margin: EdgeInsets.all(5),
          //       child: Center(
          //         child: Text(
          //           product.desc,
          //           style: Cons.blackStyle1,
          //           overflow: TextOverflow.ellipsis
          //           ,
          //           //TextStyle(fontSize: 13,),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
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


  buildContainerProductImages(Product product,BuildContext context){
    return Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Cons.primary_color)),
        child: Stack(
          children: [
            ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product.images.length,
                itemBuilder: (_, indx) {
                  return Container(
                      margin: EdgeInsets.all(2),
                      child: SizedBox(
                          height: 65,
                          width: 55,
                          child: Image.network(
                            product.images[indx],
                            scale: 1,
                            fit: BoxFit.cover,
                          )));
                }),
            Align(
              alignment:StorageController.isArabicLanguage? Alignment.centerLeft:Alignment.centerRight,
              child: Container(
                height: 90,
                width: 65,
                color: Cons.accent_color,
                child: Center(
                  child: Container(
                    child: InkWell(
                      onTap: () {
                         showImageDialog(context, product);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            product.images.length.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Icon(
                            Icons.photo_camera,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }



void showImageDialog(BuildContext context, Product product) {
  showDialog(context: context, builder: (ctx){
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(ctx).size.height*0.7,
        margin: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
        width: double.infinity,
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCarouselSlider(product,context)  ,
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i =0;i<product.images.length;i++)
                  buildCircleSlider(i)
              ],
            )

          ],
        ),

      ),
    );
  });

}

Widget buildCircleSlider(int i){
  return GetBuilder<ProductController>(
    builder: (_)=>Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 13,
        width: 13,
        decoration: BoxDecoration(
            border:i==_productController.sliderIndex? Border.all(width:2,color:Cons.accent_color ):Border.all(width:1,color:Cons.accent_color ),
            shape: BoxShape.circle,
            color:_productController.sliderIndex==i?Colors.white:Cons.primary_color
        ),
      ),
    ),
  );
}


Widget buildCarouselSlider(Product product,BuildContext context) {
  return
    Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height *.4,
      child:
      GetBuilder<ProductController>(
        builder: (_)=>
         CarouselSlider(
          carouselController:_carouselController,
          items: product.images.map((e) =>
              Image.network(e,fit: BoxFit.fill,)
          ).toList(),
          options: CarouselOptions(
              onPageChanged: (ind,x){
               _productController.changeSliderImage(ind);
               _productController.update();
              },
              initialPage: 1,
              autoPlayAnimationDuration:Duration(milliseconds: 100),
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 9/6,
              viewportFraction: 0.97
          ),),
      ),

    );
}




  Widget buildAppBar(BuildContext context,Product product,String _prodType){
    return  AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // iconTheme: IconThemeData(
        //   color: Colors.white, //change your color here
        // ),
        backgroundColor: Cons.blueColor,
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace:  GetBuilder<ProductController>(
          builder: (_)=>
              FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(5),
                  centerTitle: true,
                  title: _prodType==null ||_prodType=='fav'?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: Icon(Icons.arrow_back,color: Cons.accent_color,size: 30)),
                      Text(product.name, style: Cons.whiteFont),
                      IconButton(onPressed: ()async{
                        if(StorageController.isGuest){
                          Navigator.of(context).pushReplacementNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
                        }else{
                          print('pppp');
                          if(product.isFav==1){
                            await  toogleFav(0, product.id,product);
                          }else{
                            await toogleFav(1, product.id,product);
                          }
                          _productController.changeFavoriteFlag(product.isFav);
                        }

                      }, icon: Icon(product.isFav==1?Icons.favorite:Icons.favorite_border,color: Colors.red,size: 30,)),
                    ],
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: SizedBox(width: 1,)
                        // IconButton(onPressed: (){
                        //   Navigator.of(context).pop();
                        // }, icon: Icon(Icons.arrow_back,color: Cons.accent_color,size: 25)),
                      ),
                      Flexible(
                        flex: 1,
                        child: IconButton(onPressed: ()async{
                          print('ppppp');
                          if(StorageController.isGuest==true){
                            Navigator.of(context).pushReplacementNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
                          }else {
                            if (product.isFav == 1) {
                              await toogleFav(0, product.id, product);
                            } else {
                              await toogleFav(1, product.id, product);
                            }
                            _productController.changeFavoriteFlag(product.isFav);
                            _productController.update();
                          }
                        }, icon: Icon(product.isFav==1?Icons.favorite:Icons.favorite_border,color: Colors.red,size: 25)),
                      ),
                      Padding(
                          padding:EdgeInsets.only(left: 10,right: 10),child: Text(product.name, style: TextStyle(fontSize: 18,color: Colors.black54))),
                      Flexible(
                          flex:1,child: IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.white,size: 25))),
                      Flexible(
                          flex:1,child: IconButton(onPressed: (){
                        Navigator.of(context).pushNamed(CreateProductScreen.CREATE_PRODUCT_ROUTE,arguments: product);
                      }, icon: Icon(Icons.edit,color: Colors.white,size: 25,))),

                    ],
                  ),
              //     background: Hero(
              //   tag: product.id,
              //   child: FadeInImage(
              //     image: NetworkImage(product.images[0]),
              //     // Image.network(product.images[0],),
              //     placeholder: AssetImage('assets/images/watch_item1.png'),
              //     fit: BoxFit.cover,
              //   ),
              // )
              ),
        ));

  }


  Future toogleFav(int fav,String prodId,Product product) async {
    await _productController
        .toggleFav(prodId, fav)
        .then((value) => product.isFav=fav);
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
              child: Image.network(product.images[0],  fit: BoxFit.fill,)
            //child:Image.asset(
            //  'assets/images/watch_item1.png',
            //   fit: BoxFit.fill,
            // width: 50,
            // height: 100,
            // ),
          ),
        ),
      ),
    ),
  );
}

