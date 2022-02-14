import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/main_page/widget/store_item_widget.dart';
import 'package:saaty_app/providers/products_controller.dart';

class GridListStoresMain extends StatelessWidget {
  ProductsController _productController = Get.find();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
   return _isLoading == true
        ? Center(
      child: CircularProgressIndicator(),
    )
        : _productController.allStores.isEmpty
        ? Center(
      child: Text('empty_data'.tr),
    )
        : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 1,
            crossAxisCount: 2),
        itemCount: _productController.allStores.length,
        itemBuilder: (ctx, inx) {
          return StoreItemWidget(
              _productController.allStores[inx], inx);
        });
  }
}
