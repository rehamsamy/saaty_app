
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/view/widget/product_item_widget.dart';

class GrisListProductsMain extends StatelessWidget {
  ProductsController _productController = Get.find();
  var _searcController = TextEditingController();
  bool _isLoading = false;

  GrisListProductsMain(this._searcController,this._isLoading);

  @override
  Widget build(BuildContext context) {
    _productController.txt = _searcController.text;
    return _isLoading == true
        ? Center(
      child: CircularProgressIndicator(),
    )
        : _productController.filteredList.isEmpty
        ? Center(
      child: Text('empty_data'.tr),
    )
        : GetBuilder<ProductsController>(
      builder: (_) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 8 / 9,
              crossAxisCount: 2),
          itemCount: _productController.filteredList.length,
          itemBuilder: (ctx, inx) {
            return ProductItemWidget(
                _productController.filteredList[inx]);
          }),
    );
  }
}
