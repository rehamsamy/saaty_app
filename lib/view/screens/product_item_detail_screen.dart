import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/view/screens/send_message_screen.dart';

import '../../cons.dart';

class ProductItemDetailScreen extends StatefulWidget {

  static String PRODUCT_DETAIL_ROUTE='/6';

  @override
  _ProductItemDetailScreenState createState() => _ProductItemDetailScreenState();
}

class _ProductItemDetailScreenState extends State<ProductItemDetailScreen> {
  var _index;
  CarouselController _carouselController = CarouselController();
  ProductController _productController=Get.find();
  IconData _icon;




  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    WidgetsFlutterBinding.ensureInitialized();


    Map<String,dynamic> map = ModalRoute.of(context).settings.arguments as  Map<String,dynamic> ;
    Product product=map['prod'];
    String flag=map['flag'];
    _icon=Icons.favorite_border;
    //product.isFav==0?Icons.favorite_border:Icons.favorite;
    return Scaffold(
      appBar: AppBar(title: Text('My Ads', style: Cons.greyFont),
                elevation: 8,
                actions: [
                  IconButton(icon: Icon(
                    Icons.home, color: Cons.accent_color, size: 25,)),
                ],),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 25),
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.yellow.shade50,
                        ],)
                  ),
                  child: Hero(
                    tag: product.id,
                    child: FadeInImage(image: NetworkImage(product.images[0],scale: 1),
                      placeholder: AssetImage('assets/images/watch_item1.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                    left: 0,
                    bottom: 0,
                    child: IconButton(onPressed: ()async{
                      Map<String, dynamic> map = Product().toMap(product);
                      if (product.isFav == 1) {
                        print('case1');
                        await toogleFav(0,Icons.favorite_border,map);
                      } else {
                        print('case2');
                        await toogleFav(1,Icons.favorite,map);
                      }
                    }, icon: Icon(product.isFav==0?_icon:Icons.favorite,color: Colors.red, size: 30,))
                  //Icon(product.isFav==0?Icons.favorite_border:Icons.favorite,color: Colors.red,
                  //  size: 30,)
                )
              ],
            ),
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 15),child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.cat==0?'Watch':'Braclet',style: Cons.accentFont,),
                    Text('${product.price} PSD',style: Cons.greenFont,)
                  ],
                ),
                //SizedBox(height: 20,),
                ListTile(title: Text(product.desc),contentPadding: EdgeInsets.all(0)),
                // SizedBox(height: 20,),
                Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Cons.primary_color)
                    ),
                    child: Stack(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.images.length,
                            itemBuilder: (_,indx){
                              return Container(
                                  margin:EdgeInsets.all(5)
                                  ,child: Image.network(product.images[0],scale: 1,fit: BoxFit.cover,));
                            }
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 70,
                            width: 80,
                            color: Cons.accent_color,
                            child:InkWell(
                              onTap: (){
                                showImageDialog(context,product);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(product.images.length.toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                  Icon(Icons.photo_camera,color: Colors.white,),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ],
                              ),
                            ) ,
                          ),
                        ),

                      ],
                    )

                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Divider(color: Cons.primary_color,thickness: 1.2,),
                ),

                ListTile(title: Text('User Name:'),contentPadding: EdgeInsets.all(0)),
                ListTile(title: Text('Status:${product.status==0?'Old Product':'New Product'}'),contentPadding: EdgeInsets.all(0)),
                ListTile(leading: Icon(Icons.phone_android_sharp,color: Cons.primary_color,),title: Text(product.phone),contentPadding: EdgeInsets.all(0)),
                ListTile(leading: Icon(Icons.email,color: Cons.primary_color,),title: Text(product.email),contentPadding: EdgeInsets.all(0))
              ],
            ),)

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.email_rounded,color: Colors.white,),
        onPressed: ()=>Navigator.of(context).pushNamed(SendMessageScreen.SEND_MESSAGE_SCREEN_ROUTE),
      )
    );
  }

  void showImageDialog(BuildContext context, Product product) {

    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        content: Container(
          height: MediaQuery.of(ctx).size.height*0.6,
          margin: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
          width: double.infinity,
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  buildCarouselSlider(product)  ,
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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 13,
        width: 13,
        decoration: BoxDecoration(
            border:i==_index? Border.all(width:2,color:Cons.accent_color ):Border.all(width:1,color:Cons.accent_color ),
            shape: BoxShape.circle,
            color:_index==i?Colors.white:Cons.primary_color
        ),
      ),
    );
  }


  Widget buildCarouselSlider(Product product) {
    return
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height *.4,
        child:
        CarouselSlider(
          carouselController:_carouselController,
          items: product.images.map((e) =>
            Image.network(e,fit: BoxFit.fill,)
             ).toList(),
           options: CarouselOptions(
            onPageChanged: (ind,x){
              setState(() {
                _index=ind;
              });
            },
            initialPage: 1,
            autoPlayAnimationDuration:Duration(milliseconds: 400),
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 9/6,
            viewportFraction: 0.97
        ),),

    );
  }

  toogleFav(int fav ,IconData iconData,Map<String,dynamic> map) async{
    map['isFav']=fav;
    await _productController.toggleFav(map['id'], map).then((value) {
      if (mounted) {

      }
      print(iconData.toString());
    }

    );

    setState(() {
      print('vvvvvvvvvvvv---------  $fav');
      _icon=Icons.add_alert;
    });



  }
}