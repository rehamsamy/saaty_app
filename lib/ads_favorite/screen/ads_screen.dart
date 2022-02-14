import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/fav_ads_controller.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/view/widget/app_drawer.dart';
import 'package:saaty_app/view/widget/product_item_widget.dart';

import '../../cons.dart';

class AdsScreen extends StatelessWidget {
  static String ADS_SCREEN_ROUTE='/8';
  FavsAdsController _favsAdsController=Get.find();
  var _searcController = TextEditingController();
  double width, height;

  List<Product> allProducts = [];

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    String flag=ModalRoute.of(context).settings.arguments as String;
 _favsAdsController.prodTypeFlag=flag;

    fetchData(flag);
    width = MediaQuery
        .of(context)
        .size
        .width;
    height = MediaQuery
        .of(context)
        .size
        .height;
    return GetBuilder<FavsAdsController>(
      builder: (_)=>
       Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Container(
            //height: 250,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: AppBar(title: Text(flag=='ads'.tr?'my_ads'.tr:'favorites'.tr, style: Cons.greyFont),
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
                        controller: _searcController,
                        onChanged: onTextChange,
                        decoration: InputDecoration(
                            hintText: 'search'.tr,
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
      ),
    );
  }


  Widget buildGrid(String flag) {
    _favsAdsController.txt=_searcController.text;
    return
      GetBuilder<FavsAdsController>(builder: (_) {
        List<Product> finalProds = _favsAdsController.filteredList;
        return _favsAdsController.isLoading ?
        Center(child: CircularProgressIndicator(),) :
        finalProds.length == 0 ? Center(child: Text('empty_data'.tr)) :
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 8 / 9,
                crossAxisCount: 2
            ),
            itemCount: finalProds.length,
            itemBuilder: (ctx, inx) {
              return ProductItemWidget(finalProds[inx], flag);
            }
        );
      }  );


  }

  onTextChange(String text) {
    String text = _searcController.text;
    _favsAdsController.search(text);
  }

  void fetchData(String flag) async{
  //  print('step '+flag);
    _favsAdsController.isLoading=true;
    _favsAdsController.isFiltering=false;
    await _favsAdsController.fetchProducts(flag).then((value) {
      _favsAdsController.changeIsLoadingFlag(false);
      _favsAdsController.update();
    }
    );
  }

}

