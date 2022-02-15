import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/home_page/widget/new_product_widget.dart';
import 'package:saaty_app/providers/products_controller.dart';


class HomeListGrid extends StatelessWidget {
  ProductsController _productController = Get.find();
  bool _isLoading = false;


  HomeListGrid(this._isLoading);

  @override
  Widget build(BuildContext context) {
  return  GetBuilder<ProductsController>(
    builder: (_) => _isLoading == true
        ? SliverList(
        delegate: SliverChildListDelegate([
          Center(
            child: CircularProgressIndicator(),
          ),
        ]))
        : _productController.homeProducts.isEmpty
        ? SliverList(
        delegate: SliverChildListDelegate([
          Center(
            child: Text('empty_data'.tr),
          ),
        ]))
        : SliverPadding(
      padding: EdgeInsets.all(6),
      sliver: SliverGrid(
        gridDelegate:
        SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
          //childAspectRatio: 0.9,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
              //  print( 'crete   ---   '+_productController.homeProducts[index].creator_name.toString());
            return HomeProductWidget(
                _productController.homeProducts[index]);

          },
          childCount: _productController.homeProducts.length,
        ),
      ),
    ),
  );
  }
}
