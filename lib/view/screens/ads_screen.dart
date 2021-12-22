import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/view/widget/app_drawer.dart';
import 'package:saaty_app/view/widget/product_item_widget.dart';

import '../../cons.dart';

class AdsScreen extends StatelessWidget {
  static String ADS_SCREEN_ROUTE='/8';
  ProductsController _productController=Get.find();
  double width, height;

  List<Product> allProducts = [];

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    String flag=ModalRoute.of(context).settings.arguments as String;
    fetchData('all');
    width = MediaQuery
        .of(context)
        .size
        .width;
    height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Container(
          //height: 250,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: AppBar(title: Text('My Ads', style: Cons.greyFont),
                  elevation: 8,
                  actions: [
                    IconButton(icon: Icon(
                      Icons.home, color: Cons.accent_color, size: 25,)),
                  ],),),
              SizedBox(height: 2,),
              Expanded(
                flex: 1,
                child: Card(
                  margin: EdgeInsets.all(2),
                  elevation: 6,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'search',
                          prefixIcon: Icon(
                            Icons.search, color: Cons.accent_color, size: 25,),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Cons.accent_color,
                              width: 1.0,
                            ),
                          )
                        //ثى prefix: Icon(Icons.search,color: Cons.accent_color,)
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: height * 0.8,
        child: buildGrid(flag),),
      drawer: MyDrawer(),
    );
  }


  Widget buildGrid(String flag) {
    List<Product> finalProds=[];
    flag='fav';
    return
      GetBuilder<ProductsController>(builder: (_)=>
         // print(' vvvv   xxx '+ _productController.favProducts.length.toString()));
          _productController.isLoading? Center(child: CircularProgressIndicator(),) :
              _productController.favProducts.length==0?Center(child:Text('Empty Data')):
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 8 / 9,
                      crossAxisCount: 2
                  ),
                  itemCount: _productController.favProducts.length,
                  itemBuilder: (ctx, inx) {
                    print(' vvvv   xxx '+ _productController.favProducts.length.toString());
                    // return storeGridItem(_productController.allProducts,inx);
                    return ProductItemWidget(_productController.favProducts[inx],flag);
                  }
              ));

    // GetBuilder<ProductsController>(
    //     builder: (_) {
    //       flag=='ads'?
    //       _productController.adsProducts.forEach((element) {
    //         print('#########  ${element.id}');
    //         allProducts.add(element);
    //         print(element.name);
    //       }): _productController.favProducts;
    //
    //       finalProds=_productController.favProducts;
    //       return finalProds.length==0?Center(child: Text('Empty Data'),):
    //       GridView.builder(
    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //               mainAxisSpacing: 0,
    //               crossAxisSpacing: 0,
    //               childAspectRatio: 8 / 9,
    //               crossAxisCount: 2
    //           ),
    //           itemCount: finalProds.length,
    //           itemBuilder: (ctx, inx) {
    //             // return storeGridItem(_productController.allProducts,inx);
    //             return ProductItemWidget(finalProds[inx],flag);
    //           }
    //       );

       //  );

  }

  void fetchData(String flag) async{
    print('flag = '+flag);
   await _productController.changeIsLoadingFlag(true);
    await _productController.fetchProducts('fav').then((value) {
      _productController.changeIsLoadingFlag(false);
      _productController.update();
      print('fav length  0000 '+_productController.favProducts.length.toString());
    }
    );
  }

}

