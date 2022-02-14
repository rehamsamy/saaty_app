import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/products_controller.dart';

import '../../cons.dart';

class FilterProductDialog{

static  ProductsController _productController = Get.find();

 static void buildFilterDialogWidget(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) =>
                  Container(
                    child: SingleChildScrollView(
                      child: GetBuilder<ProductsController>(
                        builder: (_) =>
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('arrange'.tr),
                                RadioListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text(
                                    'from_high'.tr,
                                    textAlign: TextAlign.start,
                                  ),
                                  value: 0,
                                  groupValue: _productController.filterRad,
                                  onChanged: (value) {
                                    _productController.filterRad = value;
                                    _productController.update();
                                  },
                                  activeColor: Cons.primary_color,
                                ),
                                //SizedBox(width: 10,)
                                RadioListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  value: 1,
                                  groupValue: _productController.filterRad,
                                  onChanged: (value) {
                                    _productController.filterRad = value;
                                    _productController.update();
                                  },
                                  title: Text('from_low'.tr),
                                  activeColor: Cons.primary_color,
                                ),
                                //SizedBox(width: 30,),

                                Divider(
                                  color: Cons.primary_color,
                                  thickness: 1.5,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'filter'.tr,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CheckboxListTile(
                                  value: _productController.statusNewChecked,
                                  onChanged: (val) {
                                    _productController.statusNewChecked = val;
                                    _productController.update();
                                  },
                                  title: Text('new_prods'.tr),
                                  activeColor: Cons.primary_color,
                                ),
                                //  SizedBox(height: 20,),
                                CheckboxListTile(
                                  value: _productController.statusOldChecked,
                                  onChanged: (val) {
                                    _productController.statusOldChecked = val;
                                    _productController.update();
                                  },
                                  title: Text('old_prods'.tr),
                                  activeColor: Cons.primary_color,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: () async {
                                      _productController.changeFilterFlag(true);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'execute'.tr,
                                      style: Cons.whiteFont,
                                    ),
                                    color: Cons.accent_color,
                                  ),
                                )
                              ],
                            ),
                      ),
                    ),
                  ),
            ),
          );
        });
  }
}