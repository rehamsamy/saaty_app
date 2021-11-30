import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/view/widget/app_drawer.dart';
import 'package:saaty_app/view/widget/product_item_widget.dart';

import '../../cons.dart';

class AdsScreen extends StatefulWidget {
  static String ADS_SCREEN_ROUTE='/8';
  @override
  _AdsScreenState createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  ProductController _productController=Get.find();
  double width, height;
  bool _isLoading = false;
  List<Product> allProducts = [];

  @override
  void initState() {
    super.initState();
    fetchData();

  }

  @override
  Widget build(BuildContext context) {
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
        preferredSize: Size.fromHeight(150),
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
        height: height * 0.7,
        child: buildGrid(),),
      drawer: MyDrawer(),
    );
  }


  Widget buildGrid() {
    return _isLoading == true ? Center(child: CircularProgressIndicator(),) :
    GetBuilder<ProductController>(
        init: _productController,
        builder: (_) {
          _productController.allProducts.forEach((element) {
            if (element.isFav==1) {
             allProducts.add(element);
              print(element.name);
            }
          });
          return
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 8 / 9,
                    crossAxisCount: 2
                ),
                itemCount: allProducts.length,
                itemBuilder: (ctx, inx) {
                  // return storeGridItem(_productController.allProducts,inx);
                  return ProductItemWidget(allProducts[inx]);
                }
            );
        });
    //   }
    // });

  }

  void fetchData() async{
    setState(() {
      _isLoading=true;
    });
    await _productController.fetchProducts(2).then((value) => setState(()=>_isLoading=false));

  }
}