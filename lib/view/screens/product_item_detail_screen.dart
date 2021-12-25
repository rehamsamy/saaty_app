import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/view/screens/create_product_screen.dart';
import 'package:saaty_app/view/screens/send_message_screen.dart';

import '../../cons.dart';

class ProductItemDetailScreen extends StatelessWidget {

  static String PRODUCT_DETAIL_ROUTE='/6';

  CarouselController _carouselController = CarouselController();
  ProductController _productController=Get.find();
  IconData _icon;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    WidgetsFlutterBinding.ensureInitialized();


    Map<String,dynamic> map = ModalRoute.of(context).settings.arguments as  Map<String,dynamic> ;
    Product product=map['prod'];
    String _prodType=map['flag'];
    _icon=Icons.favorite_border;
    //product.isFav==0?Icons.favorite_border:Icons.favorite;
    return Scaffold(
        body:CustomScrollView(
          slivers: [
            buildAppBar(context,product,_prodType),
            SliverList(delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
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
                          SizedBox(height: 50,),
                          Container(
                              height: 100,
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
                                            ,child: SizedBox(
                                            height: 65,
                                            width: 80,
                                            child: Image.network(product.images[indx],scale: 1,fit: BoxFit.cover,)));
                                      }
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height: 100,
                                      width: 90,
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
                          SizedBox(height: 30,),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Divider(color: Cons.primary_color,thickness: 1.2,),
                          ),

                          ListTile(title: Text('User Name:'),contentPadding: EdgeInsets.all(0)),
                          ListTile(title: Text('Status:${product.status==0?'Old Product':'New Product'}'),contentPadding: EdgeInsets.all(0)),
                          ListTile(leading: Icon(Icons.phone_android_sharp,color: Cons.primary_color,),title: Text(product.phone),contentPadding: EdgeInsets.all(0)),
                          ListTile(leading: Icon(Icons.email,color: Cons.primary_color,),title: Text(product.email),contentPadding: EdgeInsets.all(0)),
                          SizedBox(height: 50,),
                        ],
                      ),)

                    ],
                  ),
                ]
            ))
          ],

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
  return  SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height*0.4,
        pinned: true,
        floating: true,
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
                Text(product.name, style: Cons.greyFont1),
                IconButton(onPressed: ()async{
                  print('pppp');
                  if(product.isFav==1){
                  await  toogleFav(0, product.id,product);
                  }else{
                   await toogleFav(1, product.id,product);
                  }
                  _productController.changeFavoriteFlag(product.isFav);
                }, icon: Icon(product.isFav==1?Icons.favorite:Icons.favorite_border,color: Colors.red,size: 30,)),
              ],
            ):
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 1,
                  child: IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.arrow_back,color: Cons.accent_color,size: 25)),
                ),
                Flexible(
                  flex: 1,
                  child: IconButton(onPressed: ()async{
                    print('ppppp');
                    if(product.isFav==1){
                     await toogleFav(0, product.id,product);
                    }else{
                     await toogleFav(1, product.id,product);
                    }
                    _productController.changeFavoriteFlag(product.isFav);
                    _productController.update();
                  }, icon: Icon(product.isFav==1?Icons.favorite:Icons.favorite_border,color: Colors.red,size: 25)),
                ),
                Padding(
                    padding:EdgeInsets.only(left: 10,right: 10),child: Text(product.name, style: TextStyle(fontSize: 18,color: Colors.black54))),
                Flexible(
                    flex:1,child: IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Cons.accent_color,size: 25))),
                Flexible(
                    flex:1,child: IconButton(onPressed: (){
                      Navigator.of(context).pushNamed(CreateProductScreen.CREATE_PRODUCT_ROUTE,arguments: product);
                }, icon: Icon(Icons.edit,color: Cons.accent_color,size: 25))),

              ],
            ), background: Hero(
          tag: product.id,
          child: FadeInImage(
            image: NetworkImage(product.images[0],scale: 3),
           // Image.network(product.images[0],),
            placeholder: AssetImage('assets/images/watch_item1.png'),
            fit: BoxFit.cover,
          ),
      )
    ),
        ));

  }


  Future toogleFav(int fav,String prodId,Product product) async {
    await _productController
        .toggleFav(prodId, fav)
        .then((value) => product.isFav=fav);
  }
}
