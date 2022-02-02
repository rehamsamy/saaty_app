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




import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/product_controller.dart';

import '../../cons.dart';


class ProductItemDetailScreen extends StatelessWidget {
  static String PRODUCT_DETAIL_ROUTE='/6';
  double width,height;
  Product product;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    Map<String,dynamic> map = ModalRoute.of(context).settings.arguments as  Map<String,dynamic> ;
    product=map['prod'];
    String _prodType=map['flag'];
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Cons.accent_color,
                  const Color(0xFF00CCFF),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.decal),


        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: height * 0.3),
              padding: EdgeInsets.only(
                top: height * 0.12,
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
                  buildTypeStatusProduct(),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      product.desc,
                      style: Cons.blackStyle1
                      //TextStyle(fontSize: 13,),
                    ),
                  ),
                  SizedBox(height: 10,),
                  CounterWithFavBtn(),
                  SizedBox(height: 10,),
                  AddToCart(product: product)
                ],
              ),
            ),
            ProductTitleWithImage(product: product)
          ],
        ),
      ),
    );
  }

  buildTypeStatusProduct() {
    return Row(
      children: [
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('category'.tr,style: TextStyle(fontSize: 15),),
            Text(product.cat==0?'watch'.tr:'braclet'.tr,style: TextStyle(fontSize: 15),)
          ],
        )),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('status'.tr,style: TextStyle(fontSize: 15),),
            Text(product.status==0?'new'.tr:'old'.tr,style: TextStyle(fontSize: 15),)
          ],
        ))
      ],
    );
  }

  CounterWithFavBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(),
        Container(
          padding: EdgeInsets.all(8),
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Color(0xFFFF6464),
            shape: BoxShape.circle,
          ),
          child: Image.asset("assets/images/wishlist_not_select.png"),
         // child: IconButton(icon: Icon(Icons.favorite_border),),
        )
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
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.blueGrey,
              ),
            ),
            child:
            // IconButton(
            //   icon: Icon(Icons.add_shopping_cart_outlined),
              Image.asset(
                "assets/images/wishlist_select.png",
                color: Colors.blueGrey,
              ),
            //  onPressed: () {},
           // ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: SizedBox(
              height: 45,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.blueGrey,
                onPressed: () {},
                child: Text(
                  "Buy  Now".toUpperCase(),
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
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15),
          Text(
            product.name,
            style: TextStyle(color: Colors.white,fontSize: 16),
          ),
          Text(
            product.name,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),

          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "\$${product.price}",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 130,
                height: 105,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
                      topRight: Radius.circular(15)),
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
              )
            ],
          )
        ],
      ),
    );
  }
}



buildContainerProductImages(Product product){
  return Container(
      height: 100,
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
                    margin: EdgeInsets.all(5),
                    child: SizedBox(
                        height: 65,
                        width: 80,
                        child: Image.network(
                          product.images[indx],
                          scale: 1,
                          fit: BoxFit.cover,
                        )));
              }),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 100,
              width: 90,
              color: Cons.accent_color,
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
        ],
      ));
}


  //
  // void showImageDialog(BuildContext context, Product product) {
  //
  //   showDialog(context: context, builder: (ctx){
  //     return AlertDialog(
  //       content: Container(
  //         height: MediaQuery.of(ctx).size.height*0.7,
  //         margin: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
  //         width: double.infinity,
  //         child:
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             buildCarouselSlider(product,context)  ,
  //             SizedBox(height: 20,),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 for (int i =0;i<product.images.length;i++)
  //                   buildCircleSlider(i)
  //               ],
  //             )
  //
  //           ],
  //         ),
  //
  //       ),
  //     );
  //   });
  //
  // }
  //
  // Widget buildCircleSlider(int i){
  //   return GetBuilder<ProductController>(
  //     builder: (_)=>Padding(
  //       padding: const EdgeInsets.all(2.0),
  //       child: Container(
  //         height: 13,
  //         width: 13,
  //         decoration: BoxDecoration(
  //             border:i==_productController.sliderIndex? Border.all(width:2,color:Cons.accent_color ):Border.all(width:1,color:Cons.accent_color ),
  //             shape: BoxShape.circle,
  //             color:_productController.sliderIndex==i?Colors.white:Cons.primary_color
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  //
  // Widget buildCarouselSlider(Product product,BuildContext context) {
  //   return
  //     Container(
  //       width: double.infinity,
  //       height: MediaQuery.of(context).size.height *.4,
  //       child:
  //       GetBuilder<ProductController>(
  //         builder: (_)=>
  //          CarouselSlider(
  //           carouselController:_carouselController,
  //           items: product.images.map((e) =>
  //               Image.network(e,fit: BoxFit.fill,)
  //           ).toList(),
  //           options: CarouselOptions(
  //               onPageChanged: (ind,x){
  //                _productController.changeSliderImage(ind);
  //                _productController.update();
  //               },
  //               initialPage: 1,
  //               autoPlayAnimationDuration:Duration(milliseconds: 100),
  //               autoPlay: true,
  //               enlargeCenterPage: true,
  //               aspectRatio: 9/6,
  //               viewportFraction: 0.97
  //           ),),
  //       ),
  //
  //     );
  // }


