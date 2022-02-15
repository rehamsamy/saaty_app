

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/providers/status_product_controller.dart';
import 'package:saaty_app/view/widget/product_item_widget.dart';

class GridListStores extends StatelessWidget {
  StatusProductController _statusController = Get.find();
  var _searcController = TextEditingController();
  bool _isLoading = false;

  GridListStores(this._searcController,this._isLoading);
  @override
  Widget build(BuildContext context) {
         return GetBuilder<ProductsController>(builder: (ctx) {
      _statusController.txt=_searcController.text;
      return _isLoading == true
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _statusController.filteredList.isEmpty
          ? Center(
        child: Text('Empty Data'),
      )
          : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 8 / 9,
              crossAxisCount: 2),
          itemCount: _statusController.filteredList.length,
          itemBuilder: (ctx, inx) {
            return ProductItemWidget(_statusController.filteredList[inx]);
          });

    }
    );
  }
}
