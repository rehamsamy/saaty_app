import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/view/widget/CategoryItem.dart';
import 'package:saaty_app/view/widget/app_drawer.dart';
import 'package:saaty_app/view/widget/product_item_widget.dart';
import 'package:saaty_app/view/widget/visitor_drawer.dart';

import '../../cons.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'login_screen.dart';
import 'main_page_screen.dart';

class HomeScreen extends StatefulWidget{
  static String HOME_SCREEN_RIUTE='/3';
  @override
  State<StatefulWidget> createState() {
   return HomeScreenState();
  }

}


class HomeScreenState extends State<HomeScreen> {

  List<String> images=['assets/images/store1.png',
                        'assets/images/store2.png',
                        'assets/images/store3.png',
                        'assets/images/store4.png'];
  bool _isLoading = false;
  ProductsController _productController = Get.find();

  int _index=0;
  AuthController _authController=Get.find();
  var _storageontroller=Get.put(StorageController());
  double width,height;
  static String token;
  static String userId;
  Map<String,dynamic>  _userData;
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    _userData=_storageontroller.authData as Map<String,dynamic>;
    if( _storageontroller.expire){
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacementNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
      });
    }else{
      MainPageScreen.token=_userData['idToken'];
      MainPageScreen.userId=_userData['localId'];
      print('88888  '+MainPageScreen.userId+'      ;fff   '+MainPageScreen.token);
    }

    fetchData();
  }


  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    Cons.buildColors(context);
    CarouselController buttonCarouselController = CarouselController();
    return Scaffold(
      appBar: AppBar(
          title: Text('main_page'.tr,style: Cons.greyFont,),
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height*0.44,
              child: Stack(children: [
                CarouselSlider(
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                    onPageChanged: (ind,x){
                      setState(() {
                        _index=ind;
                      });
                    },
                    initialPage: 1,
                    autoPlayAnimationDuration: Duration(milliseconds: 400),
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 6/4,
                    viewportFraction:0.81
                ),
                items: images.map((e) =>
                    Image.asset(e)
                ).toList(),
              ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCircleSlider(0),
                  buildCircleSlider(1),
                  buildCircleSlider(2),
                  buildCircleSlider(3),
                ],
              ),
            ),
              ],),
            ),
            SizedBox(height: 5,)
            ,
            Container(
              height: height*0.42,
              child: Stack(
                children: [
                  Align(
                      alignment : Alignment.bottomCenter,
                      child: Image.asset('assets/images/home_photo.png',fit: BoxFit.contain,)),
                  LayoutBuilder(
                    builder:(_,cons)=> Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          ListTile(
                          leading: Icon(Icons.category_outlined),
                      title: Text(
                        'catgory'.tr,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                          buildCatList(),
                         buildGridProducts(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
            
          //  Expanded(flex:5,child: ),
          
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }


  Widget buildCardItem(String title,BuildContext context,BoxConstraints cons,int pos){
      return  Container(
       margin: EdgeInsets.symmetric(horizontal: 50),
        height:cons.maxHeight*0.2,
        alignment: Alignment.center,
        child: Center(
          child: Card(
          elevation: 10,
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios_sharp,color:Theme.of(context).accentColor),
                leading: Text(title,style: Cons.greyFont1,),
                onTap: (){
                  Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE,arguments:pos);
                },

            ),
    ),
        ),
      );
  }

  Widget buildCircleSlider(int index){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 12,
         width: 12,
       decoration: BoxDecoration(
         border:index==_index? Border.all(width:2,color:Cons.primary_color ):Border.all(width:1,color:Cons.primary_color ),
           shape: BoxShape.circle,
         color:_index==index?Colors.white:Cons.accent_color
       ),
      ),
    );
  }

  buildCatList() {
    return   Container(
        height: 150,
        child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (_,inx)=>
        CategoryItem(Cons.categoriesList[inx],inx),
    itemCount: 4,
    scrollDirection: Axis.horizontal,
    ));
  }

  buildCarsolSliderProds() {

  }

  buildGridProducts() {
    return _isLoading == true
        ? Center(
      child: CircularProgressIndicator(),
    )
        : _productController.filteredList.isEmpty
        ? Center(
      child: Text('empty_data'.tr),
    )
        : GetBuilder<ProductsController>(
      builder: (_)=>
          Container(
            alignment: Alignment.center,
            height: 70,
            width: double.infinity-20,
            child: ListView.builder(itemBuilder: (_,inx)=>
                  Card(
                    elevation: 5,
                      margin: EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child:  Image.network(
                          _productController.filteredList[inx].images[0]
                            ,
                            height: 60.0,
                            width: 60.0,
                            fit: BoxFit.cover
                        ),
                      ),),
              scrollDirection: Axis.horizontal,
              itemCount:_productController.filteredList.length ,
            ),
            // GridView.builder(
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         mainAxisSpacing: 0,
            //         crossAxisSpacing: 0,
            //         childAspectRatio: 8 / 9,
            //         crossAxisCount: 2),
            //     itemCount: 7,
            //     itemBuilder: (ctx, inx) {
            //       return ProductItemWidget(
            //           _productController.filteredList[inx]);
            //     }
          //  ),
          ),
    );
  }



  Future fetchData() async {
    await Future.delayed(Duration(milliseconds: 20));
    _productController
        .fetchProducts('all')
        .then((value) => setState(() => _isLoading = false))
        .catchError((err) => print('=>>>>>  $err'));

  }


}